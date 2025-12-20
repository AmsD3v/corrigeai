"""
Script para popular estados e cidades brasileiras usando dados do IBGE.
Execute: docker compose exec backend python scripts/populate_ibge_locations.py
"""
import requests
from sqlalchemy import create_engine, text
import os

# URL da API do IBGE
URL_ESTADOS = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
URL_MUNICIPIOS = "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"

def get_database_url():
    """Obtém a URL do banco de dados."""
    return os.getenv("DATABASE_URL", "postgresql://user:password@db:5432/prosaai")

def populate_states(engine):
    """Popula a tabela de estados."""
    print("📥 Buscando estados do IBGE...")
    response = requests.get(URL_ESTADOS)
    estados = response.json()
    
    print(f"📊 Encontrados {len(estados)} estados")
    
    with engine.connect() as conn:
        for estado in estados:
            conn.execute(text("""
                INSERT INTO brazil_state (code, name) 
                VALUES (:code, :name) 
                ON CONFLICT (code) DO NOTHING
            """), {"code": estado["sigla"], "name": estado["nome"]})
        conn.commit()
    
    print("✅ Estados inseridos com sucesso!")

def populate_cities(engine):
    """Popula a tabela de cidades."""
    print("📥 Buscando municípios do IBGE (isso pode demorar)...")
    response = requests.get(URL_MUNICIPIOS)
    municipios = response.json()
    
    print(f"📊 Encontrados {len(municipios)} municípios")
    
    with engine.connect() as conn:
        batch = []
        for i, municipio in enumerate(municipios, 1):
            state_code = municipio["microrregiao"]["mesorregiao"]["UF"]["sigla"]
            batch.append({"name": municipio["nome"], "state_code": state_code})
            
            # Inserir em lotes de 500
            if len(batch) >= 500:
                conn.execute(text("""
                    INSERT INTO brazil_city (name, state_code) 
                    VALUES (:name, :state_code)
                """), batch)
                conn.commit()
                print(f"  ⏳ Inseridos {i}/{len(municipios)} municípios...")
                batch = []
        
        # Inserir restante
        if batch:
            conn.execute(text("""
                INSERT INTO brazil_city (name, state_code) 
                VALUES (:name, :state_code)
            """), batch)
            conn.commit()
    
    print("✅ Municípios inseridos com sucesso!")

def main():
    print("🇧🇷 Populando dados do IBGE...")
    print("=" * 50)
    
    db_url = get_database_url()
    print(f"📌 Conectando ao banco: {db_url[:30]}...")
    
    engine = create_engine(db_url)
    
    populate_states(engine)
    populate_cities(engine)
    
    # Verificar contagens
    with engine.connect() as conn:
        states = conn.execute(text("SELECT COUNT(*) FROM brazil_state")).scalar()
        cities = conn.execute(text("SELECT COUNT(*) FROM brazil_city")).scalar()
    
    print("=" * 50)
    print(f"📊 Resumo final:")
    print(f"   Estados: {states}")
    print(f"   Municípios: {cities}")
    print("🎉 Concluído!")

if __name__ == "__main__":
    main()
