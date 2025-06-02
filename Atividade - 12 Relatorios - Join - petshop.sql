-- INSERT's PARA O PRIMEIRO RELATORIO MOSTRAR DADOS DE 2019 ATÉ 2022 --

INSERT INTO Empregado (cpf, nome, sexo, email, ctps, cargo, dataAdm, dataDem, salario, comissao, bonificacao, Departamento_idDepartamento)
VALUES
    ('443.456.789-00', 'Ana Silva', 'F', 'ana.silva@email.com', '54321', 'Veterinária', '2019-03-15', NULL, 4200.00, 350.00, 80.00, 1),
    ('444.567.890-11', 'Carlos Oliveira', 'M', 'carlos.oliveira@email.com', '67890', 'Tosador', '2019-07-22', NULL, 3800.00, 300.00, 70.00, 2),
    ('345.448.901-22', 'Mariana Costa', 'F', 'mariana.costa@email.com', '98765', 'Atendente', '2020-01-10', NULL, 3200.00, 250.00, 60.00, 3),
    ('456.444.012-33', 'Pedro Santos', 'M', 'pedro.santos@email.com', '12398', 'Gerente', '2020-05-18', NULL, 4800.00, 450.00, 90.00, 2),
    ('567.444.123-44', 'Juliana Pereira', 'F', 'juliana.pereira@email.com', '45673', 'Veterinária', '2020-11-05', NULL, 4300.00, 380.00, 85.00, 1),
    ('678.944.234-55', 'Ricardo Almeida', 'M', 'ricardo.almeida@email.com', '78901', 'Tosador', '2021-02-28', NULL, 3900.00, 320.00, 75.00, 2),
    ('789.044.345-66', 'Fernanda Lima', 'F', 'fernanda.lima@email.com', '23456', 'Atendente', '2021-06-15', NULL, 3300.00, 270.00, 65.00, 3),
    ('890.443.456-77', 'Lucas Souza', 'M', 'lucas.souza@email.com', '56789', 'Veterinário', '2021-09-30', NULL, 4400.00, 400.00, 95.00, 1),
    ('901.444.567-88', 'Patrícia Rocha', 'F', 'patricia.rocha@email.com', '34567', 'Gerente', '2022-01-20', NULL, 4900.00, 480.00, 100.00, 3),
    ('044.345.644-99', 'Roberto Martins', 'M', 'roberto.martins@email.com', '89012', 'Tosador', '2022-04-10', NULL, 4000.00, 350.00, 80.00, 2);
-- INSERT's PARA O PRIMEIRO RELATORIO MOSTRAR DADOS DE 2019 ATÉ 2022 --


-- 1. adimissão 2019 até 2022, (Nome Empregado, CPF Empregado, Data Admissão,  Salário, Departamento, Número de Telefone), ordenado por data de admissão decrescente --

SELECT
    e.nome AS "Nome Empregado",
    e.cpf AS "CPF Empregado",
    e.dataAdm AS "Data Admissão",
	concat('R$ ', format(e.salario, 2))  AS "Salário",
    d.nome AS "Departamento",
    (SELECT GROUP_CONCAT(t.numero SEPARATOR ', ') FROM Telefone t WHERE t.Empregado_cpf = e.cpf) AS "Número de Telefone"
FROM
    Empregado e
JOIN
    Departamento d ON e.Departamento_idDepartamento = d.idDepartamento
WHERE
    e.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY
    e.dataAdm DESC;

-- 2. Lista dos empregados que ganham menos que a média salarial dos funcionários do Petshop, (Nome Empregado, CPF Empregado, Data Admissão,  Salário, Departamento, Número de Telefone), ordenado por nome do empregado --

SELECT e.nome AS 'Nome Empregado', e.cpf AS 'CPF Empregado', 
       e.dataAdm AS 'Data Admissão', concat('R$ ', format(e.salario,2)) AS 'Salário', 
       d.nome AS 'Departamento', t.numero AS 'Número de Telefone'
FROM Empregado e
JOIN Departamento d ON e.Departamento_idDepartamento = d.idDepartamento
LEFT JOIN Telefone t ON e.cpf = t.Empregado_cpf
WHERE e.salario < (SELECT AVG(salario) FROM Empregado)
ORDER BY e.nome;

-- 3. Lista dos departamentos com a quantidade de empregados total por cada departamento + media salario e comissão, (Departamento, Quantidade de Empregados, Média Salarial, Média da Comissão), ordenado por nome do departamento --

SELECT d.nome AS 'Departamento', 
       COUNT(e.cpf) AS 'Quantidade de Empregados',
       concat('R$ ',format(AVG(e.salario),2)) AS 'Média Salarial',
       concat('R$ ', format(AVG(e.comissao),2)) AS 'Média da Comissão'
FROM Departamento d
LEFT JOIN Empregado e ON d.idDepartamento = e.Departamento_idDepartamento
GROUP BY d.idDepartamento
ORDER BY d.nome;

-- 4. Lista dos empregados com a quantidade total de vendas já realiza por cada Empregado, soma total vendas e comissoes, (Nome Empregado, CPF Empregado, Sexo, Salário, Quantidade Vendas, Total Valor Vendido, Total Comissão das Vendas), ordenado por quantidade total de vendas realizadas --

SELECT e.nome AS 'Nome Empregado', e.cpf AS 'CPF Empregado', 
       e.sexo AS 'Sexo', concat('R$ ', format(e.salario, 2)) AS 'Salário',
       COUNT(v.idVenda) AS 'Quantidade Vendas',
       concat('R$ ', format(SUM(v.valor),2)) AS 'Total Valor Vendido',
       concat('R$ ', format(SUM(v.comissao),2)) AS 'Total Comissão das Vendas'
FROM Empregado e
LEFT JOIN Venda v ON e.cpf = v.Empregado_cpf
GROUP BY e.cpf
ORDER BY COUNT(v.idVenda) DESC;

-- 5. Lista dos empregados que prestaram Serviço na venda, quantidade total de vendas com serviço por Empregado, soma do valor total apurado pelos serviços nas vendas por empregado e a soma de suas comissões,
-- (Nome Empregado, CPF Empregado, Sexo, Salário, Quantidade Vendas com Serviço, Total Valor Vendido com Serviço, Total Comissão das Vendas com Serviço), 
-- ordenado por quantidade total de vendas realizadas;

SELECT e.nome AS 'Nome Empregado', e.cpf AS 'CPF Empregado', 
       e.sexo AS 'Sexo', concat('R$ ', format(e.salario,2)) AS 'Salário',
       COUNT(DISTINCT isv.venda_idVenda) AS 'Quantidade Vendas com Serviço',
       concat('R$ ', format(SUM(isv.valor),2)) AS 'Total Valor Vendido com Serviço',
       concat('R$ ', format(SUM(v.comissao),2)) AS 'Total Comissão das Vendas com Serviço'
FROM Empregado e
JOIN itensServico isv ON e.cpf = isv.Empregado_cpf
JOIN Venda v ON isv.Venda_idVenda = v.idVenda
GROUP BY e.cpf
ORDER BY COUNT(DISTINCT isv.venda_idVenda) DESC;

-- 6. Lista dos serviços já realizados por um Pet, (Nome do Pet, Data do Serviço, Nome do Serviço, Quantidade, Valor, Empregado que realizou o Serviço), ordenado por data do serviço da mais recente;

SELECT p.nome AS 'Nome do Pet', v.data AS 'Data do Serviço',
       s.nome AS 'Nome do Serviço', isv.quantidade AS 'Quantidade',
       concat('R$ ', format(s.valorVenda,2)) AS 'Valor', e.nome AS 'Empregado que realizou o Serviço'
FROM itensServico isv
JOIN Servico s ON isv.Servico_idServico = s.idServico
JOIN PET p ON isv.PET_idPET = p.idPET
JOIN Venda v ON isv.Venda_idVenda = v.idVenda
JOIN Empregado e ON isv.Empregado_cpf = e.cpf
ORDER BY v.data DESC;

-- 7. Lista das vendas já realizados para um Cliente (Data da Venda, Valor, Desconto, Valor Final, Empregado que realizou a venda), ordenado por data do serviço da mais recente;

SELECT v.data AS 'Data da Venda', concat('R$ ', format(v.valor,2)) AS 'Valor',
       concat('% ', format((v.desconto),2)) AS 'Desconto', 
       concat('R$ ', format((v.valor - (v.valor * v.desconto/100)),2)) AS 'Valor Final',
       e.nome AS 'Empregado que realizou a venda'
FROM Venda v
JOIN Empregado e ON v.Empregado_cpf = e.cpf
JOIN Cliente c ON v.Cliente_cpf = c.cpf
ORDER BY v.data DESC;

-- 8. Lista dos 10 serviços mais vendidos, (Nome do Serviço, Quantidade Vendas, Total Valor Vendido), ordenado por quantidade total de vendas realizadas;

SELECT s.nome AS 'Nome do Serviço',
	COUNT(isv.Venda_idVenda) AS 'Quantidade Vendas',
	concat('R$ ', format(SUM(isv.valor),2)) AS 'Total Valor Vendido'
FROM itensServico isv
JOIN Servico s ON isv.Servico_idServico = s.idServico
GROUP BY s.idServico
ORDER BY COUNT(isv.Venda_idVenda) DESC
LIMIT 10;

-- 9. formas de pagamentos mais utilizadas nas Vendas, informando quantas vendas cada forma de pagamento já foi relacionada,
-- trazendo as colunas (Tipo Forma Pagamento, Quantidade Vendas, Total Valor Vendido), ordenado por quantidade total de vendas realizadas;

SELECT fp.tipo AS 'Tipo Forma Pagamento',
       COUNT(fp.Venda_idVenda) AS 'Quantidade Vendas',
       concat('R$ ', format(SUM(fp.valorPago),2)) AS 'Total Valor Vendido'
FROM FormaPgVenda fp
GROUP BY fp.tipo
ORDER BY COUNT(fp.Venda_idVenda) DESC;

-- 10. Balaço das Vendas, informando a soma dos valores vendidos por dia, (Data Venda, Quantidade de Vendas, Valor Total Venda), ordenado por Data Venda da mais recente.

SELECT DATE(v.data) AS 'Data Venda',
       COUNT(v.idVenda) AS 'Quantidade de Vendas',
       concat('R$ ', format(SUM(v.valor),2)) AS 'Valor Total Venda'
FROM Venda v
GROUP BY DATE(v.data)
ORDER BY DATE(v.data) DESC;

-- 11. Lista dos Produtos, informando qual Fornecedor de cada produto, trazendo as colunas (Nome Produto, Valor Produto, Categoria do Produto, Nome Fornecedor, Email Fornecedor, Telefone Fornecedor), ordenado por Nome Produto;
 
 SELECT 
    p.nome AS 'Nome Produto',
    CONCAT('R$ ', FORMAT(ic.valorCompra, 2)) AS 'Valor Produto',
    f.nome AS 'Nome Fornecedor',
    f.email AS 'Email Fornecedor',
    t.numero AS 'Telefone Fornecedor'
FROM  Produtos p
JOIN  ItensCompra ic ON p.idProduto = ic.Produtos_idProduto
JOIN  Compras c ON ic.Compras_idCompra = c.idCompra
JOIN  Fornecedor f ON c.Fornecedor_cpf_cnpj = f.cpf_cnpj
LEFT JOIN Telefone t ON f.cpf_cnpj = t.Fornecedor_cpf_cnpj
GROUP BY p.idProduto, p.nome, ic.valorCompra, f.nome, f.email, t.numero
ORDER BY p.nome ASC;
    
-- 12. Lista dos Produtos mais vendidos, quantidade (total) de vezes que cada produto participou em vendas e o total de valor apurado com a venda do produto,
-- trazendo as colunas (Nome Produto, Quantidade (Total) Vendas, Valor Total Recebido pela Venda do Produto), ordenado por quantidade de vezes que o produto participou em vendas;

SELECT p.nome AS 'Nome Produto',
       COUNT(ivp.Venda_idVenda) AS 'Quantidade (Total) Vendas',
       SUM(ivp.valor) AS 'Valor Total Recebido pela Venda do Produto'
FROM ItensVendaProd ivp
JOIN Produtos p ON ivp.Produto_idProduto = p.idProduto
GROUP BY p.idProduto
ORDER BY COUNT(ivp.Venda_idVenda) DESC;
    
