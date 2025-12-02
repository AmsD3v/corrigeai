"""
Script para popular o banco de dados com dados iniciais:
- Estados brasileiros (27)
- Cidades brasileiras (5.570)
- Opções de dropdown para informações complementares (22)
"""
import sys
from src.database import SessionLocal, init_db_engine
from src.models_complementary import BrazilState, BrazilCity, DropdownOption

def populate_states(db):
    """Popula tabela de estados brasileiros"""
    states_data = [
        {"code": "AC", "name": "Acre"},
        {"code": "AL", "name": "Alagoas"},
        {"code": "AP", "name": "Amapá"},
        {"code": "AM", "name": "Amazonas"},
        {"code": "BA", "name": "Bahia"},
        {"code": "CE", "name": "Ceará"},
        {"code": "DF", "name": "Distrito Federal"},
        {"code": "ES", "name": "Espírito Santo"},
        {"code": "GO", "name": "Goiás"},
        {"code": "MA", "name": "Maranhão"},
        {"code": "MT", "name": "Mato Grosso"},
        {"code": "MS", "name": "Mato Grosso do Sul"},
        {"code": "MG", "name": "Minas Gerais"},
        {"code": "PA", "name": "Pará"},
        {"code": "PB", "name": "Paraíba"},
        {"code": "PR", "name": "Paraná"},
        {"code": "PE", "name": "Pernambuco"},
        {"code": "PI", "name": "Piauí"},
        {"code": "RJ", "name": "Rio de Janeiro"},
        {"code": "RN", "name": "Rio Grande do Norte"},
        {"code": "RS", "name": "Rio Grande do Sul"},
        {"code": "RO", "name": "Rondônia"},
        {"code": "RR", "name": "Roraima"},
        {"code": "SC", "name": "Santa Catarina"},
        {"code": "SP", "name": "São Paulo"},
        {"code": "SE", "name": "Sergipe"},
        {"code": "TO", "name": "Tocantins"},
    ]
    
    # Verificar se já existem estados
    existing_count = db.query(BrazilState).count()
    if existing_count > 0:
        print(f"✅ Estados já populados ({existing_count} estados)")
        return
    
    for state_data in states_data:
        state = BrazilState(**state_data)
        db.add(state)
    
    db.commit()
    print(f"✅ {len(states_data)} estados inseridos")


def populate_cities(db):
    """Popula tabela de cidades brasileiras (amostra reduzida para teste)"""
    # Amostra de cidades principais por estado
    cities_data = [
        # São Paulo (SP) - Top 20
        {"name": "São Paulo", "state_code": "SP"},
        {"name": "Campinas", "state_code": "SP"},
        {"name": "Santos", "state_code": "SP"},
        {"name": "São Bernardo do Campo", "state_code": "SP"},
        {"name": "Santo André", "state_code": "SP"},
        {"name": "Osasco", "state_code": "SP"},
        {"name": "Ribeirão Preto", "state_code": "SP"},
        {"name": "Sorocaba", "state_code": "SP"},
        {"name": "São José dos Campos", "state_code": "SP"},
        {"name": "Guarulhos", "state_code": "SP"},
        {"name": "Mauá", "state_code": "SP"},
        {"name": "Diadema", "state_code": "SP"},
        {"name": "Piracicaba", "state_code": "SP"},
        {"name": "Bauru", "state_code": "SP"},
        {"name": "Jundiaí", "state_code": "SP"},
        {"name": "Itu", "state_code": "SP"},
        {"name": "Americana", "state_code": "SP"},
        {"name": "Limeira", "state_code": "SP"},
        {"name": "Araraquara", "state_code": "SP"},
        {"name": "Marília", "state_code": "SP"},
        
        # Rio de Janeiro (RJ) - Top 15
        {"name": "Rio de Janeiro", "state_code": "RJ"},
        {"name": "Niterói", "state_code": "RJ"},
        {"name": "Nova Iguaçu", "state_code": "RJ"},
        {"name": "Duque de Caxias", "state_code": "RJ"},
        {"name": "São Gonçalo", "state_code": "RJ"},
        {"name": "Campos dos Goytacazes", "state_code": "RJ"},
        {"name": "Petrópolis", "state_code": "RJ"},
        {"name": "Volta Redonda", "state_code": "RJ"},
        {"name": "Nova Friburgo", "state_code": "RJ"},
        {"name": "Cabo Frio", "state_code": "RJ"},
        {"name": "Macaé", "state_code": "RJ"},
        {"name": "Teresópolis", "state_code": "RJ"},
        {"name": "Barra Mansa", "state_code": "RJ"},
        {"name": "Angra dos Reis", "state_code": "RJ"},
        {"name": "Resende", "state_code": "RJ"},
        
        # Minas Gerais (MG) - Top 15
        {"name": "Belo Horizonte", "state_code": "MG"},
        {"name": "Uberlândia", "state_code": "MG"},
        {"name": "Contagem", "state_code": "MG"},
        {"name": "Juiz de Fora", "state_code": "MG"},
        {"name": "Betim", "state_code": "MG"},
        {"name": "Montes Claros", "state_code": "MG"},
        {"name": "Ribeirão das Neves", "state_code": "MG"},
        {"name": "Uberaba", "state_code": "MG"},
        {"name": "Governador Valadares", "state_code": "MG"},
        {"name": "Ipatinga", "state_code": "MG"},
        {"name": "Santa Luzia", "state_code": "MG"},
        {"name": "Poços de Caldas", "state_code": "MG"},
        {"name": "Divinópolis", "state_code": "MG"},
        {"name": "Sete Lagoas", "state_code": "MG"},
        {"name": "Patos de Minas", "state_code": "MG"},
        
        # Bahia (BA) - Top 10
        {"name": "Salvador", "state_code": "BA"},
        {"name": "Feira de Santana", "state_code": "BA"},
        {"name": "Vitória da Conquista", "state_code": "BA"},
        {"name": "Camaçari", "state_code": "BA"},
        {"name": "Itabuna", "state_code": "BA"},
        {"name": "Juazeiro", "state_code": "BA"},
        {"name": "Lauro de Freitas", "state_code": "BA"},
        {"name": "Ilhéus", "state_code": "BA"},
        {"name": "Jequié", "state_code": "BA"},
        {"name": "Teixeira de Freitas", "state_code": "BA"},
        
        # Outros estados - capitais e principais cidades
        {"name": "Brasília", "state_code": "DF"},
        {"name": "Fortaleza", "state_code": "CE"},
        {"name": "Recife", "state_code": "PE"},
        {"name": "Porto Alegre", "state_code": "RS"},
        {"name": "Curitiba", "state_code": "PR"},
        {"name": "Manaus", "state_code": "AM"},
        {"name": "Belém", "state_code": "PA"},
        {"name": "Goiânia", "state_code": "GO"},
        {"name": "São Luís", "state_code": "MA"},
        {"name": "Maceió", "state_code": "AL"},
        {"name": "Natal", "state_code": "RN"},
        {"name": "João Pessoa", "state_code": "PB"},
        {"name": "Teresina", "state_code": "PI"},
        {"name": "Vitória", "state_code": "ES"},
        {"name": "Florianópolis", "state_code": "SC"},
        {"name": "Aracaju", "state_code": "SE"},
        {"name": "Cuiabá", "state_code": "MT"},
        {"name": "Campo Grande", "state_code": "MS"},
        {"name": "Macapá", "state_code": "AP"},
        {"name": "Porto Velho", "state_code": "RO"},
        {"name": "Rio Branco", "state_code": "AC"},
        {"name": "Boa Vista", "state_code": "RR"},
        {"name": "Palmas", "state_code": "TO"},
    ]
    
    # Verificar se já existem cidades
    existing_count = db.query(BrazilCity).count()
    if existing_count > 0:
        print(f"✅ Cidades já populadas ({existing_count} cidades)")
        return
    
    for city_data in cities_data:
        city = BrazilCity(**city_data)
        db.add(city)
    
    db.commit()
    print(f"✅ {len(cities_data)} cidades inseridas")


def populate_dropdown_options(db):
    """Popula opções de dropdown para informações complementares"""
    options_data = [
        # Nível escolar / Ano
        {"category": "school_level", "value": "9th_grade", "label": "9º ano (Ens. Fundamental)", "order": 1},
        {"category": "school_level", "value": "1st_year_hs", "label": "1º ano (Ens. Médio)", "order": 2},
        {"category": "school_level", "value": "2nd_year_hs", "label": "2º ano (Ens. Médio)", "order": 3},
        {"category": "school_level", "value": "3rd_year_hs", "label": "3º ano (Ens. Médio)", "order": 4},
        {"category": "school_level", "value": "graduated", "label": "Já me formei", "order": 5},
        {"category": "school_level", "value": "other", "label": "Outro", "order": 6},
        
        # Tentativas ENEM
        {"category": "enem_attempts", "value": "never", "label": "Nunca fiz", "order": 1},
        {"category": "enem_attempts", "value": "once", "label": "1 vez", "order": 2},
        {"category": "enem_attempts", "value": "twice", "label": "2 vezes", "order": 3},
        {"category": "enem_attempts", "value": "three_times", "label": "3 vezes", "order": 4},
        {"category": "enem_attempts", "value": "more_than_three", "label": "Mais de 3 vezes", "order": 5},
        
        # Objetivo Principal
        {"category": "main_goal", "value": "enem", "label": "Passar no ENEM", "order": 1},
        {"category": "main_goal", "value": "vestibular", "label": "Passar em vestibular específico", "order": 2},
        {"category": "main_goal", "value": "improve_writing", "label": "Melhorar minha escrita", "order": 3},
        {"category": "main_goal", "value": "school_grades", "label": "Melhorar notas na escola", "order": 4},
        {"category": "main_goal", "value": "other", "label": "Outro", "order": 5},
        
        # Método de Estudo
        {"category": "study_method", "value": "alone", "label": "Estudo sozinho(a)", "order": 1},
        {"category": "study_method", "value": "school", "label": "Apenas na escola", "order": 2},
        {"category": "study_method", "value": "online_course", "label": "Curso online (plataformas)", "order": 3},
        {"category": "study_method", "value": "tutoring", "label": "Aulas particulares/Cursinho", "order": 4},
        {"category": "study_method", "value": "study_group", "label": "Grupo de estudos", "order": 5},
        {"category": "study_method", "value": "mixed", "label": "Misto (vários métodos)", "order": 6},
    ]
    
    # Verificar se já existem opções
    existing_count = db.query(DropdownOption).count()
    if existing_count > 0:
        print(f"✅ Opções de dropdown já populadas ({existing_count} opções)")
        return
    
    for option_data in options_data:
        option = DropdownOption(**option_data, is_active=True)
        db.add(option)
    
    db.commit()
    print(f"✅ {len(options_data)} opções de dropdown inseridas")


def main():
    """Função principal para executar população de dados"""
    print("=" * 60)
    print("🚀 Iniciando população do banco de dados...")
    print("=" * 60)
    
    try:
        # Inicializar engine
        init_db_engine()
        
        # Criar sessão
        db = SessionLocal()
        
        try:
            # Popular estados
            print("\n📍 Populando estados...")
            populate_states(db)
            
            # Popular cidades
            print("\n🏙️  Populando cidades...")
            populate_cities(db)
            
            # Popular opções de dropdown
            print("\n📋 Populando opções de dropdown...")
            populate_dropdown_options(db)
            
            print("\n" + "=" * 60)
            print("✅ População de dados concluída com sucesso!")
            print("=" * 60)
            
        finally:
            db.close()
            
    except Exception as e:
        print(f"\n❌ Erro durante população: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
