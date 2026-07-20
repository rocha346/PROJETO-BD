-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ApolloMuscleEvents
-- -----------------------------------------------------
DROP DATABASE IF EXISTS ApolloMuscleEvents;
CREATE DATABASE ApolloMuscleEvents CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ApolloMuscleEvents;

-- ORDEM DE EXECUCAO DOS FICHEIROS -> gerar_tabelas -> index -> views -> functions -> procedures -> triggers -> populacao -> userPerms -> traducao
-- -----------------------------------------------------
-- Table `Atleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Atleta` (
  `idAtleta` INT NOT NULL AUTO_INCREMENT,
  `NIF` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Genero` ENUM('M', 'F') NOT NULL,
  `Nacionalidade` VARCHAR(50) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `Tipo_Sanguineo` VARCHAR(5) NOT NULL,
  `Alergias` TEXT NULL,
  `Nome_emergencia` VARCHAR(100) NOT NULL,
  `Telefone_Emergencia` VARCHAR(20) NOT NULL,
  UNIQUE INDEX `email_unico` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `telefone_unico` (`Telefone` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  PRIMARY KEY (`idAtleta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Staff` (
  `idStaff` INT NOT NULL AUTO_INCREMENT,
  `NIF` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `Cargo` VARCHAR(50) NOT NULL,
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  PRIMARY KEY (`idStaff`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Juri`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Juri` (
  `idJuri` INT NOT NULL AUTO_INCREMENT,
  `NIF` VARCHAR(15) NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `Credenciais` VARCHAR(50) NOT NULL,
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  PRIMARY KEY (`idJuri`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Patrocinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Patrocinador` (
  `idPatrocinador` INT NOT NULL AUTO_INCREMENT,
  `NIF` VARCHAR(15) NOT NULL,
  `NomeEmpresa` VARCHAR(100) NOT NULL,
  `TipoPatrocinio` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idPatrocinador`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categoria` (
  `Nome` VARCHAR(50) NOT NULL,
  `Altura_Max` DECIMAL(4,2) NULL,
  `Altura_Min` DECIMAL(4,2) NULL,
  `Peso_Max` DECIMAL(5,2) NULL,
  `Peso_Min` DECIMAL(5,2) NULL,
  `GeneroAlvo` ENUM('M', 'F', 'Misto') NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Edicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Edicao` (
  `Nome` VARCHAR(100) NOT NULL,
  `Data_Inicio` DATE NOT NULL,
  `Data_Fim` DATE NOT NULL,
  `Local` VARCHAR(150) NOT NULL,
  `Estado` ENUM('Planeada', 'Em Curso', 'Concluída') NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Criterio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Criterio` (
  `Nome_Criterio` VARCHAR(50) NOT NULL,
  `PesoPercentual` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`Nome_Criterio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inscricao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscricao` (
  `idInscricao` INT NOT NULL AUTO_INCREMENT,
  `Data_Inscricao` DATE NOT NULL,
  `Estado` ENUM('Pendente', 'Validada', 'Cancelada') NOT NULL,
  `idAtleta` INT NOT NULL,
  `Nome_Edicao` VARCHAR(50) NOT NULL,
  `Nome_Categoria` VARCHAR(50) NOT NULL,
  `idStaff` INT NOT NULL,
  PRIMARY KEY (`idInscricao`),
  INDEX `fk_inscricao_atleta_idx` (`idAtleta` ASC) VISIBLE,
  INDEX `fk_inscricao_edicao_idx` (`Nome_Edicao` ASC) VISIBLE,
  INDEX `fk_inscricao_categoria_idx` (`Nome_Categoria` ASC) VISIBLE,
  INDEX `fk_inscricao_staff_idx` (`idStaff` ASC) VISIBLE,
  CONSTRAINT `fk_inscricao_atleta`
    FOREIGN KEY (`idAtleta`)
    REFERENCES `Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscricao_edicao`
    FOREIGN KEY (`Nome_Edicao`)
    REFERENCES `Edicao` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscricao_categoria`
    FOREIGN KEY (`Nome_Categoria`)
    REFERENCES `Categoria` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscricao_staff`
    FOREIGN KEY (`idStaff`)
    REFERENCES `Staff` (`idStaff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pagamento` (
  `Num_Fatura` INT NOT NULL AUTO_INCREMENT,
  `MetodoPagamento` ENUM('MBWay', 'Transferência', 'Dinheiro') NOT NULL,
  `Data_Transacao` DATETIME NOT NULL,
  `Montante` DECIMAL(6,2) NOT NULL,
  `idInscricao` INT NOT NULL,
  PRIMARY KEY (`Num_Fatura`),
  UNIQUE INDEX `idInscricao_UNIQUE` (`idInscricao` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_inscricao`
    FOREIGN KEY (`idInscricao`)
    REFERENCES `Inscricao` (`idInscricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pesagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pesagem` (
  `NumFrontal` INT NOT NULL,
  `idInscricao` INT NOT NULL,
  `PesoReal` DECIMAL(5,2) NOT NULL,
  `AlturaReal` DECIMAL(4,2) NOT NULL,
  `DataHora` DATETIME NOT NULL,
  PRIMARY KEY (`NumFrontal`, `idInscricao`),
  INDEX `fk_pesagem_inscricao_idx` (`idInscricao` ASC) VISIBLE,
  CONSTRAINT `fk_pesagem_inscricao`
    FOREIGN KEY (`idInscricao`)
    REFERENCES `Inscricao` (`idInscricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Avaliacao` (
  `idAvaliacao` INT NOT NULL AUTO_INCREMENT,
  `Nota` DECIMAL(3,1) NOT NULL,
  `Fase` ENUM('Prejudging', 'Finals') NOT NULL,
  `Observacoes` TEXT NULL,
  `idJuri` INT NOT NULL,
  `idInscricao` INT NOT NULL,
  `Nome_Criterio` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idAvaliacao`),
  INDEX `fk_avaliacao_juri_idx` (`idJuri` ASC) VISIBLE,
  INDEX `fk_avaliacao_inscricao_idx` (`idInscricao` ASC) VISIBLE,
  INDEX `fk_inscricao_criterio_idx` (`Nome_Criterio` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_juri`
    FOREIGN KEY (`idJuri`)
    REFERENCES `Juri` (`idJuri`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_inscricao`
    FOREIGN KEY (`idInscricao`)
    REFERENCES `Inscricao` (`idInscricao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscricao_criterio`
    FOREIGN KEY (`Nome_Criterio`)
    REFERENCES `Criterio` (`Nome_Criterio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Edicao_Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Edicao_Staff` (
  `Nome_Edicao` VARCHAR(100) NOT NULL,
  `idStaff` INT NOT NULL,
  PRIMARY KEY (`Nome_Edicao`, `idStaff`),
  INDEX `fk_edicaostaff_staff_idx` (`idStaff` ASC) VISIBLE,
  CONSTRAINT `fk_edicaostaff_edicao`
    FOREIGN KEY (`Nome_Edicao`)
    REFERENCES `Edicao` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_edicaostaff_staff`
    FOREIGN KEY (`idStaff`)
    REFERENCES `Staff` (`idStaff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Edicao_Patrocinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Edicao_Patrocinador` (
  `Nome_Edicao` VARCHAR(100) NOT NULL,
  `idPatrocinador` INT NOT NULL,
  `ValorPatrocinado` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`Nome_Edicao`, `idPatrocinador`),
  INDEX `fk_edicaopatrocinador_patrocinador_idx` (`idPatrocinador` ASC) VISIBLE,
  CONSTRAINT `fk_edicaopatrocinador_edicao`
    FOREIGN KEY (`Nome_Edicao`)
    REFERENCES `Edicao` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_edicaopatrocinador_patrocinador`
    FOREIGN KEY (`idPatrocinador`)
    REFERENCES `Patrocinador` (`idPatrocinador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
