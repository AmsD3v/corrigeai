import time
# Testes de Autenticação

def test_user_registration(client, test_user_data):
    """Testa se um novo usuário pode ser registrado com sucesso."""
    response = client.post("/register", json=test_user_data.model_dump())
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == test_user_data.email
    assert "id" in data

def test_login_success(client, registered_user, test_user_data):
    """Testa o login bem-sucedido e a resposta dos tokens."""
    login_data = {"username": test_user_data.email, "password": test_user_data.password}
    response = client.post("/login", json=login_data)
    
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "token_type" in data
    assert data["token_type"] == "bearer"
    
    # Verifica o cookie de refresh token, crucial para a nova lógica
    assert "refresh_token" in response.cookies
    # O objeto Cookies do httpx não expõe os atributos do cookie (httponly) diretamente dessa forma simples
    # A verificação da presença do cookie já é um bom indicativo para este teste de integração
    assert response.cookies["refresh_token"] is not None

def test_login_failure_wrong_password(client, registered_user, test_user_data):
    """Testa a falha de login com senha incorreta."""
    login_data = {"username": test_user_data.email, "password": "wrongpassword"}
    response = client.post("/login", json=login_data)
    assert response.status_code == 401
    assert response.json()["detail"] == "Credenciais inválidas"

def test_refresh_token_flow(client, registered_user, test_user_data):
    """Testa o fluxo completo de rotação de tokens."""
    # 1. Fazer login para obter o refresh token inicial
    login_data = {"username": test_user_data.email, "password": test_user_data.password}
    response_login = client.post("/login", json=login_data)
    assert response_login.status_code == 200
    initial_access_token = response_login.json()["access_token"]
    initial_refresh_token = response_login.cookies.get("refresh_token")
    assert initial_refresh_token is not None

    # Aguarda 2 segundos para garantir que o 'exp' do novo token seja diferente
    time.sleep(2)

    # 2. Usar o refresh token para obter novos tokens
    # Passando explicitamente no request para garantir
    cookies = {"refresh_token": initial_refresh_token}
    response_refresh = client.post("/refresh", cookies=cookies)
    
    if response_refresh.status_code != 200:
        print(f"Refresh failed: {response_refresh.status_code} - {response_refresh.text}")

    # 3. Verificar a resposta do refresh
    assert response_refresh.status_code == 200
    new_access_token = response_refresh.json()["access_token"]
    new_refresh_token = response_refresh.cookies.get("refresh_token")

    # 4. Verificar se os tokens foram efetivamente rotacionados
    assert new_access_token is not None
    assert new_refresh_token is not None
    assert new_access_token != initial_access_token
    assert new_refresh_token != initial_refresh_token

def test_logout(client, user_token):
    """Testa o logout da sessão atual."""
import time
# Testes de Autenticação

def test_user_registration(client, test_user_data):
    """Testa se um novo usuário pode ser registrado com sucesso."""
    response = client.post("/register", json=test_user_data.model_dump())
    assert response.status_code == 201
    data = response.json()
    assert data["email"] == test_user_data.email
    assert "id" in data

def test_login_success(client, registered_user, test_user_data):
    """Testa o login bem-sucedido e a resposta dos tokens."""
    login_data = {"username": test_user_data.email, "password": test_user_data.password}
    response = client.post("/login", json=login_data)
    
    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert "token_type" in data
    assert data["token_type"] == "bearer"
    
    # Verifica o cookie de refresh token, crucial para a nova lógica
    assert "refresh_token" in response.cookies
    # O objeto Cookies do httpx não expõe os atributos do cookie (httponly) diretamente dessa forma simples
    # A verificação da presença do cookie já é um bom indicativo para este teste de integração
    assert response.cookies["refresh_token"] is not None

def test_login_failure_wrong_password(client, registered_user, test_user_data):
    """Testa a falha de login com senha incorreta."""
    login_data = {"username": test_user_data.email, "password": "wrongpassword"}
    response = client.post("/login", json=login_data)
    assert response.status_code == 401
    assert response.json()["detail"] == "Credenciais inválidas"

def test_refresh_token_flow(client, registered_user, test_user_data):
    """Testa o fluxo completo de rotação de tokens."""
    # 1. Fazer login para obter o refresh token inicial
    login_data = {"username": test_user_data.email, "password": test_user_data.password}
    response_login = client.post("/login", json=login_data)
    assert response_login.status_code == 200
    initial_access_token = response_login.json()["access_token"]
    initial_refresh_token = response_login.cookies.get("refresh_token")
    assert initial_refresh_token is not None

    # Aguarda 2 segundos para garantir que o 'exp' do novo token seja diferente
    time.sleep(2)

    # 2. Usar o refresh token para obter novos tokens
    # Passando explicitamente no request para garantir
    cookies = {"refresh_token": initial_refresh_token}
    response_refresh = client.post("/refresh", cookies=cookies)
    
    if response_refresh.status_code != 200:
        print(f"Refresh failed: {response_refresh.status_code} - {response_refresh.text}")

    # 3. Verificar a resposta do refresh
    assert response_refresh.status_code == 200
    new_access_token = response_refresh.json()["access_token"]
    new_refresh_token = response_refresh.cookies.get("refresh_token")

    # 4. Verificar se os tokens foram efetivamente rotacionados
    assert new_access_token is not None
    assert new_refresh_token is not None
    assert new_access_token != initial_access_token
    assert new_refresh_token != initial_refresh_token

def test_logout(client, user_token):
    """Testa o logout da sessão atual."""
    headers = {"Authorization": f"Bearer {user_token}"}
    response_logout = client.post("/logout", headers=headers)
    
    if response_logout.status_code != 200:
        print(f"Logout failed: {response_logout.status_code} - {response_logout.text}")

    assert response_logout.status_code == 200
    assert response_logout.json()["message"] == "Logout realizado com sucesso"
    # Verifica se o cookie foi deletado (max-age=0 ou valor vazio)
    set_cookie = response_logout.headers.get('set-cookie', '').lower()
    assert 'refresh_token=""' in set_cookie or 'max-age=0' in set_cookie

def test_logout_all(client, user_token):
    """Testa o logout de todas as sessões."""
    headers = {"Authorization": f"Bearer {user_token}"}
    response_logout_all = client.post("/logout-all", headers=headers)
    
    assert response_logout_all.status_code == 200
    assert response_logout_all.json()["message"] == "Logout de todos os dispositivos realizado com sucesso"
    set_cookie = response_logout_all.headers.get('set-cookie', '').lower()
    assert 'refresh_token=""' in set_cookie or 'max-age=0' in set_cookie