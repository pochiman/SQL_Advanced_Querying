-- 4. ROLLING CALCULATIONS

-- Create a pizza orders table
CREATE TABLE pizza_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    pizza_name VARCHAR(100),
    price DECIMAL(5, 2)
);

INSERT INTO pizza_orders (order_id, customer_name, order_date, pizza_name, price) VALUES
    (1, 'Jack', '2024-12-01', 'Pepperoni', 18.75),
    (2, 'Jack', '2024-12-02', 'Pepperoni', 18.75),
    (3, 'Jack', '2024-12-03', 'Pepperoni', 18.75),
    (4, 'Jack', '2024-12-04', 'Pepperoni', 18.75),
    (5, 'Jack', '2024-12-05', 'Spicy Italian', 22.75),
    (6, 'Jill', '2024-12-01', 'Five Cheese', 18.50),
    (7, 'Jill', '2024-12-03', 'Margherita', 19.50),
    (8, 'Jill', '2024-12-05', 'Garden Delight', 21.50),
    (9, 'Jill', '2024-12-05', 'Greek', 21.50),
    (10, 'Tom', '2024-12-02', 'Hawaiian', 19.50),
    (11, 'Tom', '2024-12-04', 'Chicken Pesto', 20.75),
    (12, 'Tom', '2024-12-05', 'Spicy Italian', 22.75),
    (13, 'Jerry', '2024-12-01', 'California Chicken', 21.75),
    (14, 'Jerry', '2024-12-02', 'Margherita', 19.50),
    (15, 'Jerry', '2024-12-04', 'Greek', 21.50);
    
-- View the table
SELECT * FROM pizza_orders;

-- 1. Calculate the sales subtotals for each customer

-- View the total sales for each customer on each date
SELECT	 customer_name, order_date, SUM(price) AS total_sales
FROM	 pizza_orders
GROUP BY customer_name, order_date;

-- Include the subtotals
SELECT	 customer_name, order_date, COUNT(price) AS total_sales
FROM	 pizza_orders
GROUP BY customer_name, order_date WITH ROLLUP;

-- 2. Calculate the cumulative sum of sales over time

-- View the columns of interest
SELECT	order_date, price
FROM	pizza_orders
ORDER BY order_date;

-- Calculate the total sales for each day
SELECT	 order_date, SUM(price) AS total_sales
FROM	 pizza_orders
GROUP BY order_date
ORDER BY order_date;

-- Calculate the cumulative sales over time
WITH ts AS (SELECT	 order_date, SUM(price) AS total_sales
			FROM	 pizza_orders
			GROUP BY order_date
			ORDER BY order_date)
            
SELECT	order_date,
		SUM(total_sales) OVER(ORDER BY order_date) AS cumulative_sum
FROM 	ts;

-- 3. Calculate the 3 year moving average of happiness scores for each country

-- View the happiness score table
SELECT * FROM happiness_scores;

-- View the happiness scores for each country, sorted by year
SELECT	 country, year, happiness_score 
FROM 	 happiness_scores
ORDER BY country, year;

-- Create a basic row number window function
SELECT	 country, year, happiness_score,
		 ROW_NUMBER() OVER (PARTITION BY country ORDER BY year) AS row_num
FROM 	 happiness_scores
ORDER BY country, year;

-- Update the function to a moving average calculation
SELECT	 country, year, happiness_score,
		 ROUND(AVG(happiness_score)
         OVER (PARTITION BY country ORDER BY year
			   ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 3) AS row_num
FROM 	 happiness_scores
ORDER BY country, year;