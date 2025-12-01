import logging
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from .core.logging_config import setup_logging
from .core.config import settings
from .routers import auth, users, submissions, admin, payments, packages, settings as settings_router, feedback, gemini, password_reset

app = FastAPI()

# Inicialização do banco de dados no startup do app
@app.on_event("startup")
def startup_event():
    # Configura o logging para usar o formato JSON
    setup_logging()
    # Inicializa o engine do banco de dados
    from .database import init_db_engine, Base
    engine = init_db_engine()
    # Importa os models após inicializar o banco de dados
    from . import models
    Base.metadata.create_all(bind=engine)
    logging.info("Tabelas criadas com sucesso!")
    
    # Valida configuração do Gemini AI
    if not settings.GEMINI_API_KEY or settings.GEMINI_API_KEY == "placeholder_key":
        logging.warning("="*60)
        logging.warning("⚠️  ATENÇÃO: GEMINI_API_KEY NÃO CONFIGURADA!")
        logging.warning("⚠️  Funcionalidades de IA não funcionarão:")
        logging.warning("⚠️  - Geração de temas")
        logging.warning("⚠️  - Correção de redações")
        logging.warning("⚠️  Configure a API key no arquivo .env")
        logging.warning("="*60)
    else:
        # Log para debug - mostra primeiros e últimos caracteres da key
        key_preview = f"{settings.GEMINI_API_KEY[:10]}...{settings.GEMINI_API_KEY[-4:]}"
        logging.info(f"✅ Gemini API key configurada! (Preview: {key_preview})")

# Configuração do CORS
# Lê as origens das variáveis de ambiente para permitir configuração flexível
origins = settings.CORS_ORIGINS.split(",") if settings.CORS_ORIGINS else []

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    allow_headers=["*"],
    # Adiciona segurança adicional
    # Permite envio de cookies com requisições CORS
    allow_origin_regex=None,
    # Exposição de headers para client-side
    expose_headers=["Access-Control-Allow-Origin"],
)

# Middleware para logging de requisições e erros
from fastapi import Request
import time
import traceback

@app.middleware("http")
async def log_requests(request: Request, call_next):
    start_time = time.time()
    try:
        response = await call_next(request)
        process_time = time.time() - start_time
        logging.info(f"Request: {request.method} {request.url.path} - Status: {response.status_code} - Time: {process_time:.2f}s")
        return response
    except Exception as e:
        process_time = time.time() - start_time
        error_msg = f"❌ UNHANDLED EXCEPTION: {str(e)}\n{traceback.format_exc()}"
        print(error_msg)
        logging.error(error_msg)
        return JSONResponse(
            status_code=500,
            content={"detail": "Internal Server Error (Logged)"}
        )

# Rota de Health Check para diagnóstico
@app.get("/health")
def health_check():
    return {"status": "ok"}

# Include Routers
app.include_router(auth.router, tags=["auth"])
app.include_router(users.router, tags=["users"])
app.include_router(admin.router, tags=["admin"])
app.include_router(payments.router, tags=["payments"])
app.include_router(submissions.router, tags=["submissions"])
app.include_router(packages.router, tags=["packages"])
app.include_router(settings_router.router, tags=["settings"])
app.include_router(feedback.router, tags=["feedback"])
app.include_router(gemini.router, tags=["gemini"])
app.include_router(password_reset.router, tags=["password-reset"])