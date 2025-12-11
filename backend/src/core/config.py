import secrets
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    SECRET_KEY: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 180
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7
    ALGORITHM: str = "HS256"
    DATABASE_URL: str
    CORRECTION_SERVICE_URL: str
    CORS_ORIGINS: str = ""
    GEMINI_API_KEY: str  # API key for Gemini AI
    GROQ_API_KEY: str = ""  # API key for Groq AI
    STABILITY_API_KEY: str = ""  # API key for Stability AI (image generation)


    class Config:
        env_file = ".env"
        extra = 'ignore'

settings = Settings()

# Verificação de segurança para chave padrão
if settings.SECRET_KEY == "your-super-secret-and-secure-key-here":
    import logging
    logging.warning("⚠️  ATENÇÃO: Você está usando a SECRET_KEY padrão. Gere uma nova chave segura usando 'python scripts/generate_secret.py' para produção!")