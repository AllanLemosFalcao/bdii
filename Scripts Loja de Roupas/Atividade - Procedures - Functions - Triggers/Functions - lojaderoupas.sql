-- 1. Função para obter a quantidade total de um produto vendido

CREATE FUNCTION GetQuantidadeTotalVendidaProduto(pprodutoID INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE totalVendida INT;
    SELECT SUM(quantidade) INTO totalVendida
    FROM VendaProduto
    WHERE produtoID_FK = pprodutoID;
    RETURN IFNULL(totalVendida, 0);
END $$
DELIMITER ;

SELECT 
    p.produtoID,
    p.nome AS 'Nome do Produto',
    GetQuantidadeTotalVendidaProduto(p.produtoID) AS 'Quantidade Total Vendida'
FROM 
    Produto p
ORDER BY 
    GetQuantidadeTotalVendidaProduto(p.produtoID) DESC;

-- 1. Função para obter a quantidade total de um produto vendido - -Fim

-- 2.function calcular idade do cadastro do produto 

DELIMITER $$
CREATE FUNCTION fn_IdadeProduto(
    pprodutoID INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_idade INT DEFAULT 0;
    DECLARE v_data_cadastro DATE;
    
    SELECT dataCadastro INTO v_data_cadastro
    FROM Produto
    WHERE produtoID = pprodutoID;
    
    IF v_data_cadastro IS NOT NULL THEN
        SET v_idade = DATEDIFF(CURDATE(), v_data_cadastro);
    END IF;
    
    RETURN v_idade;
END $$

DELIMITER ;

SELECT 
    p.produtoID,
    p.nome,
    p.dataCadastro,
    fn_IdadeProduto(p.produtoID) as idade_em_dias
FROM Produto p
WHERE p.dataCadastro IS NOT NULL
ORDER BY idade_em_dias DESC;

-- 2.function calcular idade do cadastro do produto - Fim 


-- 3. FUNCTION: Calcular total de vendas de um funcionário

DELIMITER $

CREATE FUNCTION fn_TotalVendasFuncionario(
    p_cpf_funcionario VARCHAR(14),
    p_ano INT
) RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0;
    
    SELECT COALESCE(SUM(valorTotal), 0) INTO v_total
    FROM Venda
    WHERE Funcionarios_cpf_FK = p_cpf_funcionario
    AND YEAR(dataVenda) = p_ano;
    
    RETURN v_total;
END $$

DELIMITER ;

SELECT 
    f.nome as funcionario,
    fn_TotalVendasFuncionario(f.cpf, 2023) as vendas_2023
FROM Funcionarios f
WHERE f.cpf IN ('111.222.333-44', '222.333.444-55', '000.111.222-33')
ORDER BY vendas_2023 DESC;
-- 3. FUNCTION: Calcular total de vendas de um funcionário FIM

-- 4. Função para retornar o número total de produtos em estoque para um determinado fornecedor
DELIMITER $$

CREATE FUNCTION GetTotalProdutosFornecedor(p_fornecedorID INT)
RETURNS INT
BEGIN
    DECLARE totalProdutos INT;
    SELECT COUNT(DISTINCT produtoID_FK) INTO totalProdutos
    FROM Estoque
    WHERE fornecedorID_FK = p_fornecedorID;
    RETURN IFNULL(totalProdutos, 0);
END $$
DELIMITER ;

SELECT GetTotalProdutosFornecedor(1) AS 'Total de Produtos (Fornecedor ID 1)';

SELECT 
    f.fornecedorID,
    f.nome AS 'Nome do Fornecedor',
    GetTotalProdutosFornecedor(f.fornecedorID) AS 'Total de Produtos'
FROM 
    Fornecedor f
ORDER BY 
    GetTotalProdutosFornecedor(f.fornecedorID) DESC;
-- 4. Função para retornar o número total de produtos em estoque para um determinado fornecedor -- FIM

-- 5. Função para calcular o preço com desconto de um produto em uma promoção específica
delimiter $$
CREATE FUNCTION CalcularPrecoComDesconto(p_produtoID INT, p_promocaoID INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE precoOriginal DECIMAL(10,2);
    DECLARE desconto DECIMAL(5,2);
    DECLARE precoComDesconto DECIMAL(10,2);

    SELECT preço INTO precoOriginal
    FROM Produto
    WHERE produtoID = p_produtoID;

    SELECT percentualDesconto into desconto
    FROM ProdutoPromocao
    WHERE produtoID_FK = p_produtoID AND promocaoID_FK = p_promocaoID;

    IF desconto is not null THEN
        SET precoComDesconto = precoOriginal * (1 - (desconto / 100));
    ELSE
        SET precoComDesconto = precoOriginal;
    END IF;

    RETURN precoComDesconto;
END $$
DELIMITER ;
select CalcularPrecoComDesconto (2,5);
select * from produtopromocao pp join produto p on p.produtoID = pp.produtoID_FK JOIN Promocao pr ON pr.promocaoID = pp.promocaoID_FK order by produtoID_FK;
-- 5. Função para calcular o preço com desconto de um produto em uma promoção específica FIM--

-- 6. Função para calcular o faturamento de um produto se o estoque for vendido ao preço do produto atual FIM--
delimiter $$
create function testefaturamentovenda(pprodutoID int) 
RETURNS varchar(50) DETERMINISTIC
begin

declare quantidadeproduto int;
declare precounitario decimal(10,2);
declare faturamentovenda decimal(10,2);
declare resultado varchar(50);
	SELECT SUM(quantidade) into quantidadeproduto
	FROM Estoque e WHERE pprodutoID = e.produtoID_FK;
    
    select preço into precounitario from produto p where pprodutoID = p.produtoID;
    set faturamentovenda = quantidadeproduto * precounitario;
	set resultado = CONCAT('R$ ', FORMAT(faturamentovenda, 2));

    return resultado;
end $$
delimiter ;

select testefaturamentovenda(1);
select p.preço as 'preço_venda', p.produtoid, p.nome, e.quantidade, fornecedorID_FK from produto p join estoque e on p.produtoID = e.produtoID_FK where p.produtoid = 1;

-- 6. Função para calcular o faturamento de um produto se o estoque for vendido ao preço do produto atual FIM--
