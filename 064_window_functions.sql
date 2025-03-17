-- Connect to database (MySQL)
USE maven_advanced_sql;

-- ASSIGNMENT 1: Window function basics

-- View the orders table
SELECT	*
FROM	orders;

-- View the columns of interest
SELECT	customer_id, order_id, order_date, transaction_id
FROM	orders
ORDER BY customer_id, transaction_id;

-- For each customer, add a column for transaction number
SELECT	customer_id, order_id, order_date, transaction_id,
		ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_id) AS transaction_num
FROM	orders
ORDER BY customer_id, transaction_id;