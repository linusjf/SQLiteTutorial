/*

The idea of the REPLACE statement is that when a UNIQUE or PRIMARY KEY constraint violation occurs, it does the following:

First, delete the existing row that causes a constraint violation.
Second, insert a new row.
In the second step, if any constraint violation e.g., NOT NULL constraint occurs, the REPLACE statement will abort the action and roll back the transaction.

The following illustrates the syntax of the REPLACE statement.

INSERT OR REPLACE INTO table(column_list)
VALUES(value_list);
Or in a short form:

REPLACE INTO table(column_list)
VALUES(value_list);
*/
DROP TABLE IF EXISTS positions;

/*
First, create a new table named positions with the following structure.
*/
CREATE TABLE IF NOT EXISTS positions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  min_salary NUMERIC
);

/*
Second, insert some rows into the positions table.
*/
INSERT INTO positions
  (title, min_salary)
VALUES
  ('DBA', 120000),
  ('Developer', 100000),
  ('Architect', 150000);

/*
Third, verify the insert using the following SELECT statement.
*/
SELECT
  *
FROM positions;

/*
The following statement creates a unique index on the title column of the positions table to ensure that it doesn’t have any duplicate position title:
*/
CREATE UNIQUE INDEX idx_positions_title ON positions (title);

/*
Suppose, you want to add a position into the positions table if it does not exist, in case the position exists, update the current one.

The following REPLACE statement inserts a new row into the positions table because the position title Full Stack Developer is not in the positions table.
*/
REPLACE INTO positions
  (title, min_salary)
VALUES
  ('Full Stack Developer', 140000);

/*
You can verify the REPLACE operation using the SELECT statement.
*/
SELECT
  id,
  title,
  min_salary
FROM positions;

/*
See the following statement.
*/
REPLACE INTO positions
  (title, min_salary)
VALUES
  ('DBA', 170000);

/*
SQLite REPLACE - replace the existing row
First, SQLite checked the UNIQUE constraint.

Second, because this statement violated the UNIQUE constraint by trying to add the DBA title that already exists, SQLite deleted the existing row.

Third, SQLite inserted a new row with the data provided by the REPLACE statement.*/
SELECT
  id,
  title,
  min_salary
FROM positions;

/*
Notice that the REPLACE statement means INSERT or REPLACE, not INSERT or UPDATE.

See the following statement.
*/
REPLACE INTO positions
  (id, min_salary)
VALUES
  (2, 110000);
/*
What the statement tried to do is to update the min_salary for the position with id 2, which is the developer.

First, the position with id 2 already exists, the REPLACE statement removes it.

Then, SQLite tried to insert a new row with two columns: ( id, min_salary). However, it violates the NOT NULL constraint of the title column. Therefore, SQLite rolls back the transaction.

If the title column does not have the NOT NULL constraint, the REPLACE statement will insert a new row whose the title column is NULL
*/
