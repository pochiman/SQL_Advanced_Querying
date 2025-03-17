-- 4. Subqueries in the WHERE and HAVING clauses

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Above average happiness scores (WHERE)
SELECT	*
FROM	happiness_scores
WHERE	happiness_score > (SELECT AVG(happiness_score) FROM happiness_scores);

-- Above average happiness scores for each region (HAVING)
SELECT	 region, AVG(happiness_score) AS avg_hs
FROM	 happiness_scores
GROUP BY region
HAVING	 avg_hs > (SELECT AVG(happiness_score) FROM happiness_scores);