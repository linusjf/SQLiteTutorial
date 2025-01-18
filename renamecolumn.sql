/*
SQLite added support for renaming column since version 3.25.0 using the ALTER TABLE statement with the following syntax:

ALTER TABLE table_name
RENAME COLUMN current_name TO new_name;

In this syntax:

First, specify the name of the table after the ALTER TABLE keywords.
Second, specify the name of the column that you want to rename after the RENAME COLUMN keywords and the new name after the TO keyword.
SQLite ALTER TABLE RENAME COLUMN example
Let’s take an example of using the ALTER TABLE RENAME COLUMN statement.

First, create a new table called Locations:
*/
DROP TABLE IF EXISTS locations;
CREATE TABLE locations (
  locationid INTEGER PRIMARY KEY,
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  country TEXT NOT NULL
);
/*
Second, insert a new row into the Locations table by using the INSERT statement:
*/
INSERT INTO locations (address, city, state, country)
VALUES ('3960 North 1st Street', 'San Jose', 'CA', 'USA');
/*
Third, rename the column Address to Street by using the ALTER TABLE RENAME COLUMN statement:
*/
ALTER TABLE locations
RENAME COLUMN address TO street;
/*
Fourth, query data from the Locations table:
*/
SELECT
*
FROM locations;
--noqa: disable=all
.schema locations
--noqa: enable=all
