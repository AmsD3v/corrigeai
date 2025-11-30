from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel, EmailStr
from datetime import datetime, timedelta
import random

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

class VerifyTokenRequest(BaseModel):
    token: str

class ResetPasswordRequest(BaseModel):
    token: str
    new_password: str

@router.post("/forgot-password")
async def forgot_password(request: ForgotPasswordRequest, db: Session = Depends(get_db)):
    """
    Envia email com token de 6 dígitos.
    Retorna erro 404 se email não existe.
    """
    user = db.query(models.User).filter(models.User.email == request.email).first()
    
    if not user:
        raise HTTPException(status_code=404, detail="E-mail não cadastrado.")
    
    # Gerar token de 6 dígitos
    reset_token = str(random.randint(100000, 999999))
    
    # Definir expiração (1 hora)
    expires_at = datetime.utcnow() + timedelta(hours=1)
                        <p style="color: #4a5568; font-size: 16px; line-height: 1.6;">
                            Olá <strong>{user.full_name or 'Usuário'}</strong>,
                        </p>
                        
                        <p style="color: #4a5568; font-size: 16px; line-height: 1.6;">
                            Recebemos uma solicitação para redefinir sua senha. Use o código abaixo:
                        </p>
                        
                        <!-- Token Boxes -->
                        <div style="text-align: center; margin: 30px 0;">
                            {digit_boxes}
                        </div>
                        
                        <!-- Instructions -->
                        <div style="background: #f7fafc; border-left: 4px solid #3b82f6; padding: 16px; border-radius: 4px; margin: 24px 0;">
                            <p style="margin: 0; color: #2d3748; font-size: 14px;">
                                <strong>⏰ Este código expira em 1 hora.</strong>
                            </p>
                            <p style="margin: 8px 0 0 0; color: #4a5568; font-size: 14px;">
                                Digite-o na tela de recuperação de senha.
                            </p>
                        </div>
                        
                        <p style="color: #718096; font-size: 14px; line-height: 1.6; margin-top: 24px;">
                            Se você não solicitou este código, ignore este email. Sua senha permanecerá inalterada.
                        </p>
                    </div>
                    
                    <!-- Footer -->
                    <div style="background: #f7fafc; padding: 24px 30px; border-top: 1px solid #e2e8f0;">
                        <p style="margin: 0; color: #718096; font-size: 12px; text-align: center;">
                            <strong>CorrigeAI</strong> - Plataforma de Correção de Redações<br>
                            Este é um email automático, por favor não responda.
                        </p>
                    </div>
                    
                </div>
            </body>
            </html>
            """
        })
        print(f"✅ Email enviado com sucesso para {user.email} com token: {reset_token}")
    except Exception as e:
        print(f"❌ Erro ao enviar email: {str(e)}")
        raise HTTPException(status_code=500, detail="Erro ao enviar email. Tente novamente.")
    
    return {
        "message": "Token de recuperação enviado com sucesso! Verifique sua caixa de entrada e spam.",
        "email": user.email
    }


@router.post("/verify-reset-token")
async def verify_reset_token(request: VerifyTokenRequest, db: Session = Depends(get_db)):
    """
    Valida o token de 6 dígitos.
    """
    user = db.query(models.User).filter(models.User.reset_token == request.token).first()
    
    if not user:
        raise HTTPException(status_code=400, detail="Token inválido.")
    
    # Verificar se token expirou
    if user.reset_token_expires < datetime.utcnow():
        raise HTTPException(status_code=400, detail="Token expirado. Solicite um novo código.")
    
    return {
        "valid": True,
        "email": user.email,
        "message": "Token válido!"
    }


@router.post("/reset-password")
async def reset_password(request: ResetPasswordRequest, db: Session = Depends(get_db)):
    """
    Redefine a senha usando o token de 6 dígitos.
    """
    # Buscar usuário por token
    user = db.query(models.User).filter(models.User.reset_token == request.token).first()
    
    if not user:
        raise HTTPException(status_code=400, detail="Token inválido.")
    
    # Verificar se token expirou
    if user.reset_token_expires < datetime.utcnow():
        raise HTTPException(status_code=400, detail="Token expirado. Solicite um novo código.")
    
    # Validar força da senha
    if len(request.new_password) < 6:
        raise HTTPException(status_code=400, detail="A senha deve ter no mínimo 6 caracteres")
    
    # Atualizar senha
    user.hashed_password = get_password_hash(request.new_password)
    
    # Limpar token (uso único)
    user.reset_token = None
    user.reset_token_expires = None
    
    db.commit()
    
    print(f"✅ Senha redefinida com sucesso para {user.email}")
    
    return {"message": "Senha redefinida com sucesso!"}
