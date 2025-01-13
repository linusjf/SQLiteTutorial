/*
Introduction to SQLite ROWID table
Whenever you create a table without specifying the WITHOUT ROWID option, you get an implicit auto-increment column called rowid. The rowid column store 64-bit signed integer that uniquely identifies a row in the table.

Let’s see the following example.

First, create a new table named people that has two columns: first_name,  and last_name:
*/
CREATE TABLE people (first_name TEXT NOT NULL, last_name TEXT NOT NULL);

/*
Second, insert a row into the people table using the following INSERT statement:
*/
INSERT INTO
  people (first_name, last_name)
VALUES
  ('John', 'Doe');

/*
Third, query data from the people table using the following SELECT statement:
*/
SELECT
  rowid,
  first_name,
  last_name
FROM
  people;

/*
SQLite AUTOINCREMENT
As you can see clearly from the output, SQLite implicitly  creates a column named rowid and automatically assigns an integer value whenever you insert a new row into the table.

Note that you can also refer to the rowid column using its aliases: _rowid_ and oid.

When you create a table that has an INTEGER PRIMARY KEY column, this column is the alias of the rowid column.

The following statement drops table people and recreates it. This time, however, we add another column named person_id whose data type is INTEGER and column constraint is PRIMARY KEY:
*/
DROP TABLE people;

CREATE TABLE people (
  person_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);
