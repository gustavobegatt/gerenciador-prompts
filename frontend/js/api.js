// ===== Funções compartilhadas por todas as páginas =====

// Endereço da API Flask (python app.py)
const API_URL = "http://127.0.0.1:5000";

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
