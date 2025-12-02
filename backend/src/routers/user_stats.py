"""
Router para estatísticas e exportação de dados de usuários (Admin)
"""
from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from sqlalchemy import func
from ..database import get_db
from ..models import User
from ..dependencies import get_current_admin_user
from typing import Dict, Any, List
    total_users = db.query(User).count()
    
    # Contar usuários que preencheram pelo menos um campo complementar
    users_with_data = db.query(User).filter(
        (User.school_level != None) |
        (User.intended_course != None) |
        (User.state != None) |
        (User.city != None) |
        (User.enem_attempts != None) |
        (User.main_goal != None) |
        (User.study_method != None)
    ).count()
    
    # School Level Distribution
    school_level_dist = db.query(
        User.school_level,
        func.count(User.id).label('count')
    ).filter(User.school_level != None).group_by(User.school_level).all()
    
    # State Distribution
    state_dist = db.query(
        User.state,
        func.count(User.id).label('count')
    ).filter(User.state != None).group_by(User.state).order_by(func.count(User.id).desc()).limit(10).all()
    
    # ENEM Attempts Distribution
    enem_attempts_dist = db.query(
        User.enem_attempts,
        func.count(User.id).label('count')
    ).filter(User.enem_attempts != None).group_by(User.enem_attempts).all()
    
    # Main Goal Distribution
    main_goal_dist = db.query(
        User.main_goal,
        func.count(User.id).label('count')
    ).filter(User.main_goal != None).group_by(User.main_goal).all()
    
    # Study Method Distribution
    study_method_dist = db.query(
        User.study_method,
        func.count(User.id).label('count')
    ).filter(User.study_method != None).group_by(User.study_method).all()
    
    # Top 10 Intended Courses
    top_courses = db.query(
        User.intended_course,
        func.count(User.id).label('count')
    ).filter(User.intended_course != None).group_by(User.intended_course).order_by(func.count(User.id).desc()).limit(10).all()
    
    return {
        "total_users": total_users,
        "users_with_complementary_data": users_with_data,
        "completion_rate": round((users_with_data / total_users * 100), 2) if total_users > 0 else 0,
        "distributions": {
            "school_level": [{"name": item[0], "value": item[1]} for item in school_level_dist],
            "state": [{"name": item[0], "value": item[1]} for item in state_dist],
            "enem_attempts": [{"name": item[0], "value": item[1]} for item in enem_attempts_dist],
            "main_goal": [{"name": item[0], "value": item[1]} for item in main_goal_dist],
            "study_method": [{"name": item[0], "value": item[1]} for item in study_method_dist],
            "top_courses": [{"name": item[0], "value": item[1]} for item in top_courses]
        }
    }


@router.get("/admin/export-user-data")
def export_user_data(
    current_user: User = Depends(get_current_admin_user),
    db: Session = Depends(get_db)
):
    """Exporta dados complementares dos usuários em formato CSV"""
    
    # Buscar todos os usuários
    users = db.query(User).all()
    
    # Criar buffer de memória para o CSV
    output = io.StringIO()
    writer = csv.writer(output)
    
    # Escrever cabeçalho
    writer.writerow([
        'ID',
        'Email',
        'Nome Completo',
        'Data Cadastro',
        'Nível Escolar',
        'Curso Pretendido',
        'Estado',
        'Cidade',
        'Tentativas ENEM',
        'Notas Anteriores',
        'Objetivo Principal',
        'Método de Estudo',
        'Créditos',
        'Créditos Grátis',
        'Ativo'
    ])
    
    # Escrever dados dos usuários
    for user in users:
        writer.writerow([
            user.id,
            user.email,
            user.full_name or '',
            user.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            user.school_level or '',
            user.intended_course or '',
            user.state or '',
            user.city or '',
            user.enem_attempts or '',
            user.previous_scores or '',
            user.main_goal or '',
            user.study_method or '',
            user.credits,
            user.free_credits,
            'Sim' if user.is_active else 'Não'
        ])
    
    # Preparar para download
    output.seek(0)
    
    filename = f"user_data_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    
    return StreamingResponse(
        iter([output.getvalue()]),
        media_type="text/csv",
        headers={
            "Content-Disposition": f"attachment; filename={filename}"
        }
    )
