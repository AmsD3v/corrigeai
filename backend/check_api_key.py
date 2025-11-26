from src.core.config import settings
print(f"GEMINI_API_KEY configurada: {'Sim' if settings.GEMINI_API_KEY and settings.GEMINI_API_KEY != 'placeholder_key' else 'NÃO'}")
print(f"Primeiros 10 caracteres: {settings.GEMINI_API_KEY[:10] if settings.GEMINI_API_KEY else 'None'}")
