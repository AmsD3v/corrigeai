import os
import sys
from sqlalchemy import create_engine, text, inspect
from dotenv import load_dotenv

# Add src to path
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    print("DATABASE_URL not found")
    sys.exit(1)

# Fix for SQLite relative path
if DATABASE_URL.startswith("sqlite:///./"):
    # Assume db is in backend folder if running from root
    db_path = os.path.join(os.path.dirname(__file__), "sql_app.db")
    DATABASE_URL = f"sqlite:///{db_path}"
    print(f"Using database at: {db_path}")

engine = create_engine(DATABASE_URL)

def fix_schema():
    inspector = inspect(engine)
    columns = [c['name'] for c in inspector.get_columns('correction')]
    
    print(f"Current columns in correction table: {columns}")
    
    if 'corrected_at' not in columns:
        print("Adding corrected_at column...")
        with engine.connect() as conn:
            conn.execute(text("ALTER TABLE correction ADD COLUMN corrected_at TIMESTAMP DEFAULT NOW()"))
            conn.commit()
        print("Column added successfully.")
    else:
        print("corrected_at column already exists.")

    # Check for exam_type in submission table too, just in case
    sub_columns = [c['name'] for c in inspector.get_columns('submission')]
    print(f"Current columns in submission table: {sub_columns}")
    
    if 'exam_type' not in sub_columns:
        print("Adding exam_type column to submission...")
        with engine.connect() as conn:
            conn.execute(text("ALTER TABLE submission ADD COLUMN exam_type VARCHAR"))
            conn.commit()
        print("Column added successfully.")

    if 'error_message' not in sub_columns:
        print("Adding error_message column to submission...")
        with engine.connect() as conn:
            conn.execute(text("ALTER TABLE submission ADD COLUMN error_message TEXT"))
            conn.commit()
        print("Column added successfully.")

if __name__ == "__main__":
    fix_schema()
