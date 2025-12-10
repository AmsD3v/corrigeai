"""
Router para retornar critérios de avaliação de vestibulares.
Centraliza os critérios em um único endpoint para eliminar duplicação no frontend.
"""

from fastapi import APIRouter, HTTPException
from typing import List
from pydantic import BaseModel
from ..exam_criteria import get_exam_criteria, get_available_exams, validate_exam_type, EXAM_TYPES


router = APIRouter()


class ExamCriteriaResponse(BaseModel):
    """Resposta com critérios de um vestibular específico"""
    id: str
    name: str
    short_name: str
    max_score: int
    competencies: List[str]
    weights: List[float]
    description: str


class ExamListItem(BaseModel):
    """Item resumido de um vestibular"""
    id: str
    name: str
    short_name: str
    max_score: int
    num_competencies: int


@router.get("/exam-criteria", response_model=List[ExamListItem])
async def list_exam_criteria():
    """
    Retorna lista de todos os vestibulares disponíveis com informações básicas.
    Usado para dropdowns de seleção de vestibular.
    """
    result = []
    for exam_id, criteria in EXAM_TYPES.items():
        result.append(ExamListItem(
            id=exam_id,
            name=criteria.name,
            short_name=criteria.short_name,
            max_score=criteria.max_score,
            num_competencies=len(criteria.competencies)
        ))
    return result


@router.get("/exam-criteria/{exam_type}", response_model=ExamCriteriaResponse)
async def get_exam_criteria_by_type(exam_type: str):
    """
    Retorna critérios de avaliação completos para um vestibular específico.
    
    Inclui:
    - Nomes das competências
    - Pesos/pontuação máxima de cada competência  
    - Pontuação total máxima
    - Descrição do formato
    """
    exam_type_lower = exam_type.lower()
    
    if not validate_exam_type(exam_type_lower):
        raise HTTPException(
            status_code=404, 
            detail=f"Vestibular '{exam_type}' não encontrado. Use /api/exam-criteria para ver opções."
        )
    
    criteria = get_exam_criteria(exam_type_lower)
    
    return ExamCriteriaResponse(
        id=exam_type_lower,
        name=criteria.name,
        short_name=criteria.short_name,
        max_score=criteria.max_score,
        competencies=criteria.competencies,
        weights=criteria.weights,
        description=criteria.description
    )
