/*
The ROW_NUMBER() is a window function that assigns a sequential integer to each row of a query’s result set. Rows are ordered starting from one based on the order specified by the ORDER BY clause in the window definition.

The following shows the syntax of the ROW_NUMBER() function:

ROW_NUMBER() OVER (
[PARTITION BY expression1, expression2,...]
ORDER BY expression1 [ASC | DESC], expression2,...
)
In this syntax,

First, the PARTITION BY clause divides the rows derived from the FROM clause into partitions. The PARTITION BY clause is optional. If you skip it, the ROW_NUMBER() will treat the whole result set as a single partition.
Then, the ORDER BY clause specifies the order of the rows in each partition. The ORDER BY clause is mandatory because the ROW_NUMBER() function is order sensitive.
Finally, each row in each partition is assigned a sequential integer number called a row number. The row number is reset for each partition.
SQLite ROW_NUMBER() function examples
We will use the customers and invoices tables from the sample database for the demonstration.

We will use the customers and invoices tables from the sample database for the demonstration.

Using SQLite ROW_NUMBER() with ORDER BY clause example
The following statement returns the first name, last name, and country of all customers. In addition, it uses the ROW_NUMBER() function to add a sequential integer to each customer record.
*/
SELECT
  ROW_NUMBER() OVER (ORDER BY country) AS rownum,
  firstname,
  lastname,
  country
FROM customers;

/*
Using the ROW_NUMBER() with PARTITION BY example
The following statement assigns a sequential integer to each customer and resets the number when the country of the customer changes:
*/
SELECT
  ROW_NUMBER() OVER (
    PARTITION BY country
    ORDER BY firstname
  ) AS rownum,
  firstname,
  lastname,
  country
FROM customers;

/*
In this example:

First, the PARTITION BY clause divides the rows in the customers table into partitions by country.
Second, the ORDER BY clause sorts rows in each partition by the first name.
Third, the ROW_NUMBER() function assigns each row in each partition a sequential integer and resets the number when the country changes.
3) Using the ROW_NUMBER() function for pagination
The ROW_NUMBER() function can be useful for pagination. For example, if you want to display customer information on a table by pages with 10 rows per page.

The following statement returns customer data from rows 21 to 30, which is the third page with 10 rows per page:
*/
SELECT
  *
FROM
  (
    SELECT
      ROW_NUMBER() OVER (ORDER BY firstname) AS rownum,
      firstname,
      lastname,
      country
    FROM customers
  ) AS t
WHERE rownum > 20 AND rownum <= 30;

/*
In this example:

First, the ROW_NUMBER() function assigns each row a sequential integer.
Second, the outer query selects the row from 20 to 30.
4) Using the ROW_NUMBER() to find the nth highest value per group
The following statement creates a new view named Sales that consists of customer id, first name, last name, country, and amount. The amount is retrieved from the invoices table:
*/
DROP VIEW IF EXISTS sales;

CREATE VIEW sales AS
  SELECT
    customers.customerid,
    customers.firstname,
    customers.lastname,
    customers.country,
    SUM(invoices.total) AS amount
  FROM
    invoices
    INNER JOIN customers USING (customerid)
  GROUP BY customerid;

/*
The following query returns the data from the Sales view:
*/
SELECT
  *
FROM sales;

/*
The following statement finds the customers who have the highest amounts in each country:
*/
SELECT
  country,
  firstname,
  lastname,
  amount
FROM
  (
    SELECT
      country,
      firstname,
      lastname,
      amount,
      ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY amount DESC
      ) AS rownum
    FROM sales
  )
WHERE rownum = 1;
/*
In the subquery:

First, the PARTITION BY clause divides the customers by country.
Second, the ORDER BY clause sorts the customers in each country by the amount from high to low.
Third, the ROW_NUMBER() assigns each row a sequential integer. It resets the number when the country changes.
The outer query selects the customers that have the RowNum with the value 1.

If you change the row number in the WHERE clause to 2, 3, and so on, you will get the customers who have the second-highest amount, the third-highest amount, etc.
*/
