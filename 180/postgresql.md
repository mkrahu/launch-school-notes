# PostreSQL

  * [Command Line Interface](#CLI)
  * [Meta Commands](#Meta-Commands)
  * [PostgreSQL Documentation](#Docs)
  * [PostgreSQL Data Types](#Data-Types)
  * [Data Definition Syntax](#DDL)
    * Table Basics
    * Default Values
    * Constraints
    * Modifying Tables
    * Additional Topics (Privileges, Schemas, Inheritance, Partitioning)
  * [Data Manipulation Syntax](#DML)
    * Queries
    * Inserting Data
    * Updating Data
    * Deleting Data
  * [Data Control Syntax](#DCL)
    * Client Authentication
    * Database Roles
  * [Functions and Operators](#Functions-Operators)
  * [Indexes](#Indexes)
  * [Additional Topics](#Additional) (Full Text Search, Performance Tips)

<a name="CLI"></a>
## Command Line Interface

  * There are certain PostgreSQL commands you can issue from the command line in order to interact with a PostgreSQL database
  * These command line commands are 'wrappers' around equivalent SQL commands
  * Some of the most commonly used ones are:

### psql

```
$ psql
```
  * This is used to access the PostgreSQL interactive terminal, or 'psql console'
  * The psql console is a terminal-based front-end to PostgreSQL. It allows you to type in queries interactively, issue them to PostgreSQL, and see the query results
  * The `psql` command accepts a number of command line arguments in the following order:

```
psql [option...] [dbname [username]]
```

  * Executed with no arguments, it will access the psql console connected to the default database
  * The most common option is `dbname`. This will access the psql console connected to the database indicated by the argument

```
$ psql -d my_database
```

  * Docs: https://www.postgresql.org/docs/9.6/static/app-psql.html

### createdb

```
$ createdb
```

  * This creates a new PostgreSQL database
  * Normally the database user who executes the command becomes the owner of the new database, though a different owner can be specified via the `-0` option
  * `createdb` is a wrapper around the the SQL command `CREATE DATABASE`
  * `createdb` accepts a number of command line arguments in the following order:

```
createdb [connection-option...] [option...] [dbname [description]]
```

  * The most commonly used is `dbname`

```
$ createdb my_database
```

  * Docs: https://www.postgresql.org/docs/9.6/static/app-createdb.html

### dropdb

  * `dropdb` removes a PostgreSQL database
  * `dropdb` is a wrapper around the the SQL command `DROP DATABASE`

```
$ dropdb
```
  * `dropdb` accepts a number of command line arguments in the following order:

```
dropdb [connection-option...] [option...] dbname
```

  * The most commonly used is `dbname`. This specifies the name of the database to be removed

```
$ dropdb my_database
```

  * Docs: https://www.postgresql.org/docs/9.6/static/app-dropdb.html

### pg_dump

```
$ pg_dump
```

  * `pg_dump` extracts a PostgreSQL database into a script file or other archive file
  * `pg_dump` is a utility for backing up a PostrgreSQL database
  * The `pg_dump` command accepts a number of command line arguments in the following order:

```
pg_dump [connection-option...] [option...] [dbname]
```

  * The most common option is `dbname`. This will access the backup the single database indicated by the argument

```
$ pg_dump my_database
```

  * The `-f file` argument indicates the name of the file to dump the database to

```
$ pg_dump my_database -f my_file.sql
```

  * An alternative to the `-f file` argument is to use the right angled-bracket operator

```
$ pg_dump my_database > my_file.sql
```

  * Docs: https://www.postgresql.org/docs/9.6/static/app-pgdump.html

### pg_restore

  * `pg_restore` restores a PostgreSQL database from an archive file created by `pg_dump`
  * The `pg_restore` command accepts a number of command line arguments in the following order:

```
pg_restore [connection-option...] [option...] [filename]
```

  * The most common option is `filename`. This specifies the location of the archiove file to be restored

```
$ pg_restore my_file.sql
```

  * Docs: https://www.postgresql.org/docs/9.6/static/app-pgrestore.html

### createuser

  * `createuser` defines a new PostgreSQL user account, or more precisely a *role*
  * Only superusers and users with CREATEROLE privilege can create new users
  * `createuser` is a wrapper around the the SQL command `CREATE ROLE`
  * The `createuser` command accepts a number of command line arguments in the following order:

```
createuser [connection-option...] [option...] [username]
```
  
  * The most basic option is `username`

```
$ createuser some_user
```
  
  * The username must be different from all existing roles in this PostgreSQL installation

  * Some other options are:
    * `-d` -- the new user will be allowed to create databases
    * `-g role` -- indicates the role to which this role will be added as a new member
    * `-P` or `--pwprompt` -- `createuser` will prompt for the password of the new user

```
$ createuser -P some_user
Enter password for new role: xyzzy
Enter it again: xyzzy
```

### dropuser

  * `dropuser` removes an existing PostgreSQL user account
  * Only superusers and users with CREATEROLE privilege can remove PostgreSQL users
  * `dropuser` is a wrapper around the the SQL command `DROP ROLE`
  * The `dropuser` command accepts a number of command line arguments in the following order:

```
dropuser [connection-option...] [option...] [username]
```
  
  * The most basic option is `username`

```
$ dropuser some_user
```

### Other Commands

  * There are numerous other command line commands available for PostgreSQL: https://www.postgresql.org/docs/9.6/static/reference-client.html


<a name="Meta-Commands"></a>
## Meta Commands

  * Once in the psql console, as well as issuing SQL commands, there are a number of 'meta commands' available
  * Anything you enter in psql that begins with an unquoted backslash is a psql meta-command that is processed by psql itself.
  * These commands make psql more useful for administration or scripting.
  * Meta-commands are often called slash or backslash commands.
  * Some of the most commonly used meta commands are:

| Command | Description | Example |
|----|----|----|
| `\c $dbname` | Connect to database $dbname. | `\c blog_development` |
| `\d` |  Describe available relations  | |
| `\d $name` |  Describe relation $name |  `\d users` |
| `\?` |  List of console commands and options   | |
| `\h` |  List of available SQL syntax Help topics   | |
| `\h $topic` |   SQL syntax Help on syntax for $topic | `\h INSERT` |
| `\q` |  Quit  | |


  * There are numerous other meta commands available within the psql console: https://www.postgresql.org/docs/current/static/app-psql.html (scroll down to the 'Meta Commands' section)

<a name="Docs"></a>
## PostgreSQL Documentation

  * The PostgreSQL documentation is available at https://www.postgresql.org/docs/
  * You can access the docs for a specific version via the version number, e.g. https://www.postgresql.org/docs/9.6/static/index.html
  * An index of every command for that version is available under the SQL Commands section of the  Reference page: https://www.postgresql.org/docs/9.6/static/sql-commands.html
  * Documentation for a particular command usually includes:
    * Name -- the name of the command and any analogous or equivalent commands, along with a short description of the functionality
    * Synopsis -- this outlines the syntactical structure of the command in terms of its usage; the documentation follows various conventions within the Synopsis
    * Description -- detailed description of the purpose and functionality of the command
    * Parameters -- explanation of any parameters that the command can accept
    * Examples -- some code examples of typical usage

### Synopsis Conventions

  * The synopsis section uses certain conventions when outlining the syntactical usage of a command
    * Square brackets `[` and `]` indicate optional parts
    * A pipe `|` indicates a choice between various options
    * Dots `...` mean that the preceding element can be repeated
    * Curly braces `{` and `}` combined with pipes `|` indicate that you must choose one of the alternatives provided (each alternative is delineated with a `|`)
    * Part of a parameter highlighted in _**bold italics**_ means that further information is available about that part elsewhere in the doc, either elsewhere in the Synopsis, in the 'Parameters' section for that command (listed under the sub-section for that parameter), or sometimes in the 'Description' section

Example:

  * In the Synopsis for the `SELECT` command, the `SELECT` keyword is the only one that is not within square brackets, so is the only part of the command that is not optional
  * The values you wish to select *are* optional, but if you choose to pass a value parameter you must use *either* `*` (for 'all') or *`expression`* (which will be the column name).
    * There are further sub-parameters within this parameter, for example you use an alias `AS`
      * The comma and three dots means you can repeat the preceding element (i.e. the expression -- you can have multiple expressions in the query to select multiple columns)

```
[ * | expression [ [ AS ] output_name ] [, ...] ]
```

  * The `LIMIT` keyword is within brackets, so *is* optional; however, if it is used, it must be used along with either *`count`* or `ALL` (these two options are within braces and separated by a pipe)

```
[ LIMIT { count | ALL } ]
```

  * *`expression`*  is initially explained in item 5 of the 'Description' and further explained in the 'SELECT List' sub-section of the 'Parameters' section
  * *`count`* is explained in the 'LIMIT Clause' sub-section of the 'Parameters' section of the doc 

<a name="Data-Types"></a>
## PostgreSQL Data Types

  * As with most database systems, PostgreSQL supports a large number of [data types](https://www.postgresql.org/docs/9.6/static/datatype.html)
  * Those data types can be broken down into various categories

**PostgreSQL Data Type Categories**

| Category | Overview | Examples Types |
|----|----|----|
| [Numeric](https://www.postgresql.org/docs/9.6/static/datatype-numeric.html) | Numeric types consist of two-, four-, and eight- byte integers, four- and eight- byte floating-point numbers, and selectable precision decimals | `integer`, `real`, `decimal` |
| [Monetary](https://www.postgresql.org/docs/9.6/static/datatype-money.html) | The `money` type stores a currency amount with a fixed fractional precision. The fractional precision is determined by the database's `lc_monetary` setting | `money` |
| [Character](https://www.postgresql.org/docs/9.6/static/datatype-character.html) | Character types are used for storing text. The SQL standard defines two primary character types, `text` is a PostgreSQL-specific type | `varchar(n)`, `char(n)`, `text` |
| [Binary](https://www.postgresql.org/docs/9.6/static/datatype-binary.html) | A binary string is a sequence of octets (or bytes) | `bytea` |
| [Date/Time](https://www.postgresql.org/docs/9.6/static/datatype-datetime.html) | PostgreSQL supports the full set of SQL date and time types. Dates are counted according to the Gregorian calendar | `timestamp`, `date`, `time` |
| [Boolean](https://www.postgresql.org/docs/9.6/static/datatype-boolean.html) | PostgreSQL provides the standard SQL type boolean. The boolean type can have the states `true`, `false` and a third 'unknown' state represented by the SQL `NULL` value | `boolean` |
| [Enumerated](https://www.postgresql.org/docs/9.6/static/datatype-enum.html) | Enumerated (enum) types are data types that comprise a static, ordered set of values. An example of an enum type might be days of the week | Enum types are created using the `CREATE TYPE` command |
| [Geometric](https://www.postgresql.org/docs/9.6/static/datatype-geometric.html) | Geometric data types represent two-dimensional spatial objects | `point`, `line`, `polygon`, `circle` |
| [Network Address](https://www.postgresql.org/docs/9.6/static/datatype.html) | PostgreSQL offers types to store IPv4, IPv6 and MAC addresses. These types offer input error checking and specialised funtions and operators | `cidr`, `inet`, `macaddr` |
| [Bit String](https://www.postgresql.org/docs/9.6/static/datatype-bit.html) | Bit strings are strings of 1s and 0s. They can be used to store visual bit masks | `bit(n)`, `varying(n)` |
| [Text Search](https://www.postgresql.org/docs/9.6/static/datatype-textsearch.html) | PostgreSQL provides two text search data types are designed to support full text search | `tsvector`, `tsquery` |
| [UUID](https://www.postgresql.org/docs/9.6/static/datatype-uuid.html) | This data type stores Universally Unique Identifiers as defined by RFC4122, ISO/IEC9834-8:2005, and related standards (some systems refer to this as a GUID) | `uuid` |
| [XML](https://www.postgresql.org/docs/9.6/static/datatype-xml.html) | Used to store XML data. Its advantage over using a text field is it checks input values for wel-formedness, and there are support functions for type-safe operations | `xml` |
| [JSON](https://www.postgresql.org/docs/9.6/static/datatype-json.html) | Used for storing JSON data, as specified in RFC7159. Its advantage over a `text` field is enforcing that each stored value is valid JSON; there also JSON-specific functions and operators | `string`, `number`, `null` (which is different to `NULL` conceptually) |
| [Arrays](https://www.postgresql.org/docs/9.6/static/arrays.html) | PostgreSQL allows columns of a table to be defined as variable-length multidimensional arrays | An array data type is named by appending square brackets `[]` to the data type name of the array elements, e.g. `integer[]`, `text[][]`, `integer[5]` |
| [Composite Types](https://www.postgresql.org/docs/9.6/static/rowtypes.html) | A composite type represents the structure of a row or record; it is essentially just a list of fieldnames and their data types | The `CREATE TYPE` command is used to create composite data types, with syntax similar to `CREATE TABLE` |
| [Range Types](https://www.postgresql.org/docs/9.6/static/rangetypes.html) | Range types are data types representing a range of values of some element type (called the range's *subtype*); e.g. ranges of timestamp might be used to represent the ranges of time that a meeting room is reserved | `int4range`, `tsrange`, `daterange` |
| [Object Identifier Types](https://www.postgresql.org/docs/9.6/static/datatype-oid.html) | Object identifiers (OIDs) are used internally by PostgreSQL as primary keys for various system tables. OIDs are generaly not added to useer-created tables | |
| [pg_lsn Type](https://www.postgresql.org/docs/9.6/static/datatype-pg-lsn.html) | the `pg_lsn` type can be used to store LSN (Log Sequence Number) data which is a pointer to a location in the XLOG | `pg_lsn` |
| [Pseudo-Types](https://www.postgresql.org/docs/9.6/static/datatype-pseudo.html) | The PostgreSQL type system contains a number of special-purpose entries that are collectively called *pseudo-types*. A pseudo-type cannot be used as a column data type, but it can be used to declare a function's argument or result type | `any`, `cstring`, `record` `trigger` |

  * Some of the most commonly used data types come from the Numeric, Character, Date/ Time and Boolean categories

**Commonly Used Data Types**

| Data Type | Category | Value | Example Values |
|----|----|----|----|
| `varchar(length)` | character |  up to `length` characters of text | `canoe` |
| `text` | character | unlimited length of text | `a long string of text` |
| `integer` | numeric | whole numbers | `42`, `-1423290` |
| `real` | numeric | floating-point numbers | `24.563`, `-14924.3515` |
| `decimal(precision, scale)` | numeric | arbitrary precision numbers  | `123.45`, `-567.89` |
| `timestamp` | date/time | date and time | `1999-01-08 04:05:06` |
| `date` | date/time | only a date | `1999-01-08` |
| `boolean` | boolean | true or false | `true`, `false` |

  * Most data types have a limit to the amount of data they can store. For example an `integer` type can only store values between `-2147483648` and `2147483647`.
  * Other types, such as `varchar` have a limit set by how the column is defined
  * PostgreSQL will return an error if you attempt to store too large a value in a column

### NULL

  * There is a special value in relational databases called `NULL`
  * This represents nothing; that is, the absence of any other value
  * `NULL` behaves differently to the nothing value in other languages
  * When any of the ordinary comparison operators (e.g. `=`, `<`, `>=`, etc) are provided with a `NULL` value on either side, they will return `NULL` rather than `true` or `false` (as wouldbe the case in, say, Ruby or JavaScript)

Example:

```ruby
$ irb
>> nil == nill
=> true
```

```javascript
$ node
> null == null
true
```

```psql
sql-db=# SELECT NULL = NULL;
 ?column?
----------

(1 row)
```

  * When dealing with `NULL` values, always use `IS NULL` or `IS NOT NULL` for comparison

```psql
sql-db=# SELECT NULL IS NULL;
 ?column?
----------
 t
(1 row)

sql-db=# SELECT NULL IS NOT NULL;
 ?column?
----------
 f
(1 row)
```



<a name="DDL"></a>
## Data Definition Syntax

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
  * An Exclusion Constraint guarantees that if any two rows are compared on the specified columns or expressions using the specified operators, 

  * PostgreSQL Docs: https://www.postgresql.org/docs/9.6/static/sql-createtable.html#SQL-CREATETABLE-EXCLUDE
  * More info: http://thoughts.davisjeff.com/2010/09/25/exclusion-constraints-are-generalized-sql-unique/

#### Primary Keys



#### Foreign Keys



#### Multiple Constraints

  * A column can have more than one constraint
  * Constraints are written one after antoher
  * The order they are given does not matter and does not necessarily determine the order in which they are checked

```psql
CREATE TABLE products (
    product_no integer NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL CHECK (price > 0)
);
```

#### Adding a Constraint

  * Constraints can be added to existing columns or tables after they have been created

#### Removing a Constraint

### Additional Topics

#### System Columns

#### Schemas

#### Inheritance

#### Partitioning

#### Dependency Tracking

<a name="DML"></a>
## Data Manipulation Syntax

### Queries



<a name="DCL"></a>
## Data Control Syntax

### Privileges 

  * Privileges are a a combination of DDL and DCL
- https://www.postgresql.org/docs/9.6/static/ddl-priv.html

### Row Security Policies

- https://www.postgresql.org/docs/9.6/static/ddl-rowsecurity.html

<a name="Functions-Operators"></a>
## Functions and Operators

<a name="Indexes"></a>
## Indexes

<a name="Additional"></a>
## Additional Topics (Full Text Search, Performance Tips)
