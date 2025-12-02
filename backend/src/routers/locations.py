"""
Router para localização (Estados e Cidades do Brasil)
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from pydantic import BaseModel

router = APIRouter()

# Schemas
class BrazilState(BaseModel):
    id: int
    code: str
    name: str
    
    class Config:
        from_attributes = True

class BrazilCity(BaseModel):
    id: int
    name: str
    state_code: str
    
    class Config:
        from_attributes = True


# Endpoints
@router.get("/api/locations/states", response_model=List[BrazilState])
def get_states(db: Session = Depends(get_db)):
    """Retorna todos os estados brasileiros"""
    from ..models_complementary import BrazilState as DBBrazilState
    
    states = db.query(DBBrazilState).order_by(DBBrazilState.name).all()
    return states


@router.get("/api/locations/cities", response_model=List[BrazilCity])
def get_cities(state: str | None = None, db: Session = Depends(get_db)):
    """
    Retorna cidades brasileiras
    
    Args:
        state: Código do estado (SP, RJ, etc) para filtrar cidades
    """
    from ..models_complementary import BrazilCity as DBBrazilCity
    
    query = db.query(DBBrazilCity)
    
    if state:
        query = query.filter(DBBrazilCity.state_code == state.upper())
    
    cities = query.order_by(DBBrazilCity.name).all()
    return cities
