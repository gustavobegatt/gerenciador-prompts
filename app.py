"""API REST (Flask) do Gerenciador de Prompts.

Rodar:  python app.py   ->  http://127.0.0.1:5000
"""
from datetime import date

import mysql.connector
from flask import Flask, jsonify, request
from flask_cors import CORS

from dao import ProjetoDAO, PromptDAO, UtilizaDAO
from models import STATUS_VALIDOS, Projeto, Prompt, Utiliza

app = Flask(__name__)
CORS(app)  # libera o front-end (outra porta/origem) a chamar a API

projeto_dao = ProjetoDAO()
prompt_dao = PromptDAO()
utiliza_dao = UtilizaDAO()


# ------------------------------------------------------------ utilitários
def _corpo_json():
    dados = request.get_json(silent=True)
    if not isinstance(dados, dict):
        raise ValueError("Envie um corpo JSON válido.")
    return dados


def _inteiro(valor, campo):
    try:
        return int(valor)
    except (TypeError, ValueError):
        raise ValueError(f"O campo '{campo}' deve ser um número inteiro.")


def _nao_encontrado(entidade):
    return jsonify({"erro": f"{entidade} não encontrado(a)."}), 404


# --------------------------------------------------------- tratamento de erros
@app.errorhandler(ValueError)
def erro_validacao(erro):
    return jsonify({"erro": str(erro)}), 400


@app.errorhandler(mysql.connector.errors.IntegrityError)
def erro_integridade(erro):
    return jsonify({"erro": "Operação inválida: referência a registro inexistente "
                            "ou vínculo em uso."}), 400


@app.errorhandler(mysql.connector.Error)
def erro_banco(erro):
    return jsonify({"erro": "Erro no banco de dados.", "detalhe": str(erro)}), 500


@app.route("/")
def raiz():
    return jsonify({"mensagem": "API do Gerenciador de Prompts no ar!"})


# ==================================================================== PROJETOS
@app.route("/projetos", methods=["GET"])
def listar_projetos():
    """Filtro opcional: /projetos?status=ativo  (tela Home)."""
    status = request.args.get("status")
    if status:
        status = status.strip().lower()
        if status not in STATUS_VALIDOS:
            raise ValueError("O status deve ser 'ativo' ou 'concluido'.")
    return jsonify([p.to_dict() for p in projeto_dao.buscar_todos(status)])


@app.route("/projetos/<int:id_projeto>", methods=["GET"])
def obter_projeto(id_projeto):
    projeto = projeto_dao.buscar_por_id(id_projeto)
    if projeto is None:
        return _nao_encontrado("Projeto")
    return jsonify(projeto.to_dict())


@app.route("/projetos", methods=["POST"])
def criar_projeto():
    dados = _corpo_json()
    projeto = Projeto(None, dados.get("nome"), dados.get("descricao"),
                      dados.get("status", "ativo"), date.today())
    id_gerado = projeto_dao.inserir(projeto)
    return jsonify({"id_projeto": id_gerado, "mensagem": "Projeto criado com sucesso!"}), 201


@app.route("/projetos/<int:id_projeto>", methods=["PUT"])
def atualizar_projeto(id_projeto):
    existente = projeto_dao.buscar_por_id(id_projeto)
    if existente is None:
        return _nao_encontrado("Projeto")
    dados = _corpo_json()
    projeto = Projeto(
        id_projeto,
        dados.get("nome", existente.nome),
        dados.get("descricao", existente.descricao),
        dados.get("status", existente.status),
        existente.data_criacao,
    )
    projeto_dao.atualizar(id_projeto, projeto)
    return jsonify({"mensagem": "Projeto atualizado!"})


@app.route("/projetos/<int:id_projeto>", methods=["DELETE"])
def remover_projeto(id_projeto):
    if not projeto_dao.remover(id_projeto):
        return _nao_encontrado("Projeto")
    return jsonify({"mensagem": "Projeto removido!"})


# ---- prompts de um projeto (tela "Detalhe do projeto")
@app.route("/projetos/<int:id_projeto>/prompts", methods=["GET"])
def listar_prompts_do_projeto(id_projeto):
    if projeto_dao.buscar_por_id(id_projeto) is None:
        return _nao_encontrado("Projeto")
    return jsonify(utiliza_dao.buscar_por_projeto(id_projeto))


@app.route("/projetos/<int:id_projeto>/prompts", methods=["POST"])
def adicionar_prompt_ao_projeto(id_projeto):
    """Corpo: {"id_prompt": 3}  (data_uso opcional; padrão = hoje)."""
    if projeto_dao.buscar_por_id(id_projeto) is None:
        return _nao_encontrado("Projeto")
    dados = _corpo_json()
    id_prompt = _inteiro(dados.get("id_prompt"), "id_prompt")
    if prompt_dao.buscar_por_id(id_prompt) is None:
        return _nao_encontrado("Prompt")
    utiliza = Utiliza(None, id_projeto, id_prompt, dados.get("data_uso"))
    id_gerado = utiliza_dao.inserir(utiliza)
    return jsonify({"id_utiliza": id_gerado,
                    "mensagem": "Prompt adicionado ao projeto!"}), 201


# ===================================================================== PROMPTS
@app.route("/prompts", methods=["GET"])
def listar_prompts():
    """Filtros opcionais: /prompts?busca=resumir  e  /prompts?recentes=5"""
    busca = request.args.get("busca", "").strip() or None
    limite = None
    if request.args.get("recentes"):
        limite = _inteiro(request.args.get("recentes"), "recentes")
        if limite < 1:
            raise ValueError("O campo 'recentes' deve ser maior que zero.")
    return jsonify([p.to_dict() for p in prompt_dao.buscar_todos(busca, limite)])


@app.route("/prompts/<int:id_prompt>", methods=["GET"])
def obter_prompt(id_prompt):
    prompt = prompt_dao.buscar_por_id(id_prompt)
    if prompt is None:
        return _nao_encontrado("Prompt")
    return jsonify(prompt.to_dict())


@app.route("/prompts", methods=["POST"])
def criar_prompt():
    """Corpo: {"titulo": "...", "texto": "...", "id_projeto": 1 (opcional)}"""
    dados = _corpo_json()
    prompt = Prompt(None, dados.get("titulo"), dados.get("texto"), date.today())
    id_projeto = dados.get("id_projeto")
    if id_projeto in (None, ""):
        id_gerado = prompt_dao.inserir(prompt)
    else:
        id_projeto = _inteiro(id_projeto, "id_projeto")
        if projeto_dao.buscar_por_id(id_projeto) is None:
            return _nao_encontrado("Projeto")
        id_gerado = prompt_dao.inserir_com_projeto(prompt, id_projeto, date.today())
    return jsonify({"id_prompt": id_gerado, "mensagem": "Prompt criado com sucesso!"}), 201


@app.route("/prompts/<int:id_prompt>", methods=["PUT"])
def atualizar_prompt(id_prompt):
    existente = prompt_dao.buscar_por_id(id_prompt)
    if existente is None:
        return _nao_encontrado("Prompt")
    dados = _corpo_json()
    prompt = Prompt(
        id_prompt,
        dados.get("titulo", existente.titulo),
        dados.get("texto", existente.texto),
        existente.data_criacao,
    )
    prompt_dao.atualizar(id_prompt, prompt)
    return jsonify({"mensagem": "Prompt atualizado!"})


@app.route("/prompts/<int:id_prompt>", methods=["DELETE"])
def remover_prompt(id_prompt):
    if not prompt_dao.remover(id_prompt):
        return _nao_encontrado("Prompt")
    return jsonify({"mensagem": "Prompt removido!"})


# ==================================================================== UTILIZA
@app.route("/utiliza", methods=["GET"])
def listar_utiliza():
    return jsonify([u.to_dict() for u in utiliza_dao.buscar_todos()])


@app.route("/utiliza/<int:id_utiliza>", methods=["GET"])
def obter_utiliza(id_utiliza):
    utiliza = utiliza_dao.buscar_por_id(id_utiliza)
    if utiliza is None:
        return _nao_encontrado("Vínculo")
    return jsonify(utiliza.to_dict())


@app.route("/utiliza", methods=["POST"])
def criar_utiliza():
    """Corpo: {"id_projeto": 1, "id_prompt": 2, "data_uso": "2026-11-12" (opcional)}"""
    dados = _corpo_json()
    utiliza = Utiliza(None, dados.get("id_projeto"), dados.get("id_prompt"),
                      dados.get("data_uso"))
    if projeto_dao.buscar_por_id(utiliza.id_projeto) is None:
        return _nao_encontrado("Projeto")
    if prompt_dao.buscar_por_id(utiliza.id_prompt) is None:
        return _nao_encontrado("Prompt")
    id_gerado = utiliza_dao.inserir(utiliza)
    return jsonify({"id_utiliza": id_gerado, "mensagem": "Vínculo criado com sucesso!"}), 201


@app.route("/utiliza/<int:id_utiliza>", methods=["PUT"])
def atualizar_utiliza(id_utiliza):
    existente = utiliza_dao.buscar_por_id(id_utiliza)
    if existente is None:
        return _nao_encontrado("Vínculo")
    dados = _corpo_json()
    utiliza = Utiliza(
        id_utiliza,
        dados.get("id_projeto", existente.id_projeto),
        dados.get("id_prompt", existente.id_prompt),
        dados.get("data_uso", existente.data_uso),
    )
    if projeto_dao.buscar_por_id(utiliza.id_projeto) is None:
        return _nao_encontrado("Projeto")
    if prompt_dao.buscar_por_id(utiliza.id_prompt) is None:
        return _nao_encontrado("Prompt")
    utiliza_dao.atualizar(id_utiliza, utiliza)
    return jsonify({"mensagem": "Vínculo atualizado!"})


@app.route("/utiliza/<int:id_utiliza>", methods=["DELETE"])
def remover_utiliza(id_utiliza):
    """Remove só o vínculo (botão 'Remover' da tela de detalhe do projeto);
    o prompt continua existindo na biblioteca."""
    if not utiliza_dao.remover(id_utiliza):
        return _nao_encontrado("Vínculo")
    return jsonify({"mensagem": "Vínculo removido!"})


if __name__ == "__main__":
    app.run(debug=True)
