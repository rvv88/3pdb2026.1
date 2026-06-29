----------------------------1 - Pesquisa de vagas disponíveis----------------------------
--> Verifica quantas vagas estão disponíveis dentro do quarto 1 (Quarto 100)
SELECT 
    COUNT(v.id_vaga) AS total_vagas_livres
FROM VAGA v
WHERE v.id_quarto = 1  
--> Verifica se alguma vaga do quarto está ocupada AGORA
AND v.id_vaga NOT IN (
    SELECT id_vaga 
    FROM RESERVA 
    WHERE id_vaga IS NOT NULL 
      AND status_reserva = 1 -- Status 1 = Confirmada/Ativa
      AND NOW() >= data_inicio 
      AND NOW() < data_fim
)
--> Verifica se o quarto inteiro está bloqueado por uma reserva de grupo AGORA
AND v.id_quarto NOT IN (
    SELECT id_quarto 
    FROM RESERVA 
    WHERE id_quarto IS NOT NULL 
      AND status_reserva = 1
      AND NOW() >= data_inicio 
      AND NOW() < data_fim
);

----------------------------2 - Criação de Carrinho e Reserva----------------------------
--> Cria o carrinho para o cliente Rafael (id_cliente = 1)
INSERT INTO `carrinho` (`id_cliente`, `valor_total`, `status_carrinho`) 
VALUES (1, 599.00, 1);

--> Insere a vaga escolhida na tabela de reservas, associada ao carrinho criado
INSERT INTO `reserva` (`id_carrinho`, `id_vaga`, `data_inicio`, `data_fim`, `valor_diaria`, `valor_total`, `status_reserva`) 
VALUES (1, 1, '2026-07-01 15:00:00', '2026-07-03 12:00:00', 299.50, 599.00, 1);


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
WHERE car.id_carrinho = 3;


----------------------------4 - Processamento do Pagamento----------------------------
--> Regista o sucesso do pagamento e armazena o código de transação da operadora
INSERT INTO `pagamento` (`id_carrinho`, `valor_pago`, `status_pagamento`, `codigo_transacao`) 
VALUES (1, 599.00, 2, 'tx_9F7b3D2k8L1mN4p'); -- status_pagamento 2 = Aprovado

--> Atualiza o status do carrinho de "Ativo" para "Concluído/Pago"
UPDATE `carrinho` 
SET `status_carrinho` = 3 
WHERE `id_carrinho` = 1;

--> Atualiza o status da reserva de "Aguardando" para "Confirmada"
UPDATE `reserva` 
SET `status_reserva` = 2 
WHERE `id_carrinho` = 1;
