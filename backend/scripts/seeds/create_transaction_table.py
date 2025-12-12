"""
Create transaction table in database
Run this script to add the transaction table to your existing database
"""
from src.database import init_db_engine, Base
from src.models import Transaction

def create_transaction_table():
    """Create transaction table"""
    engine = init_db_engine()
    
    # Import all models to ensure they're registered
    from src import models
    
    # Create only the transaction table
    Transaction.__table__.create(bind=engine, checkfirst=True)
    
    print("✅ Transaction table created successfully!")

if __name__ == "__main__":
    create_transaction_table()
