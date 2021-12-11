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

select
e.`name` AS "Manager Name", e.manager AS "Manager ID", count(e.manager) AS "Employees Managed"
from Employees e
group by e.manager;

select * from Employees;
