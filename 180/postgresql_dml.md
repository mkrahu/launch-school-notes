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

  * The select list specification `*` represents *all columns* in the table represented by the table expression
  * `table1` is the table expression
  * This query would retrieve all rows all user-defined columns for `table1`

  * You can omit the TABLE clause completely and simply use the SELECT command as a calculator

```psql
SELECT 3 * 4;
SELECT ramdom();
```

#### Table Expressions

  * A *table expression* computes a table
  * The expression contains a `FROM` clause optionally followed by `WHERE`, `GROUP BY` and `HAVING` clauses
  * The optional `WHERE`, `GROUP BY` and `HAVING` clauses specify a pipeline of successive transformations performed on the table derived in the `FROM` clause
    * All of these transformations produce a virtual table
    * The rows of the virtual table are passed to the select list to compute the output rows of the query

##### The FROM Clause

  * The `FROM` clause derives a table from one or more other tables

```
FROM table_reference [, table_reference [, ...]]
```
  
  * A `table_reference` can be a table name or a derived table, such as a sub-query, a JOIN construct or a combination of these
  * If more than one table reference is listed in the `FROM` clause, in a comma-separated fashion with no JOIN type specified, then the tables are cross-joined

  * The result of the `FROM` clause is an intermediate virtual table that can then be subject to transformations by the `WHERE`, `GROUP BY` and `HAVING` clauses

###### Joined Tables

  * A joined table is a table derived from two other (real or derived) tables
  * Tables are joined according to the rules of the specified join type
  * Inner, outer and cross joins are available join types
  * General syntax of a joined table is:

```
table_1_name join_type table_2_name [join_condition]
```

  * `JOIN` clauses can be chained, or nested
  * `JOIN` clauses nest left-to-right
  * Parentheses can be used around `JOIN` clauses to circumvent the default nesting order

**Cross Joins**

  * For every possible combination of rows from both tables a cross join can be used
  * This is known as a Cartesian product

```
table_1_name CROSS JOIN table_2_name
```

**Qualified Joins**

  * Join types other than `CROSS JOIN` are known as *qualified joins* 
    * A qualified join requires a *join condition* which is specified using the `ON` or `USING` clause (or implicitly by the keyword `NATURAL`)
    * The join condition determineswhich rows from the two source tables are considered to 'match'
  * The general syntax for qualified joins is as follows:

```
T1 { [INNER] | { LEFT | RIGHT | FULL } [OUTER] } JOIN T2 ON boolean_expression
T1 { [INNER] | { LEFT | RIGHT | FULL } [OUTER] } JOIN T2 USING ( join column list )
T1 NATURAL { [INNER] | { LEFT | RIGHT | FULL } [OUTER] } JOIN T2
```

**_Inner Join_**

  * 



##### The WHERE Clause

##### The GROUP BY and HAVING Clauses

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