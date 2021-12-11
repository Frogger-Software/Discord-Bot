-- Script name: inserts.sql
-- Author:      Ze Lei
-- Purpose:     insert sample data to test the integrity of this database system
USE `FrogXDB`;

INSERT INTO `Department` (`department_id`) VALUES (1), (2), (3);
-- SELECT * FROM Department;

INSERT INTO `Employees` (`name`, `manager`, `department`) VALUES
 ('Gob', NULL, 1),
 ('Rob', 1, 2),
 ('Job', 1, 3),
 ('Cob', 3, 2),
 ('Qob', 3, 3);
-- SELECT * FROM Employees;

INSERT INTO `Teams` (`team_id`, `team_lead`, `team_name`) VALUES 
(1, NULL, 'robots'),
(2, 1, 'in'),
(3, NULL, 'disguise');
-- SELECT * FROM Teams;

INSERT INTO `Team_Assign` (`employee`, `team`) VALUES
 (1, 1),
 (2, 2),
 (3, 1);
 -- SELECT * FROM Team_Assign;
 
 INSERT INTO `Campus` (`name`, `square_footage (ft)`) VALUES
 ('Mountain View', 20),
 ('Seattle', 42),
 ('New York', 54),
 ('Austin', 36);
-- SELECT * FROM Campus;

 INSERT INTO `Janitor` (`name`) VALUES
 ('Jon'),
 ('Ron'),
 ('Won'),
 ('Ton'),
 ('Swon');
 
-- select * from  `Janitor`;

INSERT INTO `Campus_Assign` ( `employee`, `campus`) VALUES
 (1, 1),
 (2, 3),
 (3, 2);
 
 INSERT INTO `Wellness_Center` (`name`) VALUES
 ('Mashouf'),
 ('Caesar'),
 ('Chavez');
 
 INSERT INTO `Activities` (`campus`, `wellness`, `daily_activity`) VALUES
 (1, 2, 'run'),
 (2, 2, 'walk'),
 (1, 3, 'jump');
 
 INSERT INTO `Visitor` (`name`) VALUES
 ( 'John'),
 ( 'Paul'),
 ( 'Santiago');
 
 INSERT INTO `Visitor_List` (`visitor`, `campus`, `date`) VALUES
 ( 1, 1, '2021-12-01 00:00:00'),
 ( 2, 2, '2019-12-01 00:00:00'),
 ( 3, 3, '2021-12-01 00:00:00'),
 ( 3, 1, '2019-12-01 00:00:00'),
 ( 1, 1, '2021-12-01 00:00:00'),
 ( 2, 2, '2019-12-01 00:00:00'),
 ( 3, 3, '2021-12-01 00:00:00'),
 ( 3, 1, '2021-10-01 00:00:00');
 
 INSERT INTO `Dining_Hall` (`name`) VALUES
 ('City'),
 ('Eats'),
 ('Bricks');
 
 INSERT INTO `Meals` (`campus`, `dining`, `daily_menu`) VALUES
 (1, 3, 'chicken'),
 (2, 2, 'beef'),
 (3, 1, 'pork');
 
 
 INSERT INTO `Cleaning_Assign` (`campus`, `janitor`) VALUES
 (1, 1),
 (2, 2),
 (3, 3),
 (4, 4),
 (4, 5);
 
 INSERT INTO `Parking_Lot` (`name`, `capacity`) VALUES
 ('San', 40),
 ('Luis', 40),
 ('Obispo', 40);
 
 INSERT INTO `Parking` (`campus`, `parking_lot`) VALUES
 (1, 1),
 (2, 2),
 (3, 3);
 
 INSERT INTO `Marketing` (`department`, `name`) VALUES (1, 'Marketing'),(2, '1'),(3, '2');
 
 INSERT INTO `Software` (`department`, `name`) VALUES (2, 'Software'),(1, '1'),(3, '2');
 
 INSERT INTO `Sales` (`department`, `name`) VALUES (3, 'Sales'),(2, '1'),(1, '2');
 
 INSERT INTO `Product` (`price`, `name`) VALUES (111, 'Frog1'),(222, 'Frog2'),(333, 'Frog3');
 
 INSERT INTO `Advertisement` ( `product`, `cost`) VALUES (1, 20), (2, 40), (2, 12);
 
 INSERT INTO `Location` (`name`) VALUES  ('Mashouf'),
 ('Caesar'),
 ('Chavez');
 
INSERT INTO `Billboard` (`advertisement`, `location`) VALUES
(1, 2),
(2, 2),
(1, 3);
  
INSERT INTO `Sale` (`product`, `profit`) VALUES
 (1, 47),(1,  52),(1,  20), (2, 35);
 
 INSERT INTO `User` (`username`, `password`) VALUES 
 ('this', 'is'),('a', 'good'),('pass', 'word');
 
 INSERT INTO `Uses` (`product`, `user`) VALUES (1, 2),(1, 3),(1, 1);
 
 INSERT INTO `Platform` (`name`) VALUES ('Firefox'),('Chrome'),('Brave');
 
 INSERT INTO `On` (`product`, `platform`) VALUES (1, 1),(2, 2),(3, 3);
 
 INSERT INTO `CEO` (`name`) VALUES
 ('Cook'),('Jobs'),('Wozniak');
 
 INSERT INTO `Department_Head` (`department`, `ceo`, `name`) VALUES
 (1, 1, 'Ryan'), (2, 1, 'Joe'),(3, 1, 'Josh');
 
 INSERT INTO `Shares` (`ceo`) VALUES
 (1),(2),(3);
 
 INSERT INTO `Shareholders` (`name`) VALUES ('Lady'),('Ga'),('Ga');
 
 INSERT INTO `Retail_Shares` (`shares`, `shareholder`) VALUES (1, 1),(3, 2),(2, 3);
 
 INSERT INTO `Board_Member` (`name`) VALUES ('Yves'),('Saint'),('Laurent');
 
 INSERT INTO `Board_Shares` (`shares`, `board`) VALUES (1, 2),(1, 2), (2, 1);