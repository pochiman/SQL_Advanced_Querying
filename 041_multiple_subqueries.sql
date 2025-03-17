-- 3. Multiple subqueries

-- Return happiness scores for 2015 - 2024
SELECT DISTINCT year FROM happiness_scores;
SELECT * FROM happiness_scores_current;

SELECT year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score FROM happiness_scores_current;
            
/* Return a country's happiness score for the year as well as
the average happiness score for the country across years */
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	(SELECT year, country, happiness_score FROM happiness_scores
		 UNION ALL
		 SELECT 2024, country, ladder_score FROM happiness_scores_current) AS hs
         LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;
       
/* Return years where the happiness score is a whole point
greater than the country's average happiness score */
SELECT * FROM

(SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	(SELECT year, country, happiness_score FROM happiness_scores
		 UNION ALL
		 SELECT 2024, country, ladder_score FROM happiness_scores_current) AS hs
         LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country) AS hs_country_hs
        
WHERE happiness_score > avg_hs_by_country + 1;