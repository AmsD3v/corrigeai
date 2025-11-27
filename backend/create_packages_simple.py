"""
Script simples para criar pacotes usando SQL direto
Execute no servidor: python create_packages_simple.py
"""
import psycopg2
import os
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

def create_packages():
    """Cria pacotes de créditos usando SQL direto"""
    print("🚀 Iniciando criação de pacotes...")
    
    # Conectar ao banco
    db_url = os.getenv("DATABASE_URL")
    
    # Parse DATABASE_URL: postgresql://user:password@host/database
    # Exemplo: postgresql://corrigeai:CorrigeAI2024@localhost/corrigeai
    parts = db_url.replace("postgresql://", "").split("@")
    user_pass = parts[0].split(":")
    host_db = parts[1].split("/")
    
    conn = psycopg2.connect(
        host=host_db[0],
        database=host_db[1],
        user=user_pass[0],
        password=user_pass[1]
    )
    cur = conn.cursor()
    
    try:
        # Verificar pacotes existentes
        cur.execute("SELECT COUNT(*) FROM package")
        count = cur.fetchone()[0]
        
        if count > 0:
            print(f"⚠️  Já existem {count} pacotes no banco.")
            # Deletar pacotes existentes
            cur.execute("DELETE FROM package")
            conn.commit()
            print("🗑️  Pacotes antigos removidos.")
        
        # Inserir pacotes
        packages = [
            (
                "starter_10",
                "Starter",
                10,
                2,
                1990,
                0,
                None,
                False,
                True,
                "10 RedaCoins",
                "+2 bônus grátis",
                "Correção avançada",
                "Suporte prioritário"
            ),
            (
                "popular_30",
                "Popular",
                30,
                10,
                4990,
                17,
                "17% OFF!",
                True,
                True,
                "30 RedaCoins",
                "+10 bônus (33% extra!)",
                "Correção premium",
                "Análise detalhada"
            ),
            (
                "pro_100",
                "Pro",
                100,
                50,
                14990,
                25,
                "25% OFF!",
                False,
                True,
                "100 RedaCoins",
                "+50 bônus (50% extra!)",
                "Correção premium+",
                "Prioridade máxima"
            )
        ]
        
        for pkg in packages:
            cur.execute("""
                INSERT INTO package (
                    id, name, credits, bonus, price,
                    discount_percentage, discount_text,
                    is_popular, is_active,
                    feature1, feature2, feature3, feature4
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, pkg)
        
        conn.commit()
        
        print("\n✅ Pacotes criados com sucesso!\n")
        print("📦 Pacotes disponíveis:")
        print("━" * 60)
        
        cur.execute("SELECT name, credits, bonus, price FROM package ORDER BY price")
        for row in cur.fetchall():
            name, credits, bonus, price = row
            print(f"  {name:12} | {credits:3} créditos + {bonus:2} bônus | R$ {price/100:.2f}")
        
        print("━" * 60)
        
    except Exception as e:
        print(f"❌ Erro: {e}")
        conn.rollback()
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    create_packages()
