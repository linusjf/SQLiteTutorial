BEGIN TRANSACTION;

/*
To update existing data in a table, you use SQLite UPDATE statement. The following illustrates the syntax of the UPDATE statement:

UPDATE table
SET column_1 = new_value_1,
column_2 = new_value_2
WHERE
search_condition
ORDER column_or_expression
LIMIT row_count OFFSET offset;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the table where you want to update after the UPDATE clause.
Second, set new value for each column of the table in the SET clause.
Third, specify rows to update using a condition in the WHERE clause. The WHERE clause is optional. If you skip it, the UPDATE statement will update data in all rows of the table.
Finally, use the ORDER BY and LIMIT clauses in the UPDATE statement to specify the number of rows to update.
Notice that if use a negative value in the LIMIT clause, SQLite assumes that there are no limit and updates all rows that meet the condition in the preceding WHERE clause.

The ORDER BY clause should always goes with the LIMIT clause to specify exactly which rows to be updated. Otherwise, you will never know which row will be actually updated; because without the ORDER BY clause, the order of rows in the table is unspecified.
*/
/*
The following SELECT statement gets partial data from the employees table:
*/
SELECT
  employeeid,
  firstname,
  lastname,
  title,
  email
FROM
  employees;

/*
Suppose, Jane got married and she wanted to change her last name to her husband’s last name i.e., Smith. In this case, you can update Jane’s last name using the following statement:
*/
UPDATE employees
SET
  lastname = 'Smith'
WHERE
  employeeid = 3;

/*
The expression in the WHERE clause makes sure that we update Jane’s record only. We set the lastname column to a literal string 'Smith'.

To verify the UPDATE, you use the following statement:
*/
SELECT
  employeeid,
  firstname,
  lastname,
  title,
  email
FROM
  employees
WHERE
  employeeid = 3;

ROLLBACK;
