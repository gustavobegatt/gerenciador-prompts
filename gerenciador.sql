CREATE DATABASE gerenciador_prompts;
USE gerenciador_prompts;

CREATE TABLE projeto (
    id_projeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao VARCHAR(255),
    status VARCHAR(30),
    data_criacao DATE
);

CREATE TABLE prompt (
    id_prompt INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150),
    texto VARCHAR(1000),
    data_criacao DATE
);

CREATE TABLE utiliza (
    id_utiliza INT PRIMARY KEY AUTO_INCREMENT,
    id_projeto INT,
    id_prompt INT,
    data_uso DATE
);

INSERT INTO projeto (nome, descricao, status, data_criacao)
VALUES
('Chatbot de Atendimento', 'Assistente virtual para suporte ao cliente.', 'ativo', '2026-10-20'),
('Gerador de Resumos', 'Ferramenta que resume textos longos.', 'ativo', '2026-10-25'),
('Analise de Sentimentos', 'Classificacao de avaliacoes de produtos.', 'concluido', '2026-10-30');

INSERT INTO prompt (titulo, texto, data_criacao)
VALUES
('Resumir texto', 'Resuma o texto a seguir em ate 5 linhas: {texto}', '2026-10-21'),
('Tom formal', 'Reescreva a mensagem abaixo em tom formal: {mensagem}', '2026-10-22'),
('Classificar sentimento', 'Classifique a avaliacao como positiva, neutra ou negativa: {avaliacao}', '2026-10-23');

INSERT INTO utiliza (id_projeto, id_prompt, data_uso)
VALUES
(1, 2, '2026-11-01'),
(2, 1, '2026-11-03'),
(3, 3, '2026-11-04');