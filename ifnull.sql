/*
The SQLite IFNULL function accepts two arguments and returns the first non-NULL argument. If both arguments are NULL, the IFNULL function returns NULL.

Syntax
The following illustrates the syntax of the IFNULL function.

IFNULL(parameter_1,parameter_2);
Arguments
The IFNULL function has exactly two arguments.

The IFNULL function is equivalent to the COALESCE function with two arguments. Note that the COALESCE function can have more than two arguments.

Return type
The IFNULL function returns the type of the argument or NULL.

Examples
See the following customers table in the sample database.

The following query returns the first name, last name, fax, and phone data of the customers.
*/
SELECT
  firstname,
  lastname,
  fax,
  phone
FROM customers;

/*
Many customers do not have the fax number; in this case, we can use the IFNULL function to return the fax number if it is available or return the phone number if the fax is not available.
*/
-- noqa:disable=L060
SELECT
  firstname,
  lastname,
  IFNULL(fax, 'Call:' || phone) AS fax
FROM customers
ORDER BY firstname;
