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
