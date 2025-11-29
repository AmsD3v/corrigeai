from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel, EmailStr
from datetime import datetime, timedelta
import secrets

from .. import models
from ..database import get_db
from ..security import get_password_hash
import resend
import os

router = APIRouter()

# Configure Resend
resend.api_key = os.getenv("RESEND_API_KEY")

class ForgotPasswordRequest(BaseModel):
    email: EmailStr

class ResetPasswordRequest(BaseModel):
    token: str
    new_password: str

@router.post("/forgot-password")
async def forgot_password(request: ForgotPasswordRequest, db: Session = Depends(get_db)):
    """
    Envia email com link de reset de senha.
    Sempre retorna sucesso para não revelar se email existe.
    """
    user = db.query(models.User).filter(models.User.email == request.email).first()
    
    if user:
        # Gerar token único e seguro
        reset_token = secrets.token_urlsafe(32)
        
        # Definir expiração (1 hora)
        expires_at = datetime.utcnow() + timedelta(hours=1)
        
        # Salvar token no banco
        user.reset_token = reset_token
        user.reset_token_expires = expires_at
        db.commit()
        
        # Enviar email
        reset_link = f"https://corrigeai.online/reset-password/{reset_token}"
        
        try:
            resend.Emails.send({
                "from": "CorrigeAI <noreply@corrigeai.online>",
                "to": [user.email],
                "subject": "Recuperação de Senha - CorrigeAI",
                "html": f"""
                <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
                    <h1 style="color: #3b82f6;">Recuperação de Senha</h1>
                    <p>Olá {user.full_name or 'Usuário'},</p>
                    <p>Recebemos uma solicitação para redefinir sua senha na plataforma CorrigeAI.</p>
                    <p>Clique no botão abaixo para criar uma nova senha:</p>
                    <a href="{reset_link}" style="display: inline-block; padding: 12px 24px; background-color: #3b82f6; color: white; text-decoration: none; border-radius: 6px; margin: 20px 0;">
                        Redefinir Senha
                    </a>
                    <p>Ou copie e cole este link no seu navegador:</p>
                    <p style="color: #64748b; word-break: break-all;">{reset_link}</p>
                    <p><strong>Este link expira em 1 hora.</strong></p>
                    <p>Se você não solicitou a recuperação de senha, ignore este email.</p>
                    <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 20px 0;">
                    <p style="color: #94a3b8; font-size: 12px;">
                        CorrigeAI - Plataforma de Correção de Redações<br>
                        Este é um email automático, por favor não responda.
                    </p>
                </div>
                """
            })
        except Exception as e:
            print(f"Erro ao enviar email: {str(e)}")
            # Não revelar erro ao usuário por segurança
    
    # Sempre retornar sucesso (segurança: não revelar se email existe)
    return {
        "message": "Se o email existir em nossa base, você receberá instruções para redefinir sua senha."
    }


@router.post("/reset-password")
async def reset_password(request: ResetPasswordRequest, db: Session = Depends(get_db)):
    """
    Redefine a senha usando o token enviado por email.
    """
    # Buscar usuário por token
    user = db.query(models.User).filter(models.User.reset_token == request.token).first()
    
    if not user:
        raise HTTPException(status_code=400, detail="Token inválido ou expirado")
    
    # Verificar se token expirou
    if user.reset_token_expires < datetime.utcnow():
        raise HTTPException(status_code=400, detail="Token expirado. Solicite um novo link de recuperação.")
    
    # Validar força da senha
    if len(request.new_password) < 6:
        raise HTTPException(status_code=400, detail="A senha deve ter no mínimo 6 caracteres")
    
    # Atualizar senha
    user.hashed_password = get_password_hash(request.new_password)
    
    # Limpar token (uso único)
    user.reset_token = None
    user.reset_token_expires = None
    
    db.commit()
    
    return {"message": "Senha redefinida com sucesso!"}
