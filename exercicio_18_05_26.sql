INSERT INTO `empresa_associada` (`id_empresa`, `nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
(1, 'FAETERJ QUINTINO', '31608763000143', 4, 09000);

INSERT INTO `empresa_associada` (`nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
('TCAR', '11852124000101', 4, 15231);

INSERT INTO `empresa_associada` (`nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas`) VALUES
('FAETERJ PETROPOLIS', '12692125000107', 4, 20321);

UPDATE `empresa_associada` SET `total_comissoes_acumuladas`='10000' WHERE id_empresa = 1;

DELETE FROM `empresa_associada` WHERE id_empresa = 3;

SELECT `id_empresa`, `nome_razao_social`, `cnpj`, `pencetual_comissao`, `total_comissoes_acumuladas` FROM `empresa_associada`

