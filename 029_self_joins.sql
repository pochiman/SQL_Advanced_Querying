-- 5. Self joins
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary INT,
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, salary, manager_id) VALUES
	(1, 'Ava', 85000, NULL),
	(2, 'Bob', 72000, 1),
	(3, 'Cat', 59000, 1),
	(4, 'Dan', 85000, 2);
    
SELECT * FROM employees;

-- Employees with the same salary
SELECT	e1.employee_id, e1.employee_name, e1.salary,
		e2.employee_id, e2.employee_name, e2.salary
FROM	employees e1 INNER JOIN employees e2
		ON e1.salary = e2.salary
WHERE	e1.employee_id > e2.employee_id;

-- Employees that have a greater salary
SELECT	e1.employee_id, e1.employee_name, e1.salary, 
		e2.employee_id, e2.employee_name, e2.salary
FROM	employees e1 INNER JOIN employees e2
		ON e1.salary > e2.salary
ORDER BY e1.employee_id;

-- Employees and their managers
SELECT	e1.employee_id, e1.employee_name, e1.manager_id,
		e2.employee_name AS manager_name
FROM	employees e1 LEFT JOIN employees e2
		ON e1.manager_id = e2.employee_id;