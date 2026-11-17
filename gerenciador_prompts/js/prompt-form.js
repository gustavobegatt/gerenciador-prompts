// ===== Formulário de prompt: novo (POST) ou editar (PUT) =====
// prompt-form.html            -> novo prompt
// prompt-form.html?id=3       -> editar o prompt 3
// prompt-form.html?projeto=2  -> novo prompt já com o projeto 2 escolhido

const idPrompt = parametroUrl("id");
const form = document.getElementById("form-prompt");
const campoTitulo = document.getElementById("titulo");
const campoTexto = document.getElementById("texto");
const campoProjeto = document.getElementById("projeto");
const contador = document.getElementById("contador");
const botaoSalvar = document.getElementById("btn-salvar");

function atualizarContador() {
  contador.textContent = campoTexto.value.length + "/1000";
}

async function iniciar() {
  atualizarContador();

  if (idPrompt) {
    // Modo edição: o vínculo com projeto não se altera aqui
    document.getElementById("titulo-pagina").textContent = "Editar prompt";
    document.getElementById("migalha-atual").textContent = "Editar prompt";
    document.title = "Editar prompt — Gerenciador de Prompts";
    document.getElementById("grupo-projeto").hidden = true;
    try {
      const prompt = await api("/prompts/" + idPrompt);
      campoTitulo.value = prompt.titulo;
      campoTexto.value = prompt.texto;
      atualizarContador();
    } catch (erro) {
      mostrarMensagem(erro.message, "erro");
      botaoSalvar.disabled = true;
    }
    return;
  }

  // Modo novo: carrega os projetos para a lista "Usar em um projeto"
  try {
    const projetos = await api("/projetos");
    campoProjeto.innerHTML += projetos
      .map(p => `<option value="${p.id_projeto}">${escapeHtml(p.nome)}</option>`)
      .join("");
    const preSelecionado = parametroUrl("projeto");
    if (preSelecionado) campoProjeto.value = preSelecionado;
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
  }
}

form.addEventListener("submit", async (evento) => {
  evento.preventDefault();

  const titulo = campoTitulo.value.trim();
  const texto = campoTexto.value.trim();
  if (!titulo) { mostrarMensagem("Informe o título do prompt.", "erro"); campoTitulo.focus(); return; }
  if (!texto) { mostrarMensagem("Informe o texto do prompt.", "erro"); campoTexto.focus(); return; }

  const corpo = { titulo, texto };
  if (!idPrompt && campoProjeto.value) corpo.id_projeto = Number(campoProjeto.value);

  botaoSalvar.disabled = true;
  botaoSalvar.textContent = "Salvando...";
  try {
    if (idPrompt) {
      await api("/prompts/" + idPrompt, { method: "PUT", corpo });
      mostrarMensagem("Prompt atualizado!", "sucesso");
      irParaDepois(pagina("prompts.html"));
    } else {
      await api("/prompts", { method: "POST", corpo });
      mostrarMensagem("Prompt criado!", "sucesso");
      irParaDepois(corpo.id_projeto ? pagina("projeto.html?id=") + corpo.id_projeto : pagina("prompts.html"));
    }
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
    botaoSalvar.disabled = false;
    botaoSalvar.textContent = "Salvar";
  }
});

campoTexto.addEventListener("input", atualizarContador);
iniciar();
