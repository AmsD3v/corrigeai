"""Add correction_type column to submission table"""
import os
import sys

# Add parent directory to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.database import init_db_engine
from sqlalchemy import text

def migrate():
    """Add correction_type column to submission table"""
    print("🔧 Adding correction_type column to submission table...")
    
    # Initialize engine
    engine = init_db_engine()
    
    # Add column using raw SQL (safer than altering model)
    with engine.connect() as connection:
        try:
            # Check if column already exists
            result = connection.execute(text("PRAGMA table_info(submission)"))
            columns = [row[1] for row in result]
            
            if 'correction_type' in columns:
                print("✅ Column 'correction_type' already exists!")
                return
            
            # Add column
            connection.execute(text(
                "ALTER TABLE submission ADD COLUMN correction_type VARCHAR DEFAULT 'advanced'"
            ))
            connection.commit()
            print("✅ Column 'correction_type' added successfully!")
            print("   Default value: 'advanced'")
            print("   Allowed values: 'advanced' or 'premium'")
            
        except Exception as e:
            print(f"❌ Error: {e}")
            raise
    
    print("✅ Migration completed!")

if __name__ == "__main__":
    migrate()
