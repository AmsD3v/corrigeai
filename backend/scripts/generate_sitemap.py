#!/usr/bin/env python3
"""
Script para gerar sitemap.xml completo com todos os posts do blog.
Execute: python generate_sitemap.py > sitemap.xml
"""

import os
import sys
from datetime import datetime

# Adiciona o path do projeto
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import init_db_engine, get_db
from src.models import BlogPost

def main():
    init_db_engine()
    
    # Páginas estáticas
    static_pages = [
        ('/', '1.0', 'weekly'),
        ('/login', '0.6', 'monthly'),
        ('/cadastro', '0.9', 'monthly'),
        ('/sobre', '0.8', 'monthly'),
        ('/blog', '0.9', 'daily'),
        ('/repertorios', '0.8', 'weekly'),
        ('/demonstracao', '0.8', 'monthly'),
    ]
    
    today = datetime.now().strftime('%Y-%m-%d')
    
    print('<?xml version="1.0" encoding="UTF-8"?>')
    print('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
    
    # Páginas estáticas
    for path, priority, changefreq in static_pages:
        print(f'  <url>')
        print(f'    <loc>https://corrigeai.online{path}</loc>')
        print(f'    <lastmod>{today}</lastmod>')
        print(f'    <changefreq>{changefreq}</changefreq>')
        print(f'    <priority>{priority}</priority>')
        print(f'  </url>')
    
    # Posts do blog
    db = next(get_db())
    posts = db.query(BlogPost).filter(BlogPost.is_published == True).all()
    
    for post in posts:
        lastmod = (post.updated_at or post.created_at or datetime.now()).strftime('%Y-%m-%d')
        print(f'  <url>')
        print(f'    <loc>https://corrigeai.online/blog/{post.slug}</loc>')
        print(f'    <lastmod>{lastmod}</lastmod>')
        print(f'    <changefreq>monthly</changefreq>')
        print(f'    <priority>0.7</priority>')
        print(f'  </url>')
    
    print('</urlset>')
    
    # Log para stderr
    print(f"\n# Total: {len(static_pages)} páginas estáticas + {len(posts)} posts = {len(static_pages) + len(posts)} URLs", file=sys.stderr)

if __name__ == "__main__":
    main()
