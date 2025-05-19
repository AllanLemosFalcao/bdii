-- 1. Listar produtos com estoque baixo (menos de 20 unidades)
SELECT p.nome, p.tamanho, p.cor, e.quantidade 
FROM Produto p
JOIN Estoque e ON p.produtoID = e.produtoID_FK
WHERE e.quantidade < 20;

-- 2. Vendas por cliente com valor total
SELECT c.nome, COUNT(v.vendaID) as total_vendas, concat('R$ ', format(SUM(v.valorTotal),2)) as valor_total
FROM Cliente c
JOIN Venda v ON c.cpf = v.Cliente_cpf_FK
GROUP BY c.cpf
ORDER BY valor_total DESC;


-- 3. Produtos mais vendidos
SELECT p.nome, SUM(vp.quantidade) as total_vendido
FROM Produto p
JOIN VendaProduto vp ON p.produtoID = vp.produtoID_FK
GROUP BY p.produtoID
ORDER BY total_vendido DESC
LIMIT 5;

-- 4. Funcionários que mais venderam em R$
SELECT f.nome, COUNT(v.vendaID) as vendas_realizadas, concat('R$ ',format(SUM(v.valorTotal),2)) as valor_total
FROM Funcionarios f
JOIN Venda v ON f.cpf = v.Funcionarios_cpf_FK
GROUP BY f.cpf
ORDER BY valor_total DESC;

-- 5. Produtos em promoção do inicio do ano 2024 até o fim.
SELECT p.nome, pr.nome as promocao, pp.percentualDesconto, pr.dataInicio, pr.dataFim
FROM Produto p
JOIN ProdutoPromocao pp ON p.produtoID = pp.produtoID_FK
JOIN Promocao pr ON pp.promocaoID_FK = pr.promocaoID
WHERE datainicio >= '2024-01-01' and datafim <= '2025-12-31';

select * from Promocao;

-- 6. Fornecedores e seus produtos
SELECT f.nome as fornecedor, p.nome as produto, concat('R$ ',format(pf.preco_fornecedor,2))
FROM Fornecedor f
JOIN ProdutoFornecedor pf ON f.fornecedorID = pf.fornecedorID_FK
JOIN Produto p ON pf.produtoID_FK = p.produtoID
ORDER BY f.nome, p.nome;

-- 7. Vendas por forma de pagamento
SELECT fp.tipo, COUNT(*) as total_vendas, concat('R$ ', format(SUM(fp.valorPago),2)) as valor_total
FROM formaPagamento fp
GROUP BY fp.tipo
ORDER BY valor_total DESC;

-- 8. Média de preço por marca
SELECT m.nome as marca, concat('R$ ', format(AVG(p.preço),2)) as media_preco
FROM Marca m
JOIN Produto p ON m.marcaID = p.marcaID_FK
GROUP BY m.marcaID
ORDER BY media_preco DESC;

-- 9. Clientes que nunca compraram
SELECT c.nome, c.email, c.telefone
FROM Cliente c
LEFT JOIN Venda v ON c.cpf = v.Cliente_cpf_FK
WHERE v.vendaID IS NULL;

-- 10. Produtos por categoria
SELECT c.nome as categoria, COUNT(pc.produtoID_FK) as total_produtos
FROM Categoria c
LEFT JOIN ProdutoCategoria pc ON c.categoriaID = pc.categoriaID_FK
GROUP BY c.categoriaID
ORDER BY total_produtos DESC;

-- 11. Total de venda por mês e valor vendido para cada mês
SELECT 
  DATE_FORMAT(dataVenda, '%Y-%m') AS mes, 
  COUNT(*) AS total_vendas, 
  concat('R$ ', format(SUM(valorTotal),2)) AS valor_total
FROM Venda
WHERE dataVenda BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY mes
ORDER BY mes;



-- 12. Produtos com maior margem de lucro
SELECT 
  p.nome, 
  CONCAT('R$ ', FORMAT(p.preço, 2)) AS preco_venda,
  CONCAT('R$ ', FORMAT(AVG(pf.preco_fornecedor), 2)) AS preco_fornecedor,
  CONCAT('R$ ', FORMAT(p.preço - AVG(pf.preco_fornecedor), 2)) AS lucro_unitario
FROM Produto p
JOIN ProdutoFornecedor pf ON p.produtoID = pf.produtoID_FK
GROUP BY p.produtoID
ORDER BY lucro_unitario DESC
LIMIT 10;

-- 13. Clientes por estado
SELECT ec.uf, COUNT(DISTINCT ec.Cliente_cpf_FK) as total_clientes
FROM EnderecoCliente ec
GROUP BY ec.uf
ORDER BY total_clientes DESC;

-- 14. Produtos sem estoque
SELECT p.nome,m.nome as marca, c.nome as categoria, p.tamanho, p.cor
FROM Produto p
LEFT JOIN Estoque e ON p.produtoID = e.produtoID_FK
left join produtocategoria pc on p.produtoID = pc.produtoID_FK
left join categoria c on pc.categoriaID_FK = c.categoriaID
LEFT JOIN marca m ON p.marcaID_FK = m.marcaID
WHERE e.quantidade IS NULL OR e.quantidade = 0;

-- 15. Produtos mais vendidos com desconto
select p.nome, vp.desconto as desconto, vp.quantidade as quantidade
from produto p
join vendaproduto vp on p.produtoID = vp.produtoID_FK where vp.desconto > 0
ORDER BY vp.quantidade DESC;


-- 16. Fornecedores com mais produtos disponibilizados
SELECT f.nome, COUNT(pf.produtoID_FK) as total_produtos
FROM Fornecedor f
JOIN ProdutoFornecedor pf ON f.fornecedorID = pf.fornecedorID_FK
GROUP BY f.fornecedorID
ORDER BY total_produtos DESC
LIMIT 5;

-- 17. Histórico de preços de produtos por nome do produto, marca, fornecedor, data de entrada, preço de entrada e quantidade
SELECT 
  p.nome AS nome_produto,
  m.nome AS marca,
  f.nome as fornecedor,
  concat('R$ ', e.preco_entrada) as preço_entrada,
  e.quantidade,
  e.data_entrada
FROM Estoque e
JOIN Produto p ON e.produtoID_FK = p.produtoID
JOIN Marca m ON p.marcaID_FK = m.marcaID
join fornecedor f on e.fornecedorID_FK = f.fornecedorID
WHERE e.preco_entrada IS NOT NULL
ORDER BY p.nome, e.data_entrada;

-- 18. Média de valor de venda por funcionário
SELECT f.nome, concat('R$ ', format(AVG(v.valorTotal), 2)) as media_venda
FROM Funcionarios f
JOIN Venda v ON f.cpf = v.Funcionarios_cpf_FK
GROUP BY f.cpf
ORDER BY media_venda DESC;

-- 19. Produtos nunca vendidos
SELECT p.nome, concat('R$ ', format(p.preço, 2)) as preço, m.nome as marca
FROM Produto p
JOIN Marca m ON p.marcaID_FK = m.marcaID
LEFT JOIN VendaProduto vp ON p.produtoID = vp.produtoID_FK
WHERE vp.vendaProdutoID IS NULL;

-- 20. Categorias mais populares em vendas
SELECT c.nome as categoria, SUM(vp.quantidade) as total_vendido
FROM Categoria c
JOIN ProdutoCategoria pc ON c.categoriaID = pc.categoriaID_FK
JOIN VendaProduto vp ON pc.produtoID_FK = vp.produtoID_FK
GROUP BY c.categoriaID
ORDER BY total_vendido DESC
LIMIT 5;
