/* INSERTS para preenchimento da tabela empresa_associada */
INSERT INTO `empresa_associada` (`id_empresa`, `nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
(1, 'FAETERJ QUINTINO', '31608763000143', 4, 09000);

INSERT INTO `empresa_associada` (`nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
('TCAR', '11852124000101', 4, 15231);

INSERT INTO `empresa_associada` (`nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
('FAETERJ PETROPOLIS', '12692125000107', 4, 20321);

/* UPDATES para alteração de valor na coluna total_comissoes_acumuladas da tabela empresa_associada correspondente a id_empresa = 1. Foi escolhido id_empresa por ser o identificador único, além de ser sequencial, otimizando assim a consulta à base de dados */ 
UPDATE `empresa_associada` SET `total_comissoes_acumuladas`='10000' WHERE id_empresa = 1;

/* DELETE de linha na tabela empresa_associada, correspondente id_empresa = 3. Foi escolhido id_empresa por ser o identificador único, além de ser sequencial, otimizando assim a consulta à base de dados */ 
DELETE FROM `empresa_associada` WHERE id_empresa = 3;

/* SELECT na tabela empresa_associada para verificar todas as linhas atualizadas, garantindo que os comandos INSERT, UPDATE e DELETE foram realizados com sucesso */ 
SELECT `id_empresa`, `nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas` FROM `empresa_associada`

