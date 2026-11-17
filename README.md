PromptLab

Gerenciador de prompts de inteligência artificial, com projetos, biblioteca de prompts, calendário de uso e indicadores.

Projeto Integrado DWS + POO + BD — 2º TI, UNASP Hortolândia.

Site publicado (modo demonstração): https://gustavobegatt.github.io/gerenciador-prompts/

Sobre o site publicado: o GitHub Pages hospeda apenas arquivos estáticos, então não executa Python nem MySQL. Por isso o site publicado roda em modo demonstração: usa dados de exemplo guardados no próprio navegador e mostra um aviso no topo de todas as páginas. A versão completa, com a API Flask e o banco MySQL, roda no computador (veja Como executar localmente).

Sobre o projeto

Quem trabalha com inteligência artificial costuma acumular dezenas de prompts: alguns bons, outros esquecidos em anotações, conversas antigas e arquivos soltos. O PromptLab resolve isso reunindo tudo em um só lugar.

Cada prompt fica guardado em um banco de dados relacional e pode ser vinculado aos projetos em que é usado, com a data de uso. Com esses vínculos, o sistema mostra o que foi feito e quando: quais projetos estão ativos ou concluídos, quais prompts são os mais usados e o que aconteceu em cada dia do mês.

O projeto integra as três disciplinas do bimestre:

Disciplina	O que foi aplicado
Banco de Dados	Modelagem conceitual e lógica, criação das tabelas em MySQL, chaves estrangeiras com ON DELETE CASCADE e consultas com JOIN
POO	Classes com atributos privados, @property, validações e to_dict(), mais o padrão DAO para o acesso ao banco
Desenvolvimento Web (DWS)	Interface em HTML, CSS e JavaScript consumindo a API REST por fetch, com gráficos, calendário e tema claro e escuro
Funcionalidades
Projetos: cadastrar, editar, excluir e filtrar por status (ativo ou concluído), em um quadro com as duas colunas.
Biblioteca de prompts: cadastrar, buscar pelo título, copiar o texto com um clique, editar e excluir.
Vínculo entre projetos e prompts: cada uso registra a data, e um prompt pode ser usado em vários projetos.
Início: indicadores e gráficos desenhados em SVG (projetos por status, projetos criados por mês e ranking dos prompts mais usados), além dos prompts recentes.
Calendário: mostra, em cada dia, os prompts usados, os projetos criados e os prompts criados, com filtros por tipo e resumo do mês. Ao registrar o uso de um prompt em um dia, ele aparece naquele dia.
Tema claro e escuro, que fica salvo no navegador.
Validações no back-end (tamanhos, status permitido, campos obrigatórios) com mensagens de erro claras na tela.
Tecnologias
Camada	Tecnologias
Front-end	HTML, CSS (variáveis e temas) e JavaScript puro com fetch, sem bibliotecas externas
Back-end	Python 3, Flask e Flask-CORS
Banco de dados	MySQL (XAMPP e phpMyAdmin), com mysql-connector-python
Versionamento e publicação	Git, GitHub e GitHub Pages
Como o projeto foi desenvolvido

O trabalho foi feito em três etapas:

Etapa 1: modelagem e banco de dados. Modelo conceitual, modelo lógico, diagrama de classes, sitemap, wireframes e o script SQL de criação do banco gerenciador_prompts com dados de exemplo.
Etapa 2: back-end. Classes de domínio, DAOs, rotas Flask e conexão com o MySQL, testadas rota por rota.
Entrega final: front-end integrado. Cinco telas, a partir dos wireframes, consumindo as rotas Flask via fetch, funcionando de ponta a ponta e publicadas no GitHub Pages.
Arquitetura
Navegador (HTML, CSS, JS)  --fetch/JSON-->  Flask (app.py)  -->  DAOs (dao.py)  -->  MySQL
Camada	Arquivo	Responsabilidade
Domínio	models.py	Classes Projeto, Prompt e Utiliza, com atributos privados, @property, validações e to_dict()
Acesso a dados	dao.py	Único ponto que conversa com o MySQL (padrão DAO, consultas parametrizadas com %s, transações)
API	app.py	Rotas Flask que recebem JSON, chamam os DAOs e devolvem JSON, com tratamento de erros (400, 404 e 500)
Conexão	conexao.py	Abre a conexão com o MySQL, com variáveis de ambiente opcionais
Interface	index.html, pages/	Páginas que montam a tela com os dados recebidos da API

Algumas decisões do projeto:

Consultas parametrizadas em todo o acesso ao banco, o que evita SQL injection.
escapeHtml em todo texto vindo do usuário antes de entrar na tela, o que evita XSS.
Exclusão em cascata: ao excluir um projeto ou um prompt, os vínculos dele são removidos junto.
Criação de prompt com vínculo em uma única transação: ou grava tudo, ou nada.
Datas no horário local, para o calendário não errar o dia à noite.
Estrutura do repositório
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
├── docs/                      Diagramas, modelos, sitemap e wireframes
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
    └── bd/
        ├── gerenciador.sql    Criação do banco, das tabelas e dados de exemplo
        └── ajuste_fk.sql      FOREIGN KEYs da tabela utiliza
Como executar localmente

Pré-requisitos: Python 3 e o XAMPP (para o MySQL).

Ligue o MySQL no painel do XAMPP.
Crie o banco. No phpMyAdmin (http://localhost/phpmyadmin), aba SQL, execute nesta ordem:
backend/bd/gerenciador.sql
backend/bd/ajuste_fk.sql
Instale as dependências. Em um terminal aberto na pasta backend:
python -m pip install -r requirements.txt
(Opcional) Teste a conexão. Em um terminal aberto em backend/python:
python teste_conexao.py
Inicie a API. No terminal aberto em backend/python:
python app.py

A API fica em http://127.0.0.1:5000. Deixe a janela aberta. 6. Abra o site. Dê um duplo clique em index.html (na raiz do projeto).

Se o seu MySQL tiver senha ou outro endereço, defina antes as variáveis de ambiente DB_HOST, DB_USER, DB_PASSWORD e DB_NAME.

Modo demonstração

O site publicado no GitHub Pages não tem acesso à API, então o arquivo js/demo-api.js imita as rotas do app.py (mesmos caminhos, respostas e validações) e guarda os dados no navegador (localStorage). Os dados iniciais são os mesmos do gerenciador.sql.

Só é ativado em endereços *.github.io ou quando a página é aberta com ?demo=1.
Ao rodar no computador com python app.py, não é usado: o site fala com a API Flask e o MySQL.
O botão Restaurar dados de exemplo, na faixa de aviso, volta aos dados iniciais.
Rotas da API
Método	Rota	O que faz
GET	/projetos (?status=ativo)	Lista projetos, com filtro opcional por status
GET	/projetos/<id>	Busca um projeto
POST	/projetos	Cria um projeto
PUT	/projetos/<id>	Atualiza um projeto
DELETE	/projetos/<id>	Exclui um projeto (e seus vínculos)
GET	/projetos/<id>/prompts	Lista os prompts usados no projeto
POST	/projetos/<id>/prompts	Adiciona um prompt ao projeto (data_uso opcional)
GET	/prompts (?busca=texto, ?recentes=5)	Lista prompts, com busca por título e recentes
GET	/prompts/<id>	Busca um prompt
POST	/prompts	Cria um prompt (id_projeto opcional)
PUT	/prompts/<id>	Atualiza um prompt
DELETE	/prompts/<id>	Exclui um prompt (e seus vínculos)
GET	/utiliza	Lista os vínculos projeto–prompt
GET	/utiliza/<id>	Busca um vínculo
POST	/utiliza	Cria um vínculo
PUT	/utiliza/<id>	Atualiza um vínculo
DELETE	/utiliza/<id>	Remove só o vínculo

Exemplos de corpo JSON:

json
POST /projetos             {"nome": "Chatbot", "descricao": "Suporte ao cliente", "status": "ativo"}
POST /prompts              {"titulo": "Resumir texto", "texto": "Resuma: {texto}", "id_projeto": 1}
POST /projetos/1/prompts   {"id_prompt": 2, "data_uso": "2026-11-20"}

As datas de criação são preenchidas automaticamente com a data de hoje. O status do projeto aceita ativo ou concluido.

Modelagem

Diagrama de classes

Diagrama de classes

Modelo conceitual

Modelo conceitual

Modelo lógico

Modelo lógico

Sitemap

Sitemap

Etapas do projeto
[x] Etapa 1: modelagem e banco de dados
[x] Etapa 2: back-end em Python (classes, DAOs e rotas Flask)
[x] Entrega final: front-end (HTML, CSS e JavaScript) consumindo a API via Fetch, publicado no GitHub Pages
