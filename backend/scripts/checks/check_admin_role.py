import sqlite3
import os

# Get the database path
backend_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(backend_dir, 'sql_app.db')

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Check user details
cursor.execute("SELECT email, role, is_admin FROM user WHERE email = 'admin@example.com'")
result = cursor.fetchone()

if result:
    print(f"Email: {result[0]}")
    print(f"Role: {result[1]}")
    print(f"Is Admin: {result[2]}")
    
    # Update role to admin if needed
    if result[1] != 'admin':
        print("\nUpdating role to 'admin'...")
        cursor.execute("UPDATE user SET role = 'admin' WHERE email = 'admin@example.com'")
        conn.commit()
        print("Role updated successfully!")
else:
    print("User not found")

conn.close()
