// ===== Funções compartilhadas por todas as páginas =====

// Endereço da API Flask (python app.py)
const API_URL = "http://127.0.0.1:5000";

// ----- Caminhos: index.html fica na raiz e as demais páginas ficam em pages/ -----
const NA_PASTA_PAGES = window.location.pathname.includes("/pages/");
const RAIZ = NA_PASTA_PAGES ? "../" : "";
// pagina("prompts.html") devolve o caminho certo a partir da página atual
function pagina(nome) {
  if (nome.startsWith("index.html")) return RAIZ + nome;
  return (NA_PASTA_PAGES ? "" : "pages/") + nome;
}

// ----- Modo demonstração (só no GitHub Pages) -----
// O GitHub Pages guarda apenas arquivos estáticos: não roda Python nem MySQL.
// Quando o site está em *.github.io (ou é aberto com ?demo=1), as chamadas vão
// para js/demo-api.js, que imita a API Flask guardando os dados no navegador.
// Rodando no computador (python app.py), nada disso é usado: o site fala com a API real.
function detectarModoDemo() {
  let demo = window.location.hostname.endsWith(".github.io");
  try {
    if (new URLSearchParams(window.location.search).get("demo") === "1") sessionStorage.setItem("demo", "1");
    if (sessionStorage.getItem("demo") === "1") demo = true;
  } catch (e) { /* sem sessionStorage: ignora */ }
  return demo;
}
const MODO_DEMO = detectarModoDemo();

let promessaDemo = null;
function carregarDemo() {
  if (!promessaDemo) {
    promessaDemo = new Promise((resolve, reject) => {
      const script = document.createElement("script");
      script.src = RAIZ + "js/demo-api.js";
      script.onload = resolve;
      script.onerror = () => reject(new Error("Não foi possível carregar o modo demonstração."));
      document.head.appendChild(script);
    });
  }
  return promessaDemo;
}

// Faixa de aviso no topo: deixa claro que são dados de exemplo
function mostrarFaixaDemo() {
  const area = document.querySelector(".area");
  if (!MODO_DEMO || !area) return;
  const faixa = document.createElement("div");
  faixa.className = "faixa-demo";
  faixa.innerHTML = '<span><strong>Modo demonstração.</strong> Os dados são de exemplo e ficam só neste navegador. ' +
    'A versão completa usa a API Flask e o MySQL (veja o README).</span>' +
    '<button type="button" class="btn btn--pequeno" id="demo-restaurar">Restaurar dados de exemplo</button>';
  area.insertBefore(faixa, area.firstChild);
  document.getElementById("demo-restaurar").addEventListener("click", async () => {
    await carregarDemo();
    window.demoApi.restaurar();
    window.location.reload();
  });
}

/**
 * Faz uma requisição à API e devolve o JSON.
 * Se a API responder com erro (400, 404, 500...), lança um Error
 * com a mensagem que veio do back-end.
 */
async function api(caminho, opcoes = {}) {
  const config = { ...opcoes };
  if (config.corpo !== undefined) {
    config.method = config.method || "POST";
    config.headers = { "Content-Type": "application/json" };
    config.body = JSON.stringify(config.corpo);
    delete config.corpo;
  }

  // No GitHub Pages não existe API: usa a demonstração (js/demo-api.js)
  if (MODO_DEMO) {
    await carregarDemo();
    const { status, dados } = window.demoApi(caminho, config.method || "GET", config.body ? JSON.parse(config.body) : {});
    if (status >= 400) throw new Error(dados.erro || "Erro inesperado (código " + status + ").");
    return dados;
  }

  let resposta;
  try {
    resposta = await fetch(API_URL + caminho, config);
  } catch (erro) {
    throw new Error("Não foi possível conectar à API. Verifique se o MySQL está ligado e se o 'python app.py' está rodando.");
  }

  const dados = await resposta.json().catch(() => ({}));
  if (!resposta.ok) {
    throw new Error(dados.erro || "Erro inesperado (código " + resposta.status + ").");
  }
  return dados;
}

// Evita que texto digitado pelo usuário vire HTML (segurança contra XSS)
function escapeHtml(texto) {
  return String(texto ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

// "2026-11-11" -> "11/11/2026"
function formatarData(iso) {
  if (!iso) return "";
  const [ano, mes, dia] = String(iso).split("-");
  return `${dia}/${mes}/${ano}`;
}

// Mensagem rápida no canto da tela. tipo: "sucesso" | "erro" | ""
function mostrarMensagem(texto, tipo = "") {
  const antiga = document.querySelector(".toast");
  if (antiga) antiga.remove();

  const aviso = document.createElement("div");
  aviso.className = "toast" + (tipo ? " toast--" + tipo : "");
  aviso.setAttribute("role", "status");
  aviso.textContent = texto;
  document.body.appendChild(aviso);
  setTimeout(() => aviso.remove(), 3500);
}

// Copia um texto para a área de transferência (botão "Copiar")
async function copiarTexto(texto) {
  try {
    await navigator.clipboard.writeText(texto);
    mostrarMensagem("Prompt copiado!", "sucesso");
  } catch (erro) {
    mostrarMensagem("Não foi possível copiar.", "erro");
  }
}

// ----- Tema claro/escuro (botão no cabeçalho; a escolha fica salva no navegador) -----
function aplicarTema(tema) {
  document.documentElement.dataset.tema = tema;
  try { localStorage.setItem("tema", tema); } catch (e) { /* sem armazenamento: ignora */ }
  const texto = document.querySelector(".btn-tema span");
  if (texto) texto.textContent = tema === "claro" ? "Tema escuro" : "Tema claro";
}

function criarBotaoTema() {
  const menu = document.querySelector(".menu-lateral");
  if (!menu) return;
  const botao = document.createElement("button");
  botao.type = "button";
  botao.className = "menu-item btn-tema";
  botao.innerHTML = '<svg class="icone" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 010 18z" fill="currentColor"/></svg><span></span>';
  botao.addEventListener("click", () => {
    aplicarTema(document.documentElement.dataset.tema === "claro" ? "escuro" : "claro");
  });
  menu.appendChild(botao);
  aplicarTema(document.documentElement.dataset.tema === "claro" ? "claro" : "escuro");
}
criarBotaoTema();
mostrarFaixaDemo();

// ----- Datas no horário local (toISOString usaria UTC e erraria o dia à noite) -----
function dataParaISO(data) {
  const mes = String(data.getMonth() + 1).padStart(2, "0");
  const dia = String(data.getDate()).padStart(2, "0");
  return `${data.getFullYear()}-${mes}-${dia}`;
}

function hojeISO() {
  return dataParaISO(new Date());
}

// Lê um parâmetro da URL: projeto.html?id=3  ->  parametroUrl("id") devolve "3"
function parametroUrl(nome) {
  return new URLSearchParams(window.location.search).get(nome);
}

// Vai para outra página depois de um instante (dá tempo de ler a mensagem)
function irParaDepois(url, ms = 800) {
  setTimeout(() => { window.location.href = url; }, ms);
}
