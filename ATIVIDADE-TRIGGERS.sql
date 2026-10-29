CREATE DATABASE IF NOT EXISTS controle_estoque;
USE controle_estoque;

CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    quantidade INT
);

CREATE TABLE historico_estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT,
    quantidade_antiga INT,
    quantidade_nova INT,
    data_alteracao DATETIME
);

DELIMITER $$

CREATE TRIGGER registrar_alteracao_estoque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.quantidade <> NEW.quantidade THEN
        INSERT INTO historico_estoque (produto_id, quantidade_antiga, quantidade_nova, data_alteracao)
        VALUES (OLD.id, OLD.quantidade, NEW.quantidade, NOW());
    END IF;
END$$

DELIMITER ;

-- =========================================================================
-- PASSO A PASSO DOS TESTES E VALIDAÇÃO
-- =========================================================================

INSERT INTO produtos (nome, quantidade) VALUES ('Notebook Dell', 15);
INSERT INTO produtos (nome, quantidade) VALUES ('Mouse Sem Fio', 50);

UPDATE produtos 
SET quantidade = 12 
WHERE id = 1;

UPDATE produtos 
SET quantidade = 20 
WHERE id = 1;

SELECT * FROM historico_estoque;

