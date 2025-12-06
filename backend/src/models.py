from sqlalchemy import Boolean, Column, Integer, String, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from datetime import datetime

# Importação da Base declarativa centralizada
from .database import Base

class User(Base):
    __tablename__ = "user"
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    hashed_refresh_token = Column(String, index=True, nullable=True)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    role = Column(String, default="aluno")
    credits = Column(Integer, default=1)
    free_credits = Column(Integer, default=0)
    is_admin = Column(Boolean, default=False)
    phone = Column(String, nullable=True)
    birth_date = Column(String, nullable=True)
    reset_token = Column(String, nullable=True)
    reset_token_expires = Column(DateTime, nullable=True)
    
    # Complementary Information Fields (Analytics)
    school_level = Column(String, nullable=True)
    intended_course = Column(String, nullable=True)
    state = Column(String, nullable=True)
    city = Column(String, nullable=True)
    enem_attempts = Column(String, nullable=True)
    previous_scores = Column(String, nullable=True)
    main_goal = Column(String, nullable=True)
    study_method = Column(String, nullable=True)

    submissions = relationship("Submission", back_populates="owner")


class Submission(Base):
    __tablename__ = "submission"
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    theme = Column(String, nullable=True)
    exam_type = Column(String, nullable=True)
    content = Column(Text)
    submitted_at = Column(DateTime, default=datetime.utcnow)
    status = Column(String, default="pending")
    correction_type = Column(String, default="advanced")
    owner_id = Column(Integer, ForeignKey("user.id"))

    owner = relationship("User", back_populates="submissions")
    correction = relationship("Correction", back_populates="submission", uselist=False)


class Correction(Base):
    __tablename__ = "correction"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    submission_id = Column(Integer, ForeignKey("submission.id"), unique=True, nullable=False)
    
    competence_1_score = Column(Integer, nullable=False)
    competence_2_score = Column(Integer, nullable=False)
    competence_3_score = Column(Integer, nullable=False)
    competence_4_score = Column(Integer, nullable=False)
    competence_5_score = Column(Integer, nullable=False)
    total_score = Column(Integer, nullable=False)
    
    competence_1_feedback = Column(Text, nullable=False)
    competence_2_feedback = Column(Text, nullable=False)
    competence_3_feedback = Column(Text, nullable=False)
    competence_4_feedback = Column(Text, nullable=False)
    competence_5_feedback = Column(Text, nullable=False)
    
    strengths = Column(Text, nullable=False)
    improvements = Column(Text, nullable=False)
    general_comments = Column(Text, nullable=False)
    
    corrected_at = Column(DateTime, default=datetime.utcnow)
    
    submission = relationship("Submission", back_populates="correction")


class Transaction(Base):
    __tablename__ = "transaction"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    
    payment_id = Column(String, unique=True, nullable=True)
    preference_id = Column(String, nullable=True)
    external_reference = Column(String, nullable=True)
    
    package_id = Column(String, nullable=False)
    package_name = Column(String, nullable=False)
    coins_amount = Column(Integer, nullable=False)
    bonus_coins = Column(Integer, default=0)
    price = Column(Integer, nullable=False)
    
    payment_method = Column(String, nullable=True)
    payment_type = Column(String, nullable=True)
    status = Column(String, default="pending")
    status_detail = Column(String, nullable=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    approved_at = Column(DateTime, nullable=True)
    
    user = relationship("User")


class Package(Base):
    __tablename__ = "package"
    __table_args__ = {'extend_existing': True}

    id = Column(String, primary_key=True, index=True)
    name = Column(String, nullable=False)
    credits = Column(Integer, nullable=False)
    price = Column(Integer, nullable=False)
    discount_percentage = Column(Integer, default=0)
    bonus = Column(Integer, default=0)
    discount_text = Column(String, nullable=True)
    feature1 = Column(String, nullable=True)
    feature2 = Column(String, nullable=True)
    feature3 = Column(String, nullable=True)
    feature4 = Column(String, nullable=True)
    features = Column(Text, nullable=True)
    is_active = Column(Boolean, default=True)
    is_popular = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class Settings(Base):
    """Global application settings"""
    __tablename__ = "settings"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True, default=1)
    active_ai_provider = Column(String, default="groq")
    
    gemini_api_key = Column(String, nullable=True)
    groq_api_key = Column(String, nullable=True)
    hf_token = Column(String, nullable=True)
    together_api_key = Column(String, nullable=True)
    
    # Gamification settings
    lesson_cooldown_hours = Column(Integer, default=168)
    lesson_repeat_xp_percent = Column(Integer, default=50)
    
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class Feedback(Base):
    """User feedback on essay corrections"""
    __tablename__ = "feedback"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    submission_id = Column(Integer, ForeignKey("submission.id", ondelete="CASCADE"), nullable=False)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    is_helpful = Column(Boolean, nullable=False, default=True)
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)


# ==================== GAMIFICATION MODELS ====================

class UserGamification(Base):
    """User gamification profile - XP, level, streak (GLOBAL)"""
    __tablename__ = "user_gamification"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), unique=True, nullable=False)
    
    xp_total = Column(Integer, default=0, nullable=False)
    level = Column(Integer, default=1, nullable=False)
    
    current_streak = Column(Integer, default=0, nullable=False)
    max_streak = Column(Integer, default=0, nullable=False)
    last_activity_date = Column(DateTime, nullable=True)
    
    lessons_completed = Column(Integer, default=0, nullable=False)
    quizzes_perfect = Column(Integer, default=0, nullable=False)
    
    created_at = Column(DateTime, default=datetime.utcnow, nullable=False)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class Achievement(Base):
    """Achievement/Badge definitions - can be global or per exam_type"""
    __tablename__ = "achievement"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    code = Column(String, unique=True, nullable=False)
    name = Column(String, nullable=False)
    description = Column(String, nullable=False)
    icon = Column(String, default="🏆")
    
    # NULL = global achievement, otherwise specific to exam type
    exam_type = Column(String, nullable=True, index=True)
    
    xp_reward = Column(Integer, default=0)
    coin_reward = Column(Integer, default=0)
    lessons_reward = Column(Integer, default=0)
    
    condition_type = Column(String, nullable=False)
    condition_value = Column(Integer, nullable=False)
    
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)


class UserAchievement(Base):
    """User unlocked achievements"""
    __tablename__ = "user_achievement"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    achievement_id = Column(Integer, ForeignKey("achievement.id", ondelete="CASCADE"), nullable=False)
    unlocked_at = Column(DateTime, default=datetime.utcnow, nullable=False)


class Lesson(Base):
    """Interactive lessons content - organized by exam_type"""
    __tablename__ = "lesson"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    
    exam_type = Column(String, nullable=False, index=True)
    competency = Column(Integer, nullable=False)
    order = Column(Integer, nullable=False)
    
    title = Column(String, nullable=False)
    description = Column(String, nullable=True)
    content = Column(Text, nullable=False)
    
    quiz_data = Column(Text, nullable=True)
    
    xp_reward = Column(Integer, default=25)
    
    unlock_type = Column(String, default="previous")
    unlock_value = Column(Integer, default=0)
    
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)


class UserLesson(Base):
    """User lesson progress"""
    __tablename__ = "user_lesson"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    lesson_id = Column(Integer, ForeignKey("lesson.id", ondelete="CASCADE"), nullable=False)
    
    is_unlocked = Column(Boolean, default=False)
    is_completed = Column(Boolean, default=False)
    quiz_score = Column(Integer, nullable=True)
    times_completed = Column(Integer, default=0)
    
    unlocked_at = Column(DateTime, nullable=True)
    completed_at = Column(DateTime, nullable=True)
    cooldown_until = Column(DateTime, nullable=True)


class Challenge(Base):
    """Daily/Weekly challenges"""
    __tablename__ = "challenge"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    
    challenge_type = Column(String, nullable=False)
    title = Column(String, nullable=False)
    description = Column(String, nullable=False)
    icon = Column(String, default="🎯")
    
    action_type = Column(String, nullable=False)
    target_count = Column(Integer, default=1)
    
    xp_reward = Column(Integer, default=10)
    coin_reward = Column(Integer, default=0)
    
    is_active = Column(Boolean, default=True)


class UserChallenge(Base):
    """User challenge progress"""
    __tablename__ = "user_challenge"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), nullable=False)
    challenge_id = Column(Integer, ForeignKey("challenge.id", ondelete="CASCADE"), nullable=False)
    
    progress = Column(Integer, default=0)
    is_completed = Column(Boolean, default=False)
    
    period_start = Column(DateTime, nullable=False)
    completed_at = Column(DateTime, nullable=True)