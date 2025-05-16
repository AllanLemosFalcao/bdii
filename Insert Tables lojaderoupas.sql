INSERT INTO Marca (nome, descricao) VALUES
('Nike', 'Marca esportiva internacional'),
('Adidas', 'Marca esportiva alemã'),
('Zara', 'Marca de moda espanhola'),
('H&M', 'Marca de moda sueca'),
('Levi''s', 'Marca especializada em jeans'),
('Calvin Klein', 'Marca de moda premium'),
('Puma', 'Marca esportiva global'),
('Gucci', 'Marca de luxo italiana'),
('Lacoste', 'Marca francesa conhecida pelo jacaré'),
('Tommy Hilfiger', 'Marca americana de estilo clássico');

INSERT INTO Produto (nome, descricao, preço, tamanho, cor, dataCadastro, marcaID_FK) VALUES
('Camiseta Basic', 'Camiseta básica de algodão', 49.90, 'M', 'Branco', '2023-01-15', 1),
('Calça Jeans Skinny', 'Calça jeans modelo skinny', 199.90, '38', 'Azul', '2023-02-20', 5),
('Tênis Run', 'Tênis para corrida', 349.90, '40', 'Preto', '2023-03-10', 2),
('Vestido Floral', 'Vestido estampado floral', 159.90, 'P', 'Colorido', '2023-04-05', 4),
('Blusa de Moletom', 'Blusa de moletom com capuz', 139.90, 'G', 'Cinza', '2023-05-12', 1),
('Bermuda Jeans', 'Bermuda de jeans masculina', 119.90, '42', 'Azul', '2023-06-18', 5),
('Jaqueta Corta-Vento', 'Jaqueta impermeável', 229.90, 'GG', 'Preto', '2023-07-22', 3),
('Saia Midi', 'Saia midi plissada', 89.90, '36', 'Vermelho', '2023-08-30', 4),
('Moletom com Zíper', 'Moletom com zíper frontal', 179.90, 'M', 'Verde', '2023-09-14', 7),
('Shorts Esportivo', 'Shorts para prática esportiva', 69.90, '40', 'Azul', '2023-10-25', 2);

INSERT INTO Categoria (nome, descricao) VALUES
('Feminino', 'Roupas para mulheres'),
('Masculino', 'Roupas para homens'),
('Infantil', 'Roupas para crianças'),
('Calçados', 'Sapatos e tênis'),
('Acessórios', 'Bolsas, cintos e outros'),
('Esportivo', 'Roupas para prática esportiva'),
('Jeans', 'Peças em tecido jeans'),
('Casual', 'Roupas para uso diário'),
('Premium', 'Peças de alta qualidade'),
('Promoção', 'Produtos em oferta');

INSERT INTO Fornecedor (nome, descricao, cnpj, email) VALUES
('Distribuidora Moda Ltda', 'Distribuidor de roupas', '12.345.678/0001-90', 'vendas@distribuidora.com'),
('Atacado Fashion', 'Atacado de confecções', '23.456.789/0001-80', 'contato@atacadofashion.com'),
('Malhas do Sul', 'Fabricante de tecidos', '34.567.890/0001-70', 'compras@malhasdosul.com'),
('Calçados Brasil', 'Importador de calçados', '45.678.901/0001-60', 'sac@calcadosbrasil.com'),
('Jeans & Cia', 'Especialista em jeans', '56.789.012/0001-50', 'jeanscia@email.com'),
('Moda Infantil SA', 'Fabricante de roupas infantis', '67.890.123/0001-40', 'infantil@modasa.com'),
('Esportes Radical', 'Equipamentos esportivos', '78.901.234/0001-30', 'radical@esportes.com'),
('Luxo Confeccções', 'Roupas de alta costura', '89.012.345/0001-20', 'luxo@confeccoes.com'),
('Têxtil Nacional', 'Fabricante de tecidos', '90.123.456/0001-10', 'textil@nacional.com'),
('Acessórios Fashion', 'Importador de acessórios', '01.234.567/0001-00', 'fashion@acessorios.com');

INSERT INTO ProdutoCategoria (produtoID_FK, categoriaID_FK) VALUES
(1, 8), (1, 2),  -- Camiseta Basic: Casual e Masculino
(2, 2), (2, 7),  -- Calça Jeans: Masculino e Jeans
(3, 4), (3, 6),  -- Tênis Run: Calçados e Esportivo
(4, 1), (4, 8),  -- Vestido Floral: Feminino e Casual
(5, 2), (5, 8),  -- Blusa Moletom: Masculino e Casual
(6, 2), (6, 7),  -- Bermuda Jeans: Masculino e Jeans
(7, 1), (7, 2), (7, 6),  -- Jaqueta: Feminino, Masculino e Esportivo
(8, 1), (8, 8),  -- Saia Midi: Feminino e Casual
(9, 2), (9, 8),  -- Moletom: Masculino e Casual
(10, 2), (10, 6);  -- Shorts: Masculino e Esportivoprodutopromocao

INSERT INTO ProdutoFornecedor (produtoID_FK, fornecedorID_FK, preco_fornecedor) VALUES
(1, 1, 35.00), 
(1, 2, 37.50),
(2, 5, 120.00),
(3, 4, 250.00),
(4, 2, 100.00), 
(4, 6, 105.00),
(5, 1, 90.00),
(6, 5, 80.00),
(7, 3, 150.00), 
(7, 8, 160.00),
(8, 2, 60.00),
(9, 1, 110.00),
(10, 7, 45.00);

INSERT INTO Estoque (quantidade, produtoID_FK, data_entrada, preco_entrada) VALUES
(50, 1, '2023-01-20', 35.00),
(30, 2, '2023-02-25', 120.00),
(20, 3, '2023-03-15', 250.00),
(25, 4, '2023-04-10', 100.00),
(40, 5, '2023-05-20', 90.00),
(35, 6, '2023-06-25', 80.00),
(15, 7, '2023-07-30', 150.00),
(28, 8, '2023-08-05', 60.00),
(32, 9, '2023-09-20', 110.00),
(45, 10, '2023-10-30', 45.00);

INSERT INTO Cliente (cpf, nome, email, telefone, sexo) VALUES
('123.456.789-00', 'Ana Silva', 'ana@email.com', '(11) 98765-4321', 'Feminino'),
('234.567.890-11', 'Carlos Oliveira', 'carlos@email.com', '(11) 97654-3210', 'Masculino'),
('345.678.901-22', 'Mariana Costa', 'mariana@email.com', '(11) 96543-2109', 'Feminino'),
('456.789.012-33', 'Pedro Santos', 'pedro@email.com', '(11) 95432-1098', 'Masculino'),
('567.890.123-44', 'Juliana Pereira', 'juliana@email.com', '(11) 94321-0987', 'Feminino'),
('678.901.234-55', 'Lucas Martins', 'lucas@email.com', '(11) 93210-9876', 'Masculino'),
('789.012.345-66', 'Fernanda Lima', 'fernanda@email.com', '(11) 92109-8765', 'Feminino'),
('890.123.456-77', 'Ricardo Almeida', 'ricardo@email.com', '(11) 91098-7654', 'Masculino'),
('901.234.567-88', 'Patrícia Souza', 'patricia@email.com', '(11) 90987-6543', 'Feminino'),
('012.345.678-99', 'Gustavo Ferreira', 'gustavo@email.com', '(11) 89876-5432', 'Masculino');

INSERT INTO EnderecoCliente (Cliente_cpf_FK, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('123.456.789-00', 'SP', 'São Paulo', 'Moema', 'Av. Ibirapuera', 1000, 'Apto 101', '04029-000'),
('234.567.890-11', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua Barata Ribeiro', 500, NULL, '22011-001'),
('345.678.901-22', 'MG', 'Belo Horizonte', 'Savassi', 'Rua da Bahia', 2000, 'Sala 302', '30160-011'),
('456.789.012-33', 'RS', 'Porto Alegre', 'Moinhos de Vento', 'Rua Padre Chagas', 80, NULL, '90570-080'),
('567.890.123-44', 'PR', 'Curitiba', 'Batel', 'Av. do Batel', 1500, 'Conj. 501', '80420-090'),
('678.901.234-55', 'SC', 'Florianópolis', 'Centro', 'Rua Felipe Schmidt', 300, NULL, '88010-001'),
('789.012.345-66', 'DF', 'Brasília', 'Asa Sul', 'CLS 203', 10, 'Bloco A', '70200-003'),
('890.123.456-77', 'BA', 'Salvador', 'Barra', 'Av. Oceânica', 200, NULL, '40140-130'),
('901.234.567-88', 'PE', 'Recife', 'Boa Viagem', 'Av. Boa Viagem', 1000, 'Apto 1201', '51020-000'),
('012.345.678-99', 'CE', 'Fortaleza', 'Meireles', 'Av. Beira Mar', 800, NULL, '60165-121');

INSERT INTO Funcionarios (nome, cpf, email, sexo) VALUES
('Roberto Nunes', '111.222.333-44', 'roberto@loja.com', 'M'),
('Amanda Costa', '222.333.444-55', 'amanda@loja.com', 'F'),
('Marcos Oliveira', '333.444.555-66', 'marcos@loja.com', 'M'),
('Carla Mendes', '444.555.666-77', 'carla@loja.com', 'F'),
('Daniel Souza', '555.666.777-88', 'daniel@loja.com', 'M'),
('Larissa Gomes', '666.777.888-99', 'larissa@loja.com', 'F'),
('Felipe Rocha', '777.888.999-00', 'felipe@loja.com', 'M'),
('Tatiana Lima', '888.999.000-11', 'tatiana@loja.com', 'F'),
('Rodrigo Santos', '999.000.111-22', 'rodrigo@loja.com', 'M'),
('Vanessa Castro', '000.111.222-33', 'vanessa@loja.com', 'F');

INSERT INTO EnderecoFunc (Funcionarios_cpf_FK, uf, cidade, bairro, rua, numero, comp, cep) VALUES
('111.222.333-44', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Domingos de Morais', 100, 'Apto 201', '04010-000'),
('222.333.444-55', 'SP', 'São Paulo', 'Pinheiros', 'Rua Teodoro Sampaio', 200, NULL, '05406-000'),
('333.444.555-66', 'SP', 'São Paulo', 'Itaim Bibi', 'Rua Joaquim Floriano', 300, 'Sala 101', '04534-001'),
('444.555.666-77', 'SP', 'São Paulo', 'Jardins', 'Alameda Santos', 400, NULL, '01418-001'),
('555.666.777-88', 'SP', 'São Paulo', 'Morumbi', 'Av. Morumbi', 500, 'Bloco B', '05650-000'),
('666.777.888-99', 'SP', 'São Paulo', 'Perdizes', 'Rua Bartira', 600, NULL, '05009-000'),
('777.888.999-00', 'SP', 'São Paulo', 'Higienópolis', 'Rua da Consolação', 700, 'Apto 1501', '01301-000'),
('888.999.000-11', 'SP', 'São Paulo', 'Bela Vista', 'Rua Major Sertório', 800, NULL, '01222-001'),
('999.000.111-22', 'SP', 'São Paulo', 'Paraíso', 'Rua Vergueiro', 900, 'Conj. 302', '01504-001'),
('000.111.222-33', 'SP', 'São Paulo', 'Cerqueira César', 'Rua Augusta', 1000, NULL, '01305-000');

INSERT INTO Telefone (Funcionarios_cpf_FK, telefone, Fornecedor_fornecedorID) VALUES
('111.222.333-44', '(11) 91111-1111', NULL),
('222.333.444-55', '(11) 92222-2222', NULL),
(NULL, '(11) 3030-4040', 1),
(NULL, '(11) 3040-5050', 2),
('333.444.555-66', '(11) 93333-3333', NULL),
('444.555.666-77', '(11) 94444-4444', NULL),
(NULL, '(11) 3050-6060', 3),
('555.666.777-88', '(11) 95555-5555', NULL),
(NULL, '(11) 3060-7070', 4),
('666.777.888-99', '(11) 96666-6666', NULL);

INSERT INTO EnderecoFornecedor (fornecedorID_FK, cep, numero, uf, cidade, rua, bairro) VALUES
(1, '02010-000', 100, 'SP', 'São Paulo', 'Rua do Gasômetro', 'Barra Funda'),
(2, '03010-000', 200, 'SP', 'São Paulo', 'Rua da Figueira', 'Brás'),
(3, '04010-000', 300, 'SP', 'São Paulo', 'Rua Domingos de Morais', 'Vila Mariana'),
(4, '05010-000', 400, 'SP', 'São Paulo', 'Rua Turiassu', 'Perdizes'),
(5, '06010-000', 500, 'SP', 'Osasco', 'Av. dos Autonomistas', 'Centro'),
(6, '07010-000', 600, 'SP', 'Guarulhos', 'Rua João Bernardo', 'Centro'),
(7, '08010-000', 700, 'SP', 'São Paulo', 'Av. Sapopemba', 'Água Rasa'),
(8, '09010-000', 800, 'SP', 'Santo André', 'Rua das Figueiras', 'Centro'),
(9, '10010-000', 900, 'SP', 'São Paulo', 'Rua do Tesouro', 'Centro'),
(10, '11010-000', 1000, 'SP', 'Santos', 'Av. Ana Costa', 'Aparecida');

INSERT INTO Venda (dataVenda, statusEntrega, valorTotal, Funcionarios_cpf_FK, Cliente_cpf_FK) VALUES
('2023-11-01 10:30:00', 'Entregue', 349.90, '111.222.333-44', '123.456.789-00'),
('2023-11-02 14:15:00', 'Processando', 199.90, '222.333.444-55', '234.567.890-11'),
('2023-11-03 16:45:00', 'Enviado', 519.80, '333.444.555-66', '345.678.901-22'),
('2023-11-04 11:20:00', 'Pendente', 139.90, '444.555.666-77', '456.789.012-33'),
('2023-11-05 09:10:00', 'Entregue', 229.90, '555.666.777-88', '567.890.123-44'),
('2023-11-06 13:25:00', 'Cancelado', 89.90, '666.777.888-99', '678.901.234-55'),
('2023-11-07 15:30:00', 'Entregue', 179.90, '777.888.999-00', '789.012.345-66'),
('2023-11-08 17:40:00', 'Processando', 69.90, '888.999.000-11', '890.123.456-77'),
('2023-11-09 12:00:00', 'Enviado', 409.70, '999.000.111-22', '901.234.567-88'),
('2023-11-10 10:00:00', 'Pendente', 49.90, '000.111.222-33', '012.345.678-99');

INSERT INTO VendaProduto (quantidade, precoUnitario, desconto, vendaID_FK, produtoID_FK) VALUES
(1, 349.90, 0.00, 1, 3),
(1, 199.90, 0.00, 2, 2),
(2, 159.90, 0.00, 3, 4),
(1, 139.90, 0.00, 4, 5),
(1, 229.90, 0.00, 5, 7),
(1, 89.90, 0.00, 6, 8),
(1, 179.90, 0.00, 7, 9),
(1, 69.90, 0.00, 8, 10),
(1, 349.90, 30.00, 9, 3),
(1, 49.90, 0.00, 10, 1);

INSERT INTO Promocao (nome, descricao, dataInicio, dataFim) VALUES
('Black Friday', 'Descontos especiais na Black Friday', '2023-11-24', '2023-11-26'),
('Natal', 'Promoção de Natal', '2023-12-15', '2023-12-25'),
('Volta às Aulas', 'Descontos em material escolar', '2024-01-20', '2024-02-10'),
('Dia dos Namorados', 'Promoção especial', '2024-06-10', '2024-06-12'),
('Aniversário da Loja', 'Promoção de aniversário', '2024-03-01', '2024-03-07'),
('Liquidação de Inverno', 'Descontos em roupas de inverno', '2024-07-01', '2024-07-31'),
('Dia das Mães', 'Ofertas especiais', '2024-05-05', '2024-05-12'),
('Cyber Monday', 'Ofertas exclusivas online', '2023-11-27', '2023-11-27'),
('Queima de Estoque', 'Liquidação de estoque', '2024-02-01', '2024-02-29'),
('Fim de Temporada', 'Descontos em coleções passadas', '2024-09-01', '2024-09-15');


INSERT INTO ProdutoPromocao (percentualDesconto, produtoID_FK, promocaoID_FK) VALUES
(30.00, 3, 1),  -- Tênis Run na Black Friday
(20.00, 4, 2),  -- Vestido Floral no Natal
(15.00, 5, 3),  -- Blusa Moletom na Volta às Aulas
(25.00, 1, 4),  -- Camiseta Basic no Dia dos Namorados
(10.00, 2, 5),  -- Calça Jeans no Aniversário
(40.00, 7, 6),  -- Jaqueta na Liquidação de Inverno
(15.00, 8, 7),  -- Saia Midi no Dia das Mães
(50.00, 9, 8),  -- Moletom no Cyber Monday
(60.00, 10, 9), -- Shorts na Queima de Estoque
(35.00, 6, 10); -- Bermuda no Fim de Temporada

INSERT INTO formaPagamento (tipo, valorPago, vendaID_FK) VALUES
('Cartão de Crédito', 349.90, 1),
('PIX', 199.90, 2),
('Cartão de Débito', 259.90, 3),
('PIX', 259.90, 3),
('Dinheiro', 139.90, 4),
('Cartão de Crédito', 229.90, 5),
('Cartão de Débito', 89.90, 6),
('PIX', 179.90, 7),
('Dinheiro', 69.90, 8),
('Cartão de Crédito', 409.70, 9),
('Cartão de Débito', 49.90, 10);
