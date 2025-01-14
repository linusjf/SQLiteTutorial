/*
SQLite does not have a built-in JSON data type. However, you can use the TEXT data type to store JSON data.

Additionally, SQLite provides various built-in JSON functions and operators to allow you to effectively manipulate JSON data.

For example, the following statement creates a table called products to store the product data:
*/
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  details TEXT NOT NULL
);

/*
In the products table:

id is the primary key column.
name column stores the product names.
details column uses the TEXT data type to store JSON data.
Inserting JSON data into the database
The following INSERT statement inserts JSON data into details columns of the products table:
*/
INSERT INTO
  products (name, details)
VALUES
  (
    'iPhone 13',
    '{"category": "Electronics", "price": 999, "colors": ["Black", "Blue", "White"]}'
  ),
  (
    'Samsung Galaxy S21',
    '{"category": "Electronics", "price": 899, "colors": ["Phantom Black", "Phantom Silver"]}'
  ),
  (
    'Nike Air Force 1',
    '{"category": "Shoes", "price": 100, "colors": ["White", "Black"]}'
  ),
  (
    'Adidas Ultraboost',
    '{"category": "Shoes", "price": 180, "colors": ["Core Black", "Cloud White"]}'
  ),
  (
    'MacBook Pro',
    '{"category": "Electronics", "price": 1299, "colors": ["Silver", "Space Gray"]}'
  ),
  (
    'Amazon Kindle',
    '{"category": "Electronics", "price": 79, "colors": ["Black"]}'
  ),
  (
    'Sony PlayStation 5',
    '{"category": "Electronics", "price": 499, "colors": ["White"]}'
  ),
  (
    'Cuisinart Coffee Maker',
    '{"category": "Home & Kitchen", "price": 99, "colors": ["Stainless Steel", "Black"]}'
  ),
  (
    'Dyson V11 Vacuum Cleaner',
    '{"category": "Home & Kitchen", "price": 599, "colors": ["Iron", "Nickel"]}'
  );

/*
Here’s the contents of the products table:
*/
SELECT
  *
FROM
  products;

/*
To extract a value from JSON data, you use the json_extract() function:

json_extract(json, path)
The json_extract() function extracts a value from JSON data using a specified path. The path locates the value in the JSON data you want to extract.

The following statement uses the json_extract() function to extract the price from JSON data stored in the details column of the products table:
*/
SELECT
  name,
  JSON_EXTRACT(details, '$.price') AS price
FROM
  products;

/*
Using the json_extract() function in the WHERE clause
The following statement retrieves the products with the category 'Electronics'. It compares the value extracted from the JSON data in the details column and compares it with the string 'Electronics':
*/
SELECT
  name
FROM
  products
WHERE
  JSON_EXTRACT(details, '$.category') = 'Electronics';

/*
Inserting a JSON value
To insert a value into a JSON document, you use the json_insert() function:

json_insert(json, path, value)
The json_insert() function inserts the value into the json using the specified path. If the path does not exist, the function creates the element. If the json element already exists, the function does not overwrite.

For example, the following statement inserts the stock attribute with the value 10 into the JSON document with id 1:
*/
UPDATE products
SET
  details = JSON_INSERT(details, '$.stock', 10)
WHERE
  id = 1;

/*
Verify the insert:
*/
SELECT
  *
FROM
  products
WHERE
  id = 1;

/*
Updating a JSON value
To update an existing JSON value, you can use the json_replace() function:

json_replace(json, path, value)
Code language: SQL (Structured Query Language) (sql)
The json_replace() function replaces the value specified by a path in the json data. If the value does not exist, it does not create the value.

For example:
*/
UPDATE products
SET
  details = JSON_REPLACE(details, '$.stock', 0)
WHERE
  id = 1;

/*
Verify the update:
*/
SELECT
  *
FROM
  products
WHERE
  id = 1;

/*
Deleting a JSON value
To remove a json value, you use the json_remove() function:

json_remove(json, path)
Code language: SQL (Structured Query Language) (sql)
For example:
*/
UPDATE products
SET
  details = JSON_REMOVE(details, '$.stock')
WHERE
  id = 1;

/*
Verify the delete:
*/
SELECT
  *
FROM
  products
WHERE
  id = 1;

/*
Aggregating data into a JSON array
To aggregate values into a JSON array, you use the json_group_array() function. For example, the following statement aggregates the product names with the shoe category into a JSON array:
*/
SELECT
  JSON_GROUP_ARRAY(name)
FROM
  products
WHERE
  JSON_EXTRACT(details, '$.category') = 'Shoes';

/*
Aggregating data into a JSON object
To aggregate values into a JSON object, you use the json_group_object() function:

json_group_object(name, value)
For example, the following statement uses the json_group_object to aggregate product names and their ids in the Shoes category into a JSON object:
*/
SELECT
  JSON_GROUP_OBJECT(name, id)
FROM
  products
WHERE
  JSON_EXTRACT(details, '$.category') = 'Shoes';
