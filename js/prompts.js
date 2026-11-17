// ===== Biblioteca de prompts: listar, buscar, copiar, editar e excluir =====

const grade = document.getElementById("grade-prompts");
const campoBusca = document.getElementById("busca");

let prompts = [];       // lista atual (guardada para o botão "Copiar" achar o texto)
let temporizador;       // espera o usuário parar de digitar antes de buscar
let numeroBusca = 0;    // descarta respostas antigas se o usuário digitar rápido

function cartaoPrompt(p) {
  return `
    <article class="cartao prompt">
      <h3 class="cartao__titulo">${escapeHtml(p.titulo)}</h3>
      <pre class="prompt__texto">${escapeHtml(p.texto)}</pre>
      <span class="data">Criado em ${formatarData(p.data_criacao)}</span>
      <div class="acoes">
        <button type="button" class="btn btn--primario btn--pequeno" data-acao="copiar" data-id="${p.id_prompt}">Copiar</button>
        <a class="btn btn--pequeno" href="prompt-form.html?id=${p.id_prompt}">Editar</a>
        <button type="button" class="btn btn--pequeno btn--perigo" data-acao="excluir" data-id="${p.id_prompt}">Excluir</button>
      </div>
    </article>`;
}

async function carregarPrompts() {
  const busca = campoBusca.value.trim();
  const esta = ++numeroBusca;
  try {
    const resultado = await api("/prompts" + (busca ? "?busca=" + encodeURIComponent(busca) : ""));
    if (esta !== numeroBusca) return;  // chegou uma busca mais nova, ignora esta
    prompts = resultado;
    grade.innerHTML = prompts.length
      ? prompts.map(cartaoPrompt).join("")
      : `<p class="estado">${busca ? "Nenhum prompt encontrado para essa busca." : "Nenhum prompt cadastrado ainda."}</p>`;
  } catch (erro) {
    if (esta !== numeroBusca) return;
    grade.innerHTML = `<p class="estado estado--erro">${escapeHtml(erro.message)}</p>`;
  }
}

async function excluirPrompt(prompt) {
  const ok = confirm(`Excluir o prompt "${prompt.titulo}"?\nEle também será removido dos projetos que o usam.`);
  if (!ok) return;
  try {
    await api("/prompts/" + prompt.id_prompt, { method: "DELETE" });
    mostrarMensagem("Prompt excluído.", "sucesso");
    carregarPrompts();
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
  }
}

// Um único "ouvinte" para todos os botões dos cartões
grade.addEventListener("click", (evento) => {
  const botao = evento.target.closest("button[data-acao]");
  if (!botao) return;
  const prompt = prompts.find(p => p.id_prompt === Number(botao.dataset.id));
  if (!prompt) return;
  if (botao.dataset.acao === "copiar") copiarTexto(prompt.texto);
  if (botao.dataset.acao === "excluir") excluirPrompt(prompt);
});

campoBusca.addEventListener("input", () => {
  clearTimeout(temporizador);
  temporizador = setTimeout(carregarPrompts, 300);
});

carregarPrompts();
