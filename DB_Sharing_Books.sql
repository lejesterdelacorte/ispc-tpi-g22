-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Sharing_Books
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sharing_Books
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Sharing_Books` DEFAULT CHARACTER SET utf8 ;
USE `Sharing_Books` ;

-- -----------------------------------------------------
-- Table `Sharing_Books`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sharing_Books`.`domicilio` (
  `ID_domicilio` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(70) NOT NULL,
  `altura` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(70) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_domicilio`),
  UNIQUE INDEX `ID_domicilio_UNIQUE` (`ID_domicilio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sharing_Books`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sharing_Books`.`usuario` (
  `ID_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(60) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `fecha_nacimiento` DATE NULL,
  `telefono` VARCHAR(45) NULL,
  `e_mail` VARCHAR(70) NOT NULL,
  `password` VARCHAR(70) NOT NULL,
  `ID_domicilio` INT NULL,
  PRIMARY KEY (`ID_usuario`),
  UNIQUE INDEX `ID_usuario_UNIQUE` (`ID_usuario` ASC) VISIBLE,
  UNIQUE INDEX `nombre_usuario_UNIQUE` (`nombre_usuario` ASC) VISIBLE,
  UNIQUE INDEX `e_mail_UNIQUE` (`e_mail` ASC) VISIBLE,
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE,
  INDEX `ID_domicilio_idx` (`ID_domicilio` ASC) VISIBLE,
  CONSTRAINT `ID_domicilio`
    FOREIGN KEY (`ID_domicilio`)
    REFERENCES `Sharing_Books`.`domicilio` (`ID_domicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sharing_Books`.`libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sharing_Books`.`libro` (
  `ID_libro` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `autor` VARCHAR(70) NULL,
  `editorial` VARCHAR(50) NULL,
  `fecha_publicacion` DATE NULL,
  `genero` VARCHAR(45) NULL,
  `ID_usuario` INT NULL,
  PRIMARY KEY (`ID_libro`),
  UNIQUE INDEX `ID_libro_UNIQUE` (`ID_libro` ASC) VISIBLE,
  INDEX `ID_usuario_idx` (`ID_usuario` ASC) VISIBLE,
  CONSTRAINT `ID_usuario`
    FOREIGN KEY (`ID_usuario`)
    REFERENCES `Sharing_Books`.`usuario` (`ID_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sharing_Books`.`punto_encuentro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sharing_Books`.`punto_encuentro` (
  `ID_punto_encuentro` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `ID_domicilio` INT NULL,
  `descripcion` VARCHAR(100) NULL,
  PRIMARY KEY (`ID_punto_encuentro`),
  UNIQUE INDEX `ID_punto_encuentro_UNIQUE` (`ID_punto_encuentro` ASC) VISIBLE,
  INDEX `ID_domicilio_idx` (`ID_domicilio` ASC) VISIBLE,
  CONSTRAINT `ID_domicilio`
    FOREIGN KEY (`ID_domicilio`)
    REFERENCES `Sharing_Books`.`domicilio` (`ID_domicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sharing_Books`.`Intercambio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sharing_Books`.`Intercambio` (
  `ID_intercambio` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_intercambio` DATE NULL,
  `ID_usuario1` INT NULL,
  `ID_libro1` INT NULL,
  `ID_usuario2` INT NULL,
  `ID_libro2` INT NULL,
  `ID_punto_encuentro` INT NULL,
  PRIMARY KEY (`ID_intercambio`),
  INDEX `ID_usuario_idx` (`ID_usuario1` ASC, `ID_usuario2` ASC) VISIBLE,
  INDEX `ID_libro_idx` (`ID_libro1` ASC, `ID_libro2` ASC) VISIBLE,
  INDEX `ID_punto_encuentro_idx` (`ID_punto_encuentro` ASC) VISIBLE,
  CONSTRAINT `ID_usuario`
    FOREIGN KEY (`ID_usuario1` , `ID_usuario2`)
    REFERENCES `Sharing_Books`.`usuario` (`ID_usuario` , `ID_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_libro`
    FOREIGN KEY (`ID_libro1` , `ID_libro2`)
    REFERENCES `Sharing_Books`.`libro` (`ID_libro` , `ID_libro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_punto_encuentro`
    FOREIGN KEY (`ID_punto_encuentro`)
    REFERENCES `Sharing_Books`.`punto_encuentro` (`ID_punto_encuentro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
