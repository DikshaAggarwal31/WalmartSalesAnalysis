Create database if not EXISTS SalesDATAWalmart;

Create table if not exists sales(
invoice_id VARCHAR(30) NOT NULL Primary Key,
branch Varchar(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10, 2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6, 4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL(10, 2) NOT NULL,
gross_margin_pct FLOAT(11, 9),
gross_income DECIMAL(10, 2) NOT NULL,
rating FLOAT(2, 1)
 );
 


-- -----------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------  Feature Engineering -----------------------------------

--   time_of_day

SELECT
     time,
     (CASE
        WHEN time BETWEEN "00:00:00"  AND "12:00:00"  THEN  "Morning"
        WHEN time BETWEEN "12:01:00"  AND "16:00:00"  THEN  "Afternoon"
        Else "Evening"
        END
        ) AS  time_of_day
     FROM Sales;
	
ALTER Table sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (CASE
        WHEN time BETWEEN "00:00:00"  AND "12:00:00"  THEN  "Morning"
        WHEN time BETWEEN "12:01:00"  AND "16:00:00"  THEN  "Afternoon"
        Else "Evening"
        END
        );
        
-- day_name
SELECT
     date, 
     dayname(DATE) AS day_name
     FROM sales;
     
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = dayname(DATE);


-- month_name

Select
    date,
    MONTHNAME(date)
    FROM sales;
    
    
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);
-- -------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------
-- -------------------------------------  Generic ------------------------------------------

-- How many unique cities does the data have?
SELECT
     distinct city 
     from sales;
     
-- In which city is each branch?
SELECT 
  distinct branch
  from sales;
  
  SELECT 
   distinct city, 
   branch
   from sales;
   
-- -------------------------------------------------------------
-- -------------------  Product  ----------------------------------

-- How many unique product lines does the data have?
SELECT
   count(distinct product_line)
   FROM sales;

-- What is the most common payment method?
SELECT 
payment_method,
  count(payment_method) AS cnt
  from sales
  Group BY payment_method
  Order By cnt DESC;
 
 -- What is the most selling product line?
select
    product_line,
    count(product_line) AS cnt
    from sales
    GROUP BY product_line
    ORDER BY cnt DESC;
  
 
 -- What is the total revenue by month?
  SELECT
  month_name as month,
  SUM(total) AS total_revenue
  from sales
  GROUP BY month_name
  order by total_revenue DESC;
  
-- What month had the largest COGS?
SELECT
month_name as month,
COUNT(cogs) as MAXCOGS
from sales
Group By month_name
Order By MAXCOGS DESC;

-- What product line had the largest revenue?
Select
product_line,
SUM(total)as largest_revenue
from sales
group by product_line
order by largest_revenue DESC;

-- What is the city with the largest revenue?
Select 
branch,
city,
SUM(total) as largest_revenue
from sales
group by city, branch
order by largest_revenue Desc;

-- What product line had the largest VAT?
SELECT
product_line,
AVG(VAT) AS avg_tax
from sales
group by product_line
order by avg_tax DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales


-- Which branch sold more products than average product sold?
SELECT
branch,
SUM(quantity) AS avg_product_sold
from sales
group by branch
HAVING SUM(quantity) > (Select AVG(quantity) from sales)
order by avg_product_sold DESC;

-- What is the most common product line by gender?
Select
gender,
product_line,
count(gender) as total_cnt
from sales
group by gender, product_line
order by total_cnt desc;

-- What is the average rating of each product line?
Select 
product_line,
Round(AVG(rating), 2) as avg_rating
from sales
group by product_line
order by avg_rating DESC;

-- --------------------------------------------------------------------------------------------------------
-- ----------------------------------- Sales ---------------------------------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT 
time_of_day,
Count(*) as total_sales
from sales
where day_name ='Wednesday'
group by time_of_day
order by total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT 
customer_type,
SUM(total) as total_revenue
from sales
group by customer_type
order by total_revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
Select
city,
AVG(VAT) as largest_VAT
from sales
group by city
order by largest_VAT DESC;

-- Which customer type pays the most in VAT?
Select
customer_type,
AVG(VAT) as VAT
from sales
group by customer_type
order by VAT Desc;


-- ---------------------------------------------------------------------------------------------------
-- --------------------------------------- Customer -----------------------------------------------

-- How many unique customer types does the data have?
Select
distinct customer_type
from sales;

-- How many unique payment methods does the data have?
Select
distinct payment_method
from sales;

-- What is the most common customer type?/Which customer type buys the most?
Select
customer_type,
Count(*) as common_customertype
from sales
group by customer_type
order by common_customertype DESC
Limit 1;

-- What is the gender of most of the customers?
Select
gender,
COUNT(*) as common_gender
from sales
group by gender
order by common_gender Desc
Limit 1;

-- What is the gender distribution per branch?
Select
gender,
count(*) as gender_cnt
from sales
where branch = "B"
group by gender
order by gender_cnt DESC;

-- Which time of the day do customers give most ratings?
Select
time_of_day,
AVG(rating) as avg_rating
from sales
group by time_of_day
order by avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
Select
time_of_day,
AVG(rating) as avg_rating
from sales
where branch = "B"
group by time_of_day
order by avg_rating DESC;

-- Which day of the week has the best avg ratings?
Select
day_name,
AVG(rating) as avg_rating
from sales
group by day_name
order by avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
Select
day_name,
AVG(rating) as avg_rating
from sales
where branch = "A"
group by day_name
order by avg_rating DESC; 





-- ------------------------------------------------------------------------------------------------------------------------


















































