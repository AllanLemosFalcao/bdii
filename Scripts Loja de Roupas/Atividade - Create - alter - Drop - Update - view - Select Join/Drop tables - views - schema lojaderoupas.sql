-- Apagar tabelas

DROP TABLE IF EXISTS ProdutoPromocao;
DROP TABLE IF EXISTS formaPagamento;
DROP TABLE IF EXISTS VendaProduto;
DROP TABLE IF EXISTS Venda;
DROP TABLE IF EXISTS ProdutoFornecedor;
DROP TABLE IF EXISTS ProdutoCategoria;
DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS EnderecoFornecedor;
DROP TABLE IF EXISTS Telefone;
DROP TABLE IF EXISTS Fornecedor;
DROP TABLE IF EXISTS EnderecoFunc;
DROP TABLE IF EXISTS Funcionarios;
DROP TABLE IF EXISTS EnderecoCliente;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Marca;
DROP TABLE IF EXISTS Promocao;

-- Apagar Schema

DROP VIEW IF EXISTS vw_produtos_estoque_baixo;
DROP VIEW IF EXISTS vw_vendas_por_cliente;
DROP VIEW IF EXISTS vw_produtos_mais_vendidos;
DROP VIEW IF EXISTS vw_top_funcionarios;
DROP VIEW IF EXISTS vw_promocoes_ativas;
DROP VIEW IF EXISTS vw_produtos_fornecedores;
DROP VIEW IF EXISTS vw_vendas_forma_pagamento;
DROP VIEW IF EXISTS vw_preco_medio_marca;
DROP VIEW IF EXISTS vw_clientes_inativos;
DROP VIEW IF EXISTS vw_produtos_por_categoria;

DROP SCHEMA IF EXISTS lojaderoupas;

-- Apagar VIEWS

