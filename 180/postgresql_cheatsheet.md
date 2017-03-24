# PostgreSQL Cheatsheet

  * [`psql` Terminal Commands](#Terminal)
  * [`psql` Console Meta Commands](#Meta)
  * [PostgreSQL Data Definition](#DDL)
    * [Create a Table](#Create-Table)
    * [Drop a Table](#Drop-Table)
    * [Alter a Table](#Alter-Table)
  * [PostgreSQL Data Manipulation](#DML)
    * [FROM](#From)
    * [Joins](#Joins)
    * [WHERE](#Where)
    * [GROUP BY](#Group-By)
    * [HAVING](#Having)
    * [Sorting](#Sorting)
    * [LIMIT & OFFSET](#Limit-Offset)
    * [Subqueries](#Subqueries)
    * [Inserting Data](#Inserting-Data)
    * [Updating Data](#Updating-Data)
    * [Deleting Data](#Deleting-Data)

<a name="Terminal"></a>
## `psql` Terminal Commands

| Command | Description | Example |
|----|----|----|
| `psql` | Access psql console | n/a |
| `psql -d $dbname` | Access psql console connected to specific database | `psql -d my_database` |
| `createdb $dbname` | Create a new database | `createdb my_database` |
| `dropdb $dbname` | Remove a database | `dropdb my_database` |
| `pg_dump $dbname > $filename` | Creates a file dump of the database | `pg_dump my_database > my_file.sql` |
| `pg_restore $filename` | Restore a database from a dump file | `pg_restore my_file.sql` |

  * Other commands: https://www.postgresql.org/docs/9.6/static/reference-client.html

<a name="Meta"></a>
## `psql` Console Meta Commands

| Command | Description | Example |
|----|----|----|
| `\c $dbname` | Connect to database $dbname. | `\c blog_development` |
| `\d` |  Describe available relations  | |
| `\d $name` |  Describe relation $name |  `\d users` |
| `\?` |  List of console commands and options   | |
| `\h` |  List of available SQL syntax Help topics   | |
| `\h $topic` |   SQL syntax Help on syntax for $topic | `\h INSERT` |
| `\q` |  Quit  | |

<a name="DDL"></a>
## PostgreSQL Data Definition

<a name="Create-Table"></a>
### Create a Table

```psql
CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  email text NOT NULL UNIQUE,
  age integer NOT NULL CONSTRAINT positive_age CHECK (age > 0),
  service_level test NOT NULL DEFAULT 'Basic',
  customer_group_id interger REFERENCES customer_groups(id)
);
```

  * Docs: https://www.postgresql.org/docs/9.6/static/sql-createtable.html

<a name="Drop-Table"></a>
### Drop a Table

```psql
DROP TABLE customers;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/sql-droptable.html

<a name="Alter-Table"></a>
### Alter a Table

#### Add a Column

```psql
ALTER TABLE customers ADD COLUMN gender text;
```

#### Remove a Column

```psql
ALTER TABLE customers DROP COLUMN gender text;
```

#### Add a Constraint

```psql
ALTER TABLE customers ADD CONSTRAINT empty_name_check CHECK (name != ' ');
```

#### Remove a Constraint

```psql
ALTER TABLE customers DROP CONSTRAINT empty_name_check;
```

#### Change Default Value

```psql
ALTER TABLE products ALTER COLUMN price SET DEFAULT 7.77; 
```

#### Change Column Data Type

```psql
ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);
```

#### Rename Columns

```psql
ALTER TABLE products RENAME COLUMN product_no TO product_number;
```

#### Rename Tables

```psql
ALTER TABLE products RENAME TO items;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/ddl-alter.html

<a name="DML"></a>
## PostgreSQL Data Manipulation

### Queries

<a name="From"></a>
#### FROM

```psql
SELECT * FROM table1;
```

```psql
SELECT a, b, c FROM table1;
```

<a name="Joins"></a>
##### JOINS

###### CROSS JOIN

```psql
table1 CROSS JOIN table2;
```

Returns every possible combination of rows from `table1` and `table2`

###### INNER JOIN

```psql
table1 INNER JOIN table2 ON table1.id = table2.table1_id
```

For each row in `table1`, if there is a row in `table2` that matches the join condition for that row, then there is an equivalent row formed in the virtual table created by the join

###### LEFT OUTER JOIN

```psql
table1 LEFT OUTER JOIN table2 ON table1.id = table2.table1_id
```

First an inner join is performed; then, for each row in `table1` that does not satisfy the join condition with any row in `table2`, a joined row is added with NULL values in the columns of `table2`

The joined table always has at least one row for each row in `table1`

###### RIGHT OUTER JOIN

```psql
table1 RIGHT OUTER JOIN table2 ON table1.id = table2.table1_id
```

First an inner join is performed; then, for each row in `table2` that does not satisfy the join condition with any row in `table1`, a joined row is added with NULL values in the columns of `table1`. This is the converse of a LEFT JOIN. 

The result table will always have a row for each row in `table2`

###### FULL OUTER JOIN

```psql
table1 FULL OUTER JOIN table2 ON table1.id = table2.table1_id
```


First an inner join is performed; then, for each row in `table1` that does not satisfy the join condition with any row in `table2`, a joined row is added with NULL values in the columns of `table2`. Also, for each row in `table2` that does not satisfy the join condition with any row in `table1`, a joined row is added with NULL values in the columns of `table1`

This is essentially a combination of a Left JOIN and a RIGHT JOIN

  * Docs: https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-FROM

<a name="Where"></a>
#### WHERE

```psql
SELECT a, b, c FROM table1 WHERE a > 5;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-WHERE

<a name="Group-By"></a>
#### GROUP BY

```psql
SELECT customer_name, sum(order_price)
  FROM orders
  GROUP BY customer_name;
```

<a name="Having"></a>
#### HAVING

```psql
SELECT customer_name, sum(order_price) AS customer_order_total
  FROM orders
  GROUP BY customer_name
  HAVING customer_order_total > 100;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-GROUP

<a name="Sorting"></a>
#### Sorting

```psql
SELECT customer_name, sum(order_price) AS customer_order_total
  FROM orders
  GROUP BY customer_name
  HAVING customer_order_total > 100
  ORDER BY customer_order_total DESC;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/queries-order.html

<a name="Limit-Offset"></a>
#### LIMIT & OFFSET

```psql
SELECT customer_name, sum(order_price) AS customer_order_total
  FROM orders
  GROUP BY customer_name
  HAVING customer_order_total > 100
  ORDER BY customer_order_total DESC
  LIMIT 10;
```

```psql
SELECT customer_name, sum(order_price) AS customer_order_total
  FROM orders
  GROUP BY customer_name
  HAVING customer_order_total > 100
  ORDER BY customer_order_total DESC
  LIMIT 10
  OFFSET 1;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/queries-limit.html

<a name="Subqueries"></a>
#### Subqueries

```psql
SELECT student_name 
  FROM students 
  WHERE id IN (SELECT student_id FROM classes WHERE class_name = 'English');
```

Other Subquery clauses: `NOT IN`, `ANY`/ `SOME`, `ALL`

  * Docs: https://www.postgresql.org/docs/8.1/static/functions-subquery.html

<a name="Inserting-Data"></a>
### Inserting Data

With no column list, values must be stated in correct column order:

```psql
INSERT INTO people VALUES (1, 'Karl', 42);
```

With a column list, values can be stated in any order:

```psql
INSERT INTO people (name, id, age) VALUES ('Karl', 1, 42);
```

With no column list, `DEFAULT` keyword can be used in place of value to apply default for that column:

```psql
INSERT INTO people VALUES (DEFAULT, 'Karl', 42);
```

With a column list, column name can simply be ommited to apply default for any missing columns:

```psql
INSERT INTO people (name, age) VALUES ('Karl', 42);
```

`DEFAULT VALUES` keywords can be used in place of both column list and values to apply default values to all columns in the table:

```psql
INSERT INTO people DEFAULT VALUES;
```

#### Inserting Multiple Rows:

```psql
INSERT INTO people (name, age) VALUES
  ('Karl', 42),
  ('Keri', 27),
  ('Bill', 34);
```

  * Docs: https://www.postgresql.org/docs/9.6/static/dml-insert.html

<a name="Updating-Data"></a>
### Updating Data

Update all rows in a table:

```psql
UPDATE people SET age = 35;
```

Update a subset of rows matching a specified condition:

```psql
UPDATE people SET age = 35 WHERE name = 'Bill';
```

Update a single row matching a specified condition for a unique value:

```psql
UPDATE people SET age = 35 WHERE id = 12;
```

The `SET` clause can refer to existing values:

```psql
UPDATE people SET age = age + 1 WHERE name = 'Bill';
```

Multiple columns can be updated with a single statement:

```psql
UPDATE people SET name = 'Bob', age = 30 WHERE id = 3;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/dml-update.html

<a name="Deleting-Data"></a>
### Deleting Data

Delete one or more rows matching a specified condition:

```psql
DELETE FROM people WHERE name = 'Bill';
```

Delete a single row matching a specified condition for a unique value:

```psql
DELETE people WHERE id = 12;
```

Delete all rows:

```psql
DELETE FROM people;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/dml-delete.html
