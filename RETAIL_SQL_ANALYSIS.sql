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
-- DATA CLEANING----------------

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












	  





	   