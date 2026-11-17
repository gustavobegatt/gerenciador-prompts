"""DAOs: única camada que conversa com o MySQL.

Usa %s como marcador de parâmetro (nunca f-string com dados do usuário),
o que evita SQL Injection.
"""
from contextlib import contextmanager

from conexao import obter_conexao
from models import Projeto, Prompt, Utiliza


@contextmanager
def _cursor(commit=False):
    """Abre conexão + cursor; fecha tudo no final e desfaz em caso de erro."""
    conexao = obter_conexao()
    cursor = conexao.cursor(dictionary=True)
    try:
        yield cursor
        if commit:
            conexao.commit()
    except Exception:
        conexao.rollback()
        raise
    finally:
        cursor.close()
        conexao.close()


# ---------------------------------------------------------------- Projeto
class ProjetoDAO:
    @staticmethod
    def _montar(linha):
        return Projeto(
            linha["id_projeto"], linha["nome"], linha["descricao"],
            linha["status"], linha["data_criacao"],
        )

    def inserir(self, projeto):
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "INSERT INTO projeto (nome, descricao, status, data_criacao) "
                "VALUES (%s, %s, %s, %s)",
                (projeto.nome, projeto.descricao, projeto.status, projeto.data_criacao),
            )
            return cursor.lastrowid

    def buscar_todos(self, status=None):
        sql = "SELECT * FROM projeto"
        parametros = []
        if status:
            sql += " WHERE status = %s"
            parametros.append(status)
        sql += " ORDER BY data_criacao DESC, id_projeto DESC"
        with _cursor() as cursor:
            cursor.execute(sql, parametros)
            return [self._montar(l) for l in cursor.fetchall()]

    def buscar_por_id(self, id_projeto):
        with _cursor() as cursor:
            cursor.execute("SELECT * FROM projeto WHERE id_projeto = %s", (id_projeto,))
            linha = cursor.fetchone()
            return self._montar(linha) if linha else None

    def atualizar(self, id_projeto, projeto):
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "UPDATE projeto SET nome=%s, descricao=%s, status=%s WHERE id_projeto=%s",
                (projeto.nome, projeto.descricao, projeto.status, id_projeto),
            )

    def remover(self, id_projeto):
        with _cursor(commit=True) as cursor:
            cursor.execute("DELETE FROM projeto WHERE id_projeto = %s", (id_projeto,))
            return cursor.rowcount > 0


# ----------------------------------------------------------------- Prompt
class PromptDAO:
    @staticmethod
    def _montar(linha):
        return Prompt(
            linha["id_prompt"], linha["titulo"], linha["texto"], linha["data_criacao"],
        )

    def inserir(self, prompt):
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "INSERT INTO prompt (titulo, texto, data_criacao) VALUES (%s, %s, %s)",
                (prompt.titulo, prompt.texto, prompt.data_criacao),
            )
            return cursor.lastrowid

    def inserir_com_projeto(self, prompt, id_projeto, data_uso):
        """Cria o prompt e já o vincula a um projeto, na MESMA transação:
        ou grava os dois, ou não grava nenhum."""
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "INSERT INTO prompt (titulo, texto, data_criacao) VALUES (%s, %s, %s)",
                (prompt.titulo, prompt.texto, prompt.data_criacao),
            )
            id_prompt = cursor.lastrowid
            cursor.execute(
                "INSERT INTO utiliza (id_projeto, id_prompt, data_uso) VALUES (%s, %s, %s)",
                (id_projeto, id_prompt, data_uso),
            )
            return id_prompt

    def buscar_todos(self, busca=None, limite=None):
        sql = "SELECT * FROM prompt"
        parametros = []
        if busca:
            sql += " WHERE titulo LIKE %s"
            parametros.append(f"%{busca}%")
        sql += " ORDER BY data_criacao DESC, id_prompt DESC"
        if limite:
            sql += " LIMIT %s"
            parametros.append(limite)
        with _cursor() as cursor:
            cursor.execute(sql, parametros)
            return [self._montar(l) for l in cursor.fetchall()]

    def buscar_por_id(self, id_prompt):
        with _cursor() as cursor:
            cursor.execute("SELECT * FROM prompt WHERE id_prompt = %s", (id_prompt,))
            linha = cursor.fetchone()
            return self._montar(linha) if linha else None

    def atualizar(self, id_prompt, prompt):
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "UPDATE prompt SET titulo=%s, texto=%s WHERE id_prompt=%s",
                (prompt.titulo, prompt.texto, id_prompt),
            )

    def remover(self, id_prompt):
        with _cursor(commit=True) as cursor:
            cursor.execute("DELETE FROM prompt WHERE id_prompt = %s", (id_prompt,))
            return cursor.rowcount > 0


# --------------------------------------------------------------- Utiliza
class UtilizaDAO:
    @staticmethod
    def _montar(linha):
        return Utiliza(
            linha["id_utiliza"], linha["id_projeto"], linha["id_prompt"], linha["data_uso"],
        )

    def inserir(self, utiliza):
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "INSERT INTO utiliza (id_projeto, id_prompt, data_uso) VALUES (%s, %s, %s)",
                (utiliza.id_projeto, utiliza.id_prompt, utiliza.data_uso),
            )
            return cursor.lastrowid

    def buscar_todos(self):
        with _cursor() as cursor:
            cursor.execute("SELECT * FROM utiliza ORDER BY data_uso DESC, id_utiliza DESC")
            return [self._montar(l) for l in cursor.fetchall()]

    def buscar_por_id(self, id_utiliza):
        with _cursor() as cursor:
            cursor.execute("SELECT * FROM utiliza WHERE id_utiliza = %s", (id_utiliza,))
            linha = cursor.fetchone()
            return self._montar(linha) if linha else None

    def buscar_por_projeto(self, id_projeto):
        """Prompts usados em um projeto (JOIN), para a tela 'Detalhe do projeto'.
        Devolve dicionários, pois mistura dados de duas tabelas."""
        with _cursor() as cursor:
            cursor.execute(
                "SELECT u.id_utiliza, u.id_projeto, u.id_prompt, u.data_uso, "
                "       p.titulo, p.texto "
                "FROM utiliza u JOIN prompt p ON p.id_prompt = u.id_prompt "
                "WHERE u.id_projeto = %s "
                "ORDER BY u.data_uso DESC, u.id_utiliza DESC",
                (id_projeto,),
            )
            resultado = cursor.fetchall()
        for linha in resultado:
            linha["data_uso"] = linha["data_uso"].isoformat()
        return resultado

    def atualizar(self, id_utiliza, utiliza):
        with _cursor(commit=True) as cursor:
            cursor.execute(
                "UPDATE utiliza SET id_projeto=%s, id_prompt=%s, data_uso=%s "
                "WHERE id_utiliza=%s",
                (utiliza.id_projeto, utiliza.id_prompt, utiliza.data_uso, id_utiliza),
            )

    def remover(self, id_utiliza):
        with _cursor(commit=True) as cursor:
            cursor.execute("DELETE FROM utiliza WHERE id_utiliza = %s", (id_utiliza,))
            return cursor.rowcount > 0
