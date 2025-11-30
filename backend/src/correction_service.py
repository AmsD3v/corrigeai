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
        
        if not submission:
            print(f"❌ Submissão {submission_id} não encontrada")
            logger.error(f"Submissão {submission_id} não encontrada")
            return
        
        correction_type = getattr(submission, 'correction_type', 'advanced')
        print(f"✅ Submissão encontrada. Tipo: {correction_type}")
        logger.info(f"Iniciando correção {correction_type} da submissão {submission_id}")
        
            if not groq_key or not gemini_key:
                raise Exception("Premium requires both GROQ and GEMINI API keys")
            
            correction_data = await ai_service.correct_essay_premium(
                title=submission.title,
                theme=submission.theme or "Tema livre",
                content=submission.content,
                exam_type=exam_type,  # NOVO - passa exam_type
                api_key_groq=groq_key,
                api_key_gemini=gemini_key
            )
        else:
            print("⚡ Usando correção AVANÇADA (Groq)")
            correction_data = await ai_service.correct_essay_with_gemini(
                title=submission.title,
                theme=submission.theme or "Tema livre",
                content=submission.content,
                exam_type=exam_type  # NOVO - passa exam_type
            )
        
        logger.info(f"AI retornou dados. Salvando no banco...")
        
        print(f"\n🔍 === DADOS RECEBIDOS DA IA ===")
        print(f"Total Score: {correction_data.get('total_score')}")
        print(f"Comp 1: {correction_data.get('competence_1_score')}")
        print(f"Comp 2: {correction_data.get('competence_2_score')}")
        print(f"Comp 3: {correction_data.get('competence_3_score')}")
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
