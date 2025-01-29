/*
In SQLite, the json_array() function allows you to return a JSON array from one or more values.

Here’s the syntax of the json_array() function:

json_array(value1, value2, ...)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

value1, value2, … are the values you want to convert into elements of the result JSON array.
The json_array() function returns a JSON array containing the arguments as its elements. If an argument has a type of TEXT, the json_array() converts into a JSON string.

If you don’t provide any arguments, the json_array() returns an empty JSON array.

If an argument is a BLOB, the function throws an error.

SQLite json_array() function examples
Let’s take some examples of using the json_array() function.

1) Creating a JSON array of numbers
The following example uses the json_array() function to create a JSON array that consists of numbers:
*/
SELECT JSON_ARRAY(1, 2, 3);

/*
Creating a JSON array of strings
The following example uses the json_array() function to create a JSON array of strings:
*/
SELECT JSON_ARRAY('hi', 'hello', 'hallo') AS greeting;

/*
Creating a JSON array of mixed values
The following example uses the jsonb_array() function to create a JSON array of values of various types:
*/
SELECT
  JSON_ARRAY(
    NULL,
    'hello',
    1,
    JSON_ARRAY('bye', 'good bye'),
    JSON_OBJECT('name', 'bob')
  ) AS result;

/*
using the json_array() function with table data
First, create a table called quarters:
*/
DROP TABLE IF EXISTS quarters;

CREATE TABLE quarters (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  months JSON NOT NULL
);

/*
Second, insert rows into the quarters table:
*/
INSERT INTO quarters
  (name, months)
VALUES
  ('Q1', JSON_ARRAY('Jan', 'Feb', 'Mar')),
  ('Q2', JSON_ARRAY('Apr', 'May', 'Jun')),
  ('Q3', JSON_ARRAY('Jul', 'Aug', 'Sep')),
  ('Q4', JSON_ARRAY('Oct', 'Nov', 'Dec'));

/*
Third, retrieve data from the quarters table:
*/
SELECT
  *
FROM quarters;
