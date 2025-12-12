"""
Script para gerar SQL com TODOS os municípios brasileiros do IBGE
"""
import requests

def get_municipios():
    """Busca todos os municípios da API do IBGE"""
    url = "https://servicodados.ibge.gov.br/api/v1/localidades/municipios"
    print("📥 Buscando municípios da API do IBGE...")
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    print(f"✅ {len(data)} municípios encontrados")
    return data

def get_state_code(mun):
    """Extrai código do estado de forma segura"""
    try:
        # Tenta primeiro o caminho padrão
        if mun.get("microrregiao") and mun["microrregiao"].get("mesorregiao"):
            uf = mun["microrregiao"]["mesorregiao"].get("UF")
            if uf:
                return uf.get("sigla")
        
        # Caminho alternativo via região imediata
        if mun.get("regiao-imediata") and mun["regiao-imediata"].get("regiao-intermediaria"):
            uf = mun["regiao-imediata"]["regiao-intermediaria"].get("UF")
            if uf:
                return uf.get("sigla")
        
        return None
    except:
        return None

def generate_sql(municipios):
    """Gera arquivo SQL com todos os municípios"""
    
    sql_lines = []
    sql_lines.append("-- SQL gerado automaticamente com dados do IBGE")
    sql_lines.append("-- Total de municípios: {}".format(len(municipios)))
    sql_lines.append("")
    sql_lines.append("-- Limpar cidades existentes")
    sql_lines.append("DELETE FROM brazil_city;")
    sql_lines.append("")
    sql_lines.append("-- Inserir municípios")
    
    # Processar e filtrar municípios válidos
    valid_cities = []
    skipped = 0
    
    for mun in municipios:
        name = mun.get("nome", "").replace("'", "''")  # Escape aspas simples
        state_code = get_state_code(mun)
        
        if name and state_code:
            valid_cities.append((name, state_code))
        else:
            skipped += 1
            print(f"⚠️ Pulando: {mun.get('nome', 'SEM NOME')}")
    
    print(f"📊 Válidos: {len(valid_cities)}, Pulados: {skipped}")
    
    # Gerar em lotes de 100
    batch_size = 100
    for i in range(0, len(valid_cities), batch_size):
        batch = valid_cities[i:i+batch_size]
        
        values = [f"('{name}', '{code}')" for name, code in batch]
        
        sql_lines.append(f"INSERT INTO brazil_city (name, state_code) VALUES")
        sql_lines.append(",\n".join(values) + ";")
        sql_lines.append("")
    
    # Salvar arquivo
    output_path = "all_cities_ibge.sql"
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_lines))
    
    print(f"✅ Arquivo SQL gerado: {output_path}")
    return output_path

def main():
    print("=" * 50)
    print("GERAÇÃO DE SQL - MUNICÍPIOS DO IBGE")
    print("=" * 50)
    
    municipios = get_municipios()
    sql_file = generate_sql(municipios)
    
    print("\n🎉 SQL gerado com sucesso!")
    print(f"Execute: Get-Content {sql_file} | docker exec -i prosaai_db psql -U user -d prosaai")

if __name__ == "__main__":
    main()
