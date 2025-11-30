import logging
import traceback
import os
from sqlalchemy.orm import Session
from . import models
from . import ai_service

logger = logging.getLogger(__name__)

async def process_correction(submission_id: int, db: Session):
    """
    Processa a correção de uma redação usando AI (Advanced ou Premium)
    
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
        
        print(f"Comp 4: {correction_data.get('competence_4_score')}")
        print(f"Comp 5: {correction_data.get('competence_5_score')}")
        print(f"===================================\n")
        
        # Save correction
        db_correction = models.Correction(
            submission_id=submission.id,
            competence_1_score=correction_data['competence_1_score'],
            competence_2_score=correction_data['competence_2_score'],
            competence_3_score=correction_data['competence_3_score'],
            competence_4_score=correction_data['competence_4_score'],
            competence_5_score=correction_data['competence_5_score'],
            total_score=correction_data['total_score'],
            competence_1_feedback=correction_data['competence_1_feedback'],
            competence_2_feedback=correction_data['competence_2_feedback'],
            competence_3_feedback=correction_data['competence_3_feedback'],
            competence_4_feedback=correction_data['competence_4_feedback'],
            competence_5_feedback=correction_data['competence_5_feedback'],
            strengths=correction_data['strengths'],
            improvements=correction_data['improvements'],
            general_comments=correction_data['general_comments']
        )
        
        db.add(db_correction)
        
        print(f"💾 Salvando correção no banco de dados...")
        print(f"   - ID da submissão: {submission.id}")
        print(f"   - Total score sendo salvo: {db_correction.total_score}")
        submission.status = "completed"
        db.commit()
        
        logger.info(f"✅ Correção concluída para submissão {submission_id}")
        print(f"✅ ==== CORRECTION COMPLETED ====\n")
        
    except Exception as e:
        logger.error(f"❌ Erro ao processar correção: {str(e)}")
        logger.error(traceback.format_exc())
        print(f"❌ ERROR: {e}")
        
        try:
            submission = db.query(models.Submission).filter(
                models.Submission.id == submission_id
            ).first()
            if submission:
                submission.status = "error"
                db.commit()
        except Exception as db_error:
            logger.error(f"Erro ao atualizar status: {str(db_error)}")
