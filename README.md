# 🧪 PromptLab

PromptLab é uma aplicação desenvolvida para centralizar, organizar e gerenciar prompts de inteligência artificial de forma eficiente, armazenando tudo de maneira estruturada em uma base de dados relacional.

## 🚀 Status do Projeto

✅ **Parte 1 — Base de Dados (concluída):** modelagem lógica do banco de dados relacional e conexão inicial com o MySQL utilizando Python.

✅ **Parte 2 — Back-End (concluída):** classes em POO, camada de acesso a dados (DAO) e API REST com Flask, com cadastro, consulta, edição e exclusão funcionando no banco.

🔜 **Próxima fase:** front-end (HTML/CSS/JS) consumindo a API via Fetch.

## 🛠️ Tecnologias e Ferramentas Utilizadas

- **Python** (linguagem principal para lógica, classes e conexões)
- **Flask** (micro-framework para a API REST)
- **Flask-CORS** (libera o acesso do front-end à API)
- **MySQL** (banco de dados relacional para persistência dos prompts)
- **mysql-connector-python** (driver de conexão Python ↔ MySQL)
- **Git & GitHub** (controle de versão)

## 📁 Estrutura do Repositório

```
📦 promptlab
 ┣ 📂 docs/                # Documentação e modelo lógico do banco de dados
 ┣ 📜 conexao.py           # Conexão com o MySQL (configurável por variáveis de ambiente)
 ┣ 📜 gerenciador.sql      # Criação do banco, tabelas e dados de exemplo
 ┣ 📜 ajuste_fk.sql        # Adiciona as FOREIGN KEYs na tabela utiliza
 ┣ 📜 models.py            # Classes Projeto, Prompt e Utiliza (POO, encapsulamento)
 ┣ 📜 dao.py               # DAOs: acesso ao banco (ProjetoDAO, PromptDAO, UtilizaDAO)
 ┣ 📜 app.py               # API REST (rotas Flask)
 ┣ 📜 teste_conexao.py     # Script para validação da conexão com o banco
 ┣ 📜 requirements.txt     # Dependências e bibliotecas do projeto
 ┗ 📜 README.md            # Documentação principal do projeto
```

## ▶️ Como Executar

1. Inicie o **Apache e o MySQL** no XAMPP.
2. No phpMyAdmin (aba **SQL**), execute nesta ordem: `gerenciador.sql` e depois `ajuste_fk.sql`.
3. Instale as dependências:
   ```
   pip install -r requirements.txt
   ```
4. (Opcional) Teste a conexão com o banco:
   ```
   python teste_conexao.py
   ```
5. Inicie a API:
   ```
   python app.py
   ```
   A API fica disponível em `http://127.0.0.1:5000`.

> Se o seu MySQL tiver senha, defina antes as variáveis de ambiente `DB_HOST`, `DB_USER`, `DB_PASSWORD` e `DB_NAME`.

## 🧱 Arquitetura do Back-End

| Camada | Arquivo | Responsabilidade |
|---|---|---|
| Domínio | `models.py` | Classes com atributos privados, `@property`, validações e `to_dict()` |
| Acesso a dados | `dao.py` | Único ponto que conversa com o MySQL (padrão DAO, consultas parametrizadas) |
| API | `app.py` | Rotas Flask que recebem JSON, chamam os DAOs e devolvem JSON |

## 🔌 Rotas da API

| Método | Rota | O que faz |
|---|---|---|
| GET | `/projetos` (`?status=ativo`) | Lista projetos, com filtro opcional por status |
| GET | `/projetos/<id>` | Busca um projeto |
| POST | `/projetos` | Cria um projeto |
| PUT | `/projetos/<id>` | Atualiza um projeto |
| DELETE | `/projetos/<id>` | Exclui um projeto (e seus vínculos) |
| GET | `/projetos/<id>/prompts` | Lista os prompts usados no projeto |
| POST | `/projetos/<id>/prompts` | Adiciona um prompt ao projeto |
| GET | `/prompts` (`?busca=texto`, `?recentes=5`) | Lista prompts, com busca por título e recentes |
| GET | `/prompts/<id>` | Busca um prompt |
| POST | `/prompts` | Cria um prompt (`id_projeto` opcional) |
| PUT | `/prompts/<id>` | Atualiza um prompt |
| DELETE | `/prompts/<id>` | Exclui um prompt (e seus vínculos) |
| GET | `/utiliza` | Lista os vínculos projeto–prompt |
| GET | `/utiliza/<id>` | Busca um vínculo |
| POST | `/utiliza` | Cria um vínculo |
| PUT | `/utiliza/<id>` | Atualiza um vínculo |
| DELETE | `/utiliza/<id>` | Remove só o vínculo |

### Exemplos de corpo JSON

```json
POST /projetos             {"nome": "Chatbot", "descricao": "Suporte ao cliente", "status": "ativo"}
POST /prompts              {"titulo": "Resumir texto", "texto": "Resuma: {texto}", "id_projeto": 1}
POST /projetos/1/prompts   {"id_prompt": 2}
```

As datas (`data_criacao` e `data_uso`) são preenchidas automaticamente com a data de hoje. O `status` do projeto aceita `ativo` ou `concluido`.s do projeto
 ┗ 📜 README.md            # Documentação principal do projeto
