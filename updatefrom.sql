/*
In SQLite, the UPDATE FROM statement allows you to update data in one table based on data from another table.

The UPDATE FROM statement is often referred to as the UPDATE JOIN because it involves two tables.

Here’s the syntax for the UPDATE FROM statement:

UPDATE target_table
SET
column1 = value1,
column2 = value2
FROM
source_table
[WHERE
condition];
In this syntax:

First, specify the table to update in the UPDATE clause.
Second, set the columns in the target table to the specified values in the SET clause.
Third, specify the second table or a subquery from which the data is retrieved for updating the target table in the FROM clause
Finally, specify a condition in the WHERE clause to filter the rows to be updated.
*/
/*
Let’s explore some examples of using the SQLite UPDATE FROM statement.

1) Using a table in the SQLite UPDATE FROM statement
First, create a table called sales_employees:
*/
DROP TABLE IF EXISTS sales_employees;

CREATE TABLE sales_employees (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  salary REAL NOT NULL
);

/*
Next, create another table called sales_performances:
*/
DROP TABLE IF EXISTS sales_performances;

CREATE TABLE sales_performances (
  sales_employee_id INT PRIMARY KEY,
  score INTEGER NOT NULL CHECK (score BETWEEN 1 AND 5),
  FOREIGN KEY (sales_employee_id) REFERENCES sales_employees (id)
);

/*
Then, insert some rows into these tables:
*/
INSERT INTO
  sales_employees (name, salary)
VALUES
  ('John Doe', 3000.0),
  ('Jane Smith', 3200.0),
  ('Michael Johnson', 2800.0);

INSERT INTO
  sales_performances (sales_employee_id, score)
VALUES
  (1, 3),
  (2, 4),
  (3, 2);

/*
After that, increase the salary of sales employees based on their performance scores:
*/
UPDATE sales_employees
SET
  salary = CASE sales_performances.score
    WHEN 1 THEN salary * 1.02 -- 2% increase for score 1
    WHEN 2 THEN salary * 1.04 -- 4% increase for score 2
    WHEN 3 THEN salary * 1.06 -- 6% increase for score 3
    WHEN 4 THEN salary * 1.08 -- 8% increase for score 4
    WHEN 5 THEN salary * 1.10 -- 10% increase for score 5
  END
FROM
  sales_performances
WHERE
  sales_employees.id = sales_performances.sales_employee_id;

/*Finally, verify the update:*/
SELECT
  *
FROM
  sales_employees;

/*
First, create a table called inventory that stores the inventory:
*/
DROP TABLE IF EXISTS sales;

DROP TABLE IF EXISTS inventory;

CREATE TABLE inventory (
  item_id INTEGER PRIMARY KEY,
  item_name TEXT NOT NULL,
  quantity INTEGER NOT NULL
);

/*
Second, create a table called sales that stores the daily sales data:
*/
CREATE TABLE sales (
  sales_id INTEGER PRIMARY KEY,
  item_id INTEGER,
  quantity_sold INTEGER,
  sales_at timestamp DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (item_id) REFERENCES inventory (item_id)
);

/*
Third, insert rows into the inventory table:
*/
INSERT INTO
  inventory (item_id, item_name, quantity)
VALUES
  (1, 'Item A', 100),
  (2, 'Item B', 150),
  (3, 'Item C', 200);

/*
Fourth, insert rows into the sales table:
*/
INSERT INTO
  sales (item_id, quantity_sold)
VALUES
  (1, 20),
  (1, 30),
  (2, 25),
  (3, 50);

/*
Fifth, update the inventory table based on the aggregated daily sales from the sales table:
*/
UPDATE inventory
SET
  quantity = quantity - daily.qty
FROM
  (
    SELECT
      SUM(quantity_sold) AS qty,
      item_id
    FROM
      sales
    GROUP BY
      item_id
  ) AS daily
WHERE
  inventory.item_id = daily.item_id;

/*
Finally, verify the update by querying data from the inventory table:
*/
SELECT
  *
FROM
  inventory;
