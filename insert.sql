/*
To insert data into a table, you use the INSERT statement. SQLite provides various forms of the INSERT statements that allow you to insert a single row, multiple rows, and default values into a table.

In addition, you can insert a row into a table using data provided by a  SELECT statement.

SQLite INSERT – inserting a single row into a table
To insert a single row into a table, you use the following form of the INSERT statement:

INSERT INTO table (column1,column2 ,..)
VALUES( value1,	value2 ,...);
Let’s examine the INSERT statement in more detail:

First, specify the name of the table to which you want to insert data after the INSERT INTO keywords.
Second, add a comma-separated list of columns after the table name. The column list is optional. However, it is a good practice to include the column list after the table name.
Third, add a comma-separated list of values after the VALUES keyword. If you omit the column list, you have to specify values for all columns in the value list. The number of values in the value list must be the same as the number of columns in the column list.

*/
/*
/*
The following statement insert a new row into the artists table:
*/
INSERT INTO
  artists (name)
VALUES
  ('Bud Powell');

/*
Because the ArtistId column is an auto-increment column, you can ignore it in the statement. SQLite automatically geneate a sequential integer number to insert into the ArtistId column.

You can verify the insert operation by using the following SELECT statement:
*/
SELECT
  artistid,
  name
FROM
  artists
ORDER BY
  artistid DESC
LIMIT
  1;

/*

INSERT INTO table1 (column1,column2 ,..)
VALUES
(value1,value2 ,...),
(value1,value2 ,...),
...
(value1,value2 ,...);
Each value list following the VALUES clause is a row that will be inserted into the table.

The following example inserts three rows into the artists table:
*/
INSERT INTO
  artists (name)
VALUES
  ('Buddy Rich'),
  ('Candido'),
  ('Charlie Byrd');

/*
SQLite issued a message:

Row Affected: 3
You can verify the result using the following statement:
*/
SELECT
  artistid,
  name
FROM
  artists
ORDER BY
  artistid DESC
LIMIT
  3;

/*
When you create a new table using the CREATE TABLE statement, you can specify default values for columns, or a NULL if a default value is not specified.

The third form of the INSERT statement is INSERT DEFAULT VALUES, which inserts a new row into a table using the default values specified in the column definition or NULL if the default value is not available and the column does not have a NOT NULL constraint.

For example, the following statement inserts a new row into the artists table using INSERT DEFAULT VALUES:
*/
INSERT INTO
  artists DEFAULT
VALUES;

/*
To verify the insert, you use the following statement:
*/
SELECT
  artistid,
  name
FROM
  artists
ORDER BY
  artistid DESC;

/*

The default value of the ArtistId column is the next sequential integer . However, the name column does not have any default value, therefore, the INSERT DEFAULT VALUES statement inserts NULL  into it.
*/
/*
Suppose you want to backup the artists table, you can follow these steps:

First, create a new table named artists_backup as follows:
*/
DROP TABLE IF EXISTS artists_backup;

CREATE TABLE artists_backup (
  artistid INTEGER PRIMARY KEY AUTOINCREMENT,
  name NVARCHAR
);

/*
To insert data into the artists_backup table with the data from the artists table, you use the INSERT INTO SELECT statement as follows:
*/
INSERT INTO
  artists_backup
SELECT
  artistid,
  name
FROM
  artists;

/*

If you query data from the artists_backup table, you will see all data in the artists table.
*/
SELECT
  *
FROM
  artists_backup;
