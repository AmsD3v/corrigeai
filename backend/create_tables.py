import logging
import os
import sys

# Força o Python a reconhecer a pasta atual ('backend') como um local para procurar módulos.
# Esta é a correção definitiva para o 'ModuleNotFoundError'.
script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, script_dir)

# Agora, com o caminho corrigido, a importação 'from src...' vai funcionar.
from src.database import engine, Base
from src.models import User, Submission # Importar os modelos é crucial

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def main():
    logger.info("Iniciando o script de criação de tabelas...")
    try:
        logger.info("Conectando ao banco de dados e criando tabelas...")
        Base.metadata.create_all(bind=engine)
        logger.info("Tabelas criadas com sucesso (ou já existiam).")
        logger.info("Script concluído.")
    except Exception as e:
        logger.error(f"Ocorreu um erro fatal ao criar as tabelas: {e}")
        logger.error("VERIFIQUE: A string de conexão no .env está correta? O servidor PostgreSQL está rodando?")

if __name__ == "__main__":
    main()