from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from .database import get_db
from . import models
from .security import decode_token
import logging

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

# Dependência para obter o usuário atual
def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> models.User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Não foi possível validar as credenciais",
        headers={"WWW-Authenticate": "Bearer"},
    )
    payload = decode_token(token)
    if payload is None or "sub" not in payload:
        raise credentials_exception
        
    user_id = int(payload.get("sub"))
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user is None:
        raise credentials_exception
    return user

# Dependência para verificar se usuário é admin
def get_current_admin_user(current_user: models.User = Depends(get_current_user)) -> models.User:
    logging.info(f"🔐 Admin check for user {current_user.email}: is_admin={getattr(current_user, 'is_admin', None)}")
    
    if not getattr(current_user, 'is_admin', False):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Acesso negado. Apenas administradores."
        )
    return current_user
