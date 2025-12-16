import logging
import time
import traceback
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from .core.logging_config import setup_logging
from .core.config import settings
from .routers import auth, users, submissions, admin, payments, packages, settings as settings_router, feedback, gemini, password_reset, dropdown_options, locations, user_stats

app = FastAPI()

# Inicialização do banco de dados no startup do app
@app.on_event("startup")
def startup_event():
    # Configura o logging para usar o formato JSON
    setup_logging()
    # Inicializa o engine do banco de dados
    # Inicializa o engine do banco de dados
    try:
        from .database import init_db_engine, Base
        engine = init_db_engine()
        # Importa os models após inicializar o banco de dados
        from . import models
        Base.metadata.create_all(bind=engine)
        logging.info("✅ Tabelas criadas com sucesso!")
    except Exception as e:
        logging.error(f"❌ Erro fatal ao conectar no banco de dados: {e}")
        # Não damos raise aqui para permitir que o app inicie e responda /health
        
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
        
        # Retorna erro 500 com headers CORS manuais para evitar bloqueio do navegador
        response = JSONResponse(
            status_code=500,
            content={"detail": "Internal Server Error (Logged)"}
        )
        # Permite qualquer origem no erro para garantir que o frontend veja a mensagem
        response.headers["Access-Control-Allow-Origin"] = request.headers.get("origin", "*")
        response.headers["Access-Control-Allow-Credentials"] = "true"
        response.headers["Access-Control-Allow-Methods"] = "*"
        response.headers["Access-Control-Allow-Headers"] = "*"
        return response

# Configuração do CORS (Deve ser o último middleware adicionado para ser o primeiro a executar)
# Lê as origens das variáveis de ambiente para permitir configuração flexível
raw_origins = settings.CORS_ORIGINS.split(",") if settings.CORS_ORIGINS else []
# Limpa espaços em branco e adiciona origens hardcoded de produção para garantia
origins = [origin.strip() for origin in raw_origins] + [
    "https://corrigeai.online",
    "https://www.corrigeai.online",
    "https://api.corrigeai.online",
    "http://localhost",
    "http://localhost:5173",
    "http://localhost:3000"
]
# Remove duplicatas
origins = list(set(origins))

logging.info(f"✅ CORS Origins configurados: {origins}")

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    allow_headers=["*"],
    allow_origin_regex=None,
    expose_headers=["*"],
    max_age=3600,  # Cache preflight requests for 1 hour
)

# Rota de Health Check para diagnóstico
@app.get("/health")
def health_check():
    return {"status": "ok"}

# Rota robots.txt para SEO (Google Search Console)
from fastapi.responses import PlainTextResponse, Response

@app.get("/robots.txt", response_class=PlainTextResponse)
def robots_txt():
    """Retorna robots.txt para crawlers - API não deve ser indexada"""
    return """User-agent: *
Disallow: /

# API endpoints should not be crawled
# Frontend is at corrigeai.online
"""

# Rota sitemap.xml dinâmico para SEO
@app.get("/sitemap.xml", response_class=Response)
def sitemap_xml():
    """Gera sitemap.xml dinamicamente com todas as páginas públicas e posts do blog"""
    from .database import SessionLocal
    from .models import BlogPost
    from datetime import datetime
    
    today = datetime.now().strftime("%Y-%m-%d")
    
    # Páginas estáticas
    static_pages = [
        {"loc": "https://corrigeai.online/", "priority": "1.0", "changefreq": "weekly"},
        {"loc": "https://corrigeai.online/login", "priority": "0.8", "changefreq": "monthly"},
        {"loc": "https://corrigeai.online/cadastro", "priority": "0.9", "changefreq": "monthly"},
        {"loc": "https://corrigeai.online/recuperar-senha", "priority": "0.3", "changefreq": "yearly"},
        {"loc": "https://corrigeai.online/blog", "priority": "0.9", "changefreq": "daily"},
    ]
    
    # Inicia o XML
    xml_content = '<?xml version="1.0" encoding="UTF-8"?>\n'
    xml_content += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
    
    # Adiciona páginas estáticas
    for page in static_pages:
        xml_content += f'''  <url>
    <loc>{page["loc"]}</loc>
    <lastmod>{today}</lastmod>
    <changefreq>{page["changefreq"]}</changefreq>
    <priority>{page["priority"]}</priority>
  </url>\n'''
    
    # Adiciona posts do blog dinamicamente
    try:
        db = SessionLocal()
        posts = db.query(BlogPost).filter(BlogPost.is_published == True).all()
        
        for post in posts:
            lastmod = post.updated_at.strftime("%Y-%m-%d") if post.updated_at else today
            xml_content += f'''  <url>
    <loc>https://corrigeai.online/blog/{post.slug}</loc>
    <lastmod>{lastmod}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>\n'''
        
        db.close()
    except Exception as e:
        logging.error(f"Erro ao gerar sitemap de blog: {e}")
    
    xml_content += '</urlset>'
    
    return Response(content=xml_content, media_type="application/xml")

# Endpoint de diagnóstico de CORS
@app.get("/cors-test")
def cors_test(request: Request):
    """Endpoint para testar se o CORS está funcionando"""
    return {
        "status": "ok",
        "message": "Se você está vendo isso, CORS está funcionando!",
        "origin": request.headers.get("origin", "N/A"),
        "allowed_origins": origins,
    }

# Handler explícito para OPTIONS (preflight) - FALLBACK CRÍTICO
@app.options("/{full_path:path}")
async def options_handler(request: Request):
    """Handler explícito para requisições OPTIONS (preflight CORS)"""
    origin = request.headers.get("origin", "*")
    
    # Verifica se a origem é permitida
    if origin in origins or "*" in origins:
        return JSONResponse(
            content={"status": "ok"},
            headers={
                "Access-Control-Allow-Origin": origin,
                "Access-Control-Allow-Methods": "GET, POST, PUT, PATCH, DELETE, OPTIONS",
                "Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Credentials": "true",
                "Access-Control-Max-Age": "3600",
            }
        )
    return JSONResponse(
        content={"error": "Origin not allowed"},
        status_code=403
    )

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
app.include_router(dropdown_options.router, tags=["dropdown-options"])
app.include_router(locations.router, tags=["locations"])
app.include_router(user_stats.router, tags=["user-stats"])

# AI Tutor router
from .routers import ai_tutor
app.include_router(ai_tutor.router, tags=["ai-tutor"])

# Gamification router
from .routers import gamification
app.include_router(gamification.router, tags=["gamification"])

# Exam Criteria router (centralizes vestibular criteria for frontend)
from .routers import exam_criteria_router
app.include_router(exam_criteria_router.router, tags=["exam-criteria"])

# Blog router
from .routers import blog
app.include_router(blog.router, prefix="/api/blog", tags=["blog"])

# Serve uploaded files (blog images)
from fastapi.staticfiles import StaticFiles
import os
upload_dir = "/app/uploads"
if os.path.exists(upload_dir):
    app.mount("/uploads", StaticFiles(directory=upload_dir), name="uploads")