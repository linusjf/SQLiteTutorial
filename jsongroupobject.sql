/*
In SQLite, the json_group_object() function allows you to aggregate name/value pairs into a JSON object.

Here’s the syntax of the json_group_object() function:

json_group_object(name, value)
In this syntax:

name specifies the property names of the resulting JSON object.
value specifies the corresponding values of the property names in the resulting JSON object.
The json_group_object() function returns a JSON object that contains the properties specified by the name/value pairs.

SQLite json_group_object() function
First, create a table called employees to store the employee data:
*/
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  department TEXT NOT NULL,
  salary REAL NOT NULL
);

/*
Second, insert some rows into the employees table:
*/
INSERT INTO employees
  (name, department, salary)
VALUES
  ('John Doe', 'Engineering', 50000),
  ('Jane Smith', 'Marketing', 60000),
  ('Alice Johnson', 'Engineering', 55000),
  ('Bob Brown', 'Marketing', 62000);

/*
Third, use the json_group_object() function to aggregate the department stats including department name, the total employees, and average salary into a JSON object:
*/
WITH
  department_stats AS (
    SELECT
      department,
      COUNT(*) AS total_employees,
      AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
  )
SELECT
  JSON_GROUP_OBJECT(
    department,
    JSON_OBJECT(
      'total_employees',
      total_employees,
      'average_salary',
      average_salary
    )
  ) AS department_info
FROM department_stats;
/*
How it works.

First, create a common table expression (CTE) that includes department names, total employees, and average salary.

Second, use the json_group_object() to aggregate name/value pairs where names are department names and values are JSON objects that include total employees and average salary.

The query utilizes the json_object() function to create a JSON object as a value for each department.
*/
