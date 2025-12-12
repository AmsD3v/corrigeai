from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import Optional
from .. import models
from ..database import get_db
from ..dependencies import get_current_admin_user

router = APIRouter()

class SettingsUpdate(BaseModel):
    active_ai_provider: Optional[str] = None
    gemini_api_key: Optional[str] = None
    groq_api_key: Optional[str] = None
    hf_token: Optional[str] = None
    together_api_key: Optional[str] = None
    # Gamification settings
    lesson_cooldown_hours: Optional[int] = None  # Mínimo 1 hora
    lesson_repeat_xp_percent: Optional[int] = None

@router.get("/api/settings")
async def get_settings(
    db: Session = Depends(get_db),
    # admin_user: models.User = Depends(get_current_admin_user) # Optional: restrict to admin
):
    settings = db.query(models.Settings).first()
    if not settings:
        # Create default settings if not exists
        settings = models.Settings()
        db.add(settings)
        db.commit()
        db.refresh(settings)
    
    return {
        "active_ai_provider": settings.active_ai_provider,
        "gemini_api_key": settings.gemini_api_key,
        "groq_api_key": settings.groq_api_key,
        "hf_token": settings.hf_token,
        "together_api_key": settings.together_api_key,
        "lesson_cooldown_hours": settings.lesson_cooldown_hours,
        "lesson_repeat_xp_percent": settings.lesson_repeat_xp_percent
    }

@router.post("/api/settings")
async def update_settings(
    settings_update: SettingsUpdate,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    # Validar chave API vs provedor selecionado
    def validate_api_key(provider: str, key: str) -> tuple[bool, str]:
        if not key or key.strip() == '':
            return False, f"Chave API não configurada para {provider}"
        
        key_stripped = key.strip()
        
        if provider == 'gemini':
            if not key_stripped.startswith('AIza'):
                return False, 'Chave Gemini deve começar com "AIza". Verifique se você selecionou o provedor correto.'
        elif provider == 'groq':
            if not key_stripped.lower().startswith('gsk_'):
                return False, 'Chave Groq deve começar com "gsk_". Verifique se você selecionou o provedor correto.'
        elif provider == 'huggingface':
            if not key_stripped.lower().startswith('hf_'):
                return False, 'Chave HuggingFace deve começar com "hf_". Verifique se você selecionou o provedor correto.'
        elif provider == 'together':
            # Together não tem prefixo fixo, mas não deveria ser de outros provedores
            if key_stripped.startswith('AIza') or key_stripped.lower().startswith('gsk_') or key_stripped.lower().startswith('hf_'):
                return False, 'A chave parece ser de outro provedor (Gemini, Groq ou HuggingFace), não do Together AI.'
        
        return True, ''

    # Validar se a chave corresponde ao provedor
    if settings_update.active_ai_provider:
        provider = settings_update.active_ai_provider
        key = ''
        
        if provider == 'gemini':
            key = settings_update.gemini_api_key or ''
        elif provider == 'groq':
            key = settings_update.groq_api_key or ''
        elif provider == 'huggingface':
            key = settings_update.hf_token or ''
        elif provider == 'together':
            key = settings_update.together_api_key or ''
        
        is_valid, error_msg = validate_api_key(provider, key)
        if not is_valid:
            raise HTTPException(status_code=400, detail=error_msg)

    settings = db.query(models.Settings).first()
    if not settings:
        settings = models.Settings()
        db.add(settings)
    
    if settings_update.active_ai_provider is not None:
        settings.active_ai_provider = settings_update.active_ai_provider
        
    if settings_update.gemini_api_key is not None:
        settings.gemini_api_key = settings_update.gemini_api_key
        
    if settings_update.groq_api_key is not None:
        settings.groq_api_key = settings_update.groq_api_key
        
    if settings_update.hf_token is not None:
        settings.hf_token = settings_update.hf_token
        
    if settings_update.together_api_key is not None:
        settings.together_api_key = settings_update.together_api_key
        
    # Gamification settings
    if settings_update.lesson_cooldown_hours is not None:
        # Mínimo 1 hora
        settings.lesson_cooldown_hours = max(1, settings_update.lesson_cooldown_hours)
        
    if settings_update.lesson_repeat_xp_percent is not None:
        # Entre 0 e 100%
        settings.lesson_repeat_xp_percent = max(0, min(100, settings_update.lesson_repeat_xp_percent))
    
    db.commit()
    db.refresh(settings)
    
    return {
        "active_ai_provider": settings.active_ai_provider,
        "lesson_cooldown_hours": settings.lesson_cooldown_hours,
        "lesson_repeat_xp_percent": settings.lesson_repeat_xp_percent,
        "message": "Settings updated successfully"
    }
