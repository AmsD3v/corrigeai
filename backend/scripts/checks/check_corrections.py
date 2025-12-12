import sqlite3
import os

# Get database path
backend_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(backend_dir, 'sql_app.db')

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Check corrections
cursor.execute('''
    SELECT id, submission_id, total_score, 
           competence_1_score, competence_2_score, competence_3_score, 
           competence_4_score, competence_5_score 
    FROM correction 
    ORDER BY id DESC 
    LIMIT 10
''')

print("="*80)
print("ÚLTIMAS CORREÇÕES NO BANCO DE DADOS")
print("="*80)
print(f"{'ID':<5} {'Sub_ID':<8} {'Total':<8} {'C1':<6} {'C2':<6} {'C3':<6} {'C4':<6} {'C5':<6}")
print("-"*80)

rows = cursor.fetchall()
if rows:
    for row in rows:
        print(f"{row[0]:<5} {row[1]:<8} {row[2]:<8} {row[3]:<6} {row[4]:<6} {row[5]:<6} {row[6]:<6} {row[7]:<6}")
else:
    print("Nenhuma correção encontrada no banco de dados")

print("="*80)

# Check unique scores
cursor.execute('SELECT DISTINCT total_score FROM correction')
unique_scores = cursor.fetchall()
print(f"\nNotas únicas encontradas: {[score[0] for score in unique_scores]}")

conn.close()
