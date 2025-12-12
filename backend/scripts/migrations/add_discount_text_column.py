import sqlite3
import os

def add_discount_text_column():
    """Add discount_text column to the package table"""
    
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
        cursor.execute("PRAGMA table_info(package)")
        columns = [column[1] for column in cursor.fetchall()]
        
        if 'discount_text' in columns:
            print("Column 'discount_text' already exists in the package table.")
        else:
            # Add the discount_text column
            print("Adding 'discount_text' column to package table...")
            cursor.execute("""
                ALTER TABLE package 
                ADD COLUMN discount_text TEXT
            """)
            
            conn.commit()
            print("Successfully added 'discount_text' column to package table.")
        
        # Verify the column was added
        cursor.execute("PRAGMA table_info(package)")
        columns = cursor.fetchall()
        print("\nCurrent package table structure:")
        for col in columns:
            print(f"  - {col[1]} ({col[2]})")
        
        conn.close()
        
    except sqlite3.Error as e:
        print(f"SQLite error: {e}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    add_discount_text_column()
