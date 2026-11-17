// ===== Detalhe do projeto: dados, prompts vinculados, adicionar/remover =====
// Abre com projeto.html?id=1

const idProjeto = parametroUrl("id");
let projeto = null;
let vinculos = [];   // prompts usados neste projeto (linhas da tabela "utiliza")

const painel = document.getElementById("painel-adicionar");
const selectPrompt = document.getElementById("select-prompt");
const btnConfirmar = document.getElementById("btn-confirmar");
const corpoTabela = document.getElementById("tabela-corpo");

function mostrarErroPagina(mensagem) {
  document.getElementById("carregando").hidden = true;
  document.getElementById("conteudo").hidden = true;
  const erro = document.getElementById("erro-pagina");
  erro.innerHTML = escapeHtml(mensagem) + ' <a href="' + pagina("index.html") + '">Voltar ao início</a>';
  erro.hidden = false;
}

function mostrarProjeto() {
  document.title = projeto.nome + " — Gerenciador de Prompts";
  document.getElementById("migalha-nome").textContent = projeto.nome;
  document.getElementById("nome").textContent = projeto.nome;
  const selo = document.getElementById("status");
  selo.textContent = projeto.status;
  selo.className = "selo selo--" + projeto.status;
  document.getElementById("descricao").textContent = projeto.descricao || "Sem descrição.";
  document.getElementById("btn-editar").href = pagina("projeto-form.html?id=") + projeto.id_projeto;
  document.getElementById("link-novo-prompt").href = pagina("prompt-form.html?projeto=") + projeto.id_projeto;
  document.getElementById("carregando").hidden = true;
  document.getElementById("conteudo").hidden = false;
}

function linhaPrompt(v) {
  const previa = v.texto.length > 90 ? v.texto.slice(0, 90) + "…" : v.texto;
  return `
    <tr>
      <td><strong>${escapeHtml(v.titulo)}</strong></td>
      <td class="previa">${escapeHtml(previa)}</td>
      <td>${formatarData(v.data_uso)}</td>
      <td>
        <div class="acoes">
          <button type="button" class="btn btn--pequeno" data-acao="copiar" data-id="${v.id_utiliza}">Copiar</button>
          <button type="button" class="btn btn--pequeno btn--perigo" data-acao="remover" data-id="${v.id_utiliza}">Remover</button>
        </div>
      </td>
    </tr>`;
}

async function carregarPrompts() {
  try {
    vinculos = await api(`/projetos/${idProjeto}/prompts`);
    corpoTabela.innerHTML = vinculos.length
      ? vinculos.map(linhaPrompt).join("")
      : '<tr><td colspan="4" class="estado">Nenhum prompt neste projeto ainda. Clique em "+ Adicionar prompt".</td></tr>';
  } catch (erro) {
    corpoTabela.innerHTML = `<tr><td colspan="4" class="estado estado--erro">${escapeHtml(erro.message)}</td></tr>`;
  }
}

async function carregarProjeto() {
  if (!idProjeto) { mostrarErroPagina("Projeto não informado."); return; }
  try {
    projeto = await api("/projetos/" + idProjeto);
  } catch (erro) {
    mostrarErroPagina(erro.message);
    return;
  }
  mostrarProjeto();
  carregarPrompts();
}

// ---------- adicionar prompt ao projeto ----------
async function abrirPainel() {
  painel.hidden = false;
  document.getElementById("data-uso").value = hojeISO();  // pode trocar para agendar em outro dia
  selectPrompt.innerHTML = '<option value="">Carregando...</option>';
  btnConfirmar.disabled = true;
  try {
    const todos = await api("/prompts");
    const jaUsados = new Set(vinculos.map(v => v.id_prompt));
    const disponiveis = todos.filter(p => !jaUsados.has(p.id_prompt));
    if (!disponiveis.length) {
      selectPrompt.innerHTML = '<option value="">Todos os prompts já foram adicionados</option>';
      return;
    }
    selectPrompt.innerHTML = '<option value="">Selecione um prompt</option>' +
      disponiveis.map(p => `<option value="${p.id_prompt}">${escapeHtml(p.titulo)}</option>`).join("");
    btnConfirmar.disabled = false;
  } catch (erro) {
    selectPrompt.innerHTML = '<option value="">Erro ao carregar</option>';
    mostrarMensagem(erro.message, "erro");
  }
}

async function confirmarAdicao() {
  if (!selectPrompt.value) { mostrarMensagem("Escolha um prompt.", "erro"); return; }
  btnConfirmar.disabled = true;
  try {
    const corpo = { id_prompt: Number(selectPrompt.value) };
    const dataUso = document.getElementById("data-uso").value;
    if (dataUso) corpo.data_uso = dataUso;  // sem data, o back-end usa a data de hoje
    await api(`/projetos/${idProjeto}/prompts`, { method: "POST", corpo });
    mostrarMensagem("Prompt adicionado ao projeto!", "sucesso");
    painel.hidden = true;
    carregarPrompts();
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
    btnConfirmar.disabled = false;
  }
}

// ---------- remover prompt do projeto / excluir projeto ----------
async function removerVinculo(vinculo) {
  if (!confirm(`Remover "${vinculo.titulo}" deste projeto?\nO prompt continua na biblioteca.`)) return;
  try {
    await api("/utiliza/" + vinculo.id_utiliza, { method: "DELETE" });
    mostrarMensagem("Prompt removido do projeto.", "sucesso");
    carregarPrompts();
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
  }
}

async function excluirProjeto() {
  if (!confirm(`Excluir o projeto "${projeto.nome}"?\nOs vínculos com prompts serão removidos. Esta ação não pode ser desfeita.`)) return;
  try {
    await api("/projetos/" + idProjeto, { method: "DELETE" });
    mostrarMensagem("Projeto excluído.", "sucesso");
    irParaDepois(pagina("index.html"));
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
  }
}

corpoTabela.addEventListener("click", (evento) => {
  const botao = evento.target.closest("button[data-acao]");
  if (!botao) return;
  const vinculo = vinculos.find(v => v.id_utiliza === Number(botao.dataset.id));
  if (!vinculo) return;
  if (botao.dataset.acao === "copiar") copiarTexto(vinculo.texto);
  if (botao.dataset.acao === "remover") removerVinculo(vinculo);
});

document.getElementById("btn-adicionar").addEventListener("click", abrirPainel);
document.getElementById("btn-cancelar").addEventListener("click", () => { painel.hidden = true; });
btnConfirmar.addEventListener("click", confirmarAdicao);
document.getElementById("btn-excluir").addEventListener("click", excluirProjeto);

carregarProjeto();
