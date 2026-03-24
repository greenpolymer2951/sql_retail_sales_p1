create database sql_project_p2;
create table retail_sales ( 
             transactions_id INT PRIMARY KEY,
             sale_date DATE,
             sale_time TIME,
             customer_id INT,
             gender VARCHAR(15),
             age INT,
             category VARCHAR(15),
             quantiy INT,
             price_per_unit FLOAT,
             cogs FLOAT,
             total_sale FLOAT
);
--data cleaning
SELECT * FROM retail_sales
LIMIT 10

SELECT * FROM retail_sales
WHERE transactions_id is NULL

SELECT * FROM retail_sales
WHERE sale_date is NULL

SELECT * FROM retail_sales
WHERE sale_time is NULL

SELECT * FROM retail_sales
WHERE customer_id is NULL

DELETE FROM retail_sales
WHERE
      age is NULL
	  or
	  category is NULL
	  or
	  quantiy is NULL
	  or
	  price_per_unit is NULL
	  or
	  cogs is NULL
	  or
	  total_sale is NULL
	  
SELECT COUNT(*)FROM retail_sales

--data exporation
SELECT COUNT(*)as total_sales FROM retail_sales

--KITNE UNIQUE CUSTOMERS H USKE LIYE

SELECT COUNT(DISTINCT customer_id)as total_sales FROM retail_sales

SELECT COUNT(DISTINCT category)as total_sales FROM retail_sales

--data analysis part yaha hua h ab

--write a sql query to retrieve all columns for sales made on '2022-11-05'

select*
from retail_sales
where sale_date = '2022-11-05';

--to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of nov-2022

select 
     *
from retail_sales
where category = 'clothing'
    AND 
	TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	AND
	 quantiy>=4
group by 1;

--write sql query to calcuulate the total sales(total_sales) for each category

select
      category,
	  sum(total_sale) as net_sale,
	  count(*) as total_orders
from retail_sales
group by 1

--write a sql query to find the average age of customers who purchased itens from the 'Beauty' category
select
     round(AVG(age))as avg_age
	 from retail_sales
	 where category = 'Beauty'

	 -- WRITESQL QUERY TTO FIND ALL TRANSACTIONS WHERE THE TOTAL_SALE IS GREATER THAN 1000

	 SELECT * FROM retail_sales
	 where total_sale > 1000
	 -- query to find total number of transactions (transaction_id) made by each gender in each category

	 select
	 category,
	 gender,
	 count(*) as total_trans
	 from retail_sales
	 group
	 by
	 category,
	 gender
	 order by 
	 -- sql query to cal avg sale for each month.find out best selling month in each year.
SELECT * FROM
(
	 select
	  extract(YEAR from sale_date) as year,
	  extract(MONTH from sale_date) as month,
	  AVG(total_sale)as avg_sale,
	  RANK() OVER(
	  PARTITION BY EXTRACT(YEAR FROM sale_date) order by avg(total_sale) DESC)  as rank
	  from retail_sales
	  group by 1,2
	  ) as t1
	  where rank =1

	  --SQL QUERY TO FIND TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL SALES
	  SELECT
	        customer_id,
			sum(total_sale)as total_sales
			from retail_sales
			group by 1
			order by 2 desc
			limit 5

			-- query to find unique customers and purchased items from each category

			select 
			category,
			count(distinct customer_id) as cnt_unique_cs
			from retail_sales
			group by category

			-- query to create each shift and number of orders

			select*,
			case
			WHEN extract(HOUR from sale_time)<12 THEN 'MORNING'
			WHEN extract(HOUR from sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			
			ELSE 'EVENING'
			END as shift
			from retail_sales
			select extract(HOUR from CURRENT_TIME)