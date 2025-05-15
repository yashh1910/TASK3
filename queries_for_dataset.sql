SELECT * FROM prouduct.sample_orders_dataset;

--  a. Use SELECT, WHERE, ORDER BY, GROUP BY

-- first 10 orders 
SELECT * FROM sample_orders_dataset LIMIT 10; 

-- orders over 300
SELECT * FROM sample_orders_dataset 
WHERE order_total > 300;  

-- Sorting orders by amount (highest first)
SELECT * FROM sample_orders_dataset
ORDER BY order_total DESC;   

-- Count orders by status
SELECT status , count(*) AS total_orders 
From sample_orders_dataset
GROUP BY status; 


-- b. Use JOINS 

CREATE TABLE customers (
  customer_id INT,
  customer_name VARCHAR(100),
  region VARCHAR(50)
 );

SELECT o.order_date, o.order_id, c.customer_name, c.region
FROM sample_orders_dataset o 
JOIN customers c ON o.customer_id = c.customer_id;

-- c. Write Subqueries
-- customers who placed higg-value orders

SELECT customer_id , order_total 
FROM sample_orders_dataset
where order_total > (
SELECT AVG(order_total)  from sample_orders_dataset
);

 --  d. Use Aggregate Functions (SUM, AVG, COUNT)
 -- total sales
 SELECT SUM(order_total) AS total_sales FROM sample_orders_dataset;
 
 -- avg order value per status
 SELECT status , AVG(order_total) AS avg_order_value
 FROM sample_orders_dataset
 GROUP BY status;
 
 -- e. Create Views for Analysis
 -- Monthly sales summary
 -- modifying text to date format 
desc sample_orders_dataset;

alter table sample_orders_dataset
modify order_date date;

describe sample_orders_dataset;

select order_date from sample_orders_dataset;


CREATE VIEW monthly_sales_s AS
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS total_orders,
    SUM(order_total) AS total_sales
FROM sample_orders_dataset
GROUP BY order_month;

select * from monthly_sales_s;



-- f. Optimize Queries with Indexes
-- 1. Create index for customer_id:
CREATE INDEX idx_customer_id ON sample_orders_dataset(customer_id);

-- 2. Create index for order_date:
CREATE INDEX idx_order_date ON sample_orders_dataset(order_date);

EXPLAIN SELECT * FROM sample_orders_dataset
 WHERE customer_id = 1001;
 

 





 