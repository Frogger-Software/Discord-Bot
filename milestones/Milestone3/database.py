# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors
from prettytable import PrettyTable

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
    try:
        conn = pymysql.connect(host=db_host,
                               port=3306,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4",
                               cursorclass=pymysql.cursors.DictCursor)
        print("Bot connected to database {}".format(db_name))
        return conn
    except:
        print(
            "Bot failed to create a connection with your database because your secret environment variables "
            + "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(
                db_name))
        print("\n")


# your code here


def format_data(headers, rows):
    table = PrettyTable()
    table.field_names = headers
    table.add_rows(rows)

    return table


def getResponse(msg):
    data = msg.split()
    errors = PrettyTable()
    errors.field_names = ["Error"]
    response = None
    command = data[0]
    hasErrors = False
    errMsg = ["You are missing the number argument"]
    #   1. For each janitor, find the x that have cleaned the most in square footage
    #   1. /big-janitors <x janitors>
    if "/big-janitors" in command:
        if 2 > len(data):
            errors.add_row(errMsg)
            hasErrors = True
        else:
            num = data[1]
            response = bigJanitors(num)
    #   2. For each product, calculate the total cost of advertisements
    #   2. /ad-costs
    elif "/ad-costs" in command:
        response = adCosts()
    #   3. For each product, find the total gross revenue
    elif "/revenue" in command:
        response = revenue()
    #   4. For each campus, find all visitors that visited within the past month
    elif "/campus-visits" in command:
        if 2 > len(data):
            errors.add_row(errMsg)
            hasErrors = True
        else:
            num = data[1]
            response = campusVisits(num)
    #   6. For each manager, find the number of employees they manage
    elif "/managers" in command:
        response = managers()
    #   7. Find the x highest grossing product
    elif "/best-products" in command:
        if 2 > len(data):
            errors.add_row(errMsg)
            hasErrors = True
        else:
            num = data[1]
            response = bestProducts(num)
    #   8. For each wellness center, find the most popular activity on average
    elif "/best-activities" in command:
        response = bestActivities()
    if hasErrors:
        return errors
    return response


def bigJanitors(num):
    conn = connect()
    rows = []
    headers = ['Janitor', 'Square Footage']
    if conn:
        cursor = conn.cursor()
        query = """SELECT
j.`name` AS "Janitor Name", c.`square_footage (ft)` AS "Square Footage"
FROM Janitor j
LEFT JOIN Cleaning_Assign ca ON ca.janitor = j.janitor_id
LEFT JOIN Campus c ON c.campus_id = ca.campus
order by c.`square_footage (ft)` desc
limit %s;"""
        variable = int(num)
        cursor.execute(query, variable)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Janitor Name']
                column2 = queryData['Square Footage']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output


def adCosts():
    conn = connect()
    rows = []
    headers = ['Product', 'Cost of Ads']
    if conn:
        cursor = conn.cursor()
        query = """select
p.`name` AS "Product Name", SUM(cost) as "Total Cost"
from Product p
left join Advertisement a ON a.product = p.product_id
GROUP BY p.`name`;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Product Name']
                column2 = queryData['Total Cost']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output


def revenue():
    conn = connect()
    rows = []
    headers = ['Product', 'Total Profit']
    if conn:
        cursor = conn.cursor()
        query = """select
p.`name` AS "Product Name", SUM(profit) as "Total Profit"
from Product p
left join Sale s ON s.product = p.product_id
GROUP BY p.`name`;;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Product Name']
                column2 = queryData['Total Profit']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output


def campusVisits(num):
    conn = connect()
    rows = []
    headers = ['Campus Name', 'Visits']
    if conn:
        cursor = conn.cursor()
        query = """select
c.`name` AS "Campus Name", COUNT(vl.`date`) AS "Visits"
from Campus c
left join Visitor_List vl ON vl.campus = c.campus_id
where vl.`date` >= DATE_ADD(NOW(), INTERVAL -%s MONTH)
group by c.`name`;"""
        variable = int(num)
        cursor.execute(query, variable)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Campus Name']
                column2 = queryData['Visits']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output


def managers():
    conn = connect()
    rows = []
    headers = ['Manager Name', 'Employees Managed']
    if conn:
        cursor = conn.cursor()
        query = """SELECT 
m.name AS "Manager Name" 
,COUNT(e.employee_id) AS "Employees Managed"
FROM Employees e
JOIN Employees m ON m.employee_id = e.manager
GROUP BY m.name;"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Manager Name']
                column2 = queryData['Employees Managed']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output


def bestProducts(num):
    conn = connect()
    rows = []
    headers = ['Product Name', 'Sales']
    if conn:
        cursor = conn.cursor()
        query = """select
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
limit %s;"""
        variable = int(num)
        cursor.execute(query, variable)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Product Name']
                column2 = queryData['Profit']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output


def bestActivities():
    conn = connect()
    rows = []
    headers = ['Wellness Center Name', 'Most Popular Acitivity']
    if conn:
        cursor = conn.cursor()
        query = """Select
w.name AS "Wellness Center Name", a.daily_activity AS "Most Popular Acitivity"
From Wellness_Center w
left join Activities a ON a.wellness = w.wellness_center_id
group by a.daily_activity, w.name 
order by count(a.daily_activity);"""
        cursor.execute(query)
        data = cursor.fetchall()
        if data:
            for queryData in data:
                row = []
                column1 = queryData['Wellness Center Name']
                column2 = queryData['Most Popular Acitivity']
                row.append(column1)
                row.append(column2)
                rows.append(row)
        output = format_data(headers, rows)
        return output
