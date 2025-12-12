"""
Script para testar a API key do Gemini
"""
import google.generativeai as genai
import os
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

api_key = os.getenv("GEMINI_API_KEY")

print("="*60)
print("🔍 Testando Gemini API Key")
print("="*60)

if not api_key or api_key == "placeholder_key":
    print("❌ API key não configurada ou inválida!")
    print(f"   Valor atual: {api_key}")
    exit(1)

print(f"✅ API key encontrada: {api_key[:10]}...")

try:
    # Configurar Gemini
    genai.configure(api_key=api_key)
    
    # Testar com uma requisição simples
    model = genai.GenerativeModel('gemini-1.5-flash')
    response = model.generate_content("Diga apenas 'OK' se você está funcionando.")
    
    print(f"✅ Resposta do Gemini: {response.text.strip()}")
    print("="*60)
    print("✅ API key está VÁLIDA e FUNCIONANDO!")
    print("="*60)
    
except Exception as e:
    print(f"❌ Erro ao testar API key: {e}")
    print("="*60)
    print("❌ API key pode estar INVÁLIDA ou EXPIRADA!")
    print("="*60)
    exit(1)
