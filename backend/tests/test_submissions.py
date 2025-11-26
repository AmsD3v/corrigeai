import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from src.schemas import SubmissionCreate


def test_submit_essay_success(client: TestClient, user_token: str):
    """Testa o envio bem-sucedido de uma redação."""
    headers = {"Authorization": f"Bearer {user_token}"}
    submission_data = {
        "title": "Minha Redação",
        "content": "Este é o conteúdo da minha redação para teste. " * 20  # > 500 chars
    }
    
    response = client.post("/submit", json=submission_data, headers=headers)
    
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == submission_data["title"]
    assert data["content"] == submission_data["content"]
    assert data["status"] == "pending"
    assert "id" in data


def test_submit_essay_missing_title(client: TestClient, user_token: str):
    """Testa o envio de redação com título ausente."""
    headers = {"Authorization": f"Bearer {user_token}"}
    submission_data = {
        "title": "",
        "content": "Este é o conteúdo da minha redação."
    }
    
    response = client.post("/submit", json=submission_data, headers=headers)
    
    assert response.status_code == 422  # Unprocessable Entity devido à validação do Pydantic


def test_submit_essay_missing_content(client: TestClient, user_token: str):
    """Testa o envio de redação com conteúdo ausente."""
    headers = {"Authorization": f"Bearer {user_token}"}
    submission_data = {
        "title": "Minha Redação",
        "content": ""
    }
    
    response = client.post("/submit", json=submission_data, headers=headers)
    
    assert response.status_code == 422  # Unprocessable Entity devido à validação do Pydantic


def test_submit_essay_title_too_long(client: TestClient, user_token: str):
    """Testa o envio de redação com título muito longo."""
    headers = {"Authorization": f"Bearer {user_token}"}
    submission_data = {
        "title": "A" * 201,  # Mais de 200 caracteres
        "content": "Este é o conteúdo da minha redação."
    }
    
    response = client.post("/submit", json=submission_data, headers=headers)
    
    assert response.status_code == 422  # Unprocessable Entity devido à validação do Pydantic


def test_submit_essay_content_too_long(client: TestClient, user_token: str):
    """Testa o envio de redação com conteúdo muito longo."""
    headers = {"Authorization": f"Bearer {user_token}"}
    submission_data = {
        "title": "Minha Redação",
        "content": "A" * 10001  # Mais de 10.000 caracteres
    }
    
    response = client.post("/submit", json=submission_data, headers=headers)
    
    assert response.status_code == 422  # Unprocessable Entity devido à validação do Pydantic


def test_submit_essay_unauthorized(client: TestClient):
    """Testa o envio de redação sem autenticação."""
    submission_data = {
        "title": "Minha Redação",
        "content": "Este é o conteúdo da minha redação."
    }
    
    response = client.post("/submit", json=submission_data)
    
    assert response.status_code == 401  # Não autenticado


def test_get_submission_success(client: TestClient, user_token: str):
    """Testa a recuperação bem-sucedida de uma submissão."""
    headers = {"Authorization": f"Bearer {user_token}"}
    
    # Primeiro, cria uma submissão
    submission_data = {
        "title": "Minha Redação",
        "content": "Este é o conteúdo da minha redação para teste. " * 20
    }
    
    create_response = client.post("/submit", json=submission_data, headers=headers)
    assert create_response.status_code == 200
    created_data = create_response.json()
    submission_id = created_data["id"]
    
    # Agora recupera a submissão
    response = client.get(f"/submissions/{submission_id}", headers=headers)
    
    assert response.status_code == 200
    data = response.json()
    assert data["id"] == submission_id
    assert data["title"] == submission_data["title"]


def test_get_submission_unauthorized(client: TestClient, user_token: str, db_session: Session):
    """Testa a recuperação de uma submissão de outro usuário (não autorizado)."""
    from src.models import User, Submission
    from src.security import get_password_hash
    
    # Cria um usuário diferente
    other_user = User(
        email="other@example.com",
        hashed_password=get_password_hash("Password123!"),
        full_name="Other User"
    )
    db_session.add(other_user)
    db_session.commit()
    
    # Cria uma submissão para este outro usuário
    other_submission = Submission(
        title="Redação de Outro Usuário",
        content="Conteúdo da redação de outro usuário.",
        owner_id=other_user.id
    )
    db_session.add(other_submission)
    db_session.commit()
    
    headers = {"Authorization": f"Bearer {user_token}"}
    
    # Tenta acessar a submissão de outro usuário
    response = client.get(f"/submissions/{other_submission.id}", headers=headers)
    
    assert response.status_code == 404  # Não deve encontrar (acesso não permitido)