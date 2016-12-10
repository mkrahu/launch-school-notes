# Sinatra Tutorials

  * Sinatra is a [Domain Specific Language](https://en.wikipedia.org/wiki/Domain-specific_language) (DSL) for creating Ruby Web Applications
  * Sinatra is essentially a framework that allows you to leverage its functionality to build web applications on top of it
  * Sinatra itself is effectively built on top of another, lower-level, framework - Rack (which it uses as an HTTP parser)
  

1.  Installing Sinatra

  * It is installed as a RubyGem

```bash
gem install sinatra
```

2. Using Sinatra

  * Sinatra needs to be required in the main application file of the web app (e.g. `myapp.rb`)

```ruby
require 'sinatra'
```

  * You can then run the Sinatra app like any Ruby application

```bash
ruby myapp.rb

# or if you have the shotgun gem installed

shotgun myapp.rb
```

  * `shotgun` is a gem that automatically restarts the server every time a page is refreshed so you don't have to stopand restart the program every time you make a change to the file

3. Basic Routes

  * A route in Sinatra comprises of a http method (`get` or `post`) a url matching pattern and a `do..end` block
    * `get` routes will respond to `get` requests for urls that match the pattern
    * `post` routes will respond to `post` requests for urls that match the pattern
    * you can have a `get` route and a `post` route that both use the same pattern
    * when a match is found for the request, Sinatra will run whatever code is in the block and return the last evaluated expression from teh block to the client (like a Ruby method)

#### GET

Example:

```ruby
get '/' do
  "Hello, World!"
end
```

#### POST

  * `POST` requests are often made by submitting data via a form

Example:
```html
<form action="/form" method="post">
  <input type="text" name="message">
  <input type="submit">
</form>
<!-- clicking on 'Submit' will send a post request to '/form' -->
```

  * To match this request we must have an equivalent `post` route defined in our app.

Example:
```ruby
post '/form' do
  "You said '#{params[:message]}'"
end

# If 'hello' is submitted via the form, the rouote will return the string "You said hello" to the client
```

  * Here a `get` request from the client for `/` will return the string "Hello, World!" to the client

4. Accessing URL Parameters

  * You can query a portion of the url and add that portion as a value to the `params` Hash in Sinatra
  * To do this you must define a route with a symbol replacing that portion of the url in the matching pattern
  * You can then reference the value from the `params` hash using the same symbol

```ruby
get '/hello/:name' do
  "Hello there, #{params[:name]}."
end

# If you make a `get` request for '/hello/karl' then the string 
# "Hello there, karl" is returned to the client
```

  * The parameter is simply a String object in Ruby and so the usual Ruby string methods are available (`reverse`, `upcase`, `split` etc..)

  * You can access multiple parameters from within the url

Example:
```ruby
get '/hello/:name/:city' do
  "Hey there #{params[:name]} from #{params[:city]}."
end

# If you make a `get` request for '/hello/karl/menai-bridge' then the string 
# "Hey there karl from menai-bridge" is returned to the client 
```

  * Sinatra also allows you to retreive wildcard query strings - known as `splat`

Example:
```ruby
get '/more/*' do
  params[:splat]
end

# Anything in the url after 'more/' is accessible through the `:splat` key in the `params` Hash

params[:splat]
```

#### PUT and DELETE

  * `PUT` and `DELETE` are two other methods of `HTTP` alongside `GET` and `POST` (and other methods)
    * `GET` is used for *requesting* content
    * `POST` is generally used for *creating* content
    * `PUT` is generally used for *updating* content
    * `DELETE` is used for *destroying* content
  * Although they are valid `HTTP` methods, `PUT` and `DELETE` requests are not actually supported by web browsers
  * `PUT` and `DELETE` requests can be *faked* by including a hidden field in a web form

Example:
```html
<form action="/<%= @note.id %>" method="post" id="edit">
    <input type="hidden" name="_method" value="put">
    <textarea name="content"></textarea>
    <input type="submit">Update</input>
  </form>
  <!-- here the hidden field has a name of '_method' and a value of 'put' -->
```

  * Using this hidden `'_method'` field with a value of `'put'` or `'delete'` allows the use of `PUT` and `DELETE` routes in Sinatra

Example:
```ruby
put '/:id' do
  # route implementation goes here
end
```

#### Other Method Routes
```ruyby
get '/' do
  .. show something ..
end

post '/' do
  .. create something ..
end

put '/' do
  .. replace something ..
end

patch '/' do
  .. modify something ..
end

delete '/' do
  .. annihilate something ..
end

options '/' do
  .. appease something ..
end

link '/' do
  .. affiliate something ..
end

unlink '/' do
  .. separate something ..
end
```

5. Views

  * Sinatra views can be created using templates, for example using a templating language such as `erb`
  * `erb` stands for **Embedded Ruby** - you can *embed* Ruby code into HTML using special tags
  * These tags will be parsed by Sinatra before the resultant HTML is sent othe browser in the HTTP Response
  * Sinatra automatically looks for views in a `views` directory in the project root
  * `erb` files are suffixed `.erb`
  * views are referenced in routes using the `erb` keyword followed by a symbol represenation of the filename (without the suffix)
  * This must be the last thing evaluated in the `do..end` block in order to be returned

Example:
```ruby
get '/form' do
  erb :form
end
```

### Refrences

  * [Sinatra Documentation - Getting Started](http://www.sinatrarb.com/intro.html)
  * [Singing With Sinatra](https://code.tutsplus.com/tutorials/singing-with-sinatra--net-18965)
  * [Singing with Sinatra - Recall App](https://code.tutsplus.com/tutorials/singing-with-sinatra-the-recall-app--net-19128)
