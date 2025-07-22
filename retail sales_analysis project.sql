
----- Create Database -----
Create Database retail_analysis_project;

----- Create TABLE -----
Drop table if exists retail_sales_analysis;
Create TABLE retail_sales_analysis
            (
                transaction_id int primary key,	
                sale_date date,	 
                sale_time time,	
                customer_id	int,
                gender	varchar (50),
                age	int,
                category varchar (50),	
                quantity	int,
                price_per_unit float,	
                cogs	float,
                total_sale float
            );

Select COUNT(*) From retail_sales_analysis
Select (*) From retail_sales_analysis

----- Data Cleaning -----
Select * From retail_sales_analysis
Where transactions_id is NULL;

Select * From retail_sales_analysis
Where transaction_id is NULL
OR sale_date is NULL
OR sale_time is NULL
OR gender is NULL
OR category is NULL
OR quantity is NULL
OR cogs is NULL
OR total_sale is NULL;


----- Data Cleaning  -----
delete From retail_sales_analysis
Where transaction_id is NULL
OR sale_date is NULL
OR sale_time is NULL
OR gender is NULL
OR category is NULL
OR quantity is NULL
OR cogs is NULL
OR total_sale is NULL;


----- Data Exploration -----
# 1. How many sales we have?
SELECT 
	COUNT(*) as total_sale
FROM retail_sales_analysis;


# 2. How many uniuque customers we have?
SELECT 
	COUNT(DISTINCT customer_id) as total_sale 
FROM retail_sales_analysis;


----- Data Analysis & Business Problems -----
# Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';


# Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
# and the quantity sold is more than 4 in the month of Nov-2022
SELECT 
  *
FROM retail_sales_analysis
WHERE category = 'Clothing'
AND  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantity >= 4;


# Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) as total_sales,
    COUNT(*) as total_orders
FROM retail_sales_analysis
GROUP BY category;


# Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales_analysis
WHERE category = 'Beauty';


# Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales_analysis
WHERE total_sale > 1000;


# Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(*) as trs_total
FROM retail_sales_analysis
GROUP 
    BY 
    category,
    gender
ORDER BY 1


# Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH monthly_sales AS (
  SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(total_sale) AS total_sale,
    AVG(total_sale) AS avg_sale
  FROM retail_sales_analysis
  GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT *
FROM (
  SELECT *,
         RANK() OVER (PARTITION BY year ORDER BY total_sale DESC) AS sales_rank
  FROM retail_sales_analysis
) ranked
WHERE sales_rank = 1;


# Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales_analysis
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


# Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique
FROM retail_sales_analysis
GROUP BY category;


# Q.10 Write a SQL query to create each shift and 
# number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS order_count
FROM retail_sales_analysis
GROUP BY shift;

select * from retail_sales_analysis;

------- END OF PROJECT -------