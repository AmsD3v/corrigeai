"""
Script para testar correção do Gemini diretamente
"""
import asyncio
import sys
sys.path.append('src')

from src.gemini_service import correct_essay_with_gemini

async def test_gemini():
    title = "Educação no Brasil"
    theme = "Desafios da educação brasileira"
    content = """
    A educação no Brasil enfrenta diversos desafios. Entre eles, destaca-se a falta de investimento
    em infraestrutura escolar e na formação de professores. Além disso, há grande desigualdade
    no acesso à educação de qualidade entre diferentes regiões do país.
    
    Para melhorar esse cenário, é necessário aumentar o orçamento destinado à educação, 
    capacitar melhor os profissionais e implementar políticas públicas efetivas.
    """
    
    try:
        print("🚀 Iniciando teste de correção...")
        result = await correct_essay_with_gemini(title, theme, content)
        print("\n✅ Correção concluída!")
        print(f"\n📊 Nota Total: {result['total_score']}")
        print(f"\n📝 Pontos Fortes: {result['strengths']}")
        print(f"\n⚠️ Melhorias: {result['improvements']}")
    except Exception as e:
        print(f"\n❌ Erro: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    asyncio.run(test_gemini())
