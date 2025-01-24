/*
SQLite time() function accepts a time string and one or more modifiers. It returns a string that represents a specific time in this format: HH:MM:SS.

Here’s the syntax of the time() function:

time(time_value [, modifier, ...])
In this syntax:

The time_value can be any valid time string defined by SQLite. For example, the now string returns the current time. The time_string can be specific such as 05:20:30. Here is a complete list of datetime formats.
Each modifier transforms the time value on its left. The transformation is from left to right, therefore, the order of modifiers is significant and affects the result of the time() function. This page offers a list of modifiers.
SQLite time() function examples
Let’s take some examples of using the time() function.

SQLite time() function examples
Let’s take some examples of using the time() function.

1) Basic SQLite time() function example
The following example uses the time() function to extract the time out of a time value and return it as a string in the format HH:MM:SS:
*/
SELECT TIME('2024-04-12 15:30:20') AS time;

/*
2) Adding or subtracting values from a time
The following example uses the time() function to add 2 hours to a time:
*/
SELECT TIME('10:20:30', '+2 hours') AS result;

/*
In this example, the +2 hours modifier adds 2 hours to the time string 10:20:30 that results in 12:20:30.

The following example uses the time() function to subtract 2 hours from a time:
*/
SELECT TIME('10:20:30', '-2 hours') AS result;

/*
3) Getting the current time
The following example uses the time() function to obtain the current time in UTC:
*/
SELECT TIME('now') AS now;

/*
If you want to get the current local time rather than UTC, you need to pass localtime modifier to the function:
*/
SELECT TIME('now', 'localtime') AS local_time;

/*
4) Using the time() function with table data
First, create a table called events to store event data:
*/
DROP TABLE IF EXISTS events;

CREATE TABLE events (
  event_id INTEGER PRIMARY KEY,
  event_name TEXT,
  event_time DATETIME
);

/*
Second, insert some rows into the events table:
*/
INSERT INTO events
  (event_name, event_time)
VALUES
  ('Meeting', '2024-04-12 10:00:00'),
  ('Lunch', '2024-04-12 13:30:00'),
  ('Presentation', '2024-04-12 15:45:00'),
  ('Dinner', '2024-04-12 18:00:00'),
  ('Workshop', '2024-04-12 09:00:00');

/*
Third, use the time() function to extract time from the event_time column and compare it with 17:00:00 to retrieve events occurring after 5:00 PM:
*/
SELECT
  *
FROM events
WHERE TIME(event_time) > '17:00:00';
