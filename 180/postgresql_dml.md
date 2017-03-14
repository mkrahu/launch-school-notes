# PostreSQL: Data Manipulation Syntax

* [Queries](#Queries)
  * Table Expressions
  * Select Lists
  * Combining Queries
  * Sorting Rows
  * LIMIT and OFFSET
  * Additional Topics
* [Inserting Data](#Inserting)
* [Updating Data](#Updating)
* [Deleting Data](#Deleting)

<a name="Queries"></a>
### Queries
  
  * The process of retrieving or the command to retrieve data from a table is called a *query*
  * IN SQL the `SELECT` command is used to specify queries
  * The general syntax of the `SELECT` command is:

```psql
[WITH with_queries] SELECT select_list FROM table_expression [sort_specification]
```
  
  * The select list, table expression and sort specificationa are the most commonly used features of a `SELECT` query
  * `WITH` queries are an advanced, and less frequently used, feature

  * A simple query might take the form

```psql
SELECT * FROM table1;
```

  * The `*` operator is the select list, and represents *all columns* in the table
  * `table1` is the table expression
  * This query would retrieve all rows all user-defined columns for `table1`

#### Table Expressions

#### Select Lists

#### Combining Queries

#### Sorting Rows

#### LIMIT and OFFSET

#### Additional Topics

##### VALUES Lists

##### WITH Queries

<a name="Inserting"></a>
### Inserting Data

<a name="Updating"></a>
### Updating Data

<a name="Deleting"></a>
### Deleting Data