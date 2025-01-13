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

/*
In this case, the person_id column is actually the rowid column.

How does SQLite assign an integer value to the rowid column?

If you don’t specify the rowid value or you use a NULL value when you insert a new row, SQLite automatically assigns the next sequential integer, which is one larger than the largest rowid in the table. The rowid value starts at 1.

The maximum value of  therowid column is 9,223,372,036,854,775,807, which is very big. If your data reaches this maximum value and you attempt to insert a new row, SQLite will find an unused integer and uses it. If SQLite cannot find any unused integer, it will issue an SQLITE_FULL error. On top of that, if you delete some rows and insert a new row, SQLite will try to reuse the rowid values from the deleted rows.

Let’s take a test on it.

First, insert a row with the maximum value into the people table.
*/
INSERT INTO
  people (person_id, first_name, last_name)
VALUES
  (9223372036854775807, 'Johnathan', 'Smith');

/*
SQLite maximum rowid value
Second, insert another row without specifying a value for the person_id column:
*/
INSERT INTO
  people (first_name, last_name)
VALUES
  ('William', 'Gate');

/*
SQLite INSERT row without rowid
As clearly shown in the output, the new row received an unused integer.

Consider another example.

First, create a new table named t1 that has one column:
*/
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (c TEXT);

/*
Second, insert some rows into the t1 table:
*/
INSERT INTO
  t1 (c)
VALUES
  ('A');

INSERT INTO
  t1 (c)
VALUES
  ('B');

INSERT INTO
  t1 (c)
VALUES
  ('C');

INSERT INTO
  t1 (c)
VALUES
  ('D');

/*
Third, query data from the t1 table:
*/
SELECT
  rowid,
  c
FROM
  t1;

/*
Fourth, delete all rows of the t1 table:
*/
DELETE FROM t1;

/*
Fifth, insert some rows into the t1 table:
*/
INSERT INTO
  t1 (c)
VALUES
  ('E');

INSERT INTO
  t1 (c)
VALUES
  ('F');

INSERT INTO
  t1 (c)
VALUES
  ('G');

/*
Finally, query data from the t1 table:
*/
SELECT
  rowid,
  c
FROM
  t1;

/*
As you can see, the rowid 1, 2 and 3 have been reused for the new rows.

SQLite AUTOINCREMENT column attribute
SQLite recommends that you should not use AUTOINCREMENT attribute because:

The AUTOINCREMENT keyword imposes extra CPU, memory, disk space, and disk I/O overhead and should be avoided if not strictly needed. It is usually not needed.

In addition, the way SQLite assigns a value for the AUTOINCREMENT column slightly different from the way it does for the rowid column.

Consider the following example.

First, drop and recreate the people table. This time, we use AUTOINCREMENT attribute column:
*/
DROP TABLE people;

CREATE TABLE people (
  person_id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

/*
Second, insert a row with the maximum rowid value into the people table.
*/
INSERT INTO
  people (person_id, first_name, last_name)
VALUES
  (9223372036854775807, 'Johnathan', 'Smith');

/*
Third, insert another row into the people table.
*/
INSERT INTO
  people (first_name, last_name)
VALUES
  ('John', 'Smith');

/*
This time, SQLite issued an error message because the person_id column did not reuse the number like a rowid column.

[Err] 13 - database or disk is full

When should you use the AUTOINCREMENT column attribute?

The main purpose of using attribute AUTOINCREMENT is to prevent SQLite to reuse a value that has not been used or a value from the previously deleted row.

If you don’t have any requirement like this, you should not use the AUTOINCREMENT attribute in the primary key.*/
