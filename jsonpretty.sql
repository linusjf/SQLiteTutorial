/*
The json_pretty() function works like the json() function but makes the JSON value prettier. This means that the json_pretty() function adds extra whitespace to make the JSON value more human-readable.

Note that SQLite added the json_pretty() function since version 3.46.0 on May 23, 2024.

Here’s the syntax of the json_pretty() function:

json_pretty(json_value, format)
In this syntax:

json_value is a valid JSON value to format.
format is an optional argument used for indentation. If you omit the second argument or use NULL, the function will use four spaces to indent each level.
SQLite json_pretty() function examples
The following example uses the json_pretty() function to format a JSON value:
*/
SELECT
  JSON_PRETTY(
    '{"name": "Alice"     ,"age" : 25 , "address": {"street": "101 N 1st Street", "city": "San Jose"} }'
  );

/*
In this example, we do not use the second argument, the indentation is four spaces per level.

Like the json() function, the json_pretty function validates the JSON value before formatting it:
*/
SELECT JSON_PRETTY('{"name": "Alice" "age" : 25}');

/*
If you want the indentation to be one space per level, you can pass a space character to the second argument of the json_pretty() function like this:
*/
SELECT
  JSON_PRETTY(
    '{"name": "Alice"     ,"age" : 25 , "address": {"street": "101 N 1st Street", "city": "San Jose"} }',
    ' '
  );
