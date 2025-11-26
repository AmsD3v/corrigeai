from sqlalchemy import Boolean, Column, Integer, String, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from datetime import datetime

# Importação da Base declarativa centralizada
from .database import Base

class User(Base):
    __tablename__ = "user"  # Usando aspas para evitar conflito com a palavra reservada 'user'
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    theme = Column(String, nullable=True)
    exam_type = Column(String, nullable=True)
    content = Column(Text)
    submitted_at = Column(DateTime, default=datetime.utcnow)
    status = Column(String, default="pending")
    correction_type = Column(String, default="advanced")  # "advanced" or "premium"
    owner_id = Column(Integer, ForeignKey("user.id"))

    owner = relationship("User", back_populates="submissions")
    correction = relationship("Correction", back_populates="submission", uselist=False)

class Correction(Base):
    __tablename__ = "correction"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    submission_id = Column(Integer, ForeignKey("submission.id"), unique=True, nullable=False)
    
    # ENEM Competencies (0-200 points each)
    competence_1_score = Column(Integer, nullable=False)  # Domínio da norma culta
    competence_2_score = Column(Integer, nullable=False)  # Compreensão do tema
    competence_3_score = Column(Integer, nullable=False)  # Argumentação
    competence_4_score = Column(Integer, nullable=False)  # Coesão
    competence_5_score = Column(Integer, nullable=False)  # Proposta de intervenção
    
    # Total score (sum of all competencies, max 1000)
    total_score = Column(Integer, nullable=False)
    
    # Detailed feedback for each competency
    competence_1_feedback = Column(Text, nullable=False)
    competence_2_feedback = Column(Text, nullable=False)
    competence_3_feedback = Column(Text, nullable=False)
    competence_4_feedback = Column(Text, nullable=False)
    competence_5_feedback = Column(Text, nullable=False)
    
    # General feedback (stored as JSON strings)
    strengths = Column(Text, nullable=False)  # JSON array of strengths
    improvements = Column(Text, nullable=False)  # JSON array of improvements
    general_comments = Column(Text, nullable=False)
    
    corrected_at = Column(DateTime, default=datetime.utcnow)
    
    submission = relationship("Submission", back_populates="correction")

class Transaction(Base):
    __tablename__ = "transaction"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    
    # Mercado Pago data
    payment_id = Column(String, unique=True, nullable=True)  # MP payment ID
    preference_id = Column(String, nullable=True)  # MP preference ID
    external_reference = Column(String, nullable=True)  # Our reference
    
    # Transaction details
    package_id = Column(String, nullable=False)  # Package identifier
    package_name = Column(String, nullable=False)  # Package name
    coins_amount = Column(Integer, nullable=False)  # Coins purchased
    bonus_coins = Column(Integer, default=0)  # Bonus coins
    price = Column(Integer, nullable=False)  # Price in cents (BRL)
    
    # Payment info
    payment_method = Column(String, nullable=True)  # credit_card, pix, etc
    payment_type = Column(String, nullable=True)  # credit_card, debit_card, etc
    status = Column(String, default="pending")  # pending, approved, rejected, cancelled
    status_detail = Column(String, nullable=True)  # Detailed status from MP
    
    # Timestamps
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    approved_at = Column(DateTime, nullable=True)
    
    # Relationship
    user = relationship("User")

class Package(Base):
    __tablename__ = "package"
    __table_args__ = {'extend_existing': True}

    id = Column(String, primary_key=True, index=True)
    name = Column(String, nullable=False)
    credits = Column(Integer, nullable=False)
    price = Column(Integer, nullable=False)  # Price in cents (final price after discount)
    discount_percentage = Column(Integer, default=0)  # Discount percentage (0-100)
    bonus = Column(Integer, default=0)
    discount_text = Column(String, nullable=True)  # e.g. "15% OFF!"
    feature1 = Column(String, nullable=True)  # Feature text 1
    feature2 = Column(String, nullable=True)  # Feature text 2
    feature3 = Column(String, nullable=True)  # Feature text 3
    feature4 = Column(String, nullable=True)  # Feature text 4
    features = Column(Text, nullable=True)  # Legacy JSON string of features
    is_active = Column(Boolean, default=True)
    is_popular = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class Settings(Base):
    """Global application settings (one row only)"""
    __tablename__ = "settings"
    __table_args__ = {'extend_existing': True}
    
    id = Column(Integer, primary_key=True, index=True, default=1)
    active_ai_provider = Column(String, default="groq")  # groq, gemini, huggingface, together
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)