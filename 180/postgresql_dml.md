# PostreSQL: Data Manipulation Syntax

* [Queries](#Queries)
  * Table Expressions
  * Select Lists
  * Combining Queries
  * Sorting Rows
  * LIMIT and OFFSET
  * Subqueries
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

  * **Note:** the words `INNER` and `OUTER` are optional in all forms
    * `INNER` is the default
    * `LEFT`, `RIGHT` and `FULL` imply an outer join

**_Inner Join_**

  * For each row in 'Table One', if there is a row in 'Table Two' that matches the join condition for that row, then there is an equivalent row formed in the virtual table created by the join

**_Left Outer Join_**

  * First an inner join is performed
  * Then, for each row in 'Table One' that does not satisfy the join condition with any row in 'Table Two', a joined row is added with NULL values in the columns of 'Table Two'
  * The joined table always has at least one row for each row in 'Table One'

**_Right Outer Join_**

  * First an inner join is performed
  * Then, for each row in 'Table Two' that does not satisfy the join condition with any row in 'Table One', a joined row is added with NULL values in the columns of 'Table One'
  * This is the converse of a LEFT JOIN
  * The result table will always have a row for each row in 'Table Two'

**_Full Outer Join_**

  * First an inner join is performed
  * Then, for each row in 'Table One' that does not satisfy the join condition with any row in 'Table Two', a joined row is added with NULL values in the columns of 'Table Two'
  * Also, for each row in 'Table Two' that does not satisfy the join condition with any row in 'Table One', a joined row is added with NULL values in the columns of 'Table One'
  * This is essentially a combination of a Left JOIN and a RIGHT JOIN


**`ON`, `USING` and `NATURAL`**

  * The `ON` clause is the most general kind of condition
    * `ON` takes a boolean value expression in the same way as `WHERE`, e.g. T1.pk_col = T2.fk_col
    * A pair of rows from T1 and T2 match if the `ON` expression evaluates to true

  * The `USING` clause is shorthand used in the specific situation where the column names are identical for the matching columns in both tables; e.g. `ON T1.col_a = T2.col_a` is equivalent to `USING (col_a)`
  * `USING` takes a comma-separated column list in parentheses as an argument and so is especially useful when matching on multiple columns; e.g. `ON T1.a = T2.a AND T1.b = T2.b.` is equivalent to `USING (a, b)`
  * `USING` supresses redundant columns in the result table
    * `JOIN ON` produces all columns from T1 followed by all columns from T2
    * `JOIN USING` produces one output column for each matching column pair (in listed order) followed by remaining T1 columns and then remaining T2 columns

  * `NATURAL` is a shorthand form of `USING`. 
  * It forms a `USING` list consisting of all column names that appear in both tables
  * If there are no common column names, `NATURAL` behaves like `CROSS JOIN`


###### Table Aliases

  * A temporary name can be given to a table reference and used to refer to the table in the rest of the query.
  * This is called a *table alias*
  * The alias becomes the new name of the table for the remainder of the query
    * Once aliased, you cannot refer to the table by its original name elsewhere in the query
  * It is typical to assign short identifiers to long table names; e.g. in order to keep JOIN clauses more readable
  * Table aliases can be written with or without an `AS` clause

```
FROM table_reference AS alias
```

or

```
FROM table_reference alias
```

##### The WHERE Clause

  * The purpose of the `WHERE` clause is to limit the result table derived from the `FROM` clause to just the rows that meet a certain search condition
  * The search condition is boolean expression
  * After the processing of `FROM` is done, each row of the virtual result table is checked against the search condition
    * If the result is true, the row is kept
    * If the result is false or NULL, the row is discarded
  * The search condition typically references at least one column of the table generated in the FROM clause
  * The syntax for the `WHERE` clause is as follows:

```
WHERE search_condition
```

Example:

```psql
SELECT * FROM table_1 WHERE col_a > 5;
```

##### The GROUP BY and HAVING Clauses

**`GROUP BY`**

  * The `GROUP BY` clause is used for aggregation of the result table derived from the `FROM` clause
  * It groups rows in a table where the rows have the same values in the column(s) listed
  * By grouping you can eliminate redundancy in the output and/ or calculate aggregate values by grouping
  * You can group by more than one column
  * The syntax for the `GROUP BY` clause is as follows:

```
SELECT select_list
    FROM ...
    [WHERE ...]
    GROUP BY grouping_column_reference [, grouping_column_reference]...
```

Examples:

With no grouping:

```psql
SELECT * FROM test1;
 x | y
---+---
 a | 3
 c | 2
 b | 5
 a | 1
(4 rows)
```

With grouping but no aggregation:

```psql
SELECT x FROM test1 GROUP BY x;
 x
---
 a
 b
 c
(3 rows)
```

  * In general, if a table is grouped, columns that are not listed in `GROUP BY` cannot be referenced except in aggregate expressions
  * You therefore couldn't have `SELECT x, y FROM test1 GROUP BY x;`
  * **Note:** if a query contains an aggregate function call but not `GROUP BY` clause then aggregation still occurs but the result table is a single group row

With grouping and aggregation:

```psql
SELECT x, sum(y) FROM test1 GROUP BY x;
 x | sum
---+-----
 a |   4
 b |   5
 c |   2
(3 rows)
```

  * In this example `y` can be referenced even though it is not in the `GROUP BY ` clause since it is referenced using an aggregate function `sum()`

  * List of aggregate functions: https://www.postgresql.org/docs/9.6/static/functions-aggregate.html

**`HAVING`**

  * Using `HAVING` clause on a grouped result table is the equivalent of using the `WHERE` clause on a non-grouped table
  * Like the `WHERE` clause it eliminates rows from the result table, only in this case the rows represent entire groupings
  * Again like the `WHERE` clause it takes a boolean expression as an argument
  * The syntax for `HAVING` is as follows:

```
SELECT select_list FROM ... GROUP BY ... HAVING boolean_expression
```

  * Expressions in the `HAVING` clause can refer both to grouped and ungrouped expressions

Examples:

`HAVING` referring to a grouped expression:

```psql
SELECT x, sum(y) FROM test1 GROUP BY x HAVING sum(y) > 3;
 x | sum
---+-----
 a |   4
 b |   5
(2 rows)
```

`HAVING` referring to an ungrouped expression:

```psql
SELECT x, sum(y) FROM test1 GROUP BY x HAVING x < 'c';
 x | sum
---+-----
 a |   4
 b |   5
(2 rows)
```

#### Select Lists

  * The table expression in the `SELECT` command constructs an intermediate virtual table by doing one or more of the following: combining tables (`JOIN`), eliminating rows (`WHERE`), grouping (`GROUP BY`), etc.
  * Once these actions have taken effect, the table is passed on for processing by the *select list*
  * The select list determines which **columns** of the intermediate table are actually output

##### Select List Items

  * The simplest form of select list is `*`
  * This outputs *all* columns that the table expression produces
  * To output a *subset* of all the returned columns, a comma separated list of value expressions is used
  * Value expressions are generally column names

Example:

```psql
SELECT a, b, c FROM ...
```

  * If more than one table in a multi-table query has columns of the same name, then the table name must also be given

```psql
SELECT tbl1.a, tbl2.a, tbl1.b FROM ...
```

##### Column Labels

  * The entries in a select list can be assigned aliases using the `AS` clause
  * This is done either for subsequent processing (such as for use in an `ORDER BY` clause) or for display purposes (the aliased name is what is seen in the output table)
  * Column labels can be particularly useful when querying multiple tables which contain columns of the same name (such as `id`)
  * The syntax for column labelling is as follows:

```
SELECT a AS some_name FROM ...
```

  * Column labelling is also useful when combining values from multiple columns in a select list

```
SELECT a AS some_name, b + c AS sum_bc FROM ...
```
  
  * `AS` is optional, but there are things to be aware of when ommiting it
  * If you omit `AS` and want to use a reserved keyword as a column label you can double quote it

```
SELECT a "value" FROM ...
```

##### `DISTINCT`

  * The `DISTINCT` clause can be used to eliminate duplicate rows
  * If used, it comes into effect after the select list has been processed
  * The `DISTINCT` keyword is written directly after `SELECT` to specify this

```
SELECT DISTINCT select_list ...
```

  * Two rows are considered distinct if they differ in at least one column value; NULL values are considered equal in this comparison

  * The opposite of `DISTINCT` is `ALL`, which is the default behaviour


#### Combining Queries

  * The results of two queries can be combined in various ways such as union, intersection and difference
  * This kind of combination is effectively adding the result **rows** from one query to the result rows from another query (this is very different from JOIN, which is combining the *columns* of multiple tables)
  * In order to combine queries in this way, the queries must be 'union compatible'
    * This means that they return the same number of columns and the corresponding columns have compatible data types
  * The syntax is as follows:

```
query1 UNION [ALL] query2
query1 INTERSECT [ALL] query2
query1 EXCEPT [ALL] query2
```

  * `UNION` appends the result of query1 to the result of query2
    * There is no guarantee of the order that the rows are returned in
    * `UNION` eliminates duplicate rows from its result (in the same way as `DISTINCT`), unless `UNION ALL` is used

  * `INTERSECT` returns all rows that are both in the result of query1 and query2
    * Duplicate rows are eliminated unless `INTERSECT ALL` is used

  * `EXCEPT` returns all rows that are in the result of query1 but not in the result of query2 (this is sometimes referred to as the *difference* between the two queries)
    * Duplicates are eliminated unless `EXCEPT ALL` is used

  * Combination operations can be nested or chained

```
query1 UNION query2 UNION query3
```

which is executed as

```
(query1 UNION query2) UNION query3
```

#### Sorting Rows

  * Sorting determines the order in which the rows of the output table appear
  * Sorting is carried out after the output table has been processed by the select list
  * If sorting is not chosen, the rows will be returned in an unspecified order
  * The sort order is specified using the `SORT BY` clause, the syntax for which is as follows:

```
SELECT select_list
    FROM table_expression
    ORDER BY sort_expression1 [ASC | DESC] [NULLS { FIRST | LAST }]
             [, sort_expression2 [ASC | DESC] [NULLS { FIRST | LAST }] ...]
```

  * The sort expression can be any expression that would be valid in the query's select list

Example:

```psql
SELECT name, age, height FROM people ORDER BY age;
```

  * When more than one expression is specified, the later values are used to sort rows that are equal according to earlier values

Example:

```psql
SELECT name, age, height FROM people ORDER BY age, height;
```

  * The sort direction can be set using the optional `ASC` or `DESC` keyword.
    * `ASC` (or ascending) puts the smaller values first
    * `DESC` (or descending) puts the larger values first
    * 'Smaller' in this context is determined in terms of the `<` operator
    * Similarly, 'larger' is determined in terms of the `>` operator
    * `ASC` is the default if direction is not specified
  * If sorting by multiple expressions, each expression can be followed by `ASC` or `DESC` (i.e. ordering options are considered independently for each sort columns)

Example:

```psql
SELECT name, age, height FROM people ORDER BY age ASC, height DESC;
```

  * In the above example, the people table would be sorted by the youngest and tallest first and the oldest and shortest last

  * The `NULLS FIRST` and `NULLS LAST` options can be used to determine where rows containing NULL values in the sort columns appear
  * By default NULL values sort as if *larger* than non-null values; that is `NULLS LAST` is the default for `ASC` order and `NULLS FIRST` for `DESC`

#### LIMIT and OFFSET

  * `LIMIT` and `OFFSET` allow you to retrieve just a portion of the rows that are generated by the rest of the query

  * `LIMIT` generally sets a maximum number of rows to be retreived
  * The syntax for `LIMIT` is as follows:

```
SELECT select_list
    FROM table_expression
    [ ORDER BY ... ]
    [ LIMIT { number | ALL } ] [ OFFSET number ]
```

  * If `number` is specified, then the the maximum number of rows returned will be equal to `number`
  * Rows returned could actually be less than `number` if the query actually yields fewer rows before being limited
  * If `ALL` is passed to `LIMIT` (or if `LIMIT` is used with a NULL argument) this is equivalent to omitting the `LIMIT` clause altogether

  * `OFFSET` can be used to specify the number of rows to skip prior to retreiving the remainder of the rows after the offset rows.
    * For example if a table has 15 rows, and `OFFSET` is set to 10, then rows 11 to 15 will be returned
  * If used, `OFFSET` must always be supplied a number, indicating the number of rows for the returned rows to be offset by

  * If `OFFSET` and `LIMIT` are used together, `OFFSET` rows are skipped before starting to count the `LIMIT` rows that are returned
  * This combination is often used for functionality like pagination

  * When using `LIMIT` is is usual to also use an `ORDER` clause to define how results are ordered before limiting them

Example:

```psql
SELECT name, age
  FROM people
    ORDER BY age DESC
    LIMIT 10;
```

  * The above query would return the 10 oldest people

  * Documentation: https://www.postgresql.org/docs/9.6/static/queries-limit.html

#### Subqueries

  * The results of `SELECT` query can be used as a condition in another `SELECT` query
  * This is sometimes referred to as *nesting*
  * The query that is *nested* is referred to as a *subquery*

##### Subquery Expressions

  * Documentation: https://www.postgresql.org/docs/8.1/static/functions-subquery.html

<a name="Inserting"></a>
### Inserting Data

<a name="Updating"></a>
### Updating Data

<a name="Deleting"></a>
### Deleting Data