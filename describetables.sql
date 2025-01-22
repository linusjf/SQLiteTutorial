/*
Getting the structure of a table via the SQLite command-line shell program
To find out the structure of a table via the SQLite command-line shell program, you follow these steps:

First, connect to a database via the SQLite command-line shell program:

sqlite3 c:\sqlite\db\chinook.db
Then, issue the following command:
.schema table_name

For example, the following command shows the statement that created the albums table:
*/
/* sql-formatter-disable */
-- noqa:disable=all
.schema albums
/*
Notice that there is no semicolon (;
) after the table name. If you add a semicolon (;
), the .schema will consider the albums;
as the table name and returns nothing because the table albums;
does not exist.

Another way to show the structure of a table is to use the PRAGMA command. To do it, you use the following command to format the output:
*/
.header on
.mode column
-- noqa:enable=all
/* sql-formatter-enable */
/*
And use the PRAGMA command as follows:
*/
PRAGMA table_info ('albums');

/*
You can find the structure of a table by querying it from the sqlite_schema table as follows:
*/
SELECT
  sql
FROM sqlite_schema
WHERE name = 'albums';
