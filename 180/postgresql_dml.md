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

Example:

  * Say we had two tables `students` and `classes`; students having `student_name` and `id` columns and classes having `class_name`, `id` and a `student_id` foreign key
  * If we wanted to find all the students who attended a particular class, we could use a sub-query
  * First we could right a query to return all the `student_id` data for a particular class, say 'English'

```psql
SELECT student_id FROM classes WHERE class_name = 'English';
```

  * We could then use the resulting data as a condition in another query that returns student names from the `students` table 

```psql
SELECT student_name FROM students WHERE id IN (SELECT student_id FROM classes WHERE class_name = 'English');
```

  * Here we are selecting only students who's `id` is in the results of our previous query (which we are using here as a sub-query) using the `IN` keyword (which is part of the subquery syntax)

##### Subqueries vs JOINs

  * In SQL there is often more than one way to write a query
  * Quite often, queries using a JOIN could perhaps also be written using a subquery
  * As a general rule, JOINs are faster to run than subqueries

Example:

  * Take our previous example of selecting student names for a particular class; written as a JOIN it would look like this

```psql
SELECT student_name FROM students INNER JOIN classes
  ON students.id = classes.student_id
  WHERE classes.class_name = 'English';
```

##### Subquery Expressions

  * The general form for a subquery is to compare either an expression or a row constructor with the result of a subquery via a particular subquery function

```
expression/ row_constructor function (subquery)
```

  * There are a number of functions that use this general form: `IN`, `NOT IN`, `ANY`, `SOME` and `ALL`
  * These last three (`ANY`, `SOME`, `ALL`) require the use of an additional operator in the form:


```
expression/ row_constructor operator function (subquery)
```

  * An exception to this form is `EXISTS` which uses the form:

```
EXISTS (subquery)
```

###### Expressions

  * If an expression is used, the subquery must return exactly one column
  * The expression is evaluated and compared to each row of the subquery result

###### Row Constructors

  * Where a row constructor is used on the left hand side of the expression, the subquery must return the same number of columns as exist in the row constructor
  * Comparison between the rows constructor and the subquery is carried out column by column
  * The entire row being evaluated (i.e. all columns) must equal an entire row in the subquery in order for it to be a match

###### `IN` and `NOT IN`

  * The result of `IN` is true if any equakl sub-query row is found
  * The result of `NOT IN` is true if no equal subquery row is found

Example:

```psql
SELECT student_name FROM students WHERE id IN (SELECT student_id FROM classes WHERE class_name = 'English');
```

  * This would return the names of all the students who are in the English class

```psql
SELECT student_name FROM students WHERE id IN (SELECT student_id FROM classes WHERE class_name = 'English');
```

  * This would return the names of all the students who are not in the English class



###### `ANY`, `SOME` and `ALL`

  * With `ANY`, `SOME` and `ALL` an operator which returns a boolean value needs to be used.
  * Typical operators in this context include `=`, `<`, `>`
  * **Note:** `ANY` and `SOME` are equivalent and either can be used

Example:

  * Say we had a `student_grades` table which contained data about student grades; the table has `id`, subject, `grade` and `student_id` columns (where `student_id` is a FK for the `students` table)
  * Say the `students` table and the `student_grades` table contain the following data:

```psql
select * from students;
 id | student_name 
----+--------------
  1 | Karl
  2 | Keri
  3 | Bob
(3 rows)

select * from student_grades;
 id | grade | student_id | subject 
----+-------+------------+---------
  2 |    90 |          2 | English
  3 |    75 |          3 | English
  1 |    85 |          1 | English
  4 |    75 |          2 | French
(4 rows)
```

  * We could find students with a grade of over, say, 79 using the `ANY` clause

```psql
SELECT student_name FROM students WHERE 79 < ANY (SELECT grade FROM student_grades WHERE student_id = students.id);
 student_name 
--------------
 Karl
 Keri
(2 rows)
```
  
  * This returns two students, Karl and Keri, as they both have a grade over 79; Keri has 90 for English, Karl has 85 for English

  * Notice that Keri has two grades in the `student_grades` table; one for English and another for French
  * If we wanted to list only students whose grades are *all* over 79, we could use the `ALL` clause

```psql
SELECT student_name FROM students WHERE 79 < ALL (SELECT grade FROM student_grades WHERE student_id = students.id);
 student_name 
--------------
 Karl
(1 row)
```

  * This only returns one student, Karl. because Keri has one grade below the value assessed by the operator, she is excluded from the result

###### `EXISTS`

  * When `EXISTS` is used, the sub-query is evaluated to determine if it returns any rows
    * If the subquery returns at least one row, the result of `EXISTS` is true
    * IF no rows are returned, the result of `EXISTS` is false

Example:

  * Say we added a new student, Bill, to our `students` table; but Bill, being new, didn't have any grades yet and so didn't *exist* in the `student_grades` table

```psql
SELECT * FROM students;
 id | student_name 
----+--------------
  1 | Karl
  2 | Keri
  3 | Bob
  4 | Bill
(4 rows)

SELECT * FROM student_grades;
 id | grade | student_id | subject 
----+-------+------------+---------
  2 |    90 |          2 | English
  3 |    75 |          3 | English
  1 |    85 |          1 | English
  4 |    75 |          2 | French
(4 rows)
```

  * Note there is no value `4` in the `student_id` column of the `student_grades` table

  * If we wanted to create a list of all the students who currently had at least one grade assigned to them, we could use a subquery with the `EXISTS` clause:

```psql
SELECT student_name FROM students WHERE EXISTS
  (SELECT 1 FROM student_grades WHERE student_id = students.id);
 student_name 
--------------
 Karl
 Keri
 Bob
(3 rows)
```

  * Note that Bill is not included in the returned results because he does not *exist* in the `student_grades` table
  * Note also the use of `SELECT 1` in the subquery. Since `EXISTS` is not concerned with what is actually returned by the subquery, only whether or not any rows are returned, an arbitrary value, such as `1` can be used

  * Documentation: https://www.postgresql.org/docs/8.1/static/functions-subquery.html

##### Subquery as a Virtual Table

  * An alternative to using a subquery expression such as `IN`, `NOT IN`, `ANY`, etc. is to use a subquery as a virtual table which you can then query further

Example:

  * Say we wanted to maximum number of grades assigned to a single student, we could write a query to count grades per student and then use that as a subquery

```psql
SELECT max(grade_count.count) FROM
  (SELECT count(id) FROM student_grades GROUP BY student_id) AS grade_count;
 max 
-----
   2
(1 row)
```

  * This returns the value `2`, which makes sense because we know that Keri has two grades assigned to her

##### Scalar Subqueries

  * A *scalar subquery* is an ordinary `SELECT` query in parentheses that returns exactly one row and one column
  * The `SELECT` query is executed and the single returned value is used in the surrounding value expression
  * You cannot use a query that returns more than one row or more than one column as a scalare subquery

Example:

  * Say we wanted to list the name of each student along with their highest grade; we could query the `student_grades` table for the maximum grade for each student and use this as a scalar subquery

```psql
SELECT student_name, (SELECT max(grade) FROM student_grades WHERE student_id = students.id)
  FROM students;
 student_name | max 
--------------+-----
 Karl         |  85
 Keri         |  90
 Bob          |  75
 Bill         |    
(4 rows)
```

  * The result table shows the highest grade for each student in the `max` column; Bill has a NULL value in this column since he doesn't exist in the `student_grades` table

  * Documentation: https://www.postgresql.org/docs/9.5/static/sql-expressions.html#SQL-SYNTAX-SCALAR-SUBQUERIES

##### Row-wise Comparison

  * Row-wise comparison can be carried out when you know certain values from a row and you want to filter the table according to those values
  * It is essentially a alternative to using the `AND` clause

Example:

  * Say we know a student has a grade of `90` for `English` and we want to determine the `student_id` of that student, we could use row-wise comparison to do this

```psql
SELECT student_id FROM student_grades WHERE (90, 'English') = (grade, subject);
 student_id 
------------
          2
(1 row)
```

  * We could then use this row-wise comparison query as a subquery to determine the name of the student

```psql
SELECT student_name FROM students WHERE
  id = (SELECT student_id FROM student_grades WHERE (90, 'English') = (grade, subject));
 student_name 
--------------
 Keri
(1 row)
```

<a name="Inserting"></a>
### Inserting Data

  * Newly created tables contain no data. Data must be inserted into the table after it is created
  * Data is inserted one row at a time; although you can write queries to insert multiple rows, conceptually each row is creatd separately
  * New rows are created using the `INSERT INTO` command

Example:

  * Imagine we have a `people` table with columns `id`, `name`, `age`; we could insert a row in this format:

```psql
INSERT INTO people VALUES (1, 'Karl', 42);
```

  * In order to use this format, we need to know the order of the columns in the table
  * If we didn't know the order, we could specify the columns in parentheses prior to the `VALUES` keyword

```psql
INSERT INTO people (name, id, age) VALUES ('Karl', 1, 42);
```

  * In this case the order of the expressions after `VALUES` must corresponsd to the order of the column names preceding `VALUES`

#### Default Values

  * If columns have default values, these can be used to populate those columns for the row on insertion; this can be carried out in a number of ways

  * When not specifying columns, values are inserted from left-to-right.
  * Say our columns are ordered `id`, `name`, `age`, the following query will populate `id` and `name` and age will be populated with its default value (note, this is PostgreSQL specific functionality and not part of the SQL standard)

```psql
INSERT INTO people VALUES (1, 'Karl');
```

  * If age has no default then a NULL value will be applied 

  * Another way default values can be applied is throguh use of the `DEFAULT` keyword in place of the value
  * Say for example our `id` column is a `serial` field and the default is the next id in the sequence, we could insert a row as follows:

```psql
INSERT INTO people VALUES (DEFAULT, 'Karl', 42);
```

  * This would insert a new row with `id` given its default, `name` set to 'Karl' and `age` set to 42

  * You can apply defaults for the entire row (i.e. each column will be set to its default value for that row) in the following way:

```psql
INSERT INTO people DEFAULT VALUES;
```

  * If specifying column names, any column ommitted from the list will be assigned its default value

```psql
INSERT INTO people (name, age) VALUES ('Karl', 42);
```

  * In this example `name` and `age` will be set according to the supplied values, but `id` will be assigned its default

#### Inserting Multiple Rows

  * Multiple rows can be created with a single `INSERT command, with the values for each row in parentheses, and each set of values being comma-separated

```psql
INSERT INTO people (name, age) VALUES
  ('Karl', 42),
  ('Keri', 27),
  ('Bill', 34);
```

  * Documentation: https://www.postgresql.org/docs/9.6/static/dml-insert.html
  * Command reference: https://www.postgresql.org/docs/9.6/static/sql-insert.html 

<a name="Updating"></a>
### Updating Data

  * Modification of data that already exists in the database is referred to as *updating*
  * It is possible to update
    * Individual rows
    * All rows in a table
    * A subset of all rows
  * Each column can be updated separately without affecting the other columns

  * Updation is carried out using the `UPDATE` command
  * This command requires the following pieces of information:
    * The name of the table to upddate
    * The name of the column (or columns) to be upddated
    * The new value of the column (or columns)
    * Which row (or rows) to update
      * Rows are generally identified based on a condition, using the `WHERE` clause

Example:

```psql
UPDATE people SET age = 35 WHERE name = 'Bill';
```

  * The column name andexpression after the `SET` clause specifies the column to be updated along with its new value; the `=` operator is used to indicate that the column should be set to the value of the following expression
  * The condition following the `WHERE` clause indicates which row to update; in this case all rows where the value in the `name` column is equal to 'Bill' will have the value in the `age` column set to 35
    * If there are multiple rows that match this condition then all matching rows will be updated
    * If there are no rows that match the condition then no rows will be updated

  * The expression following the `=` sign within the `SET` clause can be any scalara expression (i.e. it doesn't simply have to be a constant)
  * Additionally it can refer to existing values in the row

```psql
UPDATE people SET age = age + 1 WHERE name = 'Bill';
```

  * Multiple columns in the row can be updated within the same `SET` clause

```psql
UPDATE people SET name = 'Bob', age = 30 WHERE id = 3;
```

  * If the `WHERE` clause is ommitted, then all rows in the table are updated

```psql
UPDATE people SET name = 'Malkovich';
```

  * Documentation: https://www.postgresql.org/docs/9.6/static/dml-update.html 
  * Command reference: https://www.postgresql.org/docs/9.6/static/sql-update.html

<a name="Deleting"></a>
### Deleting Data
