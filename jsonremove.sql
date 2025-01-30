/*
In SQLite, the json_remove() function replaces values in JSON data at specified paths.

Here’s the syntax of the json_remove() function:

json_remove(json_data, path1, path2, ...)
In this syntax:

json_data is the JSON data from which you want to remove values.
path1, path2, … are the paths that specify elements you want to delete.
The json_remove() function returns the JSON data with the values at the specified path removed. If a path does not exist, the json_remove() function silently ignores it.

First, create a table called products:
*/
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  info TEXT NOT NULL
);

/*
Second, insert JSON data that contains the product details into the info column of the products table:
*/
INSERT INTO products
  (info)
VALUES
  (
    '{
  "name": "T-Shirt",
  "color": "Black",
  "size": [
    "S",
    "M",
    "L",
    "XL"
  ],
  "price": 19.99,
  "discount": {
    "percentage": 10,
    "expiry_date": "2024-05-31"
  }, 
  "material": "100% Cotton",
  "care_instructions": [
    "Machine wash cold",
    "Tumble dry low",
    "Do not bleach",
    "Iron low heat"
  ]
}'
  );

/*
Third, delete the material property of the JSON data using the json_remove() function:
*/
UPDATE products
SET info = JSON_REMOVE(info, '$.material')
WHERE id = 1;

/*
Verify the delete:
*/
SELECT info ->> 'material' AS material
FROM products
WHERE id = 1;

/*
The output indicates that the statement successfully deleted the material property.

Fourth, delete the color and price properties of the JSON data using the json_remove() function:
*/
UPDATE products
SET info = JSON_REMOVE(info, '$.color', '$.price')
WHERE id = 1;

/*
Verify the delete:
*/
SELECT
  info ->> 'color' AS color,
  info ->> 'price' AS price
FROM products
WHERE id = 1;
