-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema projeto
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `projeto` ;

-- -----------------------------------------------------
-- Schema projeto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projeto` DEFAULT CHARACTER SET utf8 ;
USE `projeto` ;

-- -----------------------------------------------------
-- Table `projeto`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`cliente` (
  `idCliente` INT(11) NOT NULL,
  `Nome` VARCHAR(55) NOT NULL,
  `Agencia` INT(3) NOT NULL,
  `Conta` INT(3) NOT NULL,
  `Senha` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`operadoras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`operadoras` (
  `idOperadoras` INT(11) NOT NULL AUTO_INCREMENT,
  `CodigoOperadora` INT(11) NOT NULL,
  `NomeOperadora` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOperadoras`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`debit_automatico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`debit_automatico` (
  `idDEBIT_AUTOMATICO` INT(11) NOT NULL,
  `idCliente` INT(11) NOT NULL,
  `idOperadoras` INT(11) NOT NULL,
  `CodConsumidor` INT(11) NOT NULL,
  `ValorDebito` DECIMAL(10,2) NOT NULL,
  `DataDebito` DATE NOT NULL,
  PRIMARY KEY (`idDEBIT_AUTOMATICO`),
  CONSTRAINT `fk_DebitoAutomatico_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `projeto`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DebitoAutomatico_Operadoras1`
    FOREIGN KEY (`idOperadoras`)
    REFERENCES `projeto`.`operadoras` (`idOperadoras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_DebitoAutomatico_Cliente1_idx` ON `projeto`.`debit_automatico` (`idCliente` ASC);

CREATE INDEX `fk_DebitoAutomatico_Operadoras1_idx` ON `projeto`.`debit_automatico` (`idOperadoras` ASC);


-- -----------------------------------------------------
-- Table `projeto`.`tipo_movimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`tipo_movimentacao` (
  `idTipoMovimentacao` INT(11) NOT NULL,
  `Descricao` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipoMovimentacao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projeto`.`movimentacao_bancaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`movimentacao_bancaria` (
  `idMovimentacaoBancaria` INT(11) NOT NULL AUTO_INCREMENT,
  `CodCliente` INT(11) NOT NULL,
  `IdTipoMovimentacao` INT(11) NOT NULL COMMENT '1 - Transferencia / 2 - Saque / 3 - Debito Automatico',
  `TipoCredDeb` INT(11) NOT NULL COMMENT '1 - Credito / 2 - Debito',
  `ValorMovimentacao` DECIMAL(10,2) NOT NULL,
  `SaldoAtual` DECIMAL(10,2) NOT NULL,
  `DataMovimentacao` DATE NOT NULL,
  PRIMARY KEY (`idMovimentacaoBancaria`),
  CONSTRAINT `fk_MOVIMENTACAO_BANCARIA_TIPO_MOVIMENTACAO`
    FOREIGN KEY (`IdTipoMovimentacao`)
    REFERENCES `projeto`.`tipo_movimentacao` (`idTipoMovimentacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MovimentacaoBancaria_Cliente1`
    FOREIGN KEY (`CodCliente`)
    REFERENCES `projeto`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_MovimentacaoBancaria_Cliente1_idx` ON `projeto`.`movimentacao_bancaria` (`CodCliente` ASC);

CREATE INDEX `fk_MOVIMENTACAO_BANCARIA_TIPO_MOVIMENTACAO_idx` ON `projeto`.`movimentacao_bancaria` (`IdTipoMovimentacao` ASC);


-- -----------------------------------------------------
-- Table `projeto`.`saldo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`saldo` (
  `idSaldo` INT(11) NOT NULL,
  `CodCliente` INT(11) NOT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idSaldo`),
  CONSTRAINT `fk_Saldo_Cliente`
    FOREIGN KEY (`CodCliente`)
    REFERENCES `projeto`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Saldo_Cliente_idx` ON `projeto`.`saldo` (`CodCliente` ASC);


-- -----------------------------------------------------
-- Table `projeto`.`saque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`saque` (
  `idSaque` INT(11) NOT NULL AUTO_INCREMENT,
  `CodCliente` INT(11) NOT NULL,
  `ValorSaque` DECIMAL(10,2) NOT NULL,
  `SaldoAtual` DECIMAL(10,2) NOT NULL,
  `DataSaque` DATE NOT NULL,
  PRIMARY KEY (`idSaque`),
  CONSTRAINT `fk_Saque_Cliente1`
    FOREIGN KEY (`CodCliente`)
    REFERENCES `projeto`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Saque_Cliente1_idx` ON `projeto`.`saque` (`CodCliente` ASC);


-- -----------------------------------------------------
-- Table `projeto`.`transferencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto`.`transferencia` (
  `idTransferencia` INT(11) NOT NULL AUTO_INCREMENT,
  `CodClienteCred` INT(11) NOT NULL,
  `CodClienteDeb` INT(11) NOT NULL,
  `ValorTransferencia` DECIMAL(10,2) NOT NULL,
  `SaldoCliCred` DECIMAL(10,2) NOT NULL,
  `SaldoCliDeb` DECIMAL(10,2) NOT NULL,
  `DataTransferencia` DATE NOT NULL,
  PRIMARY KEY (`idTransferencia`),
  CONSTRAINT `fk_Transferencia_Cliente1`
    FOREIGN KEY (`CodClienteCred`)
    REFERENCES `projeto`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transferencia_Cliente2`
    FOREIGN KEY (`CodClienteDeb`)
    REFERENCES `projeto`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Transferencia_Cliente1_idx` ON `projeto`.`transferencia` (`CodClienteCred` ASC);

CREATE INDEX `fk_Transferencia_Cliente2_idx` ON `projeto`.`transferencia` (`CodClienteDeb` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `projeto`.`CLIENTE`
-- -----------------------------------------------------
START TRANSACTION;
USE `projeto`;
INSERT INTO `projeto`.`CLIENTE` (`idCliente`, `Nome`, `Agencia`, `Conta`, `Senha`) VALUES (1, 'JOAO DA SILVA', 123, 123, 123);
INSERT INTO `projeto`.`CLIENTE` (`idCliente`, `Nome`, `Agencia`, `Conta`, `Senha`) VALUES (2, 'CARLOS ALBERTO', 456, 456, 456);
INSERT INTO `projeto`.`CLIENTE` (`idCliente`, `Nome`, `Agencia`, `Conta`, `Senha`) VALUES (3, 'MANOEL DE NOBREGA', 789, 789, 789);
INSERT INTO `projeto`.`CLIENTE` (`idCliente`, `Nome`, `Agencia`, `Conta`, `Senha`) VALUES (4, 'VITOR HUGO PEDROSO', 987, 987, 987);

COMMIT;


-- -----------------------------------------------------
-- Data for table `projeto`.`TIPO_MOVIMENTACAO`
-- -----------------------------------------------------
START TRANSACTION;
USE `projeto`;
INSERT INTO `projeto`.`TIPO_MOVIMENTACAO` (`idTipoMovimentacao`, `Descricao`) VALUES (1, 'TRANSFERENCIA');
INSERT INTO `projeto`.`TIPO_MOVIMENTACAO` (`idTipoMovimentacao`, `Descricao`) VALUES (2, 'SAQUE');
INSERT INTO `projeto`.`TIPO_MOVIMENTACAO` (`idTipoMovimentacao`, `Descricao`) VALUES (3, 'DEBITO AUTOMATICO');
INSERT INTO `projeto`.`TIPO_MOVIMENTACAO` (`idTipoMovimentacao`, `Descricao`) VALUES (4, 'DEPOSITO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `projeto`.`MOVIMENTACAO_BANCARIA`
-- -----------------------------------------------------
START TRANSACTION;
USE `projeto`;
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (1, 1, 1, 2, 100, 1000, '2016-10-30');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (2, 1, 2, 2, 10, 990, '2016-11-01');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (3, 2, 1, 2, 200, 1300, '2016-10-30');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (4, 2, 2, 2, 50, 1250, '2016-11-01');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (5, 3, 1, 2, 30, 1770, '2016-10-30');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (6, 3, 2, 2, 150, 1620, '2016-11-01');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (7, 4, 1, 2, 70, 100, '2016-10-30');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (8, 4, 2, 2, 80, 20, '2016-11-01');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (9,2,1,1,10.00,2520.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (10,2,1,2,10.00,2520.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (11,2,1,1,10.00,2530.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (12,1,1,2,10.00,4990.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (13,2,1,1,-1.00,2529.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (14,1,1,2,-1.00,4991.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (15,2,1,1,10.00,2539.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (16,1,1,2,10.00,4981.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (17,2,1,1,10.00,2549.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (18,1,1,2,10.00,4971.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (19,2,1,1,15.00,2564.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (20,1,1,2,15.00,4956.00,'2016-11-02');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (23,2,1,1,15.00,2579.00,'2016-11-07');
INSERT INTO `projeto`.`MOVIMENTACAO_BANCARIA` (`idMovimentacaoBancaria`, `CodCliente`, `IdTipoMovimentacao`, `TipoCredDeb`, `ValorMovimentacao`, `SaldoAtual`, `DataMovimentacao`) VALUES (24,1,1,2,15.00,4941.00,'2016-11-07');

COMMIT;

-- -----------------------------------------------------
-- Data for table `projeto`.`SAQUE`
-- -----------------------------------------------------
START TRANSACTION;
USE `projeto`;
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (1, 1, 100, 1000, '2016-08-13');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (2, 1, 10, 990, '2016-08-13');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (3, 2, 200, 1300, '2016-08-01');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (4, 2, 50, 1250, '2016-08-10');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (5, 3, 30, 1770, '2016-08-05');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (6, 3, 150, 1620, '2016-08-17');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (7, 4, 70, 100, '2016-08-11');
INSERT INTO `projeto`.`SAQUE` (`idSaque`, `CodCliente`, `ValorSaque`, `SaldoAtual`, `DataSaque`) VALUES (8, 4, 80, 20, '2016-08-15');

COMMIT;

-- -----------------------------------------------------
-- Data for table `projeto`.`SALDO`
-- -----------------------------------------------------
START TRANSACTION;
USE `projeto`;
INSERT INTO `projeto`.`SALDO` (`idSaldo`,`CodCliente`,`Valor`) VALUES (1,1,4941.00);
INSERT INTO `projeto`.`SALDO` (`idSaldo`,`CodCliente`,`Valor`) VALUES (2,2,2579.00);
INSERT INTO `projeto`.`SALDO` (`idSaldo`,`CodCliente`,`Valor`) VALUES (3,3,7270.00);
INSERT INTO `projeto`.`SALDO` (`idSaldo`,`CodCliente`,`Valor`) VALUES (4,4,6710.00);

COMMIT;

-- -----------------------------------------------------
-- Data for table `projeto`.`TRANSFERENCIA`
-- -----------------------------------------------------
START TRANSACTION;
USE `projeto`;
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (18,2,1,10.00,2520.00,5000.00,'2016-11-02');
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (19,2,1,10.00,2530.00,4990.00,'2016-11-02');
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (20,2,1,-1.00,2529.00,4991.00,'2016-11-02');
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (21,2,1,10.00,2539.00,4981.00,'2016-11-02');
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (22,2,1,10.00,2549.00,4971.00,'2016-11-02');
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (23,2,1,15.00,2564.00,4956.00,'2016-11-02');
INSERT INTO `projeto`.`TRANSFERENCIA` (`idTransferencia`, `CodClienteCred`, `CodClienteDeb`, `ValorTransferencia`, `SaldoCliCred`, `SaldoCliDeb`, `DataTransferencia`) VALUES (24,2,1,15.00,2579.00,4941.00,'2016-11-07');

COMMIT;

/*SELECT * FROM CLIENTE;
SELECT * FROM SALDO;
SELECT * FROM TRANSFERENCIA;
SELECT * FROM MOVIMENTACAO_BANCARIA;
SELECT * FROM SAQUE;
SELECT * FROM OPERADORAS;
SELECT * FROM DEBITOAUTOMATICO;

UPDATE SALDO S set S.Valor = 5010 WHERE S.CodCliente = 1

SELECT * FROM tipo_movimentacao;

delete from transferencia where idTransferencia > 0;
delete from saque where idSaque > 0;
delete from movimentacao_bancaria where idMovimentacaoBancaria > 0;
*/