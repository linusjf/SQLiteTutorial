/*
Creating SQLite Unique Index
In SQLite, a unique index is an index that ensures the values stored in a column or a set of columns are unique across the table.

In other words, no two rows can have the same values in the indexed columns.

To create a unique index, you use the CREATE UNIQUE INDEX statement as follows:

CREATE UNIQUE INDEX [IF NOT EXISTS] index_name
ON table_name(column1, column2, ...)
In this syntax:

First, specify the index name after the CREATE UNIQUE INDEX keywords.
Second, use the IF NOT EXISTS option to create an index only if it does not exist.
Third, provide the table name with which the unique index is associated.
Finally, list out one or more index columns of the table inside the parentheses after the table name.
Note that SQLite considers NULLs different. It means you can have multiple NULLs inside the columns of the unique index.

Creating a unique index for one column
First, create a table called contacts to store the contact data:
*/
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT
);

/*
Second, create a unique index on the email column of the contacts table:
*/
CREATE UNIQUE INDEX contact_email ON contacts (email);

/*
Third, insert a new row into the contacts table:
*/
INSERT INTO contacts
  (name, email)
VALUES
  ('John Doe', 'john@test.com');

/*
Fourth, insert another row into the contacts table with the email that already exists:
*/
INSERT INTO contacts
  (name, email)
VALUES
  ('John Smith', 'john@test.com');

/*
The error indicates that the unique index works as expected.

Fifth, insert two more contacts without emails:
*/
INSERT INTO contacts
  (name, email)
VALUES
  ('Alice', NULL),
  ('Bob', NULL);

/*
Finally, query data from the contacts table:
*/
SELECT
  *
FROM contacts;

/*
The output indicates that SQLite allows multiple NULLs in the column of the unique index.

Creating a unique index for multiple columns
First, create a table called calendars to store month and year data:
*/
DROP TABLE IF EXISTS calendars;

CREATE TABLE calendars (
  id INTEGER PRIMARY KEY,
  year INT NOT NULL,
  month INT NOT NULL CHECK (month >= 1 AND month <= 12),
  month_name TEXT GENERATED ALWAYS AS (
    CASE month
      WHEN 1 THEN 'January'
      WHEN 2 THEN 'February'
      WHEN 3 THEN 'March'
      WHEN 4 THEN 'April'
      WHEN 5 THEN 'May'
      WHEN 6 THEN 'June'
      WHEN 7 THEN 'July'
      WHEN 8 THEN 'August'
      WHEN 9 THEN 'September'
      WHEN 10 THEN 'October'
      WHEN 11 THEN 'November'
      WHEN 12 THEN 'December'
    END
  ) STORED,
  month_abbr TEXT GENERATED ALWAYS AS (
    CASE month
      WHEN 1 THEN 'Jan'
      WHEN 2 THEN 'Feb'
      WHEN 3 THEN 'Mar'
      WHEN 4 THEN 'Apr'
      WHEN 5 THEN 'May'
      WHEN 6 THEN 'Jun'
      WHEN 7 THEN 'Jul'
      WHEN 8 THEN 'Aug'
      WHEN 9 THEN 'Sep'
      WHEN 10 THEN 'Oct'
      WHEN 11 THEN 'Nov'
      WHEN 12 THEN 'Dec'
    END
  ) STORED
);

/*
Second, create a unique index on the year and month columns:
*/
CREATE UNIQUE INDEX calendar_year_month ON calendars (year, month);

/*
Third, insert rows into the calendars table:
*/
INSERT INTO calendars
  (year, month)
VALUES
  (2024, 1),
  (2024, 2),
  (2024, 3);

/*
Fourth, retrieve data from the calendars table:
*/
SELECT
  *
FROM calendars;

/*
The output indicates that SQLite uses the values in the year and month columns to evaluate the uniqueness.

Fifth, attempt to insert a year and month that already exists:
*/
INSERT INTO calendars
  (year, month)
VALUES
  (2024, 3);
