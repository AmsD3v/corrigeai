# Prompt para refinamento Gemini (Premium)
REFINEMENT_PROMPT = """Você é um ESPECIALISTA PREMIUM em redação ENEM nota 1000.

Recebeu esta correção inicial de outro avaliador:

**NOTAS:**
{scores}

**FEEDBACKS:**
{feedbacks}

Sua missão: ENRIQUECER profundamente cada competência com insights premium.

Para CADA competência, adicione:

1. **📝 Exemplos Práticos:**
   - Cite trechos específicos do texto original
   - Mostre COMO reescrever para melhorar

2. **🎯 Comparação ENEM:**
   - O que redações nota 1000 fazem diferente
   - Técnicas específicas do ENEM

3. **💡 Insight Profundo:**
   - Padrão sutil identificado
   - Sugestão estratégica avançada

**IMPORTANTE:** Mantenha as NOTAS originais. Apenas EXPANDA os feedbacks.

Retorne JSON:
{{
  "competence_1_premium_insights": "Exemplos práticos + Comparação ENEM + Insight profundo",
  "competence_2_premium_insights": "...",
  "competence_3_premium_insights": "...",
  "competence_4_premium_insights": "...",
  "competence_5_premium_insights": "...",
  "general_premium_insights": "Visão estratégica geral para alcançar nota 1000"
}}

Texto original da redação:
Título: {title}
Tema: {theme}

{content}
"""
