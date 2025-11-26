import sqlite3

# Connect to database
conn = sqlite3.connect('sql_app.db')
cursor = conn.cursor()

# Add 20 credits to ALL users
cursor.execute('UPDATE user SET credits = credits + 20')
conn.commit()

# Show updated users
cursor.execute('SELECT id, email, credits FROM user')
users = cursor.fetchall()

print("✅ Créditos adicionados a todos os usuários!\n")
print("Usuários atualizados:")
for user in users:
    print(f"  ID: {user[0]}, Email: {user[1]}, Créditos: {user[2]}")

conn.close()
