# Database Design and Performance

  * [Normalisation](#Normalisation)
  * [Database Performance](#Performance)

<a name="Normalisation"></a>
## Database design and Normalisation

  * Database normalisation is a process of organising data effectively in tables. It is a systematic approach of decomposing tables to eliminate data redundancy and undesirable characteristics such as Insertion, Update and Deletion anomalies
  * Normalisation is carried out by adding additional tables to a database and creating appropriate relationships between these tables

### Normal Forms

  * The database community has developed a series of guidelines for ensuring that databases are normalised; these are referred to as 'normal forms'
  * Currently these run from First Normal Form through to Fifth Normal Form
  * Abbreviatons such as 1NF, 2NF, etc are generally used to denote normal form

#### Denormalised

  * A *denormalised* database table is one that does not comply with even the 1NF rules.
  * For example, if we had a table of students who studied multiple subjects, creating multiple 'subject' columns would mean that the table was denormalised

Example:

| Student | Age | Email | Time 1 | Time 2 | Class 1 | Class 2 |  Subject 1 | Subject 2 |
|----|----|----|----|----|----|----|----|----|
| Karl Lingiah | 42 | karl@mail.com | Monday 10am | Tuesday 12pm | EL101 | FR120 | English | French |
| Keri Silver | 28 | keri@mail.com | Wednesday 2pm | Monday 10am | EL201 | AH210 | English | Art History | 
| Halo Jones | 22 | halo@mail.com | Monday 10am | | EL101 | | English | |

  * This is duplicative because there are multiple columns for what is effectively the same data (i.e. the data is interchangable - e.g for 'Student' Karl Lingiah you could just as easily put French in the 'Subject 1' column and 'English' in the 'Subject 2' column, the same with the Time and Class columns)
  * Denormalised tables restrict future growth; for example, what if you had a student that was studying four subjects?
  * Even if you had a single 'Subject', 'Time' and 'Class' columns containing all of a student's subjects, this would still be duplicative and non-atomic; it would also lead to potential confusion - which class and teacher relate to which subject?
  
#### First Normal Form (1NF)

  * First Normal Form sets very basic rules for an organised database
    * Eliminate duplicative columns from the same table; i.e. do not duplicate data within the same **row** of a table (this is referred to as the atomicity of a table)
    * Create separate tables for each group of related data and identify each row with unique column (or set of columns) and act as the *primary key*

Example:

| id | Student | Age | Email | Time | Class| Subject |
|----|----|----|----|----|----|----|
| 1 | Karl Lingiah | 42 | karl@mail.com | Monday 10am  | EL101 | English |
| 2 | Karl Lingiah | 42 | karl@mail.com | Tuesday 12pm | FR120 |French |
| 3 | Keri Silver | 28 | keri@mail.com | Wednesday 2pm| EL201 | English |
| 4 | Keri Silver | 28 | keri@mail.com |  Monday 10am | AH210 | Art History |
| 5 | Halo Jones | 22 | halo@mail.com | Monday 10am | EL101 | English |

  * Here we have removed duplication from the *structure* of the table in that there are no duplicative columns; the relationship between the columns is *atomic* (there is one subject per student)
  * Also there is a clear unique identifier for each row to act as the primary key (the id column). [Note: we couldn't simply use an existing column as the primary key because the values or not unique to each row]
  * Although we've removed duplication in the *structure* of the table (by removing the multiple subject fields), as a result we now have duplication in the data, as two of the students have two rows of data each

#### Second Normal Form (2NF)

  * Second normal form further addresses the concept of removing duplicative data
  * Second normal form should meet all the requirements of first normal form
  * Furthermore, 2NF should remove subsets of data that apply to multiple rows of a table and place them in separate tables
  * 2NF should create relationships between these new tables and their predecessors through the use of foreign keys
  * Essentially, 2NF attempts tot reduce the amount of redundant data in a table by extracting it and placing it in new tables and creting relationships between those tables

Example:

Student Table -

| id | Student | Age | Email |
|----|----|----|----|----|
| 1 | Karl Lingiah | 42 | karl@mail.com | 
| 2 | Keri Silver | 28 | keri@mail.com |
| 3 | Halo Jones | 22 | halo@mail.com |

Student Classes Table - 

| student_id | Time | Class | Subject |
|----|----|----|----|
| 1 | Monday 10am  | EL101 | English |
| 1 | Tuesday 12pm | FR120 | French |
| 2 | Monday 10am | AH210 | Art History |
| 2 | Wednesday 2pm | EL201 | English |
| 3 | Monday 10am | EL101 | English |

  * Here we have removed the subsets of data that apply to multiple rows (all the data relating to the classes) and thus reduced the Student table to three rows (one per student)
  * We have created a relationship between the two tables using the `student_id` value in the Student Classes table, which acts as a foreign key for the `id` column of the Student table

#### Third Normal Form (3NF)

  * Third normal form should meet all the requirements of second normal form
  * Furthermore, 3NF should remove columns that are not *dependent* on the primary key, meaning that any column's value should be derived from the primary key only and it should not be posible to derive a column's value from another column

Example:

  * In our 2NF example, the Student table already conforms to 3NF
  * With the Student Classes table, if we think of a combination of the `student_id` and the `Time` as the Primary Key for the table, so `(student_id, Time)`, then the value of the Class column could be derived from the Primary Key (since a student can only attend one class at a particular time). So the Class column conforms to 3NF
  * The value of the Subject column however can be derived from the Class column as well as from the Primary Key, so this does not conform to 3NF
  * We can resolve this by extracting out the Class data to another table

Student Table -

| id | Student | Age | Email |
|----|----|----|----|
| 1 | Karl Lingiah | 42 | karl@mail.com | 
| 2 | Keri Silver | 28 | keri@mail.com |
| 3 | Halo Jones | 22 | halo@mail.com 

Student Classes Table - 

| student_id | Time | Class |
|----|----|----|
| 1 | Monday 10am | EL101 |
| 1 | Tuesday 12pm | FR120 |
| 2 | Monday 10am | AH210 |
| 2 | Wednesday 2pm | EL201 |
| 3 | Monday 10am  | EL101 |

Class Table -

| Class | Subject |
|----|----|
| EL101 | English |
| FR120 | French |
| AH210 | Art |
| EL201 | English | 

#### Boyce-Codd Normal Form or Third and a Half Normal Form (BCNF or 3.5NF)

  * BCNF is an extension to 3NF and adds one more requirement: Every determinant must be a *candidate key*

##### Candidate Keys

  * A candidate key is a combination of attributes that can be uniquely used to identify a database record without referring to any other data. 
  * A table can have one or more candidate keys; one of these is selected as the table Primary Key
  * All candidate Keys share some common properties:
    * For the lifetime of the candidate key, the sttribute used for identification must stay the same
    * The value cannot be NULL
    * The value must be unique

  * In our Student Classes table, the Class can be determined by the combination of `student_id` and Time, as previously discussed; so this *combination key* is a determinant and also a candidate key
  * However, assuming that a particular class only runs once a week, the value of the Time column could also be determined by the Class column, so Class is a determinant but it is **not** a candidate key because it is not unique

  * An initial attempt to resolve this issue might be to combine `student_id` and `Class` as the primary key (student_id, Class)

Example:

Student Classes Table - 

| student_id | Class | Time |
|----|----|----|
| 1 | EL101 | Monday 10am |
| 1 | FR120 | Tuesday 12pm |
| 2 | AH210 | Monday 10am |
| 2 | EL201 | Wednesday 2pm |
| 3 | EL101 | Monday 10am  |

  * This would create a unique composite key which would be a candidate key and act as the Primary Key
  * On first glance this resolves the issue as Class cannot be derived from Time (there are multiple different classes at the same time), however, Time can be derived by only part of the Primary Key -- the value of Class -- which violates the ruled for 2NF (second normal form is violated when a non-key field is a fact about a subset of a key). Since in order to be BCNF compliant we must also adhere to the rules for 1NF, 2NF and 3NF, this would render the table non-compliant
  * The solution here is to extract the Time data entirely from the Student Classes table; we could, for example, move it to our existing Class table

Example:

Student Table -

| id | Student | Age | Email |
|----|----|----|----|
| 1 | Karl Lingiah | 42 | karl@mail.com | 
| 2 | Keri Silver | 28 | keri@mail.com |

Student Classes Table - 

| student_id | Class |
|----|----|
| 1 | EL101 |
| 1 | FR120 |
| 2 | AH210 |
| 2 | EL201 |
| 3 | EL101 |

Class Table -

| Class | Subject | Time |
|----|----|----|
| EL101 | English | Monday 10am |
| FR120 | French | Tuesday 12pm |
| AH210 | Art | Monday 10am |
| EL201 | English | Wednesday 2pm |   

#### Fourth Normal Form (4NF)

  * Fourth Normal form adds one additional requirement: a relation is in 4NF if it has no multi-valued dependencies. In other words, a record type should not contain two or more independent multi-valued facts about an entity

##### Multivalued Dependency

  * A multivalued dependency is a dependency that can result in multiple rows in a table for the same entity; for example in our Student Classes table, there can be more than one class for the same student

Example:

  * All of the tables from our previous examples already satisfy 4NF, but imagine that our Student Classes also recorded information about a student's hobbies as well as their classes, it might look something like this:

Student Classes Hobbies Table - 

| student_id | Class | Hobbies |
|----|----|----|
| 1 | EL101 | Reading |
| 1 | FR120 | Reading |
| 1 | EL101 | Soccer |
| 1 | FR120 | Soccer |
| 2 | AH210 | Travel |
| 2 | EL201 | Travel |
| 3 | EL101 | Cooking |

  * Here we have cross-product form which allows for all possible combinations of classes and hobbies

or it could look something like this:

| student_id | Class | Hobbies |
|----|----|----|
| 1 | EL101 |  |
| 1 | FR120 |  |
| 1 |  | Reading |
| 1 |  | Soccer |
| 2 | AH210 |  |
| 2 | EL201 |  |
| 2 |  | Travel |
| 3 | EL101 |  |
| 3 |  | Cooking |

  * Here we have a disjointed format where a record can contain either a Class or a Hobby but not both

  * There are other ways in which you can format tables which have two or more multi-valued dependencies, such as unrestricted, minimal records with repetitions or minimal records with NULL values
  * Whichever way you format the tables there are potential issues:
    * If there are repetitions, then updates have to be done in multiple records, and they could become inconsistent.
    * Insertion of a new hobby may involve looking for a record with a blank hobby, or inserting a new record with a possibly blank class, or inserting multiple records pairing the new hobby with some or all of the classes.
    * Deletion of a hobby may involve blanking out the hobby field in one or more records (perhaps with a check that this doesn't leave two records with the same class and a blank hobby), or deleting one or more records, coupled with a check that the last mention of some class hasn't also been deleted.

#### Fifth Normal Form (5NF)

  * 5NF is mostly theoretical and fairly rarely used in real-world cases
  * Roughly speaking, we may say that a record type is in fifth normal form when its information content cannot be reconstructed from several smaller record types, i.e., from record types each having fewer fields than the original record.

### General Notes on Normalisation

  * Normalisation rules are intended as a guideline; having the highest level of normalisation isn't necessarily always the best design for a database or set of tables
  * Having data in a highly normalised format sometimes takes several joins to retrieve which makes it innefficient. Denomralisation is required when the expected data may not be exhibiting the pattern that the tables were designed for; for example if most of our students only studies a single subject and maybe one or two studied two but not more, then we could potentially have left our students table in 1NF instead of extracting the classes data into a separate tbale

### Sources:

  * https://launchschool.com/books/sql/read/normalization
  * http://databases.about.com/od/specificproducts/a/normalization.htm
  * http://www.bkent.net/Doc/simple5.htm

<a name="Performance"></a>
## Database Performance

  * Database performance can often be improved through the appropriate use of indexes
  * Indexes are used to retrieve data more quickly by helping locate column values more efficiently without having to search through every record in sequence
  * Indexing is essentially a mechanism that database engines use to speed up queries by storing results in a table-like structure in ordered form
  * By default the primary key is an index
  * You can create indexes for a table based on a single column, multiple columns or even the prefix of a column

### Read Speed vs Write Speed

  * Indexes improve the read speed of a table but slow down the write speed
  * Simply adding indexes to a table doesn't necessarily improve performance, especially if the table is written to as often often or more than it is read; this is because every time a record is added to a table that contains indexes, the index is being updated as well as the table

### Index Types

#### Primary

  * Probably the most commonly used type of index in a table is the PRIMARY KEY
  * The PRIMARY KEY is used to uniquely identify a row in a table
  * In PostgreSQL, 'index' and 'key' are somewhat synonymous

#### Unique

  * Unique indexes are where a unique constraint is added to column in a table
  * When a query is run to search a table by a value in a column that has a unique constraint, the query will not need to scan the entire table to check each row; once it has located the unique value it can stop searching
  * One difference between a Primary Key and a Unique index, is that a Unique index can be NULL whereas a Primary Key is not nullable
  * Another difference between a Primary Key and a Unique Index is that you can have multiple Unique Indices in a table but only one Primary Key

#### Non-Unique

  * A non-unique index is simply a column that has been indexed but can contain non-unique values

#### Other Index Types

  * As well as the *general* index types listed above, specific RDBMSes provide specific index types that are defined according to the structure of the index
  * PostgreSQL provides the following index types: B-tree, Hash, GiST and GIN; the default is B-tree
  * These index types generally differ in the way that they handle comparison and equality
  
##### B-tree

  * B-trees can handle equality and range queries on data that can be sorted into some ordering
  * In particular, the PostgreSQL query planner will consider using a B-tree index whenever an indexed column is involved in a comparison using one of these operators: `<`, `<=`, `=`, `>=`, `>` or equivalent constructs such as `BETWEEN` or `IN`. 
  * An `IS NULL` or `IS NOT NULL` condition on an index column can also be used on a B-tree

##### Hash

  * Hash indexes can only handle simple equality comparisons
  * The query plannner will consider using a Hash index whenever an indexed column is involved in a comparison using the `=` operator

##### GiST

  * GiST indexes are not a single kind of index, but rather an infrastructure within which many indexing strategies can be implemented
  * The particular operators witin a GiST index vary according to the indexing strategy
  * GiST indexes are capable of optimising 'nearest-neighbour' searches

##### GIN

  * GIN indexes are inverted indexes which can handle values which contain more than one key -- arrays, for example
  * Like GiST, GIN can support many different user-defined indexing strategies, and the particular operators with which a GIN index can be used vary depending on the indexing strategy
  * The standard distribution of PostgreSQL includes GIN operator classe for one-dimensional arrays


### When to use an Index

  * Indexes are best used in cases where sequential reading is inadequate
  * Fields that aid in mapping relationships and fields that are frequently displayed with `ORDERED BY` are good candidates for indexing
  * Misuse of indexes can slow down database inserts and updates
  * Indexes are best used in tables where reads are more common than writes

### Sources

  * https://launchschool.com/books/sql/read/indexes
  * https://www.postgresql.org/docs/9.1/static/indexes-types.html
