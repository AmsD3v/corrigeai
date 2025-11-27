from fastapi import APIRouter, Depends, HTTPException, status, Response, Cookie
from sqlalchemy.orm import Session
from .. import schemas, models
from ..database import get_db
from ..core.config import settings
from ..security import (
    get_password_hash,
    verify_password,
    create_access_token,
    create_refresh_token,
    hash_refresh_token,
    decode_token,
)
from ..dependencies import get_current_user
import logging

router = APIRouter()

@router.post("/users/", response_model=schemas.User, status_code=status.HTTP_201_CREATED)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email já registrado")
    
    hashed_password = get_password_hash(user.password)
    db_user = models.User(
        email=user.email, 
        hashed_password=hashed_password, 
        full_name=user.full_name,
        credits=2  # Novos usuários recebem 2 CorriCoins grátis
    )
    
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    
    return db_user

@router.post("/login")
def login(response: Response, form_data: schemas.UserLogin, db: Session = Depends(get_db)):
    logging.info(f"Login attempt for user: {form_data.username}")
    db_user = db.query(models.User).filter(models.User.email == form_data.username).first()
    logging.info(f"User found: {db_user}")
    
    if db_user:
        is_password_valid = verify_password(form_data.password, db_user.hashed_password)
        logging.info(f"Password verification result: {is_password_valid}")
    else:
        logging.info("User not found")

    if not db_user:
        logging.warning(f"❌ Login failed: User {form_data.username} not found")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciais inválidas (Usuário não encontrado)",
            headers={"WWW-Authenticate": "Bearer"},
        )

    if not verify_password(form_data.password, db_user.hashed_password):
        logging.warning(f"❌ Login failed: Password mismatch for {form_data.username}")
        # Log lengths for debugging (safe)
        logging.info(f"Received password length: {len(form_data.password)}")
        logging.info(f"Stored hash length: {len(db_user.hashed_password)}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Credenciais inválidas (Senha incorreta)",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    token_data = {"sub": str(db_user.id)}
    access_token = create_access_token(data=token_data)
    refresh_token = create_refresh_token(data=token_data)
    
    db_user.hashed_refresh_token = hash_refresh_token(refresh_token)
    db.commit()
    
    response.set_cookie(
        key="refresh_token", value=refresh_token, httponly=True,
        secure=True, samesite="lax", max_age=settings.REFRESH_TOKEN_EXPIRE_DAYS * 24 * 60 * 60
    )
    
    return {"access_token": access_token, "token_type": "bearer", "refresh_token": refresh_token}

@router.post("/refresh")
def refresh_token_route(response: Response, refresh_token: str | None = Cookie(None), db: Session = Depends(get_db)):
    if not refresh_token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token não encontrado")

    payload = decode_token(refresh_token)
    if not payload or "sub" not in payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token inválido ou expirado")

    user_id = int(payload["sub"])
    db_user = db.query(models.User).filter(models.User.id == user_id).first()

    if not db_user or not db_user.hashed_refresh_token or not verify_password(refresh_token, db_user.hashed_refresh_token):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token inválido ou já utilizado")

    new_token_data = {"sub": str(user_id)}
    new_access_token = create_access_token(data=new_token_data)
    new_refresh_token = create_refresh_token(data=new_token_data)

    db_user.hashed_refresh_token = hash_refresh_token(new_refresh_token)
    db.commit()

    response.set_cookie(
        key="refresh_token", value=new_refresh_token, httponly=True,
        secure=True, samesite="lax", max_age=settings.REFRESH_TOKEN_EXPIRE_DAYS * 24 * 60 * 60
    )
    
    return {"access_token": new_access_token, "token_type": "bearer", "refresh_token": new_refresh_token}

@router.post("/logout")
def logout(response: Response, current_user: models.User = Depends(get_current_user)):
    response.delete_cookie("refresh_token")
    return {"message": "Logout realizado com sucesso"}

@router.post("/logout-all")
def logout_all(response: Response, db: Session = Depends(get_db), current_user: models.User = Depends(get_current_user)):
    current_user.hashed_refresh_token = None
    db.commit()
    response.delete_cookie("refresh_token")
    return {"message": "Logout de todos os dispositivos realizado com sucesso"}
