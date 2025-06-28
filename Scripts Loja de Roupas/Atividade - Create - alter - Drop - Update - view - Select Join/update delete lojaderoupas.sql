UPDATE Produto SET preço = preço * 1.1 WHERE marcaID_FK = 1; -- Aumento de preço para Nike
UPDATE Cliente SET email = 'novoemail@cliente.com' WHERE cpf = '123.456.789-00';
UPDATE Fornecedor SET email = 'contato@novodominio.com' WHERE fornecedorID = 1;
UPDATE Funcionarios SET email = CONCAT(REPLACE(nome, ' ', '.'), '@loja.com') WHERE email is not null;

SET SQL_SAFE_UPDATES = 0; -- Desativar o modo de update seguro(para conseguir atualizar colunas sem a necessidade de usar where + primary key/unique)

UPDATE VendaProduto SET desconto = 10.00 WHERE vendaID_FK = 11 and vendaID_FK IN (SELECT vendaID FROM Venda WHERE dataVenda > '2023-11-11');
UPDATE Estoque SET preco_entrada = preco_entrada * 0.9 WHERE data_entrada < '2023-06-01';
UPDATE Marca SET descricao = CONCAT('Marca ', nome) WHERE descricao IS NULL;
UPDATE Venda SET statusEntrega = 'Entregue' WHERE statusEntrega = 'Processando' AND dataVenda < '2023-11-05';
UPDATE Promocao SET dataFim = DATE_ADD(dataFim, INTERVAL 7 DAY) WHERE promocaoID = 1;  -- Parei aqui11
UPDATE Categoria SET descricao = CONCAT('Categoria de ', nome) WHERE descricao IS NULL;

DELETE FROM ProdutoPromocao WHERE percentualDesconto < 15.00;
DELETE FROM Promocao WHERE dataFim < CURDATE(); -- Remover promoções expiradas
DELETE FROM Estoque WHERE quantidade = 0;
DELETE FROM cliente WHERE telefone LIKE '(11)%' and not exists(select * from venda where venda.cliente_CPF_FK = cliente.CPF);
DELETE FROM produto WHERE datacadastro is null;
DELETE FROM Telefone WHERE telefoneID > 5;
DELETE FROM formaPagamento WHERE valorPago < 50.00;
DELETE FROM EnderecoFornecedor WHERE cep = '06010-000';
DELETE FROM ProdutoFornecedor WHERE preco_fornecedor > 200.00;
DELETE FROM categoria WHERE categoriaID NOT IN (SELECT categoriaID_FK FROM produtocategoria);
