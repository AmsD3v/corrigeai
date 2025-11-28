"""
Migration script to add phone and birth_date fields to User table

Run this script ONCE in production to add the new profile fields.
"""

import psycopg2
import os
from dotenv import load_dotenv

def run_migration():
    load_dotenv()
    db_url = os.getenv('DATABASE_URL')
    
    # Parse DATABASE_URL
    parts = db_url.replace('postgresql://', '').split('@')
    user_pass = parts[0].split(':')
    host_db = parts[1].split('/')
    
    conn = psycopg2.connect(
        host=host_db[0],
        database=host_db[1],
        user=user_pass[0],
        password=user_pass[1]
    )
    
    cur = conn.cursor()
    
    try:
        print("🔄 Starting migration...")
        
        # Check if columns already exist
        cur.execute("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name='user' AND column_name IN ('phone', 'birth_date');
        """)
        existing_columns = [row[0] for row in cur.fetchall()]
        
        if 'phone' in existing_columns and 'birth_date' in existing_columns:
            print("✅ Columns already exist. Migration not needed.")
            return
        
        # Add phone column if not exists
        if 'phone' not in existing_columns:
            print("➕ Adding phone column...")
            cur.execute('ALTER TABLE "user" ADD COLUMN phone VARCHAR;')
            print("✅ Phone column added")
        
        # Add birth_date column if not exists
        if 'birth_date' not in existing_columns:
            print("➕ Adding birth_date column...")
            cur.execute('ALTER TABLE "user" ADD COLUMN birth_date VARCHAR;')
            print("✅ Birth_date column added")
        
        conn.commit()
        print("✅ Migration completed successfully!")
        
    except Exception as e:
        conn.rollback()
        print(f"❌ Migration failed: {str(e)}")
        raise
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    run_migration()
