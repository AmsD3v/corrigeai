"""
Critérios de avaliação para diferentes vestibulares e concursos.
Cada vestibular tem competências/critérios específicos e pontuação própria.

CRITÉRIOS VERIFICADOS VIA PESQUISA OFICIAL:
- ENEM, FUVEST, UNICAMP, ITA, UNESP, UERJ, UnB, UFPR, UFRGS, UFSC
- PUC-SP, PUCRS, PUC-Rio, PUC-Minas, PUCPR
- Federais via SISU: usam critérios ENEM com nome próprio
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


# Competências padrão ENEM (usadas por federais via SISU)
ENEM_COMPETENCIES = [
    "Demonstrar domínio da modalidade escrita formal da língua portuguesa",
    "Compreender a proposta de redação e aplicar conceitos das várias áreas de conhecimento",
    "Selecionar, relacionar, organizar e interpretar informações, fatos e argumentos",
    "Demonstrar conhecimento dos mecanismos linguísticos necessários para a argumentação",
    "Elaborar proposta de intervenção para o problema abordado, respeitando os direitos humanos"
]
ENEM_WEIGHTS = [200, 200, 200, 200, 200]


# Dicionário com todos os tipos de exame
EXAM_TYPES = {
    # ========== PRINCIPAIS (CRITÉRIOS PRÓPRIOS VERIFICADOS) ==========
    
    "enem": ExamCriteria(
        name="ENEM - Exame Nacional do Ensino Médio",
        short_name="ENEM",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
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
        description="Redação com foco em desenvolvimento temático autoral (sem proposta de intervenção). Título OBRIGATÓRIO."
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
        description="Redação com gêneros textuais VARIADOS (carta, artigo, discurso). Gênero é FUNDAMENTAL."
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
        description="Redação com foco em argumentação científica, rigor técnico e objetividade"
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
            "Articulação textual: coesão, coerência e organização de ideias",
            "Domínio da língua: gramática, ortografia e vocabulário"
        ],
        max_score=100,
        weights=[33.3, 33.3, 33.4],
        description="Redação com 3 critérios principais e ênfase em articulação"
    ),
    
    "ufmg": ExamCriteria(
        name="UFMG - Universidade Federal de Minas Gerais",
        short_name="UFMG",
        competencies=[
            "Abordagem temática: compreensão e desenvolvimento do tema",
            "Articulação argumentativa: qualidade e consistência dos argumentos",
            "Uso adequado de informações e dados para fundamentar",
            "Domínio da norma culta: gramática, ortografia e expressão"
        ],
        max_score=100,
        weights=[25, 25, 25, 25],
        description="Redação com foco em articulação argumentativa"
    ),
    
    "afa": ExamCriteria(
        name="AFA - Academia da Força Aérea",
        short_name="AFA",
        competencies=[
            "Adequação ao tema proposto na prova",
            "Clareza e objetividade na exposição de ideias",
            "Coerência e coesão na estruturação textual",
            "Argumentação lógica e fundamentada",
            "Domínio da norma culta da língua portuguesa"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="Redação militar com clareza, objetividade e rigor"
    ),
    
    "cacd": ExamCriteria(
        name="CACD - Concurso de Admissão à Carreira de Diplomata",
        short_name="CACD",
        competencies=[
            "Aprofundamento temático e domínio do assunto",
            "Argumentação sofisticada e bem fundamentada",
            "Domínio da norma culta formal",
            "Articulação de ideias e estruturação lógica",
            "Perspectiva geopolítica e relações internacionais"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="Redação de alto nível para carreira diplomática"
    ),
    
    "sisu": ExamCriteria(
        name="SISU - Sistema de Seleção Unificada",
        short_name="SISU",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Utiliza os mesmos critérios do ENEM (nota ENEM é usada no SISU)"
    ),
    
    # ========== VESTIBULARES PRÓPRIOS VERIFICADOS (SUL) ==========
    
    "unb": ExamCriteria(
        name="UnB - Universidade de Brasília",
        short_name="UnB",
        competencies=[
            "Macroestrutura: adequação ao tema, estrutura, coerência global",
            "Microestrutura: ortografia, morfossintaxe, pontuação, vocabulário"
        ],
        max_score=10,
        weights=[5, 5],
        description="Sistema único com fórmula: NR = NC – 2 × (NE / TL). Aceita vários gêneros textuais."
    ),
    
    "ufpr": ExamCriteria(
        name="UFPR - Universidade Federal do Paraná",
        short_name="UFPR",
        competencies=[
            "Questão 1: Produção textual conforme gênero solicitado",
            "Questão 2: Produção textual conforme gênero solicitado",
            "Questão 3: Produção textual conforme gênero solicitado"
        ],
        max_score=60,
        weights=[20, 20, 20],
        description="3 questões discursivas de 20 pts cada. Múltiplos gêneros (resumo, continuação, dissertação)."
    ),
    
    "ufrgs": ExamCriteria(
        name="UFRGS - Universidade Federal do Rio Grande do Sul",
        short_name="UFRGS",
        competencies=[
            "Aspecto Analítico: estrutura, conteúdo, organização",
            "Aspecto Holístico: efeito geral, clareza, consistência",
            "Expressão Linguística: ortografia, sintaxe, vocabulário"
        ],
        max_score=30,
        weights=[10, 10, 10],
        description="Sistema holístico + analítico. Título obrigatório. Peso 3 no vestibular."
    ),
    
    "ufsc": ExamCriteria(
        name="UFSC - Universidade Federal de Santa Catarina",
        short_name="UFSC",
        competencies=[
            "Adequação à proposta: tema e gênero textual",
            "Norma padrão: ortografia, gramática, pontuação",
            "Coerência e coesão: articulação e progressão das ideias",
            "Informatividade e argumentação/narratividade conforme gênero"
        ],
        max_score=10,
        weights=[2.5, 2.5, 2.5, 2.5],
        description="4 critérios de 2.5 pts cada. Aceita vários gêneros (crônica, carta, artigo)."
    ),
    
    # ========== FEDERAIS VIA SISU (usam nota ENEM com nome próprio) ==========
    # NORTE
    
    "ufac": ExamCriteria(
        name="UFAC - Universidade Federal do Acre",
        short_name="UFAC",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "unifap": ExamCriteria(
        name="UNIFAP - Universidade Federal do Amapá",
        short_name="UNIFAP",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufam": ExamCriteria(
        name="UFAM - Universidade Federal do Amazonas",
        short_name="UFAM",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufpa": ExamCriteria(
        name="UFPA - Universidade Federal do Pará",
        short_name="UFPA",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "unir": ExamCriteria(
        name="UNIR - Universidade Federal de Rondônia",
        short_name="UNIR",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufrr": ExamCriteria(
        name="UFRR - Universidade Federal de Roraima",
        short_name="UFRR",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "uft": ExamCriteria(
        name="UFT - Universidade Federal do Tocantins",
        short_name="UFT",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    # NORDESTE
    
    "ufal": ExamCriteria(
        name="UFAL - Universidade Federal de Alagoas",
        short_name="UFAL",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufba": ExamCriteria(
        name="UFBA - Universidade Federal da Bahia",
        short_name="UFBA",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM (mínimo 200 pts na redação)"
    ),
    
    "ufc": ExamCriteria(
        name="UFC - Universidade Federal do Ceará",
        short_name="UFC",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufma": ExamCriteria(
        name="UFMA - Universidade Federal do Maranhão",
        short_name="UFMA",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufpb": ExamCriteria(
        name="UFPB - Universidade Federal da Paraíba",
        short_name="UFPB",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufpe": ExamCriteria(
        name="UFPE - Universidade Federal de Pernambuco",
        short_name="UFPE",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufpi": ExamCriteria(
        name="UFPI - Universidade Federal do Piauí",
        short_name="UFPI",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufrn": ExamCriteria(
        name="UFRN - Universidade Federal do Rio Grande do Norte",
        short_name="UFRN",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufs": ExamCriteria(
        name="UFS - Universidade Federal de Sergipe",
        short_name="UFS",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    # CENTRO-OESTE
    
    "udf": ExamCriteria(
        name="UDF - Centro Universitário do Distrito Federal",
        short_name="UDF",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Aceita nota do ENEM para ingresso"
    ),
    
    "ufg": ExamCriteria(
        name="UFG - Universidade Federal de Goiás",
        short_name="UFG",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufmt": ExamCriteria(
        name="UFMT - Universidade Federal de Mato Grosso",
        short_name="UFMT",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    "ufms": ExamCriteria(
        name="UFMS - Universidade Federal de Mato Grosso do Sul",
        short_name="UFMS",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    # SUDESTE
    
    "ufes": ExamCriteria(
        name="UFES - Universidade Federal do Espírito Santo",
        short_name="UFES",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Ingresso via SISU - utiliza nota do ENEM"
    ),
    
    # ESTADUAIS
    
    "uerr": ExamCriteria(
        name="UERR - Universidade Estadual de Roraima",
        short_name="UERR",
        competencies=ENEM_COMPETENCIES,
        max_score=1000,
        weights=ENEM_WEIGHTS,
        description="Aceita nota do ENEM para ingresso"
    ),
    
    # ========== PUCs (CRITÉRIOS PRÓPRIOS VERIFICADOS) ==========
    
    "pucsp": ExamCriteria(
        name="PUC-SP - Pontifícia Universidade Católica de São Paulo",
        short_name="PUC-SP",
        competencies=[
            "Tipo de Texto: adequação ao gênero dissertativo",
            "Adequação ao Tema: desenvolvimento do assunto proposto",
            "Coerência: lógica e viabilidade das ideias",
            "Coesão: articulação e elementos coesivos",
            "Norma Padrão: gramática, ortografia, pontuação"
        ],
        max_score=100,
        weights=[20, 20, 20, 20, 20],
        description="5 critérios próprios. Título OBRIGATÓRIO. SEM proposta de intervenção."
    ),
    
    "pucrs": ExamCriteria(
        name="PUCRS - Pontifícia Universidade Católica do Rio Grande do Sul",
        short_name="PUCRS",
        competencies=[
            "Conteúdo: conhecimento, compreensão e análise do tema",
            "Estrutura: organização, parágrafos, encadeamento lógico",
            "Expressão Linguística: norma culta, vocabulário, legibilidade"
        ],
        max_score=100,
        weights=[40, 30, 30],
        description="3 critérios. SEM proposta de intervenção. Temas ligados à prova de Português."
    ),
    
    "pucrio": ExamCriteria(
        name="PUC-Rio - Pontifícia Universidade Católica do Rio de Janeiro",
        short_name="PUC-Rio",
        competencies=[
            "Estrutura Temática: articulação e completude",
            "Norma Padrão: domínio da língua portuguesa",
            "Coerência e Reflexão Crítica: profundidade argumentativa"
        ],
        max_score=100,
        weights=[40, 30, 30],
        description="Avaliação holística. Registro semiformal. SEM proposta de intervenção."
    ),
    
    "pucminas": ExamCriteria(
        name="PUC-Minas - Pontifícia Universidade Católica de Minas Gerais",
        short_name="PUC-Minas",
        competencies=[
            "Coerência e Coesão: clareza, lógica, articulação",
            "Correção Gramatical: ortografia, concordância, pontuação",
            "Compreensão da Proposta: gênero textual e argumentação"
        ],
        max_score=10,
        weights=[3.5, 3.5, 3],
        description="Nota de 0-10 (meio em meio ponto). Título OBRIGATÓRIO. SEM proposta de intervenção."
    ),
    
    "pucpr": ExamCriteria(
        name="PUCPR - Pontifícia Universidade Católica do Paraná",
        short_name="PUCPR",
        competencies=[
            "Qualidade de Conteúdo: profundidade e relevância das ideias",
            "Progressão e Coerência: desenvolvimento lógico do texto",
            "Coesão: conexão entre partes do texto",
            "Norma Padrão: gramática, ortografia e sintaxe"
        ],
        max_score=10,
        weights=[4, 2, 2, 2],
        description="4 critérios (4+2+2+2=10). Vale 40 pts no vestibular. Medicina: 2 redações de 50 pts."
    ),
    
    "puccampinas": ExamCriteria(
        name="PUC-Campinas - Pontifícia Universidade Católica de Campinas",
        short_name="PUC-Campinas",
        competencies=[
            "Adequação ao tema e gênero proposto",
            "Estrutura e coesão textual",
            "Argumentação e desenvolvimento",
            "Domínio da norma culta"
        ],
        max_score=100,
        weights=[25, 25, 25, 25],
        description="Redação dissertativo-argumentativa"
    ),
    
    "pucgoias": ExamCriteria(
        name="PUC-Goiás - Pontifícia Universidade Católica de Goiás",
        short_name="PUC-Goiás",
        competencies=[
            "Adequação ao tema proposto",
            "Estrutura e coesão textual",
            "Argumentação e fundamentação",
            "Domínio linguístico"
        ],
        max_score=100,
        weights=[25, 25, 25, 25],
        description="Redação dissertativo-argumentativa"
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
