"""
Script para criar pacotes de créditos no banco de dados
Execute no servidor: python create_packages.py
"""
from src.database import SessionLocal, init_db_engine
from src.models import Package
import sys

def create_packages():
    """Cria pacotes de créditos para compra"""
    print("🚀 Iniciando criação de pacotes...")
    
    init_db_engine()
    db = SessionLocal()
    
    try:
        # Verificar se já existem pacotes
        existing_count = db.query(Package).count()
        if existing_count > 0:
            print(f"⚠️  Já existem {existing_count} pacotes no banco.")
            response = input("Deseja limpar e recriar? (s/N): ")
            if response.lower() != 's':
                print("❌ Operação cancelada.")
                return
            
            # Limpar pacotes existentes
            db.query(Package).delete()
            db.commit()
            print("🗑️  Pacotes antigos removidos.")
        
        # Pacote Starter
        starter = Package(
            id="starter_10",
            name="Starter",
            credits=10,
            bonus=2,
            price=1990,  # R$ 19.90 em centavos
            discount_percentage=0,
            discount_text=None,
            is_popular=False,
            is_active=True,
            feature1="10 RedaCoins",
            feature2="+2 bônus grátis",
            feature3="Correção avançada",
            feature4="Suporte prioritário"
        )
        
        # Pacote Popular
        popular = Package(
            id="popular_30",
            name="Popular",
            credits=30,
            bonus=10,
            price=4990,  # R$ 49.90
            discount_percentage=17,
            discount_text="17% OFF!",
            is_popular=True,
            is_active=True,
            feature1="30 RedaCoins",
            feature2="+10 bônus (33% extra!)",
            feature3="Correção premium",
            feature4="Análise detalhada"
        )
        
        # Pacote Pro
        pro = Package(
            id="pro_100",
            name="Pro",
            credits=100,
            bonus=50,
            price=14990,  # R$ 149.90
            discount_percentage=25,
            discount_text="25% OFF!",
            is_popular=False,
            is_active=True,
            feature1="100 RedaCoins",
            feature2="+50 bônus (50% extra!)",
            feature3="Correção premium+",
            feature4="Prioridade máxima"
        )
        
        # Adicionar todos os pacotes
        db.add_all([starter, popular, pro])
        db.commit()
        
        print("\n✅ Pacotes criados com sucesso!\n")
        print("📦 Pacotes disponíveis:")
        print("━" * 60)
        print(f"1. {starter.name:12} | {starter.credits:3} créditos + {starter.bonus:2} bônus | R$ {starter.price/100:.2f}")
        print(f"2. {popular.name:12} | {popular.credits:3} créditos + {popular.bonus:2} bônus | R$ {popular.price/100:.2f} ({popular.discount_text})")
        print(f"3. {pro.name:12} | {pro.credits:3} créditos + {pro.bonus:2} bônus | R$ {pro.price/100:.2f} ({pro.discount_text})")
        print("━" * 60)
        
    except Exception as e:
        print(f"❌ Erro ao criar pacotes: {e}")
        db.rollback()
        sys.exit(1)
    finally:
        db.close()

if __name__ == "__main__":
    create_packages()
