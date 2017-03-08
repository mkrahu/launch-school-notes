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

- https://launchschool.com/lessons/d8c90dd4/assignments/2bb15f32
- https://www.postgresql.org/docs/9.6/static/datatype.html

<a name="DDL"></a>
## Data Definition Syntax

<a name="DML"></a>
## Data Manipulation Syntax

<a name="DCL"></a>
## Data Control Syntax

<a name="Functions-Operators"></a>
## Functions and Operators

<a name="Indexes"></a>
## Indexes

<a name="Additional"></a>
## Additional Topics (Full Text Search, Performance Tips)
