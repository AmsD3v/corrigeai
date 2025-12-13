"""
Gemini AI Service for Essay Correction
"""

import google.generativeai as genai
from .core.config import settings
import json
import logging

logger = logging.getLogger(__name__)

genai.configure(api_key=settings.GEMINI_API_KEY)

CORRECTION_PROMPT = """Analise este texto e forneça feedback detalhado usando 5 critérios.

Para cada critério, forneça pontuação de 0-200 e comentário.

Retorne APENAS JSON:

{{
  "competence_1_score": 160,
  "competence_1_feedback": "Análise da escrita",
  "competence_2_score": 140,
  "competence_2_feedback": "Desenvolvimento do tema",
  "competence_3_score": 160,
  "competence_3_feedback": "Argumentação",
  "competence_4_score": 140,
  "competence_4_feedback": "Organização",
  "competence_5_score": 160,
  "competence_5_feedback": "Conclusão",
  "total_score": 760,
  "strengths": ["Ponto 1", "Ponto 2"],
  "improvements": ["Sugestão 1", "Sugestão 2"],
  "general_comments": "Comentário geral"
}}

Texto:
{title}
{theme}
{content}
"""

async def correct_essay_with_gemini(title: str, theme: str, content: str) -> dict:
    try:
        if not settings.GEMINI_API_KEY or settings.GEMINI_API_KEY == "placeholder_key":
            raise Exception("API key não configurada")
        
        model = genai.GenerativeModel('gemini-2.0-flash')
        
        prompt = CORRECTION_PROMPT.format(title=title, theme=theme or "", content=content)
        
        logger.info(f"Enviando para Gemini: {title}")
        
        response = model.generate_content(
            prompt,
            generation_config=genai.GenerationConfig(temperature=0.3, max_output_tokens=2048),
            safety_settings=[
                {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"},
            ]
        )
        
        if hasattr(response, 'candidates') and len(response.candidates) > 0:
            if response.candidates[0].finish_reason == 2:
                logger.warning("Bloqueado por segurança")
                return {
                    'competence_1_score': 120, 'competence_1_feedback': 'Feedback padrão 1',
                    'competence_2_score': 120, 'competence_2_feedback': 'Feedback padrão 2',
                    'competence_3_score': 120, 'competence_3_feedback': 'Feedback padrão 3',
                    'competence_4_score': 120, 'competence_4_feedback': 'Feedback padrão 4',
                    'competence_5_score': 120, 'competence_5_feedback': 'Feedback padrão 5',
                    'total_score': 600,
                    'strengths': json.dumps(['Texto submetido'], ensure_ascii=False),
                    'improvements': json.dumps(['Tente novamente'], ensure_ascii=False),
                    'general_comments': 'Bloqueado por filtros de segurança'
                }
        
        try:
            text = response.text.strip()
        except:
            return {
                'competence_1_score': 120, 'competence_1_feedback': 'Erro ao processar',
                'competence_2_score': 120, 'competence_2_feedback': 'Erro ao processar',
                'competence_3_score': 120, 'competence_3_feedback': 'Erro ao processar',
                'competence_4_score': 120, 'competence_4_feedback': 'Erro ao processar',
                'competence_5_score': 120, 'total_score': 600,
                'strengths': json.dumps(['Erro'], ensure_ascii=False),
                'improvements': json.dumps(['Tente novamente'], ensure_ascii=False),
                'general_comments': 'Erro ao processar'
            }
        
        if text.startswith("```json"): text = text[7:]
        if text.startswith("```"): text = text[3:]
        if text.endswith("```"): text = text[:-3]
        text = text.strip()
        
        data = json.loads(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        return data
    except Exception as e:
        logger.error(f"Erro: {e}")
        raise

async def generate_theme_with_gemini(category: str) -> str:
    try:
        model = genai.GenerativeModel('gemini-2.0-flash')
        response = model.generate_content(f"Gere um tema sobre {category}. Máximo 15 palavras:")
        return response.text.strip().replace('"', '').replace("'", "")
    except:
        return "A importância da educação no Brasil"


async def get_ai_tutor_response(
    user_message: str,
    submission_data: dict,
    correction_data: dict,
    conversation_history: list
) -> str:
    """
    Get AI tutor response for essay correction questions using configured provider
    
    Args:
        user_message: User's question
        submission_data: Dict with submission info (title, theme, content, exam_type)
        correction_data: Dict with correction scores and feedback
        conversation_history: List of previous messages [{role, content, timestamp}]
        
    Returns:
        AI tutor response text
    """
    try:
        # Get tutor provider from database
        from .database import SessionLocal, init_db_engine
        from .models import Settings
        import os
        
        # Ensure SessionLocal is initialized
        SL = SessionLocal
        if SL is None:
            init_db_engine()
            from .database import SessionLocal as SL_new
            SL = SL_new
        
        db = SL()
        try:
            db_settings = db.query(Settings).first()
            if db_settings:
                tutor_provider = getattr(db_settings, 'tutor_provider', 'groq') or 'groq'
                tutor_api_key = getattr(db_settings, 'tutor_api_key', None) or ''
            else:
                tutor_provider = 'groq'
                tutor_api_key = ''
        finally:
            db.close()
        
        logger.info(f"AI Tutor using provider: {tutor_provider}")
        logger.info(f"AI Tutor API key configured: {bool(tutor_api_key)}")
        
        # Usar chave do banco ou fallback para variáveis de ambiente
        if tutor_api_key:
            api_key = tutor_api_key
        elif tutor_provider == 'groq':
            api_key = os.getenv('GROQ_API_KEY')
        elif tutor_provider == 'gemini':
            api_key = os.getenv('GEMINI_API_KEY')
        elif tutor_provider == 'huggingface':
            api_key = os.getenv('HF_TOKEN')
        elif tutor_provider == 'together':
            api_key = os.getenv('TOGETHER_API_KEY')
        else:
            api_key = os.getenv('GROQ_API_KEY')  # fallback
        
        if not api_key or api_key == "placeholder_key":
            logger.error(f"API key not configured for AI Tutor ({tutor_provider})")
            return (
                f"Desculpe, o Professor IA não está configurado no momento ({tutor_provider}). "
                "Entre em contato com o suporte. 🤖"
            )
        
        logger.info(f"AI Tutor request: {user_message[:50]}...")
        
        # For now, only Groq is implemented for tutor
        if tutor_provider != 'groq':
            logger.warning(f"Tutor provider {tutor_provider} not implemented, falling back to Groq")
            api_key = settings.GROQ_API_KEY or os.getenv('GROQ_API_KEY')
            if not api_key:
                return "Desculpe, o Professor IA não está disponível no momento. 🤖"
        
        # Import Groq
        from groq import Groq
        client = Groq(api_key=api_key)
        
        # PRIORIZAR criteria_snapshot da correção (garante consistência)
        import json
        criteria_snapshot = correction_data.get('criteria_snapshot')
        
        if criteria_snapshot:
            # Usar critérios exatos que foram usados na correção
            try:
                snapshot = json.loads(criteria_snapshot) if isinstance(criteria_snapshot, str) else criteria_snapshot
                current_exam = {
                    'name': snapshot.get('short_name', 'ENEM'),
                    'max': snapshot.get('max_score', 1000),
                    'comp_note': f" ({len(snapshot.get('competencies', []))} competências)"
                }
                competencies = snapshot.get('competencies', [])
                weights = snapshot.get('weights', [200, 200, 200, 200, 200])
                logger.info(f"📌 Using criteria_snapshot: {current_exam['name']}")
            except Exception as e:
                logger.warning(f"Failed to parse criteria_snapshot: {e}, falling back to exam_criteria.py")
                criteria_snapshot = None
        
        if not criteria_snapshot:
            # Fallback: usar exam_criteria.py (para correções antigas sem snapshot)
            from .exam_criteria import get_exam_criteria
            exam_type = submission_data.get('exam_type', 'enem').lower()
            criteria = get_exam_criteria(exam_type)
            
            current_exam = {
                'name': criteria.short_name,
                'max': criteria.max_score,
                'comp_note': f' ({len(criteria.competencies)} competências)'
            }
            competencies = criteria.competencies
            weights = criteria.weights
            logger.info(f"📌 Using exam_criteria.py fallback: {current_exam['name']}")
        
        # Build context with exam-specific competencies
        competencies_text = ""
        for i, comp_name in enumerate(competencies, 1):
            score = correction_data.get(f'competence_{i}_score', 0)
            max_score = int(weights[i-1]) if i <= len(weights) else 0
            competencies_text += f"\n• {comp_name}: {score}/{max_score} pts"
        
        context = f"""
INFORMAÇÕES DA REDAÇÃO:
- Título: {submission_data.get('title', 'Sem título')}
- Tema: {submission_data.get('theme', 'Não especificado')}
- Tipo de Exame: {current_exam['name']}
- Nota Total: {correction_data.get('total_score', 0)}/{current_exam['max']}{current_exam['comp_note']}

COMPETÊNCIAS AVALIADAS NESTA REDAÇÃO ({current_exam['name']}):
{competencies_text}

ATENÇÃO: Este vestibular tem {len(competencies)} competências!"""

        # Build system prompt specific to exam type
        # Criar lista de nomes mais curtos para o sistema
        short_comp_names = [c.split(':')[0] if ':' in c else c for c in competencies]
        
        system_prompt = f"""Você é o Prof. Redi, assistente especializado em redações para {current_exam['name']}.
Seu objetivo é ajudar o aluno a entender melhor sua correção ESPECÍFICA para este vestibular.

REGRAS CRÍTICAS:
- Este vestibular é {current_exam['name']}, NÃO é ENEM (a menos que seja ENEM/SISU)!
- As competências deste vestibular são APENAS: {', '.join(short_comp_names)}
- NUNCA mencione "Proposta de Intervenção" se não for ENEM/SISU
- NUNCA mencione pontuação de 200 pontos se não for ENEM/SISU
- A pontuação máxima por competência neste vestibular é {int(weights[0])} pontos
- A nota total máxima é {current_exam['max']} pontos

REGRAS GERAIS:
- Seja amigável, encorajador e didático
- Use exemplos concretos quando relevante
- Máximo 250 palavras por resposta
- Foque em ações práticas para melhorar
- Use emojis ocasionalmente (com moderação)
- Tom profissional mas acessível

{context}"""

        # Build messages for Groq
        messages = [
            {"role": "system", "content": system_prompt}
        ]
        
        # Add recent conversation history (last 6 messages)
        for msg in conversation_history[-6:]:
            if msg['role'] == 'user':
                messages.append({"role": "user", "content": msg['content']})
            elif msg['role'] == 'assistant' and 'Olá! Sou o Prof. Redi' not in msg['content']:
                messages.append({"role": "assistant", "content": msg['content']})
        
        # Add current user message
        messages.append({"role": "user", "content": user_message})
        
        # Generate response with Groq
        logger.info("Sending request to Groq...")
        response = client.chat.completions.create(
            model="llama-3.3-70b-versatile",  # Fast and capable model
            messages=messages,
            temperature=0.7,
            max_tokens=800,
            top_p=0.9
        )
        
        ai_response = response.choices[0].message.content
        logger.info(f"Groq response received: {len(ai_response)} chars")
        
        return ai_response
        
    except Exception as e:
        logger.error(f"Erro no AI tutor: {type(e).__name__}: {str(e)}")
        import traceback
        logger.error(traceback.format_exc())
        return (
            "Desculpe, tive um problema ao processar sua mensagem. "
            "Tente reformular ou aguarde um momento. 🤔"
        )



