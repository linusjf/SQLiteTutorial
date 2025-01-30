/*
In SQLite, the json_type() function returns the type of a JSON element. Here’s the syntax of the json_type() function:

json_type(x)
In this syntax:

x is the JSON element of which you want to get the type.
If you want to get the JSON type of an element specified by a path, you can use the following syntax:

json_type(x, path)
Code language: SQL (Structured Query Language) (sql)
In this syntax, the json_type() function returns the type of the element in x selected by the path.

The json_type() function returns the following SQL text values:

null
false
true
integer
real
text
array
object
If the path does not exist in x, then the json_type() function returns NULL.

The following example uses the json_type() function to return the json type of a JSON object:
*/
SELECT JSON_TYPE('{"name": "Joe"}');

/*
The following example uses the json_type() function to return the json type of a JSON array:
*/
SELECT JSON_TYPE('[1,2,3]');

/*
The following example uses the json_type() function to return the json type of the first element in a JSON array:
*/
SELECT JSON_TYPE('[1,2,3]', '$[1]');

/*
The following example uses the json_type() function to return the json type of the value of the name property in a JSON object:
*/
SELECT JSON_TYPE('{"name": "Joe"}', '$.name');

/*
The following example uses the json_type() function to return the json type of the value of the active property in a JSON object:
*/
SELECT JSON_TYPE('{"name": "Joe", "active": true }', '$.active');

/*
The following example uses the json_type() function to return the json type of the value of a property that does not exist:
*/
SELECT JSON_TYPE('{"name": "Joe"}', '$.age');

/*The following statement uses the json_type() function to return the json type of the value of the age property:
*/
SELECT JSON_TYPE('{"name": "Joe", "age": 25}', '$.age');

/*
The following statement uses the json_type() function to return the json type of the value of the weight property:
*/
SELECT JSON_TYPE('{"name": "Joe", "age": 25, "weight": 176.37}', '$.weight');
