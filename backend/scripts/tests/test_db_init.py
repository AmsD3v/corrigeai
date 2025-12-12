import sys
sys.path.append('src')

print("Testando importação...")
from src import database

print(f"SessionLocal antes: {database.SessionLocal}")

print("Chamando init_db_engine()...")
database.init_db_engine()

print(f"SessionLocal depois: {database.SessionLocal}")

if database.SessionLocal:
    print("✅ SessionLocal foi inicializado!")
    db = database.SessionLocal()
    print(f"✅ Sessão criada: {db}")
    db.close()
else:
    print("❌ SessionLocal ainda é None!")
