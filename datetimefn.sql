/*
The datetime() function accepts a time string and one or more modifiers.

Here’s the syntax of the datetime() function:

datetime(time_value [, modifier, modifier,...])
In this syntax:

The time_string specifies a specific datetime, for example now for the current datetime. Here are the valid datetime format strings.
Each modifier modifies the time value. The function applies the modifiers from left to right, therefore, their orders are important. Check this page for a complete list of modifiers.
The datetime() function returns a datetime string in this format: YYYY-MM-DD HH:MM:SS

SQLite datetime() function examples
Let’s explore some examples of using the datetime() function.

1) Basic SQLite datetime() example
The following example uses the datetime() function to extract a datetime from a date and time string:
*/
SELECT DATETIME('2024-04-12 12:30:45.789') AS result;

/*
2) Getting the current time
The following example uses the datetime() function to get the current date and time in UTC:
*/
SELECT DATETIME('now');

/*
The following statement uses the datetime() function to get the current date and time in local time:
*/
SELECT DATETIME('now', 'localtime');

/*
3) Using datetime() function with multiple modifiers
The following statement uses the datetime() function to get the current time of yesterday:
*/
SELECT DATETIME('now', '-1 day', 'localtime') AS result;

/*
In this example:

First, the now modifier returns the current date and time.
Second, the -1 day modifier is applied to the current time that results in the current time of yesterday in UTC.
Third, the localtime modifier instructs the function to return the local time.

4) Using the datetime() function with table data
First, create a new table named referrals with three columns: id, source, and created_at.
*/
DROP TABLE IF EXISTS referrals;

CREATE TABLE referrals (
  id INTEGER PRIMARY KEY,
  source TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

/*
The created_at column has a default value of the CURRENT_TIMESTAMP which is the current date and time in UTC.

Second, insert rows into the referrals table:
*/
INSERT INTO referrals
  (source)
VALUES
  ('Search Engines'),
  ('Social Network'),
  ('Email');

/*
Third, query data from the referrals table:
*/
SELECT
  source,
  created_at
FROM referrals;

/*
The output indicates that the time in the created_at column is in UTC.

To convert these created time values to local time, you use the datetime() function as shown in the following query:
*/
SELECT
  source,
  DATETIME(created_at, 'localtime') AS created_at
FROM referrals;
