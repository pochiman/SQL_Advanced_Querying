-- 7. CTEs: Readability

/* SUBQUERY: Return the happiness scores along with
   the average happiness score for each country */
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;

/* CTE: Return the happiness scores along with
   the average happiness score for each country */
WITH country_hs AS (SELECT	 country,
							 AVG(happiness_score) AS avg_hs_by_country
				    FROM	 happiness_scores
				    GROUP BY country)

SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN country_hs
		ON hs.country = country_hs.country;