create database DATATRANSFER;

USE DATATRANSFER;

CREATE TABLE CUSTOMERS(
CUSTOMERID INT PRIMARY KEY,
FIRSTNAME varchar(50),
LASTNAME VARCHAR(50),
EMAIL VARCHAR(30),
RAGISTRATIONDATE DATETIME
);

insert INTO CUSTOMERS
VALUES (1, "JOHN", "DOE", "JOHN.DOE@GMAIL.COM", "022-03-15"),
(2, "JANE", "SMITH", "JANE.SMITH@GMAIL.COM","2021-11-02");



CREATE TABLE ORDERS(
ORDERID INT PRIMARY KEY,
CUSTOMERID INT,
ORDERDATE DATE,
TOTALAMOUNT DECIMAL,
FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(CUSTOMERID)
);


INSERT INTO ORDERS
VALUES(101,1,"2023-07-01",150.50),
(102,2,"2023-07-03",200.75);

CREATE TABLE EMPLOYEES(
EMPID INT PRIMARY KEY,
FIRSTNAME VARCHAR (50),
LASTNAME VARCHAR(50),
DEPARTMENT VARCHAR(25),
HIREDATE DATE,
SALARY int
);

INSERT INTO EMPLOYEES
VALUES (1, "MARK", "JONSON", "SALES", "2020-01-15", 50000),
(2, "SUSAN", "LEE", "HR", "2021-03-20", 55000);

-- 1 Inner Join
SELECT * FROM CUSTOMERS
INNER JOIN ORDERS
ON CUSTOMERS.CUSTOMERID = ORDERS.CUSTOMERID;


-- 2 Left Join
SELECT * FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.CUSTOMERID = ORDERS.CUSTOMERID;

-- 3 RIGHT JOIN
SELECT o.OrderID,c.FirstName
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID=o.CustomerID;

-- 4 FULL OUTER JOIN
SELECT c.FirstName,o.OrderID
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID=o.CustomerID
UNION
SELECT c.FirstName,o.OrderID
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID=o.CustomerID;

-- 5 Subquery more than avg order
SELECT * FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

-- 6 Employees above avg salary
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 7 Extract year and month
SELECT OrderID,
YEAR(OrderDate) AS year,
MONTH(OrderDate) AS month
FROM Orders;

-- 8 Date difference
SELECT OrderID,
DATEDIFF(CURDATE(),OrderDate) AS days_diff
FROM Orders;

-- 9 Format date
SELECT DATE_FORMAT(OrderDate,'%d-%M-%Y') FROM Orders;

-- 10 Full name
SELECT CONCAT(FirstName,' ',LastName) AS FullName FROM Customers;

-- 11 Replace name
SELECT REPLACE(FirstName,'John','jane') FROM Customers;

-- 12 Upper and lower
SELECT UPPER(FirstName), LOWER(LastName) FROM Customers;

-- 13 Trim email
SELECT TRIM(Email) FROM Customers;

-- 14 Running total
SELECT OrderID,
SUM(TotalAmount) OVER (ORDER BY OrderID) AS RunningTotal
FROM Orders;

-- 15 Rank orders
SELECT OrderID,TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS rnk
FROM Orders;

-- 16 Discount using CASE
SELECT OrderID,TotalAmount,
CASE
 WHEN TotalAmount > 1000 THEN '10% OFF'
 WHEN TotalAmount > 500 THEN '5% OFF'
 ELSE 'NO DISCOUNT'
END AS Discount
FROM Orders;

-- 17 Salary category
SELECT FirstName,
CASE
 WHEN Salary > 55000 THEN 'High'
 WHEN Salary BETWEEN 50000 AND 55000 THEN 'Medium'
 ELSE 'Low'
END AS SalaryLevel
from employees


