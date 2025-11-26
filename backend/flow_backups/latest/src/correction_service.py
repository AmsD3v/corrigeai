import logging
import traceback
from sqlalchemy.orm import Session
from . import models
from .ai_service import correct_essay_with_gemini  # Multi-provider support


logger = logging.getLogger(__name__)

async def process_correction(submission_id: int, db: Session):
    """
    Processa a correção de uma redação usando Gemini AI
    
    Args:
        submission_id: ID da submissão a ser corrigida
        db: Sessão do banco de dados
    """
    print(f"\n🟢 ==== PROCESS_CORRECTION STARTED for submission {submission_id} ====")
    try:
        # Get submission
        submission = db.query(models.Submission).filter(
            models.Submission.id == submission_id
        ).first()
        
        if not submission:
            print(f"❌ Submissão {submission_id} não encontrada")
            logger.error(f"Submissão {submission_id} não encontrada")
            return
        
        print(f"✅ Submissão encontrada. Updating status to 'processing'...")
        logger.info(f"Iniciando correção da submissão {submission_id}")
        
        # Update status to processing
        submission.status = "processing"
        db.commit()
        
        logger.info(f"Status atualizado para 'processing'. Chamando Gemini AI...")
        
        # Call Gemini AI for correction
        correction_data = await correct_essay_with_gemini(
            title=submission.title,
            theme=submission.theme or "Tema livre",
            content=submission.content
        )
        
        logger.info(f"Gemini retornou dados. Salvando no banco...")
        logger.debug(f"Correction data keys: {correction_data.keys()}")
        
        # Save correction to database
        db_correction = models.Correction(
            submission_id=submission_id,
            **correction_data
        )
        db.add(db_correction)
        
        # Update submission status
        submission.status = "completed"
        db.commit()
        db.refresh(db_correction)
        
        logger.info(f"✅ Correção da submissão {submission_id} concluída com sucesso. Nota: {correction_data['total_score']}/1000")
        
    except Exception as e:
        logger.error(f"❌ ERRO ao processar correção da submissão {submission_id}: {e}")
        logger.error(f"Traceback completo:\n{traceback.format_exc()}")
        
        # Update status to failed
        try:
            submission.status = "failed"
            db.commit()
            
            # Refund credit to user  
            user = db.query(models.User).filter(
                models.User.id == submission.owner_id
            ).first()
            
            if user:
                user.credits += 1
                db.commit()
                logger.info(f"Crédito estornado para o usuário {user.id} devido à falha na correção")
        except Exception as rollback_error:
            logger.error(f"Erro ao fazer rollback: {rollback_error}")

