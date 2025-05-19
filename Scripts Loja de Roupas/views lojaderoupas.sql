
-- 1. Produtos com Estoque Baixo
CREATE VIEW vw_produtos_estoque_baixo AS
SELECT p.nome, p.tamanho, p.cor, e.quantidade 
FROM Produto p
JOIN Estoque e ON p.produtoID = e.produtoID_FK
WHERE e.quantidade < 20;

-- 2. Vendas por Cliente

CREATE VIEW vw_vendas_por_cliente AS
SELECT c.nome, COUNT(v.vendaID) as total_vendas, 
       CONCAT('R$ ', FORMAT(SUM(v.valorTotal),2)) as valor_total
FROM Cliente c
JOIN Venda v ON c.cpf = v.Cliente_cpf_FK
GROUP BY c.cpf
ORDER BY SUM(v.valorTotal) DESC;

-- 3. Produtos Mais Vendidos

CREATE VIEW vw_produtos_mais_vendidos AS
SELECT p.nome, SUM(vp.quantidade) as total_vendido
FROM Produto p
JOIN VendaProduto vp ON p.produtoID = vp.produtoID_FK
GROUP BY p.produtoID
ORDER BY total_vendido DESC
LIMIT 5;

-- 4. Funcionários com Melhor Desempenho

CREATE VIEW vw_top_funcionarios AS
SELECT f.nome, COUNT(v.vendaID) as vendas_realizadas, 
       CONCAT('R$ ',FORMAT(SUM(v.valorTotal),2)) as valor_total
FROM Funcionarios f
JOIN Venda v ON f.cpf = v.Funcionarios_cpf_FK
GROUP BY f.cpf
ORDER BY SUM(v.valorTotal) DESC;

-- 5. Promoções Ativas 2024-2025

CREATE VIEW vw_promocoes_ativas AS
SELECT p.nome as produto, pr.nome as promocao, 
       pp.percentualDesconto, pr.dataInicio, pr.dataFim
FROM Produto p
JOIN ProdutoPromocao pp ON p.produtoID = pp.produtoID_FK
JOIN Promocao pr ON pp.promocaoID_FK = pr.promocaoID
WHERE pr.datainicio >= '2024-01-01' AND pr.datafim <= '2025-12-31';

-- 6. Produtos por Fornecedor

CREATE VIEW vw_produtos_fornecedores AS
SELECT f.nome as fornecedor, p.nome as produto, 
       CONCAT('R$ ',FORMAT(pf.preco_fornecedor,2)) as preco_fornecedor
FROM Fornecedor f
JOIN ProdutoFornecedor pf ON f.fornecedorID = pf.fornecedorID_FK
JOIN Produto p ON pf.produtoID_FK = p.produtoID
ORDER BY f.nome, p.nome;

-- 7. Vendas por Forma de Pagamento

CREATE VIEW vw_vendas_forma_pagamento AS
SELECT fp.tipo, COUNT(*) as total_vendas, 
       CONCAT('R$ ', FORMAT(SUM(fp.valorPago),2)) as valor_total
FROM formaPagamento fp
GROUP BY fp.tipo
ORDER BY SUM(fp.valorPago) DESC;

-- 8. Preço Médio por Marca
CREATE VIEW vw_preco_medio_marca AS
SELECT m.nome as marca, CONCAT('R$ ', FORMAT(AVG(p.preço),2)) as media_preco
FROM Marca m
JOIN Produto p ON m.marcaID = p.marcaID_FK
GROUP BY m.marcaID
ORDER BY AVG(p.preço) DESC;

-- 9. Clientes Inativos

CREATE VIEW vw_clientes_inativos AS
SELECT c.nome, c.email, c.telefone
FROM Cliente c
LEFT JOIN Venda v ON c.cpf = v.Cliente_cpf_FK
WHERE v.vendaID IS NULL;

-- 10. Produtos por Categoria
CREATE VIEW vw_produtos_por_categoria AS
SELECT c.nome as categoria, COUNT(pc.produtoID_FK) as total_produtos
FROM Categoria c
LEFT JOIN ProdutoCategoria pc ON c.categoriaID = pc.categoriaID_FK
GROUP BY c.categoriaID
ORDER BY total_produtos DESC;
