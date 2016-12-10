# Sinatra Overview: Routes

*Start a new Sinatra project and write simple routes to handle requests.*

  * Sinatra makes it simple to write Ruby code that runs when a user visits a particular url.
    * It does this by providing a DSL for defining *routes*
    * Routes are how a developer maps a URL pattern to some Ruby code

Example:
```ruby
get "/" do
  # do something
end
```
When the app receives a request for the `/` route it will execute whatever code is defined in the block.

### Route Parameters

  * Sinatra allows you to use *parameters* as part of your route

Example:
```ruby
get "/show/:name" do
  params[:name]
end
```

  * Parameters can be made optional

Example:
```ruby
get '/posts.?:format?' do
  # matches "GET /posts" and any extension "GET /posts.json", "GET /posts.xml" etc.
end
```

  * This will match any route that starts with `/show` followed by a single segment.
  * Values passed to the application through the url in this way will appear in the `params` Hash.
  * The `params` Hash is pre-defined in Sinatra and is automatically made available in routes.

  * You can also use query parameters
  * Using query parameters is useful when you
    * Need parameters to be optional
    * There are multiple paramters with no logical hierarchical structure

Example:
```ruby
get '/posts' do
  # matches "GET /posts?title=foo&author=bar"
  title = params['title'] # => 'foo'
  author = params['author'] # => 'bar'
  # uses title and author variables; query is optional to the /posts route
end
```

### Before Filters

  * There are often things that need to be done on every request to an application, such as checking a user is logged in or assigning a variable to some data.

  * Common code can be moved into a `before` block so it only needs to be run once rather than in every route.
  * Sinatra will run the code in a `before` block before running the code in a matching route
  * A `before` block is a good place to set up globally needed data.
  * If a certain instance variable is referenced in a layout, the code that provides that variable is a good candidate to be put in a `before` block, but only if the value of that variable is independent of the route being run.

Example:

```ruby
before do
  # do some stuff
end
```


