"""
Promote test user to admin using raw SQL
"""
from src.database import init_db_engine
from sqlalchemy import text

def make_user_admin():
    engine = init_db_engine()
    
    email = "teste@teste.com"
    
    with engine.connect() as conn:
        # Check if user exists
        result = conn.execute(text("SELECT id, role FROM user WHERE email = :email"), {"email": email})
        user = result.fetchone()
        
        if user:
            print(f"👤 User found: ID={user.id}, Current Role={user.role}")
            
            # Update role
            conn.execute(text("UPDATE user SET role = 'admin' WHERE email = :email"), {"email": email})
            conn.commit()
            
            print(f"✅ User {email} is now an ADMIN.")
        else:
            print(f"❌ User {email} not found.")

if __name__ == "__main__":
    make_user_admin()
