
create database Retail
use Retail
select * from Retail_Sales

--DATA EXPLORATION

--How many sales do we have 
select count(transactions_id) as Total_Sales from Retail_Sales

-- How many customers do we have 
select count(distinct(customer_id)) from Retail_Sales

-- How many categories do we have
select distinct(category) from Retail_Sales

--DATA ANALYSIS

-- Write SQL query to retrieve all coloumns for sales made on 2022-11-05
select * from Retail_Sales
where sale_date = '2022-11-05'

--Write a SQL query to retrieve all transactions where category is clothing and quantity sold is more than 2 
select * from Retail_Sales
where category = 'Clothing' AND quantiy > 2 

--Write SQL Category to retrieve total sales for each category
select sum(total_sale) as Total_Sales, count(*) as Total_Orders, category from Retail_Sales
GROUP BY category

--Write SQL Query to retrieve average age of customers who purchased items from the 'Beauty' category
select avg(age) as AVG_Age, category from Retail_Sales
where category = 'Beauty'

-- Write SQL Category to retrieve all transactions where total sale is greater than 1000
select * from Retail_Sales
where total_sale > 1000

--Write SQL Category to retrieve all transactions made by each gender in each category
select count(transactions_id), gender, category from Retail_Sales
group by gender, category

--write SQL Category to calculate average sale in each month find out best selling month and best selling year
select* from 
	(select 
	Year(sale_date) as year_of_sale,
	month(sale_date) as month_of_sale,
	avg(total_sale) as Avg_Sale,
	Rank() over (partition by Year(sale_date) order by avg(total_sale) desc) as RANK_CHECK
	from Retail_Sales 
	group by Year(sale_date), month(sale_date))
	Where Rank() over (partition by Year(sale_date) order by avg(total_sale) desc) = 1
	order by Year(sale_date), avg(total_sale) desc
	

-- TOP 5 customers based on total sales

select top 5 customer_id, sum(total_sale) as Total from Retail_Sales
group by customer_id
order by sum(total_sale) desc


--  Find number of unique customers use puchased items from each category

select category, count(distinct(customer_id)) total_customer from Retail_Sales
group by category

-- Write SQL category to create each shift and total orders 
select category , 
	   Shifts = (CASE 
				WHEN HOUR(sale_time) <= 12 then 'Morning'
				WHEN HOUR(sale_time) is between 12 and 17 then 'Afternoon'
				WHEN HOUR(sale_time) > 17 then 'Evening'
				ELSE 'Not Known' 
				END) from Retail_Sales
      group by category


--END OF PROJECT

