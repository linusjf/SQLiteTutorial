/*
SQLite instr() Function

The SQLite instr() function searches a substring in a string and returns an integer that indicates the position of the substring, which is the first character of the substring.

If the substring does not appear in the string, the instr() function returns 0. If either string or substring is NULL, the instr() function returns a NULL value.

Please note that the instr() function also works with the BLOB data type.

Syntax
The following statement shows the syntax of the instr() function:

INSTR(string, substring);
Arguments
The instr() function accepts two arguments:

string

is the input string that instr() function searches for the substring

substring

is the substring that you want to search.

Return Type
Integer

Examples
The following example uses the instr() function to search the string SQLite Tutorial for the substring Tutorial. It returns the position in SQLite Tutorial at which the first occurrence of the Tutorial begins.
*/
SELECT INSTR('SQLite Tutorial', 'Tutorial') AS position;

/*
position
------------
8
The instr() function searches for the substring case-sensitively. For example, the following statement returns the first occurrence of the substring I, not i.
*/
SELECT INSTR('SQLite INSTR', 'I') AS result;

/*
Output:

result
------
8
The following statement uses the instr() function to find employees whose address has the string SW:
*/
SELECT
  lastname,
  firstname,
  address,
  INSTR(address, 'SW') AS position
FROM employees
WHERE position > 0;

/*
It is equivalent to the following statement that uses the LIKE operator:
*/
SELECT
  lastname,
  firstname,
  address
FROM employees
WHERE address LIKE '%SW%';
