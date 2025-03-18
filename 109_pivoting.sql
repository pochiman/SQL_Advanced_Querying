-- ASSIGNMENT 3: Pivoting

-- Combine the students and student grades tables
SELECT * FROM students;
SELECT * FROM student_grades;

SELECT	*
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id;
        
-- View only the columns of interest
SELECT	s.grade_level, sg.department, sg.final_grade
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id;
        
-- Pivot the grade_level column
SELECT	sg.department, sg.final_grade,
		CASE WHEN s.grade_level = 9 THEN 1 ELSE 0 END AS freshman,
        CASE WHEN s.grade_level = 10 THEN 1 ELSE 0 END AS sophomore,
        CASE WHEN s.grade_level = 11 THEN 1 ELSE 0 END AS junior,
        CASE WHEN s.grade_level = 12 THEN 1 ELSE 0 END AS senior
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id;
        
-- Update the values to be final grades
SELECT	sg.department,
		CASE WHEN s.grade_level = 9 THEN sg.final_grade END AS freshman,
        CASE WHEN s.grade_level = 10 THEN sg.final_grade END AS sophomore,
        CASE WHEN s.grade_level = 11 THEN sg.final_grade END AS junior,
        CASE WHEN s.grade_level = 12 THEN sg.final_grade END AS senior
FROM	students s LEFT JOIN student_grades sg
		ON s.id = sg.student_id;

-- Create the final summary table
SELECT	 sg.department,
		 ROUND(AVG(CASE WHEN s.grade_level = 9 THEN sg.final_grade END)) AS freshman,
         ROUND(AVG(CASE WHEN s.grade_level = 10 THEN sg.final_grade END)) AS sophomore,
         ROUND(AVG(CASE WHEN s.grade_level = 11 THEN sg.final_grade END)) AS junior,
         ROUND(AVG(CASE WHEN s.grade_level = 12 THEN sg.final_grade END)) AS senior
FROM	 students s LEFT JOIN student_grades sg
		 ON s.id = sg.student_id
WHERE	 sg.department IS NOT NULL
GROUP BY sg.department
ORDER BY sg.department;