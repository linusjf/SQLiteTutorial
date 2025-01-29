/*
In SQLite, the json_quote() function allows you to convert an SQL value into its corresponding JSON value:

json_quote(x)
In this syntax:

x is a value (a string or a number) that you want to convert into a JSON value.
The json_quote() function returns a JSON representation of the x.

If the x is a JSON value returned by another JSON function, the json_quote() function does not modify it. Instead, it returns the input JSON value as it is.

SQLite json_quote() function examples
The following example uses the json_quote() function to convert a number into a JSON value:
*/
SELECT JSON_QUOTE(100);

/*
The following example uses the json_quote() function to convert a string into a JSON value:
*/
SELECT JSON_QUOTE('Hi');

/*
The following example uses the json_quote() function to convert a value returned by the json() function:
*/
SELECT JSON_QUOTE(JSON('[1,2,3]'));
/*
In this case, the function does not modify the result of the json() function and simply returns a value as it is.

*/
