-- Superstore Sales Analysis Project

-- Step 1: Create Table
CREATE TABLE Superstore_sales(
    Order_Id VARCHAR(20),
    Order_date DATE,
    Ship_mode VARCHAR(30),
    Region VARCHAR(20),
    Category VARCHAR(30),
    Price_per_Unit DECIMAL(10,2),
    Quantity INT,
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2)
);

-- Step 2: (IMPORTANT)
-- Import dataset.csv using MySQL Workbench

-- BUSINESS QUESTIONS

-- 1. What is total sales?
-- 2. Which region performs best?
-- 3. Which category is most profitable?
-- 4. What are top-performing orders?
-- 5. What are monthly sales trends?

-- BASIC ANALYSIS

SELECT COUNT(*) AS total_transactions
FROM Superstore_sales;

SELECT SUM(Sales) AS total_sales
FROM Superstore_sales;

SELECT AVG(Profit) AS avg_profit
FROM Superstore_sales;

-- REGIONAL ANALYSIS

SELECT Region, SUM(Sales) AS total_sales
FROM Superstore_sales
GROUP BY Region
ORDER BY total_sales DESC;

SELECT Region, SUM(Sales) AS total_sales
FROM Superstore_sales
GROUP BY Region
HAVING SUM(Sales) > 500000;

-- CATEGORY ANALYSIS

SELECT Category, SUM(Profit) AS total_profit
FROM Superstore_sales
GROUP BY Category
ORDER BY total_profit DESC;

-- TOP PERFORMERS

SELECT *
FROM Superstore_sales
ORDER BY Sales DESC
LIMIT 10;

SELECT *
FROM Superstore_sales
ORDER BY Profit DESC
LIMIT 5;

-- TIME ANALYSIS

SELECT DATE_FORMAT(Order_date, '%Y-%m') AS month,
       SUM(Sales) AS total_sales
FROM Superstore_sales
GROUP BY month
ORDER BY month;

-- Running Total
SELECT Order_date,
       SUM(Sales) OVER (ORDER BY Order_date) AS running_sales
FROM Superstore_sales;

-- ADVANCED SQL

SELECT *
FROM (
    SELECT Region, Category, SUM(Sales) AS total_sales,
           RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS rank
    FROM Superstore_sales
    GROUP BY Region, Category
) ranked
WHERE rank = 1;

-- FILTERING

SELECT *
FROM Superstore_sales
WHERE Region = 'East';

SELECT *
FROM Superstore_sales
WHERE Sales > 10000;

SELECT *
FROM Superstore_sales
WHERE Category = 'Technology' AND Profit > 5000;

-- DATE FILTERING

SELECT *
FROM Superstore_sales
WHERE Order_date BETWEEN '2023-01-01' AND '2023-03-31';

SELECT SUM(Sales) AS feb_sales
FROM Superstore_sales
WHERE Order_date BETWEEN '2024-02-01' AND '2024-02-29';
