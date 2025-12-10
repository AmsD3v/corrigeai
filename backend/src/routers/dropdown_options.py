"""
Router para gerenciamento de opções de dropdown (Admin)
"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from .. import models
from ..database import get_db
from ..dependencies import get_current_admin_user
from pydantic import BaseModel

router = APIRouter()

# Schemas
class DropdownOptionBase(BaseModel):
    category: str
    value: str
    label: str
    order: int = 0

class DropdownOptionCreate(DropdownOptionBase):
    pass

class DropdownOptionUpdate(BaseModel):
    label: str | None = None
    order: int | None = None
    is_active: bool | None = None

class DropdownOption(DropdownOptionBase):
    id: int
    is_active: bool
    
    class Config:
        from_attributes = True


# Endpoints Públicos (User)
@router.get("/api/dropdown-options", response_model=List[DropdownOption])
def get_dropdown_options(category: str | None = None, db: Session = Depends(get_db)):
    """Retorna opções ativas de dropdown para usuários"""
    from ..models_complementary import DropdownOption as DBDropdownOption
    
    query = db.query(DBDropdownOption).filter(
        DBDropdownOption.is_active == True
    )
    
    if category:
        query = query.filter(DBDropdownOption.category == category)
    
    options = query.order_by(DBDropdownOption.order).all()
    
    return options


# Endpoints Admin
@router.get("/api/admin/dropdown-options", response_model=List[DropdownOption])
def get_all_dropdown_options(
    category: str | None = None,
    db: Session = Depends(get_db),
    admin: models.User = Depends(get_current_admin_user)
):
    """Retorna TODAS as opções de dropdown (ativas e inativas) para admin"""
    from ..models_complementary import DropdownOption as DBDropdownOption
    
    query = db.query(DBDropdownOption)
    
    if category:
        query = query.filter(DBDropdownOption.category == category)
    
    options = query.order_by(DBDropdownOption.category, DBDropdownOption.order).all()
    return options


@router.post("/api/admin/dropdown-options", response_model=DropdownOption)
def create_dropdown_option(
    option: DropdownOptionCreate,
    db: Session = Depends(get_db),
    admin: models.User = Depends(get_current_admin_user)
):
    """Cria nova opção de dropdown"""
    from ..models_complementary import DropdownOption as DBDropdownOption
    
    # Verificar se já existe
    existing = db.query(DBDropdownOption).filter(
        DBDropdownOption.category == option.category,
        DBDropdownOption.value == option.value
    ).first()
    
    if existing:
        raise HTTPException(status_code=400, detail="Option already exists")
    
    db_option = DBDropdownOption(
        category=option.category,
        value=option.value,
        label=option.label,
        order=option.order,
        is_active=True
    )
    
    db.add(db_option)
    db.commit()
    db.refresh(db_option)
    
    return db_option


@router.put("/api/admin/dropdown-options/{option_id}", response_model=DropdownOption)
def update_dropdown_option(
    option_id: int,
    option: DropdownOptionUpdate,
    db: Session = Depends(get_db),
    admin: models.User = Depends(get_current_admin_user)
):
    """Atualiza opção de dropdown"""
    from ..models_complementary import DropdownOption as DBDropdownOption
    
    db_option = db.query(DBDropdownOption).filter(DBDropdownOption.id == option_id).first()
    
    if not db_option:
        raise HTTPException(status_code=404, detail="Option not found")
    
    update_data = option.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_option, key, value)
    
    db.commit()
    db.refresh(db_option)
    
    return db_option


@router.delete("/api/admin/dropdown-options/{option_id}")
def delete_dropdown_option(
    option_id: int,
    db: Session = Depends(get_db),
    admin: models.User = Depends(get_current_admin_user)
):
    """Deleta opção de dropdown"""
    from ..models_complementary import DropdownOption as DBDropdownOption
    
    db_option = db.query(DBDropdownOption).filter(DBDropdownOption.id == option_id).first()
    
    if not db_option:
        raise HTTPException(status_code=404, detail="Option not found")
    
    db.delete(db_option)
    db.commit()
    
    return {"message": "Option deleted successfully"}


# ============================================
# Endpoints para Estados e Cidades Brasileiras
# ============================================

class StateResponse(BaseModel):
    id: int
    code: str
    name: str
    
    class Config:
        from_attributes = True

class CityResponse(BaseModel):
    id: int
    name: str
    state_code: str
    
    class Config:
        from_attributes = True


@router.get("/api/states", response_model=List[StateResponse])
def get_states(db: Session = Depends(get_db)):
    """Retorna todos os estados brasileiros ordenados por nome"""
    from ..models_complementary import BrazilState
    
    states = db.query(BrazilState).order_by(BrazilState.name).all()
    return states


@router.get("/api/cities", response_model=List[CityResponse])
def get_cities(state_code: str | None = None, db: Session = Depends(get_db)):
    """Retorna cidades, opcionalmente filtradas por estado"""
    from ..models_complementary import BrazilCity
    
    query = db.query(BrazilCity)
    
    if state_code:
        query = query.filter(BrazilCity.state_code == state_code.upper())
    
    cities = query.order_by(BrazilCity.name).all()
    return cities

