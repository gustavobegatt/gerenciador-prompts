import os
import mysql.connector

# Configurações padrão do XAMPP (usuário root, sem senha).
# Podem ser trocadas por variáveis de ambiente, para não deixar
# senha escrita no código que vai para o GitHub.
CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "user": os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", ""),
    "database": os.getenv("DB_NAME", "gerenciador_prompts"),
    "charset": "utf8mb4",
}


def obter_conexao():
    """Abre e devolve uma conexão com o banco gerenciador_prompts."""
    return mysql.connector.connect(**CONFIG)
