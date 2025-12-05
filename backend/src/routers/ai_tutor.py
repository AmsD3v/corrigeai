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
    
    # DEBUG: Log conversation state
    logger.info(f"🎓 Conv key: {conv_key}, Exists: {conv_key in conversations_store}, Exam: {submission.exam_type}")
    
    if conv_key not in conversations_store:
        # Map exam types to welcome topics
        exam_topics = {
            'enem': [
                '• **Norma Culta**: Ortografia, gramática, pontuação',
                '• **Compreensão do Tema**: Desenvolvimento adequado',
                '• **Argumentação**: Seleção e organização de argumentos',
                '• **Coesão e Coerência**: Conectivos e progressão',
                '• **Proposta de Intervenção**: 5 elementos completos'
            ],
            'fuvest': [
                '• **Desenvolvimento do Tema**: Abordagem crítica e autoral',
                '• **Estrutura**: Organização dissertativa-argumentativa',
                '• **Expressão**: Gramática, vocabulário e estilo',
                '• **Coesão e Coerência**: Articulação das ideias'
            ],
            'unicamp': [
                '• **Adequação ao Gênero**: Carta, artigo, relato, etc.',
                '• **Desenvolvimento da Proposta**: Compreensão temática',
                '• **Propósito Comunicativo**: Cumprimento do objetivo',
                '• **Articulação das Ideias**: Progressão textual',
                '• **Adequação Linguística**: Norma culta e registro'
            ],
            'ita': [
                '• **Domínio do Tema**: Conhecimento técnico-científico',
                '• **Estrutura Lógica**: Organização rigorosa',
                '• **Precisão Linguística**: Vocabulário técnico',
                '• **Coesão e Coerência**: Articulação precisa'
            ],
            'cacd': [
                '• **Erudição**: Repertório sociocultural amplo',
                '• **Clareza e Objetividade**: Precisão diplomática',
                '• **Estrutura**: Organização impecável',
                '• **Argumentação**: Profundidade analítica',
                '• **Estilo**: Linguagem formal e elegante'
            ]
        }
        
        exam_type_lower = (submission.exam_type or 'enem').lower()
        topics_list = exam_topics.get(exam_type_lower, exam_topics['enem'])
        topics_text = '\n'.join(topics_list)
        
        exam_names = {
            'enem': 'ENEM', 'fuvest': 'FUVEST', 'unicamp': 'UNICAMP',
            'ita': 'ITA', 'cacd': 'CACD', 'unesp': 'UNESP',
            'uerj': 'UERJ', 'ufmg': 'UFMG', 'afa': 'AFA', 'sisu': 'SISU'
        }
        exam_display = exam_names.get(exam_type_lower, exam_type_lower.upper())
        
        # Create new conversation with exam-specific welcome message
        welcome_msg = {
            "role": "assistant",
            "content": (
                f"Olá! Sou o Prof. Redi - seu assistente especializado em {exam_display}. "
                "Estou aqui para te ajudar a entender melhor sua correção. "
                f"Posso esclarecer dúvidas sobre:\n\n"
                f"{topics_text}\n\n"
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
