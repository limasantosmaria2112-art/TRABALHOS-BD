-- ============================================================================
-- ESTRUTURA DE APOIO PARA TESTAR AS ROTINAS
-- ============================================================================

CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    nota1 DECIMAL(4,2),
    nota2 DECIMAL(4,2)
);

INSERT INTO alunos (nome, idade, nota1, nota2) VALUES
('Ana Silva', 17, 8.0, 7.5),
('Bruno Souza', 19, 5.0, 4.5),
('Carlos Oliveira', 18, 3.0, 2.5),
('Daniela Lima', 20, 9.0, 9.5),
('Eduardo Santos', 22, 6.0, 5.5);

-- Alterando o delimitador para criação de blocos complexos no MySQL
DELIMITER $$

-- ============================================================================
-- EXERCÍCIO 1: Function de Dobro
-- ============================================================================
CREATE FUNCTION dobro(numero INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN numero * 2;
END$$

-- ============================================================================
-- EXERCÍCIO 2: Function de Situação do Aluno
-- ============================================================================
CREATE FUNCTION situacao_aluno(media DECIMAL(4,2)) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF media >= 6.0 THEN
        RETURN 'Aprovado';
    ELSEIF media >= 4.0 AND media < 6.0 THEN
        RETURN 'Recuperação';
    ELSE
        RETURN 'Reprovado';
    END IF;
END$$

-- ============================================================================
-- EXERCÍCIO 3: Procedure de Consulta por Idade Mínima
-- ============================================================================
CREATE PROCEDURE buscar_alunos_por_idade(IN idade_minima INT)
BEGIN
    SELECT id, nome, idade 
    FROM alunos 
    WHERE idade >= idade_minima;
END$$

-- ============================================================================
-- EXERCÍCIO 4: Procedure de Atualização de Nota
-- ============================================================================
CREATE PROCEDURE aumentar_nota(IN aluno_id INT, IN valor_aumento DECIMAL(4,2))
BEGIN
    UPDATE alunos 
    SET nota1 = nota1 + valor_aumento 
    WHERE id = aluno_id;
END$$

-- ============================================================================
-- EXERCÍCIO 5: Integração Function e Procedure
-- ============================================================================

-- 5.1 Function auxiliar para calcular média
CREATE FUNCTION calcular_media(n1 DECIMAL(4,2), n2 DECIMAL(4,2)) 
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    RETURN (n1 + n2) / 2;
END$$

-- 5.2 Procedure que consome as funções criadas anteriormente
CREATE PROCEDURE mostrar_situacao(IN aluno_id INT)
BEGIN
    SELECT 
        nome,
        nota1,
        nota2,
        calcular_media(nota1, nota2) AS media,
        situacao_aluno(calcular_media(nota1, nota2)) AS situacao
    FROM alunos
    WHERE id = aluno_id;
END$$

-- Restaurando o delimitador padrão
DELIMITER ;
