"""
Testar se o prompt de correção está sendo bloqueado
"""
import google.generativeai as genai
import os
from dotenv import load_dotenv

load_dotenv()

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

print("🧪 Testando PROMPT DE CORREÇÃO...\n")

# Prompt real usado no sistema
CORRECTION_PROMPT = """Avalie esta redação do ENEM usando os 5 critérios oficiais.

Para cada competência (1 a 5), forneça:
- Nota de 0 a 200 (múltiplos de 20)
- Feedback educacional construtivo

Retorne APENAS o JSON abaixo, sem texto adicional:

{{
  "competence_1_score": 160,
  "competence_1_feedback": "Análise sobre gramática e ortografia",
  "competence_2_score": 140,
  "competence_2_feedback": "Análise sobre compreensão do tema",
  "competence_3_score": 160,
  "competence_3_feedback": "Análise sobre argumentação",
  "competence_4_score": 140,
  "competence_4_feedback": "Análise sobre coesão textual",
  "competence_5_score": 160,
  "competence_5_feedback": "Análise sobre proposta de intervenção",
  "total_score": 760,
  "strengths": ["Ponto positivo 1", "Ponto positivo 2", "Ponto positivo 3"],
  "improvements": ["Sugestão 1", "Sugestão 2", "Sugestão 3"],
  "general_comments": "Comentário geral construtivo"
}}

Redação:
Título: {title}
Tema: {theme}

{content}
"""

# Redação de teste
test_essay = {
    "title": "Educação no Brasil",
    "theme": "Desafios da educação brasileira",
    "content": """
    A educação no Brasil enfrenta diversos desafios estruturais. Entre eles, destaca-se
    a falta de investimento adequado em infraestrutura escolar e na formação continuada
    de professores. Além disso, há grande desigualdade no acesso à educação de qualidade
    entre diferentes regiões do país.
    
    Para melhorar esse cenário, é necessário aumentar o orçamento destinado à educação,
    capacitar melhor os profissionais e implementar políticas públicas efetivas que
    garantam igualdade de oportunidades para todos os estudantes brasileiros.
    """
}

prompt = CORRECTION_PROMPT.format(**test_essay)

print(f"📝 Prompt (primeiros 300 caracteres):")
print(prompt[:300])
print("...\n")

model = genai.GenerativeModel('gemini-2.5-flash')

try:
    response = model.generate_content(
        prompt,
        generation_config=genai.GenerationConfig(
            temperature=0.3,
            max_output_tokens=2048,
        ),
        safety_settings=[
            {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
            {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
            {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
            {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"},
        ]
    )
    
    # Verificar finish_reason
    if hasattr(response, 'candidates') and len(response.candidates) > 0:
        finish_reason = response.candidates[0].finish_reason
        print(f"finish_reason: {finish_reason}")
        
        if finish_reason == 1:  # STOP (sucesso)
            print(f"\n✅ SUCESSO! Gemini NÃO bloqueou!")
            print(f"\nResposta (primeiros 500 caracteres):")
            print(response.text[:500])
        elif finish_reason == 2:  # SAFETY
            print(f"\n❌ BLOQUEADO por segurança!")
            print("\nSafety ratings:")
            for rating in response.candidates[0].safety_ratings:
                print(f"   {rating.category}: {rating.probability}")
        else:
            print(f"\n⚠️ Outro finish_reason: {finish_reason}")
    else:
        print(f"\n❌ Sem candidates")
        
except Exception as e:
    print(f"\n❌ ERRO: {e}")
    import traceback
    traceback.print_exc()
