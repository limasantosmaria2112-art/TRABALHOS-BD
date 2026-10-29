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

START TRANSACTION;

UPDATE contas SET saldo = saldo - 300.00 WHERE titular = 'Ana';

UPDATE contas SET saldo = saldo + 300.00 WHERE titular = 'Carlos';

SELECT * FROM contas;

COMMIT;

SELECT * FROM contas;


-- ========================================================
-- PARTE 2: Transferência com ROLLBACK (Carlos para Ana: R$ 200)
-- ========================================================

START TRANSACTION;

UPDATE contas SET saldo = saldo - 200.00 WHERE titular = 'Carlos';

UPDATE contas SET saldo = saldo + 200.00 WHERE titular = 'Ana';

SELECT * FROM contas;

ROLLBACK;

SELECT * FROM contas;
