SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lojaderoupas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lojaderoupas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lojaderoupas` DEFAULT CHARACTER SET utf8mb3 ;
USE `lojaderoupas` ;

-- -----------------------------------------------------
-- Table `lojaderoupas`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Marca` (
  `marcaID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`marcaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Produto` (
  `produtoID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `preço` DECIMAL(10,2) NOT NULL,
  `tamanho` VARCHAR(10) NOT NULL,
  `cor` VARCHAR(10) NOT NULL,
  `dataCadastro` DATE NULL DEFAULT NULL,
  `marcaID_FK` INT NOT NULL,
  PRIMARY KEY (`produtoID`),
  INDEX `fk_Produto_Marca1_idx` (`marcaID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_Marca`
    FOREIGN KEY (`marcaID_FK`)
    REFERENCES `lojaderoupas`.`Marca` (`marcaID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Categoria` (
  `categoriaID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`categoriaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Fornecedor` (
  `fornecedorID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fornecedorID`),
  UNIQUE INDEX `unique` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`ProdutoCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`ProdutoCategoria` (
  `produtoID_FK` INT NOT NULL,
  `categoriaID_FK` INT NOT NULL,
  INDEX `fk_ProdutoCategoria_Categoria1_idx` (`categoriaID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_ProdutoCategoria_Produto1`
    FOREIGN KEY (`produtoID_FK`)
    REFERENCES `lojaderoupas`.`Produto` (`produtoID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ProdutoCategoria_Categoria1`
    FOREIGN KEY (`categoriaID_FK`)
    REFERENCES `lojaderoupas`.`Categoria` (`categoriaID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`ProdutoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`ProdutoFornecedor` (
  `produtoID_FK` INT NOT NULL,
  `fornecedorID_FK` INT NOT NULL,
  `preco_fornecedor` DECIMAL(10,2) NOT NULL,
  INDEX `fk_table1_Produto1_idx` (`produtoID_FK` ASC) VISIBLE,
  INDEX `fk_ProdutoFornecedor_Fornecedor1_idx` (`fornecedorID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_ProdutoFornecedor_Produto`
    FOREIGN KEY (`produtoID_FK`)
    REFERENCES `lojaderoupas`.`Produto` (`produtoID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ProdutoFornecedor_Fornecedor`
    FOREIGN KEY (`fornecedorID_FK`)
    REFERENCES `lojaderoupas`.`Fornecedor` (`fornecedorID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Estoque` (
  `estoqueID` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `produtoID_FK` INT NOT NULL,
  `data_entrada` DATE NULL DEFAULT NULL,
  `data_saida` DATE NULL DEFAULT NULL,
  `preco_entrada` DECIMAL(10,2) NULL DEFAULT NULL,
  `fornecedorID_FK` INT NULL,
  PRIMARY KEY (`estoqueID`, `produtoID_FK`),
  INDEX `fk_Estoque_Produto2_idx` (`produtoID_FK` ASC) VISIBLE,
  INDEX `fk_estoque_fornecedor_idx` (`fornecedorID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_Produto`
    FOREIGN KEY (`produtoID_FK`)
    REFERENCES `lojaderoupas`.`Produto` (`produtoID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_estoque_fornecedor`
    FOREIGN KEY (`fornecedorID_FK`)
    REFERENCES `lojaderoupas`.`Fornecedor` (`fornecedorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Cliente` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT 'null',
  `telefone` VARCHAR(15) NOT NULL,
  `sexo` VARCHAR(20) NULL DEFAULT 'não informado',
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`EnderecoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`EnderecoCliente` (
  `Cliente_cpf_FK` VARCHAR(14) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `comp` VARCHAR(45) NULL DEFAULT NULL,
  `cep` VARCHAR(9) NOT NULL,
  CONSTRAINT `fk_EnderecoCliente_Cliente1`
    FOREIGN KEY (`Cliente_cpf_FK`)
    REFERENCES `lojaderoupas`.`Cliente` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Funcionarios` (
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(50) NULL DEFAULT 'null',
  `sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`EnderecoFunc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`EnderecoFunc` (
  `Funcionarios_cpf_FK` VARCHAR(14) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  `comp` VARCHAR(45) NULL DEFAULT NULL,
  `cep` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`Funcionarios_cpf_FK`),
  CONSTRAINT `fk_EnderecoFunc_Funcionarios1`
    FOREIGN KEY (`Funcionarios_cpf_FK`)
    REFERENCES `lojaderoupas`.`Funcionarios` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Telefone` (
  `Funcionarios_cpf_FK` VARCHAR(14) NULL,
  `telefoneID` INT NOT NULL AUTO_INCREMENT,
  `telefone` VARCHAR(15) NOT NULL,
  `Fornecedor_fornecedorID` INT NULL DEFAULT NULL,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  INDEX `fk_Telefone_Fornecedor2_idx` (`Fornecedor_fornecedorID` ASC) VISIBLE,
  PRIMARY KEY (`telefoneID`),
  INDEX `fk_ContatoFunc_Funcionarios1` (`Funcionarios_cpf_FK` ASC) VISIBLE,
  CONSTRAINT `fk_ContatoFunc_Funcionarios1`
    FOREIGN KEY (`Funcionarios_cpf_FK`)
    REFERENCES `lojaderoupas`.`Funcionarios` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Telefone_Fornecedor2`
    FOREIGN KEY (`Fornecedor_fornecedorID`)
    REFERENCES `lojaderoupas`.`Fornecedor` (`fornecedorID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`EnderecoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`EnderecoFornecedor` (
  `fornecedorID_FK` INT NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `numero` INT NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fornecedorID_FK`),
  CONSTRAINT `fk_EnderecoFornecedor_Fornecedor1`
    FOREIGN KEY (`fornecedorID_FK`)
    REFERENCES `lojaderoupas`.`Fornecedor` (`fornecedorID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Venda` (
  `vendaID` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATETIME NOT NULL,
  `statusEntrega` VARCHAR(45) NOT NULL,
  `valorTotal` DECIMAL(10,2) NOT NULL,
  `Funcionarios_cpf_FK` VARCHAR(14) NOT NULL,
  `Cliente_cpf_FK` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`vendaID`),
  INDEX `fk_Venda_Funcionarios1_idx` (`Funcionarios_cpf_FK` ASC) VISIBLE,
  INDEX `fk_Venda_Cliente2_idx` (`Cliente_cpf_FK` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Funcionarios1`
    FOREIGN KEY (`Funcionarios_cpf_FK`)
    REFERENCES `lojaderoupas`.`Funcionarios` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Venda_Cliente2`
    FOREIGN KEY (`Cliente_cpf_FK`)
    REFERENCES `lojaderoupas`.`Cliente` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`VendaProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`VendaProduto` (
  `vendaProdutoID` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `precoUnitario` DECIMAL(10,2) NOT NULL,
  `desconto` DECIMAL(10,2) NULL DEFAULT NULL,
  `vendaID_FK` INT NOT NULL,
  `produtoID_FK` INT NOT NULL,
  PRIMARY KEY (`vendaProdutoID`, `vendaID_FK`),
  INDEX `fk_VendaProduto_Venda1_idx` (`vendaID_FK` ASC) VISIBLE,
  INDEX `fk_VendaProduto_Produto1_idx` (`produtoID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_VendaProduto_Venda1`
    FOREIGN KEY (`vendaID_FK`)
    REFERENCES `lojaderoupas`.`Venda` (`vendaID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VendaProduto_Produto1`
    FOREIGN KEY (`produtoID_FK`)
    REFERENCES `lojaderoupas`.`Produto` (`produtoID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`Promocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`Promocao` (
  `promocaoID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `dataInicio` DATE NULL DEFAULT NULL,
  `dataFim` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`promocaoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`ProdutoPromocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`ProdutoPromocao` (
  `percentualDesconto` DECIMAL(5,2) NOT NULL,
  `produtoID_FK` INT NOT NULL,
  `promocaoID_FK` INT NOT NULL,
  INDEX `fk_ProdutoPromocao_Produto1_idx` (`produtoID_FK` ASC) VISIBLE,
  INDEX `fk_ProdutoPromocao_Promocao1_idx` (`promocaoID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_ProdutoPromocao_Produto1`
    FOREIGN KEY (`produtoID_FK`)
    REFERENCES `lojaderoupas`.`Produto` (`produtoID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ProdutoPromocao_Promocao1`
    FOREIGN KEY (`promocaoID_FK`)
    REFERENCES `lojaderoupas`.`Promocao` (`promocaoID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lojaderoupas`.`formaPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojaderoupas`.`formaPagamento` (
  `formaPagamento` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `valorPago` DECIMAL(10,2) NOT NULL,
  `vendaID_FK` INT NOT NULL,
  PRIMARY KEY (`formaPagamento`),
  INDEX `fk_formaPagamento_Venda1_idx` (`vendaID_FK` ASC) VISIBLE,
  CONSTRAINT `fk_formaPagamento_Venda1`
    FOREIGN KEY (`vendaID_FK`)
    REFERENCES `lojaderoupas`.`Venda` (`vendaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
