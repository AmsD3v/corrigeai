import sqlite3
import os

# Get database path
backend_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(backend_dir, 'sql_app.db')

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Check submissions
cursor.execute('''
    SELECT id, title, status, created_at 
    FROM submission 
    ORDER BY id DESC 
    LIMIT 10
''')

print("="*80)
print("ÚLTIMAS SUBMISSÕES NO BANCO DE DADOS")
print("="*80)
print(f"{'ID':<5} {'Título':<40} {'Status':<12} {'Data':<20}")
print("-"*80)

rows = cursor.fetchall()
if rows:
    for row in rows:
        print(f"{row[0]:<5} {row[1][:40]:<40} {row[2]:<12} {row[3]:<20}")
else:
    print("Nenhuma submissão encontrada no banco de dados")

print("="*80)

# Check status distribution
cursor.execute('SELECT status, COUNT(*) FROM submission GROUP BY status')
status_counts = cursor.fetchall()
print(f"\nDistribuição de status:")
for status, count in status_counts:
    print(f"  {status}: {count}")

conn.close()
