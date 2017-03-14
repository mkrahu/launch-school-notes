# PostreSQL: Data Definition Syntax

* [Creating, Deleting and Modifying Tables](#Basics)
* [Default Values](#Defaults)
* [Constraints](#Constraints)
* [System Columns](#SystemCols)
* [Schemas](#Schemas)
* [Inheritance](#Inheritance)
* [Partitioning](#Partitioning)

<a name="Basics"></a>
### Table Basics

  * The most common commands used within PosgreSQL for data definition are:
    * `CREATE TABLE`
    * `DROP TABLE`
    * `ALTER TABLE`

#### CREATE TABLE

  * To create a table, you use the `CREATE TABLE` command
  * You need to specify at least a name for the new table, the names of the columns and the data type of each column
  * The column list is comma-separated and surrounded by parentheses

Example:

```psql
CREATE TABLE my_table (
  col_1 text,
  col_2 integer
);
```

  * There is a limit on how many columns a table can contain
    * Depending on column type it is between 250 and 1600, though defining a table with such a high number of columns woudl be highly unusual design


Docs: 

  * https://www.postgresql.org/docs/9.6/static/sql-createtable.html

#### DROP TABLE

  * You can remove a table (and all of its data) from a database using the `DROP TABLE` command

Example:

```psql
DROP TABLE my_table;
```

  * Attempting to drop a table that does not exist will raise an error
  * It is common in SQL script files to drop each table before creating it
  * The `DROP TABLE IF EXISTS` variant can be used with PostgreSQL to avoid the error messages (though this syntax is PostgreSQL-specific and not standard SQL)

Docs: 

  * https://www.postgresql.org/docs/9.6/static/sql-droptable.html

#### ALTER TABLE

  * You can modify the definition or 'structure' of a table using the `ALTER TABLE` command
  * `ALTER TABLE` allows you to:
    * Rename tables
    * Rename columns
    * Add columns
    * Remove columns
    * Change column data types
    * Change default values
    * Add constraints
    * Remove constraints

##### Renaming Tables

  * Renaming a table uses the `RENAME` keyword

```psql
ALTER TABLE items RENAME TO products;
```

##### Renaming Columns

  * Renaming a column uses the `RENAME COLUMN` keyword combination

```psql
ALTER TABLE products RENAME COLUMN prod_no TO product_number;
```

##### Adding Columns

  * Adding a column uses the `ADD COLUMN` keyword combination

```psql
ALTER TABLE products ADD COLUMN description text;
```

  * You need to pass `column_name` and `data_type` to the command
  * The new column is filled with whatever default value is given (or `null` if DEFAULT is not specified)
  * All of the options that can be applied to a column description in CREATE TABLE can be used

##### Removing Columns

  * Removing a column uses the `DROP COLUMN` keyword combination

```psql
ALTER TABLE products DROP COLUMN description;
```

  * You need to pass `column_name` to the command
  * Whatever data was in the column disappears
  * Table constraints involving the column are dropped
  * If the column is referenced by a foreign key constraint of another table, PostgreSQL will not silently drop that constraint
  * You can authorise dropping everything that depends on the column by adding `CASCADE`

```psql
ALTER TABLE products DROP COLUMN description CASCADE;
```

##### Changing a Column's Data Type

  * Changing a column's data type uses the `ALTER COLUMN` keyword combination combined with the `TYPE` keyword

```psql
ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);
```

  * This will succeed only if each existing entry in the column can be converted to the new type by *implicit cast*
  * If a more complex conversion is needed you can add a `USING` clause that specifies how to compute the new values from the old ones
  * PostgreSQL will attempt to convert the column's default value (if one exists) to the new type
  * PostgreSQL will attempt to amend any contraints that involve the column
  * It is often best to drop any constraints on a column before altering its type and then add back suitably modified contraints after

##### Changing Default values and Adding/ Removing constraints

  * This is covered in the relevant 'Default Values' and 'Constraints' sections below
    
Docs: 

  * https://www.postgresql.org/docs/9.6/static/sql-altertable.html
  * https://www.postgresql.org/docs/9.6/static/ddl-alter.html

<a name="Defaults"></a>
### Default Values

  * A column can be assigned a default value
  * When a new row is created and no values are specified for a column, the column will be filled with its default value
    * A data manipulation command can also *explicitly* request that a column be set to its default value (without actually specifying the value)
  * If no default value is declared explicitly, the default value is the NULL value (which can usually be considered to represent *unknown data*)

  * When defining a table, default values are listed after the column data type using the `DEFAULT` keyword

```psql
CREATE TABLE products (
  product_no integer,
  name text,
  price numeric DEFAULT 9.99
);
```

  * The default value can be an expression, which will evaluated whenever the default value is inserted
  * A common example is for a timestamp column to have a default of `CURRENT_TIMESTAMP`, so it gets set to the time of row insertion
  * Another example is generating a 'serial number' for each row

```psql
CREATE TABLE products (
  prod_no integer DEFAULT nextval('products_prod_no_sequence'),
  ...
);
```

  * This is sufficiently common that there is a special shorthand available for it

```psql
CREATE TABLE products (
  prod_no integer SERIAL,
  ...
);
```

  * Using `SERIAL` will create a sequance and set the `nextval()` function for that sequence as the `DEFAULT` for the column

  * To change or remove a column's default value, the `ALTER COLUMN` keyword combination is used together with the `SET DEFAULT` or `DROP DEFAULT` keyword combinations

```psql
ALTER TABLE products ALTER COLUMN price SET DEFAULT 7.77;
```

  * This doesn't affect any existing rows in the table, it changes the default for future `INSERT` commands

```psql
ALTER TABLE products ALTER COLUMN price DROP DEFAULT;
```

  * Dropping a default is effectively the same as setting the default to `NULL`

<a name="Constraints"></a>
### Constraints

  * Data types are one way to limit or control the kind of data that can be stored in a table
  * Sometimes more fine-grained control is required over data that can be entered
  * SQL allows you to define constraints on columns and tables
  * If a user attempts to store data in a column that would violate a constraint, an error is raised
  * Constraints apply even if the value came from the default value definition

  * There are a number of different types of constraints:
    * Check Constraints
    * Not Null Constraints
    * Unique Constraints
    * Exclusion Constraints
    * Primary Keys
    * Foreign Keys

#### CHECK Constraints

  * This is the most generic type of constraint
  * It allows you to specify that a value must satisfy a Boolean expression
  * Check constraints can be specified at table creation using the `CHECK` keyword after the data type, followed by the boolean expression in parentheses

```psql
CREATE TABLE products (
  prod_no integer,
  name text,
  price numeric CHECK (price > 0)
);
```

  * Adding the constraint above will prevent negative numeric values being entered in the `price` column

  * A check constraint can refer to several columns

```psql
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CHECK (price > 0),
    discounted_price numeric CHECK (discounted_price > 0),
    CHECK (price > discounted_price)
);
```

  * The third constraint in the above table definition is not attached to a particular column
  * It appears as a separate item in the comma-separated column list
  * The first two constraints in the above table definition are referred to as 'column constraints' whereas the third is referred to as a 'table constraint'
  * This is true regardless of teh syntax used for the column constraints (i.e. they can be defined  with 'table contraint' style syntax)
  * What identifies a 'column constraint' as such is the fact that the condition only refers to a single column

```psql
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric,
    CHECK (price > 0),
    discounted_price numeric,
    CHECK (discounted_price > 0),
    CHECK (price > discounted_price)
);
```

  * An important thing to note is that a check constraint is satisfied if the check expression evaluates to true **or** `NULL`
    * Since most expressions will evaluate to `NULL` if any operand is `NULL`, they will not prevent `NULL` values in the constrained columns
    * To ensure that a column does not contain `NULL` values, a `NOT NULL` constraint can be used

##### Naming a Check Constraint

  * A constraint can be explicitly named (which can help clarify error messages) by using the `CONSTRAINT` keyword followed by the identifier, followed by the required definition for the constraint itself

```psql
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CONSTRAINT positive_price CHECK (price > 0)
); 
```

  * In the above example the contraint has been named `positive_price` which reflects the nature of the constraint

#### NOT NULL Constraints

  * A NOT NULL constraint simply specifies that a column must not assume the `NULL` value

```psql
CREATE TABLE products (
  prod_no integer NOT NULL,
  name text NOT NULL,
  price numeric
);
```

  * The above use of the `NOT NULL` keyword combination is functionally equivalent to creating a check constraint like so:

```psql
CREATE TABLE products (
  prod_no integer CHECK (prod_no IS NOT NULL),
  name text NOT NULL,
  price numeric
);
```

  * In PostgreSQL, creating an explicit NOT NULL constraint is more efficient than using a CHECK constraint
  * You cannot give explicit names to NOT NULL constraints created in this way

  * A NOT NULL contraint is always written using the column constraint syntax
  * In most database designs, the majority of columns should be marked NOT NULL

  * The NOT NULL constraint has an inverse: the NULL constraint
  * This does not mean that a column **must** be NULL, but simply selects the default behaviour that a column *might* be NULL
  * This is not part of the SQL standard and was added to PostgreSQL to be compatible wtih *some* other database systems

#### UNIQUE Constraints

  * Unique constraints ensure that the data contained in a column, or a group of columns, is unique among all of the rows in a table
  * A unique constraint is created on a sinle column using the `UNIQUE` keyword in the column defintion after the data type

```psql
CREATE TABLE products (
    product_no integer UNIQUE,
    name text,
    price numeric
);
```

  * A unique constraint can be created on a group of columns using the table constraint syntax, where the `UNIQUE` keyword is followed by a comma separated list of columns in parentheses

```psql
CREATE TABLE example (
    col_a integer,
    col_b integer,
    UNIQUE (col_a, col_b)
);
```

  * In the above example, `col_a` can contain non-unique values across rows, as can `col_b`, but `col_a` combined with `col_b` must be unique acros all rows in the table

  * Unique constraints can be explicitly named

```psql
CREATE TABLE example (
  col_a integer CONSTRAINT my_constraint_name UNIQUE
);
```

  * Adding a UNIQUE constraint automatically creates a unique B-tree index on the column or group of columns listed in the constraint
  * A unique constraint is violated if there is more than one row where the values of all of the columns included in the constraint are equal
    * Two null values are never considered equal in this comparison
    * Even all if other columns included in teh constraint are equal if the value of one of the columns on both rows is NULL then the constraint is not violated
    * This conforms to the SQL standard, though some RDBMSes might not follow this standard

#### Exclusion Constraints

  * Exclusion Constraints are created using the `EXCLUDE` clause combined with `index_parameters` and often in combination with `USING` or `WITH` keywords
  * An Exclusion Constraint guarantees that if any two rows are compared on the specified columns or expressions using the specified operators, at least one of these operator comparisons will return `false` or `NULL`
  * Exclusion constraints are implemented using an index, so each specified operator must be associated with an appropriate operator class for the index access method `index_method`
    * As part of the syntax for implementing an exclusion constraint, the `index_method` must be set; if not set it will default to `btree`

```
EXCLUDE [ USING index_method ] ( exclude_element WITH operator [, ... ] ) index_parameters [ WHERE ( predicate ) ]
```
  
Example 1:

```psql
CREATE TABLE example (
  my_col integer,
  EXCLUDE (my_col WITH =)
);
```

  * The above example is functionally equivalent to a UNIQUE constraint on `my_col` except that it uses the exclusion constraint mechanism
  * Since the `index_method` isn't included it defaults to BTree
  * The `(my_col WITH =)` part is effectively saying that `TUP1` conflicts with `TUP2` if `TUP1.my_col = TUP2.my_col`

  * For the above use-case you could simply use a UNIQUE constraint
  * Exclusion Constraints becaome useful when used with other index methods, such as GiST
  * GiST indexes include operator classes for several two-dimensional geometric data types, which support indexed queries using operators such as `&<`, `@>` and `&&`

Example 2:

```psql
CREATE TABLE circles (
  c circle,
  EXCLUDE USING gist (c WITH &&)
);
```

  * The above example uses the GiST index method, which includes the `&&` operator
  * The `&&` operator is specified here on the `c` column by the `WITH` clause
  * The `&&` operator tests for overlaps; i.e. it returns `true` if there is one common point between two shapes (see https://www.postgresql.org/docs/9.6/static/functions-geometry.html)
  * The exclusion constraint in this case then prevents the insertion of two circle values in the `c` column that overlap

  * A common use case for exclusion constraints might be to prevent overlaping bookings of rooms in a reservation system
  * This could be implemented by indexing a `tsrange` data type column with GiST and applying a exclusion constraint to that column using the `&&` operator

  * PostgreSQL Docs: https://www.postgresql.org/docs/9.6/static/sql-createtable.html#SQL-CREATETABLE-EXCLUDE
  * More info: http://thoughts.davisjeff.com/2010/09/25/exclusion-constraints-are-generalized-sql-unique/

#### Primary Keys

  * A primary key constraint indicates that a column (or group of columns) can be used as a unique identifier for rows in a table
  * For this to be the case, the value in the column must be unique to that row in the table and also not NULL
  * Setting a `PRIMARY KEY` constraint constrains a column in the same way as combining a UNIQUE constraint with a NOT NULL constraint

```psql
CREATE TABLE products (
  prod_no integer PRIMARY KEY,
  name text,
  price numeric
);
```

  * The above example constrains the `prod_no` column in the same way as the following one

```psql
CREATE TABLE products (
  prod_no integer UNIQUE NOT NULL,
  name text,
  price numeric
);
```

  * The difference between the two examples is that a table can have only one primary key, but any number of columns can have a combination of UNIQUE and NOT NULL constraints applied to them

  * Primary Keys can span more that one column using the following syntax

```psql
CREATE TABLE example (
    a integer,
    b integer,
    c integer,
    PRIMARY KEY (a, c)
);
```

#### Foreign Keys

  * A foreign key constraint specifies that the values in a column (or a group of columns) must match the values appearing in some row of another table
  * This is referred to as maintaining the *referential integrity* between two related tables

Example:

```psql
CREATE TABLE products (
    prod_no integer PRIMARY KEY,
    name text,
    price numeric
);

CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    prod_no integer REFERENCES products (prod_no),
    quantity integer
);
```

  * In the above example, the fact that orders.prod_no `REFERENCES` products.prod_no means that it is not possible to create a record in the order table with a value in the prod_no column that does not already exist as a value in the prod_no column of the products table

  * If the column name is ommited from the `REFERENCES` clause, then the PRIMARY KEY of the referenced table is automatically used

```psql
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    prod_no integer REFERENCES products,
    quantity integer
);
```

  * The relationship between Primary Key and Foreign Key can be used to maintain the integrity of data in the database
  * This is implemented by using the `ON DELETE` or `ON UPDATE` clause combined with a specified action
  * SQL allows you to implement this in the following ways:
    * `NO ACTION` Produce an error if an attempt is made to delete/ update a referenced product (this is the default)
    * `RESTRICT` Disallow deletion/ updation of a referenced product
    * `CASCADE` When deleting/ updation a referenced product also delete/ update all orders that reference it
    * `SET NULL` Set NULL values in the Foreign Key columns referencing the deleted/ updated product
    * `SET DEFAULT` Set the values in the Foreign Key columns referencing the deleted/ updated product to the default value for the column (there must be a row in the referenced table matching the default value otherwise the operation will fail)

#### Multiple Constraints

  * A column can have more than one constraint
  * Constraints are written one after antoher
  * The order they are given does not matter and does not necessarily determine the order in which they are checked

```psql
CREATE TABLE products (
    prod_no integer NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL CHECK (price > 0)
);
```

#### Deferrable/ Not Deferrable

  * Setting a constraint as `DEFERRABLE` or `NOT DEFERRABLE` controls whether the constraint can be 'deferred'
  * A constraint that is not deferrable will be checked immediately after every command
  * Checking of constraints that *are* deferrable can be postponed to the end of the transaction
  * Currently only UNIQUE, PRIMARY KEY, EXCLUDE and REFERENCES constraints accept the clause
  * If a constraint is deferrable, the `INITIALLY IMMEDIATE` or `INITIALLY DEFERRED` clauses specify the default time to check the constraint
    * INITIALLY IMMEDIATE is checked after each statement (this is the default)
    * INITIALLY DEFERRED  is checked only at teh end of the transaction
    * THE constraint check time can be altered with the `SET CONSTRAINTS` command

#### Adding a Constraint

  * Constraints can be added to existing columns or tables after they have been created
  * To add a constraint, other than for NOT NULL constraints, the table constraint suntax is used

```psql
ALTER TABLE products ADD CHECK (name <> '');
ALTER TABLE products ADD CONSTRAINT some_name UNIQUE (prod_no);
ALTER TABLE products ADD FOREIGN KEY (product_group_id) REFERENCES product_groups;
```
  
  * For NOT NULL constraints, the `ALTER COLUMN` clause must be used

```psql
ALTER TABLE products ALTER COLUMN prod_no SET NOT NULL;
```

#### Removing a Constraint

  * To remove a constraint it needs to be referred to by its name
    * If the constraint has been explicitly named when created this name should be used
    * If not explicitly named, then the system generated name must be used (this can be identified using the `\d tablename` psql meta command)

  * The `ALTER TABLE` command is used combined with the `DROP CONSTRAINT` clause for all constraints except NOT NULL

```psql
ALTER TABLE products DROP CONSTRAINT some_name;
```

  * For NOT NULL constraints the `ALTER COLUMN` clause must be used

```psql
ALTER TABLE products ALTER COLUMN product_no DROP NOT NULL;
```


<a name="SystemCols"></a>
### System Columns

  * Every table has several *system columns* that are implicitly defined by the system
  * The names of the columns cannot therefore be used to name user defined columns
  * Unlike KEYWORDS, quoting the name of a system column cannot escape the restriction on usage
  * Some example system column names are `oid`, `tableoid`, `xmin`, `cmin`, `ctid`

<a name="Schemas"></a>
### Schemas

  * A *database cluster* contains one or more databases
  * A database contains one or more named *schemas*
  * Schemas contain one or more tables
  * Schemas also contain other kinds of named objects, including data types, functions and operators
    * The same object name can be used in different schemas without conflict
  * Unlike databases, schemas are not rigidly separated
    * A user can access objects in any of the schemas in the database they are connected to (assuming they have the provileges to do so)
  * Every new database contains a schema called `public` by default

  * There are several reasons for using schemas:
    * To allow many users to use one database without interfering with each other
    * To organise database object into logical groups in order to make them more manageable
    * Third-party applications can be put into separate schemas so that they do not collide with the names of other objects

  * Schemas are analogous to directories at operating system level, except that they cannot be nested

  * PostgreSQL Docs: https://www.postgresql.org/docs/9.6/static/ddl-schemas.html

<a name="Inheritance"></a>
### Inheritance

  * PostgreSQL implements *table inheritance*, which can be useful for database design
  * Table inheritance can be useful for when you want to quickly query data based on a value that only applies to a certain subset of that data.
  * One example might be retrieving data about an employee from their parking spot reference, you could do this by having a table called `directors` and then another table called `employees` for employees that aren't directors (and therefore aren't allocated a parking spot). By making the the `directors` table inherit from `employees`, you can retrieve data about just directors, just employees that aren't directors or all employees (both directors and non-directors)

```psql
CREATE TABLE employees (
    name text,
    age integer,
    job_title text
);

CREATE TABLE directors (
    parking_spot char(2)
) INHERITS (employees);
```

  * The `directors` table *inherits* all the columns of the parent table (`employees`)
  * Employees who are directors effectively have an extra column for `parking_spot` that isn't required in the `employees` table

  * Imagine we inserted the following data into these two tables

```psql
INSERT INTO employees VALUES ('Karl Lingiah', 42, 'Developer');
INSERT INTO directors VALUES ('Keri Silver', 32, 'CTO', 'D4');
```

  * By default, a query of the `employees` table would return data from both the `employees` and `directors` tables

```psql
SELECT * FROM ONLY directors;
      name    | age | job_title     
--------------+-----+------------
 Karl Lingiah |  42 | Developer
 Keri Silver  |  32 | CTO
(2 rows)
```

  * To explicitly specift that descendant tables are included you can append a `*` to the table name (though this is not required unless the default behaviour has been changed)

```psql
SELECT * FROM employees*;
```

  * If you wanted to return data only about non-director employees, you could use the `ONLY` clause prior to the table name

```psql
SELECT * FROM ONLY employees;
      name    | age | job_title     
--------------+-----+------------
 Karl Lingiah |  42 | Developer
(1 row)
```

  * A query on the `directors` table will act as a normal table query including access the columns inherited from the employees table

```psql
SELECT * FROM employees;
      name    | age | job_title | parking_spot
--------------+-----+-----------+---------------
 Keri Silver  |  32 | CTO       | D4      
(1 row)
```

##### Things to Note

  * A table can inherit from more than one table; in this case it has the union of columns defined by the parent tables
  * Table inheritance is generally established when a child table is created, though it can be added or removed at a later date usinf the `INHERIT` or `NO INHERIT` variants of `ALTER TABLE`
  * A parent table cannot be dropped while any of its children remain
  * Columns or CHECK constraints of a child table cannot be dropped or altered if they are inherited from a parent table
  * `ALTER TABLE` will propogate any changes in column data definitions and CHECK constraints down the inheritance hierarchy

  * Not all SQL commands are able to work on inheritance hierarchies
  * Commands that are used for data querying, data modification or schema modification typically default to including child tables
  * A serious limitation of inheritance is that indexes (and therefore any constraints that rely on indexes, e.g. UNIQUE or EXCLUSION) only apply to single tables, to to children down the inheritance hierarchy

<a name="Partitioning"></a>
### Partitioning

  * PostgreSQL support basic table partitioning
  * Partitioning refers to  splitting what is logically one large table into smaller physical pieces
  * Partitioning can provide several benefits:
    * Query performance can improve dramatically in certain situations (e.g. if the heavily accessed rows of the table are in a single partition)
    * When queries or updates access a large percentage of a single partition, performance can be improved by takeing advantage of sequential scan
    * Bulk loads and deletes can be accomplished by adding or removing partitions
    * Seldom-used data can be migrated to cheaper/ slower storage media
  * The benefits will normally be worthwhile only when a table would otherwise be very large

  * Currently, PostgreSQL supports partitioning via table inheritance
    * Each partition must be created as a child table of a single parent table
    * The parent table itself is normally empty and exists just to represent the entire data set
  * The following forms of partitioning can be implemented in PostgreSQL:
    * Range Partitioning: The table is partitioned into 'ranges' defined by a key column or set of columns, with o overlap between the ranges of values; example might be alphabetically or by date range
    * List Partitioning: The table is partitioned by explicitly listing which key values appear in each partition

