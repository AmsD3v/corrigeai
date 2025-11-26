import sqlite3
import json

conn = sqlite3.connect('sql_app.db')
cursor = conn.cursor()

# List tables
cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = cursor.fetchall()
print("Tabelas no banco:")
for t in tables:
    print(f"  - {t[0]}")

# Check correction table
print("\nColunas da tabela 'correction':")
cursor.execute("PRAGMA table_info(correction)")
cols = cursor.fetchall()
for col in cols:
    print(f"  {col[1]} ({col[2]})")

# Get a sample correction
print("\nExemplo de correção:")
cursor.execute("SELECT * FROM correction LIMIT 1")
result = cursor.fetchone()
if result:
    print(f"ID: {result[0]}")
    print(f"Total Score: {result[1]}")
    print(f"Strengths: {result[8]}")
    print(f"Improvements: {result[9]}")
else:
    print("Nenhuma correção encontrada")

conn.close()
