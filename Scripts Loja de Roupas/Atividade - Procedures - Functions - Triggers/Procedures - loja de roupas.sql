
-- criar tabela historicoprecos para que a procedure faça o insert nela.--
CREATE TABLE IF NOT EXISTS HistoricoPrecos (
    historicoID INT NOT NULL AUTO_INCREMENT,
    produtoID INT,
	nome varchar(55) NOT NULL,
    preco_antigo DECIMAL(10,2) NOT NULL,
    preco_novo DECIMAL(10,2) NOT NULL,
    data_alteracao DATETIME NOT NULL,
    PRIMARY KEY (historicoID),
    CONSTRAINT fk_HistoricoPrecos_Produto
        FOREIGN KEY (produtoID)
        REFERENCES Produto (produtoID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
-- criar tabela historicoprecos fim.--


-- 1. Procedure de atualização de preço para produtos de determinada marca --

DELIMITER $$
CREATE PROCEDURE proc_AtualizarPrecosPorMarca(IN marca_id INT, IN porcentagem DECIMAL(5,2))
BEGIN
    UPDATE Produto SET preço = preço * (1 + porcentagem/100) WHERE marcaID_FK = marca_id;
	INSERT INTO HistoricoPrecos (produtoID, nome, preco_antigo, preco_novo, data_alteracao)
    SELECT produtoID, nome, preço / (1 + porcentagem/100), preço, NOW() FROM Produto  WHERE marcaID_FK = marca_id;
    SELECT * FROM Produto WHERE marcaID_FK = marca_ID;
END $$
DELIMITER ;

CALL proc_AtualizarPrecosPorMarca(1, 10);
-- 1. Procedure de atualização de preço para produtos de determinada marca --
-- Teste -- procedure 1. --
SELECT * FROM historicoprecos;
-- Teste -- procedure 1. FIM --

-- 2. PROCEDURE: Cadastrar produto completo com estoque

DELIMITER $$
CREATE PROCEDURE proc_CadastrarProdutoCompleto(
    IN pnome VARCHAR(100),
    IN pdescricao TEXT,
    IN ppreco DECIMAL(10,2),
    IN ptamanho VARCHAR(10),
    IN pcor VARCHAR(10),
    IN pmarcaID INT,
    IN pcategoriaID INT,
    IN pfornecedorID INT,
    IN pquantidade_estoque INT,
    IN ppreco_entrada DECIMAL(10,2)
)
BEGIN
    DECLARE v_produtoID INT;
    
    -- Inserir produto
    INSERT INTO Produto (nome, descricao, preço, tamanho, cor, dataCadastro, marcaID_FK)
    VALUES (pnome, pdescricao, ppreco, ptamanho, pcor, CURDATE(), pmarcaID);
    
    -- Obter ID do produto inserido
    SET v_produtoID = LAST_INSERT_ID();
    
    -- Associar produto à categoria
    INSERT INTO ProdutoCategoria (produtoID_FK, categoriaID_FK)
    VALUES (v_produtoID, pcategoriaID);
    
    -- Adicionar ao estoque
    INSERT INTO Estoque (quantidade, produtoID_FK, data_entrada, preco_entrada, fornecedorID_FK)
    VALUES (pquantidade_estoque, v_produtoID, CURDATE(), ppreco_entrada, pfornecedorID);
    
    select  p.produtoID,
		p.nome,
		p.descricao,
		p.preço,
		p.tamanho,
		p.cor,
		p.dataCadastro,
		p.marcaID_FK,
		pc.categoriaID_FK,
		e.quantidade,
		e.preco_entrada,
		e.fornecedorID_FK
from produto p
join produtocategoria pc on p.produtoID = pc.produtoID_FK
join estoque e on p.produtoID = e.produtoID_FK 
where p.produtoID = v_produtoID;
END $$
Delimiter ;

CALL proc_CadastrarProdutoCompleto(
    'Camisa Polo Premium',
    'Camisa polo de algodão premium',
    89.90,
    'M',
    'Azul',
    6, -- Calvin Klein
    2, -- Masculino
    1, -- Distribuidora Moda Ltda
    25,
    68.00
);
select * from estoque;

-- 2. PROCEDURE: Cadastrar produto completo com estoque SELECT TESTE INCLUSO -- FIM 


-- 3. PROCEDURE: Cadastrar venda - Inicio--

DELIMITER $$
CREATE PROCEDURE proc_RegistroVendas (
    IN pstatusEntrega VARCHAR(45),
    IN pquantidade INT,
    IN pprecoUnitario DECIMAL(10,2),
    IN pdesconto DECIMAL(10,2),
    IN pprodutoID_FK INT,
    IN pFuncionarios_cpf_FK VARCHAR(14),
    IN pCliente_cpf_FK VARCHAR(14))
BEGIN
    DECLARE v_vendaID INT;
    DECLARE v_valorTotal DECIMAL(10,2);
    
    -- Calcula o valor total considerando o desconto
    SET v_valorTotal = (pprecoUnitario * pquantidade) * (1 - (pdesconto/100));
    
    -- Primeiro insere na tabela Venda
    INSERT INTO venda(dataVenda, statusEntrega, valorTotal, Funcionarios_cpf_FK, Cliente_CPF_FK)
    VALUES (curdate(), pstatusEntrega, v_valorTotal, pFuncionarios_cpf_FK, pCliente_cpf_FK);
    
    -- Obtém o ID da venda recém-criada
    SET v_vendaID = LAST_INSERT_ID();
    
    -- Depois insere na tabela VendaProduto
    INSERT INTO vendaproduto(quantidade, precoUnitario, desconto, vendaID_FK, produtoID_FK)
    VALUES (pquantidade, pprecoUnitario, pdesconto, v_vendaID, pprodutoID_FK);
    
select v.vendaID, v.dataVenda,v.statusEntrega,v.valorTotal,v.Funcionarios_cpf_FK,v.cliente_cpf_FK, vp.vendaProdutoID,vp.quantidade,vp.precoUnitario,vp.desconto,vp.vendaID_FK,vp.produtoID_FK
from venda v
join vendaproduto vp on vp.vendaID_FK = v.vendaID; 
END $$
DELIMITER ;



CALL proc_RegistroVendas(
    'Processando',           -- Status
    2,                       -- Quantidade
    159.95,                  -- Preço unitário
    10.00,                   -- Desconto (10%)
    4,                       -- ID do produto
    '111.222.333-44',        -- CPF do funcionário
    '123.456.789-00'         -- CPF do cliente
);
 -- 3. PROCEDURE: Cadastrar venda - Inicio-- Select TESTE INCLUSO -- FIM 


 -- 4. PROCEDURE: Cadastrar cliente - Inicio--

Delimiter $$
Create procedure proc_cadastroCliente (in pcpf varchar(14),
									in pnome varchar(100),
									in pemail varchar(45),
									in ptelefone varchar(15),
									in psexo varchar(20),
									in puf varchar(2),
									in pcidade varchar(45),
									in pbairro varchar(45),
									in prua varchar(45),
									in pnumero int,
									in pcomp varchar(45),
									in pcep varchar(9))
Begin

DECLARE cliente_existente INT;
    
    -- Verifica se o CPF já está cadastrado
    SELECT COUNT(*) INTO cliente_existente FROM cliente WHERE cpf = pcpf;
    
    IF cliente_existente > 0 THEN
        SELECT 'CPF já cadastrado' AS Mensagem;
    ELSE

insert into cliente (cpf,nome,email,telefone,sexo)
values (pcpf,pnome,pemail,ptelefone,psexo);

insert into enderecocliente (Cliente_cpf_FK,uf,cidade,bairro,rua,numero,comp,cep)
values (pcpf,puf,pcidade,pbairro,prua,pnumero,pcomp,pcep);

	SELECT 'Cliente cadastrado com sucesso!' AS Mensagem;
    END IF;
end $$
Delimiter ;

CALL proc_cadastroCliente(
    '123.456.789-09',
    'Fulano de Tal',
    'fulano@email.com',
    '(11) 9999-9999',
    'Masculino',
    'SP',
    'São Paulo',
    'Centro',
    'Rua Principal',
    100,
    'Apto 101',
    '01001-000'
);

CALL proc_cadastroCliente(
    '123.456.789-09',
    'Fulano de Tal',
    'fulano@email.com',
    '(11) 9999-9999',
    'Masculino',
    'SP',
    'São Paulo',
    'Centro',
    'Rua Principal',
    100,
    'Apto 102',
    '01001-000'
);

SELECT * FROM enderecocliente e
JOIN cliente c ON e.Cliente_cpf_FK = c.cpf where cpf = '123.456.789-09';
-- 4. PROCEDURE: Cadastrar cliente - Call de adicao + call de falha + select teste Fim--



-- 5. PROCEDURE: Adicionar produtos na tabela promoção--

-- insert necessário para utilizar a procedure --
INSERT INTO Promocao (nome, descricao, dataInicio, dataFim)
VALUES ('Black Friday', 'Maior promoção do ano', '2023-11-24', '2023-11-26');
-- insert necessário para utilizar a procedure --

DELIMITER $$
CREATE PROCEDURE proc_adicionar_produtopromocao(
	IN pprodutoID INT,
    IN ppromocaoID INT,
    IN ppercentual_desconto DECIMAL(5,2)
)
BEGIN
    -- Verificar se é para cadastrar nova promoção
    declare v_produto_existe int;
    declare v_promocao_existe int;
    declare v_produtopromocao_existe int;
    
	select count(*) into v_produto_existe FROM Produto where produtoID = pprodutoID;
    select count(*) into v_promocao_existe FROM promocao where promocaoID = ppromocaoID;
	select count(*) into v_produtopromocao_existe from produtopromocao where produtoID_FK = pprodutoID and promocaoID_FK = ppromocaoID;
    
    
    IF v_produto_existe = 0 THEN select 'produto com o ID fornecido não existe' as Resultado;
	elseif v_promocao_existe = 0 then select 'promoção com o ID fornecido não existe' as Resultado;
	elseif v_produtopromocao_existe > 0 then select 'produto já cadastrado nesta promoção' as Resultado;
    else
				-- Cadastrar nova promoção
				INSERT INTO produtopromocao (percentualDesconto, produtoID_FK, promocaoID_FK)
				VALUES (ppercentual_Desconto, pprodutoID, ppromocaoID);
				
				SELECT CONCAT('Promoção cadastrada com ID: ', LAST_INSERT_ID()) AS Resultado;
end if;
end $$
delimiter ;

select * from produtopromocao;
CALL proc_adicionar_produtopromocao(
	1,     -- pprodutoID
    1,     -- ppromocaoID
	15 	   -- percentualdesconto
);
-- 5. PROCEDURE: Adicionar produtos na tabela promoção -- FIM--


-- 6. PROCEDURE: deletar produtos na tabela promoção -- FIM--
delimiter $$
create procedure proc_deletar_produtopromocao(IN pprodutoID INT, IN ppromocaoID INT)
begin
    declare v_produto_existe int;
    declare v_promocao_existe int;
    declare v_produtopromocao_existe int;
    
	select count(*) into v_produto_existe FROM Produto where produtoID = pprodutoID;
    select count(*) into v_promocao_existe FROM promocao where promocaoID = ppromocaoID;
	select count(*) into v_produtopromocao_existe from produtopromocao where produtoID_FK = pprodutoID and promocaoID_FK = ppromocaoID;

	IF v_produto_existe = 0 THEN select 'produto com o ID fornecido não existe' as Resultado;
		elseif v_promocao_existe = 0 then select 'promoção com o ID fornecido não existe' as Resultado;
		elseif v_produtopromocao_existe > 0 then    
		delete from produtopromocao where produtoID_FK = pprodutoID and ppromocaoID = promocaoID_FK;
        select concat(count(*), ' item foi deletado') as Resultado;
        else select 'relação entre produto e promoção não existe' as Resultado;
	end if;
end $$
Delimiter ;


CALL proc_deletar_produtopromocao(
	4, -- pprodutoID
    2 -- ppromocaoID
);

select * from produtopromocao;

-- 6. PROCEDURE: deletar produtos na tabela promoção -- FIM--





