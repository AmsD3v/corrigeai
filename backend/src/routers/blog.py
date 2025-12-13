"""
Blog Router - Endpoints for blog posts
Public endpoints for viewing posts and Admin endpoints for CRUD
"""
from fastapi import APIRouter, Depends, HTTPException, status, UploadFile, File
from sqlalchemy.orm import Session, joinedload
from sqlalchemy import desc
from typing import List, Optional
from datetime import datetime
import os
import uuid

from ..database import get_db
from ..models import BlogPost, BlogTag, User
from ..schemas import (
    BlogTagCreate, BlogTagResponse,
    BlogPostCreate, BlogPostUpdate, BlogPostResponse, BlogPostListResponse
)
from ..routers.auth import get_current_user

router = APIRouter()


# ==================== PUBLIC ENDPOINTS ====================

@router.get("/posts", response_model=List[BlogPostListResponse])
async def list_published_posts(
    skip: int = 0,
    limit: int = 10,
    tag_slug: Optional[str] = None,
    db: Session = Depends(get_db)
):
    """List all published blog posts (public)"""
    query = db.query(BlogPost).options(joinedload(BlogPost.tags)).filter(
        BlogPost.is_published == True
    )
    
    if tag_slug:
        query = query.join(BlogPost.tags).filter(BlogTag.slug == tag_slug)
    
    posts = query.order_by(desc(BlogPost.published_at)).offset(skip).limit(limit).all()
    return posts


@router.get("/posts/{slug}", response_model=BlogPostResponse)
async def get_post_by_slug(slug: str, db: Session = Depends(get_db)):
    """Get a single published post by slug (public)"""
    post = db.query(BlogPost).options(joinedload(BlogPost.tags)).filter(
        BlogPost.slug == slug,
        BlogPost.is_published == True
    ).first()
    
    if not post:
        raise HTTPException(status_code=404, detail="Post não encontrado")
    
    return post


@router.get("/tags", response_model=List[BlogTagResponse])
async def list_tags(db: Session = Depends(get_db)):
    """List all tags (public)"""
    return db.query(BlogTag).order_by(BlogTag.name).all()


# ==================== ADMIN ENDPOINTS ====================

@router.get("/admin/posts", response_model=List[BlogPostListResponse])
async def admin_list_posts(
    skip: int = 0,
    limit: int = 50,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """List all blog posts including drafts (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    posts = db.query(BlogPost).options(joinedload(BlogPost.tags)).order_by(
        desc(BlogPost.created_at)
    ).offset(skip).limit(limit).all()
    
    return posts


@router.get("/admin/posts/{id}", response_model=BlogPostResponse)
async def admin_get_post(
    id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get a single post by ID (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    post = db.query(BlogPost).options(joinedload(BlogPost.tags)).filter(
        BlogPost.id == id
    ).first()
    
    if not post:
        raise HTTPException(status_code=404, detail="Post não encontrado")
    
    return post


@router.post("/admin/posts", response_model=BlogPostResponse)
async def create_post(
    post_data: BlogPostCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a new blog post (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    # Check if slug already exists
    existing = db.query(BlogPost).filter(BlogPost.slug == post_data.slug).first()
    if existing:
        raise HTTPException(status_code=400, detail="Slug já existe")
    
    # Get tags
    tags = []
    if post_data.tag_ids:
        tags = db.query(BlogTag).filter(BlogTag.id.in_(post_data.tag_ids)).all()
    
    # Create post
    post = BlogPost(
        title=post_data.title,
        slug=post_data.slug,
        excerpt=post_data.excerpt,
        content=post_data.content,
        cover_image=post_data.cover_image,
        meta_title=post_data.meta_title,
        meta_description=post_data.meta_description,
        is_published=post_data.is_published,
        published_at=datetime.utcnow() if post_data.is_published else None,
        author_id=current_user.id,
        tags=tags
    )
    
    db.add(post)
    db.commit()
    db.refresh(post)
    
    return post


@router.put("/admin/posts/{id}", response_model=BlogPostResponse)
async def update_post(
    id: int,
    post_data: BlogPostUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update a blog post (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    post = db.query(BlogPost).filter(BlogPost.id == id).first()
    if not post:
        raise HTTPException(status_code=404, detail="Post não encontrado")
    
    # Check if new slug already exists (if changing)
    if post_data.slug and post_data.slug != post.slug:
        existing = db.query(BlogPost).filter(BlogPost.slug == post_data.slug).first()
        if existing:
            raise HTTPException(status_code=400, detail="Slug já existe")
    
    # Update fields
    update_data = post_data.model_dump(exclude_unset=True, exclude={'tag_ids'})
    for field, value in update_data.items():
        setattr(post, field, value)
    
    # Handle publishing
    if post_data.is_published is True and not post.published_at:
        post.published_at = datetime.utcnow()
    
    # Update tags if provided
    if post_data.tag_ids is not None:
        tags = db.query(BlogTag).filter(BlogTag.id.in_(post_data.tag_ids)).all()
        post.tags = tags
    
    db.commit()
    db.refresh(post)
    
    return post


@router.delete("/admin/posts/{id}")
async def delete_post(
    id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Delete a blog post (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    post = db.query(BlogPost).filter(BlogPost.id == id).first()
    if not post:
        raise HTTPException(status_code=404, detail="Post não encontrado")
    
    db.delete(post)
    db.commit()
    
    return {"message": "Post deletado com sucesso"}


# ==================== TAG ADMIN ENDPOINTS ====================

@router.post("/admin/tags", response_model=BlogTagResponse)
async def create_tag(
    tag_data: BlogTagCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a new tag (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    # Check if slug already exists
    existing = db.query(BlogTag).filter(BlogTag.slug == tag_data.slug).first()
    if existing:
        raise HTTPException(status_code=400, detail="Slug de tag já existe")
    
    tag = BlogTag(
        name=tag_data.name,
        slug=tag_data.slug,
        color=tag_data.color
    )
    
    db.add(tag)
    db.commit()
    db.refresh(tag)
    
    return tag


@router.delete("/admin/tags/{id}")
async def delete_tag(
    id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Delete a tag (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    tag = db.query(BlogTag).filter(BlogTag.id == id).first()
    if not tag:
        raise HTTPException(status_code=404, detail="Tag não encontrada")
    
    db.delete(tag)
    db.commit()
    
    return {"message": "Tag deletada com sucesso"}


# ==================== IMAGE UPLOAD ====================

UPLOAD_DIR = "/app/uploads/blog"

@router.post("/admin/upload-image")
async def upload_image(
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Upload an image for blog posts (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    # Validate file type
    allowed_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    if file.content_type not in allowed_types:
        raise HTTPException(status_code=400, detail="Tipo de arquivo não permitido")
    
    # Create upload directory if not exists
    os.makedirs(UPLOAD_DIR, exist_ok=True)
    
    # Generate unique filename
    ext = file.filename.split(".")[-1]
    filename = f"{uuid.uuid4()}.{ext}"
    filepath = os.path.join(UPLOAD_DIR, filename)
    
    # Save file
    content = await file.read()
    with open(filepath, "wb") as f:
        f.write(content)
    
    # Return URL (adjust based on your server configuration)
    return {"url": f"/uploads/blog/{filename}"}


# ==================== AI IMAGE GENERATION ====================

from pydantic import BaseModel
import httpx
import base64

class GenerateImageRequest(BaseModel):
    title: str
    excerpt: Optional[str] = None

@router.post("/admin/generate-cover-image")
async def generate_cover_image(
    request: GenerateImageRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Generate a cover image for blog post using Hugging Face Inference API (admin only)"""
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Acesso negado")
    
    try:
        import os
        
        # Get HF_TOKEN from database settings (novo campo image_api_key) or environment
        from ..models import Settings as SettingsModel
        db_settings = db.query(SettingsModel).first()
        
        hf_token = None
        if db_settings:
            # Primeiro tenta image_api_key (novo), depois hf_token (legado)
            hf_token = getattr(db_settings, 'image_api_key', None) or getattr(db_settings, 'hf_token', None)
        
        if not hf_token:
            hf_token = os.getenv('HF_TOKEN')
        
        if not hf_token:
            raise HTTPException(
                status_code=500, 
                detail="Chave HuggingFace não configurada. Configure em Configurações > Geração de Imagens."
            )
        
        # Create prompt for image generation (writing/education theme)
        prompt = f"""Professional blog cover for educational writing platform.
Theme: Essay writing, education, ENEM exam preparation.

Visual elements: Elegant fountain pen, open notebook, flowing ink, 
paper sheets, soft bokeh lights, study desk atmosphere.

Style: Modern, premium, blue and purple gradient tones, 
cinematic lighting, shallow depth of field, abstract and artistic.

NO TEXT in the image. High quality, 16:9 aspect ratio.

Context: {request.title}"""

        # Hugging Face Inference API - Stable Diffusion XL
        model_id = "stabilityai/stable-diffusion-xl-base-1.0"
        api_url = f"https://router.huggingface.co/hf-inference/models/{model_id}"
        
        async with httpx.AsyncClient() as client:
            response = await client.post(
                api_url,
                headers={
                    "Authorization": f"Bearer {hf_token}",
                    "Content-Type": "application/json"
                },
                json={
                    "inputs": prompt,
                    "parameters": {
                        "width": 1024,
                        "height": 576,  # 16:9 aspect ratio
                        "num_inference_steps": 30,
                        "guidance_scale": 7.5
                    }
                },
                timeout=120.0  # Longer timeout for image generation
            )
        
        if response.status_code == 200:
            # Save the generated image
            os.makedirs(UPLOAD_DIR, exist_ok=True)
            filename = f"ai_{uuid.uuid4()}.png"
            filepath = os.path.join(UPLOAD_DIR, filename)
            
            # Save image bytes
            with open(filepath, "wb") as f:
                f.write(response.content)
            
            return {"url": f"/uploads/blog/{filename}"}
        elif response.status_code == 503:
            # Model is loading
            error_data = response.json() if response.headers.get('content-type', '').startswith('application/json') else {}
            estimated_time = error_data.get('estimated_time', 30)
            raise HTTPException(
                status_code=503, 
                detail=f"Modelo carregando. Aguarde ~{int(estimated_time)}s e tente novamente."
            )
        else:
            error_detail = response.text
            print(f"Hugging Face Error: {response.status_code} - {error_detail}")
            raise HTTPException(status_code=500, detail=f"Erro ao gerar imagem: {error_detail}")
            
    except HTTPException:
        raise
    except Exception as e:
        print(f"Erro ao gerar imagem: {e}")
        raise HTTPException(status_code=500, detail=f"Erro ao gerar imagem: {str(e)}")

