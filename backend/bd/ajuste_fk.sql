-- Ajuste do banco: adiciona as FOREIGN KEYs na tabela utiliza.
-- Rode UMA vez, depois do gerenciador.sql. Não apaga nenhum dado.
USE gerenciador_prompts;

ALTER TABLE utiliza
  ADD CONSTRAINT fk_utiliza_projeto
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto)
    ON DELETE CASCADE,
  ADD CONSTRAINT fk_utiliza_prompt
    FOREIGN KEY (id_prompt) REFERENCES prompt(id_prompt)
    ON DELETE CASCADE;
