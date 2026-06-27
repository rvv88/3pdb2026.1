------------------Tabela Caracteristica Quarto------------------
INSERT INTO `caracteristica_quarto`(`id_caracteristica_quarto`, `descricao`) VALUES ('1','banheiro privado');
INSERT INTO `caracteristica_quarto`(`descricao`) VALUES ('banheiro coletivo'),('ar condicionado'),('TV'),('frigobar'),('ventilador');  
  
--> Altera a descrição de TV para Smart TV, através do id_caracteristica_quarto
UPDATE `caracteristica_quarto` SET `descricao`='Smart TV' WHERE id_caracteristica_quarto = 4

--> Deleta a caracteristica ventilador, pois agora todos os quartos possuem ar condicionado
DELETE FROM `caracteristica_quarto` WHERE `id_caracteristica_quarto`=6

--> Exibe a lista de caracteristicas atribuidas somente aos quartos
SELECT * FROM `caracteristica_quarto` 
  

------------------Tabela Caracteristica Vaga------------------
INSERT INTO `caracteristica`(`id_caracteristica`, `descricao`) VALUES ('1','sol da manhã');
INSERT INTO `caracteristica`(`descricao`) VALUES ('sol da tarde'),('banheiro privado'),('banheiro coletivo'),('cama beliche inferior'),('cama beliche superior'),('cama de solteiro');

--> Deleta cama de solteiro como caracteristica a ser atribuida a uma vaga, uma vez que não será mais oferecida pelo albergue
DELETE FROM `caracteristica` WHERE `id_caracteristica` = 7

--> Atualizada a descrição de id_caracteristica_vaga de "sol da tarde"para "não bate sol"
UPDATE `caracteristica_vaga` SET `descricao`='não bate sol' WHERE `id_caracteristica_vaga`=2

--> Exibe a lista de caracteristicas atribuidas somente às vagas
SELECT * FROM `caracteristica_quarto` 
  

------------------Tabela Carrinho------------------
INSERT INTO `carrinho`(`id_carrinho`, `id_cliente`,`valor_total`, `status_carrinho`) VALUES ('1','1','568,00','1')
INSERT INTO `carrinho`(`id_cliente`,`valor_total`, `status_carrinho`) VALUES ('2','2120,99','1')
INSERT INTO `carrinho`(`id_cliente`,`valor_total`, `status_carrinho`) VALUES ('2','599,17','1')

-->Carrinho estava com status 1 pois estava ativo. Como o cliente abandonou o carrinho, o status foi alterado para 2. A aplicação converterá o status em texto.
UPDATE `carrinho` SET `status_carrinho` = '2' WHERE `carrinho`.`id_carrinho` = 2

-->Deleta carrinhos que estejam com status de abandonado (status_carrinho=2) e que já tenha passado 7 dias desde sua data de criação
DELETE FROM `carrinho` WHERE status_carrinho = 2 AND data_criacao < NOW() - INTERVAL 7 DAY

-->Exibe o resumo do carrinho 
SELECT 
    car.id_carrinho,
    c.nome_completo AS cliente,
    p.valor_pago,
    p.status_pagamento AS status_pagamento,
    p.codigo_transacao
FROM CARRINHO car
INNER JOIN CLIENTE c ON car.id_cliente = c.id_cliente
LEFT JOIN PAGAMENTO p ON car.id_carrinho = p.id_carrinho
WHERE car.id_carrinho = 1; 

  
------------------Tabela Cliente------------------
INSERT INTO `cliente` (`id_cliente`, `nome_completo`, `cpf`, `email`, `telefone`) VALUES
(1, 'Rafael Vieira', '86601228010', '[rvv@email.com]', '21999887766');
INSERT INTO `cliente` (`nome_completo`, `cpf`, `emai`, `telefone`) VALUES
('Andre Neves', '56078223038', '[andre@emai.com]', '2199955443322');
INSERT INTO `cliente` (`nome_completo`, `cpf`, `email`, `telefone`) VALUES
('Renato Junior', '56891918090', '[rjr@email.com]', '21999112233');

UPDATE `cliente` SET `email`='andre@email.com' WHERE `cpf`=56078223038;
UPDATE `cliente` SET `email`='rvv@email.com' WHERE `cpf`=86601228010;

--> Seleciona clientes que efetuaram reserva e a pagaram a partir de 01/01/2026
SELECT DISTINCT
    c.id_cliente, 
    c.nome_completo, 
    c.cpf, 
    c.email, 
    c.telefone 
FROM 
    cliente c
INNER JOIN 
    carrinho cr ON c.id_cliente = cr.id_cliente
WHERE 
    cr.data_criacao >= '2026-01-01 00:00:00' AND cr.status_carrinho = 1;

DELETE FROM `cliente` WHERE `cpf` = 56891918090;


------------------Tabela Pagamento------------------
INSERT INTO `pagamento`(`id_pagamento`, `id_carrinho`, `valor_pago`, `status_pagamento`) VALUES ('1','1','568','1')
INSERT INTO `pagamento`(`id_carrinho`, `valor_pago`, `status_pagamento`) VALUES ('3','599','1')

-->Pagamento confirmado
-->Atualiza status de pagamento para PAGO, recebe e armazena o token da transação do cartão de crédito e atualiza valor pago, de acordo com as condições de pagamento(a vista, a prazo)
 UPDATE `pagamento` SET `valor_pago`='599,00',`status_pagamento`='2',`codigo_transacao`='tx_9F7b3D2k8L1mN4p' WHERE `id_pagamento`=2  
-->Atualiza status do carrinho de Aguardando pagamento para pago
UPDATE `carrinho` SET `status_carrinho` = 3;
  
-->Pagamento recusado
-->Atualiza status de pagamento para RECUSADO(`status_pagamento`='4')
 UPDATE `pagamento` SET `status_pagamento`='4' WHERE `id_pagamento`=1  
-->Atualiza carrinho paga status de aguardando pagamento(`status_carrinho` = '4')
UPDATE `carrinho` SET `status_carrinho` = '4' WHERE `carrinho`.`id_carrinho` = 1
  
DELETE -->Informações sobre pagamento não podem ser excluídas e ficam como histórico permanente. Ao invés de deletar um pagamento, como no caso dele ser negado, a tabela deve usar o UPDATE para alterar o status de pagamento. O histórico permanece!

--> Exibie os pagamentos realizados de acordo com o dia da consulta inserida pelo usuario.
SELECT 
    DATE(data_pagamento) AS dia_consultado,
    COUNT(id_pagamento) AS total_vendas_aprovadas,
    SUM(valor_pago) AS faturamento_liquido
FROM PAGAMENTO
WHERE status_pagamento = 2 AND DATE(data_pagamento) = '2026-06-27';


------------------Tabela Quarto------------------
INSERT INTO `quarto`(`id_quarto`, `numero_quarto`, `capacidade_vagas`) VALUES ('1','100','4');
INSERT INTO `quarto`(`numero_quarto`, `capacidade_vagas`) VALUES ('101','8'),('102','12');
INSERT INTO `quarto`(`numero_quarto`, `capacidade_vagas`) VALUES ('103','16');

--> Busca deleta o quarto listado com capacidade para 16 vagas. O novo limite de vagas é 12 por quarto.
DELETE FROM `quarto` WHERE `capacidade_vagas`=16;

--> Busca quais quartos possuem banheiro privado
SELECT DISTINCT
    qt.id_quarto, 
    qt.numero_quarto, 
    qt.capacidade_vagas
FROM 
    quarto qt
INNER JOIN 
    quarto_caracteristica cqt ON qt.id_quarto = cqt.id_quarto
WHERE 
    cqt.id_caracteristica = 1 ;

--> Atualizada a capacidade_vagas= de "8" para "4" no quarto 101
UPDATE `quarto` SET `capacidade_vagas`='4' WHERE `numero_quarto`=101;


------------------Tabela Quarto_Caracteristica------------------
INSERT INTO `quarto_caracteristica`(`id_quarto`, `id_caracteristica`) VALUES ('1','1')
INSERT INTO `quarto_caracteristica`(`id_quarto`, `id_caracteristica`) VALUES ('3','1')
INSERT INTO `quarto_caracteristica`(`id_quarto`, `id_caracteristica`) VALUES ('1','2')
INSERT INTO `quarto_caracteristica`(`id_quarto`, `id_caracteristica`) VALUES ('1','2')


-->Atualiza caracteristica do quarto de id_quarto = 1. Agora quarto de 1(num 100) tem banheiro privativo e ar condicionado
UPDATE `quarto_caracteristica` SET `id_caracteristica` = '3' WHERE `quarto_caracteristica`.`id_quarto` = 1 AND `quarto_caracteristica`.`id_caracteristica` = 2

DELETE --> O comando DELETE não pode ser aplicado diretamente a esta tabela associativa por possuir exclusivamente chaves do tipo PK/FK. Para realizar a exclusão seria necessário alterar as restrições das chaves estrangeiras
  
-->Exibe a lista de quartos e suas caracteristicas
SELECT 
    q.id_quarto,
    q.numero_quarto,
    cq.descricao
FROM QUARTO q
LEFT JOIN QUARTO_CARACTERISTICA qc ON q.id_quarto = qc.id_quarto
LEFT JOIN CARACTERISTICA_QUARTO cq ON qc.id_caracteristica = cq.id_caracteristica_quarto;


------------------Tabela Reserva------------------
INSERT INTO `reserva`(`id_reserva`, `id_carrinho`, `id_quarto`, `data_inicio`, `data_fim`, `valor_diaria`, `valor_total`, `status_reserva`) VALUES ('1','3','1','2026-07-01 15:00:00','2026-07-03 12:00:00','299,50','599,00','1')

-->Alteração de STATUS de reserva devido a CHECKIN do hóspede no hotel. Alterado de Reservado(status_reserva=1) para CheckedIn(status_reserva=2)
-->Alteração feita ao garantir que o status da reserva não estava como cancelado antes de alterar
UPDATE `reserva` SET `status_reserva`= 2 WHERE id_reserva=1 AND status_reserva = 1 

--> Exibie as reservas de acordo com o dia da consulta inserida pelo usuario.
SELECT 
    COALESCE(q_inteiro.numero_quarto, q_vaga.numero_quarto) AS numero_quarto,
    c.nome_completo AS nome_cliente,
    r.data_inicio AS data_entrada,
    r.data_fim AS data_saida,
    r.status_reserva
FROM RESERVA r
INNER JOIN CARRINHO car ON r.id_carrinho = car.id_carrinho
INNER JOIN CLIENTE c ON car.id_cliente = c.id_cliente
-- JOIN para quando for reserva de quarto inteiro
LEFT JOIN QUARTO q_inteiro ON r.id_quarto = q_inteiro.id_quarto
-- JOINs em cadeia para quando for reserva de vaga individual
LEFT JOIN VAGA v ON r.id_vaga = v.id_vaga
LEFT JOIN QUARTO q_vaga ON v.id_quarto = q_vaga.id_quarto

-- FILTRO: Mostra as reservas que estão acontecendo HOJE
WHERE DATE(r.data_inicio) = '2026-07-01'



------------------Tabela Vaga------------------
INSERT INTO `vaga`(`id_vaga`, `id_quarto`) VALUES ('1','1')
INSERT INTO `vaga`(`id_quarto`) VALUES ('1'),('1'),('1');
INSERT INTO `vaga`(`id_quarto`) VALUES ('2'),('2'),('2'),('2');

--> Verifica, no momento da consulta, quantas vagas estão disponiveis dentro do quarto selecionado
SELECT 
    COUNT(v.id_vaga) AS total_vagas_livres
FROM VAGA v
WHERE v.id_quarto = 1  
-- REGRA 1: Verifica se alguma vaga do quarto está ocupada AGORA
AND v.id_vaga NOT IN (
    SELECT id_vaga 
    FROM RESERVA 
    WHERE id_vaga IS NOT NULL 
      AND status_reserva = 1
      -- Verifica se o "agora" está entre o check-in e o check-out:
      AND NOW() >= data_inicio 
      AND NOW() < data_fim
)

-- REGRA 2: Verifica se o quarto inteiro está bloqueado AGORA
AND v.id_quarto NOT IN (
    SELECT id_quarto 
    FROM RESERVA 
    WHERE id_quarto IS NOT NULL 
      AND status_reserva = 1
      -- Verifica se o "agora" está entre o check-in e o check-out:
      AND NOW() >= data_inicio 
      AND NOW() < data_fim
);


------------------Tabela Vaga Caracteristica------------------
INSERT INTO `vaga_caracteristica`(`id_vaga`, `id_caracteristica`) VALUES ('1','6'),('1','2'),('2','5'),('2','2'),('3','1'),('3','2');
INSERT INTO `vaga_caracteristica`(`id_vaga`, `id_caracteristica`) VALUES ('1','6'),('1','2'),('2','5'),('2','2'),('3','1'),('3','2');
INSERT INTO `vaga_caracteristica`(`id_vaga`, `id_caracteristica`) VALUES ('5','6'),('5','2'),('6','5'),('6','2'),('7','1'),('8','2');

-->Atualiza caracteristicas da vaga de id_vaga=3
UPDATE `vaga_caracteristica` SET `id_caracteristica` = '4' WHERE `vaga_caracteristica`.`id_vaga` = 3 AND `vaga_caracteristica`.`id_caracteristica` = 2

DELETE --> O comando DELETE não pode ser aplicado diretamente a esta tabela associativa por possuir exclusivamente chaves do tipo PK/FK. Para realizar a exclusão seria necessário alterar as restrições das chaves estrangeiras

-->Exibe a lista de vagas e suas caracteristicas dentro do quarto. Utilizado quarto id_quarto = 1
SELECT 
    v.id_vaga,
    q.numero_quarto,
    GROUP_CONCAT(cv.descricao SEPARATOR ', ') AS todas_caracteristicas
FROM VAGA v
INNER JOIN QUARTO q ON v.id_quarto = q.id_quarto
LEFT JOIN VAGA_CARACTERISTICA vc ON v.id_vaga = vc.id_vaga
LEFT JOIN CARACTERISTICA_VAGA cv ON vc.id_caracteristica = cv.id_caracteristica_vaga
WHERE v.id_quarto = 1 
GROUP BY v.id_vaga, q.numero_quarto;



