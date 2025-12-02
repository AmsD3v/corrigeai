"""
Modelos adicionais para informações complementares do usuário.
Este arquivo contém modelos que devem ser importados em models.py
"""
from sqlalchemy import Boolean, Column, Integer, String, DateTime, ForeignKey
from datetime import datetime
from .database import Base


class DropdownOption(Base):
    """Opções configuráveis para dropdowns (admin gerencia)"""
    __tablename__ = "dropdown_option"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    category = Column(String, nullable=False)  # 'school_level', 'enem_attempts', 'main_goal', 'study_method'
    value = Column(String, nullable=False)  # ID interno (ex: '3rd_year_hs')
    label = Column(String, nullable=False)  # Texto exibido (ex: '3º Ano - Ensino Médio')
    order = Column(Integer, default=0)  # Ordem de exibição
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)


class BrazilState(Base):
    """Estados brasileiros"""
    __tablename__ = "brazil_state"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(2), unique=True, nullable=False)  # SP, RJ, MG
    name = Column(String, nullable=False)  # São Paulo, Rio de Janeiro


class BrazilCity(Base):
    """Cidades brasileiras"""
    __tablename__ = "brazil_city"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)  # São Paulo, Campinas
    state_code = Column(String(2), ForeignKey("brazil_state.code"), nullable=False)
