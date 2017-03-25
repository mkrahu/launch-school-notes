# Optimising SQL Queries

  * [N + 1 Queries](#N-plus-1)
  * [Pushing Down Operations to the Database](#Push-to-DB)
  * [PostgreSQL Explain Statement](#Explain)

<a name="N-plus-1"></a>
## N + 1 Queries

  * The N + 1 query problem is a common performance anti-pattern
  * The problem occurs when code nees to load children of a parent-child relationship
  * Typically when writing SQL queries for use in a web-application, you want to keep your queries fairly general so that they can be re-used.
  * Keeping queries general, however, can sometimes lead to N + 1 issues
    * This happens when you have to query the database once to retrieve some intial data and then query it again to retrieve data related to the intial data

Example:

  * Say you have a table called `customers` and another table called `orders`; if you wanted to display in your web app the number of orders per customer, you could do somthing like this:

Assume you have a route defined in your app which queries the database to retrieve data from the `customers` table

Then in your view template, you iterate through every row of that customer data in order to calculate the number of orders 

```html
<ul id="customers">
  <% @customers.each do |customer| %>
    <li>
        <h2><%= customer[:name] %></h2>
        <p>Orders: 
          <%= count_orders(customer[:id]) %>
        </p>
    </li>
  <% end %>
</ul>
```

Imagine that `count_orders()` in this context is a helper method that queries the `orders` table, counting the number of orders for that customer.

For each customer in the list you call the helper method and thus query the `orders` table once, this is 'N'. The + 1 is the initial query of the `customers` table.

If you have hundreds, or even thousands, of customers in the `customers` table then this would be many queries, which is not very optimal in terms of efficiency

You could replace all these queries with a single query that joined the two tables to retrieve all the data required by this view. This query would be less 'general' (since it is optimised for this particular view) and so probably couldn't be resused elswhere, but it would be a lot more efficient since you would only be required to query the database once, instead of hundreds or thousands of times.

<a name="Push-to-DB"></a>
## Pushing Down Operations to the Database

  * When building a database-backed web application there are design decision to be made regarding which operation you want to carry out at the database level and which operations you want to carry out at the application level
  * For example, you could keep your database queries very general, return all the data from a particular table and then manipulate the data within the application code
  * This can, however be very innefficient. You have to return a large amount of data across the network in order to manipulate it in a way that you could easily do at the database level. One example where you might want to push operations down to the database is counting agregate values

<a name="Explain"></a>
## PostgreSQL Explain and Comparing SQL Statements

https://launchschool.com/exercises/27dac993
https://launchschool.com/exercises/549674f5
https://www.postgresql.org/docs/9.6/static/performance-tips.html (Explain)