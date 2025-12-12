import sqlite3

# Connect to database
conn = sqlite3.connect('sql_app.db')
cursor = conn.cursor()

# Get user email
email = 'dono.comuna.p.fdp@hotmail.com'

# Update credits
cursor.execute('UPDATE user SET credits = 2 WHERE email = ?', (email,))
conn.commit()

# Verify
cursor.execute('SELECT email, credits FROM user WHERE email = ?', (email,))
result = cursor.fetchone()

print("="*60)
print("CRÉDITOS ATUALIZADOS")
print("="*60)
if result:
    print(f"Email: {result[0]}")
    print(f"Créditos: {result[1]}")
else:
    print("Usuário não encontrado!")
print("="*60)

conn.close()
