/*
Introduction to the SQLite unixepoch() function
The unixepoch() function allows you to obtain a unix timestamp that is the number of seconds since 1970-01-01 00:00:00 UTC.

Here’s the syntax of the unixepoch() function:

unixepoch(datetime_value, modifier, modifier, ...)
In this syntax:

datetime_value is the input date or datetime string you want to convert to a unix timestamp.
modifier is an optional argument that changes the behavior of the unixepoch() function.
The unixepoch() function returns an integer representing the number of seconds since 1970-01-01 00:00:00 UTC.

But if you use "subsec" modifier, the function will return a floating point including a fractional number of seconds.

SQLite unixepoch() function examples
Let’s take some examples of using the SQLite unixepoch() function.

1) Basic SQLite unixepoch() function example
The following example uses the unixepoch() function to obtain the number of seconds between 1970-01-01 00:00:00 UTC and 2024-11-04:
*/
SELECT UNIXEPOCH('2024-04-11') AS result;

/*
2) Using the unixepoch() function with modifiers
The following example uses the unixepoch() function to obtain the number of seconds between 1970-01-01 00:00:00 UTC and 2024-04-11 15:30:20.45:
*/
SELECT UNIXEPOCH('2024-04-11 15:30:20.45', 'subsec') AS result;

/*
In this example, we use the ‘subsec‘ modifier to get the unix timestamp with a fractional of a second.

3) Using the unixepoch() function to get the number of seconds between two dates
The following example uses the unixepoch() function to get the number of seconds between two dates:
*/
SELECT UNIXEPOCH('2014-04-11') - UNIXEPOCH('2014-04-10') AS result;
