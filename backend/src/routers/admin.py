from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from typing import Optional
from .. import schemas, models
from ..database import get_db
from ..dependencies import get_current_user, get_current_admin_user

router = APIRouter()

@router.get("/admin/users")
async def list_all_users(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    # TODO: Add admin check
    users = db.query(models.User).all()
    return users

@router.patch("/admin/users/{user_id}/credits")
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

@router.patch("/admin/users/{user_id}")
async def update_user(
    user_id: int,
    user_update: schemas.UserUpdate,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Update user details (admin only)
    """
    target_user = db.query(models.User).filter(models.User.id == user_id).first()
    if not target_user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    
    # Update fields if provided
    if user_update.full_name is not None:
        target_user.full_name = user_update.full_name
    if user_update.email is not None:
        # Check if email is already in use by another user
        existing = db.query(models.User).filter(
            models.User.email == user_update.email,
            models.User.id != user_id
        ).first()
        if existing:
            raise HTTPException(status_code=400, detail="Email já está em uso")
        target_user.email = user_update.email
    if user_update.credits is not None:
        target_user.credits = user_update.credits
    if user_update.free_credits is not None:
        target_user.free_credits = user_update.free_credits
    
    db.commit()
    db.refresh(target_user)
    
    return target_user

@router.get("/admin/transactions")
async def get_all_transactions(
    status_filter: Optional[str] = None,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Get all transactions (admin only)
    """
    query = db.query(models.Transaction).join(models.User)
    
    # Filter by status if provided
    if status_filter and status_filter != "all":
        query = query.filter(models.Transaction.status == status_filter)
    
    # Order by created_at desc
    query = query.order_by(models.Transaction.created_at.desc())
    
    transactions = query.all()
    
    # Transform to response format
    result = []
    for txn in transactions:
        result.append({
            "id": txn.id,
            "user_id": txn.user_id,
            "user_name": txn.user.full_name or "N/A",
            "user_email": txn.user.email,
            "created_at": txn.created_at,
            "price": txn.price,
            "package_name": txn.package_name,
            "coins_amount": txn.coins_amount,
            "bonus_coins": txn.bonus_coins,
            "payment_method": txn.payment_method,
            "payment_id": txn.payment_id,
            "status": txn.status,
            "approved_at": txn.approved_at
        })
    return result

@router.get("/admin/submissions")
async def get_all_submissions(
    skip: int = Query(0, ge=0),
    limit: int = Query(20, ge=1, le=100),
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Get all submissions with corrections and user data (admin only)
    Supports pagination with skip and limit
    """
    # Query all submissions with user and correction data
    submissions = db.query(models.Submission)\
        .join(models.User)\
        .order_by(models.Submission.submitted_at.desc())\
        .offset(skip)\
        .limit(limit)\
        .all()
    
    result = []
    for sub in submissions:
        # Get correction if exists
        correction = db.query(models.Correction).filter(
            models.Correction.submission_id == sub.id
        ).first()
        
        submission_data = {
            "id": sub.id,
            "title": sub.title,
            "theme": sub.theme,
            "content": sub.content,
            "created_at": sub.submitted_at,
            "status": sub.status,
            "correction_type": sub.correction_type if hasattr(sub, 'correction_type') else 'advanced',
            "owner": {
                "id": sub.owner.id,
                "full_name": sub.owner.full_name,
                "email": sub.owner.email
            }
        }
        
        if correction:
            submission_data["correction"] = {
                "total_score": correction.total_score,
                "competence_1_score": correction.competence_1_score,
                "competence_2_score": correction.competence_2_score,
                "competence_3_score": correction.competence_3_score,
                "competence_4_score": correction.competence_4_score,
                "competence_5_score": correction.competence_5_score
            }
        
        result.append(submission_data)
    
    return result

@router.delete("/admin/submissions/{submission_id}")
async def delete_submission(
    submission_id: int,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Delete a submission and its correction (admin only)
    """
    print(f"[DELETE API] Recebido pedido para deletar submission_id={submission_id}")
    
    # Find submission
    submission = db.query(models.Submission).filter(
        models.Submission.id == submission_id
    ).first()
    
    if not submission:
        print(f"[DELETE API] Submission {submission_id} NÃO encontrada")
        raise HTTPException(status_code=404, detail="Redação não encontrada")
    
    print(f"[DELETE API] Submission {submission_id} encontrada, título: {submission.title}")
    
    # Delete associated correction if exists
    correction = db.query(models.Correction).filter(
        models.Correction.submission_id == submission_id
    ).first()
    if correction:
        print(f"[DELETE API] Deletando correção associada")
        db.delete(correction)
    else:
        print(f"[DELETE API] Nenhuma correção associada")
    
    # Delete submission
    print(f"[DELETE API] Deletando submission {submission_id}")
    db.delete(submission)
    
    print(f"[DELETE API] Fazendo FLUSH")
    db.flush()  # Força SQL a ser executado
    
    print(f"[DELETE API] Fazendo COMMIT")
    db.commit()
    
    # Verifica se realmente foi deletado
    verification = db.query(models.Submission).filter(
        models.Submission.id == submission_id
    ).first()
    
    if verification:
        print(f"[DELETE API] ❌ ERRO: Submission {submission_id} AINDA EXISTE após commit!")
        raise HTTPException(status_code=500, detail="Erro ao deletar redação do banco")
    
    print(f"[DELETE API] ✅ Submission {submission_id} deletada e verificada com sucesso!")
    
    return {"message": "Redação excluída com sucesso", "id": submission_id}

@router.delete("/admin/users/{user_id}")
async def delete_user(
    user_id: int,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Delete a user account (admin only).
    This will delete all submissions and corrections associated with the user.
    Admin cannot delete their own account via this endpoint.
    """
    # Prevent admin from deleting themselves
    if user_id == admin_user.id:
        raise HTTPException(
            status_code=400,
            detail="Você não pode excluir sua própria conta por aqui. Use /users/me"
        )
    
    # Find target user
    target_user = db.query(models.User).filter(models.User.id == user_id).first()
    if not target_user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    
    try:
        # Delete all corrections first (foreign key constraint)
        corrections_to_delete = db.query(models.Correction).join(
            models.Submission
        ).filter(
            models.Submission.owner_id == user_id
        ).all()
        
        for correction in corrections_to_delete:
            db.delete(correction)
        
        # Delete all submissions
        submissions_to_delete = db.query(models.Submission).filter(
            models.Submission.owner_id == user_id
        ).all()
        
        for submission in submissions_to_delete:
            db.delete(submission)
        
        # Delete the user
        user_email = target_user.email
        db.delete(target_user)
        db.commit()
        
        return {
            "message": f"Usuário {user_email} excluído com sucesso",
            "deleted_user_id": user_id
        }
    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"Erro ao excluir usuário: {str(e)}"
        )


@router.get("/admin/stats")
async def get_admin_stats(
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """Retorna estatísticas gerais do sistema para o dashboard admin."""
    from sqlalchemy import func
    from datetime import datetime, timedelta
    
    try:
        # 1. Total de usuários
        total_users = db.query(func.count(models.User.id)).scalar() or 0
        
        # 2. Usuários ativos (com submissions nos últimos 30 dias)
        thirty_days_ago = datetime.utcnow() - timedelta(days=30)
        active_users = db.query(func.count(func.distinct(models.Submission.owner_id))).filter(
            models.Submission.submitted_at >= thirty_days_ago
        ).scalar() or 0
        
        # 3. Total de redações (apenas completed)
        total_essays = db.query(func.count(models.Submission.id)).filter(
            models.Submission.status == "completed"
        ).scalar() or 0
        
        # 4. Receita total (transações aprovadas, em centavos)
        total_revenue = db.query(func.sum(models.Transaction.price)).filter(
            models.Transaction.status == "approved"
        ).scalar() or 0
        
        # 5. Pontuação média (de todas as correções)
        avg_score = db.query(func.avg(models.Correction.total_score)).scalar()
        avg_score = round(avg_score) if avg_score else 0
        
        # 6. Pendentes (redações aguardando correção)
        pending_corrections = db.query(func.count(models.Submission.id)).filter(
            models.Submission.status.in_(["pending", "processing"])
        ).scalar() or 0
        
        return {
            "total_users": total_users,
            "active_users": active_users,
            "total_essays": total_essays,
            "total_revenue": total_revenue,
            "avg_score": avg_score,
            "pending_corrections": pending_corrections
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar estatísticas: {str(e)}")
