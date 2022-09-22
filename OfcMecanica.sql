-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ofcMecanina` DEFAULT CHARACTER SET utf8 ;
USE `ofcMecanina` ;

-- -----------------------------------------------------
-- Table `mydb`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico` (
  `CPF` VARCHAR(14) NOT NULL,
  `Salario` DECIMAL(6,2) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `Sexo` VARCHAR(1) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `IdEndereco` INT NOT NULL AUTO_INCREMENT,
  `CEP` VARCHAR(9) NOT NULL,
  `Rua` VARCHAR(60) NOT NULL,
  `comp` VARCHAR(60) NULL,
  `Cidade` VARCHAR(60) NOT NULL,
  `Bairro` VARCHAR(60) NOT NULL,
  `Numero` INT NOT NULL,
  `UF` VARCHAR(2) NOT NULL,
  `Mecanico_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`IdEndereco`),
  INDEX `fk_Endereco_Mecanico1_idx` (`Mecanico_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Mecanico1`
    FOREIGN KEY (`Mecanico_CPF`)
    REFERENCES `mydb`.`Mecanico` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Editoras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Editoras` (
  `CNPJ` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(12) NOT NULL,
  `Endereco_CEP` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`CNPJ`),
  INDEX `fk_table1_Endereco_idx` (`Endereco_CEP` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Endereco`
    FOREIGN KEY (`Endereco_CEP`)
    REFERENCES `mydb`.`Endereco` (`CEP`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Autores` (
  `idAutores` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(12) NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  PRIMARY KEY (`idAutores`),
  INDEX `fk_Autores_Endereco1_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Autores_Endereco1`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AreaConhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AreaConhecimento` (
  `idAreaConhecimento` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAreaConhecimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Titulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Titulos` (
  `ISBN` VARCHAR(25) NOT NULL,
  `Titulo` VARCHAR(60) NOT NULL,
  `NumPages` INT NOT NULL,
  `Versao` VARCHAR(15) NOT NULL,
  `Sumario` VARCHAR(45) NOT NULL,
  `DataPubli` DATE NOT NULL,
  `Editoras_CNPJ` VARCHAR(15) NOT NULL,
  `AreaConhecimento_idAreaConhecimento` INT NOT NULL,
  PRIMARY KEY (`ISBN`),
  INDEX `fk_Titulos_Editoras1_idx` (`Editoras_CNPJ` ASC) VISIBLE,
  INDEX `fk_Titulos_AreaConhecimento1_idx` (`AreaConhecimento_idAreaConhecimento` ASC) VISIBLE,
  CONSTRAINT `fk_Titulos_Editoras1`
    FOREIGN KEY (`Editoras_CNPJ`)
    REFERENCES `mydb`.`Editoras` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Titulos_AreaConhecimento1`
    FOREIGN KEY (`AreaConhecimento_idAreaConhecimento`)
    REFERENCES `mydb`.`AreaConhecimento` (`idAreaConhecimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Autores_Titulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Autores_Titulos` (
  `Autores_idAutores` INT NOT NULL,
  `Titulos_ISBN` DECIMAL(25) NOT NULL,
  PRIMARY KEY (`Autores_idAutores`, `Titulos_ISBN`),
  INDEX `fk_Autores_has_Titulos_Titulos1_idx` (`Titulos_ISBN` ASC) VISIBLE,
  INDEX `fk_Autores_has_Titulos_Autores1_idx` (`Autores_idAutores` ASC) VISIBLE,
  CONSTRAINT `fk_Autores_has_Titulos_Autores1`
    FOREIGN KEY (`Autores_idAutores`)
    REFERENCES `mydb`.`Autores` (`idAutores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autores_has_Titulos_Titulos1`
    FOREIGN KEY (`Titulos_ISBN`)
    REFERENCES `mydb`.`Titulos` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exemplares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exemplares` (
  `idExemplar` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  `Titulos_ISBN` DECIMAL(25) NOT NULL,
  INDEX `fk_Exemplares_Titulos1_idx` (`Titulos_ISBN` ASC) VISIBLE,
  PRIMARY KEY (`idExemplar`),
  CONSTRAINT `fk_Exemplares_Titulos1`
    FOREIGN KEY (`Titulos_ISBN`)
    REFERENCES `mydb`.`Titulos` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ususario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ususario` (
  `Matricula` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(12) NOT NULL,
  `Perfil` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  PRIMARY KEY (`Matricula`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `fk_Ususario_Endereco1_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Ususario_Endereco1`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ususario_Emprestimo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ususario_Emprestimo` (
  `Ususario_Matricula` VARCHAR(15) NOT NULL,
  `Exemplares_idExemplar` INT NOT NULL,
  `DataEmp` DATETIME NOT NULL,
  `DataPrev` DATETIME NOT NULL,
  `DataDev` DATETIME NULL,
  `Multa` DECIMAL(5,2) NULL,
  PRIMARY KEY (`Ususario_Matricula`, `Exemplares_idExemplar`),
  INDEX `fk_Ususario_has_Exemplares_Exemplares1_idx` (`Exemplares_idExemplar` ASC) VISIBLE,
  INDEX `fk_Ususario_has_Exemplares_Ususario1_idx` (`Ususario_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Ususario_has_Exemplares_Ususario1`
    FOREIGN KEY (`Ususario_Matricula`)
    REFERENCES `mydb`.`Ususario` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ususario_has_Exemplares_Exemplares1`
    FOREIGN KEY (`Exemplares_idExemplar`)
    REFERENCES `mydb`.`Exemplares` (`idExemplar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Cliente_Endereco2_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Endereco2`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `Placa` VARCHAR(7) NOT NULL,
  `Modelo` VARCHAR(30) NOT NULL,
  `Marca` VARCHAR(30) NOT NULL,
  `Ano` DATETIME NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  `Cliente_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  INDEX `fk_Veiculo_Cliente1_idx` (`Cliente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Cliente_Endereco2_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Endereco2`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `CPF` VARCHAR(14) NOT NULL,
  `CTPS` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `Telefone` VARCHAR(12) NOT NULL,
  `DataNasc` DATETIME NOT NULL,
  `DataAdm` DATETIME NOT NULL,
  `DataDem` DATETIME NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `CTPS_UNIQUE` (`CTPS` ASC) VISIBLE,
  INDEX `fk_Funcionario_Endereco1_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Endereco1`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Locacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Locacao` (
  `idLocacao` INT NOT NULL AUTO_INCREMENT,
  `DataLocacao` DATETIME NOT NULL,
  `DataPrev` DATETIME NOT NULL,
  `ValorTotal` DECIMAL(5,2) NOT NULL,
  `FormaPag` VARCHAR(45) NOT NULL,
  `DataDev` DATETIME NULL,
  `Multa` DECIMAL(5,2) NULL,
  `Cliente_CPF` VARCHAR(14) NULL,
  `Funcionario_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idLocacao`, `Cliente_CPF`, `Funcionario_CPF`),
  INDEX `fk_Locacao_Cliente1_idx` (`Cliente_CPF` ASC) VISIBLE,
  INDEX `fk_Locacao_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Locacao_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locacao_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `mydb`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Filme` (
  `idFilme` INT NOT NULL AUTO_INCREMENT,
  `TituloOrig` VARCHAR(60) NOT NULL,
  `TitulloBr` VARCHAR(60) NOT NULL,
  `Preco` DECIMAL(4,2) NOT NULL,
  `Duracao` VARCHAR(5) NOT NULL,
  `Ano` DATETIME NOT NULL,
  `FaixaEtaria` INT NOT NULL,
  PRIMARY KEY (`idFilme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Midia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Midia` (
  `idMidia` INT NOT NULL AUTO_INCREMENT,
  `Secao` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Filme_idFilme` INT NOT NULL,
  PRIMARY KEY (`idMidia`),
  INDEX `fk_Midia_Filme1_idx` (`Filme_idFilme` ASC) VISIBLE,
  CONSTRAINT `fk_Midia_Filme1`
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `mydb`.`Filme` (`idFilme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `idStatus` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  `Midia_idMidia` INT NULL,
  PRIMARY KEY (`idStatus`),
  INDEX `fk_Status_Midia1_idx` (`Midia_idMidia` ASC) VISIBLE,
  CONSTRAINT `fk_Status_Midia1`
    FOREIGN KEY (`Midia_idMidia`)
    REFERENCES `mydb`.`Midia` (`idMidia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genero` (
  `idGenero` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrdemServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrdemServico` (
  `idOS` INT NOT NULL AUTO_INCREMENT,
  `DataEmissao` DATETIME NOT NULL,
  `DataPrev` DATETIME NOT NULL,
  `ValorTotal` DECIMAL(7,2) NOT NULL,
  `DataConclu` DATETIME NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  PRIMARY KEY (`idOS`),
  INDEX `fk_OrdemServico_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemServico_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CompraAvPeca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CompraAvPeca` (
  `idVendaPeca` INT NOT NULL AUTO_INCREMENT,
  `Valor` DECIMAL(6,2) NOT NULL,
  `Data` DATETIME NOT NULL,
  `Cliente_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idVendaPeca`),
  INDEX `fk_CompraAvPeca_Cliente1_idx` (`Cliente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_CompraAvPeca_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Valor` DECIMAL(5,2) NOT NULL,
  `Computador_idComputador` INT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Servico_Computador1_idx` (`Computador_idComputador` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Computador1`
    FOREIGN KEY (`Computador_idComputador`)
    REFERENCES `mydb`.`Computador` (`idComputador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TipoPeca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoPeca` (
  `idTipoPeca` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Ano` DATETIME NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Valor` DECIMAL(6,2) NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`idTipoPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hospital` (
  `CNPJ` INT NOT NULL,
  `NomeFant` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(22) NOT NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  PRIMARY KEY (`CNPJ`),
  INDEX `fk_Hospital_Endereco1_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  CONSTRAINT `fk_Hospital_Endereco1`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medico` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CRM` VARCHAR(15) NOT NULL,
  `Epecialidade` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `Hospital_CNPJ` INT NOT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `CRM_UNIQUE` (`CRM` ASC) VISIBLE,
  INDEX `fk_Medico_Hospital1_idx` (`Hospital_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_Hospital1`
    FOREIGN KEY (`Hospital_CNPJ`)
    REFERENCES `mydb`.`Hospital` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ambulatorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ambulatorio` (
  `idAmbulatorio` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(22) NOT NULL,
  `Hospital_CNPJ` INT NOT NULL,
  PRIMARY KEY (`idAmbulatorio`),
  INDEX `fk_Ambulatorio_Hospital1_idx` (`Hospital_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Ambulatorio_Hospital1`
    FOREIGN KEY (`Hospital_CNPJ`)
    REFERENCES `mydb`.`Hospital` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PessoalApoio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PessoalApoio` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `Funcao` VARCHAR(45) NOT NULL,
  `Ambulatorio_idAmbulatorio` INT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_PessoalApoio_Ambulatorio1_idx` (`Ambulatorio_idAmbulatorio` ASC) VISIBLE,
  CONSTRAINT `fk_PessoalApoio_Ambulatorio1`
    FOREIGN KEY (`Ambulatorio_idAmbulatorio`)
    REFERENCES `mydb`.`Ambulatorio` (`idAmbulatorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Laboratorio` (
  `CNPJ` VARCHAR(15) NOT NULL,
  `NomeFant` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `DataNasc` DATETIME NOT NULL,
  `Ambulatorio_idAmbulatorio` INT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Paciente_Ambulatorio1_idx` (`Ambulatorio_idAmbulatorio` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Ambulatorio1`
    FOREIGN KEY (`Ambulatorio_idAmbulatorio`)
    REFERENCES `mydb`.`Ambulatorio` (`idAmbulatorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diagnostico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diagnostico` (
  `idDiagnostico` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NOT NULL,
  `Data` DATETIME NOT NULL,
  `Medico_CPF` VARCHAR(14) NOT NULL,
  `Paciente_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idDiagnostico`),
  INDEX `fk_Diagnostico_Medico1_idx` (`Medico_CPF` ASC) VISIBLE,
  INDEX `fk_Diagnostico_Paciente1_idx` (`Paciente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Diagnostico_Medico1`
    FOREIGN KEY (`Medico_CPF`)
    REFERENCES `mydb`.`Medico` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Diagnostico_Paciente1`
    FOREIGN KEY (`Paciente_CPF`)
    REFERENCES `mydb`.`Paciente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exame` (
  `idExame` INT NOT NULL AUTO_INCREMENT,
  `Especialidade` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Laboratorio_CNPJ` VARCHAR(15) NOT NULL,
  `Paciente_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idExame`),
  INDEX `fk_Exame_Laboratorio1_idx` (`Laboratorio_CNPJ` ASC) VISIBLE,
  INDEX `fk_Exame_Paciente1_idx` (`Paciente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Exame_Laboratorio1`
    FOREIGN KEY (`Laboratorio_CNPJ`)
    REFERENCES `mydb`.`Laboratorio` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exame_Paciente1`
    FOREIGN KEY (`Paciente_CPF`)
    REFERENCES `mydb`.`Paciente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ferias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ferias` (
  `idFerias` INT NOT NULL AUTO_INCREMENT,
  `DataIni` DATETIME NOT NULL,
  `QtdDias` INT NOT NULL,
  `DataFim` DATETIME NOT NULL,
  `Ano` DATETIME NOT NULL,
  PRIMARY KEY (`idFerias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empregado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empregado` (
  `CPF` VARCHAR(14) NOT NULL,
  `Salario` DECIMAL(6,2) NOT NULL,
  `Sexo` VARCHAR(2) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  `NomeSocial` VARCHAR(60) NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Endereco_IdEndereco` INT NOT NULL,
  `Ferias_idFerias` INT NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_Empregado_Endereco1_idx` (`Endereco_IdEndereco` ASC) VISIBLE,
  INDEX `fk_Empregado_Ferias1_idx` (`Ferias_idFerias` ASC) VISIBLE,
  CONSTRAINT `fk_Empregado_Endereco1`
    FOREIGN KEY (`Endereco_IdEndereco`)
    REFERENCES `mydb`.`Endereco` (`IdEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empregado_Ferias1`
    FOREIGN KEY (`Ferias_idFerias`)
    REFERENCES `mydb`.`Ferias` (`idFerias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `Data` DATETIME NOT NULL,
  `ValorTotal` DECIMAL(5,2) NOT NULL,
  `Desconto` DECIMAL(5,2) NOT NULL,
  `FormaPag` VARCHAR(45) NOT NULL,
  `Empregado_CPF` VARCHAR(14) NULL,
  `Clientes_idClientes` INT NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_Vendas_Empregado1_idx` (`Empregado_CPF` ASC) VISIBLE,
  INDEX `fk_Vendas_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `mydb`.`Empregado` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendas_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `mydb`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `CNPJ/CPF` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`CNPJ/CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Validade` DATETIME NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Valor` DECIMAL(5,2) NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Computador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Computador` (
  `idComputador` INT NOT NULL AUTO_INCREMENT,
  `DataManu` DATETIME NOT NULL,
  `Especificacoes` VARCHAR(45) NOT NULL,
  `TecnicoManu` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idComputador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Valor` DECIMAL(5,2) NOT NULL,
  `Computador_idComputador` INT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Servico_Computador1_idx` (`Computador_idComputador` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Computador1`
    FOREIGN KEY (`Computador_idComputador`)
    REFERENCES `mydb`.`Computador` (`idComputador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ItensdeVenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ItensdeVenda` (
  `idItensdeVenda` INT NOT NULL AUTO_INCREMENT,
  `Quantidade` INT NOT NULL,
  `Vendas_idVendas` INT NOT NULL,
  `Produto_idProduto` INT NULL,
  `Servico_idServico` INT NULL,
  PRIMARY KEY (`idItensdeVenda`),
  INDEX `fk_ItensdeVenda_Vendas1_idx` (`Vendas_idVendas` ASC) VISIBLE,
  INDEX `fk_ItensdeVenda_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_ItensdeVenda_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_ItensdeVenda_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `mydb`.`Vendas` (`idVendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItensdeVenda_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItensdeVenda_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Locacao_Midia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Locacao_Midia` (
  `Locacao_idLocacao` INT NOT NULL,
  `Locacao_Cliente_CPF` VARCHAR(14) NOT NULL,
  `Locacao_Funcionario_CPF` VARCHAR(14) NULL,
  `Midia_idMidia` INT NULL,
  PRIMARY KEY (`Locacao_idLocacao`, `Locacao_Cliente_CPF`, `Locacao_Funcionario_CPF`, `Midia_idMidia`),
  INDEX `fk_Locacao_has_Midia_Midia1_idx` (`Midia_idMidia` ASC) VISIBLE,
  INDEX `fk_Locacao_has_Midia_Locacao1_idx` (`Locacao_idLocacao` ASC, `Locacao_Cliente_CPF` ASC, `Locacao_Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Locacao_has_Midia_Locacao1`
    FOREIGN KEY (`Locacao_idLocacao` , `Locacao_Cliente_CPF` , `Locacao_Funcionario_CPF`)
    REFERENCES `mydb`.`Locacao` (`idLocacao` , `Cliente_CPF` , `Funcionario_CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locacao_has_Midia_Midia1`
    FOREIGN KEY (`Midia_idMidia`)
    REFERENCES `mydb`.`Midia` (`idMidia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Filme_has_Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Filme_has_Genero` (
  `Filme_idFilme` INT NULL,
  `Genero_idGenero` INT NOT NULL,
  PRIMARY KEY (`Filme_idFilme`, `Genero_idGenero`),
  INDEX `fk_Filme_has_Genero_Genero1_idx` (`Genero_idGenero` ASC) VISIBLE,
  INDEX `fk_Filme_has_Genero_Filme1_idx` (`Filme_idFilme` ASC) VISIBLE,
  CONSTRAINT `fk_Filme_has_Genero_Filme1`
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `mydb`.`Filme` (`idFilme`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Filme_has_Genero_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `mydb`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_has_Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_has_Fornecedor` (
  `Produto_idProduto` INT NULL,
  `Fornecedor_CNPJ/CPF` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Fornecedor_CNPJ/CPF`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_CNPJ/CPF` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ/CPF`)
    REFERENCES `mydb`.`Fornecedor` (`CNPJ/CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor_Servico` (
  `Fornecedor_CNPJ/CPF` VARCHAR(15) NULL,
  `Servico_idServico` INT NULL,
  PRIMARY KEY (`Fornecedor_CNPJ/CPF`, `Servico_idServico`),
  INDEX `fk_Fornecedor_has_Servico_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Servico_Fornecedor1_idx` (`Fornecedor_CNPJ/CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Servico_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ/CPF`)
    REFERENCES `mydb`.`Fornecedor` (`CNPJ/CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Servico_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hospital_Laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hospital_Laboratorio` (
  `Hospital_CNPJ` INT NULL,
  `Laboratorio_CNPJ` VARCHAR(15) NULL,
  PRIMARY KEY (`Hospital_CNPJ`, `Laboratorio_CNPJ`),
  INDEX `fk_Hospital_has_Laboratorio_Laboratorio1_idx` (`Laboratorio_CNPJ` ASC) VISIBLE,
  INDEX `fk_Hospital_has_Laboratorio_Hospital1_idx` (`Hospital_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Hospital_has_Laboratorio_Hospital1`
    FOREIGN KEY (`Hospital_CNPJ`)
    REFERENCES `mydb`.`Hospital` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hospital_has_Laboratorio_Laboratorio1`
    FOREIGN KEY (`Laboratorio_CNPJ`)
    REFERENCES `mydb`.`Laboratorio` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diagnostico_Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diagnostico_Paciente` (
  `Diagnostico_idDiagnostico` INT NOT NULL,
  `Paciente_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Diagnostico_idDiagnostico`, `Paciente_CPF`),
  INDEX `fk_Diagnostico_has_Paciente_Paciente1_idx` (`Paciente_CPF` ASC) VISIBLE,
  INDEX `fk_Diagnostico_has_Paciente_Diagnostico1_idx` (`Diagnostico_idDiagnostico` ASC) VISIBLE,
  CONSTRAINT `fk_Diagnostico_has_Paciente_Diagnostico1`
    FOREIGN KEY (`Diagnostico_idDiagnostico`)
    REFERENCES `mydb`.`Diagnostico` (`idDiagnostico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Diagnostico_has_Paciente_Paciente1`
    FOREIGN KEY (`Paciente_CPF`)
    REFERENCES `mydb`.`Paciente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medico_Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medico_Paciente` (
  `Medico_CPF` VARCHAR(14) NOT NULL,
  `Paciente_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`Medico_CPF`, `Paciente_CPF`),
  INDEX `fk_Medico_has_Paciente_Paciente1_idx` (`Paciente_CPF` ASC) VISIBLE,
  INDEX `fk_Medico_has_Paciente_Medico1_idx` (`Medico_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_has_Paciente_Medico1`
    FOREIGN KEY (`Medico_CPF`)
    REFERENCES `mydb`.`Medico` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medico_has_Paciente_Paciente1`
    FOREIGN KEY (`Paciente_CPF`)
    REFERENCES `mydb`.`Paciente` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mecanico_OrdemServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico_OrdemServico` (
  `Mecanico_CPF` VARCHAR(14) NOT NULL,
  `OrdemServico_idOS` INT NULL,
  PRIMARY KEY (`Mecanico_CPF`, `OrdemServico_idOS`),
  INDEX `fk_Mecanico_has_OrdemServico_OrdemServico1_idx` (`OrdemServico_idOS` ASC) VISIBLE,
  INDEX `fk_Mecanico_has_OrdemServico_Mecanico1_idx` (`Mecanico_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_has_OrdemServico_Mecanico1`
    FOREIGN KEY (`Mecanico_CPF`)
    REFERENCES `mydb`.`Mecanico` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecanico_has_OrdemServico_OrdemServico1`
    FOREIGN KEY (`OrdemServico_idOS`)
    REFERENCES `mydb`.`OrdemServico` (`idOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CompraAvPeca_has_TipoPeca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CompraAvPeca_has_TipoPeca` (
  `CompraAvPeca_idVendaPeca` INT NULL,
  `TipoPeca_idTipoPeca` INT NOT NULL,
  PRIMARY KEY (`CompraAvPeca_idVendaPeca`, `TipoPeca_idTipoPeca`),
  INDEX `fk_CompraAvPeca_has_TipoPeca_TipoPeca1_idx` (`TipoPeca_idTipoPeca` ASC) VISIBLE,
  INDEX `fk_CompraAvPeca_has_TipoPeca_CompraAvPeca1_idx` (`CompraAvPeca_idVendaPeca` ASC) VISIBLE,
  CONSTRAINT `fk_CompraAvPeca_has_TipoPeca_CompraAvPeca1`
    FOREIGN KEY (`CompraAvPeca_idVendaPeca`)
    REFERENCES `mydb`.`CompraAvPeca` (`idVendaPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CompraAvPeca_has_TipoPeca_TipoPeca1`
    FOREIGN KEY (`TipoPeca_idTipoPeca`)
    REFERENCES `mydb`.`TipoPeca` (`idTipoPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrdemServico_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrdemServico_Servico` (
  `OrdemServico_idOS` INT NULL,
  `Servico_idServico` INT NOT NULL,
  PRIMARY KEY (`OrdemServico_idOS`, `Servico_idServico`),
  INDEX `fk_OrdemServico_has_Servico_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_OrdemServico_has_Servico_OrdemServico1_idx` (`OrdemServico_idOS` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemServico_has_Servico_OrdemServico1`
    FOREIGN KEY (`OrdemServico_idOS`)
    REFERENCES `mydb`.`OrdemServico` (`idOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrdemServico_has_Servico_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_TipoPeca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico_TipoPeca` (
  `Servico_idServico` INT NULL,
  `TipoPeca_idTipoPeca` INT NULL,
  PRIMARY KEY (`Servico_idServico`, `TipoPeca_idTipoPeca`),
  INDEX `fk_Servico_has_TipoPeca_TipoPeca1_idx` (`TipoPeca_idTipoPeca` ASC) VISIBLE,
  INDEX `fk_Servico_has_TipoPeca_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_has_TipoPeca_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `mydb`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_TipoPeca_TipoPeca1`
    FOREIGN KEY (`TipoPeca_idTipoPeca`)
    REFERENCES `mydb`.`TipoPeca` (`idTipoPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
