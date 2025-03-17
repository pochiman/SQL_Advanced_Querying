-- 5. NTILE

-- Add a percentile to each row of data
SELECT	region, country, happiness_score,
		NTILE(4) OVER(PARTITION BY region ORDER BY happiness_score DESC) AS hs_percentile
FROM	happiness_scores
WHERE	year = 2023
ORDER BY region, happiness_score DESC;

-- For each region, return the top 25% of countries, in terms of happiness score
WITH hs_pct AS (SELECT	region, country, happiness_score,
						NTILE(4) OVER(PARTITION BY region ORDER BY happiness_score DESC)
                        AS hs_percentile
				FROM	happiness_scores
				WHERE	year = 2023
				ORDER BY region, happiness_score DESC)

			/* This ORDER BY clause in the CTE doesn't affect the final order of
			the query and can be removed to make the code run more efficiently */
                
SELECT	*
FROM	hs_pct
WHERE	hs_percentile = 1;