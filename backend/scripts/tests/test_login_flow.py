"""
Verify Login and User Role
"""
import requests
import sys

BASE_URL = "http://127.0.0.1:8000"
EMAIL = "teste@teste.com"
PASSWORD = "Teste@123"

def test_login():
    print(f"🔄 Testing login for {EMAIL}...")
    try:
        response = requests.post(f"{BASE_URL}/login", json={
            "username": EMAIL,
            "password": PASSWORD
        })
        
        if response.status_code == 200:
            token = response.json().get("access_token")
            print("✅ Login SUCCESS!")
            print(f"🔑 Token received: {token[:20]}...")
            return token
        else:
            print(f"❌ Login FAILED: {response.status_code} - {response.text}")
            return None
    except Exception as e:
        print(f"❌ Login EXCEPTION: {e}")
        return None

def test_me(token):
    print(f"\n🔄 Testing /users/me endpoint...")
    try:
        headers = {"Authorization": f"Bearer {token}"}
        response = requests.get(f"{BASE_URL}/users/me", headers=headers)
        
        if response.status_code == 200:
            user = response.json()
            print("✅ /users/me SUCCESS!")
            print(f"👤 User: {user['email']}")
            print(f"🎭 Role: {user['role']}")
            
            if user['role'] == 'admin':
                print("✅ User is correctly identified as ADMIN.")
            else:
                print(f"⚠️ User is NOT admin. Role is: {user['role']}")
        else:
            print(f"❌ /users/me FAILED: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"❌ /users/me EXCEPTION: {e}")

if __name__ == "__main__":
    token = test_login()
    if token:
        test_me(token)
