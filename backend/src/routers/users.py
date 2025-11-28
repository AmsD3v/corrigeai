from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import schemas, models
from ..dependencies import get_current_user, get_db

router = APIRouter()

@router.get("/users/me", response_model=schemas.User)
async def read_users_me(current_user: models.User = Depends(get_current_user)):
    return current_user

@router.put("/users/me/profile", response_model=schemas.User)
async def update_profile(
    profile_data: schemas.UserProfileUpdate,
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Update current user's profile information.
    Users can update their own full_name, email, phone, and birth_date.
    """
    # Check if email is being changed and if it's already in use
    if profile_data.email and profile_data.email != current_user.email:
        existing_user = db.query(models.User).filter(
            models.User.email == profile_data.email
        ).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Email já está em uso")
    
    # Update fields if provided
    if profile_data.full_name is not None:
        current_user.full_name = profile_data.full_name
    if profile_data.email is not None:
        current_user.email = profile_data.email
    if profile_data.phone is not None:
        current_user.phone = profile_data.phone if profile_data.phone.strip() else None
    if profile_data.birth_date is not None:
        current_user.birth_date = profile_data.birth_date if profile_data.birth_date.strip() else None
    
    db.commit()
    db.refresh(current_user)
    
    return current_user
