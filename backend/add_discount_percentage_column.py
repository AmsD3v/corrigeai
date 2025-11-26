"""
Add discount_percentage column to package table
"""
import sys
import os
sys.path.insert(0, 'src')

from sqlalchemy import create_engine, text

def add_discount_percentage_column():
    """Add discount_percentage column to package table"""
    
    # Use the correct database file
    engine = create_engine('sqlite:///./sql_app.db', echo=False)
    
    try:
        with engine.connect() as conn:
            # Check if column already exists
            result = conn.execute(text("PRAGMA table_info(package)"))
            columns = [row[1] for row in result]
            
            if 'discount_percentage' in columns:
                print("✅ Column 'discount_percentage' already exists!")
                return
            
            # Add the column
            print("🔄 Adding 'discount_percentage' column to package table...")
            conn.execute(text("""
                ALTER TABLE package 
                ADD COLUMN discount_percentage INTEGER DEFAULT 0
            """))
            conn.commit()
            print("✅ Column added successfully!")
            
            # Now update existing packages with discount percentage from discount_text
            print("\n🔄 Updating existing packages...")
            result = conn.execute(text("SELECT id, discount_text FROM package"))
            packages = result.fetchall()
            
            for pkg_id, discount_text in packages:
                if discount_text and '%' in discount_text:
                    try:
                        # Extract percentage from "15% OFF!" or similar
                        percentage_str = discount_text.split('%')[0].strip()
                        percentage = int(''.join(filter(str.isdigit, percentage_str)))
                        
                        conn.execute(
                            text("UPDATE package SET discount_percentage = :pct WHERE id = :id"),
                            {"pct": percentage, "id": pkg_id}
                        )
                        print(f"  ✅ {pkg_id}: {percentage}%")
                    except Exception as e:
                        print(f"  ⚠️  {pkg_id}: Could not parse discount ({e}), set to 0%")
                else:
                    print(f"  ℹ️  {pkg_id}: No discount text, set to 0%")
            
            conn.commit()
            print("\n✅ Migration completed successfully!")
            print("\n🔄 Now restart the backend server: python run.py")
                
    except Exception as e:
        print(f"❌ Error during migration: {e}")
        import traceback
        traceback.print_exc()
        raise

if __name__ == "__main__":
    print("=" * 60)
    print("PACKAGE TABLE MIGRATION - Adding discount_percentage")
    print("=" * 60)
    add_discount_percentage_column()
