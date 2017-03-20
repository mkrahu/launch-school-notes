# PostreSQL: Additional Topics

* [Functions and Operators](#Functions-Operators)
* [Indexes](#Indexes)
* [Additional Topics](#Additional) (Full Text Search, Performance Tips)

<a name="Functions-Operators"></a>
## Functions and Operators

  * PostgreSQL provides a large number of functions and operators for the built-in data types
  * Users can also define their own functions and operators
  * The psql meta commands `\df` and `\do` can be used to list available functions nad operators respectively

  * Documentation: https://www.postgresql.org/docs/9.6/static/functions.html

### Logical Operators

  * `AND`, `OR`, `NOT`

  * Documentation: https://www.postgresql.org/docs/9.6/static/functions-logical.html

### Comparison Functions and Operators

  * `<`, `>`, `<=`, `>=`, `=`, `<>` or `!=`

  * Documentation: https://www.postgresql.org/docs/9.6/static/functions-comparison.html

### Mathematical Functions and Operators

  * E.g. `+`, `-`, `*`, `/`, `%`, etc.

  * https://www.postgresql.org/docs/9.6/static/functions-math.html

### String Functions and Operators

  * E.g. `||` (concatenation), `lower()`, `trim()`, `upper()`, etc.

  * Documentation: https://www.postgresql.org/docs/9.6/static/functions-string.html

### Other Function and Operator Types

  * Other types include:
    * Pattern Matching
    * data Type Formatting
    * Date/ Time
    * Array
    * Range
    * Aggregate Functions

<a name="Indexes"></a>
## Indexes

  * Indexes are used to create efficiencies when querying a table
  * Without the use of indexes, the system needs to scan an entire table to find all the matching entries for a particular query
  * Indexes provide quicker access to the particular data that is indexed

### Creating an Index

  * Indexes are created using the `CREATE INDEX` command

Example:

```psql
CREATE INDEX test_index ON test (id);
```

  * THis example creates an index on the `id` column of the `test` table

### Removing an Index

  * Removing an index is done using the `DROP INDEX` command

  * Documentation: https://www.postgresql.org/docs/9.6/static/indexes-intro.html

### Index Types

  * PostgreSQL provides a number of different index types:
    * Btree
    * GiST
    * SP-GiST
    * GIN
    * BRIN

  * Documentation: https://www.postgresql.org/docs/9.6/static/indexes-types.html
