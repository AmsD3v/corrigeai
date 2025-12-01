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
        
        # Update status to processing
        submission.status = "processing"
        db.commit()
        
        # Call appropriate correction function based on type
        exam_type = getattr(submission, 'exam_type', None) or 'enem'  # Pega exam_type da submission
        print(f"📚 Tipo de vestibular: {exam_type.upper()}")
        
        if correction_type == "premium":
            print("💎 Usando correção PREMIUM (Groq + Gemini)")
            groq_key = os.getenv('GROQ_API_KEY')
            gemini_key = os.getenv('GEMINI_API_KEY')
            
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
        
        # Ensure JSON fields are strings
        import json
        strengths = correction_data.get('strengths', [])
        if not isinstance(strengths, str):
            strengths = json.dumps(strengths, ensure_ascii=False)
            
        improvements = correction_data.get('improvements', [])
        if not isinstance(improvements, str):
            improvements = json.dumps(improvements, ensure_ascii=False)

        # Save correction
        db_correction = models.Correction(
            submission_id=submission.id,
            competence_1_score=correction_data.get('competence_1_score', 0),
            competence_2_score=correction_data.get('competence_2_score', 0),
            competence_3_score=correction_data.get('competence_3_score', 0),
            competence_4_score=correction_data.get('competence_4_score', 0),
            competence_5_score=correction_data.get('competence_5_score', 0),
            total_score=correction_data.get('total_score', 0),
            competence_1_feedback=correction_data.get('competence_1_feedback', 'Sem feedback'),
            competence_2_feedback=correction_data.get('competence_2_feedback', 'Sem feedback'),
            competence_3_feedback=correction_data.get('competence_3_feedback', 'Sem feedback'),
            competence_4_feedback=correction_data.get('competence_4_feedback', 'Sem feedback'),
            competence_5_feedback=correction_data.get('competence_5_feedback', 'Sem feedback'),
            strengths=strengths,
            improvements=improvements,
            general_comments=correction_data.get('general_comments', 'Sem comentários gerais')
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
