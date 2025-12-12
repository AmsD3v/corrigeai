"""
Create and populate Package table using raw SQL
"""
from src.database import init_db_engine
from sqlalchemy import text
import json

def create_package_table():
    """Create Package table and populate with default data"""
    engine = init_db_engine()
    
    # Create table if not exists
    with engine.connect() as conn:
        conn.execute(text("""
        CREATE TABLE IF NOT EXISTS package (
            id VARCHAR PRIMARY KEY,
            name VARCHAR NOT NULL,
            credits INTEGER NOT NULL,
            price INTEGER NOT NULL,
            bonus INTEGER DEFAULT 0,
            discount_text VARCHAR,
            features TEXT,
            is_active BOOLEAN DEFAULT 1,
            is_popular BOOLEAN DEFAULT 0,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
        )
        """))
        conn.commit()
        print("✅ Package table created (if not existed)")
        
        # Default packages
        default_packages = [
            {
                "id": "basic",
                "name": "Pacote de 5 Créditos",
                "credits": 5,
                "price": 1122, # R$ 11,22
                "bonus": 0,
                "discount_text": "15% OFF!",
                "features": json.dumps(["Feedback inteligente e detalhado", "Correção Imediata", "Créditos vitalícios"]),
                "is_popular": 0
            },
            {
                "id": "standard",
                "name": "Pacote de 10 Créditos",
                "credits": 10,
                "price": 2178, # R$ 21,78
                "bonus": 1,
                "discount_text": "15% OFF!",
                "features": json.dumps(["Feedback inteligente e detalhado", "Correção Imediata", "Créditos vitalícios", "1 Crédito Bônus"]),
                "is_popular": 1
            },
            {
                "id": "premium",
                "name": "Pacote de 15 Créditos",
                "credits": 15,
                "price": 2640, # R$ 26,40
                "bonus": 2,
                "discount_text": "20% OFF!",
                "features": json.dumps(["Feedback inteligente e detalhado", "Correção Imediata", "Créditos vitalícios", "2 Créditos Bônus"]),
                "is_popular": 0
            }
        ]
        
        for pkg in default_packages:
            # Check if exists
            result = conn.execute(text("SELECT 1 FROM package WHERE id = :id"), {"id": pkg["id"]})
            if not result.fetchone():
                conn.execute(text("""
                INSERT INTO package (id, name, credits, price, bonus, discount_text, features, is_active, is_popular)
                VALUES (:id, :name, :credits, :price, :bonus, :discount_text, :features, 1, :is_popular)
                """), pkg)
                print(f"➕ Added package: {pkg['name']}")
            else:
                print(f"ℹ️ Package exists: {pkg['name']}")
        
        conn.commit()
        print("✅ Packages populated successfully!")

if __name__ == "__main__":
    create_package_table()
