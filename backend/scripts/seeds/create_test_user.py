"""
Create test user for login
"""
from src.database import init_db_engine, get_db
from src.models import User
from src.security import get_password_hash

def create_test_user():
    """Create test user"""
    engine = init_db_engine()
    db = next(get_db())
    
    # Check if user exists
    existing_user = db.query(User).filter(User.email == "teste@teste.com").first()
    
    if existing_user:
        print(f"✅ User already exists: {existing_user.email}")
        print(f"   ID: {existing_user.id}")
        print(f"   Name: {existing_user.full_name}")
        print(f"   Credits: {existing_user.credits}")
        return
    
    # Create new user
    hashed_password = get_password_hash("Teste@123")
    
    new_user = User(
        email="teste@teste.com",
        full_name="Usuário Teste",
        hashed_password=hashed_password,
        is_active=True,
        role="aluno",
        credits=1
    )
    
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    print(f"✅ Test user created successfully!")
    print(f"   Email: {new_user.email}")
    print(f"   Password: Teste@123")
    print(f"   ID: {new_user.id}")
    print(f"   Credits: {new_user.credits}")

if __name__ == "__main__":
    create_test_user()
