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


Docs: https://www.postgresql.org/docs/9.6/static/sql-createtable.html

#### DROP TABLE

  * You can remove a table (and all of its data) from a database using the `DROP TABLE` command

Example:

```psql
DROP TABLE my_table;
```

  * Attempting to drop a table that does not exist will raise an error
  * It is common in SQL script files to drop each table before creating it
  * The `DROP TABLE IF EXISTS` variant can be used with PostgreSQL to avoid the error messages (though this syntax is PostgreSQL-specific and not standard SQL)

#### ALTER TABLE

  * You can modify a table using the `ALTER TABLE` command

### Default Values

### Constraints

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
