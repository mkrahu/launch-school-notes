# Interacting with a Datababase in Code
  
  * [Executing SQL Statements from Ruby](#SQL-Ruby)
    * The PG gem
  * [Database-backed Web-apps](#DB-Web-apps)
    * Adaptor Patterns
    * Designing Schema
  * [Working with a Database Interface Library](#DB-Interface-Lib)
    * Advantages of abstraction
    * The Sequel gem

<a name="SQL-Ruby"></a>
## Executing SQL Statements from Ruby

  * Within web development, interaction with and manipulation of a database is generally not carried out directly in the psql console (unless, perhaps, when initially setting up a database for use by another system)
  * Usually some programming language will use an adapter of some sort in order to interact with the database
  * One such adapter, which provides an interface between Ruby and the PostgreSQL RDBMS, is `pg`
  * `pg` is a Ruby gem. As such it can be installed and then 'required' in order to extend the Ruby language
  * `pg` works by dynamically generating SQL; in effect it creates SQL statements using Ruby
  * There are certain dangers inherent in interacting with a database in this way; you need to be aware of these dangers and of the methods that can be used to reduce or eliminate them

  * Documentation: https://deveiate.org/code/pg/index.html

### Connection to a Database

  * In order to be able to interact with a database, a connection first needs to be made to that database
  * PG has a class method called `connect` which facilitates this

Example:

```ruby
require 'pg'

db = PG.connect(dbname: "my_database")
```

  * This would create a new `PG::connect` object, which is a connection to the `my_database` database; we can assign a variable, e.g. `db`, to it in order to be able to subsequently use the connection object to interact with the database
  * If the database was hosted on a remote server rather than localhost, further arguments, such as `host`, `hostaddr`, `port` would be required, probably along with `user` and `password`

  * Documentation: https://deveiate.org/code/pg/PG/Connection.html#method-c-new

### Executing a SQL Statement

  * PG has an instance method, `Connection#exec`, which can be used to executed SQL queries via a PG connection object
  * This method can be called on the `PG::connect` object

Example:

```ruby
result = db.exec("SELECT * FROM some_table;")
```

  * The argument passed to `exec` is simply a SQL statement in String form
  * The `exec` method executes this statement on the database
  * This returns a `PG::result` object. This can have a variable assigned to it to be further manipulated

  * Documentation: https://deveiate.org/code/pg/PG/Connection.html#method-i-exec

### Manipulating a Result Object

  * PG has a number of methods that can be used to manipulate or further query a `PG::Result` object
  * One of these methods is `Result#values`. This returns a two-dimensional, where each sub-array represents a row in the table

Example:

  * Say we had a PostgreSQL table called people with `id, `name` and `age` columns, querying that table in the psql console might produce a result like this:

```psql
SELECT * FROM people;
id | name | age   
---+------+-----
 1 | Keri | 27 
 2 | Karl | 42
 3 | Bob  | 30
 4 | Bill | 35
(4 rows)
```

  * If we were to connect to the database using PG and execute the same query, this would return a `PG::Result` object
  * Calling `Result#values` method on that object would produce something like this:

```ruby
[
  ['1', 'Keri', '27'],
  ['2', 'Karl', '42'],
  ['3', 'Bob', '30'],
  ['4', 'Bill', '35']
]
```

  * There are many other methods available to the PG Result object, such as:
    * `Result#ntuples` returns the number of rows (tuples) in the result
    * `Result#each` invokes a block for each row (tuple) in the result set
    * `Result#fields` returns an array of Strings representing the names of the fields in the result

  * Documentation: https://deveiate.org/code/pg/PG/Result.html

  * The main take-away here though shouldn't be the specific capabilities or syntax of the PG gem, but the fact that PG allows you to query to a PostreSQL database and return a Ruby Object
  * The Ruby Object can be manipulated in numerous ways that make the returned data much easier to work with within your Ruby program
  * This allows you to write simple SQL queries to the database and then manipulate general results in a more complex way in the code

  * One thing to note is that the values returned in the result are all in String format. 
  * This is true even for values that are defined as some other data type in the PostgreSQL database
    * For example, `id` in the database is an Integer, but in the result it is a String

#### Security Considerations

  * One thing to be aware of when interacting with a database in code in this way is the potential security issues
  * This is of particular concern when the program allows user input in order to create the query that is made to the database
  * A malicious user could carefully craft some input in order to inject a destructive or otherwise harmful SQL command into the system via normally benign query
  * Tools such as the PG gem which allow you to interact with a database often provide ways to limit the risk of SQL injection
    * For example, PG has a `Connection#exec_params` method which sends SQL query requests using placeholders for parameters, user input can then be safely interpolated into the request string in place of these parameters

  * Documentation: https://deveiate.org/code/pg/PG/Connection.html#method-i-exec_params



<a name="DB-Web-apps"></a>
## Database-backed Web-apps

  * The main reason for wanting to interact with a database in code is to be able to build database-backed web applications
  * Often a tool, like the PG gem, will be used within an *adapter pattern* in order to create an interface between the main program and the database

### Adaptor Patterns

  * A common pattern for building database-backed web applications is called the *adapter pattern*
    * Within this pattern all of the functionaility for interacting with the database is extracted to a separate class
    * The 'main' application code then manipulates an instance of that class in order to create, read, edit or delete data in the database without having to interact directly with the database itself
    * One of the advantages of this pattern is that this modularity allows you to use different types of data store or to change the the data store you are using while maintaining the same abstractions within the main program

### Designing Schema

  * Another important aspect of building a database-backed web application is designing the schema required for the database
  * One approach is to think of your application in terms of entities that exist and interact within it, and to the describe the attributes that the entities require
  * These attributes can then be extrapolated to design the schema for the database

Example:

  * Say for example we are woking on a ToDo app; the app will display ToDo lists, and within each list will have a number of ToDos
  * We could say that we have two *entities* within the application: todo lists and todos
  * We could then define the attributes of our entities in the following way:
    * List:
      * Has a *unique* name
    * ToDo
      * Has a name
      * Belongs to a list
      * Can be completed, but its initial state is incomplete

  * We can then extrapolate from these entities and their attributes in order to define the tables and column required in our database
  * With the addition of `id` columns in order to be able to uniquely identify rows, our `lists` table would need `id` and `name` columns, the name column having a `UNIQUE` constraint on it; the `todos` table would need `id`, `name`, `completed` and `list_id` columns where `completed` would eb a boolean with a DEDFAULT value of `false` and `list_id` would be a foreign key referencing the `id` column of the `lists` table
  * Our table creation statements for this schema might look something like this:

```psql
CREATE TABLE lists (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE todos (
    id serial PRIMARY KEY,
    name text NOT NULL,
    completed boolean NOT NULL DEFAULT false,
    list_id integer NOT NULL REFERENCES lists (id)
);
```

<a name="DB-Interface-Lib"></a>
## Working with a Database Interface Library

  * A Database Interface Library can be thought of as another level of abstraction above an database adapter like the PG gem
  * It is effectively an API that allows you to express SQL queries purely in code without ahving to write queries in SQL
  * One example of a Database Interface Library is the 

### Advantages of Abstraction

  * One of the main advantages of using a Database Interface Library to interact with the database is that is allows you to mostly think at single level of abstraction
  * Consider the situation with using a database adapter like the PG gem, although we could use the adapters methods to connect to and query a database and to manipulate the results of a query, we still have to write queries in SQL, with the queries passed as arguments to an adapter method to then be executed on the database
  * In this situation we are effectively having to think at two very different levels of abstraction: at the database level and at the code level; this can be pictured in the following way:

```
******                    ****          (thinking)
PostgreSQL <-> pg gem <-> Ruby program
```

  * In the above example we are having to think in both Ruby *and* SQL (`pg` is just an adapter, so it doesn't involve a lot of mental overhead)
  * For small programs this might not be much of an issue, but with larger programs this disconnect can become more probelmatic

  * If we used a Database Interface Library, such as Sequel, the diagram might look more like this:

```
**                        *****      ***           (thinking)
PostgreSQL <-> pg gem <-> Sequel <-> Ruby program
```

  * Here we are mostly thinking at the Sequel and Ruby program levels; since they are similar levels of abstraction, and Sequel allows us to express all of our queries in Ruby code, using the Ruby syntax, this is less mentally taxing
  * Of course we still need to think a little at the SQL level, but most of our thinking in this scenario is at the Ruby level

  * Consider this comparison of the same query using `pg` and Sequel:

```ruby
post_id = 42

# just using the pg gem
require 'pg'
connection = PG::Connection.new(dbname: "database")
connection.exec_params("SELECT * FROM posts WHERE id = $1 LIMIT 1", [post_id]).values

# using Sequel
require 'sequel'
DB = Sequel.connect('postgres://database')
DB[:posts].where(id: post_id).first
```

  * The key difference here is that the `pg` version uses a combination of Ruby and SQL, and the Sequel version uses only Ruby
  * The goal is not to avoid writing SQL, but to be able to think and write code that operates at a higher level of abstraction

### The Sequel gem

  * Sequel is an Database Interface Library for interacting with databases using Ruby
  * It can interface with a number of different RDBMSes

#### Connecting to a Database

  * Connecting to a database using Sequel is as simple as calling the appropriate `Sequel` module method ofor the database adapter that you are using 

```ruby
require 'sequel'

DB = Sequel.postgres('my_database')
```

  * These module methods are actually created via metaprogramming. Another option is to use the `Sequel::connect` method and pass in the adapter name as an argument

```
DB = Sequel.connect(:adapter=>'postgres', :database=>'./my_database.db')
```

  * Both of these methods create a new database object which can then be used to manipulate and query the database

  * Documentation: http://sequel.jeremyevans.net/rdoc/classes/Sequel.html#method-c-connect

#### Data Definition

  * Data definition and schema creation can be carried by calling the appropriate `Sequel::Database` method on the database object created by the connection

Example:

```ruby
DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end
```

  * In the above example, the `Database#create_table` method is used to create a new table in the database, with the column names and types defined in the block

  * `Database#create_table` method: http://sequel.jeremyevans.net/rdoc/classes/Sequel/Database.html#method-i-create_table
  * `Database` Documentation: http://sequel.jeremyevans.net/rdoc/classes/Sequel/Database.html

#### Data Manipulation

  * Data manipulation in Sequel is based on the concept of a dataset
  * A dataset represents and SQL query, or more generally, an abstract set of rows in the database
  * Datasets can be used to create, retrieve, update and delete records
  * In its simplest form, a dataset can be created by passing a table name as a symbol to the `Database` object

Example:

```ruby
items = DB[:items]
```

  * Query results are always retreived on demand, so a dataset can be kept around and reused indefintely

Example:

```ruby
my_posts = DB[:posts].where(:author => 'karl') # no records are retrieved at this point
my_posts.all # records are retrieved here (i.e. the database is queried)
my_posts.first # records are retrieved here (i.e. the database is again queried)
```

  * Many different methods can be called on a dataset in order to run a query, such as `select`, `all`, `first`, `insert` `update`, `delete`, and many other methods analogous to common SQL queries
  * Methods can also be chained to create more complex queries:

Example:

```ruby
DB[:birds].select(:name, :family).where(extinct: false).order(Sequel.desc(:length)).all
```

  * Sequel dataset Documentation: http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html

#### Sequel Documentation

  * Readme: http://sequel.jeremyevans.net/rdoc/files/README_rdoc.html
  * Documentation: http://sequel.jeremyevans.net/rdoc/
  * Sequel class documentation: http://sequel.jeremyevans.net/rdoc/classes/Sequel.html
  * Sequel::Dataset class documentation: http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html
  * Sequel Cheatsheet: http://sequel.jeremyevans.net/rdoc/files/doc/cheat_sheet_rdoc.html
