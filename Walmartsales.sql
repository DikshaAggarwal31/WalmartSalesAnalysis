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
 Select
	product_line,
    count(product_line)
    from sales;
  
















-- --------------------------------------------------------------------------------------------------------