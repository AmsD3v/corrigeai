import secrets

def generate_secret_key():
    """Gera uma chave secreta segura hexadecimal de 32 bytes (64 caracteres)."""
    return secrets.token_hex(32)

if __name__ == "__main__":
    secret = generate_secret_key()
    print("\n--- Gerador de Chave Secreta Segura ---")
    print("Copie a chave abaixo e cole no seu arquivo .env na variável SECRET_KEY:\n")
    print(secret)
    print("\n---------------------------------------")
