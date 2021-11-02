-- Script name: tests.sql
-- Author:      Ze Lei
-- Purpose:     test the integrity of this database system
USE `FrogXDB`;

DELETE FROM Department WHERE department_id = 3;
UPDATE Department SET department_id = 4 WHERE department_id = 1;

DELETE FROM Employees WHERE employee_id = 3;
UPDATE Employees SET employee_id = 5 WHERE employee_id = 2;

DELETE FROM Teams WHERE team_id = 3;
UPDATE Teams SET team_id = 5 WHERE team_id = 2;

DELETE FROM Team_Assign WHERE employee = 3;
UPDATE Team_Assign SET employee = 5 WHERE employee = 2;

DELETE FROM Campus WHERE campus_id = 3;
UPDATE Campus SET campus_id = 5 WHERE campus_id = 2;

DELETE FROM Campus_Assign WHERE campus_assign_id = 3;
UPDATE Campus_Assign SET campus_assign_id = 5 WHERE campus_assign_id = 2;
 
DELETE FROM Wellness_Center WHERE wellness_center_id = 3;
UPDATE Wellness_Center SET wellness_center_id = 5 WHERE wellness_center_id = 2;

DELETE FROM Activities WHERE activities_id = 3;
UPDATE Activities SET activities_id = 5 WHERE activities_id = 2;

DELETE FROM Visitor WHERE visitor_id = 3;
UPDATE Visitor SET visitor_id = 5 WHERE visitor_id = 2;
 
DELETE FROM Visitor_List WHERE visitor_list_id = 3;
UPDATE Visitor_List SET visitor_list_id = 5 WHERE visitor_list_id = 2;
 
DELETE FROM Dining_Hall WHERE dining_hall_id = 3;
UPDATE Dining_Hall SET dining_hall_id = 5 WHERE dining_hall_id = 2;
 
DELETE FROM Meals WHERE meals_id = 3;
UPDATE Meals SET meals_id = 5 WHERE meals_id = 2;
 
DELETE FROM Janitor WHERE janitor_id = 3;
UPDATE Janitor SET janitor_id = 5 WHERE janitor_id = 2;
 
DELETE FROM Cleaning_Assign WHERE campus = 3;
UPDATE Cleaning_Assign SET campus = 5 WHERE campus = 2;
 
DELETE FROM Parking_Lot WHERE parking_lot_id = 3;
UPDATE Parking_Lot SET parking_lot_id = 5 WHERE parking_lot_id = 2;
 
DELETE FROM Parking WHERE parking_id = 3;
UPDATE Parking SET parking_id = 5 WHERE parking_id = 2;
 
DELETE FROM Marketing WHERE department = 3;
-- UPDATE Marketing SET department = 5 WHERE department = 2; 22:44:30	UPDATE Marketing SET department = 5 WHERE department = 2	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`frogxdb`.`marketing`, CONSTRAINT `MARKETING_DEPARTMENT_FK` FOREIGN KEY (`department`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE)	0.000 sec
 UPDATE Marketing SET department = 2 WHERE department = 1;
 
DELETE FROM Software WHERE department = 3;
UPDATE Software SET department = 2 WHERE department = 1;

DELETE FROM Sales WHERE department = 2;
UPDATE Sales SET department = 3 WHERE department = 1;

DELETE FROM Product WHERE product_id = 3;
UPDATE Product SET product_id = 5 WHERE product_id = 2;

DELETE FROM Advertisement WHERE advertisement_id = 3;
UPDATE Advertisement SET advertisement_id = 5 WHERE advertisement_id = 2;
 
DELETE FROM Location WHERE location_id = 3;
UPDATE Location SET location_id = 5 WHERE location_id = 2;

DELETE FROM Billboard WHERE billboard_id = 3;
UPDATE Billboard SET billboard_id = 5 WHERE billboard_id = 2;

DELETE FROM Sale WHERE sale_id = 3;
UPDATE Sale SET sale_id = 5 WHERE sale_id = 2;

DELETE FROM Sale WHERE sale_id = 3;
UPDATE Sale SET sale_id = 5 WHERE sale_id = 2;

DELETE FROM `User` WHERE user_id = 3;
UPDATE `User` SET user_id = 5 WHERE user_id = 2;

DELETE FROM `Uses` WHERE `user` = 3;
UPDATE `Uses` SET `user` = 5 WHERE `user` = 2;

DELETE FROM `Platform` WHERE `platform_id` = 3;
UPDATE `Platform` SET `platform_id` = 5 WHERE `platform_id` = 2;

DELETE FROM `On` WHERE `product` = 3;
UPDATE `On` SET `product` = 5 WHERE `product` = 2; 

DELETE FROM `CEO` WHERE `ceo_id` = 3;
UPDATE `CEO` SET `ceo_id` = 5 WHERE `ceo_id` = 2;

DELETE FROM `Department_Head` WHERE `department_head_id` = 3;
UPDATE `Department_Head` SET `department_head_id` = 5 WHERE `department_head_id` = 2; 

DELETE FROM `Shares` WHERE `shares_id` = 3;
UPDATE `Shares` SET `shares_id` = 5 WHERE `shares_id` = 2; 

DELETE FROM `Shareholders` WHERE `shareholders_id` = 3;
UPDATE `Shareholders` SET `shareholders_id` = 5 WHERE `shareholders_id` = 2;  
 
DELETE FROM `Retail_Shares` WHERE `retail_shares_id` = 3;
UPDATE `Retail_Shares` SET `retail_shares_id` = 5 WHERE `retail_shares_id` = 2;  

DELETE FROM `Retail_Shares` WHERE `retail_shares_id` = 3;
UPDATE `Retail_Shares` SET `retail_shares_id` = 5 WHERE `retail_shares_id` = 2; 

DELETE FROM `Board_Member` WHERE `board_member_id` = 3;
UPDATE `Board_Member` SET `board_member_id` = 5 WHERE `board_member_id` = 2;

DELETE FROM `Board_Shares` WHERE `board_shares_id` = 3;
UPDATE `Board_Shares` SET `board_shares_id` = 5 WHERE `board_shares_id` = 2; 
 
 
 
 
 
 
 
 
 
 
 
 
 