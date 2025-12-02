#!/usr/bin/env python3
"""
Script para adicionar informações complementares ao banco de dados.
Adiciona campos ao modelo User e cria novas tabelas.
"""
import os
import sys
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    print("❌ DATABASE_URL não encontrada no .env")
    sys.exit(1)

engine = create_engine(DATABASE_URL)

# SQL Migration Scripts
MIGRATIONS = [
    # 1. Adicionar campos complementares à tabela user
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS school_level VARCHAR;
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS intended_course VARCHAR;
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS state VARCHAR(2);
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS city VARCHAR;
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS enem_attempts VARCHAR;
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS previous_scores VARCHAR;
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS main_goal VARCHAR;
    """,
    """
    ALTER TABLE "user" ADD COLUMN IF NOT EXISTS study_method VARCHAR;
    """,
    
    # 2. Criar tabela dropdown_option
    """
    CREATE TABLE IF NOT EXISTS dropdown_option (
        id SERIAL PRIMARY KEY,
        category VARCHAR NOT NULL,
        value VARCHAR NOT NULL,
        label VARCHAR NOT NULL,
        "order" INTEGER DEFAULT 0,
        is_active BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(category, value)
    );
    """,
    
    # 3. Criar índice para busca por categoria
    """
    CREATE INDEX IF NOT EXISTS idx_dropdown_option_category 
    ON dropdown_option(category) WHERE is_active = TRUE;
    """,
    
    # 4. Criar tabela brazil_state
    """
    CREATE TABLE IF NOT EXISTS brazil_state (
        id SERIAL PRIMARY KEY,
        code VARCHAR(2) UNIQUE NOT NULL,
        name VARCHAR NOT NULL
    );
    """,
    
    # 5. Criar tabela brazil_city
    """
    CREATE TABLE IF NOT EXISTS brazil_city (
        id SERIAL PRIMARY KEY,
        name VARCHAR NOT NULL,
        state_code VARCHAR(2) REFERENCES brazil_state(code),
        UNIQUE(name, state_code)
    );
    """,
    
    # 6. Criar índice para busca por estado
    """
    CREATE INDEX IF NOT EXISTS idx_brazil_city_state 
    ON brazil_city(state_code);
    """
]

def run_migrations():
    """Executa as migrações"""
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🔧 Migrando Banco de Dados - Informações Complementares")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    with engine.connect() as conn:
        for i, migration in enumerate(MIGRATIONS, 1):
            try:
                print(f"📝 Executando migração {i}/{len(MIGRATIONS)}...")
                conn.execute(text(migration))
                conn.commit()
                print(f"✅ Migração {i} concluída!")
            except Exception as e:
                print(f"⚠️  Migração {i} falhou (pode já existir): {e}")
                conn.rollback()
    
    print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("✅ MIGRAÇÕES CONCLUÍDAS!")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    # Verificar tabelas criadas
    print("📊 Verificando tabelas...")
    with engine.connect() as conn:
        result = conn.execute(text("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name IN ('dropdown_option', 'brazil_state', 'brazil_city')
            ORDER BY table_name;
        """))
        tables = [row[0] for row in result]
        
        if tables:
            print(f"✅ Tabelas encontradas: {', '.join(tables)}")
        else:
            print("⚠️  Nenhuma tabela nova encontrada")
    
    # Verificar colunas adicionadas
    print("\n📊 Verificando colunas adicionadas ao User...")
    with engine.connect() as conn:
        result = conn.execute(text("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name = 'user' 
            AND column_name IN ('school_level', 'intended_course', 'state', 'city', 
                               'enem_attempts', 'previous_scores', 'main_goal', 'study_method')
            ORDER BY column_name;
        """))
        columns = [row[0] for row in result]
        
        if columns:
            print(f"✅ Colunas adicionadas: {', '.join(columns)}")
        else:
            print("⚠️  Nenhuma coluna nova encontrada")

if __name__ == "__main__":
    run_migrations()
