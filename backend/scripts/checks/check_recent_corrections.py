import sqlite3

conn = sqlite3.connect('sql_app.db')
cursor = conn.cursor()

print("=== ULTIMAS 5 CORREÇÕES ===")
cursor.execute("SELECT id, total_score, strengths, improvements FROM correction ORDER BY id DESC LIMIT 5")
results = cursor.fetchall()

for r in results:
    print(f"\nID: {r[0]}")
    print(f"Nota Total: {r[1]}")
    print(f"Strengths: {r[2][:100] if r[2] else 'None'}...")
    print(f"Improvements: {r[3][:100] if r[3] else 'None'}...")

conn.close()
