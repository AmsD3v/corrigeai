"""
Script para importar TODOS os municípios brasileiros da API do IBGE
"""
import requests
import psycopg2
from psycopg2.extras import execute_values

# Configurações do banco
DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "prosaai",
    "user": "user",
    "password": "password"
}

def get_municipios():
    """Busca todos os municípios da API do IBGE"""
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"
    print("📥 Buscando municípios da API do IBGE...")
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    print(f"✅ {len(data)} municípios encontrados")
    return data

def import_to_database(municipios):
    """Importa os municípios para o banco de dados"""
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()
    
    try:
        # Limpar cidades existentes
        print("🗑️ Limpando cidades existentes...")
        cursor.execute("DELETE FROM brazil_city")
        
        # Preparar dados para inserção em lote
        cities = []
        for mun in municipios:
            name = mun["nome"]
            state_code = mun["microrregiao"]["mesorregiao"]["UF"]["sigla"]
            cities.append((name, state_code))
        
        # Inserir em lotes
        print("📤 Inserindo cidades no banco...")
        insert_query = "INSERT INTO brazil_city (name, state_code) VALUES %s"
        execute_values(cursor, insert_query, cities)
        
        conn.commit()
        print(f"✅ {len(cities)} cidades inseridas com sucesso!")
        
    except Exception as e:
        conn.rollback()
        print(f"❌ Erro: {e}")
        raise
    finally:
        cursor.close()
        conn.close()

def main():
    print("=" * 50)
    print("IMPORTAÇÃO DE MUNICÍPIOS DO IBGE")
    print("=" * 50)
    
    municipios = get_municipios()
    import_to_database(municipios)
    
    print("\n🎉 Importação concluída!")

if __name__ == "__main__":
    main()
