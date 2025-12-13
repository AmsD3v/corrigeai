from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import Optional
from .. import models
from ..database import get_db
from ..dependencies import get_current_admin_user

router = APIRouter()

class SettingsUpdate(BaseModel):
    # Provedores por função
    correction_provider: Optional[str] = None
    image_provider: Optional[str] = None
    tutor_provider: Optional[str] = None
    theme_provider: Optional[str] = None
    
    # Chaves API por função (separadas)
    correction_api_key: Optional[str] = None
    image_api_key: Optional[str] = None
    tutor_api_key: Optional[str] = None
    theme_api_key: Optional[str] = None
    premium_gemini_api_key: Optional[str] = None  # Chave Gemini extra para Premium
    premium_provider: Optional[str] = None  # Provedor para segunda correção Premium
    
    # Fallback provider
    fallback_provider: Optional[str] = None
    fallback_api_key: Optional[str] = None
    
    # Gamification settings
    lesson_cooldown_hours: Optional[int] = None
    lesson_repeat_xp_percent: Optional[int] = None

def validate_api_key(provider: str, key: str, function_name: str) -> tuple[bool, str]:
    """Valida se a chave corresponde ao provedor selecionado"""
    if not key or key.strip() == '':
        return False, f"{function_name}: Chave API não configurada"
    
    key_stripped = key.strip()
    
    if provider == 'gemini':
        if not key_stripped.startswith('AIza'):
            return False, f'{function_name}: Chave Gemini deve começar com "AIza"'
    elif provider == 'groq':
        if not key_stripped.lower().startswith('gsk_'):
            return False, f'{function_name}: Chave Groq deve começar com "gsk_"'
    elif provider == 'huggingface':
        if not key_stripped.lower().startswith('hf_'):
            return False, f'{function_name}: Chave HuggingFace deve começar com "hf_"'
    elif provider == 'together':
        if key_stripped.startswith('AIza') or key_stripped.lower().startswith('gsk_') or key_stripped.lower().startswith('hf_') or key_stripped.lower().startswith('csk-'):
            return False, f'{function_name}: A chave parece ser de outro provedor'
    elif provider == 'cerebras':
        if not key_stripped.lower().startswith('csk-'):
            return False, f'{function_name}: Chave Cerebras deve começar com "csk-"'
    
    return True, ''

@router.get("/api/settings")
async def get_settings(db: Session = Depends(get_db)):
    settings = db.query(models.Settings).first()
    if not settings:
        settings = models.Settings()
        db.add(settings)
        db.commit()
        db.refresh(settings)
    
    return {
        # Provedores por função
        "correction_provider": getattr(settings, 'correction_provider', 'groq'),
        "image_provider": getattr(settings, 'image_provider', 'huggingface'),
        "tutor_provider": getattr(settings, 'tutor_provider', 'groq'),
        "theme_provider": getattr(settings, 'theme_provider', 'groq'),
        # Chaves API por função
        "correction_api_key": getattr(settings, 'correction_api_key', '') or '',
        "image_api_key": getattr(settings, 'image_api_key', '') or '',
        "tutor_api_key": getattr(settings, 'tutor_api_key', '') or '',
        "theme_api_key": getattr(settings, 'theme_api_key', '') or '',
        "premium_gemini_api_key": getattr(settings, 'premium_gemini_api_key', '') or '',
        "premium_provider": getattr(settings, 'premium_provider', 'gemini') or 'gemini',
        "fallback_provider": getattr(settings, 'fallback_provider', 'groq') or 'groq',
        "fallback_api_key": getattr(settings, 'fallback_api_key', '') or '',
        # Gamificação
        "lesson_cooldown_hours": settings.lesson_cooldown_hours,
        "lesson_repeat_xp_percent": settings.lesson_repeat_xp_percent
    }

@router.post("/api/settings")
async def update_settings(
    settings_update: SettingsUpdate,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    # Validar chave para cada função
    validations = [
        ('correction_provider', settings_update.correction_provider, settings_update.correction_api_key, 'Correção'),
        ('image_provider', settings_update.image_provider, settings_update.image_api_key, 'Imagens'),
        ('tutor_provider', settings_update.tutor_provider, settings_update.tutor_api_key, 'Tutor'),
        ('theme_provider', settings_update.theme_provider, settings_update.theme_api_key, 'Tema'),
    ]
    
    for field_name, provider, api_key, func_name in validations:
        if provider and api_key:
            is_valid, error_msg = validate_api_key(provider, api_key, func_name)
            if not is_valid:
                raise HTTPException(status_code=400, detail=error_msg)

    settings = db.query(models.Settings).first()
    if not settings:
        settings = models.Settings()
        db.add(settings)
    
    # Provedores por função
    if settings_update.correction_provider is not None:
        settings.correction_provider = settings_update.correction_provider
    if settings_update.image_provider is not None:
        settings.image_provider = settings_update.image_provider
    if settings_update.tutor_provider is not None:
        settings.tutor_provider = settings_update.tutor_provider
    if settings_update.theme_provider is not None:
        settings.theme_provider = settings_update.theme_provider
    
    # Chaves API por função
    if settings_update.correction_api_key is not None:
        settings.correction_api_key = settings_update.correction_api_key
    if settings_update.image_api_key is not None:
        settings.image_api_key = settings_update.image_api_key
    if settings_update.tutor_api_key is not None:
        settings.tutor_api_key = settings_update.tutor_api_key
    if settings_update.theme_api_key is not None:
        settings.theme_api_key = settings_update.theme_api_key
    if settings_update.premium_gemini_api_key is not None:
        settings.premium_gemini_api_key = settings_update.premium_gemini_api_key
    if settings_update.premium_provider is not None:
        settings.premium_provider = settings_update.premium_provider
    if settings_update.fallback_provider is not None:
        settings.fallback_provider = settings_update.fallback_provider
    if settings_update.fallback_api_key is not None:
        settings.fallback_api_key = settings_update.fallback_api_key
        
    # Gamification settings
    if settings_update.lesson_cooldown_hours is not None:
        settings.lesson_cooldown_hours = max(1, settings_update.lesson_cooldown_hours)
    if settings_update.lesson_repeat_xp_percent is not None:
        settings.lesson_repeat_xp_percent = max(0, min(100, settings_update.lesson_repeat_xp_percent))
    
    db.commit()
    db.refresh(settings)
    
    return {
        "correction_provider": getattr(settings, 'correction_provider', 'groq'),
        "image_provider": getattr(settings, 'image_provider', 'huggingface'),
        "tutor_provider": getattr(settings, 'tutor_provider', 'groq'),
        "theme_provider": getattr(settings, 'theme_provider', 'groq'),
        "message": "Settings updated successfully"
    }
