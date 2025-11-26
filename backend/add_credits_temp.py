import sqlite3

# Connect to database
conn = sqlite3.connect('sql_app.db')
cursor = conn.cursor()

# Update credits for user
email = 'videos.angel@gmail.com'
cursor.execute('UPDATE user SET credits = 10 WHERE email = ?', (email,))
conn.commit()

# Verify
cursor.execute('SELECT email, credits FROM user WHERE email = ?', (email,))
result = cursor.fetchone()

if result:
    print(f"✅ Créditos atualizados!")
    print(f"Email: {result[0]}")
    print(f"Créditos: {result[1]}")
else:
    print("❌ Usuário não encontrado")

conn.close()
