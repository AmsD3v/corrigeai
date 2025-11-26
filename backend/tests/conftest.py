# --- INÍCIO DA CORREÇÃO DE CAMINHO DEFINITIVA ---
import sys
import os

# Esta deve ser a primeira coisa no arquivo.
# Adiciona o diretório raiz do projeto ('backend') ao caminho do Python.
# Isso garante que importações como 'from src.models import ...' funcionem.
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if project_root not in sys.path:
    sys.path.insert(0, project_root)
# --- FIM DA CORREÇÃO DE CAMINHO DEFINITIVA ---

import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from fastapi.testclient import TestClient

from sqlalchemy.pool import StaticPool

# Agora que o caminho está corrigido, estas importações funcionarão corretamente.
from src.database import Base, get_db
from src.main import app
from src.schemas import UserCreate
from src.models import User

os.environ["DATABASE_URL"] = "sqlite:///:memory:"
os.environ["SECRET_KEY"] = "test_secret_key_for_testing_purposes_only"
os.environ["CORS_ORIGINS"] = "http://localhost:5173,http://localhost:3000"

engine = create_engine(
    os.getenv("DATABASE_URL"), 
    connect_args={"check_same_thread": False},
    poolclass=StaticPool
)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

@pytest.fixture(scope="session", autouse=True)
def setup_test_db():
    Base.metadata.create_all(bind=engine)
    yield
    Base.metadata.drop_all(bind=engine)
    if "DATABASE_URL" in os.environ:
        del os.environ["DATABASE_URL"]

@pytest.fixture(name="db_session")
def db_session_fixture():
    connection = engine.connect()
    transaction = connection.begin()
    session = TestingSessionLocal(bind=connection)
    yield session
    session.close()
    transaction.rollback()
    connection.close()

@pytest.fixture(name="client")
def client_fixture(db_session: Session):
    def override_get_db():
        yield db_session
    app.dependency_overrides[get_db] = override_get_db
    with TestClient(app) as client:
        yield client
    app.dependency_overrides.clear()

@pytest.fixture(name="test_user_data")
def test_user_data_fixture():
    return UserCreate(
        email="test@example.com",
        password="TestPass123!",
        full_name="Test User"
    )

@pytest.fixture(name="registered_user")
def registered_user_fixture(client: TestClient, test_user_data: UserCreate, db_session: Session):
    # Garante que o usuário não existe antes de tentar criar
    user = db_session.query(User).filter(User.email == test_user_data.email).first()
    if user:
        db_session.delete(user)
        db_session.commit()
        
    response = client.post("/register", json=test_user_data.model_dump())
    assert response.status_code == 201
    return response.json()

@pytest.fixture(name="user_token")
def user_token_fixture(client: TestClient, registered_user, test_user_data: UserCreate):
    login_data = {"username": test_user_data.email, "password": test_user_data.password}
    response = client.post("/login", json=login_data)
    assert response.status_code == 200
    return response.json()["access_token"]