"""
AI Service for Essay Correction - Multi-Provider Support
Supports: Groq, Gemini, HuggingFace, Together AI
"""

import json
import logging
import os
from typing import Optional

logger = logging.getLogger(__name__)

# Provider configurations
AI_PROVIDERS = {
    'groq': {
        'name': 'Groq',
        'env_var': 'GROQ_API_KEY',
        'default_model': 'llama-3.1-70b-versatile'
    },
    'gemini': {
        'name': 'Google Gemini',
        'env_var': 'GEMINI_API_KEY',
        'default_model': 'gemini-2.0-flash'
    },
    'huggingface': {
        'name': 'HuggingFace',
        'env_var': 'HF_TOKEN',
        'default_model': 'mistralai/Mixtral-8x7B-Instruct-v0.1'
    },
    'together':  {
        'name': 'Together AI',
        'env_var': 'TOGETHER_API_KEY',
        'default_model': 'meta-llama/Llama-3-70b-chat-hf'
    }
}

# Prompt universal para avaliação
# Prompt detalhado com critérios ENEM
CORRECTION_PROMPT = """Você é um corretor OFICIAL do ENEM. Analise esta redação seguindo RIGOROSAMENTE os critérios oficiais.

**CRITÉRIOS DE PONTUAÇÃO (0, 40, 80, 120, 160, 200 por competência):**

**COMPETÊNCIA 1 - Domínio da Norma Culta:**
- 200: Excelente domínio, desvios raríssimos
- 160: Bom domínio, poucos desvios leves
- 120: Domínio adequado, alguns desvios
- 80: Domínio mediano, desvios frequentes
- 40: Domínio insuficiente, muitos desvios
- 0: Domínio precário, graves problemas

**COMPETÊNCIA 2 - Compreensão do Tema:**
- 200: Desenvolvimento EXCELENTE do tema
- 160: Desenvolvimento BOM, tangenciando levemente
- 120: Desenvolvimento ADEQUADO do tema
- 80: Desenvolvimento mediano, tangencia em partes
- 40: Desenvolvimento insuficiente
- 0: Fuga total ao tema

**COMPETÊNCIA 3 - Argumentação:**
- 200: Argumentação EXCELENTE (autoral, consistente, repertório legitimado)
- 160: Argumentação BOA (consistente, bom repertório)
- 120: Argumentação ADEQUADA (previsível, repertório superficial)
- 80: Argumentação mediana (frágil, repertório limitado)
- 40: Argumentação insuficiente
- 0: Sem argumentação

**COMPETÊNCIA 4 - Coesão e Coerência:**
- 200: Articulação EXCELENTE de ideias
- 160: Articulação BOA
- 120: Articulação ADEQUADA
- 80: Articulação mediana, alguns problemas
- 40: Articulação insuficiente
- 0: Sem articulação

**COMPETÊNCIA 5 - Proposta de Intervenção:**
- 200: Proposta COMPLETA (5 elementos: ação, agente, modo, efeito, detalhamento)
- 160: Proposta com 4 elementos bem desenvolvidos
- 120: Proposta com 3 elementos ou 4 superficiais
- 80: Proposta com 2 elementos ou genérica
- 40: Proposta vaga/incompleta
- 0: Sem proposta

**IMPORTANTE:** 
- Seja CRITERIOSO: notas intermediárias (40, 80, 120, 160) são COMUNS
- Nota 200 é RARA (somente para textos excepcionais)
- Nota 0 é RARA (somente para problemas gravíssimos)
- A MAIORIA das redações fica entre 80-160 por competência

Retorne APENAS JSON neste formato:

{{
  "competence_1_score": 120,
  "competence_1_feedback": "Análise: [análise detalhada]\\n\\n✅ Pontos Fortes: [específicos]\\n\\n⚠️ O que melhorar: [específicos]",
  "competence_2_score": 160,
  "competence_2_feedback": "Análise: [análise detalhada]\\n\\n✅ Pontos Fortes: [específicos]\\n\\n⚠️ O que melhorar: [específicos]",
  "competence_3_score": 120,
  "competence_3_feedback": "Análise: [análise detalhada]\\n\\n✅ Pontos Fortes: [específicos]\\n\\n⚠️ O que melhorar: [específicos]",
  "competence_4_score": 80,
  "competence_4_feedback": "Análise: [análise detalhada]\\n\\n✅ Pontos Fortes: [específicos]\\n\\n⚠️ O que melhorar: [específicos]",
  "competence_5_score": 120,
  "competence_5_feedback": "Análise: [análise detalhada]\\n\\n✅ Pontos Fortes: [específicos]\\n\\n⚠️ O que melhorar: [específicos]",
  "total_score": 600,
  "strengths": ["Ponto forte específico 1", "Ponto forte específico 2"],
  "improvements": ["Melhoria específica 1", "Melhoria específica 2"],
  "general_comments": "Comentário geral construtivo."
}}

Texto:
Título: {title}
Tema: {theme}

{content}
"""


def get_active_provider() -> tuple[str, Optional[str]]:
    """
    Get active AI provider from database + environment.
    Returns: (provider_name, api_key)
    """
    from .database import SessionLocal
    from .models import Settings
    
    print("\n🔍 ==== CHECKING ACTIVE AI PROVIDER ====")
    
    # Get active provider from database
    db = SessionLocal()
    try:
        settings = db.query(Settings).first()
        if settings:
            active_provider = settings.active_ai_provider
            print(f"📊 Database says active provider: {active_provider}")
        else:
            active_provider = "groq"  # Default fallback
            print(f"⚠️ No settings in DB, using default: {active_provider}")
    finally:
        db.close()
    
    # Get API key from environment for the active provider
    if active_provider == "groq":
        groq_key = os.getenv('GROQ_API_KEY')
        print(f"GROQ_API_KEY present: {bool(groq_key)}")
        if groq_key:
            print(f"✅ Using GROQ provider with key: {groq_key[:20]}...")
            logger.info("Using Groq AI provider")
            return ('groq', groq_key)
        else:
            print("❌ Groq selected but no API key in .env!")
            logger.error("Groq selected but GROQ_API_KEY not configured in .env")
            return ('groq', None)
    
    elif active_provider == "gemini":
        gemini_key = os.getenv('GEMINI_API_KEY')
        print(f"GEMINI_API_KEY present: {bool(gemini_key)}")
        if gemini_key:
            print(f"✅ Using GEMINI provider")
            logger.info("Using Gemini AI provider")
            return ('gemini', gemini_key)
        else:
            print("❌ Gemini selected but no API key in .env!")
            logger.error("Gemini selected but GEMINI_API_KEY not configured in .env")
            return ('gemini', None)
    
    elif active_provider == "huggingface":
        hf_token = os.getenv('HF_TOKEN')
        print(f"HF_TOKEN present: {bool(hf_token)}")
        if hf_token:
            print(f"✅ Using HuggingFace provider")
            return ('huggingface', hf_token)
        else:
            print("❌ HuggingFace selected but no API key in .env!")
            return ('huggingface', None)
    
    elif active_provider == "together":
        together_key = os.getenv('TOGETHER_API_KEY')
        print(f"TOGETHER_API_KEY present: {bool(together_key)}")
        if together_key:
            print(f"✅ Using Together AI provider")
            return ('together', together_key)
        else:
            print("❌ Together selected but no API key in .env!")
            return ('together', None)
    
    # Unknown provider
    print(f"❌ Unknown provider in database: {active_provider}")
    logger.error(f"Unknown provider configured: {active_provider}")
    return (active_provider, None)


async def correct_with_groq(title: str, theme: str, content: str, api_key: str) -> dict:
    """Correct essay using Groq API"""
    try:
        from groq import Groq
        
        client = Groq(api_key=api_key)
        
        prompt = CORRECTION_PROMPT.format(title=title, theme=theme or "", content=content)
        
        print(f"📤 Sending to Groq: {title}")
        logger.info(f"Sending to Groq: {title}")
        
        response = client.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.7,  # Increased for more varied scoring
            max_tokens=2048
        )
        
        text = response.choices[0].message.content.strip()
        
        # Clean JSON
        if text.startswith("```json"):
            text = text[7:]
        if text.startswith("```"):
            text = text[3:]
        if text.endswith("```"):
            text = text[:-3]
        text = text.strip()
        
        data = json.loads(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        print(f"✅ Groq correction completed. Score: {data.get('total_score')}")
        logger.info(f"Groq correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        print(f"❌ Groq error: {e}")
        logger.error(f"Groq error: {e}")
        raise


async def correct_with_gemini(title: str, theme: str, content: str, api_key: str) -> dict:
    """Correct essay using Gemini API"""
    try:
        import google.generativeai as genai
        
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-2.0-flash')
        
        prompt = CORRECTION_PROMPT.format(title=title, theme=theme or "", content=content)
        
        logger.info(f"Sending to Gemini: {title}")
        
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
        
        # Check for safety block
        if hasattr(response, 'candidates') and len(response.candidates) > 0:
            if response.candidates[0].finish_reason == 2:
                logger.warning("Gemini blocked by safety")
                raise Exception("Blocked by safety filters")
        
        text = response.text.strip()
        
        # Clean JSON
        if text.startswith("```json"):
            text = text[7:]
        if text.startswith("```"):
            text = text[3:]
        if text.endswith("```"):
            text = text[:-3]
        text = text.strip()
        
        data = json.loads(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        logger.info(f"Gemini correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        logger.error(f"Gemini error: {e}")
        raise


async def correct_essay_with_gemini(title: str, theme: str, content: str) -> dict:
    """
    Main correction function - routes to active provider
    Maintains backward compatibility with existing code
    """
    provider, api_key = get_active_provider()
    
    if not api_key:
        raise Exception(f"API key not configured for provider: {provider}")
    
    print(f"🤖 Using AI provider: {AI_PROVIDERS[provider]['name']}")
    logger.info(f"Using AI provider: {AI_PROVIDERS[provider]['name']}")
    
    try:
        if provider == 'groq':
            return await correct_with_groq(title, theme, content, api_key)
        elif provider == 'gemini':
           return await correct_with_gemini(title, theme, content, api_key)
        elif provider == 'huggingface':
            # TODO: Implement HuggingFace
            raise Exception("HuggingFace provider not implemented yet")
        elif provider == 'together':
            # TODO: Implement Together AI
            raise Exception("Together AI provider not implemented yet")
        else:
            raise Exception(f"Unknown provider: {provider}")
            
    except Exception as e:
        # Log error and re-raise (no silent fallback)
        print(f"❌ AI correction failed: {e}")
        logger.error(f"AI correction failed: {e}")
        raise Exception(f"Falha na correção com {provider}: {str(e)}. Verifique se a API key está configurada corretamente.")


async def generate_theme_with_gemini(category: str) -> str:
    """Generate theme using active provider"""
    provider, api_key = get_active_provider()
    
    if provider == 'groq' and api_key:
        try:
            from groq import Groq
            client = Groq(api_key=api_key)
            response = client.chat.completions.create(
                model="llama-3.1-70b-versatile",
                messages=[{"role": "user", "content": f"Gere um tema dissertativo sobre {category}. Máximo 15 palavras. Responda APENAS o tema, sem aspas."}],
                temperature=0.8,
                max_tokens=100
            )
            return response.choices[0].message.content.strip().replace('"', '').replace("'", "")
        except:
            pass
    
    # Fallback themes
    return {
        'geral': 'A importância da educação no Brasil contemporâneo',
        'educacao': 'Desafios da formação de professores no Brasil',
        'tecnologia': 'O impacto da inteligência artificial na sociedade',
        'meio_ambiente': 'Sustentabilidade e desenvolvimento econômico',
        'sociedade': 'A importância do diálogo na resolução de conflitos',
        'saude': 'Desafios do sistema de saúde pública no Brasil'
    }.get(category, 'A educação como instrumento de transformação social')
# Add these lines at the end of ai_service.py after line 350

# ===== PREMIUM CORRECTION FUNCTIONS =====

# Refinement prompt
REFINEMENT_PROMPT = """Você é um ESPECIALISTA PREMIUM em redação ENEM nota 1000.

Recebeu esta correção inicial:

**NOTAS:**
Competência 1: {comp1_score}/200
Competência 2: {comp2_score}/200
Competência 3: {comp3_score}/200
Competência 4: {comp4_score}/200
Competência 5: {comp5_score}/200

Para CADA competência, adicione insights premium com:
1. Exemplos práticos do texto
2. Como redações nota 1000 fazem
3. Sugestão estratégica avançada

Retorne JSON:
{{
  "competence_1_premium_insights": "...",
  "competence_2_premium_insights": "...",
  "competence_3_premium_insights": "...",
  "competence_4_premium_insights": "...",
  "competence_5_premium_insights": "...",
  "general_premium_insights": "Visão estratégica geral"
}}

Texto:
{content}
"""


async def refine_with_gemini(title: str, theme: str, content: str, groq_result: dict, api_key: str) -> dict:
    """Refine Groq correction with Gemini premium insights"""
    try:
        import google.generativeai as genai
        
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-2.0-flash')
        
        # Prepare prompt
        prompt = REFINEMENT_PROMPT.format(
            comp1_score=groq_result.get('competence_1_score', 0),
            comp2_score=groq_result.get('competence_2_score', 0),
            comp3_score=groq_result.get('competence_3_score', 0),
            comp4_score=groq_result.get('competence_4_score', 0),
            comp5_score=groq_result.get('competence_5_score', 0),
            content=content
        )
        
        print(f"📤 Sending to Gemini for refinement...")
        response = model.generate_content(prompt)
        text = response.text.strip()
        
        # Clean JSON
        if text.startswith("```json"):
            text = text[7:]
        if text.startswith("```"):
            text = text[3:]
        if text.endswith("```"):
            text = text[:-3]
        text = text.strip()
        
        insights = json.loads(text)
        print(f"✅ Gemini refinement completed")
        return insights
        
    except Exception as e:
        print(f"❌ Gemini refinement error: {e}")
        # Return empty insights if fails
        return {f"competence_{i}_premium_insights": "" for i in range(1, 6)}


def combine_corrections(groq_result: dict, gemini_insights: dict) -> dict:
    """Combine Groq scores/feedback with Gemini premium insights"""
    combined = groq_result.copy()
    
    # Add premium insights to each competence feedback
    for i in range(1, 6):
        feedback_key = f"competence_{i}_feedback"
        insights_key = f"competence_{i}_premium_insights"
        
        if feedback_key in combined and insights_key in gemini_insights:
            insight = gemini_insights.get(insights_key, "")
            if insight:
                # Append premium insights
                combined[feedback_key] += f"\n\n💎 **Insights Premium:**\n{insight}"
    
    # Add general premium insights
    if "general_premium_insights" in gemini_insights:
        combined['general_comments'] += f"\n\n💎 **Análise Premium:**\n{gemini_insights['general_premium_insights']}"
    
    return combined


async def correct_essay_premium(title: str, theme: str, content: str, api_key_groq: str, api_key_gemini: str) -> dict:
    """
    Premium correction: Groq (initial) + Gemini (refinement)
    """
    print("🌟 === PREMIUM CORRECTION (Groq + Gemini) ===")
    
    # Step 1: Groq initial correction
    print("Step 1/3: Groq initial correction...")
    groq_result = await correct_with_groq(title, theme, content, api_key_groq)
    
    # Step 2: Gemini refinement
    print("Step 2/3: Gemini refinement...")
    gemini_insights = await refine_with_gemini(title, theme, content, groq_result, api_key_gemini)
    
    # Step 3: Combine
    print("Step 3/3: Combining corrections...")
    final_result = combine_corrections(groq_result, gemini_insights)
    
    print(f"✅ Premium correction completed. Score: {final_result.get('total_score')}")
    return final_result
