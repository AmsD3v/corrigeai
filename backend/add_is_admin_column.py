import sqlite3
import os

def add_is_admin_column():
    """Add is_admin column to the user table"""
    
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
        
        # Check if the column already exists
        cursor.execute("PRAGMA table_info(user)")
        columns = [column[1] for column in cursor.fetchall()]
        
        if 'is_admin' in columns:
            print("Column 'is_admin' already exists in the user table.")
        else:
            # Add the is_admin column
            print("Adding 'is_admin' column to user table...")
            cursor.execute("""
                ALTER TABLE user 
                ADD COLUMN is_admin BOOLEAN DEFAULT 0
            """)
            
            conn.commit()
            print("Successfully added 'is_admin' column to user table.")
        
        # Verify the column was added
        cursor.execute("PRAGMA table_info(user)")
        columns = cursor.fetchall()
        print("\nCurrent user table structure:")
        for col in columns:
            print(f"  - {col[1]} ({col[2]})")
        
        conn.close()
        
    except sqlite3.Error as e:
        print(f"SQLite error: {e}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    add_is_admin_column()
