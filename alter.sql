/*
Unlike SQL-standard and other database systems, SQLite supports a very limited functionality of the ALTER TABLE statement.

By using an SQLite ALTER TABLE statement, you can perform two actions:

Rename a table.
Add a new column to a table.
Rename a column (added supported in version 3.20.0)
*/

/*
Using SQLite ALTER TABLE to rename a table
To rename a table, you use the following ALTER TABLE RENAME TO statement:

ALTER TABLE existing_table
RENAME TO new_table;
These are important points you should know before you rename a table:

The ALTER TABLE only renames a table within a database. You cannot use it to move the table between the attached databases.
The database objects such as indexes and triggers associated with the table will be associated with the new table.
If a table is referenced by views or statements in triggers, you must manually change the definition of views and triggers.
Let’s take an example of renaming a table.

First, create a table named devices that has three columns: name, model, serial; and insert a new row into the devices table.
*/
DROP TABLE IF EXISTS devices;
DROP TABLE IF EXISTS equipment;

CREATE TABLE devices (
  name TEXT NOT NULL,
  model TEXT NOT NULL,
  serial INTEGER NOT NULL UNIQUE
);

INSERT INTO devices (name, model, serial)
VALUES ('HP ZBook 17 G3 Mobile Workstation', 'ZBook', 'SN-2015');
/*
Second, use the ALTER TABLE RENAME TO statement to change the devices table to equipment table as follows:
*/
ALTER TABLE devices
RENAME TO equipment;
/*
Third, query data from the equipment table to verify the RENAME operation.
*/
SELECT
  name,
  model,
  serial
FROM equipment;

/*
Using SQLite ALTER TABLE to add a new column to a table
You can use the SQLite ALTER TABLE statement to add a new column to an existing table. In this scenario, SQLite appends the new column at the end of the existing column list.

The following illustrates the syntax of ALTER TABLE ADD COLUMN statement:

ALTER TABLE table_name
ADD COLUMN column_definition;
There are some restrictions on the new column:

The new column cannot have a UNIQUE or PRIMARY KEY constraint.
If the new column has a NOT NULL constraint, you must specify a default value for the column other than a NULL value.
The new column cannot have a default of CURRENT_TIMESTAMP, CURRENT_DATE, and CURRENT_TIME, or an expression.
If the new column is a foreign key and the foreign key constraint check is enabled, the new column must accept a default value NULL.
For example, you can add a new column named location to the equipment table:
*/
ALTER TABLE equipment
ADD COLUMN location TEXT;

/*

Using SQLite ALTER TABLE to rename a column
SQLite added the support for renaming a column using ALTER TABLE RENAME COLUMN statement in version 3.20.0

The following shows the syntax of the ALTER TABLE RENAME COLUMN statement:
ALTER TABLE table_name
RENAME COLUMN current_name TO new_name;
For more information on how to rename a column, check it out the renaming column tutorial.
*/

/*
SQLite does not support ALTER TABLE DROP COLUMN statement. To drop a column, you need to use the steps above.

The following script creates two tables users and favorites, and insert data into these tables:
*/
PRAGMA foreign_keys = OFF;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS favorites;

CREATE TABLE users (
  userid INTEGER PRIMARY KEY,
  firstname TEXT NOT NULL,
  lastname TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL
);

CREATE TABLE favorites (
  userid INTEGER,
  playlistid INTEGER,
  FOREIGN KEY (userid) REFERENCES users (userid),
  FOREIGN KEY (playlistid) REFERENCES playlists (playlistid)
);

INSERT INTO users (firstname, lastname, email, phone)
VALUES ('John', 'Doe', 'john.doe@example.com', '408-234-3456');

INSERT INTO favorites (userid, playlistid)
VALUES (1, 1);
/*
The following statement returns data from the users table:
*/
SELECT
  *
FROM users;
/*
And the following statement returns the data from the favorites table:
*/
SELECT
  *
FROM favorites;

/*
Suppose, you want to drop the column phone of the users table.

First, disable the foreign key constraint check:
*/
PRAGMA foreign_keys = OFF;
/*
Second, start a new transaction:
*/
BEGIN TRANSACTION;
/*
Third, create a new table to hold data of the users table except for the phone column:
*/
DROP TABLE IF EXISTS persons;

CREATE TABLE IF NOT EXISTS persons (
  userid INTEGER PRIMARY KEY,
  firstname TEXT NOT NULL,
  lastname TEXT NOT NULL,
  email TEXT NOT NULL
);
/*
Fourth, copy data from the users to persons table:
*/
INSERT INTO persons (userid, firstname, lastname, email)
SELECT
  userid,
  firstname,
  lastname,
  email
FROM users;
/*
Fifth, drop the users table:
*/
DROP TABLE users;
/*
Sixth, rename the persons table to users table:
*/
ALTER TABLE persons RENAME TO users;
/*
Seventh, commit the transaction:
*/
COMMIT;
/*
Eighth, enable the foreign key constraint check:
*/
PRAGMA foreign_keys = ON;
/*
Here is the users table after dropping the phone column:
*/
SELECT
  *
FROM users;
