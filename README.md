# Retail_dataset_Analysis
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

# Objectives:-
Create a retail sales table to store transactional data

Clean the dataset by identifying and removing NULL values

Perform exploratory data analysis (EDA)

Answer real business questions using SQL queries

Apply advanced SQL concepts like CTEs and window functions

# Project Structure--------
1. Database & Table Setup :- Table Name: retail_data

# 1- Stores detailed retail transaction information
CREATE TABLE retail_data(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,	
    total_sale FLOAT
);
# 2. Data Cleaning & Preparation

SELECT COUNT(*) FROM retail_data;

:-check null values-
SELECT *
FROM retail_data
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
   
:-Remove records with missing values
DELETE FROM retail_data
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

:-3. Exploratory Data Analysis (EDA)
SELECT COUNT(total_sale) FROM retail_data;
SELECT COUNT(DISTINCT category) AS total_category FROM retail_data;
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_data;

# 3. Business Analysis & SQL Queries
The following SQL queries were developed to answer specific business questions

Q-1-Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_data
WHERE sale_date = '2022-11-05';

Q-2- Clothing sales with quantity ≥ 4 in November 2022
SELECT *
FROM retail_data
WHERE category = 'Clothing'
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
  AND quantity >= 4;
  
Q-3- Total sales and orders by category
SELECT category,
       SUM(total_sale) AS net_sale,
       COUNT(*) AS total_orders
FROM retail_data
GROUP BY category;

Q-4- Average age of customers purchasing Beauty products
SELECT ROUND(AVG(age), 2) AS average_age
FROM retail_data
WHERE category = 'Beauty';

Q-5-High-value transactions (total_sale ≥ 1000)
SELECT *
FROM retail_data
WHERE total_sale >= 1000;

Q-6- Transactions by gender and category
SELECT category,
       gender,
       COUNT(transactions_id) AS total_transactions
FROM retail_data
GROUP BY category, gender;

Q-7- Best-selling month in each year (Average Sales)
SELECT *
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_data
    GROUP BY year, month
) t1
WHERE rank = 1;

Q-8- Top customers by total sales
SELECT customer_id,
       SUM(total_sale) AS total_sales
FROM retail_data
GROUP BY customer_id
ORDER BY total_sales DESC;

Q-9-  Unique customers per category
SELECT category,
       COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_data
GROUP BY category;

Q-10- Sales shift analysis (Morning, Afternoon, Night)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Night'
        END AS shift
    FROM retail_data
)
SELECT shift,
       COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

# Key Findings-

1-Sales performance varies significantly across categories and time shifts
2-Certain customers contribute disproportionately to total revenue
3-High-value transactions indicate premium customer segments
4-Afternoon and Evening shifts show higher order volume
5-Monthly analysis highlights best-selling months per year

# SQL Concepts Used-

GROUP BY, ORDER BY
Aggregate Functions (SUM, AVG, COUNT)
CASE WHEN
DATE & TIME functions
WINDOW FUNCTIONS (RANK)
CTE (WITH clause)
Data Cleaning techniques

# How to Use This Project-

Clone the repository
Create the retail_data table
Insert data
Run cleaning queries
Execute analysis queries
Modify queries for further insights

# Author
Shraddha
Aspiring Data AnalysT





























