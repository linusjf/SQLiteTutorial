/*
The json() function validates a JSON value and returns its minified version with unnecessary whitespace removed.

json(json_value)
In this syntax:

json_value is the JSON value that you want to validate.
If the json_value is valid, the json() function returns the minified version of the JSON value. Otherwise, it throws an error.

The json() function returns NULL if the json_value is NULL.

SQLite json() function examples
The following example uses the json() function to validate and return the minified version of a JSON value:
*/
SELECT JSON('{"name": "Alice"     ,"age" : 25   }');

/*
In this example, the function returns the minified version of the input JSON value because the input JSON value is valid.

The following statement uses the json() function to validate a JSON but returns an error because the input JSON value is invalid:
*/
SELECT JSON('{"name": "Alice"  "age" : 25}');

/*
The following example uses the json() function with the NULL argument:
*/
SELECT JSON(NULL);
