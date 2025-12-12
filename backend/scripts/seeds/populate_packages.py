#!/usr/bin/env python3
"""
Script para popular a tabela de pacotes (packages) com opções de créditos.
"""
import os
import sys
from datetime import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv

# Add src to path
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

from src.models import Package

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    print("❌ DATABASE_URL não encontrada no .env")
    sys.exit(1)

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Definir pacotes padrão
PACKAGES = [
    {
        "id": "basic",
        "name": "Pacote Básico",
        "credits": 5,
        "price": 2500,  # R$ 25,00
        "discount_percentage": 0,
        "bonus": 0,
        "discount_text": None,
        "is_active": True,
        "is_popular": False
    },
    {
        "id": "starter",
        "name": "Pacote Iniciante",
        "credits": 10,
        "price": 4500,  # R$ 45,00 (10% off)
        "discount_percentage": 10,
        "bonus": 0,
        "discount_text": "10% OFF!",
        "is_active": True,
        "is_popular": False
    },
    {
        "id": "popular",
        "name": "Pacote Popular",
        "credits": 20,
        "price": 8000,  # R$ 80,00 (20% off)
        "discount_percentage": 20,
        "bonus": 2,
        "discount_text": "20% OFF + Bônus!",
        "is_active": True,
        "is_popular": True
    },
    {
        "id": "advanced",
        "name": "Pacote Avançado",
        "credits": 50,
        "price": 17500,  # R$ 175,00 (30% off)
        "discount_percentage": 30,
        "bonus": 5,
        "discount_text": "30% OFF + Bônus!",
        "is_active": True,
        "is_popular": False
    },
    {
        "id": "premium",
        "name": "Pacote Premium",
        "credits": 100,
        "price": 30000,  # R$ 300,00 (40% off)
        "discount_percentage": 40,
        "bonus": 15,
        "discount_text": "40% OFF + Bônus!",
        "is_active": True,
        "is_popular": False
    },
    {
        "id": "master",
        "name": "Pacote Master",
        "credits": 200,
        "price": 50000,  # R$ 500,00 (50% off)
        "discount_percentage": 50,
        "bonus": 50,
        "discount_text": "50% OFF + Super Bônus!",
        "is_active": True,
        "is_popular": False
    }
]

def populate_packages():
    """Popula a tabela de pacotes"""
    db = SessionLocal()
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📦 Populando Pacotes de Créditos")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    try:
        for pkg_data in PACKAGES:
            # Verificar se já existe
            existing = db.query(Package).filter(Package.id == pkg_data["id"]).first()
            if existing:
                print(f"⚠️  Pacote '{pkg_data['name']}' já existe, pulando...")
                continue
            
            # Criar pacote
            package = Package(
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
            
            db.add(package)
            
            # Calcular preço formatado
            price_brl = pkg_data["price"] / 100
            total_credits = pkg_data["credits"] + pkg_data["bonus"]
            
            print(f"✅ {pkg_data['name']}")
            print(f"   ID: {pkg_data['id']}")
            print(f"   Créditos: {total_credits} ({pkg_data['credits']} + {pkg_data['bonus']} bônus)")
            print(f"   Preço: R$ {price_brl:.2f}")
            if pkg_data['discount_text']:
                print(f"   Desconto: {pkg_data['discount_text']}")
            if pkg_data['is_popular']:
                print(f"   🌟 POPULAR")
            print()
        
        db.commit()
        
        # Contar total
        total = db.query(Package).filter(Package.is_active == True).count()
        
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print(f"✅ Pacotes criados com sucesso!")
        print(f"📊 Total de pacotes ativos: {total}")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
        
    except Exception as e:
        print(f"\n❌ Erro ao criar pacotes: {e}")
        db.rollback()
        import traceback
        traceback.print_exc()
        sys.exit(1)
    finally:
        db.close()

if __name__ == "__main__":
    populate_packages()
