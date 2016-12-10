# Sinatra Redirection

*Explain how redirection works and why it would be needed in a web application.*

### Route Not Found

  * Sinatra provides a special route `not_found` that is executed whenever it can't find a route to match an incoming request
  * You can define your own `not_found` route to over-ride the Sinatra default
  * The return value of the `not_found` block is handled just like the return value of any other route

Example:

```ruby
not_found do
  "That page was not found"
end
```

### Redirection

  * Routes don't have to return HTML code, they can also send th browser to a different url
  * This is done using the `redirect` method in Sinatra
  * It is common to redirect a user as a result of creating or updating some data

Example:
```ruby
not_found do
  redirect "/"
end

# This would redirect the user to the hompage for any `not_found` route
```
