"""
Script para gerar posts de blog sobre competências de TODOS os vestibulares.
Cada post inclui link para o site oficial do vestibular.

Uso:
    python scripts/generate_blog_posts.py --list          # Lista vestibulares
    python scripts/generate_blog_posts.py --count         # Conta total de posts possíveis
    python scripts/generate_blog_posts.py --generate-all  # Gera todos os posts
    python scripts/generate_blog_posts.py --publish       # Gera e publica
"""

import os
import sys
import asyncio
import argparse
import logging
from datetime import datetime
from pathlib import Path

# Setup path
sys.path.insert(0, str(Path(__file__).parent.parent))

from dotenv import load_dotenv
load_dotenv()

import google.generativeai as genai
from sqlalchemy.orm import Session

from src import database
from src.database import init_db_engine
from src.models import BlogPost, BlogTag
from src.exam_criteria import EXAM_TYPES

# Logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')
logger = logging.getLogger(__name__)

# Initialize database
init_db_engine()

# Configure Gemini
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
if GEMINI_API_KEY:
    genai.configure(api_key=GEMINI_API_KEY)


# ============================================================
# LINKS OFICIAIS DOS VESTIBULARES
# ============================================================
LINKS_OFICIAIS = {
    "enem": ("INEP/ENEM", "https://www.gov.br/inep/pt-br/areas-de-atuacao/avaliacao-e-exames-educacionais/enem"),
    "fuvest": ("FUVEST", "https://www.fuvest.br/"),
    "unicamp": ("COMVEST/UNICAMP", "https://www.comvest.unicamp.br/"),
    "ita": ("ITA", "http://www.ita.br/"),
    "unesp": ("VUNESP/UNESP", "https://www.vunesp.com.br/"),
    "uerj": ("UERJ Vestibular", "https://www.uerj.br/vestibular/"),
    "ufmg": ("COPEVE/UFMG", "https://www.ufmg.br/copeve/"),
    "afa": ("AFA", "https://www.fab.mil.br/afa/"),
    "cacd": ("Itamaraty/CACD", "https://www.gov.br/mre/pt-br/assuntos/carreiras/ingresso-no-itamaraty"),
    "sisu": ("SISU/MEC", "https://sisu.mec.gov.br/"),
    "unb": ("CESPE/UnB", "https://www.cespe.unb.br/"),
    "ufpr": ("NC/UFPR", "https://www.nc.ufpr.br/"),
    "ufrgs": ("COPERSE/UFRGS", "https://www.ufrgs.br/coperse/"),
    "ufsc": ("UFSC Vestibular", "https://vestibular.ufsc.br/"),
    "pucsp": ("PUC-SP Vestibular", "https://www.pucsp.br/vestibular"),
    "pucrs": ("PUCRS Vestibular", "https://www.pucrs.br/vestibular/"),
    "pucrio": ("PUC-Rio Vestibular", "https://www.puc-rio.br/vestibular/"),
    "pucminas": ("PUC-Minas Vestibular", "https://www.pucminas.br/vestibular/"),
    "pucpr": ("PUCPR Vestibular", "https://www.pucpr.br/vestibular/"),
    "puccampinas": ("PUC-Campinas Vestibular", "https://www.puc-campinas.edu.br/vestibular/"),
    "pucgoias": ("PUC-Goiás Vestibular", "https://www.pucgoias.edu.br/vestibular/"),
}

# Default para federais via SISU
DEFAULT_LINK = ("SISU/MEC", "https://sisu.mec.gov.br/")


# ============================================================
# FUNÇÕES AUXILIARES
# ============================================================
def slugify(text: str) -> str:
    """Converte texto para slug URL-friendly."""
    import re
    import unicodedata
    text = unicodedata.normalize('NFKD', text)
    text = text.encode('ascii', 'ignore').decode('ascii')
    text = text.lower().strip()
    text = re.sub(r'[^\w\s-]', '', text)
    text = re.sub(r'[-\s]+', '-', text)
    return text[:70]


def get_link_oficial(vestibular: str) -> tuple:
    """Retorna (nome, url) do link oficial."""
    return LINKS_OFICIAIS.get(vestibular, DEFAULT_LINK)


def build_vestibulares_data():
    """Constrói dados dos vestibulares a partir do exam_criteria."""
    data = []
    
    for vest_key, criteria in EXAM_TYPES.items():
        link_nome, link_url = get_link_oficial(vest_key)
        
        for idx, competencia in enumerate(criteria.competencies, 1):
            # Simplificar nome da competência
            comp_nome = competencia.split(':')[0].strip() if ':' in competencia else competencia
            if len(comp_nome) > 40:
                comp_nome = f"Competência {idx}"
            
            data.append({
                "vestibular_key": vest_key,
                "vestibular_nome": criteria.short_name,
                "vestibular_descricao": criteria.name,
                "competencia_idx": idx,
                "competencia_nome": comp_nome,
                "competencia_desc": competencia,
                "link_nome": link_nome,
                "link_url": link_url,
                "slug": slugify(f"{vest_key}-comp-{idx}"),
            })
    
    return data


# ============================================================
# GERAÇÃO DE CONTEÚDO
# ============================================================
def build_prompt(item: dict) -> str:
    """Constrói o prompt para geração do post."""
    return f"""Você é um especialista em redação para vestibulares brasileiros.
Escreva um artigo completo sobre a seguinte competência:

**Vestibular**: {item['vestibular_nome']} - {item['vestibular_descricao']}
**Competência {item['competencia_idx']}**: {item['competencia_nome']}
**Descrição completa**: {item['competencia_desc']}
**Site oficial**: {item['link_url']}

ESTRUTURA DO ARTIGO (em markdown):

## Introdução
- O que é esta competência (2 parágrafos)
- Por que é importante para a nota
- Link para o site oficial: [{item['link_nome']}]({item['link_url']})

## O que os avaliadores buscam
- Critérios específicos de avaliação (3-4 parágrafos)
- Como a nota é atribuída
- Erros que zeram ou diminuem a nota

## Dicas práticas para melhorar
- 5-7 técnicas específicas e aplicáveis
- Exemplos práticos

## Erros comuns a evitar
- 4-5 erros frequentes
- Como identificar e corrigir

## Recursos oficiais
Consulte as diretrizes oficiais em [{item['link_nome']}]({item['link_url']}) para informações atualizadas sobre os critérios de avaliação.

## Conclusão
- Resumo das principais dicas
- "Pratique sua redação no [CorrigeAI](https://corrigeai.online) e receba feedback instantâneo com IA!"

REGRAS:
- Linguagem clara e acessível
- 1000-1500 palavras
- Use markdown (negrito, listas, etc.)
- NÃO inclua título (será adicionado separadamente)
- OBRIGATÓRIO: inclua o link [{item['link_nome']}]({item['link_url']}) pelo menos 2 vezes

Escreva o artigo:"""


async def generate_content(item: dict) -> str:
    """Gera o conteúdo do post usando Gemini."""
    model = genai.GenerativeModel('gemini-2.0-flash')
    prompt = build_prompt(item)
    
    try:
        response = await model.generate_content_async(prompt)
        return response.text
    except Exception as e:
        logger.error(f"Erro Gemini: {e}")
        return None


def get_or_create_tag(db: Session, name: str, color: str = "#4F46E5") -> BlogTag:
    """Obtém ou cria uma tag."""
    slug = slugify(name)
    tag = db.query(BlogTag).filter(BlogTag.slug == slug).first()
    if not tag:
        tag = BlogTag(name=name[:50], slug=slug, color=color)
        db.add(tag)
        db.commit()
        db.refresh(tag)
    return tag


def save_post(db: Session, item: dict, content: str, publish: bool) -> BlogPost:
    """Salva o post no banco."""
    # Verificar se já existe
    existing = db.query(BlogPost).filter(BlogPost.slug == item['slug']).first()
    if existing:
        logger.info(f"   ⏭️  Já existe: {item['slug']}")
        return existing
    
    # Tags
    tags = [
        get_or_create_tag(db, item['vestibular_nome'], "#4F46E5"),
        get_or_create_tag(db, "Competências", "#10b981"),
        get_or_create_tag(db, "Dicas de Redação", "#f59e0b"),
    ]
    
    # Criar post
    title = f"{item['vestibular_nome']}: {item['competencia_nome']} - Guia Completo"
    excerpt = f"Aprenda sobre {item['competencia_nome']} do {item['vestibular_nome']}: critérios de avaliação, dicas práticas e erros a evitar."
    
    post = BlogPost(
        title=title[:200],
        slug=item['slug'],
        content=content,
        excerpt=excerpt[:300],
        meta_title=f"{item['competencia_nome']} - {item['vestibular_nome']} | CorrigeAI"[:70],
        meta_description=excerpt[:160],
        is_published=publish,
        published_at=datetime.utcnow() if publish else None,
        tags=tags
    )
    
    db.add(post)
    db.commit()
    db.refresh(post)
    return post


# ============================================================
# COMANDOS PRINCIPAIS
# ============================================================
async def generate_all(publish: bool = False, max_posts: int = 300):
    """Gera todos os posts."""
    db = database.SessionLocal()
    items = build_vestibulares_data()
    
    logger.info(f"\n{'='*60}")
    logger.info(f"📚 GERANDO POSTS PARA {len(EXAM_TYPES)} VESTIBULARES")
    logger.info(f"📝 Total de posts: {len(items)}")
    logger.info(f"{'='*60}\n")
    
    created = 0
    skipped = 0
    errors = 0
    
    try:
        for i, item in enumerate(items, 1):
            if created >= max_posts:
                logger.info(f"\n⚠️ Limite de {max_posts} posts atingido.")
                break
            
            logger.info(f"[{i}/{len(items)}] {item['vestibular_nome']} - {item['competencia_nome']}")
            
            # Verificar se já existe
            existing = db.query(BlogPost).filter(BlogPost.slug == item['slug']).first()
            if existing:
                logger.info(f"   ⏭️ Já existe")
                skipped += 1
                continue
            
            # Gerar conteúdo
            content = await generate_content(item)
            if not content:
                logger.error(f"   ❌ Erro ao gerar")
                errors += 1
                continue
            
            # Salvar
            save_post(db, item, content, publish)
            created += 1
            logger.info(f"   ✅ Criado! ({created} total)")
            
            # Delay para API
            await asyncio.sleep(1.5)
    
    finally:
        db.close()
    
    logger.info(f"\n{'='*60}")
    logger.info(f"📊 RESULTADO FINAL")
    logger.info(f"   ✅ Criados: {created}")
    logger.info(f"   ⏭️ Pulados: {skipped}")
    logger.info(f"   ❌ Erros: {errors}")
    logger.info(f"{'='*60}\n")


def list_vestibulares():
    """Lista todos os vestibulares e competências."""
    items = build_vestibulares_data()
    
    print(f"\n{'='*70}")
    print(f"📚 VESTIBULARES DISPONÍVEIS ({len(EXAM_TYPES)} total)")
    print(f"{'='*70}\n")
    
    current_vest = None
    for item in items:
        if item['vestibular_key'] != current_vest:
            current_vest = item['vestibular_key']
            link = item['link_url']
            print(f"\n🎓 {item['vestibular_nome']} ({item['vestibular_key']})")
            print(f"   🔗 {link}")
        print(f"   {item['competencia_idx']}. {item['competencia_nome']}")
    
    print(f"\n{'='*70}")
    print(f"📊 TOTAL: {len(EXAM_TYPES)} vestibulares, {len(items)} posts")
    print(f"{'='*70}\n")


def count_posts():
    """Conta posts no banco de dados."""
    db = database.SessionLocal()
    try:
        total = db.query(BlogPost).count()
        publicados = db.query(BlogPost).filter(BlogPost.is_published == True).count()
        rascunhos = db.query(BlogPost).filter(BlogPost.is_published == False).count()
        
        print(f"\n📊 POSTS NO BANCO:")
        print(f"   Total: {total}")
        print(f"   Publicados: {publicados}")
        print(f"   Rascunhos: {rascunhos}\n")
    finally:
        db.close()


def main():
    parser = argparse.ArgumentParser(description="Gerador de posts de blog")
    parser.add_argument("--list", action="store_true", help="Lista vestibulares")
    parser.add_argument("--count", action="store_true", help="Conta posts no banco")
    parser.add_argument("--generate-all", action="store_true", help="Gera todos os posts")
    parser.add_argument("--publish", action="store_true", help="Publica posts ao criar")
    parser.add_argument("--max-posts", type=int, default=300, help="Limite de posts")
    
    args = parser.parse_args()
    
    if args.list:
        list_vestibulares()
    elif args.count:
        count_posts()
    elif args.generate_all:
        asyncio.run(generate_all(publish=args.publish, max_posts=args.max_posts))
    else:
        parser.print_help()
        print("\n" + "="*50)
        print("EXEMPLOS:")
        print("  python scripts/generate_blog_posts.py --list")
        print("  python scripts/generate_blog_posts.py --count")
        print("  python scripts/generate_blog_posts.py --generate-all --publish")
        print("="*50)


if __name__ == "__main__":
    main()
