"""
Script de teste completo para simular submissão e correção
Vai revelar o erro exato que está causando as falhas
"""
import asyncio
import sys
sys.path.append('src')

from src import database
from src import models
from src.correction_service import process_correction

async def test_full_correction_flow():
    print("\n" + "="*60)
    print("🧪 TESTE COMPLETO DE CORREÇÃO")
    print("="*60 + "\n")
    
    # Initialize database
    print("🔧 Inicializando banco de dados...")
    database.init_db_engine()
    print("✅ Banco inicializado\n")
    
    db = database.SessionLocal()
    
    try:
        # 1. Criar uma submissão de teste
        print("📝 Criando submissão de teste...")
        test_submission = models.Submission(
            title="Teste de Correção",
            theme="Educação no Brasil",
            content="""
            A educação brasileira enfrenta diversos desafios. Entre eles, 
            destacam-se a falta de investimento em infraestrutura escolar 
            e na formação de professores. É necessário aumentar o orçamento 
            destinado à educação e capacitar melhor os profissionais.
            """,
            owner_id=1,  # Assumindo que existe user com ID 1
            status="pending"
        )
        
        db.add(test_submission)
        db.commit()
        db.refresh(test_submission)
        
        submission_id = test_submission.id
        print(f"✅ Submissão criada com ID: {submission_id}")
        
        # 2. Processar correção
        print(f"\n🚀 Iniciando process_correction para ID {submission_id}...")
        print("-" * 60)
        
        await process_correction(submission_id, db)
        
        print("-" * 60)
        print(f"\n✅ Correção processada com sucesso!")
        
        # 3. Verificar resultado
        db.refresh(test_submission)
        print(f"\n📊 Status final da submissão: {test_submission.status}")
        
        correction = db.query(models.Correction).filter(
            models.Correction.submission_id == submission_id
        ).first()
        
        if correction:
            print(f"✅ Correção encontrada!")
            print(f"   Nota total: {correction.total_score}/1000")
            print(f"   Strengths: {correction.strengths[:100]}...")
            print(f"   Improvements: {correction.improvements[:100]}...")
        else:
            print("❌ Correção NÃO encontrada no banco!")
        
    except Exception as e:
        print(f"\n❌ ERRO CAPTURADO:")
        print(f"   Tipo: {type(e).__name__}")
        print(f"   Mensagem: {e}")
        print(f"\n📋 Traceback completo:")
        import traceback
        traceback.print_exc()
        
        # Verificar status da submissão
        if 'test_submission' in locals():
            db.refresh(test_submission)
            print(f"\n📊 Status da submissão após erro: {test_submission.status}")
    
    finally:
        # Limpar submissão de teste
        if 'test_submission' in locals():
            print(f"\n🧹 Limpando submissão de teste {test_submission.id}...")
            db.delete(test_submission)
            db.commit()
        
        db.close()
        print("\n" + "="*60)
        print("🏁 TESTE CONCLUÍDO")
        print("="*60 + "\n")

if __name__ == "__main__":
    asyncio.run(test_full_correction_flow())
