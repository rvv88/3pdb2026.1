-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 26/05/2026 às 00:14
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
-- Banco de dados: `cooperativa_de_credito`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `associado`
--

CREATE TABLE `associado` (
  `id_associado` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `nome_completo` varchar(50) NOT NULL,
  `cpf` int(11) NOT NULL,
  `salario_mensal` double NOT NULL,
  `margem_consignada` double NOT NULL,
  `status_spc` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bem_duravel`
--

CREATE TABLE `bem_duravel` (
  `id_bem` int(11) NOT NULL,
  `descricao_bem` varchar(100) NOT NULL,
  `valor_estimado_bem` double NOT NULL,
  `status_garantia` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `bem_duravel`
--

INSERT INTO `bem_duravel` (`id_bem`, `descricao_bem`, `valor_estimado_bem`, `status_garantia`) VALUES
(1, 'Apartamento 2 qts Copacabana', 600002.18, 1),
(2, 'Casa Petrópolis 5 qts', 13260000.21, 1),
(3, 'Kitnet Vidigal', 32000.49, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `comissao_vendedor`
--

CREATE TABLE `comissao_vendedor` (
  `id_parcela` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL,
  `numero_parcela` int(11) NOT NULL,
  `valor_parcela` int(11) NOT NULL,
  `data_vencimento` int(11) NOT NULL,
  `data_pagamento` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `configuracao_sistema`
--

CREATE TABLE `configuracao_sistema` (
  `id_config` int(11) NOT NULL,
  `chave_configuracao` int(11) NOT NULL,
  `valor_configuracao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `contrato_financiamento`
--

CREATE TABLE `contrato_financiamento` (
  `id_contrato` int(11) NOT NULL,
  `id_associado` int(11) NOT NULL,
  `id_vendedor` int(11) NOT NULL,
  `id_bem` int(11) NOT NULL,
  `data_contrato` int(11) NOT NULL,
  `valor_financiado` double NOT NULL,
  `taxa_juros_aplicada` double NOT NULL,
  `quantidade_meses` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `empresa_associada`
--

CREATE TABLE `empresa_associada` (
  `id_empresa` int(11) NOT NULL,
  `nome_razao_social` varchar(50) NOT NULL,
  `cnpj` varchar(20) NOT NULL,
  `pencetual_comissao` double NOT NULL,
  `total_comissoes_acumuladas` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `empresa_associada`
--

INSERT INTO `empresa_associada` (`id_empresa`, `nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
(1, 'FAETERJ QUINTINO', '31608763000143', 4, 10000),
(2, 'TCAR', '11852124000101', 4, 15231);

-- --------------------------------------------------------

--
-- Estrutura para tabela `parcela`
--

CREATE TABLE `parcela` (
  `id_parcela` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL,
  `numero_parcela` int(11) NOT NULL,
  `valor_parcela` double NOT NULL,
  `data_vencimento` int(11) NOT NULL,
  `data_pagamento` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendedor`
--

CREATE TABLE `vendedor` (
  `id_vendedor` int(11) NOT NULL,
  `nome_vendedor` varchar(50) NOT NULL,
  `cpf` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `associado`
--
ALTER TABLE `associado`
  ADD PRIMARY KEY (`id_associado`),
  ADD KEY `fkEmpresa_Associado` (`id_empresa`);

--
-- Índices de tabela `bem_duravel`
--
ALTER TABLE `bem_duravel`
  ADD PRIMARY KEY (`id_bem`);

--
-- Índices de tabela `comissao_vendedor`
--
ALTER TABLE `comissao_vendedor`
  ADD PRIMARY KEY (`id_parcela`);

--
-- Índices de tabela `configuracao_sistema`
--
ALTER TABLE `configuracao_sistema`
  ADD PRIMARY KEY (`id_config`);

--
-- Índices de tabela `contrato_financiamento`
--
ALTER TABLE `contrato_financiamento`
  ADD PRIMARY KEY (`id_contrato`);

--
-- Índices de tabela `empresa_associada`
--
ALTER TABLE `empresa_associada`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Índices de tabela `parcela`
--
ALTER TABLE `parcela`
  ADD PRIMARY KEY (`id_parcela`);

--
-- Índices de tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id_vendedor`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `associado`
--
ALTER TABLE `associado`
  MODIFY `id_associado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bem_duravel`
--
ALTER TABLE `bem_duravel`
  MODIFY `id_bem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `comissao_vendedor`
--
ALTER TABLE `comissao_vendedor`
  MODIFY `id_parcela` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `configuracao_sistema`
--
ALTER TABLE `configuracao_sistema`
  MODIFY `id_config` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `contrato_financiamento`
--
ALTER TABLE `contrato_financiamento`
  MODIFY `id_contrato` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `empresa_associada`
--
ALTER TABLE `empresa_associada`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `parcela`
--
ALTER TABLE `parcela`
  MODIFY `id_parcela` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `id_vendedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `associado`
--
ALTER TABLE `associado`
  ADD CONSTRAINT `fkEmpresa_Associado` FOREIGN KEY (`id_empresa`) REFERENCES `empresa_associada` (`id_empresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
