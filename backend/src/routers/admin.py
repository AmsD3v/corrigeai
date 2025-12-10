from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from sqlalchemy import Integer
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


@router.patch("/admin/transactions/{transaction_id}/approve")
async def approve_transaction(
    transaction_id: int,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Approve a pending transaction and add coins to user (admin only)
    """
    from datetime import datetime
    
    transaction = db.query(models.Transaction).filter(
        models.Transaction.id == transaction_id
    ).first()
    
    if not transaction:
        raise HTTPException(status_code=404, detail="Transação não encontrada")
    
    if transaction.status != "pending":
        raise HTTPException(
            status_code=400, 
            detail=f"Transação já está com status: {transaction.status}"
        )
    
    # Update transaction status
    transaction.status = "approved"
    transaction.approved_at = datetime.utcnow()
    
    # Add coins to user
    user = db.query(models.User).filter(models.User.id == transaction.user_id).first()
    if user:
        total_coins = transaction.coins_amount + transaction.bonus_coins
        user.credits = (user.credits or 0) + total_coins
    
    db.commit()
    
    return {
        "message": f"Transação aprovada! {transaction.coins_amount + transaction.bonus_coins} CorriCoins adicionados.",
        "transaction_id": transaction_id,
        "status": "approved"
    }


@router.patch("/admin/transactions/{transaction_id}/reject")
async def reject_transaction(
    transaction_id: int,
    reason: Optional[dict] = None,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Reject a pending transaction (admin only)
    """
    transaction = db.query(models.Transaction).filter(
        models.Transaction.id == transaction_id
    ).first()
    
    if not transaction:
        raise HTTPException(status_code=404, detail="Transação não encontrada")
    
    if transaction.status != "pending":
        raise HTTPException(
            status_code=400, 
            detail=f"Transação já está com status: {transaction.status}"
        )
    
    # Update transaction status
    transaction.status = "rejected"
    
    db.commit()
    
    return {
        "message": "Transação rejeitada.",
        "transaction_id": transaction_id,
        "status": "rejected"
    }

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


@router.get("/admin/user-growth")
async def get_user_growth(
    months: int = 6,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Retorna dados de crescimento de usuários por mês para o gráfico.
    """
    from sqlalchemy import func, extract
    from datetime import datetime, timedelta
    from calendar import monthrange
    
    try:
        now = datetime.utcnow()
        data = []
        
        # Buscar contagem de usuários por mês nos últimos N meses
        for i in range(months - 1, -1, -1):
            # Calcular data do mês
            month_date = now - timedelta(days=i * 30)  # Aproximação
            year = month_date.year
            month = month_date.month
            
            # Primeiro e último dia do mês
            first_day = datetime(year, month, 1)
            last_day_num = monthrange(year, month)[1]
            last_day = datetime(year, month, last_day_num, 23, 59, 59)
            
            # Contar usuários cadastrados neste mês
            count = db.query(func.count(models.User.id)).filter(
                models.User.created_at >= first_day,
                models.User.created_at <= last_day
            ).scalar() or 0
            
            # Nome do mês em português
            month_names = ['', 'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 
                          'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
            
            data.append({
                "month": month_names[month],
                "year": year,
                "users": count
            })
        
        return data
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar crescimento: {str(e)}")


@router.get("/admin/recent-activities")
async def get_recent_activities(
    limit: int = 10,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Retorna as atividades recentes do sistema para o dashboard admin.
    Combina: novos usuários, redações submetidas e transações.
    """
    from sqlalchemy import func
    from datetime import datetime, timedelta
    
    try:
        activities = []
        
        # 1. Últimos usuários cadastrados
        recent_users = db.query(models.User).order_by(
            models.User.created_at.desc()
        ).limit(5).all()
        
        for user in recent_users:
            if user.created_at:
                activities.append({
                    "id": f"user_{user.id}",
                    "type": "user",
                    "description": f"Novo usuário: {user.full_name or user.email}",
                    "time": user.created_at.isoformat(),
                    "timestamp": user.created_at
                })
        
        # 2. Últimas redações submetidas
        recent_submissions = db.query(models.Submission).join(models.User).order_by(
            models.Submission.submitted_at.desc()
        ).limit(5).all()
        
        for sub in recent_submissions:
            if sub.submitted_at:
                user = db.query(models.User).filter(models.User.id == sub.owner_id).first()
                user_name = user.full_name or user.email if user else "Usuário"
                status_text = "corrigida" if sub.status == "completed" else "submetida"
                activities.append({
                    "id": f"essay_{sub.id}",
                    "type": "essay",
                    "description": f"Redação {status_text}: {sub.title or 'Sem título'} ({user_name})",
                    "time": sub.submitted_at.isoformat(),
                    "timestamp": sub.submitted_at
                })
        
        # 3. Últimas transações
        recent_transactions = db.query(models.Transaction).join(models.User).order_by(
            models.Transaction.created_at.desc()
        ).limit(5).all()
        
        for tx in recent_transactions:
            if tx.created_at:
                user = db.query(models.User).filter(models.User.id == tx.user_id).first()
                user_name = user.full_name or user.email if user else "Usuário"
                status_emoji = "✅" if tx.status == "approved" else "⏳" if tx.status == "pending" else "❌"
                activities.append({
                    "id": f"tx_{tx.id}",
                    "type": "purchase",
                    "description": f"{status_emoji} Transação R${tx.price/100:.2f}: {user_name}",
                    "time": tx.created_at.isoformat(),
                    "timestamp": tx.created_at
                })
        
        # Ordenar por timestamp descendente e pegar os N mais recentes
        activities.sort(key=lambda x: x["timestamp"], reverse=True)
        activities = activities[:limit]
        
        # Formatar tempo relativo
        now = datetime.utcnow()
        for activity in activities:
            delta = now - activity["timestamp"]
            if delta.days > 0:
                activity["time"] = f"há {delta.days} dia(s)"
            elif delta.seconds >= 3600:
                hours = delta.seconds // 3600
                activity["time"] = f"há {hours} hora(s)"
            elif delta.seconds >= 60:
                minutes = delta.seconds // 60
                activity["time"] = f"há {minutes} minuto(s)"
            else:
                activity["time"] = "agora mesmo"
            # Remover timestamp do retorno
            del activity["timestamp"]
        
        return activities
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar atividades: {str(e)}")


@router.get("/admin/analytics")
async def get_admin_analytics(
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """Retorna métricas detalhadas para a página Analytics Admin."""
    from sqlalchemy import func, extract
    from datetime import datetime, timedelta
    
    try:
        now = datetime.utcnow()
        first_day_of_month = datetime(now.year, now.month, 1)
        thirty_days_ago = now - timedelta(days=30)
        
        # === USER METRICS ===
        total_users = db.query(func.count(models.User.id)).scalar() or 0
        
        # Usuários ativos (com submissions nos últimos 30 dias)
        active_users = db.query(func.count(func.distinct(models.Submission.owner_id))).filter(
            models.Submission.submitted_at >= thirty_days_ago
        ).scalar() or 0
        
        # Novos usuários este mês
        new_users_this_month = db.query(func.count(models.User.id)).filter(
            models.User.created_at >= first_day_of_month
        ).scalar() or 0
        
        # Taxa de retenção (% de usuários com pelo menos 2 submissions)
        users_with_multiple_submissions = db.query(
            func.count(func.distinct(models.Submission.owner_id))
        ).filter(
            db.query(func.count(models.Submission.id))
            .filter(models.Submission.owner_id == models.User.id)
            .correlate(models.User)
            .as_scalar() >= 2
        ).scalar() or 0
        retention_rate = round((users_with_multiple_submissions / total_users * 100) if total_users > 0 else 0, 1)
        
        # Taxa de churn (100 - retention)
        churn_rate = round(100 - retention_rate, 1)
        
        # === ESSAY METRICS ===
        # Total de redações completed
        total_essays = db.query(func.count(models.Submission.id)).filter(
            models.Submission.status == "completed"
        ).scalar() or 0
        
        # Pontuação média geral
        avg_score = db.query(func.avg(models.Correction.total_score)).scalar()
        avg_score = round(avg_score) if avg_score else 0
        
        # Redações deste mês
        essays_this_month = db.query(func.count(models.Submission.id)).filter(
            models.Submission.submitted_at >= first_day_of_month,
            models.Submission.status == "completed"
        ).scalar() or 0
        
        # Performance média por competência
        avg_competency_scores = []
        for i in range(1, 6):
            competency_field = getattr(models.Correction, f'competence_{i}_score')
            avg_comp = db.query(func.avg(competency_field)).scalar()
            avg_competency_scores.append(round(avg_comp) if avg_comp else 0)
        
        # === REVENUE METRICS ===
        # Receita total (em centavos)
        total_revenue_cents = db.query(func.sum(models.Transaction.price)).filter(
            models.Transaction.status == "approved"
        ).scalar() or 0
        total_revenue = total_revenue_cents / 100  # Converter para reais
        
        # ARPU (Average Revenue Per User)
        arpu = round(total_revenue / total_users, 2) if total_users > 0 else 0
        
        # MRR (simplificado: 30% da receita total dividido por número de meses ativos)
        # Assumindo que o sistema tem pelo menos 1 mês
        mrr = round(total_revenue * 0.3, 2)
        
        # LTV (assumindo 12 meses de lifetime)
        ltv = round(arpu * 12, 2)
        
        return {
            "user_metrics": {
                "total_users": total_users,
                "active_users": active_users,
                "new_users_this_month": new_users_this_month,
                "retention_rate": retention_rate,
                "churn_rate": churn_rate
            },
            "essay_metrics": {
                "total_essays": total_essays,
                "avg_score": avg_score,
                "essays_this_month": essays_this_month,
                "avg_competency_scores": avg_competency_scores
            },
            "revenue_metrics": {
                "total_revenue": total_revenue,
                "mrr": mrr,
                "arpu": arpu,
                "ltv": ltv
            }
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar analytics: {str(e)}")


@router.get("/admin/growth-timeline")
async def get_growth_timeline(
    months: int = 6,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Retorna dados de crescimento ao longo do tempo para o gráfico de linhas.
    Inclui: usuários novos, redações e receita por mês.
    """
    from sqlalchemy import func
    from datetime import datetime, timedelta
    from calendar import monthrange
    
    try:
        now = datetime.utcnow()
        data = []
        
        month_names = ['', 'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 
                      'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']
        
        for i in range(months - 1, -1, -1):
            # Calcular data do mês
            month_date = now - timedelta(days=i * 30)
            year = month_date.year
            month = month_date.month
            
            # Primeiro e último dia do mês
            first_day = datetime(year, month, 1)
            last_day_num = monthrange(year, month)[1]
            last_day = datetime(year, month, last_day_num, 23, 59, 59)
            
            # Novos usuários no mês
            new_users = db.query(func.count(models.User.id)).filter(
                models.User.created_at >= first_day,
                models.User.created_at <= last_day
            ).scalar() or 0
            
            # Redações completadas no mês
            essays = db.query(func.count(models.Submission.id)).filter(
                models.Submission.submitted_at >= first_day,
                models.Submission.submitted_at <= last_day,
                models.Submission.status == "completed"
            ).scalar() or 0
            
            # Receita do mês (em reais)
            revenue_cents = db.query(func.sum(models.Transaction.price)).filter(
                models.Transaction.created_at >= first_day,
                models.Transaction.created_at <= last_day,
                models.Transaction.status == "approved"
            ).scalar() or 0
            revenue = revenue_cents / 100
            
            data.append({
                "month": month_names[month],
                "year": year,
                "label": f"{month_names[month]}/{str(year)[2:]}",
                "users": new_users,
                "essays": essays,
                "revenue": round(revenue, 2)
            })
        
        return data
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar timeline: {str(e)}")


@router.get("/admin/feedback-stats")
def get_feedback_stats(
    days: Optional[int] = 30,
    db: Session = Depends(get_db),
    admin: models.User = Depends(get_current_admin_user)
):
    """Get feedback statistics for admin dashboard"""
    from sqlalchemy import func
    from datetime import datetime, timedelta
    
    try:
        start_date = datetime.utcnow() - timedelta(days=days)
        
        # Total feedbacks
        total_feedbacks = db.query(func.count(models.Feedback.id)).filter(
            models.Feedback.created_at >= start_date
        ).scalar() or 0
        
        # Positive (👍)
        positive_count = db.query(func.count(models.Feedback.id)).filter(
            models.Feedback.created_at >= start_date,
            models.Feedback.is_helpful == True
        ).scalar() or 0
        
        # Negative (👎)
        negative_count = db.query(func.count(models.Feedback.id)).filter(
            models.Feedback.created_at >= start_date,
            models.Feedback.is_helpful == False
        ).scalar() or 0
        
        # Latest feedbacks
        latest_feedbacks = db.query(models.Feedback).filter(
            models.Feedback.created_at >= start_date
        ).order_by(models.Feedback.created_at.desc()).limit(10).all()
        
        # Daily stats
        daily_stats = db.query(
            func.date(models.Feedback.created_at).label('date'),
            func.count(models.Feedback.id).label('count'),
            func.sum(func.cast(models.Feedback.is_helpful, Integer)).label('positive')
        ).filter(
            models.Feedback.created_at >= start_date
        ).group_by(func.date(models.Feedback.created_at)).all()
        
        # Get essay info for latest feedbacks
        latest_with_info = []
        for f in latest_feedbacks:
            submission = db.query(models.Submission).filter(models.Submission.id == f.submission_id).first()
            correction = db.query(models.Correction).filter(models.Correction.submission_id == f.submission_id).first()
            user = db.query(models.User).filter(models.User.id == f.user_id).first()
            
            latest_with_info.append({
                "id": f.id,
                "submission_id": f.submission_id,
                "essay_title": submission.title if submission else "Redação deletada",
                "score": correction.total_score if correction else 0,
                "is_helpful": f.is_helpful,
                "user_name": user.full_name if user else "Usuário desconhecido",
                "created_at": f.created_at.isoformat()
            })
        
        return {
            "total_feedbacks": total_feedbacks,
            "positive_count": positive_count,
            "negative_count": negative_count,
            "positive_percentage": round((positive_count / total_feedbacks * 100), 1) if total_feedbacks > 0 else 0,
            "negative_percentage": round((negative_count / total_feedbacks * 100), 1) if total_feedbacks > 0 else 0,
            "latest_feedbacks": latest_with_info,
            "daily_stats": [
                {
                    "date": stat.date.isoformat(),
                    "total": stat.count,
                    "positive": stat.positive or 0,
                    "negative": stat.count - (stat.positive or 0)
                }
                for stat in daily_stats
            ],
            "period_days": days
        }
    except Exception as e:
        import logging
        logging.error(f"Erro ao buscar feedback stats: {e}")
        raise HTTPException(status_code=500, detail=f"Erro ao buscar estatísticas: {str(e)}")
