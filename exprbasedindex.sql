/*
Introduction to the SQLite expression-based index
When you create an index, you often use one or more columns in a table. Besides the normal indexes, SQLite allows you to form an index based on expressions involved table columns. This kind of index is called an expression based index.

The following query selects the customers whose the length of the company is greater than 10 characters.
*/
SELECT
  customerid,
  company
FROM customers
WHERE LENGTH(company) > 10
ORDER BY LENGTH(company) DESC;

/*
If you use the EXPLAIN QUERY PLAN statement, you will find that SQLite query planner had to scan the whole customers table to return the result set.
*/
-- noqa:disable=all
EXPLAIN QUERY PLAN
  SELECT
    customerid,
    company
  FROM customers
  WHERE LENGTH(company) > 10
  ORDER BY LENGTH(company) DESC;

-- noqa:enable=all
/*
The SQLite query planner is a software component that determines the best algorithm or query plan to execute an SQL statement. As of SQLite version 3.8.0, the query planner component was rewritten to run faster and generate better query plans. The rewrite is known as the next generation query planner or NGQP.

To create an index based on the expression LENGTH(company), you use the following statement.
*/
CREATE INDEX customers_length_company ON customers (LENGTH(company));

/*
Now if you execute the query above again, SQLite will use the expression index to search to select the data, which is faster.
*/
-- noqa:disable=all
EXPLAIN QUERY PLAN
  SELECT
    customerid,
    company
  FROM customers
  WHERE LENGTH(company) > 10
  ORDER BY LENGTH(company) DESC;

-- noqa:enable=all
DROP INDEX IF EXISTS customers_length_company;

/*
The SQLite query planner uses the expression-based index only when the expression, which you specified in the CREATE INDEX statement, appears the same as in the WHERE clause or ORDER BY clause.

For example, in the sample database, we have the invoice_items table.

The following statement creates an index using the unit price and quantity columns.
*/
CREATE INDEX invoice_line_amount ON invoice_items (unitprice * quantity);

/*
However, when you run the following query:
*/
-- noqa:disable=all
EXPLAIN QUERY PLAN
  SELECT
    invoicelineid,
    invoiceid,
    unitprice * quantity
  FROM invoice_items
  WHERE quantity * unitprice > 10;

-- noqa:enable=all
/*
The SQLite query planner did not use the index because the expression in the CREATE INDEX ( unitprice*quantity) is not the same as the one in the WHERE clause (quantity*unitprice)
*/
-- noqa:disable=all
EXPLAIN QUERY PLAN
  SELECT
    invoicelineid,
    invoiceid,
    unitprice * quantity
  FROM invoice_items
  WHERE unitprice * quantity > 10;
-- noqa:enable=all
/*
SQLite expression based index restriction
The following lists all the restrictions on the expression that appears in the CREATE INDEX statement.

The expression must refer to the columns of the table that is being indexed only. It cannot refer to the columns of other tables.
The expression can only use the deterministic function call.
The expression cannot use a subquery.
*/
