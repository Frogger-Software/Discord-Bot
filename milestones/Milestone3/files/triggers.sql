-- Additional Table Required for Trigger #1. 
DROP TABLE IF EXISTS `FrogXDB`.`manager_history` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`manager_history` (
    old_employee_id INT,
    old_name VARCHAR(45),
    old_manager INT,
    fullname_change_date DATETIME)
 ENGINE = InnoDB;   
 
 -- Additional Table Required for Trigger #2. 
 DROP TABLE IF EXISTS `FrogXDB`.`username_audit` ;

CREATE TABLE IF NOT EXISTS `FrogXDB`.`username_audit` (
    old_user_id INT,
    old_username VARCHAR(45),
    old_password VARCHAR(45),
    username_change_date DATETIME)
 ENGINE = InnoDB;   
 

-- Triggers --------------------------------------------------------------
-- 1. Create an audit trigger that stores the old information of the employee whenever the manager is changed
DROP TRIGGER IF EXISTS manager_change
DELIMITER $$

CREATE TRIGGER manager_change
AFTER UPDATE 
ON Employees FOR EACH ROW 
BEGIN
    IF (OLD.manager <> NEW.manager) THEN
        INSERT INTO manager_history(old_employee_id, old_name, old_manager, fullname_change_date)
        VALUES(OLD.employee_id, OLD.name, OLD.manager, NOW());
    END IF;
END$$

DELIMITER ;

-- 2. Create an audit trigger that stores the old username whenever a User changes their account username.
DROP TRIGGER IF EXISTS user_username_change
DELIMITER $$

CREATE TRIGGER user_username_change
AFTER UPDATE 
ON `User` FOR EACH ROW 
BEGIN
    IF OLD.username <> NEW.username THEN
        INSERT INTO username_audit(old_user_id, old_username, username_change_date)
        VALUES(OLD.user_id, OLD.username, NOW());
    END IF;
END$$

DELIMITER ;

-- Function --------------------------------------------------------------
-- 1. Create a function that adds the first and last name together
DROP FUNCTION IF EXISTS concat_name;
DELIMITER $$

CREATE FUNCTION concat_name (

    foo_first_name VARCHAR(22),
    foo_last_name VARCHAR(22)
)
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
        RETURN CONCAT(foo_first_name, ' ', foo_last_name);
END $$

DELIMITER ;
-- Procedure --------------------------------------------------------------
-- 1. Create a procedure that returns all team assignments
DROP PROCEDURE IF EXISTS get_teams;
DELIMITER $$

CREATE PROCEDURE get_teams()
BEGIN
    SELECT 
    t.employee
    , t.team
    FROM Team_Assign t;
END $$

DELIMITER ;