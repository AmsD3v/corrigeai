"""
Add feature1-4 columns to package table
"""
import sys
import os
sys.path.insert(0, 'src')

from sqlalchemy import create_engine, text

def add_feature_columns():
    """Add feature1-4 columns to package table"""
    
    # Use the correct database file
    engine = create_engine('sqlite:///./sql_app.db', echo=False)
    
    try:
        with engine.connect() as conn:
            # Check if columns already exist
            result = conn.execute(text("PRAGMA table_info(package)"))
            columns = [row[1] for row in result]
            
            columns_to_add = []
            for i in range(1, 5):
                col_name = f'feature{i}'
                if col_name not in columns:
                    columns_to_add.append(col_name)
            
            if not columns_to_add:
                print("✅ All feature columns already exist!")
                return
            
            # Add the columns
            for col_name in columns_to_add:
                print(f"🔄 Adding '{col_name}' column to package table...")
                conn.execute(text(f"""
                    ALTER TABLE package 
                    ADD COLUMN {col_name} TEXT DEFAULT NULL
                """))
                conn.commit()
                print(f"✅ Column '{col_name}' added successfully!")
            
            print("\n✅ Migration completed successfully!")
            print("\n🔄 Now restart the backend server: python run.py")
                
    except Exception as e:
        print(f"❌ Error during migration: {e}")
        import traceback
        traceback.print_exc()
        raise

if __name__ == "__main__":
    print("=" * 60)
    print("PACKAGE TABLE MIGRATION - Adding feature1-4 columns")
    print("=" * 60)
    add_feature_columns()
