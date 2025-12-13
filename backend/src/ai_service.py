"""
AI Service for Essay Correction - Multi-Provider Support
Supports: Groq, Gemini, HuggingFace, Together AI
"""

import json
import logging
import os
import asyncio
import re
from typing import Optional

logger = logging.getLogger(__name__)

def extract_json_robust(text: str) -> dict:
    """
    Extrai JSON de uma string de forma robusta, buscando o primeiro '{' e o último '}'.
    Remove blocos de código markdown se houver.
    """
    text = text.strip()
    
    # Remove blocos de código markdown ```json ... ```
    if "```" in text:
        # Tenta extrair conteúdo dentro de ```json ou apenas ```
        match = re.search(r"```(?:json)?(.*?)```", text, re.DOTALL)
        if match:
            text = match.group(1).strip()
            
    # Encontra o primeiro '{' e o último '}'
    start = text.find('{')
    end = text.rfind('}')
    
    if start != -1 and end != -1:
        json_str = text[start:end+1]
        try:
            return json.loads(json_str)
        except json.JSONDecodeError as e:
            logger.error(f"Erro ao decodificar JSON extraído: {e}")
            # Tenta limpar vírgulas finais (trailing commas) que o JSON padrão não aceita
            try:
                json_str_clean = re.sub(r",\s*}", "}", json_str)
                json_str_clean = re.sub(r",\s*]", "]", json_str_clean)
                return json.loads(json_str_clean)
            except:
                pass
            raise ValueError(f"Falha ao extrair JSON válido. Texto: {text[:100]}...")
    
    raise ValueError("Nenhum objeto JSON encontrado na resposta da IA")

async def retry_with_backoff(func, *args, max_retries=3, initial_delay=1, **kwargs):
    """
    Executa uma função async com retry e backoff exponencial.
    """
    delay = initial_delay
    last_exception = None
    
    for attempt in range(max_retries):
        try:
            return await func(*args, **kwargs)
        except Exception as e:
            last_exception = e
            logger.warning(f"Tentativa {attempt+1}/{max_retries} falhou: {str(e)}. Retentando em {delay}s...")
            if attempt < max_retries - 1:
                await asyncio.sleep(delay)
                delay *= 2  # Backoff exponencial
    
    logger.error(f"Todas as {max_retries} tentativas falharam.")
    raise last_exception

# Provider configurations
AI_PROVIDERS = {
    'groq': {
        'name': 'Groq',
        'env_var': 'GROQ_API_KEY',
        'default_model': 'llama-3.3-70b-versatile'
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

# Prompt aprimorado com calibração e critérios objetivos
CORRECTION_PROMPT = """Você é um corretor OFICIAL do ENEM. Analise esta redação seguindo RIGOROSAMENTE os critérios oficiais.

**📊 ESCALA DE CALIBRAÇÃO (distribuição estatística típica):**
- 200 pontos: <5% das redações (texto excepcional, referência nacional)
- 160 pontos: 15-20% (texto muito bom, acima da média)
- 120 pontos: 40-50% (texto adequado, dentro do esperado) ← FAIXA MAIS COMUM
- 80 pontos: 20-25% (texto mediano, abaixo do esperado)
- 40 pontos: 5-10% (texto insuficiente, problemas sérios)
- 0 pontos: <2% (texto inadequado, problemas gravíssimos)

**📝 CHECKLIST OBRIGATÓRIO ANTES DE PONTUAR:**

Para CADA competência, você DEVE verificar objetivamente:

**C1 - Norma Culta:**
□ Quantos erros de ortografia? ___
□ Quantos erros de pontuação? ___
□ Quantos erros de concordância? ___
□ Quantos erros de regência? ___
→ 0-2 erros = 160-200 | 3-5 erros = 120-160 | 6-10 erros = 80-120 | 11+ erros = 40-80

**C2 - Compreensão do Tema:**
□ O tema foi compreendido corretamente? (Sim/Não)
□ Há tangenciamento? (Não/Leve/Moderado/Grave)
□ Desenvolvimento: (Superficial/Adequado/Aprofundado)
→ Completo = 160-200 | Adequado = 120-160 | Tangente leve = 80-120

**C3 - Argumentação:**
□ Quantos argumentos bem desenvolvidos? ___
□ Há repertório sociocultural? (Não/Superficial/Legitimado)
□ Argumentação é autoral ou genérica?
→ 3+ argumentos + repertório legitimado = 160-200 | 2 argumentos adequados = 120-160 | 1-2 argumentos fracos = 80-120

**C4 - Coesão:**
□ Quantos conectivos ADEQUADOS usados? ___
□ Há problemas de coerência? (Não/Leve/Grave)
□ Progressão textual: (Excelente/Boa/Adequada/Problemática)
→ 8+ conectivos variados = 160-200 | 5-7 conectivos = 120-160 | 3-4 conectivos = 80-120

**C5 - Proposta de Intervenção:**
□ AÇÃO detalhada? (Sim/Não)
□ AGENTE claro? (Sim/Não)
□ MODO/MEIO especificado? (Sim/Não)
□ EFEITO/FINALIDADE clara? (Sim/Não)
□ DETALHAMENTO suficiente? (Sim/Não)
→ 5 elementos = 200 | 4 elementos = 160 | 3 elementos = 120 | 2 elementos = 80

**🎓 EXEMPLOS DE CALIBRAÇÃO (few-shot learning):**

EXEMPLO 1 - Redação nota 840 (168 média):
"A tecnologia como ponte para a inclusão digital no Brasil"
- C1: 160pts (2 desvios leves de pontuação)
- C2: 180pts (tema muito bem desenvolvido, perspectiva crítica)
- C3: 160pts (2 argumentos sólidos, repertório de sociólogos)
- C4: 180pts (progressão clara, 9 conectivos variados)
- C5: 160pts (4 dos 5 elementos: ação+agente+modo+efeito)
Características: linguagem fluida, repertório legitimado, estrutura clara, proposta viável.

EXEMPLO 2 - Redação nota 600 (120 média):
"Os desafios da mobilidade urbana nas grandes cidades"
- C1: 120pts (5 desvios: concordância e acentuação)
- C2: 120pts (tema adequadamente desenvolvido, sem aprofundamento)
- C3: 120pts (2 argumentos previsíveis, repertório superficial)
- C4: 120pts (5 conectivos, alguns repetidos)
- C5: 120pts (3 elementos: ação+agente+modo)
Características: linguagem simples, argumentos genéricos, estrutura básica, proposta incompleta.

EXEMPLO 3 - Redação nota 400 (80 média):
"A importancia da educaçao finanseira"
- C1: 80pts (10 erros: ortografia, acentuação, concordância)
- C2: 80pts (tangenciamento moderado do tema)
- C3: 80pts (1 argumento desenvolvido, sem repertório)
- C4: 80pts (3 conectivos básicos, repetição de ideias)
- C5: 80pts (2 elementos vagos: ação+agente genéricos)
Características: erros frequentes, pouco desenvolvimento, estrutura frágil, proposta vaga.

**⚠️ DIRETRIZES CRÍTICAS:**
1. Seja OBJETIVO: conte erros, conectivos, argumentos
2. Seja CONSISTENTE: use a escala de calibração
3. Seja JUSTO: notas 120-160 são NORMAIS, não tenha medo de usá-las
4. Seja CRITERIOSO: nota 200 exige perfeição quase absoluta
5. EVITE: dar sempre a mesma nota ou notas muito extremas

**📝 REGRAS OBRIGATÓRIAS PARA FEEDBACKS:**

1. **strengths** DEVE conter EXATAMENTE 5 itens (um por competência). MESMO que a redação seja fraca, encontre aspectos positivos relativos. NUNCA deixe vazio ou com menos de 5 itens.
   - Exemplo fraco: "C1: Apesar dos erros, o vocabulário básico é adequado para a comunicação"
   
2. **improvements** DEVE conter EXATAMENTE 5 itens (um por competência), citando trechos específicos do texto.
   - Exemplo: "C1: No trecho 'a desinformação é um problema muito ruim', substituir por vocabulário mais preciso"

3. **general_comments** DEVE ter no MÍNIMO 150 palavras em 3 parágrafos: (1) análise geral, (2) qualidades, (3) sugestões práticas.

4. PROIBIDO usar:
   - "Nenhum ponto forte identificado"
   - "N/A" ou "N/F"
   - Arrays vazios []
   - Frases genéricas sem especificidade

Retorne APENAS JSON válido:

```json
{{
  "competence_1_score": 120,
  "competence_1_feedback": "📊 Análise: Foram identificados X erros de ortografia e Y erros de pontuação.\\n\\n✅ Pontos Fortes: O vocabulário básico está adequado e há poucas repetições.\\n\\n⚠️ O que melhorar: Revisar a concordância em 'os problema' e a pontuação após conectivos.",
  "competence_2_score": 120,
  "competence_2_feedback": "📊 Análise: O tema foi abordado de forma superficial.\\n\\n✅ Pontos Fortes: Há uma tentativa de contextualização inicial.\\n\\n⚠️ O que melhorar: Desenvolver mais a relação causa-efeito do problema apresentado.",
  "competence_3_score": 80,
  "competence_3_feedback": "📊 Análise: Apresenta 1 argumento pouco desenvolvido.\\n\\n✅ Pontos Fortes: Há menção a uma causa do problema.\\n\\n⚠️ O que melhorar: Adicionar dados estatísticos ou citações de especialistas.",
  "competence_4_score": 80,
  "competence_4_feedback": "📊 Análise: Poucos conectivos identificados (3).\\n\\n✅ Pontos Fortes: Uso correto de 'além disso' para progressão.\\n\\n⚠️ O que melhorar: Diversificar conectivos, evitando repetição de 'portanto'.",
  "competence_5_score": 120,
  "competence_5_feedback": "📊 Análise: Proposta incompleta (2 de 5 elementos).\\n\\n✅ Pontos Fortes: Menciona uma ação governamental.\\n\\n⚠️ O que melhorar: Especificar o agente (quem fará), o modo (como fará) e o efeito esperado.",
  "total_score": 520,
  "strengths": [
    "C1: Apesar de alguns erros gramaticais, demonstra capacidade de escrita formal com vocabulário adequado ao gênero dissertativo",
    "C2: Demonstra compreensão do tema central, mesmo que superficial, identificando corretamente a problemática apresentada",
    "C3: Apresenta tentativa de argumentação com menção a causas do problema, indicando potencial para desenvolvimento",
    "C4: Utiliza alguns conectivos adequadamente, mostrando noção de progressão textual entre parágrafos",
    "C5: Propõe uma solução, ainda que incompleta, demonstrando entendimento da necessidade de intervenção social"
  ],
  "improvements": [
    "C1: No trecho 'os problema da sociedade atual', corrigir para 'os problemas'. Revisar também a pontuação após 'Portanto'",
    "C2: Aprofundar a discussão sobre o tema, explicando COMO e POR QUE o problema afeta a sociedade brasileira",
    "C3: Adicionar pelo menos mais um argumento com repertório sociocultural (dados do IBGE, citação de filósofos, exemplos históricos)",
    "C4: Substituir a terceira ocorrência de 'além disso' por conectivos variados como 'outrossim', 'ademais' ou 'sob essa ótica'",
    "C5: Completar a proposta de intervenção especificando: QUEM executará (agente), COMO será feito (modo), e QUAL o resultado esperado (efeito)"
  ],
  "general_comments": "Sua redação apresenta uma estrutura básica de texto dissertativo-argumentativo, com introdução, desenvolvimento e conclusão. Você demonstra compreensão do tema proposto e consegue articular ideias de forma coerente, o que é um bom ponto de partida.\\n\\nEntre os pontos positivos, destaca-se sua capacidade de manter o foco no tema e de propor uma solução para o problema. A escrita é clara e você utiliza vocabulário adequado ao gênero, ainda que com alguns deslizes gramaticais que podem ser facilmente corrigidos com revisão.\\n\\nPara melhorar sua nota, sugiro: (1) revisar o texto em voz alta para identificar erros de concordância e pontuação; (2) adicionar dados estatísticos ou citações de pensadores para enriquecer a argumentação; e (3) detalhar sua proposta de intervenção com os 5 elementos exigidos - ação, agente, modo, efeito e detalhamento. Continue praticando que você está no caminho certo para alcançar notas mais altas!"
}}
```

**REDAÇÃO A AVALIAR:**

Título: {title}
Tema: {theme}

{content}
"""


def get_active_provider() -> tuple[str, Optional[str]]:
    """
    Get active AI provider from database + environment.
    Returns: (provider_name, api_key)
    """
    from .database import SessionLocal, init_db_engine
    from .models import Settings
    
    print("\n🔍 ==== CHECKING ACTIVE AI PROVIDER ====")
    
    # Ensure SessionLocal is initialized
    if SessionLocal is None:
        print("⚠️ SessionLocal not initialized, initializing now...")
        init_db_engine()
        # Re-import after initialization
        from .database import SessionLocal as SL
    else:
        SL = SessionLocal
    
    # Get correction provider and key from database
    db = SL()
    try:
        settings = db.query(Settings).first()
        if settings:
            active_provider = getattr(settings, 'correction_provider', None) or settings.active_ai_provider
            correction_api_key = getattr(settings, 'correction_api_key', None) or ''
            print(f"📊 Database correction_provider: {active_provider}")
            print(f"🔑 Correction API key configured: {bool(correction_api_key)}")
        else:
            active_provider = "groq"
            correction_api_key = ''
            print(f"⚠️ No settings in DB, using default: {active_provider}")
    finally:
        db.close()
    
    # Usar chave do banco ou fallback para variáveis de ambiente
    if active_provider == "groq":
        api_key = correction_api_key or os.getenv('GROQ_API_KEY')
        if api_key:
            print(f"✅ Using GROQ provider")
            logger.info("Using Groq AI provider")
            return ('groq', api_key)
        else:
            print("❌ Groq selected but no API key!")
            logger.error("Groq selected but no API key configured")
            return ('groq', None)
    
    elif active_provider == "gemini":
        api_key = correction_api_key or os.getenv('GEMINI_API_KEY')
        if api_key:
            print(f"✅ Using GEMINI provider")
            logger.info("Using Gemini AI provider")
            return ('gemini', api_key)
        else:
            print("❌ Gemini selected but no API key!")
            logger.error("Gemini selected but no API key configured")
            return ('gemini', None)
    
    elif active_provider == "huggingface":
        api_key = correction_api_key or os.getenv('HF_TOKEN')
        if api_key:
            print(f"✅ Using HuggingFace provider")
            return ('huggingface', api_key)
        else:
            print("❌ HuggingFace selected but no API key!")
            return ('huggingface', None)
    
    elif active_provider == "together":
        api_key = correction_api_key or os.getenv('TOGETHER_API_KEY')
        if api_key:
            print(f"✅ Using Together AI provider")
            return ('together', api_key)
        else:
            print("❌ Together selected but no API key!")
            return ('together', None)
    
    elif active_provider == "cerebras":
        api_key = correction_api_key or os.getenv('CEREBRAS_API_KEY')
        if api_key:
            print(f"🧠 Using Cerebras provider")
            return ('cerebras', api_key)
        else:
            print("❌ Cerebras selected but no API key!")
            return ('cerebras', None)
    
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
            temperature=0.2,  # Low temperature for consistent scoring
            max_tokens=4096
        )
        
        text = response.choices[0].message.content.strip()
        
        data = extract_json_robust(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        print(f"✅ Groq correction completed. Score: {data.get('total_score')}")
        logger.info(f"Groq correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        print(f"❌ Groq error: {e}")
        logger.error(f"Groq error: {e}")
        raise


async def correct_with_cerebras(title: str, theme: str, content: str, api_key: str) -> dict:
    """Correct essay using Cerebras API (OpenAI-compatible)"""
    try:
        from openai import OpenAI
        
        # Cerebras usa API compatível com OpenAI
        client = OpenAI(
            api_key=api_key,
            base_url="https://api.cerebras.ai/v1"
        )
        
        prompt = CORRECTION_PROMPT.format(title=title, theme=theme or "", content=content)
        
        print(f"🧠 Sending to Cerebras: {title}")
        logger.info(f"Sending to Cerebras: {title}")
        
        response = client.chat.completions.create(
            model="llama-3.3-70b",  # Cerebras Llama 3.3 70B
            messages=[{"role": "user", "content": prompt}],
            temperature=0.2,
            max_tokens=2048
        )
        
        text = response.choices[0].message.content.strip()
        
        data = extract_json_robust(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        print(f"✅ Cerebras correction completed. Score: {data.get('total_score')}")
        logger.info(f"Cerebras correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        print(f"❌ Cerebras error: {e}")
        logger.error(f"Cerebras error: {e}")
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
            generation_config=genai.GenerationConfig(temperature=0.1, max_output_tokens=4096),
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
        
        data = extract_json_robust(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        logger.info(f"Gemini correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        logger.error(f"Gemini error: {e}")
        raise


async def correct_essay_with_gemini(title: str, theme: str, content: str, exam_type: str = 'enem') -> dict:
    """
    Main correction function - routes to active provider
    Maintains backward compatibility with existing code
    """
    provider, api_key = get_active_provider()
    
    if not api_key:
        raise Exception(f"API key not configured for provider: {provider}")
    
    print(f"🤖 Using AI provider: {AI_PROVIDERS[provider]['name']}")
    logger.info(f"Using AI provider: {AI_PROVIDERS[provider]['name']}")
    
    # Define wrapper functions for retry
    async def run_groq():
        # Import prompt_builder to use specific prompts
        from .prompt_builder import create_correction_prompt
        prompt = create_correction_prompt(exam_type, title, theme, content)
        return await correct_with_groq_custom_prompt(
            title, theme, content, api_key, prompt, model="llama-3.1-8b-instant"
        )
        
    async def run_gemini():
        # Import prompt_builder to use specific prompts
        from .prompt_builder import create_correction_prompt
        prompt = create_correction_prompt(exam_type, title, theme, content)
        return await correct_with_gemini_custom_prompt(title, theme, content, api_key, prompt)

    try:
        if provider == 'groq':
            return await retry_with_backoff(run_groq, max_retries=3)
        elif provider == 'gemini':
           return await retry_with_backoff(run_gemini, max_retries=3)
        elif provider == 'cerebras':
            async def run_cerebras():
                from .prompt_builder import create_correction_prompt
                prompt = create_correction_prompt(exam_type, title, theme, content)
                return await correct_with_cerebras_custom_prompt(title, theme, content, api_key, prompt)
            return await retry_with_backoff(run_cerebras, max_retries=3)
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
                model="llama-3.3-70b-versatile",
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

# ===== PREMIUM CORRECTION FUNCTIONS =====

def create_refinement_prompt(exam_type: str, groq_result: dict, content: str) -> str:
    """
    Cria prompt de refinement dinâmico baseado em exam_criteria.py.
    Isso garante que Premium funcione corretamente para todos os vestibulares.
    """
    from .exam_criteria import get_exam_criteria
    criteria = get_exam_criteria(exam_type)
    
    # Formata competências com pesos corretos do vestibular
    comp_scores = []
    for i, comp in enumerate(criteria.competencies, 1):
        score = groq_result.get(f'competence_{i}_score', 0)
        max_score = int(criteria.weights[i-1])
        comp_scores.append(f"Competência {i} ({comp}): {score}/{max_score}")
    
    # Gera campos JSON dinamicamente baseado no número de competências
    num_comps = len(criteria.competencies)
    json_fields = ",\n  ".join([f'"competence_{i}_premium_insights": "..."' for i in range(1, num_comps+1)])
    
    return f"""Você é um ESPECIALISTA PREMIUM em redação {criteria.short_name}.

Recebeu esta correção inicial para o vestibular {criteria.short_name} (nota máxima: {criteria.max_score}):

**NOTAS:**
{chr(10).join(comp_scores)}

Para CADA competência avaliada, adicione insights premium específicos para {criteria.short_name} com:
1. Exemplos práticos extraídos do texto
2. Como redações excelentes deste vestibular fazem
3. Sugestão estratégica avançada

Retorne JSON:
{{
  {json_fields},
  "general_premium_insights": "Visão estratégica geral para {criteria.short_name}"
}}

Texto:
{content}
"""


async def refine_with_gemini(title: str, theme: str, content: str, groq_result: dict, api_key: str, exam_type: str = 'enem') -> dict:
    """Refine Groq correction with Gemini premium insights - suporta multi-vestibular"""
    try:
        import google.generativeai as genai
        from .exam_criteria import get_exam_criteria
        
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-2.0-flash')
        
        # Usar prompt dinâmico baseado em exam_type
        prompt = create_refinement_prompt(exam_type, groq_result, content)
        
        print(f"📤 Sending to Gemini for refinement ({exam_type.upper()})...")
        response = model.generate_content(prompt)
        text = response.text.strip()
        
        insights = extract_json_robust(text)
        print(f"✅ Gemini refinement completed for {exam_type.upper()}")
        return insights
        
    except Exception as e:
        print(f"❌ Gemini refinement error: {e}")
        # Retorna insights vazios para o número de competências do vestibular
        try:
            from .exam_criteria import get_exam_criteria
            criteria = get_exam_criteria(exam_type)
            return {f"competence_{i}_premium_insights": "" for i in range(1, len(criteria.competencies)+1)}
        except:
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


async def correct_essay_premium(title: str, theme: str, content: str, exam_type: str = 'enem', api_key_groq: str = '', api_key_gemini: str = '') -> dict:
    """
    Premium correction: Dupla correção paralela (Groq + Gemini) + Árbitro
    
    Fluxo:
    1. Groq 70B e Gemini corrigem em paralelo
    2. Compara notas - se diferença > 40pts em qualquer competência:
       → Árbitro (Groq 8B) decide
    3. Senão: média ponderada (Groq 60%, Gemini 40%)
    """
    import asyncio
    
    print(f"🌟 === PREMIUM CORRECTION V2 ({exam_type.upper()}) - DUPLA CORREÇÃO + ÁRBITRO ===")
    
    # Import prompt_builder para prompts específicos por vestibular
    from .prompt_builder import create_correction_prompt
    
    # Cria prompt específico para o vestibular
    prompt = create_correction_prompt(exam_type, title, theme, content)
    print(f"✅ Prompt específico para {exam_type.upper()} criado")
    
    # ===== STEP 1: CORREÇÃO PARALELA =====
    print(f"Step 1/3: Correção paralela (Groq 70B + Gemini)...")
    
    async def run_groq():
        try:
            return await retry_with_backoff(
                lambda: correct_with_groq_custom_prompt(
                    title, theme, content, api_key_groq, prompt, model="llama-3.3-70b-versatile"
                ),
                max_retries=2
            )
        except Exception as e:
            print(f"⚠️ Groq 70B falhou: {e}. Tentando 8B...")
            return await correct_with_groq_custom_prompt(
                title, theme, content, api_key_groq, prompt, model="llama-3.1-8b-instant"
            )
    
    async def run_gemini():
        try:
            return await correct_with_gemini_custom_prompt(
                title, theme, content, api_key_gemini, prompt
            )
        except Exception as e:
            print(f"⚠️ Gemini falhou: {e}")
            return None
    
    # Executa em paralelo
    results = await asyncio.gather(run_groq(), run_gemini(), return_exceptions=True)
    
    groq_result = results[0] if not isinstance(results[0], Exception) else None
    gemini_result = results[1] if not isinstance(results[1], Exception) else None
    
    # Tratamento de erros
    if groq_result is None and gemini_result is None:
        raise Exception("Ambas IAs falharam na correção")
    
    if groq_result is None:
        print("⚠️ Apenas Gemini retornou. Usando resultado único.")
        return gemini_result
    
    if gemini_result is None:
        print("⚠️ Apenas Groq retornou. Usando resultado único com insights antigos.")
        gemini_insights = await refine_with_gemini(title, theme, content, groq_result, api_key_gemini, exam_type)
        return combine_corrections(groq_result, gemini_insights)
    
    print(f"✅ Groq Score: {groq_result.get('total_score')} | Gemini Score: {gemini_result.get('total_score')}")
    
    # ===== STEP 2: VERIFICAR DIVERGÊNCIA =====
    print(f"Step 2/3: Verificando divergências...")
    needs_arb, divergent_comps = check_needs_arbitration(groq_result, gemini_result, threshold=40)
    
    # ===== STEP 3: ÁRBITRO OU MÉDIA =====
    if needs_arb:
        print(f"Step 3/3: Chamando árbitro para {len(divergent_comps)} competência(s)...")
        final_result = await arbitrate_scores(
            groq_result, gemini_result, divergent_comps, 
            content, api_key_groq, exam_type
        )
    else:
        print(f"Step 3/3: Calculando média ponderada...")
        final_result = average_scores(groq_result, gemini_result)
    
    print(f"✅ Premium V2 completed. Score: {final_result.get('total_score')}")
    return final_result


async def correct_with_groq_custom_prompt(title: str, theme: str, content: str, api_key: str, custom_prompt: str, model: str = "llama-3.3-70b-versatile") -> dict:
    """Correct essay using Groq API with custom prompt (for exam-specific prompts)"""
    try:
        from groq import Groq
        
        client = Groq(api_key=api_key)
        
        print(f"📤 Sending to Groq with custom prompt: {title}")
        logger.info(f"Sending to Groq: {title}")
        print(f"🤖 Model: {model}")
        
        # DEBUG PROMPT
        print(f"📝 PROMPT ENVIADO PARA GROQ:\n{custom_prompt[:500]}...")
        
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": custom_prompt}],
            temperature=0.2,
            max_tokens=2048
        )
        
        text = response.choices[0].message.content.strip()
        print(f"📥 RESPOSTA RAW GROQ:\n{text[:500]}...")
        
        data = extract_json_robust(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        print(f"✅ Groq correction completed. Score: {data.get('total_score')}")
        logger.info(f"Groq correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        print(f"❌ Groq error: {e}")
        logger.error(f"Groq error: {e}")
        raise


async def correct_with_gemini_custom_prompt(title: str, theme: str, content: str, api_key: str, custom_prompt: str) -> dict:
    """Correct essay using Gemini API with custom prompt (for exam-specific prompts)"""
    try:
        import google.generativeai as genai
        
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-2.0-flash')
        
        logger.info(f"Sending to Gemini: {title}")
        
        response = model.generate_content(
            custom_prompt,
            generation_config=genai.GenerationConfig(temperature=0.1, max_output_tokens=2048),
            safety_settings=[
                {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"},
            ]
        )
        
        text = response.text.strip()
        data = extract_json_robust(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        logger.info(f"Gemini correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        logger.error(f"Gemini error: {e}")
        raise


async def correct_with_cerebras_custom_prompt(title: str, theme: str, content: str, api_key: str, custom_prompt: str) -> dict:
    """Correct essay using Cerebras API with custom prompt (for exam-specific prompts)"""
    try:
        from openai import OpenAI
        
        # Cerebras usa API compatível com OpenAI
        client = OpenAI(
            api_key=api_key,
            base_url="https://api.cerebras.ai/v1"
        )
        
        print(f"🧠 Sending to Cerebras: {title}")
        logger.info(f"Sending to Cerebras: {title}")
        
        response = client.chat.completions.create(
            model="llama-3.3-70b",
            messages=[{"role": "user", "content": custom_prompt}],
            temperature=0.2,
            max_tokens=2048
        )
        
        text = response.choices[0].message.content.strip()
        data = extract_json_robust(text)
        data['strengths'] = json.dumps(data.get('strengths', []), ensure_ascii=False)
        data['improvements'] = json.dumps(data.get('improvements', []), ensure_ascii=False)
        
        print(f"✅ Cerebras correction completed. Score: {data.get('total_score')}")
        logger.info(f"Cerebras correction completed. Score: {data.get('total_score')}")
        return data
        
    except Exception as e:
        print(f"❌ Cerebras error: {e}")
        logger.error(f"Cerebras error: {e}")
        raise


# ===== DUAL CORRECTION + ARBITRATOR FUNCTIONS =====

def average_scores(groq_result: dict, gemini_result: dict, groq_weight: float = 0.6) -> dict:
    """
    Calcula média ponderada das notas de Groq e Gemini.
    Combina feedbacks de ambas IAs.
    Default: Groq 60%, Gemini 40%
    """
    gemini_weight = 1.0 - groq_weight
    combined = {}
    
    # Média ponderada das notas
    for i in range(1, 6):
        score_key = f"competence_{i}_score"
        groq_score = groq_result.get(score_key, 0) or 0
        gemini_score = gemini_result.get(score_key, 0) or 0
        
        # Média ponderada arredondada para múltiplo de 20 (escala ENEM)
        avg = groq_score * groq_weight + gemini_score * gemini_weight
        combined[score_key] = int(round(avg / 20) * 20)  # Arredonda para 0, 20, 40, 60...
        
        # Combina feedbacks
        feedback_key = f"competence_{i}_feedback"
        groq_fb = groq_result.get(feedback_key, "")
        gemini_fb = gemini_result.get(feedback_key, "")
        combined[feedback_key] = f"{groq_fb}\n\n💎 **Segunda Análise:**\n{gemini_fb}" if gemini_fb else groq_fb
    
    # Total
    combined['total_score'] = sum(combined.get(f"competence_{i}_score", 0) for i in range(1, 6))
    
    # Outros campos
    combined['strengths'] = groq_result.get('strengths', '[]')
    combined['improvements'] = groq_result.get('improvements', '[]')
    combined['general_comments'] = f"{groq_result.get('general_comments', '')}\n\n💎 **Análise Complementar:**\n{gemini_result.get('general_comments', '')}"
    
    print(f"📊 Média ponderada calculada. Total: {combined['total_score']}")
    return combined


def check_needs_arbitration(groq_result: dict, gemini_result: dict, threshold: int = 40) -> tuple[bool, list]:
    """
    Verifica se há discrepância significativa entre as correções.
    Retorna (precisa_arbitragem, lista_competencias_divergentes)
    """
    divergent_comps = []
    
    for i in range(1, 6):
        score_key = f"competence_{i}_score"
        groq_score = groq_result.get(score_key, 0) or 0
        gemini_score = gemini_result.get(score_key, 0) or 0
        diff = abs(groq_score - gemini_score)
        
        if diff > threshold:
            divergent_comps.append({
                'competence': i,
                'groq_score': groq_score,
                'gemini_score': gemini_score,
                'difference': diff
            })
            print(f"⚠️ Divergência C{i}: Groq={groq_score} vs Gemini={gemini_score} (diff={diff})")
    
    needs_arb = len(divergent_comps) > 0
    if needs_arb:
        print(f"🔔 ARBITRAGEM NECESSÁRIA para {len(divergent_comps)} competência(s)")
    else:
        print(f"✅ Notas concordantes (threshold={threshold})")
    
    return needs_arb, divergent_comps


def create_arbitration_prompt(groq_result: dict, gemini_result: dict, divergent_comps: list, content: str, exam_type: str) -> str:
    """Cria prompt para o árbitro decidir entre notas discrepantes"""
    from .exam_criteria import get_exam_criteria
    criteria = get_exam_criteria(exam_type)
    
    divergence_text = ""
    for div in divergent_comps:
        i = div['competence']
        comp_name = criteria.competencies[i-1] if i <= len(criteria.competencies) else f"Competência {i}"
        divergence_text += f"""
**Competência {i} ({comp_name}):**
- IA 1 (Groq): {div['groq_score']}/200
- IA 2 (Gemini): {div['gemini_score']}/200
- Diferença: {div['difference']} pontos
"""
    
    return f"""Você é um ÁRBITRO ESPECIALISTA em correção de redações {criteria.short_name}.

Duas IAs corrigiram a mesma redação e discordam significativamente em algumas competências:
{divergence_text}

Analise a redação abaixo e DECIDA a nota correta para cada competência divergente.
Use a escala oficial: 0, 40, 80, 120, 160 ou 200.

IMPORTANTE: Sua decisão deve ser baseada nos critérios oficiais do {criteria.short_name}.
Seja preciso e justo.

Retorne APENAS JSON no formato:
{{
  "arbitrated_scores": {{
    "competence_1_score": <sua decisão ou null se não divergiu>,
    "competence_2_score": <sua decisão ou null se não divergiu>,
    "competence_3_score": <sua decisão ou null se não divergiu>,
    "competence_4_score": <sua decisão ou null se não divergiu>,
    "competence_5_score": <sua decisão ou null se não divergiu>
  }},
  "justification": "Breve justificativa para as decisões"
}}

REDAÇÃO:
{content}
"""


async def arbitrate_scores(groq_result: dict, gemini_result: dict, divergent_comps: list, 
                           content: str, api_key: str, exam_type: str) -> dict:
    """
    Usa uma terceira IA (Groq 8B - mais rápido) para decidir entre notas divergentes.
    Retorna resultado final combinado.
    """
    print(f"⚖️ Iniciando arbitragem para {len(divergent_comps)} competências...")
    
    try:
        from groq import Groq
        
        prompt = create_arbitration_prompt(groq_result, gemini_result, divergent_comps, content, exam_type)
        
        client = Groq(api_key=api_key)
        response = client.chat.completions.create(
            model="llama-3.1-8b-instant",  # Modelo rápido para arbitragem
            messages=[{"role": "user", "content": prompt}],
            temperature=0.1,
            max_tokens=1024
        )
        
        text = response.choices[0].message.content.strip()
        arb_data = extract_json_robust(text)
        arbitrated = arb_data.get('arbitrated_scores', {})
        justification = arb_data.get('justification', '')
        
        print(f"⚖️ Árbitro decidiu: {arbitrated}")
        print(f"📝 Justificativa: {justification[:100]}...")
        
        # Monta resultado final
        combined = groq_result.copy()
        
        for i in range(1, 6):
            score_key = f"competence_{i}_score"
            arb_score = arbitrated.get(score_key)
            
            if arb_score is not None:
                # Usa nota do árbitro
                combined[score_key] = int(arb_score)
                combined[f"competence_{i}_feedback"] += f"\n\n⚖️ **Nota Arbitrada:** Esta competência teve divergência entre corretores e foi reavaliada."
            else:
                # Usa média das IAs para competências não divergentes
                groq_score = groq_result.get(score_key, 0) or 0
                gemini_score = gemini_result.get(score_key, 0) or 0
                combined[score_key] = int(round((groq_score * 0.6 + gemini_score * 0.4) / 20) * 20)
        
        # Recalcula total
        combined['total_score'] = sum(combined.get(f"competence_{i}_score", 0) for i in range(1, 6))
        
        # Adiciona justificativa ao comentário geral
        combined['general_comments'] += f"\n\n⚖️ **Nota de Arbitragem:**\n{justification}"
        
        print(f"✅ Arbitragem concluída. Total: {combined['total_score']}")
        return combined
        
    except Exception as e:
        print(f"❌ Erro na arbitragem: {e}. Usando média simples como fallback.")
        logger.error(f"Arbitration error: {e}")
        return average_scores(groq_result, gemini_result)

