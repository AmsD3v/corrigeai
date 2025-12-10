from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import get_db
from ..dependencies import get_current_user
from ..schemas import FeedbackCreate
from ..models import User
import resend
import os

router = APIRouter(prefix="/feedback", tags=["feedback"])

# Configure Resend
resend.api_key = os.getenv("RESEND_API_KEY")
print(f"📧 Resend API Key configurada: {'✅ Sim' if resend.api_key else '❌ Não'}")

@router.post("/")
async def send_feedback(
    feedback: FeedbackCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Enviar feedback do usuário por email
    """
    print(f"📥 Recebendo feedback de {current_user.email}")
    print(f"   Tipo: {feedback.type}")
    print(f"   Mensagem: {feedback.message[:50]}...")
    
    try:
        # Mapear tipo de feedback para label
        type_labels = {
            'sugestao': 'Sugestão',
            'bug': 'Reportar Bug',
            'reclamacao': 'Reclamação',
            'elogio': 'Elogio',
            'outro': 'Outro'
        }
        
        tipo_label = type_labels.get(feedback.type, feedback.type)
        
        # Montar o email
        html_content = f"""
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <h2 style="color: #3B82F6;">Novo Feedback - CorrigeAI</h2>
            
            <div style="background: #f3f4f6; padding: 20px; border-radius: 8px; margin: 20px 0;">
                <p><strong>Tipo:</strong> {tipo_label}</p>
                <p><strong>Usuário:</strong> {current_user.full_name or 'Não informado'} ({current_user.email})</p>
                <p><strong>ID do Usuário:</strong> {current_user.id}</p>
            </div>
            
            <div style="background: #ffffff; padding: 20px; border: 1px solid #e5e7eb; border-radius: 8px;">
                <h3 style="margin-top: 0;">Mensagem:</h3>
                <p style="white-space: pre-wrap; line-height: 1.6;">{feedback.message}</p>
            </div>
            
            <p style="color: #64748b; font-size: 12px; margin-top: 20px;">
                Este feedback foi enviado através do painel do CorrigeAI.
            </p>
        </div>
        """
        
        # Verificar API key antes de enviar
        if not resend.api_key:
            print("❌ RESEND_API_KEY não está configurada!")
            raise HTTPException(
                status_code=500,
                detail="Configuração de email inválida. Contate o suporte."
            )
        
        # Enviar email via Resend - usar domínio verificado!
        from_email = os.getenv("FEEDBACK_FROM_EMAIL", "noreply@corrigeai.online")
        to_email = os.getenv("FEEDBACK_EMAIL", "feedback@corrigeai.online")
        
        print(f"📤 Enviando email de {from_email} para {to_email}")
        
        params = {
            "from": f"CorrigeAI <{from_email}>",
            "to": [to_email],
            "subject": f"[{tipo_label}] Novo Feedback de {current_user.full_name or current_user.email}",
            "html": html_content
        }
        
        email = resend.Emails.send(params)
        print(f"✅ Email enviado com sucesso! ID: {email}")
        
        return {
            "success": True,
            "message": "Feedback enviado com sucesso! Obrigado pela sua contribuição."
        }
        
    except HTTPException:
        raise
    except Exception as e:
        print(f"❌ Erro ao enviar feedback: {str(e)}")
        import traceback
        traceback.print_exc()
        raise HTTPException(
            status_code=500,
            detail="Erro ao enviar feedback. Tente novamente mais tarde."
        )

