import requests
import json

url = "http://127.0.0.1:8000/login"
headers = {"Content-Type": "application/json"}
data = {
    "username": "test4@example.com",
    "password": "TestPass123!"
}

try:
    print(f"Sending POST to {url} with data: {data}")
    response = requests.post(url, headers=headers, json=data)
    print(f"Status Code: {response.status_code}")
    print(f"Response Body: {response.text}")
except Exception as e:
    print(f"Error: {e}")
