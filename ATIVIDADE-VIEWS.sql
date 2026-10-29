-- ============================================================================
-- EXERCÍCIO 1: Clientes por Estado
-- ============================================================================

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2)
);

INSERT INTO clientes (id, nome, cidade, estado) VALUES
(1, 'Carlos Silva', 'Curitiba', 'PR'),
(2, 'Ana Souza', 'Londrina', 'PR'),
(3, 'Roberto Santos', 'São Paulo', 'SP'),
(4, 'Juliana Lima', 'Maringá', 'PR'),
(5, 'Ricardo Alves', 'Rio de Janeiro', 'RJ');

CREATE VIEW vw_clientes_pr AS
SELECT id, nome, cidade
FROM clientes
WHERE estado = 'PR';


-- ============================================================================
-- EXERCÍCIO 2: Relacionamento Clientes e Pedidos
-- ============================================================================

CREATE TABLE ex2_clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE ex2_pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    valor DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES ex2_clientes(id)
);

INSERT INTO ex2_clientes (id, nome) VALUES
(1, 'Mariana Costa'),
(2, 'Lucas Oliveira'),
(3, 'Beatriz Souza'),
(4, 'Fernando Cruz'),
(5, 'Amanda Rocha');

INSERT INTO ex2_pedidos (id, cliente_id, data_pedido, valor) VALUES
(101, 1, '2026-10-01', 150.00),
(102, 2, '2026-10-02', 320.50),
(103, 3, '2026-10-03', 75.00),
(104, 4, '2026-10-04', 450.00),
(105, 5, '2026-10-05', 120.90);

CREATE VIEW vw_pedidos_clientes AS
SELECT 
    c.nome AS nome_cliente,
    p.data_pedido,
    p.valor AS valor_pedido
FROM ex2_pedidos p
INNER JOIN ex2_clientes c ON p.cliente_id = c.id;


-- ============================================================================
-- EXERCÍCIO 3: Cálculo de Valor em Estoque
-- ============================================================================

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10, 2),
    estoque INT
);

INSERT INTO produtos (id, nome, preco, estoque) VALUES
(1, 'Notebook Pro', 4500.00, 10),
(2, 'Mouse Sem Fio', 120.00, 50),
(3, 'Teclado Mecânico', 350.00, 25),
(4, 'Monitor 24h', 1100.00, 15),
(5, 'Headset Gamer', 280.00, 30);

CREATE VIEW vw_valor_estoque AS
SELECT 
    nome AS nome_produto,
    preco AS preco_unitario,
    estoque AS quantidade_estoque,
    (preco * estoque) AS valor_total
FROM produtos;


-- ============================================================================
-- EXERCÍCIO 4: Total de Pedidos por Cliente (Agrupamento)
-- ============================================================================

CREATE TABLE ex4_clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE ex4_pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    valor DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES ex4_clientes(id)
);

INSERT INTO ex4_clientes (id, nome) VALUES
(1, 'André Souza'),
(2, 'Paula Tejeda'),
(3, 'Marcos Vinicius');

INSERT INTO ex4_pedidos (id, cliente_id, valor) VALUES
(1, 1, 100.00),
(2, 1, 50.00),
(3, 2, 250.00),
(4, 2, 120.00),
(5, 2, 30.00),
(6, 3, 500.00),
(7, 3, 450.00),
(8, 1, 200.00),
(9, 3, 150.00),
(10, 2, 90.00);

CREATE VIEW vw_total_clientes AS
SELECT 
    c.nome AS nome_cliente,
    COUNT(p.id) AS quantidade_pedidos,
    SUM(p.valor) AS valor_total_gasto
FROM ex4_clientes c
LEFT JOIN ex4_pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nome;


-- ============================================================================
-- EXERCÍCIO 5: Desempenho de Vendedores (Relatório Completo)
-- ============================================================================

CREATE TABLE vendedores (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE vendas (
    id INT PRIMARY KEY,
    vendedor_id INT,
    valor DECIMAL(10, 2),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(id)
);

INSERT INTO vendedores (id, nome) VALUES
(1, 'Carlos Alberto'),
(2, 'Patricia Silva'),
(3, 'Renato Augusto');

INSERT INTO vendas (id, vendedor_id, valor) VALUES
(1, 1, 1500.00),
(2, 1, 2300.00),
(3, 2, 850.00),
(4, 2, 4200.00),
(5, 3, 3100.00),
(6, 3, 1200.00),
(7, 1, 950.00),
(8, 2, 1750.00),
(9, 3, 2200.00),
(10, 2, 500.00);

CREATE VIEW vw_desempenho_vendedores AS
SELECT 
    v.nome AS nome_vendedor,
    COUNT(vd.id) AS quantidade_vendas,
    SUM(vd.valor) AS valor_total_vendido,
    AVG(vd.valor) AS valor_medio_vendas,
    MAX(vd.valor) AS maior_venda_realizada
FROM vendedores v
LEFT JOIN vendas vd ON v.id = vd.vendedor_id
GROUP BY v.id, v.nome;
