/*
The SQLite NULLIF function accepts two arguments and returns a NULL value if they are equal.

If the first argument is not equal to the second one, the NULLIF function returns the first argument. In case both arguments are NULL, the NULLIF function returns a NULL value.

Syntax
The following illustrates the syntax of the NULLIF function:

NULLIF(parameter_1,parameter_2);
Logically, the NULLIF function is equivalent to the CASE expression:

CASE WHEN parameter_1 = parameter_2 THEN  NULL ELSE expr1 END
Arguments
The NULLIF function accepts exactly two arguments.

Return Type
The NULLIF function returns a value with the type of the first argument or NULL.

Examples
We often use the NULLIF function when the database contains “special” values such as zero or empty string that we want to handle them as NULL values. This is very useful when we use the aggregate functions such as AVG, MAX, MIN, SUM, and COUNT.

Let’s take a look at the following example.

First, create a new products table that consists of three columns: name, price, and discount.
*/
DROP TABLE IF EXISTS products;

CREATE TABLE IF NOT EXISTS products (
  name TEXT NOT NULL,
  price NUMERIC NOT NULL,
  discount NUMERIC DEFAULT 0,
  CHECK (price >= 0 AND discount >= 0 AND price > discount)
);

/*
Second, insert some sample data into the products table.
*/
INSERT INTO products
  (name, price, discount)
VALUES
  ('Apple iPhone', 700, 0),
  ('Samsung Galaxy', 600, 10),
  ('Google Nexus', 399, 20);

/*
Third, to count the number of products that have discount, we use the NULLIF function as follows:
*/
SELECT COUNT(NULLIF(discount, 0)) AS discount_products
FROM products;

/*
It is equivalent to the following query:
*/
SELECT COUNT(*)
FROM products
WHERE discount > 0;

/*
Or you can use the CASE expression instead:
*/
SELECT
  COUNT(
    CASE
      WHEN discount = 0 THEN NULL
      ELSE 1
    END
  )
FROM products;
