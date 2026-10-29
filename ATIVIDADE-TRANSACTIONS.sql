-- 1. Criação da tabela e inserção dos dados iniciais
CREATE TABLE contas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titular VARCHAR(100),
    saldo DECIMAL(10,2)
);

INSERT INTO contas (titular, saldo) 
VALUES ('Ana', 1500.00), ('Carlos', 800.00);

-- ========================================================
-- PARTE 1: Transferência com COMMIT (Ana para Carlos: R$ 300)
-- ========================================================

-- Inicia a transação
START TRANSACTION;

-- Retira R$ 300,00 da conta de Ana
UPDATE contas SET saldo = saldo - 300.00 WHERE titular = 'Ana';

-- Adiciona R$ 300,00 à conta de Carlos
UPDATE contas SET saldo = saldo + 300.00 WHERE titular = 'Carlos';

-- Consulta os saldos (Visualização temporária dentro da transação)
SELECT * FROM contas;

-- Confirme a transferência
COMMIT;

-- Consulta novamente os saldos (Valores gravados permanentemente)
SELECT * FROM contas;


-- ========================================================
-- PARTE 2: Transferência com ROLLBACK (Carlos para Ana: R$ 200)
-- ========================================================

-- Inicia uma nova transação
START TRANSACTION;

-- Retira R$ 200,00 da conta de Carlos
UPDATE contas SET saldo = saldo - 200.00 WHERE titular = 'Carlos';

-- Adiciona R$ 200,00 à conta de Ana
UPDATE contas SET saldo = saldo + 200.00 WHERE titular = 'Ana';

-- Consulta os saldos (Mostra os valores alterados temporariamente)
SELECT * FROM contas;

-- Cancela a transação e desfaz as alterações
ROLLBACK;

-- Consulta novamente os saldos
SELECT * FROM contas;
