import bleach
from pydantic import BaseModel, EmailStr, ConfigDict, field_validator
from typing import Optional, List
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

class FeedbackCreate(BaseModel):
    type: str
    message: str
    
    @field_validator('type')
    @classmethod
    def validate_type(cls, v):
        allowed_types = ['sugestao', 'bug', 'reclamacao', 'elogio', 'outro']
        if v not in allowed_types:
            raise ValueError(f'Tipo inválido. Deve ser um de: {", ".join(allowed_types)}')
        return v
    
    @field_validator('message')
    @classmethod
    def validate_message(cls, v):
        v = v.strip()
        if len(v) < 10:
            raise ValueError('Mensagem muito curta. Mínimo de 10 caracteres.')
        if len(v) > 1000:
            raise ValueError('Mensagem muito longa. Máximo de 1000 caracteres.')
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
    phone: Optional[str] = None
    birth_date: Optional[str] = None

    model_config = ConfigDict(from_attributes=True) # Usa ConfigDict

class UserUpdate(BaseModel):
    """Schema for admin to update user details"""
    full_name: Optional[str] = None
    email: Optional[EmailStr] = None
    credits: Optional[int] = None
    free_credits: Optional[int] = None

class UserProfileUpdate(BaseModel):
    """Schema for user to update their own profile"""
    full_name: Optional[str] = None
    email: Optional[EmailStr] = None
    phone: Optional[str] = None
    birth_date: Optional[str] = None
    
    @field_validator('phone')
    @classmethod
    def validate_phone(cls, v):
        if v is not None and v.strip():
            # Remove non-digits
            digits = ''.join(filter(str.isdigit, v))
            if len(digits) not in [10, 11]:
                raise ValueError('Telefone deve ter 10 ou 11 dígitos')
        return v
    
    @field_validator('birth_date')
    @classmethod
    def validate_birth_date(cls, v):
        if v is not None and v.strip():
            try:
                from datetime import datetime
                birth = datetime.strptime(v, '%Y-%m-%d')
                age = (datetime.now() - birth).days // 365
                if age < 13:
                    raise ValueError('Você deve ter pelo menos 13 anos')
            except ValueError as e:
                if 'does not match format' in str(e):
                    raise ValueError('Data deve estar no formato YYYY-MM-DD')
                raise
        return v

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
    
    @field_validator('exam_type')
    @classmethod
    def validate_exam_type(cls, v):
        if v is None:
            return 'enem'  # Padrão é ENEM
        
        allowed_types = [
            'enem', 'fuvest', 'unicamp', 'ita', 'unesp',
            'uerj', 'ufmg', 'afa', 'cacd', 'sisu'
        ]
        
        v = v.lower().strip()
        if v not in allowed_types:
            raise ValueError(
                f'Tipo de vestibular inválido. Deve ser um de: {", ".join(allowed_types)}'
            )
        return v

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
    
    corrected_at: Optional[datetime] = None
    exam_type: Optional[str] = "enem"  # Field from Submission, not Correction table
    
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