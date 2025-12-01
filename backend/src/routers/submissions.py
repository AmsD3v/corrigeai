from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from .. import schemas, models
from ..database import get_db, SessionLocal
from ..dependencies import get_current_user
from ..correction_service import process_correction
import logging
import traceback
import asyncio

router = APIRouter()

async def trigger_correction(submission_id: int):
    """
    Trigger essay correction using Gemini AI in background
    Creates its own database session to avoid session closure issues
    """
    print(f"\n🔵 ==== TRIGGER_CORRECTION CALLED for submission {submission_id} ====")
    
    from ..database import init_db_engine
    
    # Ensure SessionLocal is initialized
    if SessionLocal is None:
        print("⚠️ SessionLocal not initialized in trigger_correction, initializing...")
        init_db_engine()
        from ..database import SessionLocal as SL
    else:
        SL = SessionLocal
    
    # Create a new database session for the background task
    db = SL()
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

@router.post("/submit", response_model=schemas.SubmissionResponse)
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
    logging.info(f"🔵 ENDPOINT /submit CHAMADO - User: {current_user.email}, Title: {submission.title}, Type: {submission.correction_type}")
    
    if current_user.role != "aluno":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Apenas usuários com perfil 'aluno' podem enviar redações.",
        )

    # Validate correction_type
    if submission.correction_type not in ["advanced", "premium"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Tipo de correção inválido. Use 'advanced' ou 'premium'.",
        )
    
    # Calculate required credits
    required_credits = 3 if submission.correction_type == "premium" else 1
    
    # Check total available credits (free + paid)
    total_available = (current_user.free_credits or 0) + current_user.credits
    
    if total_available < required_credits:
        raise HTTPException(
            status_code=status.HTTP_402_PAYMENT_REQUIRED,
            detail=f"Créditos insuficientes. Necessário: {required_credits}, Disponível: {total_available} (Grátis: {current_user.free_credits or 0}, CorriCoins: {current_user.credits})",
        )


    db_submission = models.Submission(
        **submission.model_dump(), owner_id=current_user.id
    )
    
    # DEBUG: Log exam_type
    logging.info(f"🎓 EXAM_TYPE RECEBIDO: {submission.exam_type or 'None/NULL'}")
    logging.info(f"🎓 EXAM_TYPE NO DB_SUBMISSION: {db_submission.exam_type or 'None/NULL'}")
    
    db.add(db_submission)
    
    # Deduct credits: use free_credits first, then paid credits
    credits_to_deduct = required_credits
    free_credits_available = current_user.free_credits or 0
    
    if free_credits_available > 0:
        # Use free credits first
        if free_credits_available >= credits_to_deduct:
            # All from free credits
            current_user.free_credits -= credits_to_deduct
            logging.info(f"✅ Deducted {credits_to_deduct} free credits. Remaining free: {current_user.free_credits}")
        else:
            # Use all free credits + some paid credits
            remaining_needed = credits_to_deduct - free_credits_available
            current_user.free_credits = 0
            current_user.credits -= remaining_needed
            logging.info(f"✅ Deducted {free_credits_available} free credits + {remaining_needed} CorriCoins. Remaining: Free={current_user.free_credits}, Paid={current_user.credits}")
    else:
        # No free credits, use paid credits only
        current_user.credits -= credits_to_deduct
        logging.info(f"✅ Deducted {credits_to_deduct} CorriCoins. Remaining: {current_user.credits}")
    
    db.commit()
    db.refresh(db_submission)
    
    # Executa a correção de forma síncrona (inline) para garantir que funcione
    logging.info(f"Iniciando correção {submission.correction_type} da submissão {db_submission.id}")
    try:
        await trigger_correction(db_submission.id)
        logging.info(f"Correção da submissão {db_submission.id} iniciada com sucesso")
    except Exception as e:
        logging.error(f"Erro ao iniciar correção da submissão {db_submission.id}: {e}")
    
    return db_submission


@router.get("/my-submissions")
def list_my_submissions(
    skip: int = 0,
    limit: int = 10,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user),
):
    """
    Lista submissões do usuário com paginação (infinite scroll)
    """
    try:
        # Total de submissões do usuário
        total = db.query(models.Submission).filter(
            models.Submission.owner_id == current_user.id
        ).count()
        
        # Buscar submissões paginadas
        submissions = db.query(models.Submission).filter(
            models.Submission.owner_id == current_user.id
        ).order_by(models.Submission.submitted_at.desc()).offset(skip).limit(limit).all()
        
        result = []
        for submission in submissions:
            # Buscar a correção associada (se existir)
            correction = db.query(models.Correction).filter(
                models.Correction.submission_id == submission.id
            ).first()
            
            result.append({
                "id": submission.id,
                "title": submission.title,
                "theme": submission.theme,
                "submitted_at": submission.submitted_at,
                "status": submission.status,
                "correction_type": getattr(submission, 'correction_type', 'advanced'),
                "score": correction.total_score if correction else None,
                "has_correction": correction is not None
            })
        
        return {
            "total": total,
            "skip": skip,
            "limit": limit,
            "has_more": (skip + limit) < total,
            "items": result
        }
    except Exception as e:
        logging.error(f"Erro ao listar submissões: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/my-submissions/{submission_id}")
def get_my_submission_details(
    submission_id: str,  # Accept as string to handle both UUID and INT
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """
    Get detailed submission data including correction.
    Returns submission with nested correction object.
    Accepts both integer IDs (from database) and UUID strings (from old localStorage).
    """
    # Try to convert to int (database ID)
    try:
        numeric_id = int(submission_id)
        submission = db.query(models.Submission).filter(
            models.Submission.id == numeric_id,
            models.Submission.owner_id == current_user.id
        ).first()
    except ValueError:
        # Not a valid integer, might be UUID - not supported in current schema
        # Return 404 as we don't store UUIDs in database
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada. IDs antigos (UUID) não são mais suportados."
        )
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada ou acesso não permitido."
        )
    
    # Get correction data
    correction = db.query(models.Correction).filter(
        models.Correction.submission_id == submission.id
    ).first()
    
    result = {
        "id": str(submission.id),
        "title": submission.title,
        "theme": submission.theme,
        "content": submission.content,
        "submitted_at": str(submission.submitted_at),
        "status": submission.status
    }
    
    if correction:
        result["correction"] = {
            "total_score": correction.total_score,
            "competence_1_score": correction.competence_1_score,
            "competence_2_score": correction.competence_2_score,
            "competence_3_score": correction.competence_3_score,
            "competence_4_score": correction.competence_4_score,
            "competence_5_score": correction.competence_5_score,
            "competence_1_feedback": correction.competence_1_feedback or "",
            "competence_2_feedback": correction.competence_2_feedback or "",
            "competence_3_feedback": correction.competence_3_feedback or "",
            "competence_4_feedback": correction.competence_4_feedback or "",
            "competence_5_feedback": correction.competence_5_feedback or "",
            "strengths": correction.strengths or [],
            "improvements": correction.improvements or [],
            "general_comments": correction.general_comments or ""
        }
    
    return result




@router.get("/submissions/{submission_id}", response_model=schemas.SubmissionResponse)
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


@router.get("/submissions/{submission_id}/correction", response_model=schemas.CorrectionDetail)
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
    try:
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
            elif submission.status == "failed" or submission.status == "error":
                error_msg = submission.error_message if hasattr(submission, 'error_message') and submission.error_message else "Erro desconhecido"
                raise HTTPException(
                    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    detail=f"Falha na correção: {error_msg}"
                )
            else:
                # Status desconhecido ou 'completed' mas sem correção (inconsistência)
                logging.error(f"Inconsistência: Submissão {submission.id} com status {submission.status} mas sem correção no banco.")
                raise HTTPException(
                    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    detail=f"Erro de consistência. Status: {submission.status}"
                )
        
        return correction
        
    except HTTPException:
        raise
    except Exception as e:
        logging.error(f"Erro não tratado em get_correction: {str(e)}")
        logging.error(traceback.format_exc())
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Erro interno do servidor: {str(e)}"
        )


# Alias endpoint for frontend compatibility
@router.get("/get-correction/{submission_id}", response_model=schemas.CorrectionDetail)
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
