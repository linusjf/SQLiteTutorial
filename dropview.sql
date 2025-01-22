/*
The DROP VIEW statement deletes a view from the database schema. Here is the basic syntax of the DROP VIEW statement:

DROP VIEW [IF EXISTS] [schema_name.]view_name;
In this syntax:

First, specify the name of the view that you wants to remove after the DROP VIEW keywords.
Second, specify the schema of the view that you want to delete.
Third, use the IF EXISTS option to remove a view only if it exists. If the view does not exist, the DROP VIEW IF EXISTS statement does nothing. However, trying to drop a non-existing view without the IF EXISTS option will result in an error.
Note that the DROP VIEW statement only removes the view object from the database schema. It does not remove the data of the base tables.

SQLite DROP VIEW statement examples
This statement creates a view that summarizes data from the invoices and invoice_items in the sample database:
*/
CREATE VIEW v_billings (invoiceid, invoicedate, total) AS
  SELECT
    invoices.invoiceid,
    invoices.invoicedate,
    SUM(invoice_items.unit_price * invoice_items.quantity) AS total
  FROM
    invoices
    INNER JOIN invoice_items USING (invoice_id);

/*
To delete the v_billings view, you use the following DROP VIEW statement:
*/
DROP VIEW v_billings;

/*
This example uses the IF EXISTS option to delete a non-existing view:
*/
DROP VIEW IF EXISTS v_xyz;

/*
It does not return any error. However, if you don’t use the IF EXISTS option like the following example, you will get an error:
*/
DROP VIEW v_xyz;
