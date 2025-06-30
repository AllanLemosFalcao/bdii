


-- Tabela para registrar saida --

CREATE TABLE IF NOT EXISTS saida_estoque (
    saidaID INT AUTO_INCREMENT PRIMARY KEY,
    produtoID_FK INT NOT NULL,
    quantidade INT NOT NULL,
    data_saida DATE NOT NULL,
    vendaID_FK INT NULL,
    FOREIGN KEY (produtoID_FK) REFERENCES Produto(produtoID),
    FOREIGN KEY (vendaID_FK) REFERENCES Venda(vendaID)
);

-- Tabela para registrar saida FIM --

-- Trigger 1. atualizar estoque de venda + registrar saida depois do insert--
delimiter $$
create trigger atualizarEstoqueVenda
after insert on vendaproduto
for each row
begin
DECLARE estoque_atual INT;

SELECT quantidade INTO estoque_atual
FROM estoque WHERE produtoID_FK = NEW.produtoID_FK
limit 1;

IF estoque_atual < NEW.quantidade then
SIGNAL SQLSTATE '45000'  SET MESSAGE_TEXT = 'Estoque insuficiente';
Else
        update estoque 
		set quantidade = quantidade - NEW.quantidade
		WHERE produtoID_FK = NEW.produtoID_FK;
		insert into saida_estoque(produtoID_FK, quantidade, vendaID_FK, data_saida) 
		values (new.produtoID_FK,new.quantidade, new.vendaID_FK, curdate());
END IF;
end $$
delimiter ;

insert into vendaproduto(quantidade,precounitario,desconto,vendaID_FK,produtoID_FK) values (10,10.00,0.00,2,5);

select * from estoque;
select * from saida_estoque;
-- Trigger 1. atualizar estoque de venda + registrar saida depois do insert FIM--

-- Trigger 2. 
DELIMITER $$
CREATE TRIGGER registrar_data_cadastro_produto
BEFORE INSERT ON Produto
FOR EACH ROW
BEGIN
    IF NEW.dataCadastro IS NULL THEN
        SET NEW.dataCadastro = CURDATE();
    END IF;
END$$
DELIMITER ;

select * from produto;
INSERT INTO Produto (nome, descricao, preço, tamanho, cor, dataCadastro, marcaID_FK)
VALUES ('Camiseta', 'Camiseta polo de algodão penteado', 89.90, 'G', 'Azul', null, 3), 
('Vestido Midis', 'Vestido midi em viscose', 219.90, 'M', 'Verde', '2023-11-10', 4);

-- Trigger 2. 

-- Trigger 3.
-- criar tabela necessaria pra inserir registros de alterações; --

CREATE TABLE IF NOT EXISTS LogAlteracoesProduto (
    logID INT AUTO_INCREMENT PRIMARY KEY,
    produtoID INT NOT NULL,
    dataHora DATETIME NOT NULL,
    usuario VARCHAR(50) NOT NULL
);

DELIMITER $$
CREATE TRIGGER LogAlteracoesProduto
AFTER UPDATE ON Produto
FOR EACH ROW
BEGIN
    -- Verifica se houve qualquer alteração
    IF NEW.nome != OLD.nome OR NEW.preço != OLD.preço THEN
        -- Insere um registro simples no log
        INSERT INTO LogAlteracoesProduto (
            produtoID, 
            dataHora, 
            usuario
        ) VALUES (
            NEW.produtoID, 
            NOW(), 
            CURRENT_USER()
        );
    END IF;
END$$
DELIMITER ;

UPDATE Produto 
SET nome = 'Camiseta Basic Premium', preço = 59.90
WHERE produtoID = 1;
select * from LogAlteracoesProduto;

-- Trigger 3. 

-- trigger 4. verificar se categoria e produto existem antes do insert --
DELIMITER $$
CREATE TRIGGER validar_categoria_produto
BEFORE INSERT ON ProdutoCategoria
FOR EACH ROW
BEGIN
    DECLARE categoria_existe INT;
    DECLARE produto_existe INT;
    
    -- Verifica se a categoria existe
    SELECT COUNT(*) INTO categoria_existe
    FROM Categoria
    WHERE categoriaID = NEW.categoriaID_FK;
    
    -- Verifica se o produto existe
    SELECT COUNT(*) INTO produto_existe
    FROM Produto
    WHERE produtoID = NEW.produtoID_FK;
    
    IF categoria_existe = 0 THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = 'Erro 45001: Categoria não encontrada';
    END IF;
    
    IF produto_existe = 0 THEN
        SIGNAL SQLSTATE '45002'
        SET MESSAGE_TEXT = 'Erro 45002: Produto não encontrado';
    END IF;
END$$
DELIMITER ;,
drop trigger validar_categoria_produto;

-- teste --

INSERT INTO ProdutoCategoria (produtoID_FK, categoriaID_FK) VALUES (1, 9999);
INSERT INTO ProdutoCategoria (produtoID_FK, categoriaID_FK) VALUES (9999, 1);

-- teste --

-- trigger 4. verificar se categoria e produto existem antes do insert -- FIM--

-- trigger 5. verificar se produto e promoção existem antes de inserir na tabela produtopromocao-- 

DELIMITER $$
CREATE TRIGGER validar_promocao_produto
BEFORE INSERT ON ProdutoPromocao
FOR EACH ROW
BEGIN
    DECLARE promocao_existe INT;
    DECLARE produto_existe INT;
    
    -- Verifica se a promoção existe
    SELECT COUNT(*) INTO promocao_existe
    FROM Promocao
    WHERE promocaoID = NEW.promocaoID_FK;
    
    -- Verifica se o produto existe
    SELECT COUNT(*) INTO produto_existe
    FROM Produto
    WHERE produtoID = NEW.produtoID_FK;
    
    IF promocao_existe = 0 THEN
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'Erro 45003: Promoção não encontrada no sistema';
    END IF;
    
    IF produto_existe = 0 THEN
        SIGNAL SQLSTATE '45004'
        SET MESSAGE_TEXT = 'Erro 45004: Produto não encontrado no sistema';
    END IF;
END$$
DELIMITER ;


-- teste --
INSERT INTO ProdutoPromocao (percentualDesconto, produtoID_FK, promocaoID_FK)
VALUES (10.00, 1, 44); 
-- teste --

-- trigger 5. verificar se produto e promoção existem antes de inserir na tabela produtopromocao. 

-- trigger 6 verificar se CPF já está cadastrado antes de inserir na tabela cliente. 
delimiter $$
create trigger tgrVerificacaoCPFcliente before insert on cliente for each row 
begin
declare cpfExiste varchar(14);
declare VerificacaoCPF varchar(100);

select cpf into cpfExiste from cliente c where c.cpf = new.cpf limit 1;

if new.cpf = cpfExiste then

set VerificacaoCPF = concat('Error 45004: ' 'Cliente com CPF ','"', new.cpf,'"', ' já existe');
 SIGNAL SQLSTATE '45004'
 SET MESSAGE_TEXT = VerificacaoCPF;
End IF; 
end $$
delimiter ;

drop trigger tgrVerificacaoCPFcliente;

select * from cliente;

INSERT INTO Cliente (cpf, nome, email, telefone, sexo)
VALUES ('012.345.678-99', 'Gustavo Ferreira', 'gustavo@email.com', '(85) 89876-5432', 'Masculino');

-- trigger 6 verificar se CPF já está cadastrado antes de inserir na tabela cliente -- FIM --. 



