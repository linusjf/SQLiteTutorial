/*
The DROP INDEX statement allows you to remove an index associated with a table. Here’s the syntax of the DROP INDEX statement:

DROP INDEX [IF EXISTS] index_name;
In this syntax:

First, specify the name of the index you want to remove after the DROP INDEX keywords.
Second, use the optional IF EXISTS clause to conditionally delete the index only if it exists.
The DROP INDEX permanently removes the index_name from the SQLite database.

To get all indexes in the current attached database, you use the following statement:
*/
SELECT
  name,
  tbl_name,
  sql
FROM sqlite_master
WHERE type = 'index';

/*
The query returns the name of the index, the name of the table with which the index is associated, and the SQL statement that defines the index.

Let’s take some examples of using the DROP INDEX statement.

1) Removing indexes
First, create a new table called customers:
*/
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE
);

/*
Second, create an index on the name column:
*/
CREATE INDEX customer_name ON customers (name);

/*
Third, create a unique index on the email column:
*/
CREATE UNIQUE INDEX customer_email ON customers (email);

/*
Fourth, retrieve all indexes of the current database:
*/
SELECT
  name,
  tbl_name,
  sql
FROM sqlite_master
WHERE type = 'index';

/*
The output indicates that there are three indexes. One is created automatically when defining the table and two others are created using the CREATE INDEX statement.



Fifth, remove the customer_name index using the DROP INDEX statement:
*/
DROP INDEX customer_name;

/*
Verify the index removal:
*/
SELECT
  name,
  tbl_name,
  sql
FROM sqlite_master
WHERE type = 'index';

/*
The output indicates that the customer_name index has been removed successfully.

Finally, remove the customer_email index:
*/
DROP INDEX customer_email;

/*
Dropping an index that does not exist
The following statement uses the DROP INDEX statement to drop an index that does not exist:
*/
DROP INDEX customer_phone;

/*
To conditionally remove an index only if it exists, you can use the IF EXISTS option:
*/
DROP INDEX IF EXISTS customer_phone;
/*
This time, SQLite does not issue any errors.
*/
