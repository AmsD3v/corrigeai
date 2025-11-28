from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from datetime import datetime as dt
from typing import Optional
from .. import schemas, models
from ..database import get_db
from ..dependencies import get_current_user
from ..payment_service import MercadoPagoService
import logging

router = APIRouter()
payment_service = MercadoPagoService()

@router.post("/api/payment/create-preference", response_model=schemas.PreferenceResponse)
async def create_payment_preference(
    request: schemas.CreatePreferenceRequest,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Create a Mercado Pago payment preference for purchasing CorriCoins
    """
    print("\n" + "="*80)
    print("🛒 PAYMENT REQUEST RECEIVED")
    print("="*80)
    try:
        if request.package:
            print(f"📦 Package (Legacy): {request.package.dict()}")
        else:
            print(f"📦 Package ID: {request.package_id}")
            
        print(f"👤 User: {current_user.email} (ID: {current_user.id})")
        
        # Prepare user data
        user_data = {
            "id": current_user.id,
            "email": current_user.email,
            "name": current_user.full_name or "Usuário"
        }
        
        # Prepare package data
        if request.package_id:
            # Fetch from DB
            db_package = db.query(models.Package).filter(models.Package.id == request.package_id).first()
            if not db_package:
                print(f"❌ Package not found: {request.package_id}")
                raise HTTPException(status_code=404, detail="Package not found")
            
            package_data = {
                "id": db_package.id,
                "name": db_package.name,
                "price": float(db_package.price) / 100, # Convert cents to float for MP
                "coins": db_package.credits,
                "bonus": db_package.bonus
            }
            print(f"📦 Package loaded from DB: {package_data}")
            
        elif request.package:
            # Use provided data (Legacy support)
            package_data = {
                "id": request.package.id,
                "name": request.package.name,
                "price": request.package.price,
                "coins": request.package.coins,
                "bonus": request.package.bonus
            }
        else:
            raise HTTPException(status_code=400, detail="Package information required")
        
        print(f"📡 Calling Mercado Pago service...")
        # Create preference using Mercado Pago service
        result = payment_service.create_preference(package_data, user_data)
        
        print(f"✅ MP Service returned: {result}")
        
        if result["success"]:
            # Create transaction record in database
            transaction = models.Transaction(
                user_id=current_user.id,
                preference_id=result["preference_id"],
                package_id=package_data["id"],
                package_name=package_data["name"],
                coins_amount=package_data["coins"],
                bonus_coins=package_data["bonus"],
                price=int(package_data["price"] * 100),  # Convert to cents
                status="pending"
            )
            db.add(transaction)
            db.commit()
            
            print(f"💾 Transaction saved to database")
            
            return schemas.PreferenceResponse(
                success=True,
                preference_id=result["preference_id"],
                init_point=result["init_point"]
            )
        else:
            print(f"❌ Failed to create preference: {result.get('error')}")
            return schemas.PreferenceResponse(
                success=False,
                error=result.get("error", "Failed to create preference")
            )
    
    except Exception as e:
        print(f"❌ EXCEPTION in payment endpoint: {str(e)}")
        import traceback
        traceback.print_exc()
        logging.error(f"Error creating payment preference: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error creating payment preference: {str(e)}"
        )

@router.post("/api/payment/webhook")
async def payment_webhook(
    id: Optional[str] = None,
    topic: Optional[str] = None,
    db: Session = Depends(get_db)
):
    """
    Receive and process Mercado Pago webhook notifications
    MP sends data via query params: ?id=PAYMENT_ID&topic=payment
    """
    try:
        logging.info(f"Webhook received: id={id}, topic={topic}")
        
        # Mercado Pago sends topic=payment or topic=merchant_order
        if not id or not topic:
            logging.warning(f"Webhook missing data: id={id}, topic={topic}")
            return {"status": "ok"}  # Return 200 to prevent retries
        
        # Only process payment notifications
        if topic != "payment":
            logging.info(f"Ignoring non-payment topic: {topic}")
            return {"status": "ok"}
        
        # Get payment info from Mercado Pago
        payment_info_result = payment_service.get_payment_info(id)
        
        if not payment_info_result.get("success"):
            logging.error(f"Failed to get payment info for ID {id}")
            return {"status": "error"}
        
        payment_info = payment_info_result
        payment_status = payment_info.get("status")
        external_ref = payment_info.get("external_reference", "")
        
        logging.info(f"Payment {id} status: {payment_status}, ref: {external_ref}")
        
        if not external_ref:
            logging.warning(f"Payment {id} has no external_reference")
            return {"status": "ok"}
        
        # Parse external_reference: user_{user_id}_package_{package_id}_{timestamp}
        parts = external_ref.split("_")
        if len(parts) < 4:
            logging.error(f"Invalid external_reference format: {external_ref}")
            return {"status": "ok"}
        
        user_id = int(parts[1])
        package_id = parts[3]
        
        # Find or create transaction
        transaction = db.query(models.Transaction).filter(
            models.Transaction.user_id == user_id,
            models.Transaction.external_reference == external_ref
        ).first()
        
        if not transaction:
            # Try to find by user_id and pending status (most recent)
            transaction = db.query(models.Transaction).filter(
                models.Transaction.user_id == user_id,
                models.Transaction.status == "pending"
            ).order_by(models.Transaction.created_at.desc()).first()
            
            if transaction:
                logging.info(f"Found pending transaction {transaction.id} for user {user_id}")
        
        if transaction:
            # Update transaction
            old_status = transaction.status
            transaction.payment_id = str(id)
            transaction.external_reference = external_ref
            transaction.status = payment_status
            transaction.status_detail = payment_info.get("status_detail")
            transaction.payment_method = payment_info.get("payment_method_id")
            transaction.payment_type = payment_info.get("payment_type_id")
            transaction.updated_at = dt.utcnow()
            
            logging.info(f"Transaction {transaction.id}: {old_status} → {payment_status}")
            
            # Only add coins if status changed from pending/other to approved
            # This prevents duplicate credits if webhook is called multiple times
            if payment_status == "approved" and old_status != "approved":
                transaction.approved_at = dt.utcnow()
                
                # Add coins to user account
                user = db.query(models.User).filter(
                    models.User.id == user_id
                ).first()
                
                if user:
                    total_coins = transaction.coins_amount + transaction.bonus_coins
                    old_balance = user.credits
                    user.credits += total_coins
                    logging.info(f"✅ Added {total_coins} coins to user {user_id} (balance: {old_balance} → {user.credits})")
                else:
                    logging.error(f"❌ User {user_id} not found!")
            elif payment_status == "approved" and old_status == "approved":
                logging.info(f"⚠️  Transaction {transaction.id} already approved, skipping credit addition")
            
            db.commit()
            logging.info(f"✅ Transaction {transaction.id} updated successfully")
        else:
            logging.warning(f"❌ Transaction not found for external_ref: {external_ref}")
        
        
        return {"status": "ok"}
    
    except Exception as e:
        logging.error(f"Error processing webhook: {str(e)}")
        import traceback
        traceback.print_exc()
        # Return 200 to prevent Mercado Pago from retrying
        return {"status": "error", "message": str(e)}

@router.get("/api/payment/transactions", response_model=list[schemas.TransactionResponse])
async def get_user_transactions(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Get all transactions for the current user
    """
    transactions = db.query(models.Transaction).filter(
        models.Transaction.user_id == current_user.id
    ).order_by(models.Transaction.created_at.desc()).all()
    
    return transactions

@router.get("/api/payment/transaction/{transaction_id}", response_model=schemas.TransactionResponse)
async def get_transaction(
    transaction_id: int,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Get a specific transaction by ID
    """
    transaction = db.query(models.Transaction).filter(
        models.Transaction.id == transaction_id,
        models.Transaction.user_id == current_user.id
    ).first()
    
    if not transaction:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Transaction not found"
        )
    
    return transaction
