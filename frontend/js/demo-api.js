// ===== API de demonstração (usada só no GitHub Pages) =====
// O GitHub Pages hospeda apenas arquivos estáticos: não roda Python nem MySQL.
// Este arquivo imita as rotas do app.py (mesmos caminhos, mesmas respostas e as
// mesmas validações) guardando os dados no navegador (localStorage).
// Rodando no computador com "python app.py", ele NÃO é usado.

(function () {
  const CHAVE = "promptlab-demo-v1";
  const STATUS = ["ativo", "concluido"];

  // ---------- dados iniciais (iguais aos do gerenciador.sql) ----------
  function semente() {
    return {
      prox: { projeto: 4, prompt: 4, utiliza: 4 },
      projetos: [
        { id_projeto: 1, nome: "Chatbot de Atendimento", descricao: "Assistente virtual para suporte ao cliente.", status: "ativo", data_criacao: "2026-10-20" },
        { id_projeto: 2, nome: "Gerador de Resumos", descricao: "Ferramenta que resume textos longos.", status: "ativo", data_criacao: "2026-10-25" },
        { id_projeto: 3, nome: "Analise de Sentimentos", descricao: "Classificacao de avaliacoes de produtos.", status: "concluido", data_criacao: "2026-10-30" },
      ],
      prompts: [
        { id_prompt: 1, titulo: "Resumir texto", texto: "Resuma o texto a seguir em ate 5 linhas: {texto}", data_criacao: "2026-10-21" },
        { id_prompt: 2, titulo: "Tom formal", texto: "Reescreva a mensagem abaixo em tom formal: {mensagem}", data_criacao: "2026-10-22" },
        { id_prompt: 3, titulo: "Classificar sentimento", texto: "Classifique a avaliacao como positiva, neutra ou negativa: {avaliacao}", data_criacao: "2026-10-23" },
      ],
      utiliza: [
        { id_utiliza: 1, id_projeto: 1, id_prompt: 2, data_uso: "2026-11-01" },
        { id_utiliza: 2, id_projeto: 2, id_prompt: 1, data_uso: "2026-11-03" },
        { id_utiliza: 3, id_projeto: 3, id_prompt: 3, data_uso: "2026-11-04" },
      ],
    };
  }

  let db = lerArmazenado() || semente();

  function lerArmazenado() {
    try {
      const texto = localStorage.getItem(CHAVE);
      return texto ? JSON.parse(texto) : null;
    } catch (e) { return null; }
  }
  function salvar() {
    try { localStorage.setItem(CHAVE, JSON.stringify(db)); } catch (e) { /* sem armazenamento: fica só em memória */ }
  }

  // ---------- validações (mesmas regras do models.py) ----------
  function hoje() {
    const d = new Date();
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
  }
  function obrigatorio(valor, campo, limite) {
    const texto = valor == null ? "" : String(valor).trim();
    if (!texto) throw new Error(`O campo '${campo}' é obrigatório.`);
    if (texto.length > limite) throw new Error(`O campo '${campo}' deve ter no máximo ${limite} caracteres.`);
    return texto;
  }
  function opcional(valor, campo, limite) {
    const texto = valor == null ? "" : String(valor).trim();
    if (texto.length > limite) throw new Error(`O campo '${campo}' deve ter no máximo ${limite} caracteres.`);
    return texto;
  }
  function inteiro(valor, campo) {
    const n = Number(valor);
    if (valor === null || valor === "" || valor === undefined || !Number.isInteger(n)) {
      throw new Error(`O campo '${campo}' deve ser um número inteiro.`);
    }
    return n;
  }
  function statusValido(valor) {
    const s = String(valor || "ativo").trim().toLowerCase();
    if (!STATUS.includes(s)) throw new Error("O status deve ser 'ativo' ou 'concluido'.");
    return s;
  }
  function dataValida(valor, campo) {
    if (valor == null || valor === "") return hoje();
    const t = String(valor);
    const ok = /^\d{4}-\d{2}-\d{2}$/.test(t) && !isNaN(new Date(t + "T12:00:00"));
    if (!ok) throw new Error(`O campo '${campo}' deve estar no formato AAAA-MM-DD.`);
    return t;
  }
  const semAcento = t => String(t).normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase();

  // ---------- ordenações (iguais às dos DAOs) ----------
  const maisRecentePrimeiro = (campoData, campoId) => (a, b) =>
    b[campoData].localeCompare(a[campoData]) || b[campoId] - a[campoId];

  // ---------- respostas ----------
  const resposta = (status, dados) => ({ status, dados });
  const erro = (status, mensagem) => resposta(status, { erro: mensagem });
  const naoEncontrado = entidade => erro(404, `${entidade} não encontrado(a).`);
  const achar = (lista, campo, valor) => lista.find(x => x[campo] === valor);

  // ---------- rotas ----------
  function tratar(caminho, metodo, corpo) {
    const [rota, consulta = ""] = caminho.split("?");
    const q = new URLSearchParams(consulta);
    let m;

    // ----- projetos
    if (rota === "/projetos") {
      if (metodo === "GET") {
        const status = q.get("status");
        if (status && !STATUS.includes(status.trim().toLowerCase())) throw new Error("O status deve ser 'ativo' ou 'concluido'.");
        return resposta(200, db.projetos
          .filter(p => !status || p.status === status.trim().toLowerCase())
          .sort(maisRecentePrimeiro("data_criacao", "id_projeto")));
      }
      if (metodo === "POST") {
        const projeto = {
          id_projeto: db.prox.projeto,
          nome: obrigatorio(corpo.nome, "nome", 100),
          descricao: opcional(corpo.descricao, "descricao", 255),
          status: statusValido(corpo.status),
          data_criacao: hoje(),
        };
        db.prox.projeto += 1;
        db.projetos.push(projeto);
        salvar();
        return resposta(201, { id_projeto: projeto.id_projeto, mensagem: "Projeto criado com sucesso!" });
      }
    }

    if ((m = rota.match(/^\/projetos\/(\d+)$/))) {
      const projeto = achar(db.projetos, "id_projeto", Number(m[1]));
      if (!projeto) return naoEncontrado("Projeto");
      if (metodo === "GET") return resposta(200, projeto);
      if (metodo === "PUT") {
        const novo = {
          nome: obrigatorio(corpo.nome ?? projeto.nome, "nome", 100),
          descricao: opcional(corpo.descricao ?? projeto.descricao, "descricao", 255),
          status: statusValido(corpo.status ?? projeto.status),
        };
        Object.assign(projeto, novo);
        salvar();
        return resposta(200, { mensagem: "Projeto atualizado!" });
      }
      if (metodo === "DELETE") {
        db.projetos = db.projetos.filter(p => p !== projeto);
        db.utiliza = db.utiliza.filter(u => u.id_projeto !== projeto.id_projeto);   // ON DELETE CASCADE
        salvar();
        return resposta(200, { mensagem: "Projeto removido!" });
      }
    }

    if ((m = rota.match(/^\/projetos\/(\d+)\/prompts$/))) {
      const idProjeto = Number(m[1]);
      if (!achar(db.projetos, "id_projeto", idProjeto)) return naoEncontrado("Projeto");
      if (metodo === "GET") {
        return resposta(200, db.utiliza
          .filter(u => u.id_projeto === idProjeto)
          .sort(maisRecentePrimeiro("data_uso", "id_utiliza"))
          .map(u => {
            const p = achar(db.prompts, "id_prompt", u.id_prompt);
            return { ...u, titulo: p.titulo, texto: p.texto };
          }));
      }
      if (metodo === "POST") {
        const idPrompt = inteiro(corpo.id_prompt, "id_prompt");
        if (!achar(db.prompts, "id_prompt", idPrompt)) return naoEncontrado("Prompt");
        const uso = { id_utiliza: db.prox.utiliza, id_projeto: idProjeto, id_prompt: idPrompt, data_uso: dataValida(corpo.data_uso, "data_uso") };
        db.prox.utiliza += 1;
        db.utiliza.push(uso);
        salvar();
        return resposta(201, { id_utiliza: uso.id_utiliza, mensagem: "Prompt adicionado ao projeto!" });
      }
    }

    // ----- prompts
    if (rota === "/prompts") {
      if (metodo === "GET") {
        const busca = (q.get("busca") || "").trim();
        let lista = db.prompts
          .filter(p => !busca || semAcento(p.titulo).includes(semAcento(busca)))
          .sort(maisRecentePrimeiro("data_criacao", "id_prompt"));
        if (q.get("recentes")) {
          const limite = inteiro(q.get("recentes"), "recentes");
          if (limite < 1) throw new Error("O campo 'recentes' deve ser maior que zero.");
          lista = lista.slice(0, limite);
        }
        return resposta(200, lista);
      }
      if (metodo === "POST") {
        const prompt = {
          id_prompt: db.prox.prompt,
          titulo: obrigatorio(corpo.titulo, "titulo", 150),
          texto: obrigatorio(corpo.texto, "texto", 1000),
          data_criacao: hoje(),
        };
        const temProjeto = corpo.id_projeto !== undefined && corpo.id_projeto !== null && corpo.id_projeto !== "";
        const idProjeto = temProjeto ? inteiro(corpo.id_projeto, "id_projeto") : null;
        if (temProjeto && !achar(db.projetos, "id_projeto", idProjeto)) return naoEncontrado("Projeto");
        db.prox.prompt += 1;
        db.prompts.push(prompt);
        if (temProjeto) {
          db.utiliza.push({ id_utiliza: db.prox.utiliza, id_projeto: idProjeto, id_prompt: prompt.id_prompt, data_uso: hoje() });
          db.prox.utiliza += 1;
        }
        salvar();
        return resposta(201, { id_prompt: prompt.id_prompt, mensagem: "Prompt criado com sucesso!" });
      }
    }

    if ((m = rota.match(/^\/prompts\/(\d+)$/))) {
      const prompt = achar(db.prompts, "id_prompt", Number(m[1]));
      if (!prompt) return naoEncontrado("Prompt");
      if (metodo === "GET") return resposta(200, prompt);
      if (metodo === "PUT") {
        const novo = {
          titulo: obrigatorio(corpo.titulo ?? prompt.titulo, "titulo", 150),
          texto: obrigatorio(corpo.texto ?? prompt.texto, "texto", 1000),
        };
        Object.assign(prompt, novo);
        salvar();
        return resposta(200, { mensagem: "Prompt atualizado!" });
      }
      if (metodo === "DELETE") {
        db.prompts = db.prompts.filter(p => p !== prompt);
        db.utiliza = db.utiliza.filter(u => u.id_prompt !== prompt.id_prompt);       // ON DELETE CASCADE
        salvar();
        return resposta(200, { mensagem: "Prompt removido!" });
      }
    }

    // ----- utiliza (vínculo projeto-prompt)
    if (rota === "/utiliza") {
      if (metodo === "GET") return resposta(200, [...db.utiliza].sort(maisRecentePrimeiro("data_uso", "id_utiliza")));
      if (metodo === "POST") {
        const uso = {
          id_utiliza: db.prox.utiliza,
          id_projeto: inteiro(corpo.id_projeto, "id_projeto"),
          id_prompt: inteiro(corpo.id_prompt, "id_prompt"),
          data_uso: dataValida(corpo.data_uso, "data_uso"),
        };
        if (!achar(db.projetos, "id_projeto", uso.id_projeto)) return naoEncontrado("Projeto");
        if (!achar(db.prompts, "id_prompt", uso.id_prompt)) return naoEncontrado("Prompt");
        db.prox.utiliza += 1;
        db.utiliza.push(uso);
        salvar();
        return resposta(201, { id_utiliza: uso.id_utiliza, mensagem: "Vínculo criado com sucesso!" });
      }
    }

    if ((m = rota.match(/^\/utiliza\/(\d+)$/))) {
      const uso = achar(db.utiliza, "id_utiliza", Number(m[1]));
      if (!uso) return naoEncontrado("Vínculo");
      if (metodo === "GET") return resposta(200, uso);
      if (metodo === "DELETE") {
        db.utiliza = db.utiliza.filter(u => u !== uso);
        salvar();
        return resposta(200, { mensagem: "Vínculo removido!" });
      }
    }

    return erro(404, "Rota não encontrada no modo demonstração.");
  }

  // Ponto de entrada usado pelo api.js
  window.demoApi = function (caminho, metodo, corpo) {
    try {
      return tratar(caminho, metodo, corpo || {});
    } catch (e) {
      return erro(400, e.message);       // igual ao errorhandler(ValueError) do app.py
    }
  };

  // Volta aos dados de exemplo (botão da faixa de demonstração)
  window.demoApi.restaurar = function () {
    db = semente();
    salvar();
  };
})();
