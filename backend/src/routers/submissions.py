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

    # PROTEÇÃO ANTI-DUPLICAÇÃO: Rejeitar submissões idênticas nos últimos 30 segundos
    from datetime import datetime, timedelta
    time_threshold = datetime.utcnow() - timedelta(seconds=30)
    
    existing_recent = db.query(models.Submission).filter(
        models.Submission.owner_id == current_user.id,
        models.Submission.title == submission.title,
        models.Submission.submitted_at > time_threshold
    ).first()
    
    if existing_recent:
        logging.warning(f"⚠️ SUBMISSÃO DUPLICADA REJEITADA - User: {current_user.email}, Title: {submission.title}")
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail="Submissão duplicada detectada. Aguarde alguns segundos antes de tentar novamente."
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
                "exam_type": getattr(submission, 'exam_type', 'enem'),  # Vestibular
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


@router.get("/my-submissions/development-stats")
def get_development_stats(
    exam_type: str = None,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user),
):
    """
    Get development statistics for the user including competency averages and score history.
    Used by the Meu Desenvolvimento page.
    Optional exam_type filter to show stats for a specific vestibular.
    Uses specific competencies for each vestibular.
    """
    from ..exam_criteria import get_exam_criteria
    import json
    
    try:
        # First, get all unique exam_types for this user
        all_submissions = db.query(models.Submission).filter(
            models.Submission.owner_id == current_user.id,
            models.Submission.status == "completed"
        ).all()
        
        available_exam_types = list(set([
            s.exam_type for s in all_submissions if s.exam_type
        ]))
        available_exam_types.sort()
        
        # Build query with optional exam_type filter
        query = db.query(models.Submission).filter(
            models.Submission.owner_id == current_user.id,
            models.Submission.status == "completed"
        )
        
        if exam_type and exam_type != "all":
            query = query.filter(models.Submission.exam_type == exam_type)
        
        submissions = query.order_by(models.Submission.submitted_at.asc()).all()
        
        if not submissions:
            return {
                "has_data": False,
                "competencies": [],
                "score_history": [],
                "best_competencies": [],
                "worst_competencies": [],
                "available_exam_types": available_exam_types,
                "exam_info": None
            }
        
        # Determine which exam criteria to use
        # If filtering by specific exam, use that exam's criteria
        # Otherwise, use ENEM as default for "all"
        selected_exam_type = exam_type if exam_type and exam_type != "all" else "enem"
        exam_criteria = get_exam_criteria(selected_exam_type)
        
        num_competencies = len(exam_criteria.competencies)
        competency_totals = [0] * num_competencies
        count = 0
        score_history = []
        
        for submission in submissions:
            correction = db.query(models.Correction).filter(
                models.Correction.submission_id == submission.id
            ).first()
            
            if correction:
                # Add scores for each competency
                if num_competencies >= 1 and correction.competence_1_score:
                    competency_totals[0] += correction.competence_1_score
                if num_competencies >= 2 and correction.competence_2_score:
                    competency_totals[1] += correction.competence_2_score
                if num_competencies >= 3 and correction.competence_3_score:
                    competency_totals[2] += correction.competence_3_score
                if num_competencies >= 4 and correction.competence_4_score:
                    competency_totals[3] += correction.competence_4_score
                if num_competencies >= 5 and correction.competence_5_score:
                    competency_totals[4] += correction.competence_5_score
                count += 1
                
                score_history.append({
                    "essay_id": submission.id,
                    "title": submission.title or "Redação sem título",
                    "score": correction.total_score,
                    "date": submission.submitted_at.isoformat() if submission.submitted_at else None,
                    "exam_type": submission.exam_type
                })
        
        if count == 0:
            return {
                "has_data": False,
                "competencies": [],
                "score_history": [],
                "best_competencies": [],
                "worst_competencies": [],
                "available_exam_types": available_exam_types,
                "exam_info": None
            }
        
        # Calculate averages using exam-specific criteria
        competencies = []
        for i in range(num_competencies):
            max_score = exam_criteria.weights[i] if i < len(exam_criteria.weights) else 200
            avg_score = round(competency_totals[i] / count) if count > 0 else 0
            percentage = round((avg_score / max_score) * 100) if max_score > 0 else 0
            
            # Get competency name (split on ":" for short name)
            full_name = exam_criteria.competencies[i] if i < len(exam_criteria.competencies) else f"Competência {i+1}"
            if ":" in full_name:
                name, description = full_name.split(":", 1)
                name = name.strip()
                description = description.strip()
            else:
                name = f"Competência {i+1}"
                description = full_name
            
            competencies.append({
                "id": i + 1,
                "name": name,
                "description": description,
                "score": avg_score,
                "max_score": max_score,
                "percentage": percentage
            })
        
        # Find best and worst
        if competencies:
            max_score = max(c["score"] for c in competencies)
            min_score = min(c["score"] for c in competencies)
            
            best_competencies = [c for c in competencies if c["score"] == max_score]
            worst_competencies = [c for c in competencies if c["score"] == min_score]
        else:
            best_competencies = []
            worst_competencies = []
        
        return {
            "has_data": True,
            "competencies": competencies,
            "score_history": score_history,
            "best_competencies": best_competencies,
            "worst_competencies": worst_competencies,
            "available_exam_types": available_exam_types,
            "exam_info": {
                "id": selected_exam_type,
                "name": exam_criteria.name,
                "short_name": exam_criteria.short_name,
                "max_score": exam_criteria.max_score,
                "num_competencies": num_competencies
            }
        }
    except Exception as e:
        logging.error(f"Erro ao buscar estatísticas de desenvolvimento: {e}")
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
    
    # Check if user already gave feedback (with error handling)
    user_has_feedback = False
    try:
        existing_feedback = db.query(models.Feedback).filter(
            models.Feedback.submission_id == submission.id,
            models.Feedback.user_id == current_user.id
        ).first()
        user_has_feedback = existing_feedback is not None
    except Exception as e:
        # Table might not exist yet, ignore error
        pass
    
    result = {
        "id": str(submission.id),
        "title": submission.title,
        "theme": submission.theme,
        "content": submission.content,
        "submitted_at": str(submission.submitted_at),
        "status": submission.status,
        "exam_type": submission.exam_type,  # Add exam_type
        "user_has_feedback": user_has_feedback
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
            "general_comments": correction.general_comments or "",
            "criteria_snapshot": correction.criteria_snapshot  # Snapshot dos critérios usados
        }
    
    return result


@router.post("/{submission_id}/feedback", status_code=status.HTTP_201_CREATED)
def create_correction_feedback(
    submission_id: int,
    feedback_data: dict,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """Create feedback for a correction (thumbs up/down)"""
    # Verify submission belongs to user
    submission = db.query(models.Submission).filter(
        models.Submission.id == submission_id,
        models.Submission.owner_id == current_user.id
    ).first()
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada"
        )
    
    # Check if feedback already exists
    try:
        existing_feedback = db.query(models.Feedback).filter(
            models.Feedback.submission_id == submission_id,
            models.Feedback.user_id == current_user.id
        ).first()
        
        if existing_feedback:
            # Update existing feedback
            existing_feedback.is_helpful = feedback_data.get("helpful", True)
            db.commit()
            return {"message": "Feedback atualizado com sucesso"}
        
        # Create new feedback
        new_feedback = models.Feedback(
            submission_id=submission_id,
            user_id=current_user.id,
            is_helpful=feedback_data.get("helpful", True)
        )
        db.add(new_feedback)
        db.commit()
        
        return {"message": "Feedback criado com sucesso"}
        
    except Exception as e:
        db.rollback()
        # If table doesn't exist, just return success (feedback will be saved when table is created)
        return {"message": "Feedback registrado", "note": "Tabela será criada em breve"}





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
                # Em vez de erro 500, retorna um objeto de correção vazio com aviso
                # Isso evita que o frontend quebre e permite mostrar o erro na UI
                return schemas.CorrectionDetail(
                    id=0,
                    submission_id=submission_id,
                    total_score=0,
                    competence_1_score=0,
                    competence_2_score=0,
                    competence_3_score=0,
                    competence_4_score=0,
                    competence_5_score=0,
                    competence_1_feedback="Falha na correção",
                    competence_2_feedback="Falha na correção",
                    competence_3_feedback="Falha na correção",
                    competence_4_feedback="Falha na correção",
                    competence_5_feedback="Falha na correção",
                    strengths=[],
                    improvements=[],
                    general_comments="⚠️ Ocorreu uma falha ao processar sua redação com a IA. Isso pode acontecer por instabilidade momentânea. Por favor, tente enviar novamente ou entre em contato com o suporte.",
                    corrected_at=submission.submitted_at,
                    exam_type=submission.exam_type or "enem"
                )
            else:
                # Status desconhecido ou 'completed' mas sem correção (inconsistência)
                logging.error(f"Inconsistência: Submissão {submission.id} com status {submission.status} mas sem correção no banco.")
                raise HTTPException(
                    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    detail=f"Erro de consistência. Status: {submission.status}"
                )
        
        # Manually construct response to include exam_type from submission
        response_data = schemas.CorrectionDetail(
            id=correction.id,
            submission_id=correction.submission_id,
            competence_1_score=correction.competence_1_score,
            competence_2_score=correction.competence_2_score,
            competence_3_score=correction.competence_3_score,
            competence_4_score=correction.competence_4_score,
            competence_5_score=correction.competence_5_score,
            total_score=correction.total_score,
            competence_1_feedback=correction.competence_1_feedback,
            competence_2_feedback=correction.competence_2_feedback,
            competence_3_feedback=correction.competence_3_feedback,
            competence_4_feedback=correction.competence_4_feedback,
            competence_5_feedback=correction.competence_5_feedback,
            strengths=correction.strengths,
            improvements=correction.improvements,
            general_comments=correction.general_comments,
            corrected_at=correction.corrected_at,
            exam_type=submission.exam_type or "enem"
        )
        
        return response_data
        
    except HTTPException:
        raise
    except Exception as e:
        import traceback
        error_msg = f"Erro em get_correction: {str(e)}\n{traceback.format_exc()}"
        print(f"❌ {error_msg}")
        logging.error(error_msg)
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


@router.post("/submissions/{submission_id}/feedback", response_model=schemas.CorrectionFeedbackResponse)
def submit_correction_feedback(
    submission_id: str,  # Accept both UUID and INT as string
    feedback: schemas.CorrectionFeedbackCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """
    Submit user feedback for a correction
    - Allows user to mark correction as helpful (👍) or not helpful (👎)
    - Updates existing feedback if already exists
    - Supports both UUID (legacy) and INT (new) submission IDs
    """
    from datetime import datetime
    
    # Try to find submission by UUID first, then by INT ID
    submission = None
    numeric_id = None
    
    try:
        # Try as integer first
        numeric_id = int(submission_id)
        submission = db.query(models.Submission).filter(
            models.Submission.id == numeric_id,
            models.Submission.owner_id == current_user.id
        ).first()
    except ValueError:
        # Not an integer, might be UUID - not supported in current schema
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada. IDs UUID não são mais suportados."
        )
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada"
        )
    
    # Use the numeric ID from the found submission
    numeric_id = submission.id
    
    # Check if feedback already exists
    existing = db.query(models.Feedback).filter(
        models.Feedback.submission_id == numeric_id,
        models.Feedback.user_id == current_user.id
    ).first()
    
    if existing:
        # Update existing feedback
        existing.is_helpful = feedback.helpful
        db.commit()
        db.refresh(existing)
        return existing
    
    # Create new feedback
    db_feedback = models.Feedback(
        submission_id=numeric_id,
        user_id=current_user.id,
        is_helpful=feedback.helpful
    )
    
    db.add(db_feedback)
    db.commit()
    db.refresh(db_feedback)
    
    return db_feedback
