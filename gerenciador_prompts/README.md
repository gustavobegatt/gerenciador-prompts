# PromptLab

PromptLab é uma aplicação para centralizar, organizar e gerenciar prompts de inteligência artificial. Os prompts ficam guardados em um banco de dados relacional e podem ser vinculados aos projetos em que são usados.

Projeto Integrado DWS + POO + BD (2º TI).

## Acesse o site

**https://gustavobegatt.github.io/gerenciador-prompts/**

> **Atenção:** o GitHub Pages hospeda apenas arquivos estáticos, então não executa Python nem MySQL. O site publicado funciona em **modo demonstração**: usa dados de exemplo guardados no próprio navegador e mostra um aviso no topo de todas as páginas. A versão completa, com a API Flask e o banco MySQL, roda localmente (veja [Como executar](#como-executar-localmente)).

## Funcionalidades

- **Projetos:** cadastrar, editar, excluir e filtrar por status (ativo ou concluído).
- **Biblioteca de prompts:** cadastrar, buscar pelo título, copiar o texto, editar e excluir.
- **Vínculo entre projetos e prompts**, com a data de uso de cada um.
- **Início:** indicadores e gráficos (projetos por status, projetos criados por mês e prompts mais usados).
- **Calendário:** mostra prompts usados, projetos criados e prompts criados em cada dia. Ao registrar o uso de um prompt em um dia, ele aparece naquele dia.
- **Tema claro e escuro.**

## Tecnologias

| Camada | Tecnologias |
|---|---|
| Front-end | HTML, CSS e JavaScript (Fetch), sem bibliotecas externas |
| Back-end | Python (POO), Flask e Flask-CORS |
| Banco de dados | MySQL, com `mysql-connector-python` |
| Versionamento | Git e GitHub (com GitHub Pages) |

## Estrutura do repositório

```
gerenciador-prompts/
├── index.html                 Início (indicadores, gráficos e quadro de projetos)
├── pages/                     Demais páginas do site
│   ├── calendario.html        Calendário
│   ├── prompts.html           Biblioteca de prompts
│   ├── prompt-form.html       Novo e editar prompt
│   ├── projeto.html           Detalhe do projeto
│   └── projeto-form.html      Novo e editar projeto
├── css/style.css              Estilos e temas
├── js/                        Um arquivo JavaScript por página
│   ├── api.js                 Funções compartilhadas e chamadas à API (Fetch)
│   └── demo-api.js            API de demonstração (só no GitHub Pages)
├── docs/                      Sitemap, wireframes e modelo lógico
├── README.md
├── .gitignore
│
└── backend/
    ├── requirements.txt
    ├── python/
    │   ├── app.py             Rotas Flask (API REST)
    │   ├── models.py          Classes Projeto, Prompt e Utiliza
    │   ├── dao.py             Acesso ao banco (um DAO por entidade)
    │   ├── conexao.py         Conexão com o MySQL
    │   └── teste_conexao.py   Teste da conexão com o banco
    ├── bd/
    │   ├── gerenciador.sql    Criação do banco, das tabelas e dados de exemplo
    │   └── ajuste_fk.sql      FOREIGN KEYs da tabela utiliza
    └── docs/                  Diagrama de classes e modelos conceitual e lógico
```

## Como executar localmente

**Pré-requisitos:** Python 3 e o XAMPP (para o MySQL).

1. **Ligue o MySQL** no painel do XAMPP.
2. **Crie o banco.** No phpMyAdmin (`http://localhost/phpmyadmin`), aba **SQL**, execute nesta ordem:
   1. `backend/bd/gerenciador.sql`
   2. `backend/bd/ajuste_fk.sql`
3. **Instale as dependências.** Em um terminal aberto na pasta `backend`:
   ```
   python -m pip install -r requirements.txt
   ```
4. **(Opcional) Teste a conexão.** Em um terminal aberto em `backend/python`:
   ```
   python teste_conexao.py
   ```
5. **Inicie a API.** No terminal aberto em `backend/python`:
   ```
   python app.py
   ```
   A API fica em `http://127.0.0.1:5000`. Deixe a janela aberta.
6. **Abra o site.** Dê um duplo clique em `index.html` (na raiz do projeto).

Se o seu MySQL tiver senha ou outro endereço, defina antes as variáveis de ambiente `DB_HOST`, `DB_USER`, `DB_PASSWORD` e `DB_NAME`.

## Modo demonstração

O site publicado no GitHub Pages não tem acesso à API, então o arquivo `js/demo-api.js` imita as rotas do `app.py` (mesmos caminhos, respostas e validações) e guarda os dados no navegador (`localStorage`). Os dados iniciais são os mesmos do `gerenciador.sql`.

- Só é ativado em endereços `*.github.io` ou quando a página é aberta com `?demo=1`.
- Ao rodar no computador com `python app.py`, **não é usado**: o site fala com a API Flask e o MySQL.
- O botão **Restaurar dados de exemplo**, na faixa de aviso, volta aos dados iniciais.

## Arquitetura do back-end

| Camada | Arquivo | Responsabilidade |
|---|---|---|
| Domínio | `models.py` | Classes com atributos privados, `@property`, validações e `to_dict()` |
| Acesso a dados | `dao.py` | Único ponto que conversa com o MySQL (padrão DAO, consultas parametrizadas) |
| API | `app.py` | Rotas Flask que recebem JSON, chamam os DAOs e devolvem JSON |

## Rotas da API

| Método | Rota | O que faz |
|---|---|---|
| GET | `/projetos` (`?status=ativo`) | Lista projetos, com filtro opcional por status |
| GET | `/projetos/<id>` | Busca um projeto |
| POST | `/projetos` | Cria um projeto |
| PUT | `/projetos/<id>` | Atualiza um projeto |
| DELETE | `/projetos/<id>` | Exclui um projeto (e seus vínculos) |
| GET | `/projetos/<id>/prompts` | Lista os prompts usados no projeto |
| POST | `/projetos/<id>/prompts` | Adiciona um prompt ao projeto (`data_uso` opcional) |
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

Exemplos de corpo JSON:

```json
POST /projetos             {"nome": "Chatbot", "descricao": "Suporte ao cliente", "status": "ativo"}
POST /prompts              {"titulo": "Resumir texto", "texto": "Resuma: {texto}", "id_projeto": 1}
POST /projetos/1/prompts   {"id_prompt": 2, "data_uso": "2026-11-20"}
```

As datas de criação são preenchidas automaticamente com a data de hoje. O `status` do projeto aceita `ativo` ou `concluido`.

## Modelagem

**Diagrama de classes**

![Diagrama de classes](backend/docs/diagrama_classes_gerenciador_prompts.png)

**Modelo conceitual**

![Modelo conceitual](backend/docs/modelo_conceitual.png)

**Modelo lógico**

![Modelo lógico](backend/docs/modelo_logico.png)

**Sitemap**

![Sitemap](docs/wireframes/sitemap.png)

## Etapas do projeto

- [x] Etapa 1: modelagem e banco de dados
- [x] Etapa 2: back-end em Python (classes, DAOs e rotas Flask)
- [x] Entrega final: front-end (HTML, CSS e JavaScript) consumindo a API via Fetch, publicado no GitHub Pages
