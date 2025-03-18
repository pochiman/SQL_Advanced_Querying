-- ASSIGNMENT 2: Min / max value filtering

-- View the students and student grades tables
SELECT * FROM students;
SELECT * FROM student_grades;

-- For each student, return the classes they took and their final grades
SELECT	s.id, s.student_name, sg.class_name, sg.final_grade
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id;
        
-- Return each student's top grade and corresponding class:

-- APPROACH 1: GROUP BY + JOIN
        
-- For each student, return their highest grade
SELECT	 s.id, s.student_name, MAX(sg.final_grade) AS top_grade
FROM	 students s INNER JOIN student_grades sg
		 ON s.id = sg.student_id
GROUP BY s.id, s.student_name
ORDER BY s.id;

-- Final GROUP BY + JOIN query
WITH tg AS (SELECT	 s.id, s.student_name, MAX(sg.final_grade) AS top_grade
			FROM	 students s INNER JOIN student_grades sg
					 ON s.id = sg.student_id
			GROUP BY s.id, s.student_name
			ORDER BY s.id) -- ORDER BY in CTE is not needed and can be omitted
            
SELECT	tg.id, tg.student_name, tg.top_grade, sg.class_name
FROM	tg LEFT JOIN student_grades sg
		ON tg.id = sg.student_id AND tg.top_grade = sg.final_grade;

-- APPROACH 2: Window function

-- Rank the student grades for each student
SELECT	s.id, s.student_name, sg.class_name, sg.final_grade,
		DENSE_RANK() OVER (PARTITION BY s.student_name ORDER BY sg.final_grade DESC) AS grade_rank
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id;
        
-- Final window function query
SELECT id, student_name, class_name, final_grade FROM

(SELECT	s.id, s.student_name, sg.class_name, sg.final_grade,
		DENSE_RANK() OVER (PARTITION BY s.student_name ORDER BY sg.final_grade DESC) AS grade_rank
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id) AS gr
        
WHERE grade_rank = 1;