// ===== Calendário: mostra, em cada dia, o que foi usado ou criado =====
// Fontes (todas já existem na API):
//   utiliza.data_uso       -> "prompt usado" em um projeto
//   projeto.data_criacao   -> "projeto criado"
//   prompt.data_criacao    -> "prompt criado"
// Ao registrar um uso em um dia, o back-end grava a data_uso e o calendário
// recarrega os dados: o item passa a aparecer naquele dia.

const MESES = ["janeiro", "fevereiro", "março", "abril", "maio", "junho",
               "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"];
const DIAS_SEMANA = ["domingo", "segunda-feira", "terça-feira", "quarta-feira",
                     "quinta-feira", "sexta-feira", "sábado"];
const TIPOS = { uso: "Prompt usado", projeto: "Projeto criado", prompt: "Prompt criado" };
const PLURAL = { uso: "Prompts usados", projeto: "Projetos criados", prompt: "Prompts criados" };
const ORDEM = ["uso", "projeto", "prompt"];
const MAX_POR_DIA = 3;

const hoje = hojeISO();
let ano = Number(hoje.slice(0, 4));
let mes = Number(hoje.slice(5, 7)) - 1;   // 0 a 11
let selecionado = hoje;

let projetos = [];
let prompts = [];
let eventos = {};                                        // { "2026-11-16": [ {tipo, titulo, sub, href} ] }
const visiveis = { uso: true, projeto: true, prompt: true };   // filtros marcados

const grade = document.getElementById("cal-grade");
const formDia = document.getElementById("form-dia");
const selectProjeto = document.getElementById("dia-projeto");
const selectPrompt = document.getElementById("dia-prompt");
const botaoAdicionar = document.getElementById("dia-adicionar");

// ---------- dados ----------
function adicionarEvento(data, evento) {
  if (!eventos[data]) eventos[data] = [];
  eventos[data].push(evento);
}

function montarEventos(vinculos) {
  eventos = {};
  vinculos.forEach(v => {
    const prompt = prompts.find(p => p.id_prompt === v.id_prompt);
    const projeto = projetos.find(p => p.id_projeto === v.id_projeto);
    if (!prompt || !projeto) return;
    adicionarEvento(v.data_uso, {
      tipo: "uso", titulo: prompt.titulo, sub: "em " + projeto.nome,
      href: pagina("projeto.html?id=") + projeto.id_projeto,
    });
  });
  projetos.forEach(p => adicionarEvento(p.data_criacao, {
    tipo: "projeto", titulo: p.nome, sub: "Projeto criado", href: pagina("projeto.html?id=") + p.id_projeto,
  }));
  prompts.forEach(p => adicionarEvento(p.data_criacao, {
    tipo: "prompt", titulo: p.titulo, sub: "Prompt criado", href: pagina("prompts.html"),
  }));
  Object.values(eventos).forEach(lista => lista.sort((a, b) => ORDEM.indexOf(a.tipo) - ORDEM.indexOf(b.tipo)));
}

// eventos de um dia, já respeitando os filtros marcados
function eventosDoDia(iso) {
  return (eventos[iso] || []).filter(e => visiveis[e.tipo]);
}

async function carregar() {
  try {
    const [listaProjetos, listaPrompts, vinculos] = await Promise.all([api("/projetos"), api("/prompts"), api("/utiliza")]);
    projetos = listaProjetos;
    prompts = listaPrompts;
    montarEventos(vinculos);
    preencherSelects();
    desenhar();
  } catch (erro) {
    grade.innerHTML = `<p class="estado estado--erro">${escapeHtml(erro.message)}</p>`;
  }
}

function preencherSelects() {
  const projetoAtual = selectProjeto.value;
  const promptAtual = selectPrompt.value;
  selectProjeto.innerHTML = '<option value="">Escolha o projeto</option>' +
    projetos.map(p => `<option value="${p.id_projeto}">${escapeHtml(p.nome)}</option>`).join("");
  selectPrompt.innerHTML = '<option value="">Escolha o prompt</option>' +
    prompts.map(p => `<option value="${p.id_prompt}">${escapeHtml(p.titulo)}</option>`).join("");
  selectProjeto.value = projetoAtual;
  selectPrompt.value = promptAtual;
}

// ---------- mês ----------
function desenharMes() {
  document.getElementById("cal-titulo").textContent = `${MESES[mes][0].toUpperCase()}${MESES[mes].slice(1)} de ${ano}`;

  const deslocamento = new Date(ano, mes, 1).getDay();            // 0 = domingo
  const diasNoMes = new Date(ano, mes + 1, 0).getDate();
  const totalCelulas = Math.ceil((deslocamento + diasNoMes) / 7) * 7;

  let html = "";
  for (let i = 0; i < totalCelulas; i++) {
    const data = new Date(ano, mes, 1 - deslocamento + i);
    const iso = dataParaISO(data);
    const lista = eventosDoDia(iso);
    const classes = ["cal-dia"];
    if (data.getMonth() !== mes) classes.push("cal-dia--fora");
    if (iso === hoje) classes.push("cal-dia--hoje");
    if (iso === selecionado) classes.push("cal-dia--sel");

    const itens = lista.slice(0, MAX_POR_DIA)
      .map(e => `<span class="cal-evento ev--${e.tipo}" title="${escapeHtml(TIPOS[e.tipo] + ": " + e.titulo)}">${escapeHtml(e.titulo)}</span>`).join("");
    const mais = lista.length > MAX_POR_DIA ? `<span class="cal-mais">+${lista.length - MAX_POR_DIA} mais</span>` : "";

    html += `
      <button type="button" class="${classes.join(" ")}" data-data="${iso}" aria-pressed="${iso === selecionado}"
              aria-label="${data.getDate()} de ${MESES[data.getMonth()]}, ${lista.length} item(ns)">
        <span class="cal-num">${data.getDate()}</span>
        <span class="cal-eventos">${itens}${mais}</span>
      </button>`;
  }
  grade.innerHTML = html;
}

// ---------- painel do dia ----------
function desenharDia() {
  const [a, m, d] = selecionado.split("-").map(Number);
  const dataSel = new Date(a, m - 1, d);
  document.getElementById("dia-titulo").textContent =
    `${DIAS_SEMANA[dataSel.getDay()]}, ${d} de ${MESES[m - 1]}` + (selecionado === hoje ? " (hoje)" : "");
  botaoAdicionar.textContent = "Adicionar em " + formatarData(selecionado);

  const lista = eventosDoDia(selecionado);
  document.getElementById("dia-eventos").innerHTML = lista.length
    ? lista.map(e => `
        <li class="evento-item ev--${e.tipo}">
          <div><strong>${escapeHtml(e.titulo)}</strong><span>${TIPOS[e.tipo]} · ${escapeHtml(e.sub)}</span></div>
          <a class="btn btn--pequeno" href="${e.href}">Abrir</a>
        </li>`).join("")
    : '<li class="estado">Nada registrado neste dia.</li>';
}

// ---------- resumo do mês visível ----------
function desenharResumo() {
  const prefixo = `${ano}-${String(mes + 1).padStart(2, "0")}`;
  const contagem = { uso: 0, projeto: 0, prompt: 0 };
  Object.entries(eventos).forEach(([data, lista]) => {
    if (data.startsWith(prefixo)) lista.forEach(e => { contagem[e.tipo] += 1; });
  });
  const maior = Math.max(1, ...Object.values(contagem));

  document.getElementById("resumo-titulo").textContent = `Resumo de ${MESES[mes]}`;
  document.getElementById("resumo-mes").innerHTML = ORDEM.map(tipo => `
    <div class="resumo-linha ev--${tipo}">
      <div><span>${PLURAL[tipo]}</span><strong>${contagem[tipo]}</strong></div>
      <div class="rank__barra"><i style="width:${(contagem[tipo] / maior) * 100}%"></i></div>
    </div>`).join("");
}

function desenhar() {
  desenharMes();
  desenharDia();
  desenharResumo();
}

function selecionarDia(iso) {
  selecionado = iso;
  ano = Number(iso.slice(0, 4));          // se clicou num dia de outro mês, vai para esse mês
  mes = Number(iso.slice(5, 7)) - 1;
  desenhar();
}

function mudarMes(delta) {
  const novo = new Date(ano, mes + delta, 1);
  ano = novo.getFullYear();
  mes = novo.getMonth();
  const doMes = `${ano}-${String(mes + 1).padStart(2, "0")}`;
  selecionado = hoje.startsWith(doMes) ? hoje : doMes + "-01";
  desenhar();
}

// ---------- registrar um uso de prompt no dia selecionado ----------
formDia.addEventListener("submit", async (evento) => {
  evento.preventDefault();
  if (!selectProjeto.value || !selectPrompt.value) {
    mostrarMensagem("Escolha o projeto e o prompt.", "erro");
    return;
  }
  botaoAdicionar.disabled = true;
  try {
    await api(`/projetos/${selectProjeto.value}/prompts`, {
      method: "POST",
      corpo: { id_prompt: Number(selectPrompt.value), data_uso: selecionado },
    });
    mostrarMensagem("Adicionado em " + formatarData(selecionado) + ".", "sucesso");
    selectPrompt.value = "";
    await carregar();
  } catch (erro) {
    mostrarMensagem(erro.message, "erro");
  } finally {
    botaoAdicionar.disabled = false;
  }
});

grade.addEventListener("click", (evento) => {
  const celula = evento.target.closest("button[data-data]");
  if (celula) selecionarDia(celula.dataset.data);
});
document.querySelectorAll(".filtro input").forEach(caixa => {
  caixa.addEventListener("change", () => {
    visiveis[caixa.dataset.tipo] = caixa.checked;
    desenhar();
  });
});
document.getElementById("cal-anterior").addEventListener("click", () => mudarMes(-1));
document.getElementById("cal-proximo").addEventListener("click", () => mudarMes(1));
document.getElementById("cal-hoje").addEventListener("click", () => selecionarDia(hoje));

carregar();
