"""
AI Tutor endpoints for essay correction assistance
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import Dict
from datetime import datetime

from .. import schemas, models
from ..database import get_db
from ..dependencies import get_current_user
from ..gemini_service import get_ai_tutor_response

router = APIRouter(prefix="/ai-tutor", tags=["ai-tutor"])

MAX_MESSAGES_PER_CONVERSATION = 10

# In-memory storage for conversations (temporary - will use DB later)
conversations_store: Dict[str, dict] = {}


def get_conversation_key(submission_id: int, user_id: int) -> str:
    """Get unique key for conversation"""
    return f"{user_id}_{submission_id}"


@router.post("/chat/{submission_id}", response_model=schemas.AIChatResponse)
async def chat_with_ai_tutor(
    submission_id: int,
    message: schemas.AIChatMessageCreate,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """
    Chat with AI tutor about essay correction
    """
    # Verify submission belongs to user
    submission = db.query(models.Submission).filter(
        models.Submission.id == submission_id,
        models.Submission.owner_id == current_user.id
    ).first()
    
    if not submission:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Submissão não encontrada"
        )
    
    # Get correction
    correction = db.query(models.Correction).filter(
        models.Correction.submission_id == submission_id
    ).first()
    
    if not correction:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Correção não encontrada"
        )
    
    # Get or create conversation (using in-memory for now)
    conv_key = get_conversation_key(submission_id, current_user.id)
    
    if conv_key not in conversations_store:
        # Create new conversation with welcome message
        welcome_msg = {
            "role": "assistant",
            "content": (
                "Olá! Sou o Prof. Redi - seu assistente de redação. "
                "Estou aqui para te ajudar a entender melhor sua correção. "
                "Posso esclarecer dúvidas sobre:\n\n"
                "• **Norma Culta**: Ortografia, gramática, pontuação\n"
                "• **Estrutura e Coesão**: Organização e conectivos\n"
                "• **Proposta de Intervenção**: Como melhorar\n"
                "• **Argumentação**: Fortalecer seus argumentos\n\n"
                "O que deseja saber?"
            ),
            "timestamp": datetime.utcnow().isoformat()
        }
        
        conversations_store[conv_key] = {
            "messages": [welcome_msg],
            "messages_count": 0
        }
    
    conversation = conversations_store[conv_key]
    
    # Check message limit
    if conversation["messages_count"] >= MAX_MESSAGES_PER_CONVERSATION:
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail=f"Limite de mensagens atingido ({MAX_MESSAGES_PER_CONVERSATION})"
        )
    
    #  Add user message
    user_msg = {
        "role": "user",
        "content": message.message,
        "timestamp": datetime.utcnow().isoformat()
    }
    conversation["messages"].append(user_msg)
    conversation["messages_count"] += 1
    
    # Prepare data for AI
    submission_data = {
        "title": submission.title,
        "theme": submission.theme,
        "content": submission.content,
        "exam_type": submission.exam_type or "ENEM"  # Use real exam_type
    }
    
    correction_data = {
        "total_score": correction.total_score,
        "competence_1_score": correction.competence_1_score,
        "competence_2_score": correction.competence_2_score,
        "competence_3_score": correction.competence_3_score,
        "competence_4_score": correction.competence_4_score,
        "competence_5_score": correction.competence_5_score,
    }
    
    # Get AI response
    ai_response = await get_ai_tutor_response(
        user_message=message.message,
        submission_data=submission_data,
        correction_data=correction_data,
        conversation_history=conversation["messages"]
    )
    
    # Add AI message
    ai_msg = {
        "role": "assistant",
        "content": ai_response,
        "timestamp": datetime.utcnow().isoformat()
    }
    conversation["messages"].append(ai_msg)
    
    return {
        "conversation_id": submission_id,  # Using submission_id as temp ID
        "messages": conversation["messages"],
        "messages_remaining": MAX_MESSAGES_PER_CONVERSATION - conversation["messages_count"],
        "max_messages": MAX_MESSAGES_PER_CONVERSATION
    }
