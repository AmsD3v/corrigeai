"""
Critérios de avaliação para diferentes vestibulares e concursos.
Cada vestibular tem competências/critérios específicos e pontuação própria.
"""

from typing import List
from pydantic import BaseModel


class ExamCriteria(BaseModel):
    """Modelo de critérios para um vestibular"""
    name: str
    short_name: str
    competencies: List[str]
    max_score: int
    weights: List[float]
    description: str


# Dicionário com todos os tipos de exame
EXAM_TYPES = {
    "enem": ExamCriteria(
        name="ENEM - Exame Nacional do Ensino Médio",
        short_name="ENEM",
        competencies=[
            "Demonstrar domínio da modalidade escrita formal da língua portuguesa",
            "Compreender a proposta de redação e aplicar conceitos das várias áreas de conhecimento para desenvolver o tema",
            "Selecionar, relacionar, organizar e interpretar informações, fatos, opiniões e argumentos em defesa de um ponto de vista",
            "Demonstrar conhecimento dos mecanismos linguísticos necessários para a construção da argumentação",
            "Elaborar proposta de intervenção para o problema abordado, respeitando os direitos humanos"
        ],
        max_score=1000,
        weights=[200, 200, 200, 200, 200],
        description="Redação dissertativo-argumentativa com proposta de intervenção obrigatória"
    ),
    
    "fuvest": ExamCriteria(
        name="FUVEST - Fundação Universitária para o Vestibular (USP)",
        short_name="FUVEST",
        competencies=[
            "Desenvolvimento do tema e abordagem dos elementos da proposta",
            "Estrutura e organização do texto dissertativo-argumentativo",
            "Expressão: uso adequado de gramática, vocabulário e estilo",
            "Coesão e coerência na articulação dos argumentos"
        ],
        max_score=50,
        weights=[12.5, 12.5, 12.5, 12.5],
        description="Redação com foco em desenvolvimento temático e qualidade de escrita"
    ),
    
    "unicamp": ExamCriteria(
        name="UNICAMP - Universidade Estadual de Campinas",
        short_name="UNICAMP",
        competencies=[
            "Adequação ao gênero textual proposto (carta, artigo, relato, etc.)",
            "Compreensão e desenvolvimento adequado da proposta",
            "Cumprimento do propósito comunicativo do gênero",
            "Articulação e progressão das ideias no texto",
            "Adequação linguística e domínio da norma culta"
        ],
        max_score=48,
        weights=[9.6, 9.6, 9.6, 9.6, 9.6],
        description="Redação com gêneros textuais variados e propósito comunicativo"
    ),
    
    "ita": ExamCriteria(
        name="ITA - Instituto Tecnológico de Aeronáutica",
        short_name="ITA",
        competencies=[
            "Qualidade e pertinência da argumentação técnica",
            "Rigor lógico e científico na exposição",
            "Demonstração de conhecimento técnico-científico",
            "Organização, estrutura e progressão textual",
            "Domínio da norma culta e clareza de expressão"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="Redação com foco em argumentação científica e rigor técnico"
    ),
    
    "unesp": ExamCriteria(
        name="UNESP - Universidade Estadual Paulista",
        short_name="UNESP",
        competencies=[
            "Tema: compreensão e desenvolvimento do tema proposto",
            "Estrutura e coesão: organização textual e uso de conectivos",
            "Expressão: gramática, vocabulário e adequação linguística",
            "Autoria e originalidade: posicionamento crítico e criatividade",
            "Conhecimento de mundo: repertório cultural e informativo"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="Redação com valorização de autoria e repertório cultural"
    ),
    
    "uerj": ExamCriteria(
        name="UERJ - Universidade do Estado do Rio de Janeiro",
        short_name="UERJ",
        competencies=[
            "Adequação ao tema proposto e ao gênero textual solicitado",
            "Articulação textual: coesão, coerência e progressão temática",
            "Domínio da língua padrão: gramática, vocabulário e ortografia"
        ],
        max_score=100,
        weights=[33.3, 33.3, 33.4],
        description="Redação com 3 aspectos fundamentais de avaliação"
    ),
    
    "ufmg": ExamCriteria(
        name="UFMG - Universidade Federal de Minas Gerais",
        short_name="UFMG",
        competencies=[
            "Abordagem do tema: compreensão e desenvolvimento",
            "Articulação argumentativa: defesa de ponto de vista",
            "Uso de informações: repertório e fundamentação",
            "Domínio da norma culta: gramática e adequação linguística"
        ],
        max_score=100,
        weights=[25, 25, 25, 25],
        description="Redação com equilíbrio entre tema, argumentação e linguagem"
    ),
    
    "afa": ExamCriteria(
        name="AFA - Academia da Força Aérea",
        short_name="AFA",
        competencies=[
            "Adequação ao tema e à tipologia textual dissertativa",
            "Clareza e objetividade na exposição das ideias",
            "Coerência e coesão na articulação textual",
            "Argumentação lógica e fundamentada",
            "Domínio da norma culta da língua portuguesa"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="Redação militar com foco em clareza, objetividade e lógica"
    ),
    
    "cacd": ExamCriteria(
        name="CACD - Carreira de Diplomata (Instituto Rio Branco)",
        short_name="CACD",
        competencies=[
            "Aprofundamento temático e repertório sociocultural amplo",
            "Argumentação sofisticada, analítica e multidisciplinar",
            "Domínio excepcional da norma culta e estilo formal",
            "Articulação de ideias complexas com clareza e precisão",
            "Perspectiva geopolítica, internacional e contextualizada"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="Redação de alta complexidade para elite diplomática (mais difícil do Brasil)"
    ),
    
    "sisu": ExamCriteria(
        name="SISU - Sistema de Seleção Unificada",
        short_name="SISU",
        competencies=[
            "Demonstrar domínio da modalidade escrita formal da língua portuguesa",
            "Compreender a proposta de redação e aplicar conceitos das várias áreas de conhecimento para desenvolver o tema",
            "Selecionar, relacionar, organizar e interpretar informações, fatos, opiniões e argumentos em defesa de um ponto de vista",
            "Demonstrar conhecimento dos mecanismos linguísticos necessários para a construção da argumentação",
            "Elaborar proposta de intervenção para o problema abordado, respeitando os direitos humanos"
        ],
        max_score=1000,
        weights=[200, 200, 200, 200, 200],
        description="Utiliza os mesmos critérios do ENEM (nota ENEM é usada no SISU)"
    )
}


def get_exam_criteria(exam_type: str) -> ExamCriteria:
    """
    Retorna os critérios de avaliação para um tipo de exame.
    Se o tipo não existir, retorna critérios do ENEM como padrão.
    """
    return EXAM_TYPES.get(exam_type.lower(), EXAM_TYPES["enem"])


def get_available_exams() -> List[dict]:
    """
    Retorna lista de todos os exames disponíveis com informações básicas.
    """
    return [
        {
            "id": key,
            "name": criteria.name,
            "short_name": criteria.short_name,
            "max_score": criteria.max_score,
            "description": criteria.description
        }
        for key, criteria in EXAM_TYPES.items()
    ]


def validate_exam_type(exam_type: str) -> bool:
    """Valida se o tipo de exame existe."""
    return exam_type.lower() in EXAM_TYPES
