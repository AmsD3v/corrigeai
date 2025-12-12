import requests
import json

try:
    response = requests.get('http://localhost:8000/api/packages')
    print(f"Status Code: {response.status_code}")
    
    try:
        data = response.json()
        print("Response Data Type:", type(data))
        print(json.dumps(data, indent=2))
        
        if isinstance(data, list):
            for pkg in data:
                print(f"Package: {pkg.get('name')}")
                print(f"Features type: {type(pkg.get('features'))}")
                print(f"Features value: {pkg.get('features')}")
    except Exception as e:
        print(f"JSON Decode Error: {e}")
        print("Raw Text:", response.text)

except Exception as e:
    print(f"Request Error: {e}")
