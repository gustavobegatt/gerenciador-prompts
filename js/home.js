// ===== Início: indicadores, gráficos, quadro de projetos e prompts recentes =====
// Os gráficos são desenhados com SVG/HTML puro (sem biblioteca) a partir dos
// dados que a própria API já devolve: /projetos, /prompts e /utiliza.

const filtroStatus = document.getElementById("filtro-status");
const MESES_CURTOS = ["jan", "fev", "mar", "abr", "mai", "jun", "jul", "ago", "set", "out", "nov", "dez"];

// ---------- quadro de projetos ----------
function cartaoProjeto(p) {
  return `
    <a class="cartao cartao--${escapeHtml(p.status)}" href="projeto.html?id=${p.id_projeto}">
      <h3 class="cartao__titulo">${escapeHtml(p.nome)}</h3>
      <p class="cartao__texto">${escapeHtml(p.descricao) || "Sem descrição."}</p>
      <div class="cartao__rodape">
        <span class="selo selo--${escapeHtml(p.status)}">${escapeHtml(p.status)}</span>
        <span class="data">${formatarData(p.data_criacao)}</span>
      </div>
    </a>`;
}

function cartaoPromptRecente(p) {
  const previa = p.texto.length > 70 ? p.texto.slice(0, 70) + "…" : p.texto;
  return `
    <a class="cartao" href="prompts.html">
      <h3 class="cartao__titulo">${escapeHtml(p.titulo)}</h3>
      <p class="cartao__texto" style="margin:0">${escapeHtml(previa)}</p>
    </a>`;
}

function preencherColuna(status, projetos) {
  document.getElementById("qtd-" + status).textContent = projetos.length;
  document.getElementById("lista-" + status).innerHTML = projetos.length
    ? projetos.map(cartaoProjeto).join("")
    : '<p class="estado">Nenhum projeto aqui ainda.</p>';
}

async function carregarProjetos() {
  const status = filtroStatus.value;
  try {
    const projetos = await api("/projetos" + (status ? "?status=" + status : ""));
    preencherColuna("ativo", projetos.filter(p => p.status === "ativo"));
    preencherColuna("concluido", projetos.filter(p => p.status === "concluido"));
    // Com filtro, mostra só a coluna escolhida
    document.getElementById("coluna-ativo").hidden = status === "concluido";
    document.getElementById("coluna-concluido").hidden = status === "ativo";
  } catch (erro) {
    for (const s of ["ativo", "concluido"]) {
      document.getElementById("lista-" + s).innerHTML =
        `<p class="estado estado--erro">${escapeHtml(erro.message)}</p>`;
    }
  }
}

async function carregarRecentes() {
  const lista = document.getElementById("lista-recentes");
  try {
    const prompts = await api("/prompts?recentes=5");
    lista.innerHTML = prompts.length
      ? prompts.map(cartaoPromptRecente).join("")
      : '<p class="estado">Nenhum prompt cadastrado.</p>';
  } catch (erro) {
    lista.innerHTML = `<p class="estado estado--erro">${escapeHtml(erro.message)}</p>`;
  }
}

// ---------- gráfico 1: rosca com projetos ativos x concluídos ----------
function graficoStatus(ativos, concluidos) {
  const total = ativos + concluidos;
  if (!total) return '<p class="estado">Nenhum projeto cadastrado.</p>';

  const raio = 56;
  const circ = 2 * Math.PI * raio;
  const arcoAtivo = (ativos / total) * circ;
  const arcoConcluido = (concluidos / total) * circ;
  const percentual = Math.round((concluidos / total) * 100);

  return `
    <div class="donut-area">
      <svg class="donut" viewBox="0 0 140 140" role="img" aria-label="${percentual}% dos projetos estão concluídos">
        <g transform="rotate(-90 70 70)">
          <circle class="arco trilho" cx="70" cy="70" r="${raio}"/>
          <circle class="arco arco--ativo" cx="70" cy="70" r="${raio}"
                  stroke-dasharray="${arcoAtivo} ${circ - arcoAtivo}" stroke-dashoffset="0"/>
          <circle class="arco arco--concluido" cx="70" cy="70" r="${raio}"
                  stroke-dasharray="${arcoConcluido} ${circ - arcoConcluido}" stroke-dashoffset="${-arcoAtivo}"/>
        </g>
        <text class="donut-numero" x="70" y="76">${percentual}%</text>
        <text class="donut-rotulo" x="70" y="92">concluídos</text>
      </svg>
      <ul class="legenda">
        <li><span class="ponto ponto--ativo"></span>Ativos <strong>${ativos}</strong></li>
        <li><span class="ponto ponto--concluido"></span>Concluídos <strong>${concluidos}</strong></li>
      </ul>
    </div>`;
}

// ---------- gráfico 2: barras com projetos criados por mês (últimos 6), por status ----------
function graficoMeses(projetos) {
  if (!projetos.length) return '<p class="estado">Nenhum projeto cadastrado.</p>';

  // últimos 6 meses, do mais antigo para o atual
  const agora = new Date();
  const meses = [];
  for (let i = 5; i >= 0; i--) {
    const d = new Date(agora.getFullYear(), agora.getMonth() - i, 1);
    meses.push({ chave: dataParaISO(d).slice(0, 7), nome: MESES_CURTOS[d.getMonth()], ativo: 0, concluido: 0 });
  }
  projetos.forEach(p => {
    const mes = meses.find(m => m.chave === String(p.data_criacao).slice(0, 7));
    if (mes) mes[p.status] += 1;
  });

  const maior = Math.max(2, ...meses.map(m => Math.max(m.ativo, m.concluido)));
  const L = 360, A = 190, esq = 26, topo = 14, base = 26;     // medidas do desenho
  const alturaUtil = A - topo - base;
  const largGrupo = (L - esq - 6) / meses.length;
  const y = valor => topo + alturaUtil - (valor / maior) * alturaUtil;

  const marcas = [...new Set([0, Math.round(maior / 2), maior])];
  const grade = marcas.map(v => `
    <line class="linha" x1="${esq}" x2="${L - 6}" y1="${y(v)}" y2="${y(v)}"/>
    <text class="eixo" x="${esq - 6}" y="${y(v) + 3}" text-anchor="end">${v}</text>`).join("");

  const barras = meses.map((m, i) => {
    const centro = esq + largGrupo * i + largGrupo / 2;
    const desenhar = (valor, classe, deslocamento) => valor
      ? `<rect class="${classe}" x="${centro + deslocamento}" y="${y(valor)}" width="16" height="${(valor / maior) * alturaUtil}" rx="2"><title>${m.nome}: ${valor}</title></rect>
         <text class="eixo" x="${centro + deslocamento + 8}" y="${y(valor) - 4}" text-anchor="middle">${valor}</text>`
      : "";
    return desenhar(m.ativo, "barra--ativo", -18) + desenhar(m.concluido, "barra--concluido", 2) +
      `<text class="eixo" x="${centro}" y="${A - 8}" text-anchor="middle">${m.nome}</text>`;
  }).join("");

  return `
    <svg class="barras" viewBox="0 0 ${L} ${A}" role="img" aria-label="Projetos criados por mês, separados por status">${grade}${barras}</svg>
    <div class="barras-legenda">
      <span><i class="ponto ponto--ativo"></i>Ativos</span>
      <span><i class="ponto ponto--concluido"></i>Concluídos</span>
    </div>`;
}

// ---------- gráfico 3: ranking dos prompts mais usados em projetos ----------
function graficoRanking(prompts, vinculos) {
  const linhas = prompts
    .map(p => ({ titulo: p.titulo, usos: vinculos.filter(v => v.id_prompt === p.id_prompt).length }))
    .filter(l => l.usos > 0)
    .sort((a, b) => b.usos - a.usos)
    .slice(0, 5);
  if (!linhas.length) return '<p class="estado">Nenhum uso registrado ainda.</p>';

  const maior = linhas[0].usos;
  return `<ul class="rank">${linhas.map(l => `
    <li>
      <div class="rank__linha">
        <span class="rank__nome" title="${escapeHtml(l.titulo)}">${escapeHtml(l.titulo)}</span>
        <span class="rank__valor">${l.usos} ${l.usos === 1 ? "uso" : "usos"}</span>
      </div>
      <div class="rank__barra"><i style="width:${(l.usos / maior) * 100}%"></i></div>
    </li>`).join("")}</ul>`;
}

async function carregarResumo() {
  const areas = ["grafico-status", "grafico-meses", "grafico-ranking"];
  try {
    const [projetos, prompts, vinculos] = await Promise.all([api("/projetos"), api("/prompts"), api("/utiliza")]);
    const ativos = projetos.filter(p => p.status === "ativo").length;
    const concluidos = projetos.filter(p => p.status === "concluido").length;
    const percentual = projetos.length ? Math.round((concluidos / projetos.length) * 100) : 0;

    document.getElementById("kpi-projetos").textContent = projetos.length;
    document.getElementById("kpi-projetos-nota").textContent = ativos + (ativos === 1 ? " ativo" : " ativos");
    document.getElementById("kpi-concluidos").textContent = concluidos;
    document.getElementById("kpi-concluidos-nota").textContent = percentual + "% do total";
    document.getElementById("kpi-prompts").textContent = prompts.length;
    document.getElementById("kpi-usos").textContent = vinculos.length;

    document.getElementById("grafico-status").innerHTML = graficoStatus(ativos, concluidos);
    document.getElementById("grafico-meses").innerHTML = graficoMeses(projetos);
    document.getElementById("grafico-ranking").innerHTML = graficoRanking(prompts, vinculos);
  } catch (erro) {
    areas.forEach(id => {
      document.getElementById(id).innerHTML = `<p class="estado estado--erro">${escapeHtml(erro.message)}</p>`;
    });
  }
}

filtroStatus.addEventListener("change", carregarProjetos);
carregarResumo();
carregarProjetos();
carregarRecentes();
