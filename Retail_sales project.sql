--creatig database retail_sales
create database retail_sales

--using retail_database
use retail_sales

--creating retail_sales table

create table retail_sales
(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(20),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);


select * from retail_sales

--count the records
select
    count(*)
from retail_sales

-- data cleaning

select * from retail_sales
where transactions_id is null

select * from retail_sales
where sale_date is null

select * from retail_sales
where sale_time is null

select * from retail_sales
where customer_id is null

select * from retail_sales
where gender is null

--cheking nulls
select * from retail_sales
where transactions_id is null
     or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or 
	 total_sale is null;


-- deleting nulls
delete from retail_sales
where transactions_id is null
     or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
	 or
	 age is null
	 or
	 category is null
	 or
	 quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or 
	 total_sale is null;

-- Data Exploration

-- How many sales we have?
select count(transactions_id) as Total_sales 
from retail_sales

-- How many unique customers we have?
select count(distinct customer_id) as total_customers
from retail_sales

-- How many Categories we have?
select distinct(category) from retail_sales


--Data Analysis & Business Problems & Answers
  
-- Q1. Write a query to retrive all customers for sales made on '2022-11-05'
select * 
from retail_sales
where sale_date = '2022-11-05'

--Q2. Write a query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022
select 
*
from retail_sales
where category = 'Clothing'
      and
	  quantiy >= 4
	  and
	  sale_date >= '2022-11-01'
	  and
	  sale_date < '2022-11-30'



-- Q3. Write a query to calculate total sales(Total_sales) for each category
select 
     category,
	 sum(total_sale) as net_sale,
	 count(*) as Total_orders
from Retail_sales
group by category



--Q4. Write a sql query tofind the average age of customers who purchased items from the 'Beauty' category
select 
     AVG(age) as Avg_age
from Retail_sales
where category = 'Beauty'



--Q5 Write a sql query to find the all Transactions where total sale is grater than 1000
select * 
from Retail_sales
where total_sale > 1000


--Q6. Write a query to find total number of transactions(transaction_id) make by each gender and each category
select 
     category
	 ,gender
	 , count(*) as Total_Transactions
from Retail_sales
group 
    by 
	gender,
	category
order
     by 
	 category



--Q7. Write a sql query to calculate the average sales of each month. find out best selling month in each year
select * from
(
  select 
       YEAR(sale_date) as year,
	   MONTH(sale_date) as month,
	   AVG(total_sale) as avg_sales,
	   rank() over(partition by  YEAR(sale_date) order by avg(total_sale) desc) as Rank
  from Retail_sales   
  group 
    by
	YEAR(sale_date),
	MONTH(sale_date)
) as t1
where Rank = 1



--Q8. Write a sql query to find the top 5 customers baced on the highest sales
select top 5
     customer_id,
	 sum(total_sale) as total_sales
from Retail_sales
group by customer_id
order by sum(total_sale) desc



--Q9. Write sql query to find the unique customers who purchased items from each category 
select 
     category,
	 count(distinct(customer_id)) as cnt_unique_cust
from Retail_sales
group by category



--Q10. Write a sql query to create each shift and number of oreders (Example Morning <=12, Afternoon between 12 & 17 and Evining >17)
with hourly_sales
as
(
select *,
     case
	   WHEN datepart(HOUR,sale_time) < 12 THEN 'Morning'
       WHEN datepart(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   else 'Evining'
	end as shifts
from Retail_sales
)
select
     shifts,
     count(*) as total_orders
from hourly_sales
group by shifts



-----------End of Project












	  






