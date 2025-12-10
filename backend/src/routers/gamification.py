"""
Gamification Router - XP, Levels, Achievements, Lessons, Challenges
Includes: Cooldown system, AI-generated quizzes, repeat XP reduction
"""
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy import func, desc
from datetime import datetime, timedelta
from typing import Optional
import json
import logging
import httpx

from .. import models
from ..database import get_db
from ..dependencies import get_current_user
from ..core.config import settings as app_settings

router = APIRouter(prefix="/gamification", tags=["gamification"])


# ==================== HELPER FUNCTIONS ====================

# Progressão linear: 100 XP por nível
LEVEL_THRESHOLDS = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
LEVEL_NAMES = ["Calouro", "Estudante", "Dedicado", "Aplicado", "Redator", "Escritor", "Mestre", "Expert", "Lenda", "Gênio", "Divino"]
XP_PER_LEVEL = 100  # Valor fixo para cada nível



def get_settings(db: Session) -> models.Settings:
    """Get application settings"""
    settings = db.query(models.Settings).first()
    if not settings:
        settings = models.Settings()
        db.add(settings)
        db.commit()
        db.refresh(settings)
    return settings


def calculate_level(xp: int) -> tuple[int, str, int, int]:
    """Calculate level from XP. Returns (level, name, current_xp_in_level, xp_needed_for_next)"""
    # Nível é calculado como XP / 100 (cada 100 XP = 1 nível)
    level = min(xp // XP_PER_LEVEL + 1, len(LEVEL_NAMES))
    
    # XP dentro do nível atual (0-99)
    xp_in_level = xp % XP_PER_LEVEL
    
    # Sempre 100 XP para subir de nível
    xp_needed = XP_PER_LEVEL
    
    name = LEVEL_NAMES[level - 1] if level <= len(LEVEL_NAMES) else "Lenda"
    
    return level, name, xp_in_level, xp_needed



def get_or_create_gamification(db: Session, user_id: int) -> models.UserGamification:
    """Get or create user gamification profile"""
    profile = db.query(models.UserGamification).filter(
        models.UserGamification.user_id == user_id
    ).first()
    
    if not profile:
        profile = models.UserGamification(user_id=user_id)
        db.add(profile)
        db.commit()
        db.refresh(profile)
    
    return profile


def update_streak(db: Session, profile: models.UserGamification):
    """Update user streak based on last activity"""
    today = datetime.utcnow().date()
    
    if profile.last_activity_date:
        last_date = profile.last_activity_date.date()
        diff = (today - last_date).days
        
        if diff == 0:
            pass
        elif diff == 1:
            profile.current_streak += 1
            if profile.current_streak > profile.max_streak:
                profile.max_streak = profile.current_streak
        else:
            profile.current_streak = 1
    else:
        profile.current_streak = 1
    
    profile.last_activity_date = datetime.utcnow()
    db.commit()


def check_achievements(db: Session, user_id: int) -> list:
    """Check and unlock any new GLOBAL achievements (exam_type = NULL only)"""
    unlocked = []
    
    # Global stats
    essays_count = db.query(func.count(models.Submission.id)).filter(
        models.Submission.owner_id == user_id
    ).scalar() or 0
    
    max_score = db.query(func.max(models.Correction.total_score)).join(
        models.Submission
    ).filter(models.Submission.owner_id == user_id).scalar() or 0
    
    profile = get_or_create_gamification(db, user_id)
    
    existing_ids = db.query(models.UserAchievement.achievement_id).filter(
        models.UserAchievement.user_id == user_id
    ).all()
    existing_ids = [a[0] for a in existing_ids]
    
    # IMPORTANT: Only check GLOBAL achievements (exam_type IS NULL)
    # Exam-specific achievements are handled in /achievements endpoint
    achievements = db.query(models.Achievement).filter(
        models.Achievement.is_active == True,
        models.Achievement.exam_type == None,  # Only global achievements
        ~models.Achievement.id.in_(existing_ids) if existing_ids else True
    ).all()
    
    for achievement in achievements:
        earned = False
        
        if achievement.condition_type == "essays_count" and essays_count >= achievement.condition_value:
            earned = True
        elif achievement.condition_type == "score" and max_score >= achievement.condition_value:
            earned = True
        elif achievement.condition_type == "streak" and profile.current_streak >= achievement.condition_value:
            earned = True
        elif achievement.condition_type == "lessons" and profile.lessons_completed >= achievement.condition_value:
            earned = True
        
        if earned:
            user_achievement = models.UserAchievement(
                user_id=user_id,
                achievement_id=achievement.id
            )
            db.add(user_achievement)
            
            if achievement.xp_reward > 0:
                profile.xp_total += achievement.xp_reward
            
            if achievement.coin_reward > 0:
                user = db.query(models.User).filter(models.User.id == user_id).first()
                if user:
                    user.free_credits += achievement.coin_reward
            
            unlocked.append({
                "code": achievement.code,
                "name": achievement.name,
                "description": achievement.description,
                "icon": achievement.icon,
                "xp_reward": achievement.xp_reward,
                "coin_reward": achievement.coin_reward
            })
    
    if unlocked:
        db.commit()
    
    return unlocked


def check_exam_achievements(db: Session, user_id: int, exam_type: str, score: int) -> list:
    """Check and unlock achievements for a specific exam type after correction.
    Called from correction_service.py when a correction is completed."""
    unlocked = []
    
    # Get user's gamification profile
    profile = get_or_create_gamification(db, user_id)
    
    # Get already unlocked achievements for this user
    existing_ids = db.query(models.UserAchievement.achievement_id).filter(
        models.UserAchievement.user_id == user_id
    ).all()
    existing_ids = [a[0] for a in existing_ids]
    
    # Get essays count for this specific exam type
    essays_for_exam = db.query(func.count(models.Submission.id)).filter(
        models.Submission.owner_id == user_id,
        models.Submission.exam_type == exam_type.lower()
    ).scalar() or 0
    
    # Get achievements for this exam type that haven't been unlocked
    achievements = db.query(models.Achievement).filter(
        models.Achievement.is_active == True,
        models.Achievement.exam_type == exam_type.lower(),
        ~models.Achievement.id.in_(existing_ids) if existing_ids else True
    ).all()
    
    for achievement in achievements:
        earned = False
        
        if achievement.condition_type == "essays_count" and essays_for_exam >= achievement.condition_value:
            earned = True
        elif achievement.condition_type == "score" and score >= achievement.condition_value:
            earned = True
        
        if earned:
            user_achievement = models.UserAchievement(
                user_id=user_id,
                achievement_id=achievement.id
            )
            db.add(user_achievement)
            
            if achievement.xp_reward > 0:
                profile.xp_total += achievement.xp_reward
            
            if achievement.coin_reward > 0:
                user = db.query(models.User).filter(models.User.id == user_id).first()
                if user:
                    user.free_credits = (user.free_credits or 0) + achievement.coin_reward
            
            unlocked.append({
                "code": achievement.code,
                "name": achievement.name,
                "xp_reward": achievement.xp_reward
            })
            logging.info(f"🏆 Conquista desbloqueada via correção: {achievement.name} (+{achievement.xp_reward} XP)")
    
    if unlocked:
        db.commit()
    
    return unlocked


async def generate_ai_quiz(lesson_title: str, lesson_content: str, num_questions: int = 3) -> list:
    """Generate quiz questions using AI based on lesson content"""
    try:
        prompt = f"""Gere {num_questions} perguntas de quiz sobre a seguinte lição de redação do ENEM.
A lição é: "{lesson_title}"

Conteúdo da lição:
{lesson_content[:2000]}

IMPORTANTE: Responda APENAS com um array JSON válido. Cada pergunta deve ter:
- "question": a pergunta
- "options": array com 3-4 opções
- "correct": índice da resposta correta (0, 1, 2 ou 3)

Exemplo de formato:
[{{"question": "Pergunta aqui?", "options": ["Opção A", "Opção B", "Opção C"], "correct": 1}}]

Gere perguntas DIFERENTES das que já existem na lição. Faça perguntas desafiadoras sobre o conteúdo."""

        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.post(
                "https://api.groq.com/openai/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {app_settings.GROQ_API_KEY}",
                    "Content-Type": "application/json"
                },
                json={
                    "model": "llama-3.1-8b-instant",
                    "messages": [{"role": "user", "content": prompt}],
                    "temperature": 0.7,
                    "max_tokens": 1000
                }
            )
            
            if response.status_code == 200:
                result = response.json()
                content = result["choices"][0]["message"]["content"]
                
                # Extract JSON from response
                start = content.find('[')
                end = content.rfind(']') + 1
                if start != -1 and end > start:
                    json_str = content[start:end]
                    quiz = json.loads(json_str)
                    return quiz
                    
    except Exception as e:
        logging.error(f"Erro ao gerar quiz com IA: {e}")
    
    return None


# ==================== ENDPOINTS ====================

@router.get("/profile")
async def get_gamification_profile(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get user's gamification profile"""
    profile = get_or_create_gamification(db, current_user.id)
    level, level_name, xp_in_level, xp_needed = calculate_level(profile.xp_total)
    
    essays_count = db.query(func.count(models.Submission.id)).filter(
        models.Submission.owner_id == current_user.id
    ).scalar() or 0
    
    new_achievements = check_achievements(db, current_user.id)
    
    return {
        "xp_total": profile.xp_total,
        "level": level,
        "level_name": level_name,
        "xp_in_level": xp_in_level,
        "xp_for_next_level": xp_needed,
        "xp_progress_percent": round((xp_in_level / xp_needed) * 100) if xp_needed > 0 else 100,
        "current_streak": profile.current_streak,
        "max_streak": profile.max_streak,
        "lessons_completed": profile.lessons_completed,
        "essays_count": essays_count,
        "new_achievements": new_achievements
    }


@router.get("/achievements")
async def get_achievements(
    exam_type: str = "enem",
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get achievements - global ones + specific to exam_type"""
    from sqlalchemy import or_
    
    # Get global achievements (exam_type is NULL) + specific to this exam
    achievements = db.query(models.Achievement).filter(
        models.Achievement.is_active == True,
        or_(
            models.Achievement.exam_type == None,
            models.Achievement.exam_type == exam_type.lower()
        )
    ).all()
    
    # Get user's unlocked achievements
    user_achievements = db.query(models.UserAchievement).filter(
        models.UserAchievement.user_id == current_user.id
    ).all()
    unlocked_ids = {ua.achievement_id for ua in user_achievements}
    
    # Get user's gamification profile
    profile = get_or_create_gamification(db, current_user.id)
    
    # Calculate stats for the selected exam type
    # Essays count for this specific exam type
    essays_for_exam = db.query(func.count(models.Submission.id)).filter(
        models.Submission.owner_id == current_user.id,
        models.Submission.exam_type == exam_type.lower()
    ).scalar() or 0
    
    # Max score for this specific exam type
    max_score_for_exam = db.query(func.max(models.Correction.total_score)).join(
        models.Submission
    ).filter(
        models.Submission.owner_id == current_user.id,
        models.Submission.exam_type == exam_type.lower()
    ).scalar() or 0
    
    # Lessons completed for this exam type
    lessons_for_exam = db.query(func.count(models.UserLesson.id)).join(
        models.Lesson
    ).filter(
        models.UserLesson.user_id == current_user.id,
        models.UserLesson.is_completed == True,
        models.Lesson.exam_type == exam_type.lower()
    ).scalar() or 0
    
    # Global essays count (for global achievements)
    global_essays = db.query(func.count(models.Submission.id)).filter(
        models.Submission.owner_id == current_user.id
    ).scalar() or 0
    
    result = []
    newly_unlocked = []  # Track newly unlocked achievements
    
    for a in achievements:
        # Determine if unlocked based on achievement type and exam_type
        is_unlocked = False
        was_already_unlocked = a.id in unlocked_ids
        
        if a.exam_type is None:
            # Global achievement - use global stats or profile
            if a.condition_type == "essays_count":
                is_unlocked = global_essays >= a.condition_value
            elif a.condition_type == "streak":
                is_unlocked = profile.current_streak >= a.condition_value
            else:
                is_unlocked = was_already_unlocked
        else:
            # Exam-specific achievement - use exam-specific stats
            if a.condition_type == "essays_count":
                is_unlocked = essays_for_exam >= a.condition_value
            elif a.condition_type == "score":
                is_unlocked = max_score_for_exam >= a.condition_value
            elif a.condition_type == "lessons":
                is_unlocked = lessons_for_exam >= a.condition_value
            else:
                is_unlocked = was_already_unlocked
        
        # PERSIST newly unlocked achievement and add XP
        if is_unlocked and not was_already_unlocked:
            user_achievement = models.UserAchievement(
                user_id=current_user.id,
                achievement_id=a.id
            )
            db.add(user_achievement)
            
            # Add XP to profile
            if a.xp_reward > 0:
                profile.xp_total += a.xp_reward
            
            # Add coins if applicable
            if a.coin_reward > 0:
                current_user.free_credits = (current_user.free_credits or 0) + a.coin_reward
            
            newly_unlocked.append(a)
            logging.info(f"🏆 Conquista desbloqueada: {a.name} (+{a.xp_reward} XP) para user {current_user.id}")
        
        result.append({
            "id": a.id,
            "code": a.code,
            "name": a.name,
            "description": a.description,
            "icon": a.icon,
            "exam_type": a.exam_type,
            "xp_reward": a.xp_reward,
            "coin_reward": a.coin_reward,
            "lessons_reward": a.lessons_reward,
            "is_unlocked": is_unlocked,
            "unlocked_at": next((ua.unlocked_at.isoformat() for ua in user_achievements if ua.achievement_id == a.id), None) if was_already_unlocked else None
        })
    
    # Commit if there are newly unlocked achievements
    if newly_unlocked:
        db.commit()
    
    return {
        "exam_type": exam_type,
        "total": len(achievements),
        "unlocked": len([a for a in result if a["is_unlocked"]]),
        "achievements": result,
        "newly_unlocked": [{"name": a.name, "xp_reward": a.xp_reward} for a in newly_unlocked]
    }


@router.get("/lessons")
async def get_lessons(
    exam_type: str = "enem",
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get lessons for a specific exam type with user progress and cooldown status"""
    lessons = db.query(models.Lesson).filter(
        models.Lesson.exam_type == exam_type.lower(),
        models.Lesson.is_active == True
    ).order_by(models.Lesson.competency, models.Lesson.order).all()
    
    user_lessons = db.query(models.UserLesson).filter(
        models.UserLesson.user_id == current_user.id
    ).all()
    user_lesson_map = {ul.lesson_id: ul for ul in user_lessons}
    
    settings = get_settings(db)
    now = datetime.utcnow()
    
    competencies = {}
    for lesson in lessons:
        comp = lesson.competency
        if comp not in competencies:
            competencies[comp] = {"competency": comp, "lessons": []}
        
        user_lesson = user_lesson_map.get(lesson.id)
        
        # Check cooldown status
        can_redo = False
        cooldown_remaining = None
        if user_lesson and user_lesson.is_completed:
            if user_lesson.cooldown_until:
                if now >= user_lesson.cooldown_until:
                    can_redo = True
                else:
                    cooldown_remaining = (user_lesson.cooldown_until - now).total_seconds()
            else:
                can_redo = True
        
        competencies[comp]["lessons"].append({
            "id": lesson.id,
            "order": lesson.order,
            "title": lesson.title,
            "description": lesson.description,
            "xp_reward": lesson.xp_reward,
            "is_unlocked": user_lesson.is_unlocked if user_lesson else (lesson.unlock_type == "free"),
            "is_completed": user_lesson.is_completed if user_lesson else False,
            "quiz_score": user_lesson.quiz_score if user_lesson else None,
            "times_completed": user_lesson.times_completed if user_lesson else 0,
            "can_redo": can_redo,
            "cooldown_remaining_seconds": cooldown_remaining
        })
    
    return {
        "exam_type": exam_type,
        "competencies": list(competencies.values()),
        "total_lessons": len(lessons),
        "completed": sum(1 for ul in user_lessons if ul.is_completed),
        "cooldown_hours": settings.lesson_cooldown_hours
    }


@router.get("/lessons/{lesson_id}")
async def get_lesson_content(
    lesson_id: int,
    generate_new_quiz: bool = False,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get full lesson content. If generate_new_quiz=True, generates new AI questions."""
    lesson = db.query(models.Lesson).filter(
        models.Lesson.id == lesson_id,
        models.Lesson.is_active == True
    ).first()
    
    if not lesson:
        raise HTTPException(status_code=404, detail="Lição não encontrada")
    
    user_lesson = db.query(models.UserLesson).filter(
        models.UserLesson.user_id == current_user.id,
        models.UserLesson.lesson_id == lesson_id
    ).first()
    
    is_unlocked = lesson.unlock_type == "free" or (user_lesson and user_lesson.is_unlocked)
    
    if not is_unlocked:
        raise HTTPException(status_code=403, detail="Lição bloqueada")
    
    # Check if in cooldown
    settings = get_settings(db)
    now = datetime.utcnow()
    is_repeat = False
    
    if user_lesson and user_lesson.is_completed:
        if user_lesson.cooldown_until and now < user_lesson.cooldown_until:
            remaining = (user_lesson.cooldown_until - now).total_seconds()
            hours = int(remaining // 3600)
            minutes = int((remaining % 3600) // 60)
            raise HTTPException(
                status_code=403, 
                detail=f"Lição em cooldown. Disponível em {hours}h {minutes}min."
            )
        is_repeat = True
    
    # Get quiz - generate new one if requested and is a repeat
    quiz = None
    if generate_new_quiz and is_repeat:
        # Try to generate new quiz with AI
        ai_quiz = await generate_ai_quiz(lesson.title, lesson.content)
        if ai_quiz:
            quiz = ai_quiz
            logging.info(f"Quiz gerado por IA para lição {lesson_id}")
    
    if not quiz and lesson.quiz_data:
        try:
            quiz = json.loads(lesson.quiz_data)
        except:
            quiz = None
    
    return {
        "id": lesson.id,
        "title": lesson.title,
        "description": lesson.description,
        "content": lesson.content,
        "quiz": quiz,
        "xp_reward": lesson.xp_reward,
        "is_completed": user_lesson.is_completed if user_lesson else False,
        "is_repeat": is_repeat,
        "xp_multiplier": settings.lesson_repeat_xp_percent / 100 if is_repeat else 1.0,
        "quiz_score": user_lesson.quiz_score if user_lesson else None,
        "times_completed": user_lesson.times_completed if user_lesson else 0
    }


@router.post("/lessons/{lesson_id}/complete")
async def complete_lesson(
    lesson_id: int,
    quiz_score: Optional[int] = None,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Mark lesson as complete and award XP (with cooldown system)"""
    lesson = db.query(models.Lesson).filter(models.Lesson.id == lesson_id).first()
    if not lesson:
        raise HTTPException(status_code=404, detail="Lição não encontrada")
    
    settings = get_settings(db)
    now = datetime.utcnow()
    
    user_lesson = db.query(models.UserLesson).filter(
        models.UserLesson.user_id == current_user.id,
        models.UserLesson.lesson_id == lesson_id
    ).first()
    
    if not user_lesson:
        user_lesson = models.UserLesson(
            user_id=current_user.id,
            lesson_id=lesson_id,
            is_unlocked=True,
            times_completed=0
        )
        db.add(user_lesson)
    
    # Check cooldown
    is_repeat = user_lesson.is_completed
    if is_repeat and user_lesson.cooldown_until and now < user_lesson.cooldown_until:
        raise HTTPException(status_code=403, detail="Lição ainda em cooldown")
    
    # Update completion
    user_lesson.is_completed = True
    user_lesson.completed_at = now
    user_lesson.times_completed = (user_lesson.times_completed or 0) + 1
    user_lesson.cooldown_until = now + timedelta(hours=settings.lesson_cooldown_hours)
    
    if quiz_score is not None:
        user_lesson.quiz_score = quiz_score
    
    # Calculate XP
    xp_gained = lesson.xp_reward
    if is_repeat:
        # Reduced XP for repeat
        xp_gained = int(xp_gained * settings.lesson_repeat_xp_percent / 100)
    
    if quiz_score and quiz_score == 100:
        xp_gained += 10  # Bonus for perfect quiz
    
    profile = get_or_create_gamification(db, current_user.id)
    profile.xp_total += xp_gained
    
    if not is_repeat:
        profile.lessons_completed += 1
    
    if quiz_score and quiz_score == 100:
        profile.quizzes_perfect += 1
    
    update_streak(db, profile)
    db.commit()
    
    # Unlock next lesson (only on first completion)
    next_lesson_id = None
    if not is_repeat:
        next_lesson = db.query(models.Lesson).filter(
            models.Lesson.exam_type == lesson.exam_type,
            models.Lesson.competency == lesson.competency,
            models.Lesson.order == lesson.order + 1
        ).first()
        
        if next_lesson:
            next_user_lesson = db.query(models.UserLesson).filter(
                models.UserLesson.user_id == current_user.id,
                models.UserLesson.lesson_id == next_lesson.id
            ).first()
            
            if not next_user_lesson:
                next_user_lesson = models.UserLesson(
                    user_id=current_user.id,
                    lesson_id=next_lesson.id,
                    is_unlocked=True,
                    unlocked_at=now
                )
                db.add(next_user_lesson)
            else:
                next_user_lesson.is_unlocked = True
                next_user_lesson.unlocked_at = now
            
            next_lesson_id = next_lesson.id
            db.commit()
    
    new_achievements = check_achievements(db, current_user.id)
    
    return {
        "success": True,
        "xp_gained": xp_gained,
        "is_repeat": is_repeat,
        "times_completed": user_lesson.times_completed,
        "cooldown_hours": settings.lesson_cooldown_hours,
        "next_lesson_unlocked": next_lesson_id,
        "new_achievements": new_achievements
    }


@router.get("/settings")
async def get_gamification_settings(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get gamification settings (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    settings = get_settings(db)
    return {
        "lesson_cooldown_hours": settings.lesson_cooldown_hours,
        "lesson_repeat_xp_percent": settings.lesson_repeat_xp_percent
    }


@router.put("/settings")
async def update_gamification_settings(
    lesson_cooldown_hours: Optional[int] = None,
    lesson_repeat_xp_percent: Optional[int] = None,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update gamification settings (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    settings = get_settings(db)
    
    if lesson_cooldown_hours is not None:
        settings.lesson_cooldown_hours = max(0, lesson_cooldown_hours)
    
    if lesson_repeat_xp_percent is not None:
        settings.lesson_repeat_xp_percent = max(0, min(100, lesson_repeat_xp_percent))
    
    db.commit()
    
    return {
        "success": True,
        "lesson_cooldown_hours": settings.lesson_cooldown_hours,
        "lesson_repeat_xp_percent": settings.lesson_repeat_xp_percent
    }


@router.get("/challenges")
async def get_challenges(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get daily and weekly challenges with progress"""
    challenges = db.query(models.Challenge).filter(
        models.Challenge.is_active == True
    ).all()
    
    today = datetime.utcnow().replace(hour=0, minute=0, second=0, microsecond=0)
    week_start = today - timedelta(days=today.weekday())
    
    daily_challenges = []
    weekly_challenges = []
    
    for challenge in challenges:
        period_start = today if challenge.challenge_type == "daily" else week_start
        
        user_challenge = db.query(models.UserChallenge).filter(
            models.UserChallenge.user_id == current_user.id,
            models.UserChallenge.challenge_id == challenge.id,
            models.UserChallenge.period_start >= period_start
        ).first()
        
        challenge_data = {
            "id": challenge.id,
            "title": challenge.title,
            "description": challenge.description,
            "icon": challenge.icon,
            "target": challenge.target_count,
            "progress": user_challenge.progress if user_challenge else 0,
            "is_completed": user_challenge.is_completed if user_challenge else False,
            "xp_reward": challenge.xp_reward,
            "coin_reward": challenge.coin_reward
        }
        
        if challenge.challenge_type == "daily":
            daily_challenges.append(challenge_data)
        else:
            weekly_challenges.append(challenge_data)
    
    return {
        "daily": daily_challenges,
        "weekly": weekly_challenges,
        "daily_reset": (today + timedelta(days=1)).isoformat(),
        "weekly_reset": (week_start + timedelta(days=7)).isoformat()
    }


@router.get("/ranking")
async def get_ranking(
    category: str = "xp",
    limit: int = 10,
    db: Session = Depends(get_db)
):
    """Get global ranking by category (xp, lessons, streak)"""
    if category == "xp":
        rankings = db.query(
            models.UserGamification,
            models.User.full_name
        ).join(
            models.User,
            models.User.id == models.UserGamification.user_id
        ).order_by(desc(models.UserGamification.xp_total)).limit(limit).all()
        
        return {
            "category": "XP Total",
            "rankings": [
                {"rank": i + 1, "user_name": r[1] or "Anônimo", "value": r[0].xp_total, "level": r[0].level}
                for i, r in enumerate(rankings)
            ]
        }
    
    elif category == "lessons":
        rankings = db.query(
            models.UserGamification,
            models.User.full_name
        ).join(
            models.User,
            models.User.id == models.UserGamification.user_id
        ).order_by(desc(models.UserGamification.lessons_completed)).limit(limit).all()
        
        return {
            "category": "Lições Completadas",
            "rankings": [
                {"rank": i + 1, "user_name": r[1] or "Anônimo", "value": r[0].lessons_completed, "level": r[0].level}
                for i, r in enumerate(rankings)
            ]
        }
    
    elif category == "streak":
        rankings = db.query(
            models.UserGamification,
            models.User.full_name
        ).join(
            models.User,
            models.User.id == models.UserGamification.user_id
        ).order_by(desc(models.UserGamification.max_streak)).limit(limit).all()
        
        return {
            "category": "Maior Streak",
            "rankings": [
                {"rank": i + 1, "user_name": r[1] or "Anônimo", "value": r[0].max_streak, "level": r[0].level}
                for i, r in enumerate(rankings)
            ]
        }
    
    else:
        raise HTTPException(status_code=400, detail="Categoria inválida")
