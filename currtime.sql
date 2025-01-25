/*
SQLite current_time function examples
Let’s take some examples of using the current_time function.

1) Basic SQLite current_time function example
The following statement uses the current_time function to return the current time in UTC:
*/
SELECT CURRENT_TIME;

/*
If you want to get the current local time, you can pass the result of the current_time function to the time() function and use the localtime modifier.
*/
SELECT TIME(CURRENT_TIME, 'localtime') AS local_time;

/*
2) Using the current_time function as the default value of a column
In practice, you can use the current_time function as the default value of a time column

First, create a table called user_activities to store user activities:
*/
DROP TABLE IF EXISTS user_activities;

CREATE TABLE user_activities (
  id INTEGER PRIMARY KEY,
  username TEXT NOT NULL,
  activity_type TEXT NOT NULL,
  started_at TEXT DEFAULT CURRENT_TIME,
  started_on TEXT DEFAULT CURRENT_DATE
);

/*
The user_activities table has the started_at and started_on columns with the default values are the results of the current_time and current_date functions.

Second, insert a row into the user_activities table:
*/
INSERT INTO user_activities
  (username, activity_type)
VALUES
  ('admin', 'Signed in');

/*
In the statement, we don’t specify the time and date for the started_at and started_on columns.

Third, retrieve the data from the user_activities table:
*/
SELECT
  *
FROM user_activities;
/*
The output indicates that the created_at column is populated with the time at which the INSERT statement executed.

Summary
Use the current_time function to obtain the current time in UTC

*/
