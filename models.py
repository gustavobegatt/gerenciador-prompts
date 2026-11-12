"""Classes do domínio (conforme o Diagrama de Classes UML).

Todos os atributos são privados e expostos por @property.
Os setters validam os dados e lançam ValueError quando algo está inválido.
"""
from datetime import date

STATUS_VALIDOS = ("ativo", "concluido")


# ---------- funções auxiliares de validação ----------
def _texto_obrigatorio(valor, campo, limite):
    if valor is None or not str(valor).strip():
        raise ValueError(f"O campo '{campo}' é obrigatório.")
    valor = str(valor).strip()
    if len(valor) > limite:
        raise ValueError(f"O campo '{campo}' deve ter no máximo {limite} caracteres.")
    return valor


def _texto_opcional(valor, campo, limite):
    if valor is None:
        return ""
    valor = str(valor).strip()
    if len(valor) > limite:
        raise ValueError(f"O campo '{campo}' deve ter no máximo {limite} caracteres.")
    return valor


def _inteiro(valor, campo):
    try:
        return int(valor)
    except (TypeError, ValueError):
        raise ValueError(f"O campo '{campo}' deve ser um número inteiro.")


def _data(valor, campo):
    """Aceita date, texto 'AAAA-MM-DD' ou None (vira a data de hoje)."""
    if valor is None or valor == "":
        return date.today()
    if isinstance(valor, date):
        return valor
    try:
        return date.fromisoformat(str(valor))
    except ValueError:
        raise ValueError(f"O campo '{campo}' deve estar no formato AAAA-MM-DD.")


# ---------- classes ----------
class Projeto:
    def __init__(self, id_projeto, nome, descricao, status="ativo", data_criacao=None):
        self.__id_projeto = id_projeto
        self.nome = nome
        self.descricao = descricao
        self.status = status
        self.data_criacao = data_criacao

    @property
    def id_projeto(self):
        return self.__id_projeto

    @property
    def nome(self):
        return self.__nome

    @nome.setter
    def nome(self, valor):
        self.__nome = _texto_obrigatorio(valor, "nome", 100)

    @property
    def descricao(self):
        return self.__descricao

    @descricao.setter
    def descricao(self, valor):
        self.__descricao = _texto_opcional(valor, "descricao", 255)

    @property
    def status(self):
        return self.__status

    @status.setter
    def status(self, valor):
        valor = str(valor or "ativo").strip().lower()
        if valor not in STATUS_VALIDOS:
            raise ValueError("O status deve ser 'ativo' ou 'concluido'.")
        self.__status = valor

    @property
    def data_criacao(self):
        return self.__data_criacao

    @data_criacao.setter
    def data_criacao(self, valor):
        self.__data_criacao = _data(valor, "data_criacao")

    def to_dict(self):
        return {
            "id_projeto": self.__id_projeto,
            "nome": self.__nome,
            "descricao": self.__descricao,
            "status": self.__status,
            "data_criacao": self.__data_criacao.isoformat(),
        }


class Prompt:
    def __init__(self, id_prompt, titulo, texto, data_criacao=None):
        self.__id_prompt = id_prompt
        self.titulo = titulo
        self.texto = texto
        self.data_criacao = data_criacao

    @property
    def id_prompt(self):
        return self.__id_prompt

    @property
    def titulo(self):
        return self.__titulo

    @titulo.setter
    def titulo(self, valor):
        self.__titulo = _texto_obrigatorio(valor, "titulo", 150)

    @property
    def texto(self):
        return self.__texto

    @texto.setter
    def texto(self, valor):
        self.__texto = _texto_obrigatorio(valor, "texto", 1000)

    @property
    def data_criacao(self):
        return self.__data_criacao

    @data_criacao.setter
    def data_criacao(self, valor):
        self.__data_criacao = _data(valor, "data_criacao")

    def to_dict(self):
        return {
            "id_prompt": self.__id_prompt,
            "titulo": self.__titulo,
            "texto": self.__texto,
            "data_criacao": self.__data_criacao.isoformat(),
        }


class Utiliza:
    """Registro de que um Prompt foi usado em um Projeto."""

    def __init__(self, id_utiliza, id_projeto, id_prompt, data_uso=None):
        self.__id_utiliza = id_utiliza
        self.id_projeto = id_projeto
        self.id_prompt = id_prompt
        self.data_uso = data_uso

    @property
    def id_utiliza(self):
        return self.__id_utiliza

    @property
    def id_projeto(self):
        return self.__id_projeto

    @id_projeto.setter
    def id_projeto(self, valor):
        self.__id_projeto = _inteiro(valor, "id_projeto")

    @property
    def id_prompt(self):
        return self.__id_prompt

    @id_prompt.setter
    def id_prompt(self, valor):
        self.__id_prompt = _inteiro(valor, "id_prompt")

    @property
    def data_uso(self):
        return self.__data_uso

    @data_uso.setter
    def data_uso(self, valor):
        self.__data_uso = _data(valor, "data_uso")

    def to_dict(self):
        return {
            "id_utiliza": self.__id_utiliza,
            "id_projeto": self.__id_projeto,
            "id_prompt": self.__id_prompt,
            "data_uso": self.__data_uso.isoformat(),
        }
