"""
"""
Create Correction table

This migration adds the Correction table to store detailed essay correction results
based on ENEM criteria (5 competencies, 200 points each).
"""

from src.database import engine, Base
from src import models

def run_migration():
    """Create all tables defined in models"""
    
    print("Creating tables...")
    Base.metadata.create_all(bind=engine)
    print("✅ Migration completed successfully!")
    print("Tables created: user, submission, correction")

if __name__ == "__main__":
    run_migration()
