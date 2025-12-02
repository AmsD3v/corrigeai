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
    
    # Update complementary info fields
    if profile_data.school_level is not None:
        current_user.school_level = profile_data.school_level if profile_data.school_level.strip() else None
    if profile_data.intended_course is not None:
        current_user.intended_course = profile_data.intended_course if profile_data.intended_course.strip() else None
    if profile_data.state is not None:
        current_user.state = profile_data.state if profile_data.state.strip() else None
    if profile_data.city is not None:
        current_user.city = profile_data.city if profile_data.city.strip() else None
    if profile_data.enem_attempts is not None:
        current_user.enem_attempts = profile_data.enem_attempts if profile_data.enem_attempts.strip() else None
    if profile_data.previous_scores is not None:
        current_user.previous_scores = profile_data.previous_scores if profile_data.previous_scores.strip() else None
    if profile_data.main_goal is not None:
        current_user.main_goal = profile_data.main_goal if profile_data.main_goal.strip() else None
    if profile_data.study_method is not None:
        current_user.study_method = profile_data.study_method if profile_data.study_method.strip() else None
    
    db.commit()
    db.refresh(current_user)
    
    return current_user

@router.delete("/users/me")
async def delete_my_account(
    current_user: models.User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Delete current user's account permanently.
    This will delete all submissions and corrections associated with the user.
    """
    try:
        # Delete all corrections first (foreign key constraint)
        corrections_to_delete = db.query(models.Correction).join(
            models.Submission
        ).filter(
            models.Submission.owner_id == current_user.id
        ).all()
        
        for correction in corrections_to_delete:
            db.delete(correction)
        
        # Delete all submissions
        submissions_to_delete = db.query(models.Submission).filter(
            models.Submission.owner_id == current_user.id
        ).all()
        
        for submission in submissions_to_delete:
            db.delete(submission)
        
        # Delete the user
        db.delete(current_user)
        db.commit()
        
        return {
            "message": "Conta excluída com sucesso",
            "deleted_user_id": current_user.id
        }
    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"Erro ao excluir conta: {str(e)}"
        )

