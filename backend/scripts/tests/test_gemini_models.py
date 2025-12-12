"""
Testar modelos Gemini disponíveis
"""
import google.generativeai as genai
import os
from dotenv import load_dotenv

load_dotenv()

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

print("🧪 Testando modelos Gemini...\n")

# Testar modelos comuns
models_to_test = [
    'gemini-2.5-flash',
    'gemini-1.5-flash',
    'gemini-1.5-pro',
    'gemini-pro',
]

test_prompt = "Escreva apenas 'OK' se você conseguir ler isso."

for model_name in models_to_test:
    try:
        print(f"📝 Testando: {model_name}...")
        model = genai.GenerativeModel(model_name)
        
        response = model.generate_content(
            test_prompt,
            safety_settings=[
                {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
                {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"},
            ]
        )
        
        # Verificar finish_reason
        if hasattr(response, 'candidates') and len(response.candidates) > 0:
            finish_reason = response.candidates[0].finish_reason
            print(f"   finish_reason: {finish_reason}")
            
            if finish_reason == 1:  # STOP (sucesso)
                print(f"   ✅ FUNCIONA! Resposta: {response.text[:50]}")
            elif finish_reason == 2:  # SAFETY
                print(f"   ⚠️ BLOQUEADO por segurança")
            else:
                print(f"   ⚠️ Outro finish_reason: {finish_reason}")
        else:
            print(f"   ❌ Sem candidates")
            
    except Exception as e:
        print(f"   ❌ ERRO: {e}")
    
    print()

print("\n🔍 Listando modelos disponíveis:")
try:
    for model in genai.list_models():
        if 'generateContent' in model.supported_generation_methods:
            print(f"   - {model.name}")
except Exception as e:
    print(f"   ❌ Erro ao listar: {e}")
