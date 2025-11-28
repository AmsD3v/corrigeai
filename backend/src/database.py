import os
import time
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy.exc import OperationalError
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

# Variáveis globais que serão inicializadas no startup
engine = None
SessionLocal = None
Base = declarative_base()

def init_db_engine():
    """
    Inicializa o engine do banco de dados com retry.
    Esta função deve ser chamada no evento de startup do FastAPI.
    """
    global engine, SessionLocal
    for attempt in range(5):  # 5 tentativas
        try:
            engine = create_engine(DATABASE_URL)
            # Testa a conexão
            with engine.connect() as conn:
                pass
            print("Conexão com o banco de dados estabelecida com sucesso!")
            SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
            return engine
        except OperationalError as e:
            print(f"Tentativa {attempt + 1} de 5 falhou ao conectar ao banco de dados: {e}")
            if attempt < 4:  # Não dormir na última tentativa
                time.sleep(2)
            else:
                print(f"Falha após 5 tentativas. Levantando exceção.")
                raise e
    raise Exception(f"Não foi possível conectar ao banco de dados após 5 tentativas.")

def get_db():
    if SessionLocal is None:
        raise Exception("Database not initialized. Call init_db_engine() first.")
    db = SessionLocal()
    try:
        yield db
    except Exception:
        db.rollback()  # Rollback em caso de erro
        raise
    finally:
        db.close()

