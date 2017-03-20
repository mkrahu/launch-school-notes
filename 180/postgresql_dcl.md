# PostreSQL: Data Control Syntax

  * [Database Roles](#Roles)
  * [Client Authentication](#Authentication)
  * [Privileges](#Privileges)
  * [Row Security Policies](#Row-Security)

<a name="Roles"></a>
### Database Roles

#### Overview

  * PostgreSQL manages database access permissions using the concept of *roles*
  * A role can be thought of either as a database user, or a group of users, depnding on how the role is set up
  * Roles can *own* database objects (e.g. schema, tables, functions) and can asign privileges on those objects to other roles to control who has access to which objects
  * Additionally it is possible to assign *membership* in a role to another role, allowing the member role to use priviliges assigned to another role

#### Roles

  * Database roles are conceptually completely different from operating system users, but in practice a correspondance between the two is sometimes maintained
    * For example, a freshly initialised system always contains one pre-defined role -- 'superuser' -- which by default will have the same name as the operating system user that initialised the database cluster

  * Database roles are global across a database cluster and not per individual database
  * Every connection to a database is made using the name of a particular role
  * The role with which a database connection is made determines the initial access privileges for commands issued in that connection

##### Creating Roles

  * New roles are created using the `CREATE ROLE` sql command
  * As a minimum the command must be passed a name for the new role (though in practice additional options such as `LOGIN` and `PASSWORD` are also added to the command)

```
CREATE ROLE name;
```

  * There is a psql terminal command available `createuser` which acts as a wrapper around `CREATE ROLE`

  * Command reference: https://www.postgresql.org/docs/9.6/static/sql-createrole.html

##### Removing Roles

  * Removing a role is carried out using the `DROP ROLE` SQL command
  * As a minimum the command must be passed a name for the role to be dropped

```
DROP ROLE name;
```

  * It is possible to remove multiple roles with the same `DROP ROLE` command

```
DROP ROLE name_1, name_2;
```
  * Care must be taken when dropping roles, since roles can own database objects
  * Before dropping a role, any objects owned by the role must first be reassigned to other owners using the `REASSIGN OWNED` command or dropped using the `DROP OWNED` command in order to remove any dependencies on the role to be dropped
  
  * There is a psql terminal command available `dropuser` which acts as a wrapper around `DROP ROLE`

  * Command reference: https://www.postgresql.org/docs/9.6/static/sql-droprole.html

  * Documentation: https://www.postgresql.org/docs/9.6/static/database-roles.html and https://www.postgresql.org/docs/9.6/static/role-removal.html


#### Role Attributes

  * A database role can have a number of attributes that define its privileges and interact with the client authentication system. Attributes include:

    * `login privilege` allows the role to be used for as the intial role name for a database connection. A role with the `LOGIN` attribute can be considered the same as a 'database user'

    * `superuser status` bypasses all permission checks, except the right ot log in.

    * `database creation` allows users with that role to create and destroy databases within the database cluster

    * `role creation` allows a user with that role to create, alter and drop other roles, as well as grant or revoke membership to them. To perform such action on a 'superuser' role, the role itself must be a superuser

  * Documentation: https://www.postgresql.org/docs/9.6/static/role-attributes.html

#### Role Attributes

  * It is often convenient to group users together in order to facilitate the management of priviliges
  * When managed in this way privileges can be granted to or revoked from a group as a whole
  * In PostgreSQL this is done by creating roles that represent a *group* and then granting *membership* in the group to individual user roles

  * To do this you would create a role as normal for the group role using the `CREATE ROLE` command (typically this role will not have the `LOGIN` attribute, since it will not be used to connect to a database)
  * Once the group role exists, you can add or remove members using the `GRANT` or `REVOKE` commands

```
GRANT group_role TO role1, ... ;
REVOKE group_role FROM role1, ... ;
```

  * Group role membership can be granted to other group roles as well as to user roles (PostgreSQL doesn't differentiate between the two).
  * In this way a structure of *nested* group roles can be created
  * The database will not allow you to set up circular membership loops (i.e. if `role1` is a member of `role2`, `role2` cannot then be granted membership to `role1`)
  * It is not permitted to grant membership in a role to `PUBLIC`

  * Command reference (GRANT): https://www.postgresql.org/docs/9.6/static/sql-grant.html
  * Command reference (REVOKE): https://www.postgresql.org/docs/9.6/static/sql-revoke.html

##### Using Group Role Privileges

  * Members of a group role can use its priviliges in one of two ways, either by inheritance of those privileges or by temporarily assuming the role
  * To temporarily assume the role, a member of a role can use the `SET ROLE` command. In this state, the database session has access to the priviliges of the role, but any dataase objects created are considered to be owned by the group role and not the user role
  * Member roles that have teh `INHERIT` attribute, automatically have use of the privileges of all roles of which they are members, including any privileges inherited by those roles

  * Command reference: https://www.postgresql.org/docs/9.6/static/sql-set-role.html

<a name="Authentication"></a>
### Client Authentication 

  * *Authentication* is the proces by which the databse server establishes the identity of the client, determines whether the client is permitted to connect witht eh database and what privileges it has upon connection
  * PostgreSQL offers a number of different client authentication methods, detailed here: https://www.postgresql.org/docs/9.6/static/auth-methods.html

  * Documentation: https://www.postgresql.org/docs/9.6/static/client-authentication.html

<a name="Privileges"></a>
### Privileges 

  * Privileges are a a combination of DDL and DCL in that they allow a database user to interact with a created object in a specific way
  * When a database object (e.g. a table) is created, it is assigned an owner; this is usually the role that executed the creation statement
  * For most kinds of objects only the owner (or a superuser) can do anything with it
  * For other roles to use the object they must be granted privileges on the object
  * This is done using the `GRANT` command and takes the form:

```
GRANT privilege ON table TO role;
```

  * There are different types of priviliges: SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER, CREATE, CONNECT, TEMPORARY, EXECUTE, and USAGE.
  * The privileges available to an object vary depending on the object's type

Example:

```psql
GRANT UPDATE ON people TO karl;
```

  * In this example the user `karl` can now use the `UPDATE` command on the `people` table

  * Writing `ALL` in place of a specific privilege grants the user all appropriate privileges for that object type
  * Writing `PUBLIC` in place of a specific user grants all roles in the system the specified privilege

Example:

```psql
GRANT ALL ON people TO PUBLIC;
```

  * All roles in the system now have all available privileges on the `people` table

  * Documentation: https://www.postgresql.org/docs/9.6/static/ddl-priv.html

<a name="Row-Security"></a>
### Row Security Policies

  * In addition to the standard privilege system available through `GRANT`, tables can have *row security policies*
  * These restrict, on a per-user basis, which rows can be returned by a normal query, or inserted, updated, or deleted by data modification commands
  * This feature is known as Row_level Security
  * Row-Level Security is implemented by enabling it on a table and then creating one or more security policies
  * Row-Level Security is enabled using the `ALTER TABLE` command
  * Policies are created, altered or dropped using the `CREATE POLICY`, `ALTER POLICY`, and `DROP POLICY` commands

  * Documentation: https://www.postgresql.org/docs/9.6/static/ddl-rowsecurity.html
