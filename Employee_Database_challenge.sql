-- No. 1 retrieve from employees
Select emp_no, first_name, last_name
From employees

-- No. 2 retrieve from titles
Select title, from_date, to_date
From titles

-- Nos. 3 & 4 create a new table, joining
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees
JOIN titles
ON employees
-- No. 5 filter for birthdates in 1952-1955, then order by employee number
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retirement_titles

DROP TABLE unique_titles

-- No. 8 - 15 Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title
INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = '9999-01-01'
ORDER BY retirement_titles.emp_no ASC;

SELECT * FROM unique_titles

SELECT 
DISTINCT ON (unique_titles.title) --unique_titles.title,
COUNT (unique_titles.title), unique_titles.title 
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY unique_titles.title
-- would not order by count column but counts are correct
SELECT * FROM retiring_titles

-- Deliverable 2
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_employees.from_date,
	dept_employees.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees
JOIN dept_employees ON employees.emp_no = dept_employees.emp_no
JOIN titles on employees.emp_no = titles.emp_no
WHERE (dept_employees.to_date = '9999-01-01')
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility

SELECT * FROM current_emp
SELECT COUNT FROM (current_emp.emp_no), dept_employees.emp_no

SELECT 
--DISTINCT ON (unique_titles.title) --unique_titles.title,
COUNT (mentorship_eligibility.title), mentorship_eligibility.title 
--INTO retiring_titles
FROM mentorship_eligibility
GROUP BY mentorship_eligibility.title;
-- would not order by count column but counts are correct
SELECT * FROM mentorship_eligibility

--want retiring by department
SELECT * FROM ret_by_dept;

--1965 mentors by department
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_employees.dept_no,
	dept_employees.from_date,
	dept_employees.to_date,
	titles.title
--INTO mship_dept
FROM employees
JOIN dept_employees ON employees.emp_no = dept_employees.emp_no
JOIN titles on employees.emp_no = titles.emp_no
WHERE (dept_employees.to_date = '9999-01-01')
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM emp_info

SELECT emp_info.emp_no,
	emp_info.gender,
	emp_info.salary,
	titles.title,
	titles.to_date
INTO salary_compare
FROM emp_info
JOIN titles on emp_info.emp_no = titles.emp_no
WHERE (titles.to_date = '9999-01-01')

SELECT * FROM salary_compare
