-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. Subqueries in the SELECT clause
SELECT * FROM happiness_scores;

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Happiness score deviation from the average
SELECT	year, country, happiness_score,
		(SELECT AVG(happiness_score) FROM happiness_scores) AS avg_hs,
        happiness_score - (SELECT AVG(happiness_score) FROM happiness_scores) AS diff_from_avg
FROM	happiness_scores;