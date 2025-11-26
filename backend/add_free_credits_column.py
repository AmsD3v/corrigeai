"""
Migração: Adicionar coluna free_credits na tabela user

Esta migração adiciona suporte para créditos grátis separados dos créditos comprados.
"""

import sqlite3

def run_migration():
    conn = sqlite3.connect('sql_app.db')
    cursor = conn.cursor()
    
    try:
        # Verificar se a coluna já existe
        cursor.execute("PRAGMA table_info(user)")
        columns = [column[1] for column in cursor.fetchall()]
        
        if 'free_credits' in columns:
            print("⚠️ Coluna 'free_credits' já existe. Migração não necessária.")
            return
        
        # Adicionar coluna free_credits
        print("📝 Adicionando coluna 'free_credits'...")
        cursor.execute("ALTER TABLE user ADD COLUMN free_credits INTEGER DEFAULT 0")
        
        # Migrar créditos existentes para free_credits (opção: manter como estão)
        # Por padrão, todos os créditos atuais serão considerados "comprados"
        # Se quiser migrar para grátis, descomente a linha abaixo:
        # cursor.execute("UPDATE user SET free_credits = credits, credits = 0")
        
        conn.commit()
        print("✅ Coluna 'free_credits' adicionada com sucesso!")
        print("ℹ️ Créditos existentes foram mantidos como CorriCoins (comprados)")
        
    except Exception as e:
        conn.rollback()
        print(f"❌ Erro na migração: {e}")
        raise
    finally:
        conn.close()

if __name__ == "__main__":
    run_migration()
