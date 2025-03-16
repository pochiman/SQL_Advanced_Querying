-- 3. Joining on multiple columns
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;
SELECT * FROM inflation_rates;

SELECT	*
FROM	happiness_scores hs
		INNER JOIN inflation_rates ir
        ON hs.country = ir.country_name AND hs.year = ir.year;