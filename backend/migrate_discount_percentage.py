"""
Migration script to add discount_percentage field to existing packages
"""
import sys
sys.path.insert(0, 'src')

from database import SessionLocal
from models import Package

def migrate_packages():
    db = SessionLocal()
    try:
        packages = db.query(Package).all()
        
        for pkg in packages:
            # Extract percentage from discount_text if it exists
            if pkg.discount_text and '%' in pkg.discount_text:
                try:
                    # Extract number from strings like "15% OFF!" or "20% OFF"
                    percentage_str = pkg.discount_text.split('%')[0].strip()
                    # Remove any non-digit characters
                    percentage = int(''.join(filter(str.isdigit, percentage_str)))
                    pkg.discount_percentage = percentage
                    print(f"✅ Updated {pkg.id}: discount_percentage = {percentage}%")
                except:
                    pkg.discount_percentage = 0
                    print(f"⚠️  Could not parse discount for {pkg.id}, set to 0%")
            else:
                pkg.discount_percentage = 0
                print(f"ℹ️  {pkg.id}: No discount text, set to 0%")
        
        db.commit()
        print("\n✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"❌ Error during migration: {e}")
        db.rollback()
    finally:
        db.close()

if __name__ == "__main__":
    print("🔄 Starting package migration...")
    migrate_packages()
