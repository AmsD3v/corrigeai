"""
Router para SEO - Sitemap dinâmico
"""
from fastapi import APIRouter, Depends
from fastapi.responses import Response
from sqlalchemy.orm import Session
from datetime import datetime

from ..database import get_db
from ..models import BlogPost

router = APIRouter(tags=["SEO"])

# Páginas estáticas do site
STATIC_PAGES = [
    {"url": "/", "priority": "1.0", "changefreq": "weekly"},
    {"url": "/login", "priority": "0.8", "changefreq": "monthly"},
    {"url": "/cadastro", "priority": "0.9", "changefreq": "monthly"},
    {"url": "/sobre", "priority": "0.8", "changefreq": "monthly"},
    {"url": "/blog", "priority": "0.9", "changefreq": "daily"},
    {"url": "/demonstracao", "priority": "0.9", "changefreq": "weekly"},
    {"url": "/repertorios", "priority": "0.9", "changefreq": "weekly"},
]


@router.get("/sitemap.xml")
async def get_sitemap(db: Session = Depends(get_db)):
    """
    Gera sitemap.xml dinâmico incluindo todas as páginas e posts do blog.
    """
    base_url = "https://corrigeai.online"
    today = datetime.now().strftime("%Y-%m-%d")
    
    # Início do XML
    xml_content = '<?xml version="1.0" encoding="UTF-8"?>\n'
    xml_content += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
    
    # Adicionar páginas estáticas
    for page in STATIC_PAGES:
        xml_content += f'''  <url>
    <loc>{base_url}{page["url"]}</loc>
    <lastmod>{today}</lastmod>
    <changefreq>{page["changefreq"]}</changefreq>
    <priority>{page["priority"]}</priority>
  </url>
'''
    
    # Adicionar posts do blog (apenas publicados)
    posts = db.query(BlogPost).filter(BlogPost.is_published == True).all()
    
    for post in posts:
        lastmod = post.updated_at.strftime("%Y-%m-%d") if post.updated_at else today
        xml_content += f'''  <url>
    <loc>{base_url}/blog/{post.slug}</loc>
    <lastmod>{lastmod}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>
'''
    
    # Fechar XML
    xml_content += '</urlset>'
    
    return Response(
        content=xml_content,
        media_type="application/xml",
        headers={
            "Cache-Control": "public, max-age=3600",  # Cache por 1 hora
            "X-Robots-Tag": "noindex"  # Não indexar o próprio sitemap
        }
    )
