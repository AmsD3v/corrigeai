import sqlite3
import os

def grant_admin_access(email: str):
    """Grant admin access to a user by email"""
    
    # Get the database path
    backend_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(backend_dir, 'sql_app.db')
    
    print(f"Database path: {db_path}")
    
    if not os.path.exists(db_path):
        print(f"Error: Database file not found at {db_path}")
        return
    
    try:
        # Connect to the database
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Check if user exists
        cursor.execute("SELECT id, email, is_admin FROM user WHERE email = ?", (email,))
        user = cursor.fetchone()
        
        if not user:
            print(f"User with email '{email}' not found.")
            print("\nAvailable users:")
            cursor.execute("SELECT id, email, is_admin FROM user")
            users = cursor.fetchall()
            for u in users:
                admin_status = "ADMIN" if u[2] else "USER"
                print(f"  - {u[1]} ({admin_status})")
        else:
            user_id, user_email, is_admin = user
            if is_admin:
                print(f"User '{user_email}' is already an admin.")
            else:
                # Grant admin access
                cursor.execute("UPDATE user SET is_admin = 1 WHERE id = ?", (user_id,))
                conn.commit()
                print(f"Successfully granted admin access to '{user_email}'")
        
        conn.close()
        
    except sqlite3.Error as e:
        print(f"SQLite error: {e}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        email = sys.argv[1]
    else:
        email = "admin@example.com"  # Default email
    
    grant_admin_access(email)
