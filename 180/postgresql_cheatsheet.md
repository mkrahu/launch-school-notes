# PostgreSQL Cheatsheet

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

## PostgreSQL Data Definition

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

### Drop a Table

```psql
DROP TABLE customers;
```

  * Docs: https://www.postgresql.org/docs/9.6/static/sql-droptable.html

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

#### Change Column Data Type

#### Rename Columns

#### Rename Tables

  * Docs: https://www.postgresql.org/docs/9.6/static/ddl-alter.html

## PostgreSQL Data Manipulation
