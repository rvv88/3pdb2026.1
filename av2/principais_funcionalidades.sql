----------------------------1 - Pesquisa de vagas disponíveis----------------------------
--> Verifica quantas vagas estão disponíveis dentro do quarto 1 (Quarto 100) de 10/07/2026 a 15/07/2026.
-- Regras: 
--   A) Se o quarto inteiro estiver reservado por um grupo, as vagas individuais somem.
--   B) Se houver qualquer vaga individual ocupada, o quarto inteiro fica indisponível.

SELECT 
    COUNT(v.id_vaga) AS total_vagas_livres
FROM vaga v

--> Busca reservas de vagas individuais que conflitam com o período desejado
LEFT JOIN reserva r_vaga ON v.id_vaga = r_vaga.id_vaga 
    AND r_vaga.status_reserva = 2 -- Status 2 = Confirmada/Ativa
    AND r_vaga.id_vaga IS NOT NULL
    AND r_vaga.data_inicio < '2026-07-15 12:00:00' -- Data de término desejada
    AND r_vaga.data_fim > '2026-07-10 15:00:00'   -- Data de início desejada

--> Procura se o quarto inteiro foi reservado por alguém no período desejado
LEFT JOIN reserva r_quarto ON v.id_quarto = r_quarto.id_quarto 
    AND r_quarto.status_reserva = 2
    AND r_quarto.id_quarto IS NOT NULL
    AND r_quarto.id_vaga IS NULL -- Garante que é uma reserva do cômodo inteiro
    AND r_quarto.data_inicio < '2026-07-15 12:00:00'
    AND r_quarto.data_fim > '2026-07-10 15:00:00'

-- Procura se EXISTE QUALQUER OUTRA VAGA ocupada neste mesmo quarto no período desejado
LEFT JOIN vaga v_aux ON v.id_quarto = v_aux.id_quarto
LEFT JOIN reserva r_vaga_bloqueio ON v_aux.id_vaga = r_vaga_bloqueio.id_vaga
    AND r_vaga_bloqueio.status_reserva = 2
    AND r_vaga_bloqueio.data_inicio < '2026-07-15 12:00:00' 
    AND r_vaga_bloqueio.data_fim > '2026-07-10 15:00:00'

WHERE v.id_quarto = 1 
    AND r_vaga.id_reserva IS NULL        
    AND r_quarto.id_reserva IS NULL

----------------------------2 - Criação de Carrinho e Reserva----------------------------
--> Cria o carrinho para o cliente Rafael (id_cliente = 1)
INSERT INTO `carrinho` (`id_cliente`, `valor_total`, `status_carrinho`) 
VALUES (1, 599.00, 1);

--> Insere a vaga escolhida na tabela de reservas, associada ao carrinho criado
INSERT INTO `reserva` (`id_carrinho`, `id_vaga`, `id_quarto`, `data_inicio`, `data_fim`, `valor_diaria`, `valor_total`, `status_reserva`) 
VALUES (LAST_INSERT_ID(), 1, NULL, '2026-07-01 15:00:00', '2026-07-03 12:00:00', 299.50, 599.00, 1); -- Status 1 = Aguardando Pagamento


----------------------------3 - Visualização do Carrinho----------------------------
--> 3. Procura os detalhes do carrinho ativo (id_carrinho = 3) para exibir na tela de checkout
SELECT 
    car.id_carrinho,
    c.nome_completo AS cliente,
    -->Nomeia o tipo da reserva
    CASE 
        WHEN r.id_vaga IS NOT NULL THEN 'Vaga Individual'
        WHEN r.id_quarto IS NOT NULL THEN 'Quarto Inteiro'
        ELSE 'Não identificado'
    END AS tipo_item,
    
    CASE 
        WHEN r.id_vaga IS NOT NULL THEN q_vaga.numero_quarto
        WHEN r.id_quarto IS NOT NULL THEN q_inteiro.numero_quarto
    END AS numero_quarto,
    
    r.data_inicio AS data_entrada,
    r.data_fim AS data_saida,
    car.valor_total
FROM CARRINHO car
INNER JOIN CLIENTE c ON car.id_cliente = c.id_cliente
INNER JOIN RESERVA r ON car.id_carrinho = r.id_carrinho
LEFT JOIN QUARTO q_inteiro ON r.id_quarto = q_inteiro.id_quarto
LEFT JOIN VAGA v ON r.id_vaga = v.id_vaga
LEFT JOIN QUARTO q_vaga ON v.id_quarto = q_vaga.id_quarto
WHERE car.id_carrinho = 1;


----------------------------4 - Processamento do Pagamento e Confirmação----------------------------
--> Registra o sucesso do pagamento para o carrinho 1
INSERT INTO `pagamento` (`id_carrinho`, `valor_pago`, `status_pagamento`, `codigo_transacao`) 
VALUES (1, 599.00, 2, 'tx_9F7b3D2k8L1mN4p'); -- status_pagamento 2 = Aprovado

--> Atualiza o status de TODAS as reservas daquele carrinho de "Aguardando (1)" para "Confirmada (2)"
UPDATE `reserva` 
SET `status_reserva` = 2 
WHERE `id_carrinho` = 1; 

--> Limpando o carrinho após confirmação de pagamento
DELETE FROM `carrinho` 
WHERE `id_carrinho` = 1;

-- Ao deletar o carrinho, os dados em `reserva` e `pagamento` permanecerão salvos com id_carrinho = NULL.
