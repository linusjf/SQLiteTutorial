/*
The SQLite DELETE statement allows you to delete one row, multiple rows, and all rows in a table. The syntax of the SQLite DELETE statement is as follows:

DELETE FROM table
WHERE search_condition;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, specify the name of the table which you want to remove rows after the DELETE FROM keywords.
Second, add a search condition in the WHERE clause to identify the rows to remove. The WHERE clause is an optional part of the DELETE statement. If you omit the WHERE clause, the DELETE statement will delete all rows in the table.
SQLite also provides an extension to the DELETE statement by adding ORDER BY and LIMIT clauses. If you compile SQLite with the SQLITE_ENABLE_UPDATE_DELETE_LIMIT compile-time option, you can use the ORDER BY and LIMIT clause in the DELETE statement like the following form:

DELETE FROM table
WHERE search_condition
ORDER BY criteria
LIMIT row_count OFFSET offset;

The ORDER BY clause sorts the rows filtered by the preceding search_condition in the WHERE clause and the LIMIT clause specifies the number of rows that to be deleted.

Notice that when you use the DELETE statement without a WHERE clause on a table that has no triggers. SQLite will delete all rows in one shot instead of visiting and deleting each individual row. This feature is known as truncate optimization.
*/
DROP TABLE IF EXISTS artists_backup;

/*
We will use the artists_backup table created in the how to insert rows into table tutorial.

If you did not follow that tutorial, you can create the artists_backup table and insert data into it using the following script:
*/
-- create artists backup table
CREATE TABLE artists_backup (
  artistid INTEGER PRIMARY KEY AUTOINCREMENT,
  name NVARCHAR
);

-- populate data from the artists table
INSERT INTO
  artists_backup
SELECT
  artistid,
  name
FROM
  artists;

/*
The following statement returns all rows from the artists_backup table:
*/
SELECT
  artistid,
  name
FROM
  artists_backup;

/*
We have 280 rows in the artists_backup table.

To remove an artist with id 1, you use the following statement:
*/
DELETE FROM artists_backup
WHERE
  artistid = 1;

/*
Because we use artistid to identify the artist, the statement removed exactly 1 row.

Suppose you want to delete artists whose names contain the word Santana:
*/
DELETE FROM artists_backup
WHERE
  name like '%Santana%';

/*
There are 9 rows whose values in the name column contain the word Santana therefore, these 9 rows were deleted.

To remove all rows in the artists_backup table, you just need to omit the WHERE clause as the following statement:
*/
DELETE FROM artists_backup;
