import bleach
from pydantic import BaseModel, EmailStr, ConfigDict, field_validator
from typing import Optional
from datetime import datetime
import re

class UserBase(BaseModel):
    email: EmailStr
    full_name: Optional[str] = None

    @field_validator('full_name')
    @classmethod
    def validate_full_name(cls, v):
        if v is not None and len(v) > 100:
            raise ValueError('Nome completo não pode ter mais de 100 caracteres')
        return v

class UserCreate(UserBase):
    password: str

    @field_validator('password')
    @classmethod
    def validate_password(cls, v):
        if len(v) < 8:
            raise ValueError('A senha deve ter pelo menos 8 caracteres')
        if not re.search(r'[A-Z]', v):
            raise ValueError('A senha deve conter pelo menos uma letra maiúscula')
        if not re.search(r'[a-z]', v):
            raise ValueError('A senha deve conter pelo menos uma letra minúscula')
        if not re.search(r'\d', v):
            raise ValueError('A senha deve conter pelo menos um número')
        if not re.search(r'[!@#$%^&*(),.?":{}|<>]', v):
            raise ValueError('A senha deve conter pelo menos um caractere especial')
        return v

class UserLogin(BaseModel):
    username: EmailStr
    password: str

class User(UserBase):
    id: int
    is_active: bool
    created_at: datetime
    role: str
    credits: int
    free_credits: int = 0
    is_admin: bool = False

    model_config = ConfigDict(from_attributes=True) # Usa ConfigDict

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    id: Optional[int] = None

class SubmissionBase(BaseModel):
    title: str
    theme: Optional[str] = None
    exam_type: Optional[str] = None
    content: str
    correction_type: str = "advanced"  # "advanced" or "premium"

    @field_validator('title')
    @classmethod
    def validate_title(cls, v):
        if not v or len(v.strip()) == 0:
            raise ValueError('O título é obrigatório')
        if len(v) > 200:
            raise ValueError('O título não pode ter mais de 200 caracteres')
        return bleach.clean(v.strip())

    @field_validator('content')
    @classmethod
    def validate_content(cls, v):
        if len(v.strip()) < 500:
            raise ValueError('O conteúdo deve ter pelo menos 500 caracteres')
        if len(v) > 5000:
            raise ValueError('O conteúdo não pode ter mais de 5.000 caracteres')
        return bleach.clean(v)

class SubmissionCreate(SubmissionBase):
    pass

class CorrectionResponse(BaseModel):
    feedback: list[str]
    score: Optional[int] = None

class SubmissionResponse(SubmissionBase):
    id: int
    submitted_at: datetime
    status: str
    owner_id: int

    model_config = ConfigDict(from_attributes=True)

# Payment Schemas
class PackageData(BaseModel):
    id: str
    name: str
    price: float
    coins: int
    bonus: int = 0

class CreatePreferenceRequest(BaseModel):
    package: Optional[PackageData] = None
    package_id: Optional[str] = None

class PreferenceResponse(BaseModel):
    success: bool
    preference_id: Optional[str] = None
    init_point: Optional[str] = None
    error: Optional[str] = None

class WebhookNotification(BaseModel):
    id: Optional[str] = None
    live_mode: Optional[bool] = None
    type: Optional[str] = None
    date_created: Optional[str] = None
    user_id: Optional[str] = None
    api_version: Optional[str] = None
    action: Optional[str] = None
    data: Optional[dict] = None

class TransactionResponse(BaseModel):
    id: int
    user_id: int
    payment_id: Optional[str]
    package_name: str
    coins_amount: int
    bonus_coins: int
    price: int
    status: str
    created_at: datetime
    
    model_config = ConfigDict(from_attributes=True)

class CorrectionDetail(BaseModel):
    """Detailed correction results for an essay"""
    id: int
    submission_id: int
    
    # ENEM Competencies scores (0-200 each)
    competence_1_score: int
    competence_2_score: int
    competence_3_score: int
    competence_4_score: int
    competence_5_score: int
    total_score: int
    
    # Detailed feedback for each competency
    competence_1_feedback: str
    competence_2_feedback: str
    competence_3_feedback: str
    competence_4_feedback: str
    competence_5_feedback: str
    
    # General feedback (JSON strings that will be parsed by frontend)
    strengths: str  # JSON array
    improvements: str  # JSON array
    general_comments: str
    
    corrected_at: datetime
    
    model_config = ConfigDict(from_attributes=True)

# Package Schemas
class PackageBase(BaseModel):
    name: str
    credits: int
    price: int  # Price in cents (final price after discount)
    discount_percentage: int = 0  # Discount percentage (0-100)
    bonus: int = 0
    discount_text: Optional[str] = None
    feature1: Optional[str] = None
    feature2: Optional[str] = None
    feature3: Optional[str] = None
    feature4: Optional[str] = None
    features: Optional[str] = None  # Legacy JSON field, kept for compatibility
    is_active: bool = True
    is_popular: bool = False

class PackageCreate(PackageBase):
    id: str

class PackageUpdate(BaseModel):
    name: Optional[str] = None
    credits: Optional[int] = None
    price: Optional[int] = None
    discount_percentage: Optional[int] = None
    bonus: Optional[int] = None
    discount_text: Optional[str] = None
    feature1: Optional[str] = None
    feature2: Optional[str] = None
    feature3: Optional[str] = None
    feature4: Optional[str] = None
    features: Optional[str] = None
    is_active: Optional[bool] = None
    is_popular: Optional[bool] = None

class Package(PackageBase):
    id: str
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)