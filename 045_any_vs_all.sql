-- 5. ANY vs ALL
SELECT * FROM happiness_scores; -- 2015-2023
SELECT * FROM happiness_scores_current; -- 2024

-- Scores that are greater than ANY 2024 scores
SELECT 	COUNT(*)
FROM 	happiness_scores
WHERE	happiness_score > 
		ANY(SELECT  ladder_score
			FROM	happiness_scores_current);
            
SELECT 	COUNT(*)
FROM 	happiness_scores;

-- Scores that are greater than ALL 2024 scores
SELECT 	*
FROM 	happiness_scores
WHERE	happiness_score > 
		ALL(SELECT  ladder_score
			FROM	happiness_scores_current);