/*
When you connect to a database, its name is main regardless of the database file name. In addition, you can access the temporary database that holds temporary tables and other database objects via the temp database.

Therefore, every SQLite database connection has the main database and also temp database in case you deal with temporary database objects.

To attach an additional database to the current database connection, you use the ATTACH DATABASE statement as follows:

ATTACH DATABASE file_name AS database_name;
The statement associates the database file file_name with the current database connection under the logical database name database_name.

If the database file file_name does not exist, the statement creates a new database file.

Once the additional database attached, you can refer to all objects in the database under the name database_name. For example, to refer to the people table in the contacts database, you use the contacts.people.

In case you want to create a new memory database and attach it to the current database connection, you use :memory: filename.

You can attach multiple in-memory databases at the same time with a condition that each memory database must be unique.

If you specify an empty file name '', the statement creates a temporary file-backed database.

Note that SQLite automatically deletes all temporary and memory databases when the database connection is closed.
*/
/* sql-formatter-disable */
.databases --noqa
/* sql-formatter-enable */
ATTACH DATABASE 'contacts.db' AS contacts;

/*
Fourth, use the .database command to display all databases in the current database connection.
*/
/* sql-formatter-disable */
.databases --noqa
/* sql-formatter-enable */
DROP TABLE IF EXISTS contacts.people;

CREATE TABLE contacts.people (first_name TEXT, last_name TEXT);

INSERT INTO
  contacts.people
SELECT
  firstname,
  lastname
FROM
  customers;

/*
Notice that we referred to the people table in the contacts database using the contacts.people naming convention.

Finally, query data from the people table in the contacts database.
*/
SELECT
  *
FROM
  contacts.people;
