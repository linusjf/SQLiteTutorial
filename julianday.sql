/*
The Julian day is a continuous count of days since the beginning of the Julian period, which started on January 1, 4713 BCE (Before the Common Era).

Julian day numbers are useful because they provide a uniform way to represent dates, regardless of different calendar systems and the complexity of leap years.

Today, you’ll find the Julian Day numbers often used in astronomy and historical research as a convenient reference for dating events and astronomical phenomena.

In SQLite, the julianday() function allows you to convert dates and times into Julian day numbers.

Here’s the syntax of the julianday() function:

julianday(date_string, [modifier], [modifier], ...)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

date_string is the input date or datetime string to convert to a Julian day number.
modifier is an optional argument to adjust the behavior of the function. You can use it to specify the start of the day or adjust for time zones.
The julianday() function returns the fractional number of days since noon in Greenwich on November 24, 4714 B.C.

SQLite julianday() function examples
Let’s explore some examples of using the julianday() function.

1) Basic SQLite julianday() function example
The following query converts the date 2024-04-11 to a Julian day number:

*/
SELECT JULIANDAY('2024-04-11') AS julian_day;

/*
2) Using julianday() function to convert a time to a Julian day number
The following query uses the julianday() function to convert the date and time 2024-04-11 12:30:45 to a Julian day number:
*/
SELECT JULIANDAY('2024-04-11 12:30:45') AS julian_day;

/*
3) Using julianday() function with a modifier
The following example uses the julianday() function to convert a date to a Julian day number. Since we use the ‘start of day’ modifier, the function will ignore the time part and use only the date part for calculation:
*/
SELECT JULIANDAY('2024-04-11', 'start of day') AS julian_day;

/*
4) Using julianday() function with time zones
The following query uses the julianday() function to convert the date and time with a timezone to a Julian day number:
*/
SELECT JULIANDAY('2024-04-11 12:30:45', '+03:00') AS julian_day;

/*
5) Calculating the number of days between two dates
The following example uses the julianday() function to calculate the number of days between two dates:
*/
SELECT JULIANDAY('2024-02-25') - JULIANDAY('2024-03-01') AS day_count;
/*
Notice that the julianday() function takes the leap year Feb 29, 2024 into the calculation.
*/
