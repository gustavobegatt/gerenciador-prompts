-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 07/11/2026 às 17:55
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `casadecriadores`
--
CREATE DATABASE IF NOT EXISTS `casadecriadores` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `casadecriadores`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `profissionais`
--

CREATE TABLE `profissionais` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profissionais`
--

INSERT INTO `profissionais` (`id`, `nome`, `cargo`, `email`) VALUES
(1, 'Alexandre Herchcovitch', 'Designers', 'alexandre@email.com'),
(2, 'Camila Yahn', 'Jornalistas', 'camila@email.com'),
(3, 'Leo Faria', 'Fotografos', 'leo@email.com'),
(5, 'Gustavo Begatti', 'Jornalistas', 'begattiferreiragustavo@gmail.com');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `profissionais`
--
ALTER TABLE `profissionais`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `profissionais`
--
ALTER TABLE `profissionais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Banco de dados: `datapro`
--
CREATE DATABASE IF NOT EXISTS `datapro` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `datapro`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `activities`
--

CREATE TABLE `activities` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `project_id` char(36) DEFAULT NULL,
  `action` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `activities`
--

INSERT INTO `activities` (`id`, `user_id`, `project_id`, `action`, `description`, `created_at`) VALUES
('1d75ca88-ad5f-4d43-88f6-f4379a873800', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'dashboard_updated', 'Atualizou o dashboard \"Dashboard principal\".', '2026-11-01 19:32:02'),
('241f3ead-5b55-477e-a4d2-e7fd5cb0049a', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-10-31 14:30:22'),
('245ff657-c377-41e7-aa8c-c9dcd2ce28cc', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'kpi_created', 'Criou o indicador \"Receita total\".', '2026-11-01 19:30:49'),
('2932cfc0-0d64-4722-a6b6-2cf448e72415', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'dataset_uploaded', 'Importou \"datapro-demo.json\" (4 linhas).', '2026-11-01 19:33:19'),
('29a5b04e-accb-46cc-8353-fa979d33bbf3', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'dataset_uploaded', 'Importou \"datapro-test.csv\" (6 linhas).', '2026-10-31 14:31:36'),
('2b8def9d-b134-4357-bbbb-10340a0f9023', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'dataset_uploaded', 'Importou \"datapro-demo.csv\" (12 linhas).', '2026-11-01 19:30:40'),
('3149f77a-aab3-4281-a7ff-962077672c3d', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-11-01 19:29:30'),
('31dc912d-5a78-4ed6-a290-b8bbf40a8fe6', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-10-31 21:05:07'),
('34c466b7-326a-4a44-92cf-303338b50ec6', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_deleted', 'Excluiu o projeto \"Empresa ABC\".', '2026-10-31 21:44:33'),
('383c787b-8b20-410b-a878-7e876fb7025d', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'kpi_created', 'Criou o indicador \"Receita total\".', '2026-10-31 14:31:47'),
('4353a19b-3879-4cdf-804d-7c957c84bb97', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_deleted', 'Excluiu o projeto \"Empresa ABC\".', '2026-10-31 21:44:40'),
('46b52577-7fd4-4903-80e3-1fc09bce3f69', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'project_created', 'Criou o projeto \"Projeto de demonstração\".', '2026-11-01 19:30:34'),
('495954cf-4e54-4ca0-a2fa-1ad882963987', 'd92baa21-d4cf-4ffd-b530-d0f700c43a0d', NULL, 'account_created', 'Criou sua conta no DataPro.', '2026-11-02 03:20:30'),
('5ca5f539-6ab8-469f-903c-b11bedadbafb', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'share_revoked', 'Revogou um link público.', '2026-11-01 19:38:37'),
('5f10a868-e848-4782-9aee-415754c4ee85', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_created', 'Criou o projeto \"Empresa ABC\".', '2026-10-31 14:31:29'),
('700e6487-741f-47eb-b825-5e42578d3caf', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'share_created', 'Criou um link público para o dashboard \"Dashboard principal\".', '2026-11-01 19:32:34'),
('716d82a0-c5bf-4a3d-bb99-f739405e2dd9', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'share_created', 'Criou um link público para o dashboard \"Dashboard de vendas\".', '2026-10-31 14:32:18'),
('7604017b-c484-4048-8806-cacfa56e172a', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_created', 'Criou o projeto \"Empresa ABC\".', '2026-10-31 14:30:55'),
('7efda97e-1cae-4ac9-8bc3-6185aaf0fea1', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-10-31 14:31:22'),
('81569a4a-5fab-458e-b69f-b60b1eba98e4', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_created', 'Criou o projeto \"Empresa ABC\".', '2026-10-31 14:31:10'),
('8ca9a483-b540-4585-8189-49f25fda23e1', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'dataset_updated', 'Atualizou as colunas de \"datapro-demo.xlsx\".', '2026-11-01 19:34:46'),
('8db99910-fafb-4882-bcbb-b746aedb6814', 'd92baa21-d4cf-4ffd-b530-d0f700c43a0d', NULL, 'project_created', 'Criou o projeto \"Análise Empresa\".', '2026-11-02 03:21:37'),
('9e67e6f3-9c0f-4572-9aa1-cc27ee55a6b4', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-10-31 14:31:10'),
('a0de0aa2-3d78-44ee-ab1c-5354eecb354e', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-11-01 19:30:05'),
('a2e25b0a-ac1f-452b-90b3-0d7289b5eb91', 'd92baa21-d4cf-4ffd-b530-d0f700c43a0d', NULL, 'project_deleted', 'Excluiu o projeto \"Análise Empresa\".', '2026-11-02 03:23:06'),
('a4b398b4-5e8a-4d82-a03d-371a83cd63ec', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'logout', 'Encerrou a sessão.', '2026-11-01 19:36:08'),
('b9ff7d95-39d2-4e2f-a9a2-f16824135d37', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_deleted', 'Excluiu o projeto \"Empresa ABC\".', '2026-10-31 21:44:37'),
('bb58b4f8-2c69-41ef-899d-4a80d58949cf', 'f09424ac-4cb8-4a8f-9bd9-8dca923a8ce5', NULL, 'account_created', 'Criou sua conta no DataPro.', '2026-11-02 03:17:27'),
('bf89fabd-750b-4444-abd1-21841b842f78', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_deleted', 'Excluiu o projeto \"oiii\".', '2026-10-31 21:44:28'),
('c13b738b-eb40-49bf-bd0a-246938073f1e', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'project_created', 'Criou o projeto \"oiii\".', '2026-10-31 21:30:21'),
('c5a1fb2b-1a5e-4ac2-94eb-16b6945971a8', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-11-01 19:36:14'),
('d5068e15-b73a-4049-83fb-fca27bc02172', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'dashboard_created', 'Criou o dashboard \"Dashboard de vendas\".', '2026-10-31 14:31:47'),
('d69b020a-d94b-42a5-b1f2-e24009c9629f', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-10-31 14:30:43'),
('d6e326e6-5f2e-47b5-8de5-12628a3a59d8', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'chart_created', 'Criou o gráfico \"Evolução das Vendas\".', '2026-10-31 14:31:46'),
('d8c89789-04e7-4315-973e-deb34b0d41e0', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'chart_created', 'Criou o gráfico \"Receita por mês\".', '2026-11-01 19:30:49'),
('e932467a-49f5-484e-be56-c3aa686cb473', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'account_created', 'Criou sua conta no DataPro.', '2026-10-31 14:30:11'),
('efce6523-62bd-43e3-9044-00ab05840da5', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'dataset_uploaded', 'Importou \"datapro-demo.xlsx\" (5 linhas).', '2026-11-01 19:33:31'),
('f4f3b0a1-0500-4eed-b078-943471a9d800', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-10-31 14:30:55'),
('f71d56f9-57f4-4ab1-b221-70af94e6263f', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', NULL, 'login', 'Entrou na plataforma.', '2026-11-02 19:28:50'),
('ff06fb26-2b5d-4339-90e4-9e131de3449f', 'd92baa21-d4cf-4ffd-b530-d0f700c43a0d', NULL, 'dashboard_created', 'Criou o dashboard \"Painel De Vendas\".', '2026-11-02 03:22:09');

-- --------------------------------------------------------

--
-- Estrutura para tabela `charts`
--

CREATE TABLE `charts` (
  `id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `dataset_id` char(36) NOT NULL,
  `title` varchar(160) NOT NULL,
  `type` enum('bar','line','pie','doughnut','area','scatter') NOT NULL DEFAULT 'bar',
  `x_column` varchar(120) NOT NULL,
  `y_column` varchar(120) NOT NULL,
  `aggregation` enum('sum','avg','count','min','max','unique') NOT NULL DEFAULT 'sum',
  `color` varchar(20) NOT NULL DEFAULT 'blue',
  `options_json` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `charts`
--

INSERT INTO `charts` (`id`, `project_id`, `user_id`, `dataset_id`, `title`, `type`, `x_column`, `y_column`, `aggregation`, `color`, `options_json`, `created_at`, `updated_at`) VALUES
('f32c1e01-c1c7-41d0-9467-790c14e15bc3', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '28664bec-cff3-4b40-a6c5-b4b353217a15', 'Receita por mês', 'line', 'Mes', 'Receita', 'sum', 'blue', '{\"legend\":true,\"values\":true}', '2026-11-01 19:30:49', '2026-11-01 19:30:49');

-- --------------------------------------------------------

--
-- Estrutura para tabela `dashboards`
--

CREATE TABLE `dashboards` (
  `id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `name` varchar(160) NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `layout_json` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `dashboards`
--

INSERT INTO `dashboards` (`id`, `project_id`, `user_id`, `name`, `description`, `layout_json`, `created_at`, `updated_at`) VALUES
('9e1eb559-fa9c-4b9b-924f-7bbe916f9461', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'Dashboard principal', 'Organize aqui os gráficos e indicadores da análise.', '[{\"id\":\"blk-g5yso1k\",\"type\":\"chart\",\"width\":\"half\",\"ref\":\"f32c1e01-c1c7-41d0-9467-790c14e15bc3\",\"text\":\"\",\"title\":\"\"},{\"id\":\"blk-3a61q0g\",\"type\":\"kpi\",\"width\":\"half\",\"ref\":\"f647394b-e9fb-460f-90c1-67f5c63a28a4\",\"text\":\"\",\"title\":\"\"}]', '2026-11-01 19:30:34', '2026-11-01 19:32:02');

-- --------------------------------------------------------

--
-- Estrutura para tabela `datasets`
--

CREATE TABLE `datasets` (
  `id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `stored_name` varchar(120) NOT NULL,
  `format` enum('csv','xlsx','json') NOT NULL,
  `size_bytes` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `row_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `column_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `columns_json` longtext NOT NULL,
  `preview_json` longtext NOT NULL,
  `data_json` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `datasets`
--

INSERT INTO `datasets` (`id`, `project_id`, `user_id`, `original_name`, `stored_name`, `format`, `size_bytes`, `row_count`, `column_count`, `columns_json`, `preview_json`, `data_json`, `created_at`, `updated_at`) VALUES
('28664bec-cff3-4b40-a6c5-b4b353217a15', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'datapro-demo.csv', '48b84f4e5f8e6a2a7361327db74cafd0.csv', 'csv', 387, 12, 5, '[{\"name\":\"Mes\",\"type\":\"text\",\"selected\":true},{\"name\":\"Produto\",\"type\":\"text\",\"selected\":true},{\"name\":\"Receita\",\"type\":\"number\",\"selected\":true},{\"name\":\"Unidades\",\"type\":\"number\",\"selected\":true},{\"name\":\"Clientes\",\"type\":\"number\",\"selected\":true}]', '[{\"Mes\":\"Jan\",\"Produto\":\"Essencial\",\"Receita\":\"18500\",\"Unidades\":\"120\",\"Clientes\":\"84\"},{\"Mes\":\"Fev\",\"Produto\":\"Essencial\",\"Receita\":\"19200\",\"Unidades\":\"128\",\"Clientes\":\"88\"},{\"Mes\":\"Mar\",\"Produto\":\"Profissional\",\"Receita\":\"24800\",\"Unidades\":\"96\",\"Clientes\":\"72\"},{\"Mes\":\"Abr\",\"Produto\":\"Profissional\",\"Receita\":\"26400\",\"Unidades\":\"102\",\"Clientes\":\"76\"},{\"Mes\":\"Mai\",\"Produto\":\"Enterprise\",\"Receita\":\"42000\",\"Unidades\":\"42\",\"Clientes\":\"18\"},{\"Mes\":\"Jun\",\"Produto\":\"Enterprise\",\"Receita\":\"45500\",\"Unidades\":\"45\",\"Clientes\":\"20\"},{\"Mes\":\"Jul\",\"Produto\":\"Profissional\",\"Receita\":\"28100\",\"Unidades\":\"108\",\"Clientes\":\"81\"},{\"Mes\":\"Ago\",\"Produto\":\"Profissional\",\"Receita\":\"29900\",\"Unidades\":\"114\",\"Clientes\":\"86\"},{\"Mes\":\"Set\",\"Produto\":\"Enterprise\",\"Receita\":\"47800\",\"Unidades\":\"48\",\"Clientes\":\"22\"},{\"Mes\":\"Out\",\"Produto\":\"Enterprise\",\"Receita\":\"51200\",\"Unidades\":\"51\",\"Clientes\":\"24\"},{\"Mes\":\"Nov\",\"Produto\":\"Essencial\",\"Receita\":\"22400\",\"Unidades\":\"142\",\"Clientes\":\"97\"},{\"Mes\":\"Dez\",\"Produto\":\"Profissional\",\"Receita\":\"32600\",\"Unidades\":\"126\",\"Clientes\":\"92\"}]', '[{\"Mes\":\"Jan\",\"Produto\":\"Essencial\",\"Receita\":\"18500\",\"Unidades\":\"120\",\"Clientes\":\"84\"},{\"Mes\":\"Fev\",\"Produto\":\"Essencial\",\"Receita\":\"19200\",\"Unidades\":\"128\",\"Clientes\":\"88\"},{\"Mes\":\"Mar\",\"Produto\":\"Profissional\",\"Receita\":\"24800\",\"Unidades\":\"96\",\"Clientes\":\"72\"},{\"Mes\":\"Abr\",\"Produto\":\"Profissional\",\"Receita\":\"26400\",\"Unidades\":\"102\",\"Clientes\":\"76\"},{\"Mes\":\"Mai\",\"Produto\":\"Enterprise\",\"Receita\":\"42000\",\"Unidades\":\"42\",\"Clientes\":\"18\"},{\"Mes\":\"Jun\",\"Produto\":\"Enterprise\",\"Receita\":\"45500\",\"Unidades\":\"45\",\"Clientes\":\"20\"},{\"Mes\":\"Jul\",\"Produto\":\"Profissional\",\"Receita\":\"28100\",\"Unidades\":\"108\",\"Clientes\":\"81\"},{\"Mes\":\"Ago\",\"Produto\":\"Profissional\",\"Receita\":\"29900\",\"Unidades\":\"114\",\"Clientes\":\"86\"},{\"Mes\":\"Set\",\"Produto\":\"Enterprise\",\"Receita\":\"47800\",\"Unidades\":\"48\",\"Clientes\":\"22\"},{\"Mes\":\"Out\",\"Produto\":\"Enterprise\",\"Receita\":\"51200\",\"Unidades\":\"51\",\"Clientes\":\"24\"},{\"Mes\":\"Nov\",\"Produto\":\"Essencial\",\"Receita\":\"22400\",\"Unidades\":\"142\",\"Clientes\":\"97\"},{\"Mes\":\"Dez\",\"Produto\":\"Profissional\",\"Receita\":\"32600\",\"Unidades\":\"126\",\"Clientes\":\"92\"}]', '2026-11-01 19:30:40', '2026-11-01 19:30:40'),
('7241709e-5f5a-4ff9-b6fb-1d27df9c1ffd', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'datapro-demo.json', 'a5b8fa3b865a4295760dd968911e0f9f.json', 'json', 233, 4, 4, '[{\"name\":\"Mes\",\"type\":\"text\",\"selected\":true},{\"name\":\"Canal\",\"type\":\"text\",\"selected\":true},{\"name\":\"Pedidos\",\"type\":\"number\",\"selected\":true},{\"name\":\"Ticket\",\"type\":\"number\",\"selected\":true}]', '[{\"Mes\":\"Jan\",\"Canal\":\"Online\",\"Pedidos\":\"34\",\"Ticket\":\"189.9\"},{\"Mes\":\"Fev\",\"Canal\":\"Online\",\"Pedidos\":\"41\",\"Ticket\":\"195.5\"},{\"Mes\":\"Mar\",\"Canal\":\"Loja\",\"Pedidos\":\"28\",\"Ticket\":\"172.4\"},{\"Mes\":\"Abr\",\"Canal\":\"Loja\",\"Pedidos\":\"31\",\"Ticket\":\"181.2\"}]', '[{\"Mes\":\"Jan\",\"Canal\":\"Online\",\"Pedidos\":\"34\",\"Ticket\":\"189.9\"},{\"Mes\":\"Fev\",\"Canal\":\"Online\",\"Pedidos\":\"41\",\"Ticket\":\"195.5\"},{\"Mes\":\"Mar\",\"Canal\":\"Loja\",\"Pedidos\":\"28\",\"Ticket\":\"172.4\"},{\"Mes\":\"Abr\",\"Canal\":\"Loja\",\"Pedidos\":\"31\",\"Ticket\":\"181.2\"}]', '2026-11-01 19:33:19', '2026-11-01 19:33:19'),
('b5ebcd12-39f8-425c-95b2-eca3e087c2d1', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'datapro-demo.xlsx', 'c1512732520332755e8b38b2eee8db61.xlsx', 'xlsx', 1416, 5, 4, '[{\"name\":\"Mes\",\"type\":\"text\",\"selected\":true},{\"name\":\"Regiao\",\"type\":\"text\",\"selected\":true},{\"name\":\"Vendas\",\"type\":\"number\",\"selected\":true},{\"name\":\"Meta\",\"type\":\"number\",\"selected\":false}]', '[{\"Mes\":\"Jan\",\"Regiao\":\"Sudeste\",\"Vendas\":\"12500\",\"Meta\":\"14000\"},{\"Mes\":\"Fev\",\"Regiao\":\"Sudeste\",\"Vendas\":\"13800\",\"Meta\":\"14000\"},{\"Mes\":\"Mar\",\"Regiao\":\"Sul\",\"Vendas\":\"15200\",\"Meta\":\"15000\"},{\"Mes\":\"Abr\",\"Regiao\":\"Sul\",\"Vendas\":\"16100\",\"Meta\":\"16000\"},{\"Mes\":\"Mai\",\"Regiao\":\"Nordeste\",\"Vendas\":\"11900\",\"Meta\":\"13000\"}]', '[{\"Mes\":\"Jan\",\"Regiao\":\"Sudeste\",\"Vendas\":\"12500\",\"Meta\":\"14000\"},{\"Mes\":\"Fev\",\"Regiao\":\"Sudeste\",\"Vendas\":\"13800\",\"Meta\":\"14000\"},{\"Mes\":\"Mar\",\"Regiao\":\"Sul\",\"Vendas\":\"15200\",\"Meta\":\"15000\"},{\"Mes\":\"Abr\",\"Regiao\":\"Sul\",\"Vendas\":\"16100\",\"Meta\":\"16000\"},{\"Mes\":\"Mai\",\"Regiao\":\"Nordeste\",\"Vendas\":\"11900\",\"Meta\":\"13000\"}]', '2026-11-01 19:33:31', '2026-11-01 19:34:46');

-- --------------------------------------------------------

--
-- Estrutura para tabela `insights`
--

CREATE TABLE `insights` (
  `id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `title` varchar(160) NOT NULL,
  `description` text NOT NULL,
  `category` enum('trend','opportunity','risk','anomaly','recommendation','other') NOT NULL DEFAULT 'trend',
  `importance` enum('low','medium','high','critical') NOT NULL DEFAULT 'medium',
  `recommendation` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `kpis`
--

CREATE TABLE `kpis` (
  `id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `dataset_id` char(36) NOT NULL,
  `title` varchar(120) NOT NULL,
  `column_name` varchar(120) DEFAULT NULL,
  `aggregation` enum('sum','avg','count','min','max','unique') NOT NULL DEFAULT 'sum',
  `format` enum('number','currency','percent') NOT NULL DEFAULT 'number',
  `prefix` varchar(16) DEFAULT NULL,
  `suffix` varchar(16) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `kpis`
--

INSERT INTO `kpis` (`id`, `project_id`, `user_id`, `dataset_id`, `title`, `column_name`, `aggregation`, `format`, `prefix`, `suffix`, `created_at`, `updated_at`) VALUES
('f647394b-e9fb-460f-90c1-67f5c63a28a4', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '28664bec-cff3-4b40-a6c5-b4b353217a15', 'Receita total', 'Receita', 'sum', 'currency', NULL, NULL, '2026-11-01 19:30:49', '2026-11-01 19:30:49');

-- --------------------------------------------------------

--
-- Estrutura para tabela `presentations`
--

CREATE TABLE `presentations` (
  `id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `title` varchar(160) NOT NULL,
  `subtitle` varchar(240) DEFAULT NULL,
  `theme` varchar(20) NOT NULL DEFAULT 'aurora',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `presentations`
--

INSERT INTO `presentations` (`id`, `project_id`, `user_id`, `title`, `subtitle`, `theme`, `created_at`, `updated_at`) VALUES
('c2c54958-1948-4d38-9da3-4ab90897b0f0', '44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'Apresentação — Projeto de demonstração', 'DataPro Studio', 'aurora', '2026-11-01 19:30:34', '2026-11-01 19:30:34');

-- --------------------------------------------------------

--
-- Estrutura para tabela `presentation_slides`
--

CREATE TABLE `presentation_slides` (
  `id` char(36) NOT NULL,
  `presentation_id` char(36) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `type` enum('cover','text','chart','kpi','insights','conclusion') NOT NULL DEFAULT 'text',
  `title` varchar(180) DEFAULT NULL,
  `content_json` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `presentation_slides`
--

INSERT INTO `presentation_slides` (`id`, `presentation_id`, `position`, `type`, `title`, `content_json`, `created_at`, `updated_at`) VALUES
('0b87fc3c-3245-4355-a5a2-8fce5c6d3d85', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 0, 'cover', 'Análise de Dados', '{\"subtitle\":\"Projeto de demonstração\",\"body\":\"DataPro Studio\"}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('23c4140a-e344-45f9-bd99-860eee9446c5', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 1, 'text', 'Objetivo da análise', '{\"kicker\":\"Introdução\",\"body\":\"Descreva o problema, o contexto e o que esta análise busca responder.\",\"bullets\":[\"Contexto do cliente\",\"Pergunta principal\",\"Período analisado\"]}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('48ba50f6-e788-4e5d-8e59-26c6af3884a0', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 6, 'insights', 'Principais insights', '{\"kicker\":\"Descobertas\",\"insight_ids\":[],\"note\":\"Selecione os insights registrados no projeto.\"}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('519ce398-25d7-4f8f-8aaa-34dbea9f6a68', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 7, 'conclusion', 'Recomendações e conclusão', '{\"kicker\":\"Próximos passos\",\"body\":\"Resuma as recomendações e o que deve ser acompanhado depois da entrega.\",\"bullets\":[]}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('760718fe-3056-442e-af30-0c42d60f3e20', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 2, 'text', 'Visão geral dos dados', '{\"kicker\":\"Dados\",\"body\":\"Apresente as bases importadas, o período e as colunas utilizadas.\",\"bullets\":[]}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('a958c389-ae59-48f0-91af-abebbaf9752e', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 4, 'chart', 'Gráficos', '{\"kicker\":\"Visualizações\",\"chart_id\":\"\",\"note\":\"Escolha um gráfico do projeto e escreva um comentário.\"}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('df9b2739-f911-40f6-b31b-596db79a84aa', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 5, 'text', 'Resultados', '{\"kicker\":\"Análise\",\"body\":\"Registre os resultados observados nos dados, sem conclusões que os dados não sustentem.\",\"bullets\":[]}', '2026-11-01 19:30:34', '2026-11-01 19:30:34'),
('ec4d674d-6a18-495f-8a6d-8faef84364c9', 'c2c54958-1948-4d38-9da3-4ab90897b0f0', 3, 'kpi', 'Indicadores principais', '{\"kicker\":\"KPIs\",\"kpi_ids\":[],\"note\":\"Selecione os indicadores reais criados no projeto.\"}', '2026-11-01 19:30:34', '2026-11-01 19:30:34');

-- --------------------------------------------------------

--
-- Estrutura para tabela `projects`
--

CREATE TABLE `projects` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `name` varchar(160) NOT NULL,
  `client` varchar(160) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('sales','finance','marketing','operations','customers','survey','other') NOT NULL DEFAULT 'other',
  `status` enum('active','completed','draft') NOT NULL DEFAULT 'active',
  `accent` varchar(20) NOT NULL DEFAULT 'aurora',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `projects`
--

INSERT INTO `projects` (`id`, `user_id`, `name`, `client`, `description`, `category`, `status`, `accent`, `created_at`, `updated_at`) VALUES
('44a82c99-4756-469b-bce5-18cb7b8f79fd', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'Projeto de demonstração', 'DataPro Studio', 'Projeto criado para validar importação, gráficos, KPIs e entregas.', 'sales', 'active', 'aurora', '2026-11-01 19:30:34', '2026-11-01 19:34:46');

-- --------------------------------------------------------

--
-- Estrutura para tabela `remember_tokens`
--

CREATE TABLE `remember_tokens` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `selector` char(32) NOT NULL,
  `validator_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `remember_tokens`
--

INSERT INTO `remember_tokens` (`id`, `user_id`, `selector`, `validator_hash`, `expires_at`, `created_at`) VALUES
('00e3cd40-c79d-44d8-b9ea-7f30cd0b4503', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '344923ce217b53c13d604c4512beec88', '$2y$10$c54iCSWg8bJOaX/A6Vnup.wX./OTgtHP4CYOhtlidjyzf0mdOCpW2', '2026-12-02 19:28:49', '2026-11-02 19:28:50'),
('531cf69d-e246-4d03-9ec0-fc5d2e0176e5', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '3180784ce00a9274c40448436e3f77fe', '$2y$10$X3mgx8c8ddM67HFCr7avZeYvdu2gWSKVqr5h2O8eXibPBjrMxKPuq', '2026-12-01 19:36:14', '2026-11-01 19:36:14'),
('54e2629a-1ff3-42e3-83ff-fb91a0711a11', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'b3d38267bbb37b50d6fd57c7c99f03cd', '$2y$10$9o2w8.04/QRUw4aED3f/ZOnTOg7pNaEYg2neMeBn7g0o/eGXtf6eO', '2026-11-30 14:30:55', '2026-10-31 14:30:55'),
('5aefda8f-e945-4502-850f-40f54f4a6a21', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '49f20e6054a067c2284c5d1e918159ec', '$2y$10$Zav1c7Oug7MYq6rzNXS8Ae/GAdvg8rH/1DyROtXDSLXcN3vwXRKtq', '2026-11-30 14:31:22', '2026-10-31 14:31:22'),
('5f69eae8-0c44-44f4-b055-079940f8cdd7', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '7c421d476245dc54dde4b423f25087ee', '$2y$10$8rZxGONGhAyKWfpxuRglD.44Hk8IgYv.up/sSIFoeuDZHOyppKvx2', '2026-11-30 14:30:11', '2026-10-31 14:30:11'),
('92d36e42-ad42-4287-9e7f-1ce6472cd472', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '0751ff6e84657bbc64d5941a546c10b9', '$2y$10$qZmq8fYXXHH/cuHzzg4bjeuuk4/zGBrhEMML0PoOHBnfbXxgZiDHG', '2026-11-30 14:31:09', '2026-10-31 14:31:10'),
('c5a48058-4286-4446-ab68-870fa0498c52', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'a4c799ec145222bd9b56b5c75784618d', '$2y$10$NXaIGKlh3/qohXUa20jL.OJzt976Hr0P2vlau.13LsDjVeQQgfOh6', '2026-11-30 21:05:07', '2026-10-31 21:05:07'),
('d154775b-698c-48a3-bdf1-d32dde43ddf0', 'e98b36c6-fb48-40e2-a980-8ad8bc2a251d', '21fa612d34b31af60fcf36a990cd309f', '$2y$10$pXU1k21mXCaxjIr4XZJOvOzIDZh0vFbtvszSonuKlum9BgPGNof9u', '2026-11-30 14:30:22', '2026-10-31 14:30:22');

-- --------------------------------------------------------

--
-- Estrutura para tabela `share_links`
--

CREATE TABLE `share_links` (
  `id` char(36) NOT NULL,
  `token` char(64) NOT NULL,
  `user_id` char(36) NOT NULL,
  `project_id` char(36) NOT NULL,
  `resource_type` enum('dashboard','presentation') NOT NULL,
  `resource_id` char(36) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `theme` enum('dark','light','system') NOT NULL DEFAULT 'dark',
  `notify_activity` tinyint(1) NOT NULL DEFAULT 1,
  `notify_updates` tinyint(1) NOT NULL DEFAULT 0,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `theme`, `notify_activity`, `notify_updates`, `last_login_at`, `created_at`, `updated_at`) VALUES
('d92baa21-d4cf-4ffd-b530-d0f700c43a0d', 'gustavo', 'gustavobegatti@gmail.com', '$2y$10$aJ7q6hLej5s/nUex66AQL.O1.N2yP.ZLvG6n3fwkm4z9tMsad10tK', 'dark', 1, 0, '2026-11-02 03:20:30', '2026-11-02 03:20:30', '2026-11-02 03:23:40'),
('e98b36c6-fb48-40e2-a980-8ad8bc2a251d', 'Gustavo Begatti', 'gustavo@datapro.local', '$2y$10$S6BA.v.dPw/m0VWralme2.rCp3ASkHYgFt5ePVyfh4cR9UewMSPZm', 'dark', 1, 0, '2026-11-02 19:28:50', '2026-10-31 14:30:11', '2026-11-01 19:35:21'),
('f09424ac-4cb8-4a8f-9bd9-8dca923a8ce5', 'Gustavo', 'begattiferreiragustavo@gmail.com', '$2y$10$.ra/0l5xmi85CAuA2e25wuv48KhLIz0sCDMHUXQvbkqjla.LCTjzS', 'dark', 1, 0, '2026-11-02 03:17:27', '2026-11-02 03:17:27', '2026-11-02 03:17:27');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activities_user` (`user_id`,`created_at`),
  ADD KEY `idx_activities_project` (`project_id`,`created_at`);

--
-- Índices de tabela `charts`
--
ALTER TABLE `charts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_charts_project` (`project_id`,`created_at`),
  ADD KEY `idx_charts_dataset` (`dataset_id`),
  ADD KEY `fk_charts_user` (`user_id`);

--
-- Índices de tabela `dashboards`
--
ALTER TABLE `dashboards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dashboards_project` (`project_id`,`updated_at`),
  ADD KEY `fk_dashboards_user` (`user_id`);

--
-- Índices de tabela `datasets`
--
ALTER TABLE `datasets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_datasets_project` (`project_id`,`created_at`),
  ADD KEY `idx_datasets_user` (`user_id`);

--
-- Índices de tabela `insights`
--
ALTER TABLE `insights`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_insights_project` (`project_id`,`created_at`),
  ADD KEY `fk_insights_user` (`user_id`);

--
-- Índices de tabela `kpis`
--
ALTER TABLE `kpis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_kpis_project` (`project_id`,`created_at`),
  ADD KEY `idx_kpis_dataset` (`dataset_id`),
  ADD KEY `fk_kpis_user` (`user_id`);

--
-- Índices de tabela `presentations`
--
ALTER TABLE `presentations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_presentations_project` (`project_id`,`updated_at`),
  ADD KEY `fk_presentations_user` (`user_id`);

--
-- Índices de tabela `presentation_slides`
--
ALTER TABLE `presentation_slides`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_slides_presentation` (`presentation_id`,`position`);

--
-- Índices de tabela `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_projects_user_updated` (`user_id`,`updated_at`),
  ADD KEY `idx_projects_user_status` (`user_id`,`status`);

--
-- Índices de tabela `remember_tokens`
--
ALTER TABLE `remember_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_remember_selector` (`selector`),
  ADD KEY `idx_remember_user` (`user_id`);

--
-- Índices de tabela `share_links`
--
ALTER TABLE `share_links`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_share_token` (`token`),
  ADD KEY `idx_share_resource` (`resource_type`,`resource_id`),
  ADD KEY `idx_share_user` (`user_id`),
  ADD KEY `fk_share_project` (`project_id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_users_email` (`email`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `fk_activities_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_activities_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `charts`
--
ALTER TABLE `charts`
  ADD CONSTRAINT `fk_charts_dataset` FOREIGN KEY (`dataset_id`) REFERENCES `datasets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_charts_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_charts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `dashboards`
--
ALTER TABLE `dashboards`
  ADD CONSTRAINT `fk_dashboards_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dashboards_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `datasets`
--
ALTER TABLE `datasets`
  ADD CONSTRAINT `fk_datasets_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_datasets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `insights`
--
ALTER TABLE `insights`
  ADD CONSTRAINT `fk_insights_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_insights_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `kpis`
--
ALTER TABLE `kpis`
  ADD CONSTRAINT `fk_kpis_dataset` FOREIGN KEY (`dataset_id`) REFERENCES `datasets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_kpis_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_kpis_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `presentations`
--
ALTER TABLE `presentations`
  ADD CONSTRAINT `fk_presentations_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_presentations_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `presentation_slides`
--
ALTER TABLE `presentation_slides`
  ADD CONSTRAINT `fk_slides_presentation` FOREIGN KEY (`presentation_id`) REFERENCES `presentations` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `fk_projects_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `remember_tokens`
--
ALTER TABLE `remember_tokens`
  ADD CONSTRAINT `fk_remember_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `share_links`
--
ALTER TABLE `share_links`
  ADD CONSTRAINT `fk_share_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_share_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Banco de dados: `escola_integrada`
--
CREATE DATABASE IF NOT EXISTS `escola_integrada` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `escola_integrada`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ano_letivo`
--

CREATE TABLE `ano_letivo` (
  `id_ano_letivo` int(11) NOT NULL,
  `ano` varchar(50) NOT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `biblioteca_livro`
--

CREATE TABLE `biblioteca_livro` (
  `id_livro` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `autor` varchar(100) DEFAULT NULL,
  `editora` varchar(100) DEFAULT NULL,
  `ano_publicacao` year(4) DEFAULT NULL,
  `quantidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cargo`
--

CREATE TABLE `cargo` (
  `id_cargo` int(11) NOT NULL,
  `nome` varchar(80) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplina`
--

CREATE TABLE `disciplina` (
  `id_disciplina` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `carga_horaria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `id_endereco` int(11) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `bairro` varchar(80) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `escola`
--

CREATE TABLE `escola` (
  `id_escola` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cnpj` varchar(20) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_endereco` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `professor`
--

CREATE TABLE `professor` (
  `id_professor` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `responsavel`
--

CREATE TABLE `responsavel` (
  `id_responsavel` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sala`
--

CREATE TABLE `sala` (
  `id_sala` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `capacidade` int(11) DEFAULT NULL,
  `bloco` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `ano_letivo`
--
ALTER TABLE `ano_letivo`
  ADD PRIMARY KEY (`id_ano_letivo`);

--
-- Índices de tabela `biblioteca_livro`
--
ALTER TABLE `biblioteca_livro`
  ADD PRIMARY KEY (`id_livro`);

--
-- Índices de tabela `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id_cargo`);

--
-- Índices de tabela `disciplina`
--
ALTER TABLE `disciplina`
  ADD PRIMARY KEY (`id_disciplina`);

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`id_endereco`);

--
-- Índices de tabela `escola`
--
ALTER TABLE `escola`
  ADD PRIMARY KEY (`id_escola`),
  ADD KEY `fk_escola_endereco` (`id_endereco`);

--
-- Índices de tabela `professor`
--
ALTER TABLE `professor`
  ADD PRIMARY KEY (`id_professor`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices de tabela `responsavel`
--
ALTER TABLE `responsavel`
  ADD PRIMARY KEY (`id_responsavel`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices de tabela `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`id_sala`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ano_letivo`
--
ALTER TABLE `ano_letivo`
  MODIFY `id_ano_letivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `biblioteca_livro`
--
ALTER TABLE `biblioteca_livro`
  MODIFY `id_livro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id_cargo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `disciplina`
--
ALTER TABLE `disciplina`
  MODIFY `id_disciplina` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `id_endereco` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `escola`
--
ALTER TABLE `escola`
  MODIFY `id_escola` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `professor`
--
ALTER TABLE `professor`
  MODIFY `id_professor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `responsavel`
--
ALTER TABLE `responsavel`
  MODIFY `id_responsavel` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sala`
--
ALTER TABLE `sala`
  MODIFY `id_sala` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `escola`
--
ALTER TABLE `escola`
  ADD CONSTRAINT `fk_escola_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id_endereco`);
--
-- Banco de dados: `escola_sql`
--
CREATE DATABASE IF NOT EXISTS `escola_sql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `escola_sql`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `id_aluno` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `turma` varchar(20) DEFAULT NULL,
  `turno` varchar(20) DEFAULT NULL,
  `curso` varchar(100) DEFAULT NULL,
  `situacao` varchar(30) DEFAULT NULL,
  `nota` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `alunos`
--

INSERT INTO `alunos` (`id_aluno`, `nome`, `data_nascimento`, `idade`, `cidade`, `estado`, `turma`, `turno`, `curso`, `situacao`, `nota`) VALUES
(1, 'Ana Souza', '2009-03-12', 17, 'Hortolândia', 'SP', '1º TIA', 'Manhã', 'Técnico em Informática', 'Matriculado', 8.50),
(2, 'Arthur Almeida', '2010-07-21', 16, 'Campinas', 'SP', '1º TIB', 'Manhã', 'Técnico em Informática', 'Matriculado', 7.80),
(3, 'Carla Mendes', '2009-11-05', 16, 'Hortolândia', 'SP', '1º TIC', 'Tarde', 'Desenvolvimento de Sistemas', 'Matriculado', 9.00),
(4, 'Mariana Souza', '2008-02-18', 18, 'Sumaré', 'SP', '2º TIA', 'Manhã', 'Técnico em Informática', 'Matriculado', 6.50),
(5, 'Lucas Ferreira', '2009-06-30', 17, 'Campinas', 'SP', '2º TIB', 'Tarde', 'Desenvolvimento de Sistemas', 'Matriculado', 7.20),
(6, 'Gabriel Santos', '2008-09-14', 17, 'Valinhos', 'SP', '2º TIC', 'Manhã', 'Técnico em Informática', 'Trancado', 5.80),
(7, 'Beatriz Lima', '2010-01-09', 16, 'Sumaré', 'SP', '1º TIA', 'Tarde', 'Desenvolvimento de Sistemas', 'Matriculado', 8.90),
(8, 'Pedro Henrique', '2008-04-23', 18, 'Hortolândia', 'SP', '3º TIA', 'Manhã', 'Técnico em Informática', 'Matriculado', 9.40),
(9, 'Juliana Costa', '2009-12-17', 16, 'Campinas', 'SP', '1º TIB', 'Manhã', 'Técnico em Administração', 'Transferido', 6.00),
(10, 'Rafael Martins', '2008-08-02', 18, 'Valinhos', 'SP', '3º TIB', 'Noite', 'Desenvolvimento de Sistemas', 'Matriculado', 7.00),
(11, 'Amanda Ribeiro', '2009-05-11', 17, 'Hortolândia', 'SP', '2º TIA', 'Tarde', 'Técnico em Informática', 'Matriculado', 8.00),
(12, 'Felipe Souza', '2010-10-26', 15, 'Sumaré', 'SP', '1º TIC', 'Manhã', 'Técnico em Informática', 'Matriculado', 6.40),
(13, 'Larissa Gomes', '2008-03-15', 18, 'Campinas', 'SP', '3º TIC', 'Manhã', 'Desenvolvimento de Sistemas', 'Concluído', 9.70),
(14, 'André Oliveira', '2009-07-08', 17, 'Hortolândia', 'SP', '2º TIB', 'Noite', 'Técnico em Informática', 'Matriculado', 7.50),
(15, 'Camila Rocha', '2010-02-28', 16, 'Valinhos', 'SP', '1º TIA', 'Tarde', 'Desenvolvimento de Sistemas', 'Matriculado', 8.30),
(16, 'João Pedro', '2008-12-01', 17, 'Belo Horizonte', 'MG', '3º TIA', 'Manhã', 'Técnico em Informática', 'Matriculado', 6.20),
(17, 'Alice Nunes', '2009-04-19', 17, 'Curitiba', 'PR', '2º TIC', 'Tarde', 'Desenvolvimento de Sistemas', 'Transferido', 8.70),
(18, 'Bruno Carvalho', '2008-06-07', 18, 'Rio de Janeiro', 'RJ', '3º TIB', 'Noite', 'Técnico em Informática', 'Matriculado', 5.50),
(19, 'Marla Pereira', '2010-09-13', 15, 'Vitória', 'ES', '1º TIB', 'Manhã', 'Desenvolvimento de Sistemas', 'Matriculado', 7.90),
(20, 'Eduardo Souza', '2009-01-25', 17, 'Campinas', 'SP', '2º TIA', 'Manhã', 'Técnico em Informática', 'Trancado', 6.80),
(21, 'Aline Barbosa', '2008-10-10', 17, 'Hortolândia', 'SP', '3º TIC', 'Tarde', 'Desenvolvimento de Sistemas', 'Matriculado', 9.20),
(22, 'Matheus Silva', '2010-05-16', 16, 'Sumaré', 'SP', '1º TIC', 'Manhã', 'Técnico em Informática', 'Matriculado', 7.10),
(23, 'Fernanda Alves', '2009-08-29', 16, 'Campinas', 'SP', '2º TIB', 'Tarde', 'Técnico em Administração', 'Matriculado', 8.10),
(24, 'Carlos Souza', '2008-01-31', 18, 'Hortolândia', 'SP', '3º TIA', 'Noite', 'Técnico em Informática', 'Concluído', 10.00),
(25, 'Daniela Freitas', '2010-03-03', 16, 'Valinhos', 'SP', '1º TIA', 'Manhã', 'Desenvolvimento de Sistemas', 'Matriculado', 6.30),
(26, 'Gustavo Moreira', '2009-09-22', 16, 'Campinas', 'SP', '2º TIC', 'Manhã', 'Técnico em Informática', 'Matriculado', 7.60),
(27, 'Helena Castro', '2008-05-27', 18, 'Sumaré', 'SP', '3º TIB', 'Tarde', 'Desenvolvimento de Sistemas', 'Matriculado', 8.60),
(28, 'Igor Teixeira', '2010-11-04', 15, 'Hortolândia', 'SP', '1º TIB', 'Manhã', 'Técnico em Informática', 'Matriculado', 5.90),
(29, 'Natália Moraes', '2009-02-14', 17, 'Campinas', 'SP', '2º TIA', 'Noite', 'Desenvolvimento de Sistemas', 'Matriculado', 9.10),
(30, 'Vinícius Lopes', '2008-07-19', 18, 'Hortolândia', 'SP', '3º TIC', 'Manhã', 'Técnico em Informática', 'Afastado', 6.50);

-- --------------------------------------------------------

--
-- Estrutura para tabela `professores`
--

CREATE TABLE `professores` (
  `id_professor` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `disciplina` varchar(100) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `carga_horaria` int(11) DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `data_contratacao` date DEFAULT NULL,
  `situacao` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `professores`
--

INSERT INTO `professores` (`id_professor`, `nome`, `disciplina`, `cidade`, `estado`, `carga_horaria`, `salario`, `data_contratacao`, `situacao`) VALUES
(1, 'Marcos Vieira', 'Programação', 'Campinas', 'SP', 40, 5200.00, '2015-02-10', 'Ativo'),
(2, 'Patrícia Silva', 'Banco de Dados', 'Hortolândia', 'SP', 30, 4800.00, '2018-08-01', 'Ativo'),
(3, 'Roberto Almeida', 'Redes de Computadores', 'Campinas', 'SP', 20, 3900.00, '2020-01-15', 'Ativo'),
(4, 'Fernanda Costa', 'Programação', 'Sumaré', 'SP', 25, 4300.00, '2019-03-20', 'Ativo'),
(5, 'Juliana Rocha', 'Matemática', 'Valinhos', 'SP', 40, 5500.00, '2014-07-12', 'Ativo'),
(6, 'Ricardo Souza', 'Banco de Dados', 'Campinas', 'SP', 30, 4700.00, '2017-02-06', 'Licença'),
(7, 'Márcia Oliveira', 'Redes de Computadores', 'Hortolândia', 'SP', 24, 4100.00, '2021-06-14', 'Ativo'),
(8, 'Carlos Pereira', 'Sistemas Operacionais', 'Sumaré', 'SP', 20, 3600.00, '2022-01-24', 'Ativo'),
(9, 'Luciana Ferreira', 'Programação', 'Campinas', 'SP', 35, 5100.00, '2016-09-05', 'Ativo'),
(10, 'Renato Gomes', 'Banco de Dados', 'Valinhos', 'SP', 15, 3200.00, '2023-02-01', 'Afastado'),
(11, 'Adriana Lima', 'Redes de Computadores', 'Campinas', 'SP', 30, 4600.00, '2019-08-19', 'Ativo'),
(12, 'Marcelo Nunes', 'Programação', 'Hortolândia', 'SP', 20, 4000.00, '2020-07-27', 'Ativo'),
(13, 'Vanessa Martins', 'Design de Interfaces', 'Sumaré', 'SP', 25, 4200.00, '2021-01-18', 'Ativo'),
(14, 'Daniela Barbosa', 'Banco de Dados', 'Campinas', 'SP', 40, 5800.00, '2013-04-08', 'Ativo'),
(15, 'André Teixeira', 'Sistemas Operacionais', 'Hortolândia', 'SP', 30, 4400.00, '2018-02-12', 'Licença'),
(16, 'Cláudia Moraes', 'Programação', 'Valinhos', 'SP', 20, 3800.00, '2022-08-03', 'Ativo'),
(17, 'Eduardo Castro', 'Redes de Computadores', 'Campinas', 'SP', 35, 5000.00, '2016-01-25', 'Ativo'),
(18, 'Sabrina Freitas', 'Matemática', 'Hortolândia', 'SP', 18, 3500.00, '2023-07-31', 'Ativo'),
(19, 'Gustavo Lopes', 'Banco de Dados', 'Sumaré', 'SP', 25, 4500.00, '2020-02-17', 'Ativo'),
(20, 'Ana Paula', 'Programação', 'Campinas', 'SP', 30, 4900.00, '2017-08-07', 'Ativo'),
(21, 'Mônica Ribeiro', 'Redes de Computadores', 'Hortolândia', 'SP', 40, 5600.00, '2014-02-03', 'Ativo'),
(22, 'Rogério Santos', 'Sistemas Operacionais', 'Valinhos', 'SP', 22, 4050.00, '2021-03-22', 'Afastado'),
(23, 'Cristina Almeida', 'Design de Interfaces', 'Campinas', 'SP', 28, 4350.00, '2019-05-13', 'Ativo'),
(24, 'Alexandre Moreira', 'Programação', 'Sumaré', 'SP', 32, 4750.00, '2018-10-01', 'Ativo'),
(25, 'Tatiana Souza', 'Banco de Dados', 'Hortolândia', 'SP', 20, 3700.00, '2022-02-07', 'Ativo'),
(26, 'Priscila Nogueira', 'Redes de Computadores', 'Campinas', 'SP', 26, 4450.00, '2020-09-14', 'Ativo'),
(27, 'Maurício Lima', 'Programação', 'Valinhos', 'SP', 40, 6000.00, '2012-01-16', 'Ativo'),
(28, 'Sandra Carvalho', 'Banco de Dados', 'Sumaré', 'SP', 30, 4650.00, '2017-03-06', 'Licença'),
(29, 'Débora Mendes', 'Sistemas Operacionais', 'Hortolândia', 'SP', 24, 3950.00, '2021-08-09', 'Ativo'),
(30, 'Fábio Rocha', 'Redes de Computadores', 'Campinas', 'SP', 36, 5300.00, '2015-07-20', 'Ativo');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`id_aluno`);

--
-- Índices de tabela `professores`
--
ALTER TABLE `professores`
  ADD PRIMARY KEY (`id_professor`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
  MODIFY `id_aluno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `professores`
--
ALTER TABLE `professores`
  MODIFY `id_professor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- Banco de dados: `gerenciador_prompts`
--
CREATE DATABASE IF NOT EXISTS `gerenciador_prompts` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gerenciador_prompts`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `projeto`
--

CREATE TABLE `projeto` (
  `id_projeto` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `data_criacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `projeto`
--

INSERT INTO `projeto` (`id_projeto`, `nome`, `descricao`, `status`, `data_criacao`) VALUES
(1, 'Chatbot de Atendimento', 'Assistente virtual para suporte ao cliente.', 'ativo', '2026-10-20'),
(2, 'Gerador de Resumos', 'Ferramenta que resume textos longos.', 'ativo', '2026-10-25'),
(3, 'Analise de Sentimentos', 'Classificacao de avaliacoes de produtos.', 'concluido', '2026-10-30');

-- --------------------------------------------------------

--
-- Estrutura para tabela `prompt`
--

CREATE TABLE `prompt` (
  `id_prompt` int(11) NOT NULL,
  `titulo` varchar(150) DEFAULT NULL,
  `texto` varchar(1000) DEFAULT NULL,
  `data_criacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `prompt`
--

INSERT INTO `prompt` (`id_prompt`, `titulo`, `texto`, `data_criacao`) VALUES
(1, 'Resumir texto', 'Resuma o texto a seguir em ate 5 linhas: {texto}', '2026-10-21'),
(2, 'Tom formal', 'Reescreva a mensagem abaixo em tom formal: {mensagem}', '2026-10-22'),
(3, 'Classificar sentimento', 'Classifique a avaliacao como positiva, neutra ou negativa: {avaliacao}', '2026-10-23');

-- --------------------------------------------------------

--
-- Estrutura para tabela `utiliza`
--

CREATE TABLE `utiliza` (
  `id_utiliza` int(11) NOT NULL,
  `id_projeto` int(11) DEFAULT NULL,
  `id_prompt` int(11) DEFAULT NULL,
  `data_uso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `utiliza`
--

INSERT INTO `utiliza` (`id_utiliza`, `id_projeto`, `id_prompt`, `data_uso`) VALUES
(1, 1, 2, '2026-11-01'),
(2, 2, 1, '2026-11-03'),
(3, 3, 3, '2026-11-04');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `projeto`
--
ALTER TABLE `projeto`
  ADD PRIMARY KEY (`id_projeto`);

--
-- Índices de tabela `prompt`
--
ALTER TABLE `prompt`
  ADD PRIMARY KEY (`id_prompt`);

--
-- Índices de tabela `utiliza`
--
ALTER TABLE `utiliza`
  ADD PRIMARY KEY (`id_utiliza`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `projeto`
--
ALTER TABLE `projeto`
  MODIFY `id_projeto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `prompt`
--
ALTER TABLE `prompt`
  MODIFY `id_prompt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `utiliza`
--
ALTER TABLE `utiliza`
  MODIFY `id_utiliza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Banco de dados: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Despejando dados para a tabela `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"portfolio_gustavo\",\"table\":\"mensagens_contato\"},{\"db\":\"\",\"table\":\"alunos\"},{\"db\":\"\",\"table\":\"professores\"},{\"db\":\"casadecriadores\",\"table\":\"profissionais\"}]');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Despejando dados para a tabela `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-11-07 16:40:04', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"pt_BR\",\"NavigationWidth\":0}');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Índices de tabela `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Índices de tabela `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Índices de tabela `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Índices de tabela `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Índices de tabela `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Índices de tabela `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Índices de tabela `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Índices de tabela `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Índices de tabela `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Índices de tabela `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Índices de tabela `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Índices de tabela `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Índices de tabela `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Banco de dados: `portfolio_gustavo`
--
CREATE DATABASE IF NOT EXISTS `portfolio_gustavo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `portfolio_gustavo`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `mensagens_contato`
--

CREATE TABLE `mensagens_contato` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mensagem` text NOT NULL,
  `enviado_em` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `mensagens_contato`
--

INSERT INTO `mensagens_contato` (`id`, `nome`, `email`, `mensagem`, `enviado_em`) VALUES
(1, 'Gustavo Begatti', 'begattiferreiragustavo@gmail.com', 'Olá! Gostaria de saber mais...', '2026-09-17 15:30:44');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `mensagens_contato`
--
ALTER TABLE `mensagens_contato`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `mensagens_contato`
--
ALTER TABLE `mensagens_contato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Banco de dados: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
