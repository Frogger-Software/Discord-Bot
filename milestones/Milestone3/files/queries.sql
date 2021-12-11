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
c.`name` AS "Campus Name", vl.`date` AS "Visit Date"
from Campus c
left join Visitor_List vl ON vl.campus = c.campus_id
group by c.`name`;

