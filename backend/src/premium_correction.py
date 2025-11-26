"""
Premium correction functions for hybrid Groq + Gemini system
"""
import json
from typing import Dict
# Import from parent ai_service
from .ai_service import correct_with_groq

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
        model = genai.GenerativeModel('gemini-pro')
        
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
        return {
            f"competence_{i}_premium_insights": "" for i in range(1, 6)
        }


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
