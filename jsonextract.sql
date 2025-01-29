/*
In SQLite, the json_extract() function allows you to extract one or more values from JSON data.

Here’s the syntax of the json_extract() function:

json_extract(json_value, path1 [, path2]...)
In this syntax:

json_value is the JSON data from which you want to extract values.
path1, path2, … is the JSON path that locates the values in the json_value. If you provide multiple JSON paths, the json_extract() function returns the extracted values as elements of a JSON array.
Notice that if you provide one JSON path argument (path1), the json_extract() function returns an SQL value.

However, if you provide two or more path arguments, (path1, path2, and so on), the json_extract() function returns a JSON value i.e., a JSON array that holds the extracted values.

Notice that MySQL’s json_extract() function always returns a JSON value.

If the path does not locate any element in json_value, the json_extract() function returns NULL. Additionally, the json_extract() function also returns NULL if any argument is NULL.

Let’s use the json_extract() function to extract values from JSON data.

1) Extracting a single value
The following example uses the json_extract() function to extract the name from a JSON value:
*/
SELECT JSON_EXTRACT('{"name": "Alice", age: 22}', '$.name') AS name;

/*
In this example, the path '$.name' locates the name property of a JSON object. Therefore, the json_extract() function returns the value of the name property, which is Alice.
*/
SELECT TYPEOF(JSON_EXTRACT('{"name": "Alice", age: 22}', '$.name')) AS type;

/*
The result is not a JSON value but has a type of TEXT. You can verify it using the typeof() function:
*/
SELECT TYPEOF(JSON_EXTRACT('{"name": "Alice", age: 22}', '$.name')) AS type;

/*
2) Extracting multiple values
The following example uses the json_extract() function to extract multiple values specified by multiple paths:
*/
SELECT JSON_EXTRACT('{"name": "Alice", age: 22}', '$.name', '$.age') AS result;

/*
In this example, we use multiple JSON paths:

'$.name' – locates the name property.
'$.age' – matches the age property.
The json_extract() function extracts values and puts them into a JSON array. The type of the result is JSON, not TEXT.
*/
SELECT TYPEOF(JSON_EXTRACT('{"name": "Alice", age: 22}', '$.name', '$.age')) AS type;

/*
Notice that SQLite uses the TEXT storage type to store JSON. There is no separate JSON data type.

3) Extracting array elements from JSON data
The following example uses the json_extract() to extract the second array element from a JSON array:
*/
SELECT JSON_EXTRACT('["red","green","blue"]', '$[2]') AS color;

/*
In this example, the JSON path ‘$[2]’ specifies the second element of the top-level array of a JSON document.

4) Extracting nested values from JSON data
The following example uses the json_extract() to extract a nested value from JSON data:
*/
SELECT
  JSON_EXTRACT(
    '{"name": "t-shirt","attributes": {"size": "XL", "colors": ["red","green","blue"]}}',
    '$.attributes.size'
  ) AS size;

/*
In this example, the '$.attributes.size' path specifies the size property of the attributes property of the top-level JSON object in JSON data.

5) Extracting data with a non-existent path
The following example uses the json_extract() function to extract values from a JSON with a path that does not exist ('$.color'):

*/
SELECT
  JSON_EXTRACT(
    '{"name": "t-shirt","attributes": {"size": "XL", "colors": ["red","green","blue"]}}',
    '$.name',
    '$.color'
  ) AS result;

/*
6) Using SQLite json_extract() function with table data
First, create a new table called books to store book data:
*/
DROP TABLE IF EXISTS books;

CREATE TABLE books (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  data TEXT NOT NULL
);

/*
Second, insert rows into the books table:
*/
INSERT INTO books
  (title, data)
VALUES
  (
    'The Catcher in the Rye',
    '{"isbn": "0316769487", "author": {"name": "J.D. Salinger"}}'
  ),
  (
    'To Kill a Mockingbird',
    '{"isbn": "0061120081", "author": {"name": "Harper Lee"}}'
  ),
  ('1984', '{"isbn": "0451524934", "author": {"name": "George Orwell"}}');

/*
Third, retrieve data from the books table:
*/
SELECT
  *
FROM books;

/*
Finally, extract the ISBN and name from the JSON data using the json_extract() data:
*/
SELECT
  title,
  JSON_EXTRACT(data, '$.isbn') AS isbn,
  JSON_EXTRACT(data, '$.author.name') AS author
FROM books;
