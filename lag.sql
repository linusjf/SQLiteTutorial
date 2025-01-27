/*
SQLite LAG() function is a window function that allows you to obtain the data of the preceding row at the given physical offset from the current row in the partition.

The following shows the syntax of the LAG() function:

LAG(expression [,offset[, default ]]) OVER (
PARTITION BY expression1, expression2,...
ORDER BY expression1 [ASC | DESC], expression2,...
)
In this syntax:

expression
It is an expression that is evaluated against the value of the preceding row based on the specified offset. The expression must return a single value.

offset
Offset is the number of rows from the current row to obtain the value. The default value of the offset is 1 if you don’t specify it explicitly.

default
It is the default value to return if the expression at offset is NULL. If you skip the default, then the LAG() function will return NULL if the expression evaluates to NULL.

PARTITION BY clause
The PARTITION BY clause divides the rows of the result set into partitions to which the LAG() function applies. If you don’t specify the PARTITION BY clause explicitly, the LAG() function will treat the whole result set as a single partition.

ORDER BY clause
The ORDER BY clause sorts the rows of each partition to which the LAG() function applies.

The LAG() function is often used to calculate the difference between the values of the current row and the preceding row at a given offset.

*/
/*

SQLite LAG() function examples
We will use the CustomerInvoices view created in the LEAD() function tutorial for the demonstration.
*/
DROP VIEW IF EXISTS customerinvoices;

CREATE VIEW customerinvoices AS
  SELECT
    customerid,
    STRFTIME('%Y', invoicedate) AS year,
    SUM(total) AS total
  FROM invoices
  GROUP BY customerid, STRFTIME('%Y', invoicedate);

/*
The following query returns data from the CustomerInvoices view:
*/
SELECT
  *
FROM customerinvoices
ORDER BY customerid, year, total;

/*
Using SQLite LAG() function over the result set example
The following query uses the LAG() function to return the difference in invoice amounts for the customer Id 4 over the subsequent years:
*/
SELECT
  customerid,
  year,
  total,
  LAG(total, 1, 0) OVER (ORDER BY year) AS previousyeartotal
FROM customerinvoices
WHERE customerid = 4;

/*
In this example:

First, we skipped the PARTITION BY clause so the LAG() function treated the whole result set as a single partition.
Second, because there is no preceding value available for the first row, the LAG() function returned the default value of zero.
*/
SELECT
  customerid,
  year,
  total,
  LAG(total, 1, 0) OVER (
    PARTITION BY customerid
    ORDER BY year
  ) AS previousyeartotal
FROM customerinvoices;
/*
In this example:

First, the PARTITION BY clause divided the rows in the result set by customer Id into partitions.
Second, the ORDER BY clause specified in the OVER clause specified the order of the rows in each partition by year before the LAG() function was applied.
The LAG() function is applied to each partition separately and the calculation was restarted for each partition.

*/
