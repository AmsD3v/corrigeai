from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from ..dependencies import get_current_user
from ..models import User
import google.generativeai as genai
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
    Gera um tema de redação usando IA (Gemini).
    Usa GEMINI_THEME_API_KEY se disponível, caso contrário usa GEMINI_API_KEY.
    """
    try:
        # Tentar usar API Key específica para temas, fallback para a geral
        api_key = os.getenv("GEMINI_THEME_API_KEY") or os.getenv("GEMINI_API_KEY")
        
        if not api_key:
            logger.error("❌ Nenhuma API key do Gemini configurada")
            raise HTTPException(
                status_code=500,
                detail="API key do Gemini não configurada"
            )
        
        # Configurar Gemini
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-1.5-flash')
        
        # Prompt para gerar tema
        context_text = f" no contexto de {request.context}" if request.context else ""
        
        prompt = f"""Gere um tema de redação ENEM interessante e relevante{context_text}.

Retorne no formato JSON exato:
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
        
        # Gerar tema
        response = model.generate_content(prompt)
        
        # Extrair JSON da resposta
        import json
        import re
        
        # Tentar extrair JSON da resposta
        text = response.text
        
        # Remover markdown code blocks se houver
        text = re.sub(r'```json\s*', '', text)
        text = re.sub(r'```\s*$', '', text)
        text = text.strip()
        
        # Parse JSON
        try:
            theme_data = json.loads(text)
        except json.JSONDecodeError:
            # Se falhar, tentar extrair do texto
            logger.warning("⚠️ Resposta não é JSON válido, usando fallback")
            theme_data = {
                "theme": "Os desafios da tecnologia na educação brasileira",
                "description": "Discuta o impacto da tecnologia no ensino e os desafios de acesso à educação digital."
            }
        
        logger.info(f"✅ Tema gerado: {theme_data.get('theme')}")
        
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
