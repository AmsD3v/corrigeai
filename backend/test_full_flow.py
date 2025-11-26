import requests
import json
import time

base_url = "http://127.0.0.1:8000"
headers = {"Content-Type": "application/json"}

# 1. Login
print("--- Attempting Login ---")
login_data = {
    "username": "test4@example.com",
    "password": "TestPass123!"
}
try:
    response = requests.post(f"{base_url}/login", headers=headers, json=login_data)
    print(f"Login Status: {response.status_code}")
    if response.status_code == 200:
        token_data = response.json()
        access_token = token_data["access_token"]
        print("Login Successful. Token received.")
        
        # 2. Submit Essay
        print("\n--- Attempting Essay Submission ---")
        auth_headers = {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json"
        }
        essay_data = {
            "title": "Script Test Essay",
            "theme": "Backend Verification",
            "content": "This is a test essay content that must be longer than 500 characters to pass the validation. " * 10,
            "exam_type": "enem"
        }
        
        response_submit = requests.post(f"{base_url}/submit", headers=auth_headers, json=essay_data)
        print(f"Submit Status: {response_submit.status_code}")
        print(f"Submit Response: {response_submit.text}")
        
        if response_submit.status_code == 200:
            print("Submission Successful!")
        else:
            print("Submission Failed.")
            
    else:
        print(f"Login Failed: {response.text}")

except Exception as e:
    print(f"Error: {e}")
