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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `idDoctor` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Adress` VARCHAR(200) NULL,
  `Phone_number` INT NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`idDoctor`),
  UNIQUE INDEX `idDoctor_UNIQUE` (`idDoctor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `idMedical` INT NOT NULL,
  `Overtime_rate` INT NULL,
  `Doctor_ID` INT NOT NULL,
  PRIMARY KEY (`idMedical`),
  UNIQUE INDEX `idMedical_UNIQUE` (`idMedical` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_ID_UNIQUE` (`Doctor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_Doctor`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `idSpecialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  `Doctor_ID` INT NOT NULL,
  PRIMARY KEY (`idSpecialist`),
  UNIQUE INDEX `idSpecialist_UNIQUE` (`idSpecialist` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_ID_UNIQUE` (`Doctor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Specialist_Doctor`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Adress` VARCHAR(200) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`idPatient`),
  UNIQUE INDEX `idPatient_UNIQUE` (`idPatient` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NULL,
  `Time` VARCHAR(45) NULL,
  `Patient_ID` INT NOT NULL,
  `Doctor_ID` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  UNIQUE INDEX `idAppointment_UNIQUE` (`idAppointment` ASC) VISIBLE,
  UNIQUE INDEX `Patient_ID_UNIQUE` (`Patient_ID` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_ID_UNIQUE` (`Doctor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Method` VARCHAR(45) NULL,
  `Details` VARCHAR(45) NULL,
  `Patient_ID` INT NOT NULL,
  PRIMARY KEY (`idPayment`),
  UNIQUE INDEX `idPayment_UNIQUE` (`idPayment` ASC) VISIBLE,
  UNIQUE INDEX `Patient_ID_UNIQUE` (`Patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Patient`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `Total` VARCHAR(45) NULL,
  `Doctor_ID` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  UNIQUE INDEX `Doctor_ID_UNIQUE` (`Doctor_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Doctor`
    FOREIGN KEY (`Doctor_ID`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PaymentOfBill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PaymentOfBill` (
  `idPaymentOfBill` INT NOT NULL,
  `Payment_ID` INT NOT NULL,
  `Bill_ID` INT NOT NULL,
  PRIMARY KEY (`idPaymentOfBill`),
  UNIQUE INDEX `Payment_ID_UNIQUE` (`Payment_ID` ASC) VISIBLE,
  UNIQUE INDEX `idPaymentOfBill_UNIQUE` (`idPaymentOfBill` ASC) VISIBLE,
  UNIQUE INDEX `Bill_ID_UNIQUE` (`Bill_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentOfBill_Payment`
    FOREIGN KEY (`Payment_ID`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentOfBill_Bill`
    FOREIGN KEY (`Bill_ID`)
    REFERENCES `mydb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
