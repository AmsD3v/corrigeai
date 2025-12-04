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
    Get AI tutor response for essay correction questions using Groq
    
    Args:
        user_message: User's question
        submission_data: Dict with submission info (title, theme, content, exam_type)
        correction_data: Dict with correction scores and feedback
        conversation_history: List of previous messages [{role, content, timestamp}]
        
    Returns:
        AI tutor response text
    """
    try:
        # Check API key
        groq_key = settings.GROQ_API_KEY
        if not groq_key or groq_key == "placeholder_key":
            logger.error("GROQ_API_KEY not configured for AI Tutor")
            return (
                "Desculpe, o Professor IA não está configurado no momento. "
                "Entre em contato com o suporte. 🤖"
            )
        
        logger.info(f"AI Tutor request: {user_message[:50]}...")
        
        # Import Groq
        from groq import Groq
        client = Groq(api_key=groq_key)
        
        # Build context
        context = f"""
INFORMAÇÕES DA REDAÇÃO:
- Título: {submission_data.get('title', 'Sem título')}
- Tema: {submission_data.get('theme', 'Não especificado')}
- Tipo de Exame: {submission_data.get('exam_type', 'ENEM')}
- Nota Total: {correction_data.get('total_score', 0)}/1000

COMPETÊNCIAS:
1. Domínio da Norma Culta - Nota: {correction_data.get('competence_1_score', 0)}/200
2. Compreensão do Tema - Nota: {correction_data.get('competence_2_score', 0)}/200  
3. Argumentação - Nota: {correction_data.get('competence_3_score', 0)}/200
4. Coesão e Coerência - Nota: {correction_data.get('competence_4_score', 0)}/200
5. Proposta de Intervenção - Nota: {correction_data.get('competence_5_score', 0)}/200
"""

        # Build system prompt
        system_prompt = f"""Você é o Prof. Redi, assistente especializado em redações do ENEM e vestibulares.
Seu objetivo é ajudar o aluno a entender melhor sua correção.

REGRAS:
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



