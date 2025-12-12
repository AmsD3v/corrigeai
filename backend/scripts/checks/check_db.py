import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError

# Carrega as variáveis do arquivo .env na raiz do backend
load_dotenv()

# Pega a URL do banco de dados do ambiente
DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    print("Erro: A variável de ambiente DATABASE_URL não foi encontrada no arquivo .env.")
else:
    print(f"Tentando conectar ao banco de dados: {DATABASE_URL}")
    try:
        # Cria a 'engine' de conexão
        engine = create_engine(DATABASE_URL)
        
        # Tenta estabelecer uma conexão
        with engine.connect() as connection:
            print("\n>>> SUCESSO! A conexão com o banco de dados foi estabelecida com êxito.")
    except OperationalError as e:
        print("\n>>> FALHA! Não foi possível conectar ao banco de dados.")
        print("Por favor, verifique os seguintes pontos:")
        print("1. O servidor do banco de dados (PostgreSQL) está rodando?")
        print("2. O endereço, a porta, o nome de usuário, a senha e o nome do banco na DATABASE_URL estão corretos?")
        print("\nDetalhes do Erro:")
        print(e)
    except Exception as e:
        print(f"\n>>> FALHA! Ocorreu um erro inesperado: {e}")