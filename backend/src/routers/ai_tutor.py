"""
AI Tutor endpoints for essay correction assistance
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import Dict, List
from datetime import datetime
import logging

from .. import schemas, models
from ..database import get_db
from ..dependencies import get_current_user
from ..gemini_service import get_ai_tutor_response

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/ai-tutor", tags=["ai-tutor"])

MAX_MESSAGES_PER_CONVERSATION = 10


@router.get("/history/{submission_id}")
async def get_chat_history(
    submission_id: int,
    db: Session = Depends(get_db),
    current_user: models.User = Depends(get_current_user)
):
    """Get chat history for a submission"""
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
    
    # Load messages from database
    messages = db.query(models.ChatMessage).filter(
        models.ChatMessage.submission_id == submission_id,
        models.ChatMessage.user_id == current_user.id
    ).order_by(models.ChatMessage.created_at).all()
    
    return {
        "conversation_id": submission_id,
        "messages": [
            {
                "role": msg.role,
                "content": msg.content,
                "timestamp": msg.created_at.isoformat()
            }
            for msg in messages
        ],
        "messages_remaining": MAX_MESSAGES_PER_CONVERSATION - len(messages)
    }


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
    
    # Load existing messages from database
    existing_messages = db.query(models.ChatMessage).filter(
        models.ChatMessage.submission_id == submission_id,
        models.ChatMessage.user_id == current_user.id
    ).order_by(models.ChatMessage.created_at).all()
    
    # Check message limit (count user messages only)
    user_messages_count = len([m for m in existing_messages if m.role == "user"])
    if user_messages_count >= MAX_MESSAGES_PER_CONVERSATION:
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail=f"Limite de mensagens atingido ({MAX_MESSAGES_PER_CONVERSATION})"
        )
    
    # Save user message to database
    user_msg = models.ChatMessage(
        submission_id=submission_id,
        user_id=current_user.id,
        role="user",
        content=message.message
    )
    db.add(user_msg)
    db.commit()
    
    # Convert to format for AI
    conversation_history = [
        {"role": m.role, "content": m.content}
        for m in existing_messages
    ]
    conversation_history.append({"role": "user", "content": message.message})
    
    # Prepare data for AI
    submission_data = {
        "title": submission.title,
        "theme": submission.theme,
        "content": submission.content,
        "exam_type": submission.exam_type or "ENEM"
    }
    
    correction_data = {
        "total_score": correction.total_score,
        "competence_1_score": correction.competence_1_score,
        "competence_2_score": correction.competence_2_score,
        "competence_3_score": correction.competence_3_score,
        "competence_4_score": correction.competence_4_score,
        "competence_5_score": correction.competence_5_score,
        "criteria_snapshot": getattr(correction, 'criteria_snapshot', None)
    }
    
    # Get AI response
    ai_response = await get_ai_tutor_response(
        user_message=message.message,
        submission_data=submission_data,
        correction_data=correction_data,
        conversation_history=conversation_history
    )
    
    # Save AI message to database
    ai_msg = models.ChatMessage(
        submission_id=submission_id,
        user_id=current_user.id,
        role="assistant",
        content=ai_response
    )
    db.add(ai_msg)
    db.commit()
    
    # Reload all messages for response
    all_messages = db.query(models.ChatMessage).filter(
        models.ChatMessage.submission_id == submission_id,
        models.ChatMessage.user_id == current_user.id
    ).order_by(models.ChatMessage.created_at).all()
    
    return {
        "conversation_id": submission_id,
        "messages": [
            {
                "role": msg.role,
                "content": msg.content,
                "timestamp": msg.created_at.isoformat()
            }
            for msg in all_messages
        ],
        "messages_remaining": MAX_MESSAGES_PER_CONVERSATION - len([m for m in all_messages if m.role == "user"]),
        "max_messages": MAX_MESSAGES_PER_CONVERSATION
    }
