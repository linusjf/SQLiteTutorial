/*
In SQLite, the json_tree() is a table-valued function that allows you to iterate over elements of a JSON object or array recursively.

Here’s the syntax of the json_tree() function:

json_tree(json_value)
In this syntax:

json_value is the JSON object or array that you want to iterate.
The json_tree() function returns a set of rows, each representing an element in the JSON object or array.

If you want to iterate elements of a JSON object or array recursively, which is specified by a path, you can use the following json_tree() function:

json_tree(json_data, path);
In this syntax:

json_data is the JSON data from which you want to extract a JSON object or array for iterating.
path is the JSON path expression for selecting the JSON object or array in the json_data.
The json_tree() function returns a result set that includes the following columns:

key: is the key of the object element or the index of the array element.
value: is the value of the element.
type: is the data type of the value such as integer, text, real, null, or object.
atom: is the atomic value of the element such as the number, string, or null.
id: is the identifier for the top-level JSON value (useful for joining with other json_tree() results).
parent: is the identifier of the parent JSON value (useful for hierarchical queries).
fullkey: is the full key path to the element.
path: is the JSON path to the element.
Because the json_tree() function is a table-valued function, you need to use it in the place that accepts a table such as in the FROM clause of the SELECT statement.

If you don’t do so, you’ll get the following error:

Parse error: no such function: <span style="background-color: initial; font-family: inherit; font-size: inherit; text-wrap: wrap; color: initial;">json_tree</span>
SQLite json_tree() function examples

Let’s take some examples of using the json_tree() function.

1) Iterating elements of a JSON object
The following example uses the json_tree() function to iterate over the elements of a JSON object recursively:
*/
SELECT
  *
FROM
  JSON_TREE(
    '{
  "name": "John Doe",
  "age": 25,
  "address": {
    "street": "123 Main Street",
    "city": "San Jose",
    "state": "CA",
    "zipcode": "95134"
  }
}'
  );

/*
Notice that the json_each() only returns the top-level elements of the JSON object:
*/
SELECT
  *
FROM
  JSON_EACH(
    '{
  "name": "John Doe",
  "age": 25,
  "address": {
    "street": "123 Main Street",
    "city": "San Jose",
    "state": "CA",
    "zipcode": "95134"
  }
}'
  );

/*

2) Iterating elements of a JSON object specified by a path
The following example uses the json_tree() function to iterate over elements of a JSON object specified by a path:
*/
SELECT
  *
FROM
  JSON_TREE(
    '{
   "name": "John Doe",
   "age": 25,
   "contact": {
      "phone": "(408)-111-2222",
      "email": "john.doe@test.com",
      "address": {
         "street": "123 Main Street",
         "city": "San Jose",
         "state": "CA",
         "zipcode": "95134"
      }
   }
}',
    '$.contact'
  );

/*
3) Iterating elements of a JSON array
The following example uses the json_tree() function to iterate over the elements of a JSON array recursively:
*/
SELECT
  *
FROM JSON_TREE('[1,2,3,[4,5]]');
