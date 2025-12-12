#!/usr/bin/env python3
"""
Script para popular o banco de dados com pacotes padrão de CorriCoins
Execute: python seed_packages.py
"""

import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

from src.database import SessionLocal
from src.models import Package
from datetime import datetime

def seed_packages():
    """Adiciona pacotes padrão ao banco de dados"""
    db = SessionLocal()
    
    try:
        # Verificar se já existem pacotes
        existing = db.query(Package).count()
        if existing > 0:
            print(f"✓ Já existem {existing} pacotes no banco de dados.")
            print("  Para recriar, delete-os primeiro no painel admin.")
            return
        
        # Pacotes padrão
        packages_data = [
            {
                "id": "pack_basic",
                "name": "Básico",
                "credits": 10,
                "price": 3990,  # R$ 39,90
                "discount_percentage": 0,
                "bonus": 0,
                "discount_text": None,
                "is_active": True,
                "is_popular": False
            },
            {
                "id": "pack_popular",
                "name": "Popular",
                "credits": 25,
                "price": 8990,  # R$ 89,90
                "discount_percentage": 10,
                "bonus": 5,
                "discount_text": "10% OFF",
                "is_active": True,
                "is_popular": True
            },
            {
                "id": "pack_premium",
                "name": "Premium",
                "credits": 50,
                "price": 14990,  # R$ 149,90
                "discount_percentage": 25,
                "bonus": 15,
                "discount_text": "25% OFF",
                "is_active": True,
                "is_popular": False
            }
        ]
        
        # Criar pacotes
        for pkg_data in packages_data:
            pkg = Package(
                id=pkg_data["id"],
                name=pkg_data["name"],
                credits=pkg_data["credits"],
                price=pkg_data["price"],
                discount_percentage=pkg_data["discount_percentage"],
                bonus=pkg_data["bonus"],
                discount_text=pkg_data["discount_text"],
                is_active=pkg_data["is_active"],
                is_popular=pkg_data["is_popular"],
                created_at=datetime.utcnow()
            )
            db.add(pkg)
            print(f"✓ Criado pacote: {pkg.name} - {pkg.credits + pkg.bonus} créditos - R$ {pkg.price/100:.2f}")
        
        db.commit()
        print("\n✅ Pacotes criados com sucesso!")
        print("   Acesse https://corrigeai.online para ver os pacotes na landing page.")
        
    except Exception as e:
        db.rollback()
        print(f"❌ Erro ao criar pacotes: {e}")
        raise
    finally:
        db.close()

if __name__ == "__main__":
    print("🔧 Populando banco de dados com pacotes padrão...")
    print()
    seed_packages()
