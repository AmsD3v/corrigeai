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
        
        # Map exam types to names and max scores (critérios verificados oficialmente)
        exam_info = {
            # Principais (critérios próprios)
            'enem': {'name': 'ENEM', 'max': 1000, 'comp_note': ' (5 competências x 200 pontos)'},
            'fuvest': {'name': 'FUVEST (USP)', 'max': 50, 'comp_note': ' (4 comp x 12.5)'},
            'unicamp': {'name': 'UNICAMP', 'max': 48, 'comp_note': ' (5 comp x 9.6)'},
            'ita': {'name': 'ITA', 'max': 100, 'comp_note': ''},
            'unesp': {'name': 'UNESP', 'max': 100, 'comp_note': ''},
            'uerj': {'name': 'UERJ', 'max': 100, 'comp_note': ' (3 critérios)'},
            'ufmg': {'name': 'UFMG', 'max': 100, 'comp_note': ''},
            'afa': {'name': 'AFA', 'max': 100, 'comp_note': ''},
            'cacd': {'name': 'CACD (Diplomacia)', 'max': 100, 'comp_note': ' - NÍVEL AVANÇADO'},
            'sisu': {'name': 'SISU (usa ENEM)', 'max': 1000, 'comp_note': ' (5 competências x 200 pontos)'},
            # Vestibulares próprios verificados
            'unb': {'name': 'UnB', 'max': 10, 'comp_note': ' (sistema único)'},
            'ufpr': {'name': 'UFPR', 'max': 60, 'comp_note': ' (3 questões x 20 pts)'},
            'ufrgs': {'name': 'UFRGS', 'max': 30, 'comp_note': ' (holístico + analítico)'},
            'ufsc': {'name': 'UFSC', 'max': 10, 'comp_note': ' (4 critérios x 2.5)'},
            # Federais via SISU (usam nota ENEM = 1000)
            'ufac': {'name': 'UFAC (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'unifap': {'name': 'UNIFAP (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufam': {'name': 'UFAM (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufpa': {'name': 'UFPA (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'unir': {'name': 'UNIR (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufrr': {'name': 'UFRR (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'uft': {'name': 'UFT (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'uerr': {'name': 'UERR', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufal': {'name': 'UFAL (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufba': {'name': 'UFBA (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufc': {'name': 'UFC (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufma': {'name': 'UFMA (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufpb': {'name': 'UFPB (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufpe': {'name': 'UFPE (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufpi': {'name': 'UFPI (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufrn': {'name': 'UFRN (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufs': {'name': 'UFS (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'udf': {'name': 'UDF', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufg': {'name': 'UFG (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufmt': {'name': 'UFMT (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufms': {'name': 'UFMS (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            'ufes': {'name': 'UFES (via SISU)', 'max': 1000, 'comp_note': ' - critérios ENEM'},
            # PUCs (critérios próprios)
            'pucsp': {'name': 'PUC-SP', 'max': 100, 'comp_note': ' (5 critérios próprios)'},
            'puccampinas': {'name': 'PUC-Campinas', 'max': 100, 'comp_note': ''},
            'pucminas': {'name': 'PUC-Minas', 'max': 10, 'comp_note': ' (0-10 pts)'},
            'pucpr': {'name': 'PUCPR', 'max': 10, 'comp_note': ' (4+2+2+2 = 10 pts)'},
            'pucrio': {'name': 'PUC-Rio', 'max': 100, 'comp_note': ' (holístico)'},
            'pucgoias': {'name': 'PUC-Goiás', 'max': 100, 'comp_note': ''},
            'pucrs': {'name': 'PUCRS', 'max': 100, 'comp_note': ' (3 critérios)'}
        }
        
        exam_type = submission_data.get('exam_type', 'enem').lower()
        current_exam = exam_info.get(exam_type, exam_info['enem'])
        
        # Competências ENEM (usadas por federais via SISU)
        enem_competencies = ['Domínio da Norma Culta', 'Compreensão do Tema', 'Argumentação', 'Coesão e Coerência', 'Proposta de Intervenção']
        enem_weights = [200, 200, 200, 200, 200]
        
        # Competências e pesos para cada vestibular
        EXAM_COMPETENCIES = {
            'enem': enem_competencies,
            'sisu': enem_competencies,
            'fuvest': ['Desenvolvimento do Tema', 'Estrutura e Organização', 'Expressão e Gramática', 'Coesão e Coerência'],
            'unicamp': ['Adequação ao Gênero', 'Compreensão da Proposta', 'Propósito Comunicativo', 'Articulação de Ideias', 'Adequação Linguística'],
            'ita': ['Argumentação Técnica', 'Rigor Lógico', 'Conhecimento Técnico', 'Organização Textual', 'Domínio da Norma Culta'],
            'unesp': ['Tema', 'Estrutura e Coesão', 'Expressão', 'Autoria e Originalidade', 'Conhecimento de Mundo'],
            'uerj': ['Adequação ao Tema/Gênero', 'Articulação Textual', 'Domínio da Língua'],
            'ufmg': ['Abordagem do Tema', 'Articulação Argumentativa', 'Uso de Informações', 'Domínio da Norma Culta'],
            'afa': ['Adequação ao Tema', 'Clareza e Objetividade', 'Coerência e Coesão', 'Argumentação Lógica', 'Domínio da Norma Culta'],
            'cacd': ['Aprofundamento Temático', 'Argumentação Sofisticada', 'Domínio da Norma Culta', 'Articulação de Ideias', 'Perspectiva Geopolítica'],
            # Vestibulares próprios
            'unb': ['Macroestrutura (tema, coerência)', 'Microestrutura (gramática, vocabulário)'],
            'ufpr': ['Questão 1', 'Questão 2', 'Questão 3'],
            'ufrgs': ['Aspecto Analítico', 'Aspecto Holístico', 'Expressão Linguística'],
            'ufsc': ['Adequação à Proposta', 'Norma Padrão', 'Coerência e Coesão', 'Informatividade'],
            # PUCs
            'pucsp': ['Tipo de Texto', 'Adequação ao Tema', 'Coerência', 'Coesão', 'Norma Padrão'],
            'pucrs': ['Conteúdo', 'Estrutura', 'Expressão Linguística'],
            'pucrio': ['Estrutura Temática', 'Norma Padrão', 'Coerência e Reflexão Crítica'],
            'pucminas': ['Coerência e Coesão', 'Correção Gramatical', 'Compreensão da Proposta'],
            'pucpr': ['Qualidade de Conteúdo', 'Progressão e Coerência', 'Coesão', 'Norma Padrão']
        }
        
        EXAM_WEIGHTS = {
            'enem': enem_weights,
            'sisu': enem_weights,
            'fuvest': [12.5, 12.5, 12.5, 12.5],
            'unicamp': [9.6, 9.6, 9.6, 9.6, 9.6],
            'ita': [20, 20, 20, 20, 20],
            'unesp': [20, 20, 20, 20, 20],
            'uerj': [33.3, 33.3, 33.4],
            'ufmg': [25, 25, 25, 25],
            'afa': [20, 20, 20, 20, 20],
            'cacd': [20, 20, 20, 20, 20],
            # Vestibulares próprios
            'unb': [5, 5],
            'ufpr': [20, 20, 20],
            'ufrgs': [10, 10, 10],
            'ufsc': [2.5, 2.5, 2.5, 2.5],
            # PUCs
            'pucsp': [20, 20, 20, 20, 20],
            'pucrs': [40, 30, 30],
            'pucrio': [40, 30, 30],
            'pucminas': [3.5, 3.5, 3],
            'pucpr': [4, 2, 2, 2]
        }
        
        # Para federais via SISU, usa competências/pesos do ENEM
        if exam_type in ['ufac', 'unifap', 'ufam', 'ufpa', 'unir', 'ufrr', 'uft', 'uerr', 
                         'ufal', 'ufba', 'ufc', 'ufma', 'ufpb', 'ufpe', 'ufpi', 'ufrn', 
                         'ufs', 'udf', 'ufg', 'ufmt', 'ufms', 'ufes']:
            competencies = enem_competencies
            weights = enem_weights
        else:
            competencies = EXAM_COMPETENCIES.get(exam_type, enem_competencies)
            weights = EXAM_WEIGHTS.get(exam_type, enem_weights)
        
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

ATENÇÃO: Este vestibular tem {len(competencies)} competências, NÃO 5 como no ENEM!"""

        # Build system prompt specific to exam type
        system_prompt = f"""Você é o Prof. Redi, assistente especializado em redações para {current_exam['name']}.
Seu objetivo é ajudar o aluno a entender melhor sua correção ESPECÍFICA para este vestibular.

REGRAS CRÍTICAS:
- Este vestibular é {current_exam['name']}, NÃO é ENEM!
- As competências deste vestibular são APENAS: {', '.join(competencies)}
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



