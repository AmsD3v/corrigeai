"""
Script para gerar lições para todos os vestibulares baseado em exam_criteria.py
Cada competência de cada vestibular terá 5 lições.
"""
import os
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.exam_criteria import EXAM_TYPES

# Template de lições por ordem (1-5) - genérico, adaptado para cada competência
LESSON_TEMPLATES = [
    {
        "order": 1,
        "title_template": "Introdução: {comp_name}",
        "description_template": "Fundamentos e conceitos básicos",
        "content_template": "Aprenda os fundamentos desta competência. {comp_desc}",
        "unlock_type": "free"
    },
    {
        "order": 2,
        "title_template": "Praticando: {comp_name}",
        "description_template": "Exercícios e aplicações práticas",
        "content_template": "Coloque em prática o que aprendeu sobre {comp_name}. Identifique exemplos e erros comuns.",
        "unlock_type": "lesson"
    },
    {
        "order": 3,
        "title_template": "Aprofundando: {comp_name}",
        "description_template": "Técnicas avançadas e nuances",
        "content_template": "Aprofunde seu conhecimento em {comp_name}. Explore casos especiais e exceções.",
        "unlock_type": "lesson"
    },
    {
        "order": 4,
        "title_template": "Erros Comuns: {comp_name}",
        "description_template": "Evite os erros mais frequentes",
        "content_template": "Conheça os erros mais comuns relacionados a {comp_name} e aprenda a evitá-los.",
        "unlock_type": "lesson"
    },
    {
        "order": 5,
        "title_template": "Dominando: {comp_name}",
        "description_template": "Revisão e consolidação",
        "content_template": "Consolide todo o conhecimento sobre {comp_name}. Você está pronto para aplicar na prova!",
        "unlock_type": "lesson"
    }
]

def truncate_text(text, max_len):
    """Trunca texto para caber no banco"""
    if len(text) > max_len:
        return text[:max_len-3] + "..."
    return text

def generate_lessons_sql():
    """Gera SQL para inserir lições de todos os vestibulares"""
    
    sql_lines = []
    sql_lines.append("-- Lições geradas automaticamente baseado em exam_criteria.py")
    sql_lines.append("-- Deletar lições existentes (exceto ENEM que já tem)")
    sql_lines.append("DELETE FROM lesson WHERE exam_type != 'enem';")
    sql_lines.append("")
    sql_lines.append("INSERT INTO lesson (exam_type, competency, \"order\", title, description, content, xp_reward, unlock_type, is_active, created_at) VALUES")
    
    values = []
    
    for exam_key, criteria in EXAM_TYPES.items():
        if exam_key == 'enem':  # ENEM já tem lições
            continue
            
        for comp_idx, competency_name in enumerate(criteria.competencies, start=1):
            # Encurtar nome da competência para usar no título
            comp_short = competency_name[:50] if len(competency_name) > 50 else competency_name
            
            for template in LESSON_TEMPLATES:
                title = truncate_text(template["title_template"].format(comp_name=comp_short), 100)
                description = truncate_text(template["description_template"], 200)
                content = truncate_text(template["content_template"].format(
                    comp_name=comp_short,
                    comp_desc=competency_name
                ), 500)
                
                # Escapar aspas simples
                title = title.replace("'", "''")
                description = description.replace("'", "''")
                content = content.replace("'", "''")
                
                values.append(
                    f"('{exam_key}', {comp_idx}, {template['order']}, '{title}', '{description}', '{content}', 50, '{template['unlock_type']}', true, NOW())"
                )
    
    sql_lines.append(",\n".join(values) + ";")
    
    return "\n".join(sql_lines)

if __name__ == "__main__":
    sql = generate_lessons_sql()
    
    # Salvar em arquivo
    output_file = os.path.join(os.path.dirname(__file__), "seed_lessons.sql")
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(sql)
    
    print(f"SQL gerado com sucesso: {output_file}")
    print(f"Total de vestibulares: {len(EXAM_TYPES) - 1}")  # -1 porque ENEM já tem
    
    # Contar lições
    total = 0
    for exam_key, criteria in EXAM_TYPES.items():
        if exam_key != 'enem':
            total += len(criteria.competencies) * 5
    print(f"Total de lições a serem criadas: {total}")
