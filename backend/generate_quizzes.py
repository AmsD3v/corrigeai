"""
Script para gerar quizzes com IA para todas as lições.
Usa a API do Groq para gerar 3 perguntas de múltipla escolha para cada lição.
"""
import os
import sys
import json
import time

# Adicionar o diretório src ao path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from groq import Groq
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Configuração do banco de dados
DATABASE_URL = os.environ.get("DATABASE_URL", "postgresql://postgres:CorrigeAI2024Prod!@db:5432/corrigeai")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# API Key do Groq
GROQ_API_KEY = os.environ.get("GROQ_API_KEY")

def generate_quiz_for_lesson(client, title: str, description: str, content: str) -> list:
    """Gera 3 perguntas de quiz usando IA"""
    
    prompt = f"""Você é um professor especialista em redação para vestibulares brasileiros.

Gere EXATAMENTE 3 perguntas de múltipla escolha sobre o seguinte conteúdo de lição:

Título: {title}
Descrição: {description}
Conteúdo: {content[:1500]}

REGRAS:
1. Cada pergunta deve ter 4 alternativas (A, B, C, D)
2. Apenas 1 alternativa deve ser correta
3. As perguntas devem testar compreensão do conteúdo
4. Use linguagem clara e objetiva

Responda APENAS com um JSON válido no formato:
[
  {{
    "question": "Texto da pergunta 1?",
    "options": ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"],
    "correct": 0
  }},
  {{
    "question": "Texto da pergunta 2?",
    "options": ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"],
    "correct": 1
  }},
  {{
    "question": "Texto da pergunta 3?",
    "options": ["Alternativa A", "Alternativa B", "Alternativa C", "Alternativa D"],
    "correct": 2
  }}
]

O campo "correct" é o índice (0-3) da alternativa correta.
"""
    
    try:
        response = client.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.7,
            max_tokens=1500
        )
        
        response_text = response.choices[0].message.content.strip()
        
        # Extrair JSON da resposta
        if "```json" in response_text:
            response_text = response_text.split("```json")[1].split("```")[0].strip()
        elif "```" in response_text:
            response_text = response_text.split("```")[1].split("```")[0].strip()
        
        quiz = json.loads(response_text)
        
        # Validar estrutura
        if not isinstance(quiz, list) or len(quiz) != 3:
            print(f"  ⚠️ Quiz inválido: não tem 3 perguntas")
            return None
            
        for q in quiz:
            if not all(k in q for k in ["question", "options", "correct"]):
                print(f"  ⚠️ Quiz inválido: faltam campos")
                return None
            if len(q["options"]) != 4:
                print(f"  ⚠️ Quiz inválido: não tem 4 opções")
                return None
        
        return quiz
        
    except Exception as e:
        print(f"  ❌ Erro ao gerar quiz: {e}")
        return None


def main():
    if not GROQ_API_KEY:
        print("❌ GROQ_API_KEY não configurada!")
        return
    
    client = Groq(api_key=GROQ_API_KEY)
    db = SessionLocal()
    
    try:
        # Buscar lições sem quiz
        result = db.execute("""
            SELECT id, title, description, content 
            FROM lesson 
            WHERE quiz_data IS NULL OR quiz_data = ''
            ORDER BY id
        """)
        lessons = result.fetchall()
        
        print(f"📚 {len(lessons)} lições sem quiz encontradas")
        
        success_count = 0
        error_count = 0
        
        for i, lesson in enumerate(lessons):
            lesson_id, title, description, content = lesson
            print(f"\n[{i+1}/{len(lessons)}] Gerando quiz para: {title[:50]}...")
            
            quiz = generate_quiz_for_lesson(client, title, description, content)
            
            if quiz:
                # Salvar no banco
                quiz_json = json.dumps(quiz, ensure_ascii=False)
                db.execute(
                    "UPDATE lesson SET quiz_data = :quiz WHERE id = :id",
                    {"quiz": quiz_json, "id": lesson_id}
                )
                db.commit()
                print(f"  ✅ Quiz salvo!")
                success_count += 1
            else:
                error_count += 1
            
            # Rate limiting - esperar 1 segundo entre requisições
            time.sleep(1)
        
        print(f"\n\n{'='*50}")
        print(f"✅ Quizzes gerados com sucesso: {success_count}")
        print(f"❌ Erros: {error_count}")
        print(f"{'='*50}")
        
    finally:
        db.close()


if __name__ == "__main__":
    main()
