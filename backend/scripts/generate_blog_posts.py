"""
Script para gerar posts de blog automaticamente usando IA.
Cria posts sobre competências de TODOS os vestibulares cadastrados.

Uso:
    python scripts/generate_blog_posts.py --list
    python scripts/generate_blog_posts.py --generate-all --dry-run
    python scripts/generate_blog_posts.py --generate-all --max-posts 100 --publish
    python scripts/generate_blog_posts.py --exam enem --competence 1 --publish
"""

import os
import sys
import asyncio
import argparse
import logging
from datetime import datetime
from typing import Optional
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

# Import after path setup
from dotenv import load_dotenv
load_dotenv()

import google.generativeai as genai
from sqlalchemy.orm import Session

from src import database
from src.database import init_db_engine
from src.models import BlogPost, BlogTag
from src.exam_criteria import EXAM_TYPES

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Initialize database connection
init_db_engine()

# Configure Gemini
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
if GEMINI_API_KEY:
    genai.configure(api_key=GEMINI_API_KEY)


def get_vestibulares_from_criteria():
    """
    Converte EXAM_TYPES do exam_criteria.py para o formato do gerador de posts.
    Retorna todos os 40+ vestibulares cadastrados.
    """
    vestibulares = {}
    
    for key, criteria in EXAM_TYPES.items():
        # Criar tuplas (nome, descrição) para cada competência
        competencias = []
        for i, comp in enumerate(criteria.competencies, 1):
            # Se a competência for longa, simplificar o nome
            comp_name = comp.split(':')[0].strip() if ':' in comp else comp
            if len(comp_name) > 50:
                comp_name = f"Competência {i}"
            competencias.append((comp_name, comp))
        
        vestibulares[key] = {
            "nome": criteria.short_name,
            "descricao": criteria.name,
            "competencias": competencias
        }
    
    return vestibulares


# Carrega todos os vestibulares dinamicamente
VESTIBULARES = get_vestibulares_from_criteria()


def slugify(text: str) -> str:
    """Converte texto para slug URL-friendly."""
    import re
    import unicodedata
    
    # Normaliza unicode e remove acentos
    text = unicodedata.normalize('NFKD', text)
    text = text.encode('ascii', 'ignore').decode('ascii')
    
    # Converte para minúsculas e substitui espaços
    text = text.lower().strip()
    text = re.sub(r'[^\w\s-]', '', text)
    text = re.sub(r'[-\s]+', '-', text)
    
    return text[:80]  # Limitar tamanho do slug


def generate_post_prompt(vestibular: str, competencia: tuple, info: dict) -> str:
    """Gera o prompt para criação do post."""
    comp_nome, comp_desc = competencia
    
    return f"""Você é um especialista em redação para vestibulares brasileiros. 
Escreva um artigo completo e detalhado sobre a seguinte competência do {info['nome']}:

**Vestibular**: {info['nome']} - {info['descricao']}
**Competência**: {comp_nome}
**Descrição**: {comp_desc}

ESTRUTURA DO ARTIGO (em markdown):

1. **Introdução** (2 parágrafos)
   - O que é esta competência
   - Por que é importante para a nota

2. **O que os avaliadores buscam** (3-4 parágrafos)
   - Critérios específicos de avaliação
   - Como a nota é atribuída
   - Erros que zeram ou diminuem a nota

3. **Dicas práticas para melhorar** (5-7 itens)
   - Técnicas específicas e aplicáveis
   - Exemplos práticos

4. **Erros comuns a evitar** (4-5 itens)
   - Erros frequentes dos candidatos
   - Como identificar e corrigir

5. **Exemplo prático** (se aplicável)
   - Um trecho de redação exemplar
   - Análise do que está bom

6. **Conclusão** (1-2 parágrafos)
   - Resumo das principais dicas
   - Call-to-action para praticar no CorrigeAI

REGRAS:
- Use linguagem clara e acessível para estudantes
- Seja específico e prático, não genérico
- Use listas, negrito e itálico para destacar pontos importantes
- O artigo deve ter entre 1000-1500 palavras
- NÃO inclua o título no conteúdo (será adicionado separadamente)
- Use markdown para formatação

Escreva o artigo completo:"""


async def generate_post_content(vestibular: str, competencia: tuple, info: dict, comp_index: int) -> dict:
    """Gera o conteúdo do post usando Gemini."""
    
    model = genai.GenerativeModel('gemini-2.0-flash')
    
    prompt = generate_post_prompt(vestibular, competencia, info)
    
    try:
        response = await model.generate_content_async(prompt)
        content = response.text
        
        comp_nome = competencia[0]
        vest_nome = info['nome']
        
        # Título único com vestibular e índice
        title = f"{vest_nome}: {comp_nome} - Guia Completo de Redação"
        
        # Slug único: vestibular-competencia-numero
        slug = slugify(f"{vestibular}-competencia-{comp_index}")
        
        # Gerar excerpt
        excerpt = f"Aprenda tudo sobre {comp_nome} do {vest_nome}: o que os avaliadores buscam, dicas práticas e erros comuns a evitar."
        
        return {
            "title": title[:200],
            "slug": slug,
            "content": content,
            "excerpt": excerpt[:300],
            "meta_title": f"{comp_nome} - {vest_nome} | CorrigeAI"[:70],
            "meta_description": excerpt[:160],
            "vestibular": vestibular,
            "competencia": comp_nome,
            "comp_index": comp_index
        }
        
    except Exception as e:
        logger.error(f"Erro ao gerar conteúdo: {e}")
        return None


def get_or_create_tag(db: Session, name: str, color: str = "#4F46E5") -> BlogTag:
    """Obtém ou cria uma tag."""
    slug = slugify(name)
    tag = db.query(BlogTag).filter(BlogTag.slug == slug).first()
    
    if not tag:
        tag = BlogTag(
            name=name[:50],
            slug=slug,
            color=color
        )
        db.add(tag)
        db.commit()
        db.refresh(tag)
        logger.info(f"Tag criada: {name}")
    
    return tag


def save_post(db: Session, post_data: dict, publish: bool = False) -> BlogPost:
    """Salva o post no banco de dados."""
    
    # Verificar se já existe
    existing = db.query(BlogPost).filter(BlogPost.slug == post_data["slug"]).first()
    if existing:
        logger.warning(f"Post já existe: {post_data['slug']}")
        return existing
    
    # Criar/obter tags
    tags = []
    
    # Tag do vestibular
    vest_info = VESTIBULARES.get(post_data["vestibular"], {})
    vest_tag = get_or_create_tag(
        db, 
        vest_info.get("nome", post_data["vestibular"].upper()),
        "#4F46E5"
    )
    tags.append(vest_tag)
    
    # Tag de "Competências"
    comp_tag = get_or_create_tag(db, "Competências", "#10b981")
    tags.append(comp_tag)
    
    # Tag de "Dicas de Redação"
    dicas_tag = get_or_create_tag(db, "Dicas de Redação", "#f59e0b")
    tags.append(dicas_tag)
    
    # Criar post
    post = BlogPost(
        title=post_data["title"][:200],
        slug=post_data["slug"],
        content=post_data["content"],
        excerpt=post_data["excerpt"],
        meta_title=post_data["meta_title"],
        meta_description=post_data["meta_description"],
        is_published=publish,
        published_at=datetime.utcnow() if publish else None,
        tags=tags
    )
    
    db.add(post)
    db.commit()
    db.refresh(post)
    
    logger.info(f"Post {'publicado' if publish else 'criado (rascunho)'}: {post.title}")
    return post


async def generate_all_posts(max_posts: int = 100, publish: bool = False, dry_run: bool = False):
    """Gera posts para TODOS os vestibulares e competências."""
    
    db = database.SessionLocal()
    posts_generated = 0
    posts_skipped = 0
    
    # Calcular total de posts possíveis
    total_possible = sum(len(v["competencias"]) for v in VESTIBULARES.values())
    logger.info(f"\n📚 Total de vestibulares: {len(VESTIBULARES)}")
    logger.info(f"📝 Total de posts possíveis: {total_possible}")
    logger.info(f"🎯 Limite definido: {max_posts}\n")
    
    try:
        for vest_key, vest_info in VESTIBULARES.items():
            if posts_generated >= max_posts:
                break
                
            logger.info(f"\n{'='*60}")
            logger.info(f"📌 Vestibular: {vest_info['nome']} ({vest_info['descricao'][:50]}...)")
            logger.info(f"   Competências: {len(vest_info['competencias'])}")
            logger.info(f"{'='*60}")
            
            for idx, competencia in enumerate(vest_info["competencias"], 1):
                if posts_generated >= max_posts:
                    break
                
                comp_nome = competencia[0]
                logger.info(f"\n  [{idx}/{len(vest_info['competencias'])}] {comp_nome}")
                
                # Verificar se já existe - usando novo formato de slug único
                slug = slugify(f"{vest_key}-competencia-{idx}")
                existing = db.query(BlogPost).filter(BlogPost.slug == slug).first()
                if existing:
                    logger.info(f"      ⏭️  Já existe ({slug}), pulando...")
                    posts_skipped += 1
                    continue
                
                if dry_run:
                    logger.info(f"      🔍 [DRY RUN] Seria criado: {slug}")
                    posts_generated += 1
                    continue
                
                # Gerar conteúdo (passando o índice para slug único)
                post_data = await generate_post_content(vest_key, competencia, vest_info, idx)
                
                if post_data:
                    save_post(db, post_data, publish=publish)
                    posts_generated += 1
                    logger.info(f"      ✅ Post #{posts_generated} criado!")
                    
                    # Delay para não sobrecarregar a API
                    await asyncio.sleep(2)
                else:
                    logger.error(f"      ❌ Falha ao gerar conteúdo")
        
        logger.info(f"\n{'='*60}")
        logger.info(f"📊 RESUMO FINAL")
        logger.info(f"{'='*60}")
        logger.info(f"   ✅ Posts gerados: {posts_generated}")
        logger.info(f"   ⏭️  Posts pulados (já existiam): {posts_skipped}")
        logger.info(f"   📚 Total vestibulares processados: {len(VESTIBULARES)}")
        logger.info(f"{'='*60}\n")
        
    finally:
        db.close()


async def generate_single_post(exam: str, competence_index: int, publish: bool = False):
    """Gera um único post para um vestibular e competência específicos."""
    
    if exam not in VESTIBULARES:
        logger.error(f"Vestibular não encontrado: {exam}")
        logger.info(f"Disponíveis: {list(VESTIBULARES.keys())}")
        return
    
    vest_info = VESTIBULARES[exam]
    
    if competence_index < 1 or competence_index > len(vest_info["competencias"]):
        logger.error(f"Competência inválida: {competence_index}")
        logger.info(f"Disponíveis: 1 a {len(vest_info['competencias'])}")
        return
    
    competencia = vest_info["competencias"][competence_index - 1]
    
    db = database.SessionLocal()
    try:
        logger.info(f"Gerando: {competencia[0]} ({vest_info['nome']})")
        
        # Passando o índice para slug único
        post_data = await generate_post_content(exam, competencia, vest_info, competence_index)
        
        if post_data:
            save_post(db, post_data, publish=publish)
            logger.info("Post criado com sucesso!")
        else:
            logger.error("Falha ao gerar conteúdo")
            
    finally:
        db.close()


def list_vestibulares():
    """Lista todos os vestibulares e suas competências."""
    print(f"\n{'='*70}")
    print(f"📚 VESTIBULARES DISPONÍVEIS ({len(VESTIBULARES)} total)")
    print(f"{'='*70}\n")
    
    total_comps = 0
    for key, info in VESTIBULARES.items():
        num_comps = len(info['competencias'])
        total_comps += num_comps
        print(f"  {key:12} | {info['nome']:15} | {num_comps} competências")
        for i, comp in enumerate(info['competencias'], 1):
            comp_name = comp[0][:45] + "..." if len(comp[0]) > 45 else comp[0]
            print(f"               |    {i}. {comp_name}")
        print()
    
    print(f"{'='*70}")
    print(f"📊 TOTAL: {len(VESTIBULARES)} vestibulares, {total_comps} posts possíveis")
    print(f"{'='*70}\n")


def main():
    parser = argparse.ArgumentParser(description="Gerador automático de posts de blog sobre TODOS os vestibulares")
    
    parser.add_argument("--generate-all", action="store_true", help="Gera posts para todos os vestibulares")
    parser.add_argument("--exam", type=str, help="Vestibular específico (enem, fuvest, unicamp, etc.)")
    parser.add_argument("--competence", type=int, help="Número da competência (1, 2, 3...)")
    parser.add_argument("--max-posts", type=int, default=200, help="Máximo de posts a gerar (padrão: 200)")
    parser.add_argument("--publish", action="store_true", help="Publicar posts imediatamente")
    parser.add_argument("--dry-run", action="store_true", help="Simula sem criar posts")
    parser.add_argument("--list", action="store_true", help="Lista vestibulares e competências")
    
    args = parser.parse_args()
    
    if args.list:
        list_vestibulares()
        return
    
    if args.generate_all:
        asyncio.run(generate_all_posts(
            max_posts=args.max_posts,
            publish=args.publish,
            dry_run=args.dry_run
        ))
    elif args.exam and args.competence:
        asyncio.run(generate_single_post(
            exam=args.exam,
            competence_index=args.competence,
            publish=args.publish
        ))
    else:
        parser.print_help()
        print("\n" + "="*60)
        print("EXEMPLOS:")
        print("="*60)
        print("  # Listar todos os vestibulares")
        print("  python scripts/generate_blog_posts.py --list")
        print()
        print("  # Simular geração (dry-run)")
        print("  python scripts/generate_blog_posts.py --generate-all --dry-run")
        print()
        print("  # Gerar 50 posts e publicar")
        print("  python scripts/generate_blog_posts.py --generate-all --max-posts 50 --publish")
        print()
        print("  # Gerar post específico")
        print("  python scripts/generate_blog_posts.py --exam enem --competence 1 --publish")
        print("="*60)


if __name__ == "__main__":
    main()
