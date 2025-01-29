/*
In SQLite, the json_object() function accepts zero or more pairs of name/value arguments and converts them into properties of a JSON object. The first and second arguments in each pair are property name and value, respectively.

Here’s the syntax of the json_object() function:

json_object(name1, value1, name2, value2, ...)
In this syntax:

name1, value1, … are pairs of values that correspond to property names and values.
The json_object() function returns a well-formed JSON object. If any value has a type of BLOB, the function raises an error.

Let’s create JSON objects using the json_object() function.

1) Basic json_object() function examples
The following example uses the json_object() function to create an empty object:
*/
SELECT JSON_OBJECT();

/*
The following example uses the json_object() function to create a flat JSON object:
*/
SELECT JSON_OBJECT('name', 'Bob', 'age', 25) AS person;

/*
) Creating a nested JSON object
The following example uses the json_object() function to create a nested JSON object:
*/
SELECT
  JSON_OBJECT(
    'name',
    'Bob',
    'age',
    25,
    'favorite_colors',
    JSON_ARRAY('blue', 'brown')
  ) AS person;

/*
Using json_object() function with table data
We’ll use the customers table from the sample database:

The following example uses the json_object() function to create a JSON object including the first name, last name, and phone of each customer:
*/
SELECT
  JSON_OBJECT(
    'first_name',
    firstname,
    'last_name',
    lastname,
    'phone',
    phone
  ) AS customer
FROM customers
ORDER BY firstname
limit 30;
