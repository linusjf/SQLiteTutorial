/*
What is an SQLite trigger
An SQLite trigger is a named database object that is executed automatically when an INSERT, UPDATE or DELETE statement is issued against the associated table.

When do we need SQLite triggers
You often use triggers to enable sophisticated auditing. For example, you want to log the changes in the sensitive data such as salary and address whenever it changes.

In addition, you use triggers to enforce complex business rules centrally at the database level and prevent invalid transactions.

SQLite CREATE TRIGGER statement
To create a new trigger in SQLite, you use the CREATE TRIGGER statement as follows:

CREATE TRIGGER [IF NOT EXISTS] trigger_name 
[BEFORE|AFTER|INSTEAD OF] [INSERT|UPDATE|DELETE] 
ON table_name
[WHEN condition]
BEGIN
statements;
END;
In this syntax:

First,  specify the name of the trigger after the CREATE TRIGGER keywords.
Next, determine when the trigger is fired such as BEFORE, AFTER, or INSTEAD OF. You can create BEFORE and AFTER triggers on a table. However, you can only create an INSTEAD OF trigger on a view.
Then, specify the event that causes the trigger to be invoked such as INSERT, UPDATE, or DELETE.
After that, indicate the table to which the trigger belongs.
Finally, place the trigger logic in the BEGIN END block, which can be any valid SQL statements.
If you combine the time when the trigger is fired and the event that causes the trigger to be fired, you have a total of 9 possibilities:

BEFORE INSERT
AFTER INSERT
BEFORE UPDATE
AFTER UPDATE
BEFORE DELETE
AFTER DELETE
INSTEAD OF INSERT
INSTEAD OF DELETE
INSTEAD OF UPDATE

Suppose you use a UPDATE statement to update 10 rows in a table, the trigger that associated with the table is fired 10 times. This trigger is called FOR EACH ROW trigger. If the trigger associated with the table is fired one time, we call this trigger a FOR EACH STATEMENT trigger.

As of version 3.9.2, SQLite only supports FOR EACH ROW triggers. It has not yet supported the FOR EACH STATEMENT triggers.

If you use a condition in the WHEN clause, the trigger is only invoked when the condition is true. In case you omit the WHEN clause, the trigger is executed for all rows.

Notice that if you drop a table, all associated triggers are also deleted. However, if the trigger references other tables, the trigger is not removed or changed if other tables are removed or updated.

For example, a trigger references to a table named people, you drop the people table or rename it, you need to manually change the definition of the trigger.

You can access the data of the row being inserted, deleted, or updated using the OLD and NEW references in the form: OLD.column_name and NEW.column_name.

the OLD and NEW references are available depending on the event that causes the trigger to be fired.

The following table illustrates the rules.:

Action	Reference
INSERT	NEW is available
UPDATE	Both NEW and OLD are available
DELETE	OLD is available

SQLite triggers examples
Let’s create a new table called leads to store all business leads of the company.
*/
DROP TABLE IF EXISTS leads;

CREATE TABLE leads (
  id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT NOT NULL,
  source TEXT
);

/*
SQLite BEFORE INSERT trigger example
Suppose you want to validate the email address before inserting a new lead into the leads table. In this case, you can use a BEFORE INSERT trigger.

First, create a BEFORE INSERT trigger as follows:
*/
DROP TRIGGER IF EXISTS validate_email_before_insert_leads;

-- noqa:disable=all
CREATE TRIGGER validate_email_before_insert_leads BEFORE INSERT ON leads BEGIN
SELECT
  CASE
    WHEN new.email NOT like '%_@__%.__%' THEN RAISE (ABORT, 'Invalid email address: ' || new.email)
  END;

END;

-- noqa:enable=all
/*
We used the NEW reference to access the email column of the row that is being inserted.

To validate the email, we used the LIKE operator to determine whether the email is valid or not based on the email pattern. If the email is not valid, the RAISE function aborts the insert and issues an error message.

Second, insert a row with an invalid email into the leads table.
*/
INSERT INTO leads
  (first_name, last_name, email, phone)
VALUES
  ('John', 'Doe', 'jjj', '4089009334');

/*
Third, insert a row with a valid email.
*/
INSERT INTO leads
  (first_name, last_name, email, phone)
VALUES
  ('John', 'Doe', 'john.doe@sqlitetutorial.net', '4089009334');

/*
Because the email is valid, the insert statement executed successfully.
*/
SELECT
  first_name,
  last_name,
  email,
  phone
FROM leads;

/*
SQLite AFTER UPDATE trigger example
The phones and emails of the leads are so important that you can’t afford to lose this information. For example, someone accidentally updates the email or phone to the wrong ones or even delete it.

To protect this valuable data, you use a trigger to log all changes which are made to the phone and email.

First, create a new table called lead_logs to store the historical data.
*/
DROP TABLE IF EXISTS lead_logs;

CREATE TABLE lead_logs (
  id INTEGER PRIMARY KEY,
  old_id INT,
  new_id INT,
  old_phone TEXT,
  new_phone TEXT,
  old_email TEXT,
  new_email TEXT,
  user_action TEXT,
  created_at TEXT
);

/*
Second, create an AFTER UPDATE trigger to log data to the lead_logs table whenever there is an update in the email or phone column.
*/
CREATE TRIGGER log_contact_after_update
AFTER UPDATE ON leads
WHEN old.phone != new.phone OR old.email != new.email
BEGIN
  INSERT INTO lead_logs
    (
      old_id,
      new_id,
      old_phone,
      new_phone,
      old_email,
      new_email,
      user_action,
      created_at
    )
  VALUES
    (
      old.id,
      new.id,
      old.phone,
      new.phone,
      old.email,
      new.email,
      'UPDATE',
      DATETIME('NOW')
    );
END;

/*
You notice that in the condition in the WHEN clause specifies that the trigger is invoked only when there is a change in either email or phone column.

Third, update the last name of John from Doe to Smith.
*/
UPDATE leads
SET last_name = 'Smith'
WHERE id = 1;

/*
The trigger log_contact_after_update was not invoked because there was no change in email or phone.

Fourth, update both email and phone of John to the new ones.
*/
UPDATE leads
SET
  phone = '4089998888',
  email = 'john.smith@sqlitetutorial.net'
WHERE id = 1;

/*
If you check the log table, you will see there is a new entry there.
*/
SELECT
  old_phone,
  new_phone,
  old_email,
  new_email,
  user_action
FROM lead_logs;

/*
SQLite TRIGGER After Update Trigger Example
You can develop the AFTER INSERT and AFTER DELETE triggers to log the data in the lead_logs table as an exercise.
*/
/*
SQLite DROP TRIGGER statement
To drop an existing trigger, you use the DROP TRIGGER statement as follows:
DROP TRIGGER [IF EXISTS] trigger_name;

In this syntax:

First, specify the name of the trigger that you want to drop after the DROP TRIGGER keywords.
Second, use the IF EXISTS option to delete the trigger only if it exists.
Note that if you drop a table, SQLite will automatically drop all triggers associated with the table.

For example, to remove the validate_email_before_insert_leads trigger, you use the following statement:
*/
DROP TRIGGER validate_email_before_insert_leads;
