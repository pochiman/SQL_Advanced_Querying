-- 5. FINAL DEMO: Imputing NULL Values

/* Stock prices table was created in prior section:
   This is the code if you need to create it again */

/* -- Create a stock prices table
CREATE TABLE IF NOT EXISTS stock_prices (
    date DATE PRIMARY KEY,
    price DECIMAL(10, 2)
);

INSERT INTO stock_prices (date, price) VALUES
	('2024-11-01', 678.27),
	('2024-11-03', 688.83),
	('2024-11-04', 645.40),
	('2024-11-06', 591.01); */
    
-- Recursive CTE from earlier
WITH RECURSIVE my_dates(dt) AS (SELECT '2024-11-01'
								UNION ALL
								SELECT dt + INTERVAL 1 DAY
								FROM my_dates
								WHERE dt < '2024-11-06')
     
SELECT	md.dt, sp.price
FROM	my_dates md
		LEFT JOIN stock_prices sp
        ON md.dt = sp.date;
        
-- Let's replace the NULL values in the price column 4 different ways (aka imputation)
-- 1. With a hard coded value
-- 2. With a subquery
-- 3. With one window function
-- 4. With two window functions

WITH RECURSIVE my_dates(dt) AS (SELECT '2024-11-01'
								UNION ALL
								SELECT dt + INTERVAL 1 DAY
								FROM my_dates
								WHERE dt < '2024-11-06'),
                                
	 sp AS (SELECT	md.dt, sp.price
			FROM	my_dates md
					LEFT JOIN stock_prices sp
					ON md.dt = sp.date)
                    
SELECT	dt, price,
		COALESCE(price, 600) AS updated_price_600,
        COALESCE(price, ROUND((SELECT AVG(price) FROM sp), 2)) AS updated_price_avg,
        COALESCE(price, LAG(price) OVER()) AS updated_price_prior,
        COALESCE(price, ROUND((LAG(price) OVER() + LEAD(price) OVER())/2, 2)) AS updated_price_smooth
FROM	sp;