# SQL Overview
  
  * [Introduction](#Introduction)
  * [Language Basics](#Basics)
  * [Queries](#Queries)
  * [Joins](#Joins)
  * [Aggregations](#Aggregations)
  * [Subqueries](#Subqueries)
  * [Write Operations](#Write-Ops)

<a name="Introduction"></a>
## Introduction

  * SQL stands for Structured Query Language
  * SQL is a language used to manipulate the structure and values of datasets stored in a relational database
  * SQL is described as a **special purpose language** (as contrasted with general programming languages such as Ruby, JavaScript, C, etc)
  * SQL is predominantly a **declarative language** -- it describes *what* needs to be done but does not detail *how* to accomplish this objective -- in practice the same query might be executed differently on identical datasets based on a variety of conditions. The SQL server abstracts the *how* away from the user ans generally selects the most efficient way to execute a query
  * There are a number of different 'flavours' of SQL, from SQLite, through MySQL, PostgreSQL to MS SQL Server and Oracle
  * SQL is really made up of three, smaller sub-languages for data-defiition, data-manipulation and data-control:

| **sub-language** | **controls** | **SQL constructs** |
|----|----|----|
| **DDL** (data defintion language) | relation structure and rules | `CREATE`, `DROP`, `ALTER` |
| **DML** (data manipulation language)  | values stored within relations | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **DCL** (data control language) | who can do what | `GRANT` |

### DDL: Data Definition Language

Allows users to create and modify *schema* stored witin a database. Statements include `CREATE TABLE`, `ALTER TABLE`, `ADD COLUMN`.

### DML: Data Manipulation Language

Allows users to retreive and modify the *data* stored within a database. Some databases consider retreival and manipulation as two separate languages themselves.

### DCL: Data Control Language

DCL controls the rights and access roles of the users interacting with a database or table.

<a name="Basics"></a>
## Language Basics
  
  * SQL is made up of **statements**. A SQL statement is terminated by a semi-colon
  * The most commonly used keywords in SQL statements are `SELECT`, `FROM` and `WHERE`
  * These keywords represent the most fundamental aspect of querying a database; other, more complex queries, are simply an extension of them

<a name="Queries"></a>
## Queries

A simple query of a table containing data on books might look something like this:

```sql
SELECT author
FROM books
WHERE id = 1;
```
`FROM` - where do we get the data from. This refers the query to a particular table. This could be an actual table in the database, or a temporary table generated through joins or subqueries. In the example the table is the `books` table.

`WHERE` - what data should we show. The `WHERE` clause acts as a filter to only show the particular rows from the table that match the condition defined in the `WHERE` clause. In the example, our query only returns rows from the `books` table where the value in the `id` column in equal to `1`

`SELECT` - how should we show the data. Generally this is which columns to show in the returned data. Column aliases can also be defined in a `WHERE` clause using the `AS` keyword.


<a name="Joins"></a>
## Joins
  
  * In an RDBMS, related data is often kept in separate tables in order to avoid duplication. This is referred to as data normalisation
  * A lot of the time you will want to access this related data from across the various table where it is stored.
  * In order to query mutliple data, SQL uses *joins*

An example a query on two joined tables (one containing data on books, and the other on when those books were borrowed) might look something like this:

```sql
SELECT books.title AS "Title", borrowings.returndate AS "Return Date"
FROM borrowings JOIN books ON borrowings.bookid=books.id
WHERE books.id=1;
```

  * One thing to note is the `FROM` clause is not referring directly to the `books` table or to the `borrowings` table, but to a *new* table formed by joining these two tables.
  * The `WHERE` and `SELECT` clauses also refer this joined table
  * It is usual practice to prepend column names with table names when querying joined tables in order to disambiguate columns of identical names; sometimes a query won't run unless certain columns are prepended with table names
  * The `ON` clause defines the criteria by which the tables should be joined. In the example, this is where the value of the `bookid` column from `borrowings` table matches the value of the `id` column from the `books` table.


<a name="Aggregations"></a>
## Aggregations

  * Aggregations are used to turn many rows into a single row based on some specified logic
  * Almost all aggregations are done with the `GROUP BY` statement
    * `GROUP BY` converts the table otherwise returned by the query into groups of tables
    * Each group corresponds to a unique value (or group of values) of columns specified in the `GROUP BY` clause
  * Aggregating data in this way allows us to then perform functions on the aggregated data, such as `count`, `sum` or `max`

For example, if we want to know the number of books written by each author, we would query :

```sql
SELECT authors.author, count(books.id)
FROM authors JOIN books on authors.id = books.author_id
GROUP BY authors.author;
```

<a name="Subqueries"></a>
## Subqueries

  * Subqueries are regular SQL queries embeded inside larger queries
  * There are three different types of sub-query, based on what they return:
    * Two-dimensional Table
    * One Dimensional Array
    * Single Values

### Two-dimensional Table

  * These are queries that return more than one **column**
  * As a subquery these simply return another table which can then be queried further

Example:

Say we used our query from before as a sub query, then filtered it further using a `WHERE` claus in the outer query:

```sql
SELECT * 
FROM (SELECT authors.author as author, count(books.id)
  FROM authors JOIN books on authors.id = books.author_id
  GROUP BY authors.author) AS results
WHERE author = 'William Gibson';
```

Note: You could of course do this without the sub-query by adding a `HAVING` clause to the original query. `HAVING` performs a similar role to `WHERE` but for queries where aggregation has been used.

### One Dimensional Array

  * These are queries that return multiple rows of a single column
  * As a subquery they can be used in the same way as a two-dimensional table (i.e. queried further) or they can be used as an array of values which can then be used in a further query

Example:

If we amended our previous query to return just the author instead of all the author and count, and changed the where clause so that multiple rows (authors) are returned (e.g. all authors withll more than 3 books):

```sql
SELECT author 
FROM (SELECT authors.author as author, count(books.id)
  FROM authors JOIN books on authors.id = books.author_id
  GROUP BY authors.author) AS results
WHERE count > 3;
```

we can then use this 'array' of returned values in a further subquery:

```sql
SELECT title, bookid
FROM books
WHERE author IN (SELECT author 
FROM (SELECT authors.author as author, count(books.id)
  FROM authors JOIN books on authors.id = books.author_id
  GROUP BY authors.author) AS results
WHERE count > 3);
```

Here we are querying a third table `books` and filtering the results using a `WHERE` clause by passing the results of our subquery to it using `IN`.

### Single Values

  * These are queries whose whose results only have one row and one column - i.e. a single value.
  * This value can then be used within a clause of another query

Example:

A subquery that returns a single value can also be used to filter an outer query, say through use in a `WHERE` clause.

Say for example we write a query that calculates the average stock of books from our `books` table:

```sql
SELECT avg(stock) FROM books;
```

the result of that query can then be used in the `WHERE` clause of another query to find all the books where the stock is greater than average:

```sql
SELECT *
FROM books
WHERE stock>(SELECT avg(stock) FROM books);
```

<a name="Write-Ops"></a>
## Write Operations

  * Write Operations are used when we want to add, change, or remove data from a database rather than just access data
  * They generally more straightforward than read queries

### Update

  * The syntax of `UPDATE` queries is semantically similar to read queries
  * The main difference is instead of `SELECT`ing columns we `SET` them instead

Example:

Say we sold out of a certain book title, we could update the stock levels

```sql
UPDATE books
SET stock=0
WHERE title='Neuromancer';
```

  * `WHERE` still performs the same function; it filters the table rows to just theones that you want to update
  * The `=` operator is used to indicate the new value that the column should be set to for the selected rows

### Delete

  * A `DELETE` query is syntactically similar to a `SELECT` query without the column names (since we are deleting the entire row the columns are irrelevant apart from for filtering)

Example:

If we wanted to remove all books from our `books` table where we have no stock, we could do the following:

```sql
DELETE FROM books
WHERE stock=0;
```

### Insert

  * The syntax for `INSERT` queries is a little bit different
    * You need to specify the columns names (unless you are inserting data into all columns in the table)
    * You also need to specify the data that you want to insert into those columns (in the same order as the column definition)

Example:

Say we received some more stock of our deleted book and we wanted to add it back in:

```sql
INSERT INTO books
  (bookid,title,author,published,stock)
VALUES
  (22, 'Neuromancer', 'William Gibson', 1984, 20);
```

If you want to insert multiple rows, you can comma-separate the data:

```sql
INSERT INTO books
  (bookid,title,author,published,stock)
VALUES
  (22, 'Neuromancer', 'William Gibson', 1984, 20),
  (22, 'Count Zero', 'William Gibson', 1986, 20),
  (22, 'Mona Lisa Overdrive', 'William Gibson', 1988, 20);
```
