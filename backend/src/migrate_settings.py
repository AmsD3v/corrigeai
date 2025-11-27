import sqlite3
import os

# Path to SQLite DB
db_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../backend/sql_app.db'))

def migrate_db():
    print(f"Migrating database at {db_path}...")
    
    if not os.path.exists(db_path):
        print("❌ Database file not found!")
        return

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    columns_to_add = [
        ("gemini_api_key", "VARCHAR"),
        ("groq_api_key", "VARCHAR"),
        ("hf_token", "VARCHAR"),
        ("together_api_key", "VARCHAR")
    ]
    
    for col_name, col_type in columns_to_add:
        try:
            print(f"Adding column {col_name}...")
            cursor.execute(f"ALTER TABLE settings ADD COLUMN {col_name} {col_type}")
            print(f"✅ Added {col_name}")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"⚠️ Column {col_name} already exists.")
            else:
                print(f"❌ Error adding {col_name}: {e}")
                
    conn.commit()
    conn.close()
    print("Migration complete.")

if __name__ == "__main__":
    migrate_db()
