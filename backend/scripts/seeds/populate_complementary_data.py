#!/usr/bin/env python3
"""
Script para popular opções padrão dos dropdowns e estados brasileiros.
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

# Opções padrão para dropdowns
DROPDOWN_OPTIONS = [
    # SCHOOL_LEVEL - Ano/Nível Escolar
    {'category': 'school_level', 'value': '1st_year_hs', 'label': '1º Ano - Ensino Médio', 'order': 1},
    {'category': 'school_level', 'value': '2nd_year_hs', 'label': '2º Ano - Ensino Médio', 'order': 2},
    {'category': 'school_level', 'value': '3rd_year_hs', 'label': '3º Ano - Ensino Médio', 'order': 3},
    {'category': 'school_level', 'value': 'prep_course', 'label': 'Cursinho Pré-Vestibular', 'order': 4},
    {'category': 'school_level', 'value': 'higher_ed', 'label': 'Ensino Superior', 'order': 5},
    {'category': 'school_level', 'value': 'graduated', 'label': 'Formado', 'order': 6},
    
    # ENEM_ATTEMPTS - Quantas vezes já fez o ENEM?
    {'category': 'enem_attempts', 'value': 'never', 'label': 'Nunca fiz', 'order': 1},
    {'category': 'enem_attempts', 'value': 'once', 'label': '1 vez', 'order': 2},
    {'category': 'enem_attempts', 'value': 'twice', 'label': '2 vezes', 'order': 3},
    {'category': 'enem_attempts', 'value': 'three_times', 'label': '3 vezes', 'order': 4},
    {'category': 'enem_attempts', 'value': 'four_plus', 'label': '4 ou mais vezes', 'order': 5},
    
    # MAIN_GOAL - Objetivo principal
    {'category': 'main_goal', 'value': 'pass_enem', 'label': 'Passar no  ENEM', 'order': 1},
    {'category': 'main_goal', 'value': 'improve_score', 'label': 'Melhorar minha nota', 'order': 2},
    {'category': 'main_goal', 'value': 'practice', 'label': 'Praticar redação', 'order': 3},
    {'category': 'main_goal', 'value': 'vestibular', 'label': 'Treinar para vestibular', 'order': 4},
    {'category': 'main_goal', 'value': 'personal_dev', 'label': 'Desenvolvimento pessoal', 'order': 5},
    
    # STUDY_METHOD - Como você estuda?
    {'category': 'study_method', 'value': 'self_study', 'label': 'Sozinho(a) em casa', 'order': 1},
    {'category': 'study_method', 'value': 'prep_course_in_person', 'label': 'Cursinho presencial', 'order': 2},
    {'category': 'study_method', 'value': 'online_course', 'label': 'Curso online', 'order': 3},
    {'category': 'study_method', 'value': 'regular_school', 'label': 'Escola regular', 'order': 4},
    {'category': 'study_method', 'value': 'study_group', 'label': 'Grupo de estudos', 'order': 5},
    {'category': 'study_method', 'value': 'hybrid', 'label': 'Híbrido (online + presencial)', 'order': 6},
]

# Estados brasileiros (27 estados)
BRAZIL_STATES = [
    {'code': 'AC', 'name': 'Acre'},
    {'code': 'AL', 'name': 'Alagoas'},
    {'code': 'AP', 'name': 'Amapá'},
    {'code': 'AM', 'name': 'Amazonas'},
    {'code': 'BA', 'name': 'Bahia'},
    {'code': 'CE', 'name': 'Ceará'},
    {'code': 'DF', 'name': 'Distrito Federal'},
    {'code': 'ES', 'name': 'Espírito Santo'},
    {'code': 'GO', 'name': 'Goiás'},
    {'code': 'MA', 'name': 'Maranhão'},
    {'code': 'MT', 'name': 'Mato Grosso'},
    {'code': 'MS', 'name': 'Mato Grosso do Sul'},
    {'code': 'MG', 'name': 'Minas Gerais'},
    {'code': 'PA', 'name': 'Pará'},
    {'code': 'PB', 'name': 'Paraíba'},
    {'code': 'PR', 'name': 'Paraná'},
    {'code': 'PE', 'name': 'Pernambuco'},
    {'code': 'PI', 'name': 'Piauí'},
    {'code': 'RJ', 'name': 'Rio de Janeiro'},
    {'code': 'RN', 'name': 'Rio Grande do Norte'},
    {'code': 'RS', 'name': 'Rio Grande do Sul'},
    {'code': 'RO', 'name': 'Rondônia'},
    {'code': 'RR', 'name': 'Roraima'},
    {'code': 'SC', 'name': 'Santa Catarina'},
    {'code': 'SP', 'name': 'São Paulo'},
    {'code': 'SE', 'name': 'Sergipe'},
    {'code': 'TO', 'name': 'Tocantins'},
]

def populate_dropdown_options():
    """Popula opções dos dropdowns"""
    print("\n📋 Populando Opções dos Dropdowns...")
    
    with engine.connect() as conn:
        inserted = 0
        skipped = 0
        
        for opt in DROPDOWN_OPTIONS:
            try:
                conn.execute(text("""
                    INSERT INTO dropdown_option (category, value, label, "order", is_active)
                    VALUES (:category, :value, :label, :order, TRUE)
                    ON CONFLICT (category, value) DO NOTHING
                """), opt)
                conn.commit()
                inserted += 1
            except Exception as e:
                skipped += 1
                conn.rollback()
        
        print(f"✅ Opções de dropdown: {inserted} inseridas, {skipped} já existiam")

def populate_brazil_states():
    """Popula estados brasileiros"""
    print("\n🗺️  Populando Estados Brasileiros...")
    
    with engine.connect() as conn:
        inserted = 0
        skipped = 0
        
        for state in BRAZIL_STATES:
            try:
                conn.execute(text("""
                    INSERT INTO brazil_state (code, name)
                    VALUES (:code, :name)
                    ON CONFLICT (code) DO NOTHING
                """), state)
                conn.commit()
                inserted += 1
            except Exception as e:
                skipped += 1
                conn.rollback()
        
        print(f"✅ Estados: {inserted} inseridos, {skipped} já existiam")

def main():
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("📦 Populando Dados Iniciais - Informações Complementares")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    
    populate_dropdown_options()
    populate_brazil_states()
    
    print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("✅ POPULAÇÃO CONCLUÍDA!")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
    
    # Exibir estatísticas
    print("📊 Estatísticas:")
    with engine.connect() as conn:
        # Contar opções por categoria
        result = conn.execute(text("""
            SELECT category, COUNT(*) as count
            FROM dropdown_option
            WHERE is_active = TRUE
            GROUP BY category
            ORDER BY category
        """))
        
        print("\nOpções de dropdown por categoria:")
        for row in result:
            print(f"  • {row[0]}: {row[1]} opções")
        
        # Contar estados
        result = conn.execute(text("SELECT COUNT(*) FROM brazil_state"))
        state_count = result.scalar()
        print(f"\nEstados cadastrados: {state_count}")

if __name__ == "__main__":
    main()
