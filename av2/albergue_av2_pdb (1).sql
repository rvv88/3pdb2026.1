-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27/06/2026 às 07:56
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
-- Banco de dados: `albergue_av2_pdb`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `caracteristica_quarto`
--

CREATE TABLE `caracteristica_quarto` (
  `id_caracteristica_quarto` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `caracteristica_quarto`
--

INSERT INTO `caracteristica_quarto` (`id_caracteristica_quarto`, `descricao`) VALUES
(1, 'banheiro privado'),
(2, 'banheiro coletivo'),
(3, 'ar condicionado'),
(4, 'Smart TV'),
(5, 'frigobar');

-- --------------------------------------------------------

--
-- Estrutura para tabela `caracteristica_vaga`
--

CREATE TABLE `caracteristica_vaga` (
  `id_caracteristica_vaga` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `caracteristica_vaga`
--

INSERT INTO `caracteristica_vaga` (`id_caracteristica_vaga`, `descricao`) VALUES
(1, 'sol da manhã'),
(2, 'não bate sol'),
(3, 'próximo a porta'),
(4, 'próximo a janela'),
(5, 'cama beliche inferior'),
(6, 'cama beliche superior');

-- --------------------------------------------------------

--
-- Estrutura para tabela `carrinho`
--

CREATE TABLE `carrinho` (
  `id_carrinho` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  `valor_total` decimal(10,2) NOT NULL,
  `status_carrinho` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `carrinho`
--

INSERT INTO `carrinho` (`id_carrinho`, `id_cliente`, `data_criacao`, `valor_total`, `status_carrinho`) VALUES
(1, 1, '2026-06-27 01:11:44', 568.00, 4),
(2, 2, '2026-06-27 01:13:04', 2120.00, 3),
(3, 2, '2026-06-27 01:38:22', 599.00, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome_completo` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome_completo`, `cpf`, `email`, `telefone`) VALUES
(1, 'Rafael Vieira', '86601228010', '[rvv@email.com]', '21999887766'),
(2, 'Andre Neves', '56078223038', '[andre@email.com]', '21999554433');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamento`
--

CREATE TABLE `pagamento` (
  `id_pagamento` int(11) NOT NULL,
  `id_carrinho` int(11) NOT NULL,
  `valor_pago` decimal(10,2) NOT NULL,
  `data_pagamento` datetime NOT NULL DEFAULT current_timestamp(),
  `status_pagamento` tinyint(4) NOT NULL,
  `codigo_transacao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pagamento`
--

INSERT INTO `pagamento` (`id_pagamento`, `id_carrinho`, `valor_pago`, `data_pagamento`, `status_pagamento`, `codigo_transacao`) VALUES
(1, 1, 568.00, '2026-06-27 01:28:24', 4, NULL),
(2, 3, 599.00, '2026-06-27 01:42:40', 2, 'tx_9F7b3D2k8L1mN4p');

-- --------------------------------------------------------

--
-- Estrutura para tabela `quarto`
--

CREATE TABLE `quarto` (
  `id_quarto` int(11) NOT NULL,
  `numero_quarto` int(11) NOT NULL,
  `capacidade_vagas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `quarto`
--

INSERT INTO `quarto` (`id_quarto`, `numero_quarto`, `capacidade_vagas`) VALUES
(1, 100, 4),
(2, 101, 4),
(3, 102, 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `quarto_caracteristica`
--

CREATE TABLE `quarto_caracteristica` (
  `id_quarto` int(11) NOT NULL,
  `id_caracteristica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `quarto_caracteristica`
--

INSERT INTO `quarto_caracteristica` (`id_quarto`, `id_caracteristica`) VALUES
(1, 1),
(1, 3),
(3, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `reserva`
--

CREATE TABLE `reserva` (
  `id_reserva` int(11) NOT NULL,
  `id_carrinho` int(11) NOT NULL,
  `id_vaga` int(11) DEFAULT NULL,
  `id_quarto` int(11) DEFAULT NULL,
  `data_inicio` datetime NOT NULL DEFAULT current_timestamp(),
  `data_fim` datetime NOT NULL DEFAULT current_timestamp(),
  `valor_diaria` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `status_reserva` tinyint(4) NOT NULL,
  `data_cancelamento` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `reserva`
--

INSERT INTO `reserva` (`id_reserva`, `id_carrinho`, `id_vaga`, `id_quarto`, `data_inicio`, `data_fim`, `valor_diaria`, `valor_total`, `status_reserva`, `data_cancelamento`) VALUES
(1, 3, NULL, 1, '2026-07-01 15:00:00', '2026-07-03 12:00:00', 299.00, 599.00, 2, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vaga`
--

CREATE TABLE `vaga` (
  `id_vaga` int(11) NOT NULL,
  `id_quarto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vaga`
--

INSERT INTO `vaga` (`id_vaga`, `id_quarto`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vaga_caracteristica`
--

CREATE TABLE `vaga_caracteristica` (
  `id_vaga` int(11) NOT NULL,
  `id_caracteristica` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vaga_caracteristica`
--

INSERT INTO `vaga_caracteristica` (`id_vaga`, `id_caracteristica`) VALUES
(1, 2),
(1, 6),
(2, 2),
(2, 5),
(3, 1),
(3, 4),
(5, 2),
(5, 6),
(6, 2),
(6, 5),
(7, 1),
(8, 2);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `caracteristica_quarto`
--
ALTER TABLE `caracteristica_quarto`
  ADD PRIMARY KEY (`id_caracteristica_quarto`);

--
-- Índices de tabela `caracteristica_vaga`
--
ALTER TABLE `caracteristica_vaga`
  ADD PRIMARY KEY (`id_caracteristica_vaga`);

--
-- Índices de tabela `carrinho`
--
ALTER TABLE `carrinho`
  ADD PRIMARY KEY (`id_carrinho`),
  ADD KEY `fk_id_cliente` (`id_cliente`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`id_pagamento`),
  ADD KEY `fK_id_carrinho` (`id_carrinho`);

--
-- Índices de tabela `quarto`
--
ALTER TABLE `quarto`
  ADD PRIMARY KEY (`id_quarto`);

--
-- Índices de tabela `quarto_caracteristica`
--
ALTER TABLE `quarto_caracteristica`
  ADD PRIMARY KEY (`id_quarto`,`id_caracteristica`),
  ADD KEY `fk_id_caracteristica_quarto` (`id_caracteristica`);

--
-- Índices de tabela `reserva`
--
ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `fk_id_carrinho_reserva` (`id_carrinho`),
  ADD KEY `fk_id_vaga_reserva` (`id_vaga`),
  ADD KEY `fk_id_quarto_reserva` (`id_quarto`);

--
-- Índices de tabela `vaga`
--
ALTER TABLE `vaga`
  ADD PRIMARY KEY (`id_vaga`),
  ADD KEY `fk_id_quarto_vaga` (`id_quarto`);

--
-- Índices de tabela `vaga_caracteristica`
--
ALTER TABLE `vaga_caracteristica`
  ADD PRIMARY KEY (`id_vaga`,`id_caracteristica`),
  ADD KEY `	 fk_id_caracteristica_vaga` (`id_caracteristica`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `caracteristica_quarto`
--
ALTER TABLE `caracteristica_quarto`
  MODIFY `id_caracteristica_quarto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `caracteristica_vaga`
--
ALTER TABLE `caracteristica_vaga`
  MODIFY `id_caracteristica_vaga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `carrinho`
--
ALTER TABLE `carrinho`
  MODIFY `id_carrinho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `id_pagamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `quarto`
--
ALTER TABLE `quarto`
  MODIFY `id_quarto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `reserva`
--
ALTER TABLE `reserva`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `vaga`
--
ALTER TABLE `vaga`
  MODIFY `id_vaga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `carrinho`
--
ALTER TABLE `carrinho`
  ADD CONSTRAINT `fk_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Restrições para tabelas `pagamento`
--
ALTER TABLE `pagamento`
  ADD CONSTRAINT `fK_id_carrinho` FOREIGN KEY (`id_carrinho`) REFERENCES `carrinho` (`id_carrinho`);

--
-- Restrições para tabelas `quarto_caracteristica`
--
ALTER TABLE `quarto_caracteristica`
  ADD CONSTRAINT `fk_id_caracteristica_quarto` FOREIGN KEY (`id_caracteristica`) REFERENCES `caracteristica_quarto` (`id_caracteristica_quarto`),
  ADD CONSTRAINT `fk_id_quarto` FOREIGN KEY (`id_quarto`) REFERENCES `quarto` (`id_quarto`);

--
-- Restrições para tabelas `reserva`
--
ALTER TABLE `reserva`
  ADD CONSTRAINT `fk_id_carrinho_reserva` FOREIGN KEY (`id_carrinho`) REFERENCES `carrinho` (`id_carrinho`),
  ADD CONSTRAINT `fk_id_quarto_reserva` FOREIGN KEY (`id_quarto`) REFERENCES `quarto` (`id_quarto`),
  ADD CONSTRAINT `fk_id_vaga_reserva` FOREIGN KEY (`id_vaga`) REFERENCES `vaga` (`id_vaga`);

--
-- Restrições para tabelas `vaga`
--
ALTER TABLE `vaga`
  ADD CONSTRAINT `fk_id_quarto_vaga` FOREIGN KEY (`id_quarto`) REFERENCES `vaga` (`id_vaga`);

--
-- Restrições para tabelas `vaga_caracteristica`
--
ALTER TABLE `vaga_caracteristica`
  ADD CONSTRAINT `	 fk_id_caracteristica_vaga` FOREIGN KEY (`id_caracteristica`) REFERENCES `caracteristica_vaga` (`id_caracteristica_vaga`),
  ADD CONSTRAINT `fk_id_vaga` FOREIGN KEY (`id_vaga`) REFERENCES `vaga` (`id_vaga`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
