# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `Retail_database`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Rerail_database`.
- **Table Creation**: A table named `retail_data` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE table retail_data(
            transactions_id INT PRIMARY KEY,
			sale_date DATE,	
			sale_time TIME,
			customer_id	INT,
			gender VARCHAR(10),
			age	INT,
			category VARCHAR(15),
			quantiy	INT,
			price_per_unit FLOAT,
			cogs FLOAT,	
			total_sale FLOAT
)
DATA CLEANING

SELECT COUNT(*)FROM retail_data;
select * from retail_data;

SELECT * FROM retail_data  
where  transactions_id IS NULL OR
       sale_date  IS NULL OR
	   sale_time  IS NULL OR
	   customer_id  IS NULL OR
	   gender  IS NULL OR
	   age  IS NULL OR
	   category  IS NULL OR
	   quantiy  IS NULL OR
	   price_per_unit  IS NULL OR
	   cogs  IS NULL OR
	   total_sale  IS NULL ;

DELETE FROM retail_data
where transactions_id IS NULL OR
       sale_date  IS NULL OR
	   sale_time  IS NULL OR
	   customer_id  IS NULL OR
	   gender  IS NULL OR
	   age  IS NULL OR
	   category  IS NULL OR
	   quantiy  IS NULL OR
	   price_per_unit  IS NULL OR
	   cogs  IS NULL OR
	   total_sale  IS NULL ;
	   
-- DATA EXPLORATION FOR BUSINESS PROBLEM---------
SELECT COUNT(total_sale ) FROM retail_data;
SELECT COUNT(DISTINCT category) AS total_category FROM retail_data;
SELECT COUNT(DISTINCT customer_id ) AS total_customers FROM retail_data;

-- DATA ANALYSIS FOR BUSINESS-------------

ALTER TABLE retail_data
RENAME COLUMN quantiy TO quantity;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_data
WHERE sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022 
SELECT * FROM retail_data
WHERE category='Clothing'
	  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
      AND quantiy >=4
	  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,sum(total_sale)as net_sale , count(*) as total_orders FROM retail_data
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT round(AVG(age),2)as average_age from retail_data
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_data
WHERE total_sale >=1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactionS_id) AS total_transactions
FROM retail_data
GROUP BY gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM
(
     SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
	    EXTRACT(MONTH FROM sale_date) as month,
	    AVG(total_sale)AS  avg_sale,
	    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
     FROM retail_data
     group by year,month 
)as t1
where rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id , SUM(total_sale) AS total_sales From retail_data
GROUP BY customer_id
order by total_sales desc;

-- second method  FOR UPPER QUERY-------------------
-- SELECT * from
-- (
--        SELECT customer_id , SUM(total_sale) AS total_sales,
-- 	   rank() over(order by sum(total_sale) desc) as rank
-- 	   from retail_data	
-- 	   group by customer_id
-- ) as t1;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT count(DISTINCT(customer_id)), category from retail_data
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale 
AS 
( 
select *,
      CASE
	      WHEN Extract(hours from sale_time)<12 THEN 'Morning'
		  WHEN Extract(hours from sale_time) between 12 and 17 THEN 'Afternoon'
		  ELSE 'Night'
	  END AS shift
from retail_data
)
select shift,count(*) as total_orders from hourly_sale
group by shift;


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Shraddha Sahu

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles.

