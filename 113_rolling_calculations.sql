-- ASSIGNMENT 4: Rolling calculations

-- Calculate the total sales each month
SELECT	 YEAR(o.order_date) AS yr, MONTH(o.order_date) AS mnth, SUM(o.units * p.unit_price) AS total_sales
FROM	 orders o LEFT JOIN products p
		 ON o.product_id = p.product_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);

-- Add on the cumulative sum and 6 month moving average
WITH ms AS (SELECT	 YEAR(o.order_date) AS yr, MONTH(o.order_date) AS mnth,
						SUM(o.units * p.unit_price) AS total_sales
			FROM	 orders o LEFT JOIN products p
					 ON o.product_id = p.product_id
			GROUP BY YEAR(o.order_date), MONTH(o.order_date)
			ORDER BY YEAR(o.order_date), MONTH(o.order_date)) -- ORDER BY in CTE is not needed and can be omitted
            
SELECT	yr, mnth, total_sales,
        SUM(total_sales) OVER (ORDER BY yr, mnth) AS cumulative_sum,
        AVG(total_sales) OVER (ORDER BY yr, mnth ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)
			AS six_month_ma
FROM	ms;