/*
Introduction to SQLite CUME_DIST() Function
The CUME_DIST() is a window function that returns the cumulative distribution of a value relative to the values in the group.

Here’s the syntax of the CUME_DIST() function:

CUME_DIST() OVER (
[PARTITION BY partition_expression]
[ORDER BY order_list]
)
In this syntax:

The PARTITION BY clause specifies how the rows are grouped into partitions to which the CUME_DIST() function applies. If you skip the PARTITION BY clause, the function treats the whole result set as a single partition.
The ORDER BY clause specifies the order of rows in each partition to which the CUME_DIST() function applies. If you omit the ORDER BY clause, the function returns 1 for all rows.
Suppose N is the value of the current row of the column specified in the ORDER BY clause and the order of rows is from low to high, the cumulative distribution of a value is calculated using the following formula:

The number of rows with values <= N / The number of rows in the window or partition
The return value of the CUME_DIST() function is greater than 0 and less than or equal to 1:

0 < CUME_DIST() <= 1
The rows with the same values receive the same result.

SQLite CUME_DIST() function example
First, create a new table named products for the demonstration:
*/
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  color TEXT NOT NULL,
  price REAL NOT NULL
);

/*
Second, insert some rows into the products table:
*/
INSERT INTO products
  (name, color, price)
VALUES
  ('A', 'red', 100),
  ('B', 'red', 200),
  ('C', 'red', 200),
  ('D', 'black', 300),
  ('E', 'black', 400),
  ('F', 'white', 500);

/*
Third, query data from the products table:
*/
SELECT
  *
FROM products;

/*
Fourth, calculate the cumulative distribution of the price in the products table:
*/
SELECT
  name,
  CUME_DIST() OVER (ORDER BY price) AS pricecumulativedistribution
FROM products;

/*
Because we skipped the PARTITION BY clause, the function treated the whole result set as a single partition. Therefore, the number of rows to be evaluated is 6.

The following example uses the CUME_DIST() function to calculate the cumulative distribution of prices partitioned by colors:
*/
SELECT
  name,
  color,
  price,
  round(CUME_DIST() OVER (
    PARTITION BY color
    ORDER BY price
  ),2) AS price_cumulative_distribution
FROM products
ORDER BY color;

SELECT
  name,
  color,
  price,
  round(CUME_DIST() OVER (
    ORDER BY price
  ),2) AS price_cumulative_distribution
FROM products
ORDER BY price;
