"""
Script para diagnosticar e corrigir posts do blog.
Verifica posts não publicados, adiciona links externos, etc.

Uso:
    python scripts/fix_blog_posts.py --diagnose
    python scripts/fix_blog_posts.py --publish-all
    python scripts/fix_blog_posts.py --add-links
"""

import os
import sys
import argparse
import logging
from datetime import datetime
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

from dotenv import load_dotenv
load_dotenv()

from src import database
from src.database import init_db_engine
from src.models import BlogPost, BlogTag

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Initialize database
init_db_engine()

# Links oficiais dos vestibulares
LINKS_OFICIAIS = {
    "enem": ("INEP/ENEM", "https://www.gov.br/inep/pt-br/areas-de-atuacao/avaliacao-e-exames-educacionais/enem"),
    "fuvest": ("FUVEST", "https://www.fuvest.br/"),
    "unicamp": ("COMVEST/UNICAMP", "https://www.comvest.unicamp.br/"),
    "ita": ("ITA", "http://www.ita.br/"),
    "unesp": ("VUNESP/UNESP", "https://www.vunesp.com.br/"),
    "uerj": ("UERJ", "https://www.uerj.br/vestibular/"),
    "ufmg": ("COPEVE/UFMG", "https://www.ufmg.br/copeve/"),
    "afa": ("AFA", "https://www.fab.mil.br/afa/"),
    "cacd": ("Itamaraty/CACD", "https://www.gov.br/mre/pt-br/assuntos/carreiras/ingresso-no-itamaraty"),
    "sisu": ("SISU/MEC", "https://sisu.mec.gov.br/"),
    "unb": ("CESPE/UnB", "https://www.cespe.unb.br/"),
    "ufpr": ("NC/UFPR", "https://www.nc.ufpr.br/"),
    "ufrgs": ("COPERSE/UFRGS", "https://www.ufrgs.br/coperse/"),
    "ufsc": ("UFSC", "https://vestibular.ufsc.br/"),
    "pucsp": ("PUC-SP", "https://www.pucsp.br/vestibular"),
    "pucrs": ("PUCRS", "https://www.pucrs.br/vestibular/"),
    "pucrio": ("PUC-Rio", "https://www.puc-rio.br/vestibular/"),
    "pucminas": ("PUC-Minas", "https://www.pucminas.br/vestibular/"),
    "pucpr": ("PUCPR", "https://www.pucpr.br/vestibular/"),
    "puccampinas": ("PUC-Campinas", "https://www.puc-campinas.edu.br/vestibular/"),
    "pucgoias": ("PUC-Goiás", "https://www.pucgoias.edu.br/vestibular/")
}

# Default para federais via SISU
DEFAULT_LINK = ("SISU/MEC", "https://sisu.mec.gov.br/")


def diagnose():
    """Diagnostica o estado dos posts no banco."""
    db = database.SessionLocal()
    
    try:
        total = db.query(BlogPost).count()
        publicados = db.query(BlogPost).filter(BlogPost.is_published == True).count()
        rascunhos = db.query(BlogPost).filter(BlogPost.is_published == False).count()
        
        print(f"\n{'='*60}")
        print(f"📊 DIAGNÓSTICO DO BLOG")
        print(f"{'='*60}")
        print(f"   📝 Total de posts: {total}")
        print(f"   ✅ Publicados: {publicados}")
        print(f"   📋 Rascunhos: {rascunhos}")
        
        # Verificar posts sem links externos
        posts_sem_link = 0
        posts_com_link = 0
        
        all_posts = db.query(BlogPost).all()
        for post in all_posts:
            if 'https://' in post.content and ('gov.br' in post.content or 'fuvest' in post.content or 'unicamp' in post.content or 'sisu.mec' in post.content):
                posts_com_link += 1
            else:
                posts_sem_link += 1
        
        print(f"\n   🔗 Posts COM links externos: {posts_com_link}")
        print(f"   ❌ Posts SEM links externos: {posts_sem_link}")
        
        # Listar alguns posts rascunho
        if rascunhos > 0:
            print(f"\n📋 Primeiros rascunhos:")
            drafts = db.query(BlogPost).filter(BlogPost.is_published == False).limit(5).all()
            for d in drafts:
                print(f"   - {d.slug}: {d.title[:50]}...")
        
        print(f"{'='*60}\n")
        
    finally:
        db.close()


def publish_all():
    """Publica todos os posts que estão como rascunho."""
    db = database.SessionLocal()
    
    try:
        rascunhos = db.query(BlogPost).filter(BlogPost.is_published == False).all()
        
        print(f"\n📝 Publicando {len(rascunhos)} rascunhos...")
        
        for post in rascunhos:
            post.is_published = True
            post.published_at = datetime.utcnow()
            logger.info(f"✅ Publicado: {post.slug}")
        
        db.commit()
        print(f"\n✅ {len(rascunhos)} posts publicados com sucesso!")
        
    finally:
        db.close()


def add_links_to_posts():
    """Adiciona links externos aos posts que não têm."""
    db = database.SessionLocal()
    
    try:
        all_posts = db.query(BlogPost).all()
        updated = 0
        
        print(f"\n🔗 Verificando {len(all_posts)} posts...")
        
        for post in all_posts:
            # Identificar vestibular pelo slug
            vestibular = None
            for v in LINKS_OFICIAIS.keys():
                if post.slug.startswith(v + '-') or v in post.slug:
                    vestibular = v
                    break
            
            if not vestibular:
                # Tentar identificar pelo título
                title_lower = post.title.lower()
                for v in LINKS_OFICIAIS.keys():
                    if v in title_lower:
                        vestibular = v
                        break
            
            # Se ainda não identificou, usar SISU como padrão
            nome, link = LINKS_OFICIAIS.get(vestibular, DEFAULT_LINK)
            
            # Verificar se já tem link
            if link in post.content:
                continue
            
            # Adicionar seção de recursos oficiais no final
            recursos_section = f"""

---

## 📚 Recursos Oficiais

Para mais informações sobre os critérios oficiais de avaliação, consulte o site oficial:
- [{nome}]({link})

---

💡 **Pratique agora!** Envie sua redação no [CorrigeAI](https://corrigeai.online) e receba feedback instantâneo com Inteligência Artificial!
"""
            
            # Verificar se já tem seção de recursos
            if "Recursos Oficiais" not in post.content and "Pratique agora" not in post.content:
                post.content = post.content + recursos_section
                updated += 1
                logger.info(f"✅ Link adicionado: {post.slug} -> {link}")
        
        db.commit()
        print(f"\n✅ {updated} posts atualizados com links externos!")
        
    finally:
        db.close()


def main():
    parser = argparse.ArgumentParser(description="Ferramentas para corrigir posts do blog")
    
    parser.add_argument("--diagnose", action="store_true", help="Diagnostica o estado dos posts")
    parser.add_argument("--publish-all", action="store_true", help="Publica todos os rascunhos")
    parser.add_argument("--add-links", action="store_true", help="Adiciona links externos aos posts")
    
    args = parser.parse_args()
    
    if args.diagnose:
        diagnose()
    elif args.publish_all:
        publish_all()
    elif args.add_links:
        add_links_to_posts()
    else:
        parser.print_help()
        print("\nExemplos:")
        print("  python scripts/fix_blog_posts.py --diagnose")
        print("  python scripts/fix_blog_posts.py --publish-all")
        print("  python scripts/fix_blog_posts.py --add-links")


if __name__ == "__main__":
    main()
