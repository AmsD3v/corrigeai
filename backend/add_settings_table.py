"""Add settings table for AI provider configuration"""
import os
import sys

# Add parent directory to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import SessionLocal, Base, init_db_engine
from src.models import Settings

def migrate():
    """Create settings table and initialize with default values"""
    print("🔧 Creating settings table...")
    
    # Initialize engine
    engine = init_db_engine()
    
    # Create all tables (will skip existing ones)
    Base.metadata.create_all(bind=engine)
    
    # Initialize settings if not exists
    from sqlalchemy.orm import sessionmaker
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()
    try:
        existing = db.query(Settings).first()
        if not existing:
            print("📝 Initializing default settings...")
            settings = Settings(
                id=1,
                active_ai_provider="groq"
            )
            db.add(settings)
            db.commit()
            print("✅ Settings initialized with Groq as default provider")
        else:
            print(f"✅ Settings already exist. Active provider: {existing.active_ai_provider}")
    finally:
        db.close()
    
    print("✅ Migration completed!")

if __name__ == "__main__":
    migrate()
