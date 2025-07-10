-- Question 1
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

USE Northwind;
SELECT CustomerName FROM customers;

-- Question 2
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

SELECT ProductName, Price FROM Products
WHERE Price < 15;

-- Question 3
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

SELECT FirstName, LastName FROM Employees;

-- Question 4
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

SELECT OrderID, OrderDate FROM Orders
WHERE YEAR(OrderDate) = 1997;

-- Question 5
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

SELECT ProductName, Price FROM Products
WHERE Price > 50;

-- Question 6
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

SELECT c.CustomerName, e.FirstName, e.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID;

-- Question 7
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

SELECT Country, COUNT(*) AS CustomerCount
FROM Customers
GROUP BY Country;

-- Question 8
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

SELECT c.CategoryName, ROUND(AVG(p.Price), 2) AS AvgPrice
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

-- Question 9
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

SELECT EmployeeID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY EmployeeID;

-- Question 10
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

SELECT p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Exotic Liquid';

-- Question 11
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

SELECT ProductID, SUM(Quantity) AS TotalOrdered
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;

-- Question 12
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

SELECT c.CustomerName, SUM(p.Price * od.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerName
HAVING TotalSpent > 10000;

-- Question 13
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

SELECT o.OrderID, SUM(p.Price * od.Quantity) AS OrderValue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING OrderValue > 2000;

-- Question 14
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

SELECT c.CustomerName, o.OrderID, SUM(p.Price * od.Quantity) AS TotalValue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING TotalValue = (
    SELECT MAX(OrderTotal) FROM (
        SELECT SUM(p.Price * od.Quantity) AS OrderTotal
        FROM Orders o
        JOIN OrderDetails od ON o.OrderID = od.OrderID
        JOIN Products p ON od.ProductID = p.ProductID
        GROUP BY o.OrderID
    ) AS OrderTotals
);

-- Question 15
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

SELECT ProductName
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID FROM OrderDetails
);