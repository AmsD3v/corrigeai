"""
Script para migrar dados do SQLite local para PostgreSQL em produção.
"""
import sqlite3
import psycopg2

# Configurações
SQLITE_PATH = "sql_app.db"
POSTGRES_CONFIG = {
    "host": "72.62.12.60",
    "port": 5432,
    "database": "corrigeai",
    "user": "postgres",
    "password": "CorrigeAI2024Prod!"
}

# Mapeamento: SQLite -> PostgreSQL
TABLE_MAPPING = {
    "user": "users",
    "package": "packages", 
    "settings": "settings",
    "submission": "submissions",
    "correction": "corrections",
    "feedback": "feedback",
    "ai_conversations": "chat_messages",
}

def migrate():
    print("🔄 Iniciando migração SQLite -> PostgreSQL...")
    
    # Conectar SQLite
    sqlite_conn = sqlite3.connect(SQLITE_PATH)
    sqlite_conn.row_factory = sqlite3.Row
    sqlite_cur = sqlite_conn.cursor()
    
    # Conectar PostgreSQL
    pg_conn = psycopg2.connect(**POSTGRES_CONFIG)
    pg_cur = pg_conn.cursor()
    
    # Migrar cada tabela
    for sqlite_table, pg_table in TABLE_MAPPING.items():
        try:
            # Buscar dados do SQLite (usar aspas para evitar conflitos com palavras reservadas)
            sqlite_cur.execute(f'SELECT * FROM "{sqlite_table}"')
            rows = sqlite_cur.fetchall()
            
            if not rows:
                print(f"⏭️  Tabela {sqlite_table} está vazia, pulando...")
                continue
            
            # Pegar nomes das colunas
            columns = [description[0] for description in sqlite_cur.description]
            
            # Verificar quais colunas existem no PostgreSQL
            pg_cur.execute(f"""
                SELECT column_name FROM information_schema.columns 
                WHERE table_name = '{pg_table}'
            """)
            pg_columns = [r[0] for r in pg_cur.fetchall()]
            
            # Filtrar apenas colunas que existem em ambos
            valid_columns = [c for c in columns if c in pg_columns]
            
            if not valid_columns:
                print(f"⚠️  Nenhuma coluna compatível para {sqlite_table} -> {pg_table}")
                continue
            
            # Pegar índices das colunas válidas
            column_indices = [columns.index(c) for c in valid_columns]
            
            placeholders = ", ".join(["%s"] * len(valid_columns))
            columns_str = ", ".join(valid_columns)
            
            insert_query = f'INSERT INTO "{pg_table}" ({columns_str}) VALUES ({placeholders}) ON CONFLICT DO NOTHING'
            
            count = 0
            for row in rows:
                try:
                    values = tuple(row[i] for i in column_indices)
                    pg_cur.execute(insert_query, values)
                    count += 1
                except Exception as e:
                    print(f"   ⚠️ Erro: {e}")
                    pg_conn.rollback()
            
            pg_conn.commit()
            print(f"✅ {sqlite_table} -> {pg_table}: {count} registros migrados")
            
            # Atualizar sequence
            if count > 0 and 'id' in valid_columns:
                try:
                    pg_cur.execute(f"SELECT setval(pg_get_serial_sequence('{pg_table}', 'id'), (SELECT COALESCE(MAX(id), 1) FROM \"{pg_table}\"))")
                    pg_conn.commit()
                except:
                    pass
                    
        except Exception as e:
            print(f"❌ Erro na tabela {sqlite_table}: {e}")
            pg_conn.rollback()
    
    # Fechar conexões
    sqlite_conn.close()
    pg_conn.close()
    
    print("\n🎉 Migração concluída!")

if __name__ == "__main__":
    migrate()
