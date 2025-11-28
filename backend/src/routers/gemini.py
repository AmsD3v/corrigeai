from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from ..dependencies import get_current_user
from ..models import User
import os
import logging

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/gemini", tags=["gemini"])

class ThemeRequest(BaseModel):
    context: str | None = None

class ThemeResponse(BaseModel):
    theme: str
    description: str

@router.post("/generate-theme", response_model=ThemeResponse)
async def generate_theme(
    request: ThemeRequest,
    current_user: User = Depends(get_current_user)
):
    """
    Gera um tema de redação usando IA.
    Tenta usar Groq primeiro (mais rápido e grátis), fallback para Gemini.
    """
    try:
        import json
        import re
        
        # Prompt para gerar tema
        context_text = f" no contexto de {request.context}" if request.context else ""
        
        prompt = f"""Gere um tema de redação ENEM interessante e relevante{context_text}.

Retorne APENAS um JSON válido neste formato exato:
{{
    "theme": "Título do tema (máximo 80 caracteres)",
    "description": "Breve contexto sobre o tema (máximo 150 caracteres)"
}}

O tema deve ser:
- Atual e relevante
- Específico e focado
- Adequado para argumentação
- Relacionado a questões sociais, políticas, ambientais ou culturais do Brasil

Exemplos de bons temas:
- "Os desafios da inclusão digital no Brasil"
- "O papel da educação financeira na sociedade brasileira"
- "A preservação da Amazônia e o desenvolvimento sustentável"
"""
        
        logger.info(f"🤖 Gerando tema com IA para usuário {current_user.email}")
        
        # Tentar Groq primeiro (mais rápido)
        groq_key = os.getenv("GROQ_API_KEY")
        if groq_key:
            try:
                from groq import Groq
                
                logger.info("🚀 Usando Groq para gerar tema")
                client = Groq(api_key=groq_key)
                
                response = client.chat.completions.create(
                    model="llama-3.1-8b-instant",
                    messages=[
                        {"role": "system", "content": "Você é um especialista em educação e redação do ENEM. Responda APENAS com JSON válido."},
                        {"role": "user", "content": prompt}
                    ],
                    temperature=0.7,
                    max_tokens=500
                )
                
                text = response.choices[0].message.content.strip()
                logger.info(f"📥 Resposta do Groq: {text[:100]}...")
                
                # Limpar resposta
                text = re.sub(r'```json\s*', '', text)
                text = re.sub(r'```\s*$', '', text)
                text = text.strip()
                
                theme_data = json.loads(text)
                logger.info(f"✅ Tema gerado com Groq: {theme_data.get('theme')}")
                
                return ThemeResponse(
                    theme=theme_data.get("theme", "Tema não disponível"),
                    description=theme_data.get("description", "Descrição não disponível")
                )
                
            except Exception as e:
                logger.warning(f"⚠️ Groq falhou: {str(e)}, tentando Gemini...")
        
        # Fallback para Gemini
        gemini_key = os.getenv("GEMINI_THEME_API_KEY") or os.getenv("GEMINI_API_KEY")
        
        if not gemini_key:
            logger.error("❌ Nenhuma API key configurada (Groq ou Gemini)")
            raise HTTPException(
                status_code=500,
                detail="Nenhuma API key de IA configurada"
            )
        
        logger.info("🔮 Usando Gemini para gerar tema")
        import google.generativeai as genai
        
        genai.configure(api_key=gemini_key)
        model = genai.GenerativeModel('gemini-1.5-pro')
        
        response = model.generate_content(prompt)
        text = response.text.strip()
        
        # Limpar resposta
        text = re.sub(r'```json\s*', '', text)
        text = re.sub(r'```\s*$', '', text)
        text = text.strip()
        
        try:
            theme_data = json.loads(text)
        except json.JSONDecodeError:
            logger.warning("⚠️ Resposta não é JSON válido, usando fallback")
            theme_data = {
                "theme": "Os desafios da tecnologia na educação brasileira",
                "description": "Discuta o impacto da tecnologia no ensino e os desafios de acesso à educação digital."
            }
        
        logger.info(f"✅ Tema gerado com Gemini: {theme_data.get('theme')}")
        
        return ThemeResponse(
            theme=theme_data.get("theme", "Tema não disponível"),
            description=theme_data.get("description", "Descrição não disponível")
        )
        
    except Exception as e:
        logger.error(f"❌ Erro ao gerar tema: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=f"Erro ao gerar tema: {str(e)}"
        )
