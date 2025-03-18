-- Connect to database (MySQL)
USE maven_advanced_sql;

-- ASSIGNMENT 1: Duplicate values

-- View the students data
SELECT * FROM students;

-- Create a column that counts the number of times a student appears in the table
SELECT 	*,
		ROW_NUMBER() OVER (PARTITION BY student_name ORDER BY id DESC) AS student_count
FROM	students;

-- Return student ids, names and emails, excluding duplicates students
WITH sc AS (SELECT 	id, student_name, email,
					ROW_NUMBER() OVER (PARTITION BY student_name ORDER BY id DESC) AS student_count
			FROM	students)
            
SELECT	id, student_name, email
FROM	sc
WHERE	student_count = 1;