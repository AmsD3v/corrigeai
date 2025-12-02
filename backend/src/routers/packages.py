from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from .. import schemas, models
from ..database import get_db
from ..dependencies import get_current_user, get_current_admin_user

router = APIRouter()

@router.get("/api/packages", response_model=List[schemas.Package])
def read_packages(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """Public endpoint: returns only active packages for users"""
    packages = db.query(models.Package).filter(
        models.Package.is_active == True
    ).order_by(models.Package.price.asc()).offset(skip).limit(limit).all()
    return packages

@router.get("/api/packages/all", response_model=List[schemas.Package])
def read_all_packages(
    skip: int = 0, 
    limit: int = 100,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    """Admin endpoint: returns ALL packages (active and inactive)"""
    packages = db.query(models.Package).order_by(
        models.Package.created_at.asc()
    ).offset(skip).limit(limit).all()
    return packages

@router.post("/api/packages", response_model=schemas.Package)
def create_package(package: schemas.PackageCreate, current_user: models.User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Check if user is admin (simple check for now, can be improved)
    if current_user.role != "admin":
        raise HTTPException(status_code=403, detail="Not authorized")
    
    db_package = models.Package(**package.dict())
    db.add(db_package)
    db.commit()
    db.refresh(db_package)
    return db_package

@router.put("/api/packages/{package_id}", response_model=schemas.Package)
def update_package(
    package_id: str, 
    package: schemas.PackageUpdate, 
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(get_current_admin_user)
):
    db_package = db.query(models.Package).filter(models.Package.id == package_id).first()
    if not db_package:
        raise HTTPException(status_code=404, detail="Package not found")
    
    update_data = package.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_package, key, value)
    
    db.commit()
    db.refresh(db_package)
    return db_package
