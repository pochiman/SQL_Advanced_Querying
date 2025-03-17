-- 4. LEAD & LAG

-- Return the prior year's happiness score
SELECT	country, year, happiness_score,
		LAG(happiness_score) OVER(PARTITION BY country ORDER BY year) AS prior_happiness_score
FROM	happiness_scores;

-- Return the difference between yearly scores
WITH hs_prior AS (SELECT	country, year, happiness_score,
							LAG(happiness_score) OVER(PARTITION BY country ORDER BY year)
                            AS prior_happiness_score
				  FROM		happiness_scores)
                  
SELECT  country, year, happiness_score, prior_happiness_score,
		happiness_score - prior_happiness_score AS hs_change
FROM	hs_prior;