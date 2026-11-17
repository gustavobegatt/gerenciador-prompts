// ===== Formulário de projeto: novo (POST) ou editar (PUT) =====
// projeto-form.html       -> novo projeto
// projeto-form.html?id=3  -> editar o projeto 3

const idProjeto = parametroUrl("id");
const form = document.getElementById("form-projeto");
const campoNome = document.getElementById("nome");
const campoDescricao = document.getElementById("descricao");
const campoStatus = document.getElementById("status");
const contador = document.getElementById("contador");
const botaoSalvar = document.getElementById("btn-salvar");

function atualizarContador() {
  contador.textContent = campoDescricao.value.length + "/255";
}

async function iniciar() {
  atualizarContador();
  if (!idProjeto) return;

  document.getElementById("titulo-pagina").textContent = "Editar projeto";
  document.getElementById("migalha-atual").textContent = "Editar projeto";
  document.title = "Editar projeto — Gerenciador de Prompts";
  document.getElementById("btn-cancelar").href = pagina("projeto.html?id=") + idProjeto;
  try {
    const projeto = await api("/projetos/" + idProjeto);
    campoNome.value = projeto.nome;
    campoDescricao.value = projeto.descricao;
    campoStatus.value = projeto.status;
    atualizarContador();
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
    botaoSalvar.disabled = true;
  }
}

form.addEventListener("submit", async (evento) => {
  evento.preventDefault();

  const nome = campoNome.value.trim();
  if (!nome) { mostrarMensagem("Informe o nome do projeto.", "erro"); campoNome.focus(); return; }

  const corpo = { nome, descricao: campoDescricao.value.trim(), status: campoStatus.value };

  botaoSalvar.disabled = true;
  botaoSalvar.textContent = "Salvando...";
  try {
    if (idProjeto) {
      await api("/projetos/" + idProjeto, { method: "PUT", corpo });
      mostrarMensagem("Projeto atualizado!", "sucesso");
      irParaDepois(pagina("projeto.html?id=") + idProjeto);
    } else {
      const resposta = await api("/projetos", { method: "POST", corpo });
      mostrarMensagem("Projeto criado!", "sucesso");
      irParaDepois(pagina("projeto.html?id=") + resposta.id_projeto);
    }
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
    botaoSalvar.disabled = false;
    botaoSalvar.textContent = "Salvar";
  }
});

campoDescricao.addEventListener("input", atualizarContador);
iniciar();
