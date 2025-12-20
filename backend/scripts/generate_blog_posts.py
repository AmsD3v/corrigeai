"""
Script para gerar posts de blog automaticamente usando IA.
Cria posts sobre competências de cada vestibular principal.

Uso:
    python generate_blog_posts.py --max-posts 10 --dry-run
    python generate_blog_posts.py --exam enem --competence 1
    python generate_blog_posts.py --generate-all
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

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# Initialize database connection
init_db_engine()

# Configure Gemini
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
if GEMINI_API_KEY:
    genai.configure(api_key=GEMINI_API_KEY)

# Vestibulares com critérios próprios (não via SISU)
VESTIBULARES_PRINCIPAIS = {
    "enem": {
        "nome": "ENEM",
        "descricao": "Exame Nacional do Ensino Médio",
        "competencias": [
            ("Competência 1", "Domínio da modalidade escrita formal da língua portuguesa"),
            ("Competência 2", "Compreensão da proposta e aplicação de conceitos"),
            ("Competência 3", "Seleção, organização e interpretação de informações"),
            ("Competência 4", "Mecanismos linguísticos para argumentação"),
            ("Competência 5", "Proposta de intervenção")
        ]
    },
    "fuvest": {
        "nome": "FUVEST (USP)",
        "descricao": "Vestibular da Universidade de São Paulo",
        "competencias": [
            ("Desenvolvimento do tema", "Abordagem dos elementos da proposta"),
            ("Estrutura", "Organização do texto dissertativo-argumentativo"),
            ("Expressão", "Uso adequado de gramática, vocabulário e estilo"),
            ("Coesão e coerência", "Articulação dos argumentos")
        ]
    },
    "unicamp": {
        "nome": "UNICAMP",
        "descricao": "Universidade Estadual de Campinas",
        "competencias": [
            ("Gênero textual", "Adequação ao gênero proposto (carta, artigo, etc.)"),
            ("Desenvolvimento", "Compreensão e desenvolvimento da proposta"),
            ("Propósito comunicativo", "Cumprimento do objetivo do gênero"),
            ("Articulação", "Progressão das ideias no texto"),
            ("Adequação linguística", "Domínio da norma culta")
        ]
    },
    "ita": {
        "nome": "ITA",
        "descricao": "Instituto Tecnológico de Aeronáutica",
        "competencias": [
            ("Argumentação técnica", "Qualidade e pertinência da argumentação"),
            ("Rigor lógico", "Exposição científica rigorosa"),
            ("Conhecimento técnico", "Demonstração de conhecimento técnico-científico"),
            ("Organização", "Estrutura e progressão textual"),
            ("Clareza", "Domínio da norma culta e clareza")
        ]
    },
    "unesp": {
        "nome": "UNESP",
        "descricao": "Universidade Estadual Paulista",
        "competencias": [
            ("Tema", "Compreensão e desenvolvimento do tema"),
            ("Estrutura", "Organização textual e uso de conectivos"),
            ("Expressão", "Gramática, vocabulário e adequação linguística"),
            ("Autoria", "Posicionamento crítico e criatividade"),
            ("Repertório", "Conhecimento de mundo e repertório cultural")
        ]
    },
    "uerj": {
        "nome": "UERJ",
        "descricao": "Universidade do Estado do Rio de Janeiro",
        "competencias": [
            ("Adequação ao tema", "Desenvolvimento do tema proposto e gênero textual"),
            ("Articulação textual", "Coesão, coerência e organização de ideias"),
            ("Domínio da língua", "Gramática, ortografia e vocabulário")
        ]
    },
    "ufmg": {
        "nome": "UFMG",
        "descricao": "Universidade Federal de Minas Gerais",
        "competencias": [
            ("Abordagem temática", "Compreensão e desenvolvimento do tema"),
            ("Articulação argumentativa", "Qualidade e consistência dos argumentos"),
            ("Fundamentação", "Uso adequado de informações e dados"),
            ("Domínio linguístico", "Gramática, ortografia e expressão")
        ]
    },
    "afa": {
        "nome": "AFA",
        "descricao": "Academia da Força Aérea",
        "competencias": [
            ("Adequação ao tema", "Desenvolvimento do tema proposto"),
            ("Clareza e objetividade", "Exposição clara de ideias"),
            ("Coerência e coesão", "Estruturação textual"),
            ("Argumentação lógica", "Fundamentação dos argumentos"),
            ("Domínio linguístico", "Norma culta da língua portuguesa")
        ]
    },
    "cacd": {
        "nome": "CACD",
        "descricao": "Concurso de Admissão à Carreira de Diplomata",
        "competencias": [
            ("Aprofundamento temático", "Domínio do assunto"),
            ("Argumentação sofisticada", "Fundamentação elaborada"),
            ("Norma culta formal", "Domínio linguístico elevado"),
            ("Articulação lógica", "Estruturação e progressão"),
            ("Perspectiva geopolítica", "Relações internacionais")
        ]
    },
    "unb": {
        "nome": "UnB",
        "descricao": "Universidade de Brasília",
        "competencias": [
            ("Macroestrutura", "Adequação ao tema, estrutura e coerência global"),
            ("Microestrutura", "Ortografia, morfossintaxe, pontuação e vocabulário")
        ]
    },
    "ufpr": {
        "nome": "UFPR",
        "descricao": "Universidade Federal do Paraná",
        "competencias": [
            ("Questão 1", "Produção textual conforme gênero solicitado"),
            ("Questão 2", "Produção textual conforme gênero solicitado"),
            ("Questão 3", "Produção textual conforme gênero solicitado")
        ]
    },
    "ufrgs": {
        "nome": "UFRGS",
        "descricao": "Universidade Federal do Rio Grande do Sul",
        "competencias": [
            ("Aspecto Analítico", "Estrutura, conteúdo e organização"),
            ("Aspecto Holístico", "Efeito geral, clareza e consistência"),
            ("Expressão Linguística", "Ortografia, sintaxe e vocabulário")
        ]
    },
    "ufsc": {
        "nome": "UFSC",
        "descricao": "Universidade Federal de Santa Catarina",
        "competencias": [
            ("Adequação à proposta", "Tema e gênero textual"),
            ("Norma padrão", "Ortografia, gramática e pontuação"),
            ("Coerência e coesão", "Articulação e progressão das ideias"),
            ("Informatividade", "Argumentação conforme gênero")
        ]
    },
    "pucsp": {
        "nome": "PUC-SP",
        "descricao": "Pontifícia Universidade Católica de São Paulo",
        "competencias": [
            ("Tipo de texto", "Adequação ao gênero dissertativo"),
            ("Adequação ao tema", "Desenvolvimento do assunto proposto"),
            ("Coerência", "Lógica e viabilidade das ideias"),
            ("Coesão", "Articulação e elementos coesivos"),
            ("Norma padrão", "Gramática, ortografia e pontuação")
        ]
    },
    "pucrs": {
        "nome": "PUCRS",
        "descricao": "Pontifícia Universidade Católica do Rio Grande do Sul",
        "competencias": [
            ("Conteúdo", "Conhecimento, compreensão e análise do tema"),
            ("Estrutura", "Organização, parágrafos e encadeamento lógico"),
            ("Expressão Linguística", "Norma culta, vocabulário e legibilidade")
        ]
    }
}


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
    
    return text


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


async def generate_post_content(vestibular: str, competencia: tuple, info: dict) -> dict:
    """Gera o conteúdo do post usando Gemini."""
    
    model = genai.GenerativeModel('gemini-2.0-flash')
    
    prompt = generate_post_prompt(vestibular, competencia, info)
    
    try:
        response = await model.generate_content_async(prompt)
        content = response.text
        
        comp_nome = competencia[0]
        title = f"Como dominar a {comp_nome} do {info['nome']} - Guia Completo"
        slug = slugify(f"{comp_nome}-{vestibular}-guia-completo")
        
        # Gerar excerpt
        excerpt = f"Aprenda tudo sobre a {comp_nome} do {info['nome']}: o que os avaliadores buscam, dicas práticas e erros comuns a evitar."
        
        return {
            "title": title,
            "slug": slug,
            "content": content,
            "excerpt": excerpt,
            "meta_title": f"{comp_nome} {info['nome']} - Dicas e Guia Completo | CorrigeAI",
            "meta_description": excerpt,
            "vestibular": vestibular,
            "competencia": comp_nome
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
            name=name,
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
    vest_tag = get_or_create_tag(
        db, 
        VESTIBULARES_PRINCIPAIS[post_data["vestibular"]]["nome"],
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
        title=post_data["title"],
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


async def generate_all_posts(max_posts: int = 50, publish: bool = False, dry_run: bool = False):
    """Gera posts para todos os vestibulares e competências."""
    
    db = database.SessionLocal()
    posts_generated = 0
    
    try:
        for vest_key, vest_info in VESTIBULARES_PRINCIPAIS.items():
            if posts_generated >= max_posts:
                break
                
            logger.info(f"\n{'='*50}")
            logger.info(f"Vestibular: {vest_info['nome']}")
            logger.info(f"{'='*50}")
            
            for competencia in vest_info["competencias"]:
                if posts_generated >= max_posts:
                    break
                
                comp_nome = competencia[0]
                logger.info(f"\nGerando post: {comp_nome} ({vest_info['nome']})")
                
                # Verificar se já existe
                slug = slugify(f"{comp_nome}-{vest_key}-guia-completo")
                existing = db.query(BlogPost).filter(BlogPost.slug == slug).first()
                if existing:
                    logger.info(f"  → Já existe, pulando...")
                    continue
                
                if dry_run:
                    logger.info(f"  → [DRY RUN] Seria criado: {slug}")
                    posts_generated += 1
                    continue
                
                # Gerar conteúdo
                post_data = await generate_post_content(vest_key, competencia, vest_info)
                
                if post_data:
                    save_post(db, post_data, publish=publish)
                    posts_generated += 1
                    
                    # Delay para não sobrecarregar a API
                    await asyncio.sleep(2)
                else:
                    logger.error(f"  → Falha ao gerar conteúdo")
        
        logger.info(f"\n{'='*50}")
        logger.info(f"Total de posts gerados: {posts_generated}")
        logger.info(f"{'='*50}")
        
    finally:
        db.close()


async def generate_single_post(exam: str, competence_index: int, publish: bool = False):
    """Gera um único post para um vestibular e competência específicos."""
    
    if exam not in VESTIBULARES_PRINCIPAIS:
        logger.error(f"Vestibular não encontrado: {exam}")
        logger.info(f"Disponíveis: {list(VESTIBULARES_PRINCIPAIS.keys())}")
        return
    
    vest_info = VESTIBULARES_PRINCIPAIS[exam]
    
    if competence_index < 1 or competence_index > len(vest_info["competencias"]):
        logger.error(f"Competência inválida: {competence_index}")
        logger.info(f"Disponíveis: 1 a {len(vest_info['competencias'])}")
        return
    
    competencia = vest_info["competencias"][competence_index - 1]
    
    db = database.SessionLocal()
    try:
        logger.info(f"Gerando: {competencia[0]} ({vest_info['nome']})")
        
        post_data = await generate_post_content(exam, competencia, vest_info)
        
        if post_data:
            save_post(db, post_data, publish=publish)
            logger.info("Post criado com sucesso!")
        else:
            logger.error("Falha ao gerar conteúdo")
            
    finally:
        db.close()


def list_vestibulares():
    """Lista todos os vestibulares e suas competências."""
    print("\nVestibulares disponíveis:\n")
    
    for key, info in VESTIBULARES_PRINCIPAIS.items():
        print(f"  {key}: {info['nome']}")
        for i, comp in enumerate(info['competencias'], 1):
            print(f"    {i}. {comp[0]}: {comp[1]}")
        print()


def main():
    parser = argparse.ArgumentParser(description="Gerador automático de posts de blog sobre vestibulares")
    
    parser.add_argument("--generate-all", action="store_true", help="Gera posts para todos os vestibulares")
    parser.add_argument("--exam", type=str, help="Vestibular específico (enem, fuvest, unicamp, etc.)")
    parser.add_argument("--competence", type=int, help="Número da competência (1, 2, 3...)")
    parser.add_argument("--max-posts", type=int, default=50, help="Máximo de posts a gerar")
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
        print("\nExemplos:")
        print("  python generate_blog_posts.py --list")
        print("  python generate_blog_posts.py --generate-all --dry-run")
        print("  python generate_blog_posts.py --generate-all --max-posts 5")
        print("  python generate_blog_posts.py --exam enem --competence 1")
        print("  python generate_blog_posts.py --exam enem --competence 5 --publish")


if __name__ == "__main__":
    main()
