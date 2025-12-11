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

        # Helper to safely get int score
        def get_int_score(key, default=0):
            try:
                val = correction_data.get(key, default)
                if val is None: return default
                return int(float(val)) # Handle "120.0" or "120" strings
            except (ValueError, TypeError):
                return default

        c1 = get_int_score('competence_1_score')
        c2 = get_int_score('competence_2_score')
        c3 = get_int_score('competence_3_score')
        c4 = get_int_score('competence_4_score')
        c5 = get_int_score('competence_5_score')
        
        # Recalculate total to be safe
        calculated_total = c1 + c2 + c3 + c4 + c5
        ai_total = get_int_score('total_score')
        
        # Use calculated total if AI total is 0 or very different (more than 10 points diff)
        final_total = calculated_total
        if ai_total > 0 and abs(ai_total - calculated_total) < 10:
            final_total = ai_total

        # Create criteria snapshot for consistent display
        from .exam_criteria import get_exam_criteria
        criteria = get_exam_criteria(exam_type)
        criteria_snapshot = json.dumps({
            "exam_type": exam_type,
            "short_name": criteria.short_name,
            "max_score": criteria.max_score,
            "competencies": criteria.competencies,
            "weights": [float(w) for w in criteria.weights]
        }, ensure_ascii=False)
        
        # Save correction
        db_correction = models.Correction(
            submission_id=submission.id,
            competence_1_score=c1,
            competence_2_score=c2,
            competence_3_score=c3,
            competence_4_score=c4,
            competence_5_score=c5,
            total_score=final_total,
            competence_1_feedback=correction_data.get('competence_1_feedback', 'Sem feedback'),
            competence_2_feedback=correction_data.get('competence_2_feedback', 'Sem feedback'),
            competence_3_feedback=correction_data.get('competence_3_feedback', 'Sem feedback'),
            competence_4_feedback=correction_data.get('competence_4_feedback', 'Sem feedback'),
            competence_5_feedback=correction_data.get('competence_5_feedback', 'Sem feedback'),
            strengths=strengths,
            improvements=improvements,
            general_comments=correction_data.get('general_comments', 'Sem comentários gerais'),
            criteria_snapshot=criteria_snapshot
        )
        
        db.add(db_correction)
        
        print(f"💾 Salvando correção no banco de dados...")
        print(f"   - ID da submissão: {submission.id}")
        print(f"   - Total score sendo salvo: {db_correction.total_score}")
        submission.status = "completed"
        db.commit()
        
        # ===== PROCESS GAMIFICATION =====
        try:
            from .routers.gamification import process_essay_completed
            gamification_result = process_essay_completed(db, submission.owner_id, exam_type, db_correction.total_score)
            print(f"🎮 Gamificação: +{gamification_result['xp_earned']} XP")
            if gamification_result['achievements']:
                print(f"🏆 Conquistas: {[a['name'] for a in gamification_result['achievements']]}")
            if gamification_result['challenges_completed']:
                print(f"🎯 Desafios: {[c['title'] for c in gamification_result['challenges_completed']]}")
            if gamification_result['level_up']:
                print(f"🎉 Level up! Novo nível: {gamification_result['new_level']['name']}")
        except Exception as gam_error:
            logger.warning(f"⚠️ Erro ao processar gamificação: {gam_error}")
        # ==========================================
        
        logger.info(f"✅ Correção concluída para submissão {submission_id}")
        print(f"✅ ==== CORRECTION COMPLETED ====\n")
        
    except Exception as e:
        logger.error(f"❌ Erro ao processar correção: {str(e)}")
        logger.error(traceback.format_exc())
        print(f"❌ ERROR: {e}")
        
        # Save error to submission
        submission.status = "error"
        # submission.error_message = str(e) # Removed in rollback
        db.commit()
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
