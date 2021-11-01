-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FrogXDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FrogXDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FrogXDB` DEFAULT CHARACTER SET utf8 ;
USE `FrogXDB` ;

-- -----------------------------------------------------
-- Table `FrogXDB`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Department` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Department` (
  `department_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `DepartmentID_UNIQUE` (`department_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Employees` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Employees` (
  `employee_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `manager` INT UNSIGNED NULL DEFAULT 0,
  `department` INT UNSIGNED NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`employee_id` ASC),
  CONSTRAINT `EMPLOYEE_MANAGER_FK`
    FOREIGN KEY (`manager`)
    REFERENCES `FrogXDB`.`Employees` (`employee_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `EMPLOYEE_DEPARTMENT_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Department` (`department_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Teams` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Teams` (
  `team_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_lead` INT UNSIGNED NOT NULL,
  `team_name` VARCHAR(45) NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE INDEX `TeamID_UNIQUE` (`team_id` ASC),
  UNIQUE INDEX `TeamLead_UNIQUE` (`team_lead` ASC),
  CONSTRAINT `TEAMS_TEAMLEAD_FK`
    FOREIGN KEY (`team_lead`)
    REFERENCES `FrogXDB`.`Employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Team_Assign`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Team_Assign` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Team_Assign` (
  `team_assign_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee` INT UNSIGNED NOT NULL,
  `team` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`team_assign_id`),
  UNIQUE INDEX `are_in_ID_UNIQUE` (`team_assign_id` ASC),
  UNIQUE INDEX `fk_employee_UNIQUE` (`employee` ASC),
  CONSTRAINT `TEAMASSIGN_TEAM_FK`
    FOREIGN KEY (`team`)
    REFERENCES `FrogXDB`.`Teams` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TEAMASSIGN_EMPLOYEE_FK`
    FOREIGN KEY (`employee`)
    REFERENCES `FrogXDB`.`Employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Marketing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Marketing` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Marketing` (
  `department` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'Marketing',
  UNIQUE INDEX `fk_department_UNIQUE` (`department` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  PRIMARY KEY (`department`),
  CONSTRAINT `MARKETING_DEPARTMENT_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Software`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Software` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Software` (
  `department` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'Software',
  UNIQUE INDEX `idSoftware_UNIQUE` (`department` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  PRIMARY KEY (`department`),
  CONSTRAINT `SOFTWARE_DEPARTMENT_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Product` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Product` (
  `product_id` INT UNSIGNED NOT NULL,
  `price` INT UNSIGNED NOT NULL,
  `software` VARCHAR(45) NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `idProduct_UNIQUE` (`product_id` ASC),
  INDEX `software_idx` (`software` ASC),
  CONSTRAINT `PRODUCT_SOFTWARE_FK`
    FOREIGN KEY (`software`)
    REFERENCES `FrogXDB`.`Software` (`name`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Sales` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Sales` (
  `department` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'Sales',
  UNIQUE INDEX `fk_department_UNIQUE` (`department` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  PRIMARY KEY (`department`),
  CONSTRAINT `SALES_DEPARTMENT_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`User` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`User` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `idUser_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Uses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Uses` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Uses` (
  `uses_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product` INT UNSIGNED NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`uses_id`),
  UNIQUE INDEX `idUses_UNIQUE` (`uses_id` ASC),
  UNIQUE INDEX `fk_user_UNIQUE` (`user` ASC),
  UNIQUE INDEX `fk_product_UNIQUE` (`product` ASC),
  CONSTRAINT `USES_PRODUCT_FK`
    FOREIGN KEY (`product`)
    REFERENCES `FrogXDB`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `USES_USER_FK`
    FOREIGN KEY (`user`)
    REFERENCES `FrogXDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Platform` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Platform` (
  `platform_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`platform_id`),
  UNIQUE INDEX `idPlatform_UNIQUE` (`platform_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`On`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`On` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`On` (
  `on_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product` INT UNSIGNED NOT NULL,
  `platform` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`on_id`),
  UNIQUE INDEX `idOn_UNIQUE` (`on_id` ASC),
  UNIQUE INDEX `fk_platform_UNIQUE` (`platform` ASC),
  UNIQUE INDEX `fk_product_UNIQUE` (`product` ASC),
  CONSTRAINT `ON_PRODUCT_FK`
    FOREIGN KEY (`product`)
    REFERENCES `FrogXDB`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ON_PLATFORM_FK`
    FOREIGN KEY (`platform`)
    REFERENCES `FrogXDB`.`Platform` (`platform_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`CEO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`CEO` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`CEO` (
  `ceo_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ceo_id`),
  UNIQUE INDEX `idCEO_UNIQUE` (`ceo_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Department_Head`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Department_Head` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Department_Head` (
  `department_head_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `department` INT UNSIGNED NOT NULL,
  `ceo` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`department_head_id`),
  UNIQUE INDEX `Department_Head_ID_UNIQUE` (`department_head_id` ASC),
  UNIQUE INDEX `fk_department_UNIQUE` (`department` ASC),
  UNIQUE INDEX `fk_CEO_UNIQUE` (`ceo` ASC),
  CONSTRAINT `DEPARTMENTHEAD_DEPARTMENT_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `DEPARTMENTHEAD_CEO_FK`
    FOREIGN KEY (`ceo`)
    REFERENCES `FrogXDB`.`CEO` (`ceo_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Shares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Shares` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Shares` (
  `shares_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ceo` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`shares_id`),
  UNIQUE INDEX `idShares_UNIQUE` (`shares_id` ASC),
  UNIQUE INDEX `fk_owner_UNIQUE` (`ceo` ASC),
  CONSTRAINT `SHARES_CEO_FK`
    FOREIGN KEY (`ceo`)
    REFERENCES `FrogXDB`.`CEO` (`ceo_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Shareholders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Shareholders` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Shareholders` (
  `shareholders_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`shareholders_id`),
  UNIQUE INDEX `idShareholders_UNIQUE` (`shareholders_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Board Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Board Member` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Board Member` (
  `board_member_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`board_member_id`),
  UNIQUE INDEX `idBoard Member_UNIQUE` (`board_member_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Board Shares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Board Shares` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Board Shares` (
  `board_shares_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `shares` INT UNSIGNED NOT NULL,
  `board` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`board_shares_id`),
  UNIQUE INDEX `idBoard Shares_UNIQUE` (`board_shares_id` ASC),
  CONSTRAINT `BOARDSHARES_SHARES_FK`
    FOREIGN KEY (`shares`)
    REFERENCES `FrogXDB`.`Shares` (`shares_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BOARDSHARES_BOARDMEMBER_FK`
    FOREIGN KEY (`board`)
    REFERENCES `FrogXDB`.`Board Member` (`board_member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Retail_Shares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Retail_Shares` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Retail_Shares` (
  `retail_shares_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `shares` INT UNSIGNED NOT NULL,
  `shareholder` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`retail_shares_id`),
  UNIQUE INDEX `idRetail Shares_UNIQUE` (`retail_shares_id` ASC),
  CONSTRAINT `RETAILSHARES_SHARES_FK`
    FOREIGN KEY (`shares`)
    REFERENCES `FrogXDB`.`Shares` (`shares_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `RETAILSHARES_SHAREHOLDERS_FK`
    FOREIGN KEY (`shareholder`)
    REFERENCES `FrogXDB`.`Shareholders` (`shareholders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Campus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Campus` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Campus` (
  `campus_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `square_footage (ft)` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`campus_id`),
  UNIQUE INDEX `idCampus_UNIQUE` (`campus_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Campus_Assign`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Campus_Assign` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Campus_Assign` (
  `campus_assign_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee` INT UNSIGNED NOT NULL,
  `campus` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`campus_assign_id`),
  UNIQUE INDEX `idAssignment_UNIQUE` (`campus_assign_id` ASC),
  UNIQUE INDEX `fk_campus_UNIQUE` (`campus` ASC),
  UNIQUE INDEX `fk_employee_UNIQUE` (`employee` ASC),
  CONSTRAINT `CAMPUSASSIGN_EMPLOYEE_FK`
    FOREIGN KEY (`employee`)
    REFERENCES `FrogXDB`.`Employees` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CAMPUSASSIGN_CAMPUS_FK`
    FOREIGN KEY (`campus`)
    REFERENCES `FrogXDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Advertisement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Advertisement` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Advertisement` (
  `advertisement_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product` INT UNSIGNED NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `price` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`advertisement_id`),
  UNIQUE INDEX `idadvertisement_UNIQUE` (`advertisement_id` ASC),
  INDEX `marketing_idx` (`department` ASC),
  INDEX `product_idx` (`product` ASC),
  CONSTRAINT `ADVERTISEMENT_MARKETING_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Marketing` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ADVERTISEMENT_PRODUCT_FK`
    FOREIGN KEY (`product`)
    REFERENCES `FrogXDB`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Sale` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Sale` (
  `sale_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product` INT UNSIGNED NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `profit` INT NOT NULL,
  PRIMARY KEY (`sale_id`),
  UNIQUE INDEX `idSale_UNIQUE` (`sale_id` ASC),
  INDEX `sales_idx` (`department` ASC),
  INDEX `product_idx` (`product` ASC),
  CONSTRAINT `SALE_SALES_FK`
    FOREIGN KEY (`department`)
    REFERENCES `FrogXDB`.`Sales` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `SALE_PRODUCT_FK`
    FOREIGN KEY (`product`)
    REFERENCES `FrogXDB`.`Product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Wellness_Center`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Wellness_Center` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Wellness_Center` (
  `wellness_center_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`wellness_center_id`),
  UNIQUE INDEX `idWellness Center_UNIQUE` (`wellness_center_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Activities` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Activities` (
  `activities_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus` INT UNSIGNED NOT NULL,
  `wellness` INT UNSIGNED NOT NULL,
  `daily_activity` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`activities_id`),
  UNIQUE INDEX `idActivities_UNIQUE` (`activities_id` ASC),
  UNIQUE INDEX `fk_wellness_UNIQUE` (`wellness` ASC),
  UNIQUE INDEX `fk_campus_UNIQUE` (`campus` ASC),
  CONSTRAINT `ACTIVITIES_CAMPUS_FK`
    FOREIGN KEY (`campus`)
    REFERENCES `FrogXDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ACTIVITIES_WELLNESS_FK`
    FOREIGN KEY (`wellness`)
    REFERENCES `FrogXDB`.`Wellness_Center` (`wellness_center_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Dining_Hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Dining_Hall` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Dining_Hall` (
  `dining_hall_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dining_hall_id`),
  UNIQUE INDEX `idDining Hall_UNIQUE` (`dining_hall_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Meals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Meals` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Meals` (
  `meals_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus` INT UNSIGNED NOT NULL,
  `dining` INT UNSIGNED NOT NULL,
  `daily_menu` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`meals_id`),
  UNIQUE INDEX `idMeals_UNIQUE` (`meals_id` ASC),
  UNIQUE INDEX `fk_campus_UNIQUE` (`campus` ASC),
  UNIQUE INDEX `fk_dining_UNIQUE` (`dining` ASC),
  CONSTRAINT `MEALS_CAMPUS_FK`
    FOREIGN KEY (`campus`)
    REFERENCES `FrogXDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MEALS_DINING_FK`
    FOREIGN KEY (`dining`)
    REFERENCES `FrogXDB`.`Dining_Hall` (`dining_hall_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Visitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Visitor` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Visitor` (
  `visitor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`visitor_id`),
  UNIQUE INDEX `idVisitor_UNIQUE` (`visitor_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Visitor_List`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Visitor_List` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Visitor_List` (
  `visitor_list_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `visitor` INT UNSIGNED NOT NULL,
  `campus` INT UNSIGNED NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`visitor_list_id`),
  UNIQUE INDEX `fk_visitor_UNIQUE` (`visitor` ASC),
  UNIQUE INDEX `fk_campus_UNIQUE` (`campus` ASC),
  UNIQUE INDEX `idVisitor List_UNIQUE` (`visitor_list_id` ASC),
  CONSTRAINT `VISITORLIST_CAMPUS_FK`
    FOREIGN KEY (`campus`)
    REFERENCES `FrogXDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `VISITORLIST_VISITOR_FK`
    FOREIGN KEY (`visitor`)
    REFERENCES `FrogXDB`.`Visitor` (`visitor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Janitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Janitor` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Janitor` (
  `janitor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`janitor_id`),
  UNIQUE INDEX `idJanitor_UNIQUE` (`janitor_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Cleaning_Assign`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Cleaning_Assign` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Cleaning_Assign` (
  `cleaning_assign_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus` INT UNSIGNED NOT NULL,
  `janitor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cleaning_assign_id`),
  UNIQUE INDEX `idCleaning Assignment_UNIQUE` (`cleaning_assign_id` ASC),
  UNIQUE INDEX `fk_janitor_UNIQUE` (`janitor` ASC),
  UNIQUE INDEX `fk_campus_UNIQUE` (`campus` ASC),
  CONSTRAINT `CLEANINGASSIGN_CAMPUS_FK`
    FOREIGN KEY (`campus`)
    REFERENCES `FrogXDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CLEANINGASSIGN_JANITOR_FK`
    FOREIGN KEY (`janitor`)
    REFERENCES `FrogXDB`.`Janitor` (`janitor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Parking Lot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Parking Lot` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Parking Lot` (
  `parking_lot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `capacity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`parking_lot_id`),
  UNIQUE INDEX `idParking Lot_UNIQUE` (`parking_lot_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Parking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Parking` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Parking` (
  `parking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus` INT UNSIGNED NOT NULL,
  `parking_lot` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`parking_id`),
  UNIQUE INDEX `fk_parking_lot_UNIQUE` (`parking_lot` ASC),
  UNIQUE INDEX `fk_campus_UNIQUE` (`campus` ASC),
  UNIQUE INDEX `idParking_UNIQUE` (`parking_id` ASC),
  CONSTRAINT `PARKING_CAMPUS_FK`
    FOREIGN KEY (`campus`)
    REFERENCES `FrogXDB`.`Campus` (`campus_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PARKING_PARKINGLOT_FK`
    FOREIGN KEY (`parking_lot`)
    REFERENCES `FrogXDB`.`Parking Lot` (`parking_lot_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Location` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Location` (
  `location_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE INDEX `location_id_UNIQUE` (`location_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FrogXDB`.`Billboard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FrogXDB`.`Billboard` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`Billboard` (
  `billboard_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `advertisement` INT UNSIGNED NOT NULL,
  `location` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`billboard_id`),
  UNIQUE INDEX `billboard_id_UNIQUE` (`billboard_id` ASC),
  UNIQUE INDEX `advertisement_UNIQUE` (`advertisement` ASC),
  INDEX `BILLBOARD_LOCATION_FK_idx` (`location` ASC),
  CONSTRAINT `BILLBOARD_ADVERTISEMENT_FK`
    FOREIGN KEY (`advertisement`)
    REFERENCES `FrogXDB`.`Advertisement` (`advertisement_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BILLBOARD_LOCATION_FK`
    FOREIGN KEY (`location`)
    REFERENCES `FrogXDB`.`Location` (`location_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
