import mysql.connector
from conexao import obter_conexao


def testar():
    conexao = None
    try:
        conexao = obter_conexao()
        cursor = conexao.cursor()
        print("Conexão com o banco realizada com sucesso!\n")

        for tabela in ("projeto", "prompt", "utiliza"):
            cursor.execute(f"SELECT COUNT(*) FROM {tabela}")
            total = cursor.fetchone()[0]
            print(f"Tabela {tabela}: {total} registro(s)")

        print("\nProjetos cadastrados:")
        cursor.execute("SELECT id_projeto, nome, status FROM projeto")
        for id_projeto, nome, status in cursor.fetchall():
            print(f"  {id_projeto} - {nome} ({status})")

    except mysql.connector.Error as erro:
        print("Erro ao conectar ou consultar o banco:", erro)
    finally:
        if conexao is not None and conexao.is_connected():
            conexao.close()


if __name__ == "__main__":
    testar()
