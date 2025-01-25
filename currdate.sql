/*
SQLite current_date Function

Summary: in this tutorial, you will learn how to use the SQLite current_date function to return the current date in UTC.

Introduction to the SQLite current_date function
In SQLite, the current_date function returns the current date in UTC.

The following shows the syntax of the current_date function:

current_date
The current_date function returns the current UTC date in the format YYYY-MM-DD.

In practice, you can use the current_date function as a default value for a date column or insert/update the current date into a date column.

SQLite current_date function examples
Let’s take some examples of using the current_date function.

1) Basic SQLite current_date function example
The following example shows how to use the current_date function to retrieve the current date:
*/
SELECT CURRENT_DATE;

/*
To get the current date in the local time, you can pass the current_date to the date() function as follows:
*/
SELECT DATE(CURRENT_DATE, 'localtime') AS local_date;

/*
2) Using the current_date function to calculate ages
First, create a new table called members to store member data:
*/
DROP TABLE IF EXISTS members;

CREATE TABLE members (
  id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  date_of_birth TEXT NOT NULL
);

/*
Second, insert rows into the members table:
*/
INSERT INTO members
  (name, date_of_birth)
VALUES
  ('John Doe', '1999-06-17'),
  ('Jane Smith', '1998-09-01'),
  ('Alice Boutique', '1998-11-10')
RETURNING *;

/*
Second, calculate the age of members using the current_date function:
*/
SELECT
  name,
  date_of_birth,
  CURRENT_DATE AS today,
  CAST(
    ((JULIANDAY(CURRENT_DATE) - JULIANDAY(date_of_birth)) / 365.25) AS INTEGER
  ) AS age
FROM members
ORDER BY name;

/*
3) Using the current_date function as the default value of a column
We’ll take an example of using the current_date function as the default value of a date column.

First, create a table called purchase_requests to store the purchase requests:
*/
DROP TABLE IF EXISTS purchase_requests;

CREATE TABLE purchase_requests (
  id INTEGER PRIMARY KEY,
  product_name TEXT NOT NULL,
  quantity INT NOT NULL,
  requested_date DATE DEFAULT CURRENT_DATE
);

/*
In the purchase_requests table, the requested_date column uses the current_date as the default value.

Second, insert a new row into the purchase_requests table:
*/
INSERT INTO purchase_requests
  (product_name, quantity)
VALUES
  ('Laptop', 20);

/*
The INSERT statement does not have a requested date, therefore, it uses the current date in UTC as the default value.

Third, retrieve the data from purchase_requests table:
*/
SELECT
  *
FROM purchase_requests;
/*
The output shows that the INSERT statement inserted the current date into the requested_date column.
*/
