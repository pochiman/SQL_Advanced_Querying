-- 4. Joining multiple tables
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;
SELECT * FROM inflation_rates;

SELECT	hs.year, hs.country, hs.happiness_score,
		cs.continent, ir.inflation_rate
FROM	happiness_scores hs
		LEFT JOIN country_stats cs
			ON hs.country = cs.country
		LEFT JOIN inflation_rates ir
			ON hs.year = ir.year AND hs.country = ir.country_name;