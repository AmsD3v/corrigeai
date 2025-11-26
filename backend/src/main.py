import logging
from fastapi import Depends, FastAPI, HTTPException, status, Response, Cookie, BackgroundTasks, Query
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from typing import Optional, List

# --- INÍCIO DA CORREÇÃO DEFINITIVA DE IMPORTAÇÃO ---
# Usando importações relativas ('.') para todos os módulos,
# incluindo o sub-pacote 'core'.
from .core.logging_config import setup_logging
from . import models, schemas
from .core.config import settings
from .database import get_db, init_db_engine
from . import correction_service
from .security import (
    get_password_hash,
    verify_password,
    create_access_token,
    create_refresh_token,
    hash_refresh_token,
    decode_token,
)
# --- FIM DA CORREÇÃO DEFINITIVA DE IMPORTAÇÃO ---

app = FastAPI()

# Inicialização do banco de dados no startup do app
@app.on_event("startup")
def startup_event():
    # Configura o logging para usar o formato JSON
    setup_logging()
    # Inicializa o engine do banco de dados
    from .database import init_db_engine, Base
    engine = init_db_engine()
    # Importa os models após inicializar o banco de dados
    from . import models
    Base.metadata.create_all(bind=engine)
    logging.info("Tabelas criadas com sucesso!")
    
    # Valida configuração do Gemini AI
    if not settings.GEMINI_API_KEY or settings.GEMINI_API_KEY == "placeholder_key":
        logging.warning("="*60)
        logging.warning("⚠️  ATENÇÃO: GEMINI_API_KEY NÃO CONFIGURADA!")
        logging.warning("⚠️  Funcionalidades de IA não funcionarão:")
        logging.warning("⚠️  - Geração de temas")
        logging.warning("⚠️  - Correção de redações")
        logging.warning("⚠️  Configure a API key no arquivo .env")
        logging.warning("="*60)
    else:
        # Log para debug - mostra primeiros e últimos caracteres da key
        key_preview = f"{settings.GEMINI_API_KEY[:10]}...{settings.GEMINI_API_KEY[-4:]}"
        logging.info(f"✅ Gemini API key configurada! (Preview: {key_preview})")

# Configuração do CORS
# Lê as origens das variáveis de ambiente para permitir configuração flexível
origins = settings.CORS_ORIGINS.split(",") if settings.CORS_ORIGINS else []

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
    # Adiciona segurança adicional
    # Permite envio de cookies com requisições CORS
    allow_origin_regex=None,
    # Exposição de headers para client-side
    expose_headers=["Access-Control-Allow-Origin"],
)

# Rota de Health Check para diagnóstico
@app.get("/health")
def health_check():
    return {"status": "ok"}

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

# Rota de Registro, alinhada com os testes


@app.post("/users/", response_model=schemas.User, status_code=status.HTTP_201_CREATED)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email já registrado")
    
    hashed_password = get_password_hash(user.password)
    db_user = models.User(
        email=user.email, 
        hashed_password=hashed_password, 
        full_name=user.full_name,
        credits=2  # Novos usuários recebem 2 CorriCoins grátis
    )
    
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    
    return db_user

# Rota de Login, alinhada com os testes
@app.post("/login")
def login(response: Response, form_data: schemas.UserLogin, db: Session = Depends(get_db)):
    logging.info(f"Login attempt for user: {form_data.username}")
    db_user = db.query(models.User).filter(models.User.email == form_data.username).first()
    logging.info(f"User found: {db_user}")
    
    if db_user:
        is_password_valid = verify_password(form_data.password, db_user.hashed_password)
        logging.info(f"Password verification result: {is_password_valid}")
    else:
        logging.info("User not found")

    if not db_user:
        logging.warning(f"❌ Login failed: User {form_data.username} not found")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciais inválidas (Usuário não encontrado)",
            headers={"WWW-Authenticate": "Bearer"},
        )

    if not verify_password(form_data.password, db_user.hashed_password):
        logging.warning(f"❌ Login failed: Password mismatch for {form_data.username}")
        # Log lengths for debugging (safe)
        logging.info(f"Received password length: {len(form_data.password)}")
        logging.info(f"Stored hash length: {len(db_user.hashed_password)}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciais inválidas (Senha incorreta)",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    token_data = {"sub": str(db_user.id)}
    access_token = create_access_token(data=token_data)
    refresh_token = create_refresh_token(data=token_data)
    
    db_user.hashed_refresh_token = hash_refresh_token(refresh_token)
    db.commit()
    
    response.set_cookie(
        key="refresh_token", value=refresh_token, httponly=True,
        secure=True, samesite="lax", max_age=settings.REFRESH_TOKEN_EXPIRE_DAYS * 24 * 60 * 60
    )
    
    return {"access_token": access_token, "token_type": "bearer", "refresh_token": refresh_token}

# Dependência para obter o usuário atual
def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> models.User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Não foi possível validar as credenciais",
        headers={"WWW-Authenticate": "Bearer"},
    )
    payload = decode_token(token)
    if payload is None or "sub" not in payload:
        raise credentials_exception
        
    user_id = int(payload.get("sub"))
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user is None:
        raise credentials_exception
    return user

@app.get("/users/me", response_model=schemas.User)
async def read_users_me(current_user: models.User = Depends(get_current_user)):
    return current_user

# Admin endpoint to list all users
@app.get("/admin/users")
async def list_all_users(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    # TODO: Add admin check
    users = db.query(models.User).all()
    return users


# Admin endpoint to update user credits
@app.patch("/admin/users/{user_id}/credits")
async def update_user_credits(
    user_id: int,
    credits: Optional[int] = Query(None, description="CorriCoins (purchased)"),
    free_credits: Optional[int] = Query(None, description="Free credits"),
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    # Check if current user is admin (you should add is_admin field to User model)
    # For now, anyone can update (temporary - you should add proper admin check)
    
    target_user = db.query(models.User).filter(models.User.id == user_id).first()
    if not target_user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    
    # Update credits if provided
    if credits is not None:
        target_user.credits = credits
    if free_credits is not None:
        target_user.free_credits = free_credits
    
    db.commit()
    db.refresh(target_user)
    
    return {
        "message": "Créditos atualizados com sucesso",
        "user": {
            "id": target_user.id,
            "email": target_user.email,
            "credits": target_user.credits,
            "free_credits": target_user.free_credits
        }
    }


# Rota de Refresh
@app.post("/refresh")
def refresh_token_route(response: Response, refresh_token: Optional[str] = Cookie(None), db: Session = Depends(get_db)):
    if not refresh_token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token não encontrado")

    payload = decode_token(refresh_token)
    if not payload or "sub" not in payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token inválido ou expirado")

    user_id = int(payload["sub"])
    db_user = db.query(models.User).filter(models.User.id == user_id).first()

    if not db_user or not db_user.hashed_refresh_token or not verify_password(refresh_token, db_user.hashed_refresh_token):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token inválido ou já utilizado")

    new_token_data = {"sub": str(user_id)}
    new_access_token = create_access_token(data=new_token_data)
    new_refresh_token = create_refresh_token(data=new_token_data)

    db_user.hashed_refresh_token = hash_refresh_token(new_refresh_token)
    db.commit()

    response.set_cookie(
        key="refresh_token", value=new_refresh_token, httponly=True,
        secure=True, samesite="lax", max_age=settings.REFRESH_TOKEN_EXPIRE_DAYS * 24 * 60 * 60
    )
    
    return {"access_token": new_access_token, "token_type": "bearer", "refresh_token": new_refresh_token}

@app.post("/logout")
def logout(response: Response, current_user: models.User = Depends(get_current_user)):
    response.delete_cookie("refresh_token")
    return {"message": "Logout realizado com sucesso"}

@app.post("/logout-all")
def logout_all(response: Response, db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    current_user.hashed_refresh_token = None
    db.commit()
    response.delete_cookie("refresh_token")
    return {"message": "Logout de todos os dispositivos realizado com sucesso"}

# Rota para submeter uma redação
import asyncio

# ... (outras importações)

async def trigger_correction(submission_id: int):
    """
    Trigger essay correction using Gemini AI in background
    Creates its own database session to avoid session closure issues
    """
    print(f"\n🔵 ==== TRIGGER_CORRECTION CALLED for submission {submission_id} ====")
    
    from .correction_service import process_correction
    from .database import SessionLocal
    import traceback
    
    # Create a new database session for the background task
    db = SessionLocal()
    try:
        print(f"🔵 Calling process_correction...")
        await process_correction(submission_id, db)
        print(f"✅ process_correction completed successfully")
    except Exception as e:
        print(f"\n❌ ====  EXCEPTION IN TRIGGER_CORRECTION ====")
        print(f"❌ Error: {e}")
        print(f"❌ Traceback:\n{traceback.format_exc()}")
        print(f"❌ ============================================\n")
        raise
    finally:
        db.close()

def trigger_correction_sync(submission_id: int):
    """
    Synchronous wrapper for trigger_correction to work with BackgroundTasks
    """
    import asyncio
    
    # Create a new event loop for the background task
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    try:
        loop.run_until_complete(trigger_correction(submission_id))
    finally:
        loop.close()


# ... (Restante do código de `main.py`, incluindo a rota `/submit`)
# A rota /submit continua síncrona, mas a tarefa em segundo plano agora é assíncrona
@app.post("/submit", response_model=schemas.SubmissionResponse)
async def submit_essay(
    submission: schemas.SubmissionCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user),
):
    """
    Permite que um usuário autenticado envie uma redação para correção,
    verificando se ele tem o perfil 'aluno' e créditos suficientes.
    A correção é executada de forma síncrona para garantir que funcione.
    """
    logging.info(f"🔵 ENDPOINT /submit CHAMADO - User: {current_user.email}, Title: {submission.title}")
    
    if current_user.role != "aluno":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Apenas usuários com perfil 'aluno' podem enviar redações.",
        )

    if current_user.credits <= 0:
        raise HTTPException(
            status_code=status.HTTP_402_PAYMENT_REQUIRED,
            detail="Créditos insuficientes para enviar a redação.",
        )

    db_submission = models.Submission(
        **submission.model_dump(), owner_id=current_user.id
    )
    db.add(db_submission)
    
    current_user.credits -= 1
    
    db.commit()
    db.refresh(db_submission)
    
    # Executa a correção de forma síncrona (inline) para garantir que funcione
    logging.info(f"Iniciando correção síncrona da submissão {db_submission.id}")
    try:
        await trigger_correction(db_submission.id)
        logging.info(f"Correção da submissão {db_submission.id} iniciada com sucesso")
    except Exception as e:
        logging.error(f"Erro ao iniciar correção da submissão {db_submission.id}: {e}")
    
    return db_submission


@app.get("/submissions/{submission_id}", response_model=schemas.SubmissionResponse)
def read_submission(
    submission_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user),
):
    """
    Recupera os detalhes de uma submissão específica.
    
    Garante que um usuário só possa acessar as submissões que ele mesmo criou.
    """
    db_submission = db.query(models.Submission).filter(
        models.Submission.id == submission_id,
        models.Submission.owner_id == current_user.id
    ).first()

    if db_submission is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada ou acesso não permitido.",
        )
        
    return db_submission


@app.get("/submissions/{submission_id}/correction", response_model=schemas.CorrectionDetail)
def get_correction(
    submission_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """
    Get correction details for a specific submission.
    
    Returns detailed ENEM evaluation with scores for all 5 competencies,
    feedback, strengths, improvements, and general comments.
    """
    # Verify submission belongs to current user
    submission = db.query(models.Submission).filter(
        models.Submission.id == submission_id,
        models.Submission.owner_id == current_user.id
    ).first()
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada ou acesso não permitido."
        )
    
    # Get correction
    correction = db.query(models.Correction).filter(
        models.Correction.submission_id == submission_id
    ).first()
    
    if not correction:
        # Check submission status
        if submission.status == "pending":
            raise HTTPException(
                status_code=status.HTTP_202_ACCEPTED,
                detail="Correção ainda não iniciada. Aguarde alguns instantes."
            )
        elif submission.status == "processing":
            raise HTTPException(
                status_code=status.HTTP_202_ACCEPTED,
                detail="Correção em andamento. Aguarde alguns instantes."
            )
        elif submission.status == "failed":
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Falha na correção. Seu crédito foi estornado. Tente novamente."
            )
        else:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Correção não disponível."
            )
    
    return correction


# Alias endpoint for frontend compatibility
@app.get("/get-correction/{submission_id}", response_model=schemas.CorrectionDetail)
def get_correction_alias(
    submission_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """
    Alias for /submissions/{submission_id}/correction
    Used by frontend for compatibility
    """
    return get_correction(submission_id, db, current_user)

# ==================== PACKAGE ENDPOINTS ====================

@app.get("/api/packages", response_model=List[schemas.Package])
def read_packages(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    packages = db.query(models.Package).filter(models.Package.is_active == True).offset(skip).limit(limit).all()
    return packages

@app.post("/api/packages", response_model=schemas.Package)
def create_package(package: schemas.PackageCreate, current_user: models.User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Check if user is admin (simple check for now, can be improved)
    if current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Not authorized")
    
    db_package = models.Package(**package.dict())
    db.add(db_package)
    db.commit()
    db.refresh(db_package)
    return db_package

@app.put("/api/packages/{package_id}", response_model=schemas.Package)
def update_package(package_id: str, package: schemas.PackageUpdate, current_user: models.User = Depends(get_current_user), db: Session = Depends(get_db)):
    if current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Not authorized")
    
    db_package = db.query(models.Package).filter(models.Package.id == package_id).first()
    if not db_package:
        raise HTTPException(status_code=404, detail="Package not found")
    
    update_data = package.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_package, key, value)
    
    db.commit()
    db.refresh(db_package)
    return db_package

# ==================== PAYMENT ENDPOINTS ====================

from .payment_service import MercadoPagoService
from datetime import datetime as dt

payment_service = MercadoPagoService()

@app.post("/api/payment/create-preference", response_model=schemas.PreferenceResponse)
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

@app.post("/api/payment/webhook")
async def payment_webhook(
    notification: schemas.WebhookNotification,
    db: Session = Depends(get_db)
):
    """
    Receive and process Mercado Pago webhook notifications
    """
    try:
        logging.info(f"Received webhook notification: {notification.dict()}")
        
        # Process webhook using payment service
        result = payment_service.process_webhook(notification.dict())
        
        if result["success"] and result.get("should_process"):
            payment_info = result["payment_info"]
            payment_id = payment_info["payment_id"]
            
            # Find transaction by external_reference or preference_id
            external_ref = payment_info.get("external_reference", "")
            
            # Extract user_id and package_id from external_reference
            # Format: user_{user_id}_package_{package_id}_{timestamp}
            if external_ref:
                parts = external_ref.split("_")
                if len(parts) >= 4:
                    user_id = int(parts[1])
                    package_id = parts[3]
                    
                    # Find or create transaction
                    transaction = db.query(models.Transaction).filter(
                        models.Transaction.user_id == user_id,
                        models.Transaction.external_reference == external_ref
                    ).first()
                    
                    if not transaction:
                        # Try to find by preference_id
                        transaction = db.query(models.Transaction).filter(
                            models.Transaction.user_id == user_id,
                            models.Transaction.status == "pending"
                        ).order_by(models.Transaction.created_at.desc()).first()
                    
                    if transaction:
                        # Update transaction
                        transaction.payment_id = str(payment_id)
                        transaction.external_reference = external_ref
                        transaction.status = payment_info["status"]
                        transaction.status_detail = payment_info.get("status_detail")
                        transaction.payment_method = payment_info.get("payment_method_id")
                        transaction.payment_type = payment_info.get("payment_type_id")
                        transaction.updated_at = dt.utcnow()
                        
                        if payment_info["status"] == "approved":
                            transaction.approved_at = dt.utcnow()
                            
                            # Add coins to user account
                            user = db.query(models.User).filter(
                                models.User.id == user_id
                            ).first()
                            
                            if user:
                                total_coins = transaction.coins_amount + transaction.bonus_coins
                                user.credits += total_coins
                                logging.info(f"Added {total_coins} coins to user {user_id}")
                        
                        db.commit()
                        logging.info(f"Transaction updated successfully: {transaction.id}")
        
        return {"status": "ok"}
    
    except Exception as e:
        logging.error(f"Error processing webhook: {str(e)}")
        # Return 200 to prevent Mercado Pago from retrying
        return {"status": "error", "message": str(e)}

@app.get("/api/payment/transactions", response_model=list[schemas.TransactionResponse])
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

@app.get("/api/payment/transaction/{transaction_id}", response_model=schemas.TransactionResponse)
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

# ===== GEMINI AI ENDPOINTS =====

from .gemini_service import generate_theme_with_gemini
from pydantic import BaseModel

class ThemeGenerationRequest(BaseModel):
    category: str

class ThemeGenerationResponse(BaseModel):
    theme: str
    success: bool

@app.post("/api/gemini/generate-theme", response_model=ThemeGenerationResponse)
async def generate_theme(
    request: ThemeGenerationRequest,
    current_user: models.User = Depends(get_current_user)
):
    """
    Generate an essay theme using Gemini AI
    """
    try:
        theme = await generate_theme_with_gemini(request.category)
        return ThemeGenerationResponse(theme=theme, success=True)
    except Exception as e:
        logging.error(f"Error generating theme: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Erro ao gerar tema: {str(e)}"
        )


# ===== SETTINGS ENDPOINTS =====

class SettingsResponse(BaseModel):
    active_ai_provider: str

class SettingsUpdate(BaseModel):
    active_ai_provider: str

@app.get("/api/settings", response_model=SettingsResponse)
async def get_settings(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get current application settings"""
    settings = db.query(models.Settings).first()
    if not settings:
        # Create default settings if not exist
        settings = models.Settings(id=1, active_ai_provider="groq")
        db.add(settings)
        db.commit()
        db.refresh(settings)
    
    return SettingsResponse(active_ai_provider=settings.active_ai_provider)

@app.post("/api/settings", response_model=SettingsResponse)
async def update_settings(
    settings_update: SettingsUpdate,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update application settings (admin only would be ideal, but allowing all authenticated users for now)"""
    # Validate provider
    valid_providers = ["groq", "gemini", "huggingface", "together"]
    if settings_update.active_ai_provider not in valid_providers:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Invalid provider. Must be one of: {', '.join(valid_providers)}"
        )
    
    settings = db.query(models.Settings).first()
    if not settings:
        settings = models.Settings(id=1, active_ai_provider=settings_update.active_ai_provider)
        db.add(settings)
    else:
        settings.active_ai_provider = settings_update.active_ai_provider
    
    db.commit()
    db.refresh(settings)
    
    logging.info(f"Settings updated: active_ai_provider={settings.active_ai_provider}")
    
    return SettingsResponse(active_ai_provider=settings.active_ai_provider)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)