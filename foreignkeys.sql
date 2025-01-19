/*
Let’s start with two tables: suppliers and supplier_groups :
*/
PRAGMA foreign_keys;

PRAGMA foreign_keys = ON;

PRAGMA foreign_keys;

DROP TABLE IF EXISTS suppliers;

DROP TABLE IF EXISTS supplier_groups;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER NOT NULL
);

CREATE TABLE supplier_groups (
  group_id INTEGER PRIMARY KEY,
  group_name TEXT NOT NULL
);

PRAGMA table_info ('suppliers');

PRAGMA foreign_key_list ('suppliers');

/*
Assuming that each supplier belongs to one and only one supplier group. And each supplier group may have zero or many suppliers. The relationship between supplier_groups and suppliers tables is one-to-many. In other words, for each row in the suppliers table, there is a corresponding row in the supplier_groups table.

Currently, there is no way to prevent you from adding a row to the suppliers table without a corresponding row in the supplier_groups table.

In addition, you may remove a row in the supplier_groups table without deleting or updating the corresponding rows in the suppliers table. This may leave orphaned rows in the suppliers table.

To enforce the relationship between rows in the suppliers and supplier_groups table, you use the foreign key constraints.

To add the foreign key constraint to the suppliers table, you change the definition of the  CREATE TABLE statement above as follows:
*/
DROP TABLE IF EXISTS suppliers;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER NOT NULL,
  FOREIGN KEY (group_id) REFERENCES supplier_groups (group_id)
);

PRAGMA table_info ('suppliers');

PRAGMA foreign_key_list ('suppliers');

/*
The supplier_groups table is called a parent table, which is the table that a foreign key references. The suppliers table is known as a child table, which is the table to which the foreign key constraint applies.

The group_id column in the supplier_groups table is called the parent key, which is a column or a set of columns in the parent table that the foreign key constraint references. Typically, the parent key is the primary key of the parent table.

The group_id column in the suppliers table is called the child key. Generally, the child key references to the primary key of the parent table.
*/
/*
First, insert three rows into the supplier_groups table.
*/
INSERT INTO
  supplier_groups (group_name)
VALUES
  ('Domestic'),
  ('Global'),
  ('One-Time');

/*
SQLite Foreign Key - Supplier Groups
Second, insert a new supplier into the suppliers table with the supplier group that exists in the supplier_groups table.
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('HP', 2);

/*
This statement works perfectly fine.

Third, attempt to insert a new supplier into the suppliers table with the supplier group that does not exist in the supplier_groups table.
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('ABC Inc.', 4);

PRAGMA foreign_key_list ('suppliers');

/*
SQLite checked the foreign key constraint, rejected the change, and issued the following error message:
*/
SELECT
  *
FROM
  suppliers;

SELECT
  *
FROM
  supplier_groups;

/*
SQLite foreign key constraint actions
What would happen if you delete a row in the supplier_groups table? Should all the corresponding rows in the suppliers table are also deleted? The same questions to the update operation.

To specify how foreign key constraint behaves whenever the parent key is deleted or updated, you use the ON DELETE or ON UPDATE action as follows:

FOREIGN KEY (foreign_key_columns)
REFERENCES parent_table(parent_key_columns)
ON UPDATE action
ON DELETE action;
SQLite supports the following actions:

SET NULL
SET DEFAULT
RESTRICT
NO ACTION
CASCADE
In practice, the values of the primary key in the parent table do not change therefore the update rules are less important. The more important rule is the DELETE rule that specifies the action when the parent key is deleted.
*/
/*
SET NULL
When the parent key changes, delete or update, the corresponding child keys of all rows in the child table set to NULL.

First, drop and create the table suppliers using the SET NULL action for the group_id foreign key:
*/
DROP TABLE suppliers;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER,
  FOREIGN KEY (group_id) REFERENCES supplier_groups (group_id) ON UPDATE SET NULL ON DELETE SET NULL
);

/*
Second, insert some rows into the suppliers table:
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('XYZ Corp', 3);

INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('ABC Corp', 3);

/*
Third, delete the supplier group id 3 from the supplier_groups table:
*/
DELETE FROM supplier_groups
WHERE
  group_id = 3;

/*
Fourth, query data from the suppliers table.
*/
SELECT
  *
FROM
  suppliers;

/*

SET DEFAULT
The SET DEFAULT action sets the value of the foreign key to the default value specified in the column definition when you create the table.

Because the values in the column group_id defaults to NULL, if you delete a row from the supplier_groups table, the values of the group_id will set to NULL.

After assigning the default value, the foreign key constraint kicks in and carries the check.

RESTRICT
The RESTRICT action does not allow you to change or delete values in the parent key of the parent table.

First, drop and create the suppliers table with the RESTRICT action in the foreign key group_id:
*/
DROP TABLE suppliers;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER,
  FOREIGN KEY (group_id) REFERENCES supplier_groups (group_id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

/*
Second, insert a row into the table suppliers with the group_id 1.
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('XYZ Corp', 1);

/*
Third, delete the supplier group with id 1 from the supplier_groups table:
*/
DELETE FROM supplier_groups
WHERE
  group_id = 1;

/*
SQLite issued the following error:

[SQLITE_CONSTRAINT]  Abort due to constraint violation (FOREIGN KEY constraint failed)
To fix it, you must first delete all rows from the suppliers table which has group_id 1:
*/
DELETE FROM suppliers
WHERE
  group_id = 1;

/*
Then, you can delete the supplier group 1 from the supplier_groups table:
*/
DELETE FROM supplier_groups
WHERE
  group_id = 1;

/*

NO ACTION
The NO ACTION does not mean by-pass the foreign key constraint. It has the similar effect as the RESTRICT.

CASCADE
The CASCADE action propagates the changes from the parent table to the child table when you update or delete the parent key.

First, insert the supplier groups into the supplier_groups table:
*/
INSERT INTO
  supplier_groups (group_name)
VALUES
  ('Domestic'),
  ('Global'),
  ('One-Time');

SELECT
  *
FROM
  supplier_groups;

/*
Second, drop and create the table suppliers with the CASCADE action in the foreign key group_id :
*/
DROP TABLE suppliers;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER,
  FOREIGN KEY (group_id) REFERENCES supplier_groups (group_id) ON UPDATE CASCADE ON DELETE CASCADE
);

/*
Third, insert some suppliers into the table suppliers:
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('XYZ Corp', 3);

INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('ABC Corp', 2);

/*
Fourth, update group_id of the Domestic supplier group to 100:
*/
UPDATE supplier_groups
SET
  group_id = 100
WHERE
  group_name = 'Domestic';

/*
Fifth, query data from the table suppliers:
*/
SELECT
  *
FROM
  suppliers;

/*
you can see the value in the group_id column of the XYZ Corp in the table suppliers changed from 1 to 100 when we updated the group_id in the suplier_groups table. This is the result of ON UPDATE CASCADE action.

Sixth, delete supplier group id 2 from the supplier_groups table:
*/
DELETE FROM supplier_groups
WHERE
  group_id = 2;

/*
Seventh, query data from the table suppliers :
*/
SELECT
  *
FROM
  suppliers;

/*
The supplier id 2 whose group_id is 2 was deleted when the supplier group id 2 was removed from the supplier_groups table. This is the effect of the ON DELETE CASCADE action.
*/
