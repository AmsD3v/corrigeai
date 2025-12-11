"""
Script para gerar conteúdo completo (explicação + quiz) para todas as lições.
Usa a API do Google Gemini para gerar explicações detalhadas das competências e 3 perguntas de quiz.
"""
import os
import sys
import json
import time
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

# Configuração do banco de dados
DATABASE_URL = os.environ.get("DATABASE_URL", "postgresql://postgres:CorrigeAI2024Prod!@db:5432/corrigeai")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# API Key do Gemini
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY")


def generate_lesson_content(model, exam_type: str, competency_name: str, lesson_type: str, lesson_order: int) -> dict:
    """
    Gera conteúdo completo da lição: explicação + quiz
    lesson_type: 'Introdução', 'Praticando', 'Aprofundando', 'Erros Comuns', 'Dominando'
    """
    
    type_descriptions = {
        1: "Introdução - conceitos básicos e fundamentais",
        2: "Praticando - exercícios e aplicações práticas", 
        3: "Aprofundando - técnicas avançadas e nuances",
        4: "Erros Comuns - evite os erros mais frequentes",
        5: "Dominando - revisão e consolidação final"
    }
    
    lesson_focus = type_descriptions.get(lesson_order, "conceitos gerais")

    prompt = f"""Você é um professor especialista em redação para vestibulares brasileiros, especificamente para o {exam_type.upper()}.

Crie uma lição completa sobre a competência "{competency_name}".

TIPO DA LIÇÃO: {lesson_focus}

VOCÊ DEVE GERAR:

1. **CONTEÚDO**: Uma explicação detalhada (300-500 palavras) no formato Markdown, incluindo:
   - O que é esta competência
   - Por que é importante no {exam_type.upper()}
   - Como desenvolver esta habilidade
   - Exemplos práticos
   - Dicas importantes

2. **QUIZ**: 3 perguntas de múltipla escolha para testar o conhecimento, cada uma com 4 alternativas.

Responda EXATAMENTE neste formato JSON:
{{
  "content": "# Título\\n\\nConteúdo em markdown com ## subtítulos, **negrito**, listas, etc...",
  "quiz": [
    {{
      "question": "Pergunta 1?",
      "options": ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"],
      "correct": 0
    }},
    {{
      "question": "Pergunta 2?",
      "options": ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"],
      "correct": 1
    }},
    {{
      "question": "Pergunta 3?",
      "options": ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"],
      "correct": 2
    }}
  ]
}}

IMPORTANTE:
- O conteúdo deve ser educativo e específico para esta competência
- As perguntas devem testar compreensão real, não apenas memorização
- Use linguagem clara e acessível
- O campo "correct" é o índice (0-3) da alternativa correta
- Responda APENAS com o JSON, sem texto adicional
"""
    
    try:
        response = model.generate_content(prompt)
        response_text = response.text.strip()
        
        # Extrair JSON da resposta
        if "```json" in response_text:
            response_text = response_text.split("```json")[1].split("```")[0].strip()
        elif "```" in response_text:
            response_text = response_text.split("```")[1].split("```")[0].strip()
        
        result = json.loads(response_text)
        
        # Validar estrutura
        if "content" not in result or "quiz" not in result:
            print(f"  ⚠️ Resposta inválida: faltam campos")
            return None
            
        if not isinstance(result["quiz"], list) or len(result["quiz"]) != 3:
            print(f"  ⚠️ Quiz inválido: não tem 3 perguntas")
            return None
            
        return result
        
    except json.JSONDecodeError as e:
        print(f"  ❌ Erro ao parsear JSON: {e}")
        return None
    except Exception as e:
        print(f"  ❌ Erro ao gerar conteúdo: {e}")
        return None


def main():
    if not GEMINI_API_KEY:
        print("❌ GEMINI_API_KEY não configurada!")
        return
    
    import google.generativeai as genai
    genai.configure(api_key=GEMINI_API_KEY)
    model = genai.GenerativeModel('gemini-2.0-flash')
    
    db = SessionLocal()
    
    try:
        # Buscar lições que precisam de conteúdo
        result = db.execute(text("""
            SELECT id, exam_type, competency, title, "order"
            FROM lesson 
            WHERE content IS NULL 
               OR content = '' 
               OR LENGTH(content) < 200
               OR quiz_data IS NULL
            ORDER BY exam_type, competency, "order"
        """))
        lessons = result.fetchall()
        
        print(f"📚 {len(lessons)} lições precisam de conteúdo")
        
        if len(lessons) == 0:
            print("✅ Todas as lições já têm conteúdo!")
            return
        
        success_count = 0
        error_count = 0
        
        for i, lesson in enumerate(lessons):
            lesson_id, exam_type, competency, title, order = lesson
            
            # Extrair nome da competência do título
            if ": " in title:
                competency_name = title.split(": ", 1)[1]
            else:
                competency_name = title
            
            print(f"\n[{i+1}/{len(lessons)}] {exam_type.upper()} C{competency} L{order}: {competency_name[:40]}...")
            
            result = generate_lesson_content(model, exam_type, competency_name, title, order)
            
            if result:
                # Salvar no banco
                content = result["content"]
                quiz_json = json.dumps(result["quiz"], ensure_ascii=False)
                
                db.execute(
                    text("UPDATE lesson SET content = :content, quiz_data = :quiz WHERE id = :id"),
                    {"content": content, "quiz": quiz_json, "id": lesson_id}
                )
                db.commit()
                print(f"  ✅ Conteúdo e quiz salvos!")
                success_count += 1
            else:
                error_count += 1
            
            # Rate limiting - esperar 0.5 segundos entre requisições (Gemini é mais rápido)
            time.sleep(0.5)
        
        print(f"\n\n{'='*50}")
        print(f"✅ Lições atualizadas com sucesso: {success_count}")
        print(f"❌ Erros: {error_count}")
        print(f"{'='*50}")
        
    finally:
        db.close()


if __name__ == "__main__":
    main()
