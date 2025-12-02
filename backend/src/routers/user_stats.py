"""
Endpoint para estatísticas de informações complementares dos usuários
"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from .. import models
from ..database import get_db
from ..dependencies import get_current_admin_user

router = APIRouter()

@router.get("/admin/user-profile-stats")
async def get_user_profile_stats(
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """
    Retorna estatísticas consolidadas das informações complementares dos usuários
    """
    from ..models_complementary import DropdownOption
    
    try:
        # Total de usuários que preencheram informações
        users_with_info = db.query(func.count(models.User.id)).filter(
            models.User.school_level.isnot(None)
        ).scalar() or 0
        
        total_users = db.query(func.count(models.User.id)).scalar() or 0
        completion_rate = round((users_with_info / total_users * 100) if total_users > 0 else 0, 1)
        
        # Distribuição por nível escolar
        school_level_dist = db.query(
            models.User.school_level,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.school_level.isnot(None)
        ).group_by(models.User.school_level).all()
        
        # Distribuição por tentativas ENEM
        enem_dist = db.query(
            models.User.enem_attempts,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.enem_attempts.isnot(None)
        ).group_by(models.User.enem_attempts).all()
        
        # Distribuição por objetivo principal
        goal_dist = db.query(
            models.User.main_goal,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.main_goal.isnot(None)
        ).group_by(models.User.main_goal).all()
        
        # Distribuição por método de estudo
        method_dist = db.query(
            models.User.study_method,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.study_method.isnot(None)
        ).group_by(models.User.study_method).all()
        
        # Top 10 estados
        state_dist = db.query(
            models.User.state,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.state.isnot(None)
        ).group_by(models.User.state).order_by(func.count(models.User.id).desc()).limit(10).all()
        
        # Top 10 cidades
        city_dist = db.query(
            models.User.city,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.city.isnot(None)
        ).group_by(models.User.city).order_by(func.count(models.User.id).desc()).limit(10).all()
        
        # Top 10 cursos pretendidos
        course_dist = db.query(
            models.User.intended_course,
            func.count(models.User.id).label('count')
        ).filter(
            models.User.intended_course.isnot(None),
            models.User.intended_course != ''
        ).group_by(models.User.intended_course).order_by(func.count(models.User.id).desc()).limit(10).all()
        
        # Helper para obter labels dos dropdowns
        def get_label(category: str, value: str):
            if not value:
                return value
            option = db.query(DropdownOption).filter(
                DropdownOption.category == category,
                DropdownOption.value == value
            ).first()
            return option.label if option else value
        
        return {
            "summary": {
                "total_users": total_users,
                "users_with_info": users_with_info,
                "completion_rate": completion_rate
            },
            "school_level": [
                {
                    "value": item[0],
                    "label": get_label('school_level', item[0]),
                    "count": item[1]
                } for item in school_level_dist
            ],
            "enem_attempts": [
                {
                    "value": item[0],
                    "label": get_label('enem_attempts', item[0]),
                    "count": item[1]
                } for item in enem_dist
            ],
            "main_goal": [
                {
                    "value": item[0],
                    "label": get_label('main_goal', item[0]),
                    "count": item[1]
                } for item in goal_dist
            ],
            "study_method": [
                {
                    "value": item[0],
                    "label": get_label('study_method', item[0]),
                    "count": item[1]
                } for item in method_dist
            ],
            "states": [
                {"code": item[0], "count": item[1]} for item in state_dist
            ],
            "cities": [
                {"name": item[0], "count": item[1]} for item in city_dist
            ],
            "courses": [
                {"name": item[0], "count": item[1]} for item in course_dist
            ]
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao buscar estatísticas: {str(e)}")
