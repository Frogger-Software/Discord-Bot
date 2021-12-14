SELECT
j.`name` AS "Janitor Name", c.`square_footage (ft)` AS "Square Footage"
FROM Janitor j
LEFT JOIN Cleaning_Assign ca ON ca.janitor = j.janitor_id
LEFT JOIN Campus c ON c.campus_id = ca.campus
order by c.`square_footage (ft)` desc
limit 2;

select
p.`name` AS "Product Name", SUM(cost) as "Total Cost"
from Product p
left join Advertisement a ON a.product = p.product_id
GROUP BY p.`name`;

select
p.`name` AS "Product Name", SUM(profit) as "Total Profit"
from Product p
left join Sale s ON s.product = p.product_id
GROUP BY p.`name`;

select
c.`name` AS "Campus Name", COUNT(vl.`date`) AS "Visits"
from Campus c
left join Visitor_List vl ON vl.campus = c.campus_id
where vl.`date` >= DATE_ADD(NOW(), INTERVAL -2 MONTH)
group by c.`name`;

SELECT 
m.name AS "Manager Name" 
,COUNT(e.employee_id) AS "Employees Managed"
FROM Employees e
JOIN Employees m ON m.employee_id = e.manager
GROUP BY m.name;

select
p.name AS "Product Name", SUM(s.profit) 
-- * 100 / t.s 
AS "Profit"
from 
Sale s
left join Product p ON p.product_id = s.product
cross join (select
SUM(s.profit) AS s
from Sale s) t
group by p.name
order by "Profit"
limit 3;

Select
w.name AS "Wellness Center Name", a.daily_activity AS "Most Popular Acitivity"
From Wellness_Center w
left join Activities a ON a.wellness = w.wellness_center_id
group by a.daily_activity, w.name 
order by count(a.daily_activity);




