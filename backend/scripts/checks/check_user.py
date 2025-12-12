import os
import sys
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv

# Add src to path
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

# Load env
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    print("DATABASE_URL not found")
    sys.exit(1)

print(f"Connecting to: {DATABASE_URL}")
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)

def check_users():
    db = SessionLocal()
    try:
        result = db.execute(text("SELECT id, email, full_name, is_active FROM \"user\""))
        users = result.fetchall()
        
        print("\n=== USERS IN DATABASE ===")
        if not users:
            print("No users found!")
        else:
            for u in users:
                print(f"ID: {u.id} | Email: {u.email} | Name: {u.full_name} | Active: {u.is_active}")
        print("=========================\n")
        
    except Exception as e:
        print(f"Error querying users: {e}")
    finally:
        db.close()

if __name__ == "__main__":
    check_users()
