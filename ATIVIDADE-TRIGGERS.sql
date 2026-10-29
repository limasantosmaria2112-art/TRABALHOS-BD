-- 1. Criação do Banco de Dados (Opcional, para organização)
CREATE DATABASE IF NOT EXISTS controle_estoque;
USE controle_estoque;

-- 2. Criação da Tabela Produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    quantidade INT
);

-- 3. Criação da Tabela Histórico de Estoque
CREATE TABLE historico_estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT,
    quantidade_antiga INT,
    quantidade_nova INT,
    data_alteracao DATETIME
);

-- 4. Criação da Trigger (Gatilho)
DELIMITER $$

CREATE TRIGGER registrar_alteracao_estoque
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    -- Verifica se a quantidade realmente mudou antes de inserir no histórico
    IF OLD.quantidade <> NEW.quantidade THEN
        INSERT INTO historico_estoque (produto_id, quantidade_antiga, quantidade_nova, data_alteracao)
        VALUES (OLD.id, OLD.quantidade, NEW.quantidade, NOW());
    END IF;
END$$

DELIMITER ;

-- =========================================================================
-- PASSO A PASSO DOS TESTES E VALIDAÇÃO
-- =========================================================================

-- Passo 1: Inserir pelo menos 2 produtos
INSERT INTO produtos (nome, quantidade) VALUES ('Notebook Dell', 15);
INSERT INTO produtos (nome, quantidade) VALUES ('Mouse Sem Fio', 50);

-- Passo 2: Alterar a quantidade de um dos produtos utilizando UPDATE (Primeira alteração)
-- Vamos alterar o Notebook (id 1) de 15 para 12 unidades
UPDATE produtos 
SET quantidade = 12 
WHERE id = 1;

-- Passo 3: Alterar novamente a quantidade desse mesmo produto (Segunda alteração)
-- Vamos alterar o Notebook (id 1) de 12 para 20 unidades
UPDATE produtos 
SET quantidade = 20 
WHERE id = 1;

-- Passo 4: Consultar a tabela historico_estoque para verificar os registros
SELECT * FROM historico_estoque;

