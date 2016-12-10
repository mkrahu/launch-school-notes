# Sinatra Cheatsheet

-----

### Table of Contents

  * [Installation](#installation)
  * [Usage](#usage)
    * [Routes](#routes)
    * [Views/ Templates](#views) 
    * [Filters and Helpers](#filters)    
  * [Configuration](#configuration)
  * [Environments](#environments)
  * [Adding Javascript](#javascript)
  * [Security and Encryption](#security)
  * [Testing](#testing)
  * [Deploying a Sinatra App to Heroku](#deploying)


-----

<a name="installation"></a>
## Installation

  * Installed as a RubyGem
```bash
gem install sinatra

#or

sudo gem install sinatra
```

<a name="usage"></a>
## Usage

  1. Create a `.rb` file
  2. In the file, `require 'sinatra'`
  3. Include at least one route
  4. Run the application file

```ruby
# myapp.rb
require 'sinatra'

get '/' do
  'Hello world!'
end
```

```bash
ruby myapp.rb

# or, if you have the shotgun gem installed:

shotgun myapp.rb
```

Going to `http://localhost:4567` (or `http://localhost:9393` if using `shotgun`) will return a html page containing `'Hello world!'`

#### Web App Server - `thin`

  * If the [`thin` web application server](https://github.com/macournoyer/thin) is installed, Sinatra will automatically use this

<a name="routes"></a>
### Routes

  * Sinatra Routes are HTTP methods paired with a URL matching pattern.
  * Each route is associated with a block
  * An HTTP Request where the HTTP method matches the route method **and** the Request URI matches the route matching pattern, will cause the code in the block to be executed.
  * The return value of the block determines part or all of the HTTP response and at least the Response Body
  * Most commonly the return is a string, but other values are accepted
  * You can return any object that would either be a valid Rack response, Rack body object or HTTP status code:
    * An Array with three elements: [status (Fixnum), headers (Hash), response body (responds to #each)]
    * An Array with two elements: [status (Fixnum), response body (responds to #each)]
    * An object that responds to #each and passes nothing but strings to the given block
    * A Fixnum representing the status code

```ruby
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

  * Routes are matched in the order they are defined - i.e. the first route that matches the request is invoked

  * Although it is recommended that (at least some of) the HTTP Response elements form the return value of the route block, it is possible to explicitly set the elements separately
```ruby
get '/foo' do
  status 418
  headers \
    "Allow"   => "BREW, POST, GET, PROPFIND, WHEN",
    "Refresh" => "Refresh: 20; http://www.ietf.org/rfc/rfc2324.txt"
  body "I'm a tea pot!"
end
```

##### Setting Body, Status Code and Headers

  * It is recommended to set the status code and response body with the return value of the route block. However you can also set status, headers and body at an arbitrary point in the execution flow with pre-defined helper methods.

```ruby
get '/' do
  status 418
  headers \
    "Allow"   => "BREW, POST, GET, PROPFIND, WHEN",
    "Refresh" => "Refresh: 20; http://www.ietf.org/rfc/rfc2324.txt"
  body "I'm a tea pot!"
end
```

##### Halting

  * To immediately stop a request within a route you can use the `halt` helper method. `halt` can be used on its own or passed arguments to specify the status, headers, or combination of these, or even eith a template.

```ruby
halt
halt 410
halt 'this is the body'
halt 401, 'go away!'
halt 402, {'Content-Type' => 'text/plain'}, 'this is the body'
halt erb(:error)
```

#### Route Parameters

  * Route patterns can include named parameters

##### Named Parameters

  * Name parameters are accessible via the `params` hash
```ruby
get '/hello/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar" etc.
  # params['name'] is 'foo' or 'bar' etc.
  "Hello #{params['name']}!"
end
```

  * Named parameters are also accessible via block parameters
```ruby
get '/hello/:name' do |n|
  # matches "GET /hello/foo" and "GET /hello/bar" etc.
  # params['name'] is 'foo' or 'bar' etc.
  # n stores params['name']
  "Hello #{n}!"
end
```

##### Query Parameters

  * Routes can use query parameters
```ruby
get '/posts' do
  # matches "GET /posts?title=foo&author=bar"
  title = params['title']
  author = params['author']
  # uses title and author variables; query is optional to the /posts route
end
```

##### Wildcard Parameters

  * Route matching patterns can also include splat `*` (wildcard) parameters
  * Splat parameters are accessible via the the params hash, using the `'splat'` key
  * The value is an array with one or more strings representing the wildcards in order
```ruby
get '/say/*/to/*' do
  # matches /say/hello/to/world
  params['splat'] # => ["hello", "world"]
end

get '/download/*.*' do
  # matches /download/path/to/file.xml
  params['splat'] # => ["path/to/file", "xml"]
end
```

  * Splat parameters can be used with a block
```ruby
get '/download/*.*' do |path, ext|
  [path, ext] # => ["path/to/file", "xml"]
end
```

  * Note: putting a `*` at the end of a route will make everything after that point part of the splat
```ruby
get '/levels/*'
  # matches '/levels/first/second/third' 
  params['splat'] # => ['first/second/third']
end
```

##### Optional Parameters

  * Routes can have optional parameters
```ruby
get '/posts.?:format?' do
  # matches "GET /posts" and any extension "GET /posts.json", "GET /posts.xml" etc.
end
```

### Sessions

  * A session is used to keep state during requests

#### Enabling Sessions

  * To use sessions they must be enabled

```ruby
enable :sessions
```

#### Setting and Retrieving Data

  * Using sessions in this way stores all data in a cookie
  * The session object is a hash of data
  * Values can be set and accessed via the session object
```ruby
get '/' do
  "value = " << session[:value].inspect
end

get '/:value' do
  session['value'] = params['value']
  redirect '/'
end
```

#### Session Secrets

  * The session data in the cookie is signed with a secret
  * By default a random secret is generated by Sinatra (this will chnge every time the application is started)
  * You can manually set the secret
```ruby
set :session_secret, 'super secret'
```

  * Further configuration can be carried out on the session cookie - such as setting it for use on a specific domain, or subdomains.
```ruby
set :sessions, :domain => 'foo.com' # => just the 'foo.com' domain

set :sessions, :domain => '.foo.com' # => any sub-domain of the 'foo.com' domain
```

#### Rack Session Middleware

  * As an alternative the standard session object, any Rack session middleware can be used instead
  * If using Rack session middleware, do not `enable :sessions`, use `use` instead
```ruby
use Rack::Session::Pool, :expire_after => 2592000
```

<a name="views"></a>
### Views/ Templates

  * Templates (or *view templates*) are files that contain text that is converted to HTML before being sent to the client as the body of the HTTP response
  * There are lots of different *templating languages*; they all provide different ways to define what HTML to generate and how to embed dynamic values
  * Each templating language is exposed via its own rendering method
  * These methods simply return a string, which forms the HTTP Response body
```ruby
get '/' do
  erb :index
end
```

  * Template methods take a second argument, which is a hash of options
  * Layout can be one of the items in the hash
```ruby
get '/' do
  erb :index, :layout => :post
end
```

  * By default templates are loaded from the `views` directory
  * If the `views` directory contains a file called `layout` of the same templating language this will be used by default as the layout

#### Layouts

  * Layouts are used to embed templates (they are effectively templates that wrap around other templates)
  * Layouts are used to remove duplication between templates

#### ERB

  * ERB, whose name comes from *embeded Ruby*, is a commonly used templating language
  * ERB uses standard HTML with special tags for outputting dynamic values
  * The percentage notation is used to define a dynamic tag
  * A `%=` tag is used to output a specific value in the form of an instance variable made available to the template
```ruby
<h1><%= @title %></h1>
```

  * A simple `%` tag can be used to execute any Ruby code, such as with a `do..end` block
```ruby
<ul>
  <% @list_items.each do |item| %>
    <li><%= item %></li>
  <% end %>
```

  * Note: a `%==` tag escapes any HTML input and can be used as a security measure to prevent html/ js injection

##### Yield

  * To use a layout with erb, the layout needs to include a erb tag with a `yield` keyword as the object which is output
  * This outputs the selected template in the place in the layout where `yield` is output

```ruby
<!doctype html>
<html>
  <head>
    <title><%= @title %></title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

##### Tilt

  * When using erb it is generally a good idea to `require 'tilt/erubis'` in your application file
  * Tilt is a thin interface over a bunch of different Ruby template engines in an attempt to make their usage as generic as possible.
  * By requiring `'tilt/erubis'` we are specifying that we are using the `erubis` implementation of erb
    * `erb` is a templating language - actually named `eruby`, and is included in Ruby by default
    * `erubis` is a particular implementation on `erb` that is can be required via `tilt` (though you could also just `require 'erubis'`)
    * `erubis` has some advantages over standard `erb` such as performance and also [providing the functionality](http://www.sinatrarb.com/faq.html#auto_escape_html) to *auto-escape* content - which helps build safer applications 
```ruby
require 'tilt/erubis'
set :erb, :escape_html => true
```

##### Accessing Variables

  * In order to access a varibale in a template, the varaible must be declared in a route that calls that template (or must already be available in the wider scope of the application file)
```ruby
get '/' do
  @title = 'My Title'
  erb :index
end
```

```ruby
# index.erb
<h1><%= @title %></h1>
```

#### Other Templating Languages

  * As well as `erb` other templating languages are available for use with Sinatra.
  * Another commonly used templating language is `haml`
  * There are also many other templating languages available, for example:
    * Nokogiri
    * Builder
    * Sass
    * SCSS
    * LESS
    * Liquid
    * Markdown
    * RDoc
    * Stylus

<a name="filters"></a>
### Filters and Helpers

#### Before Filters

  * Before filters are evaluated *before* each request within the same context as the route and can modify the request and response
  * Instance variables set in filters are accessible by routes and templates
  * One common use-case for a before filter is to checkif a user is logged in before allowing certain actions (e.g. actions other than read)

```ruby
before do
  @greeting = 'Hello'
end

get '/:name' do
  "#{@greeting} #{params['name']}!" # => e.g. 'Hello Karl!'
end
```

#### After Filters

  * After filters are evaluated after each request within the same context as the routes, and can also modify the request and response
  * Instance variables set in before filters and routes are available in after filters
  * Note: unless the `body` method is used, rather than just returnign the body within the route, this is not available to an after filter as it is generated later on

#### Filter Patterns

  * Filters can take a pattern, causing them only to be evaluated if the pattern is matched

```ruby
before '/private/*' do
  authenticate!
end
```

#### Helpers

  * The top-level `helpers` method can be used to define helper methods for use in route handlers and templates
  * Within the `helpers` block, methods are defined as they normally would be.

```ruby
helpers do
  def hello(name)
    "Hello #{name}"
  end
end

get '/:name' do
  hello(params['name'])
end
```

<a name="configuration"></a>
## Configuration

  * A `configure` block can be used to set configuration options
  * The configure block is run once, when the application starts

```ruby
configure do
  # setting one option
  set :option, 'value'

  # setting multiple options
  set :a => 1, :b => 2

  # same as `set :option, true`
  enable :option

  # same as `set :option, false`
  disable :option

  # you can also have dynamic settings with blocks
  set(:css_dir) { File.join(views, 'css') }
end
```

  * Options can be configured for different environments

```ruby
configure :production do
  ...
end

# or

configure :production, :test do
  ...
end

```

<a name="environments"></a>
## Environments

  * There are three pre-defined environments `development`, `production` and `test`.
  * Environments can be set through the `RACK_ENV` environment variable when the application is started

```bash
RACK_ENV=production ruby my_app.rb
```
  * The default value is `development`. In `development` alltemplates are reloaded between requests and `error` handlers display stack traces
  * You can use pre-defined `development?`, `test?` and `production?` methods to check the current environment setting

```ruby
get '/' do
  if settings.development?
    "development!"
  else
    "not development!"
  end
end
```

<a name="javascript"></a>
## Adding Javascript

  * Sometimes you may not want to reload the entire page when performing an action in your web app.
  * In these situations you can use javascript in your templates to perform the action for you on the client-side

  * One example of usage would be if you had a form to destroy some data, you could add an even listener via javascript with creates an alert message using the `confirm` jQuery method and only submits the form if `ok` is `true`

```javascript
$(function() {

  $("form.delete").submit(function(event) {
    event.preventDefault();
    event.stopPropagation();

    var ok = confirm("Are you sure? This cannot be undone!");
    if (ok) {
      this.submit();
    }
  });

});
```

  * Another use for javascript is to make *asynchronous* HTTP Requests directly from the front-end
  * This is known as an XHR call (XmlHttpRequest), commonly referred to as AJAX
  * For example, if you wanted to delete one item from a list, you could send and XHR request to the application to delete the item, but rather than reload the page, simply remove the item from the DOM in the front-end
  * This can be done in jQuery using the `ajax` method. In this example the method uses the `action` and `method` attributes from the `<form>` element to make a request to the to the app which will be executed by Sinatra using the matching route.

```javascript
$(function() {

  $("form.delete").submit(function(event) {

      var request = $.ajax({
              url: form.attr("action"),
              method: form.attr("method")
            });

  });

});
```

  * The route can be amended to handle AJAX (XHR) requests in a particular way by querying the `env` method (which returns the `env` hash) to check if the value for `'HTTP_X_REQUESTED_WITH'` is equal to `'XMLHttpRequest'`

```ruby
post "/list/:item_id/destroy" do
  id = params[:id].to_i
  session[:lists].delete_at(id)
  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    status 204
  else
    redirect "/list/"
  end
end
```

  * The `204` status code is a success status with no content

<a name="security"></a>
## Security and Encryption

### Code Injection

  * Code injection is a security issue that many web applications have to deal with.
  * One example would be someone submitting some Javascript code via an HTML form

```html
<script>alert("This code was injected!");</script>
```
  
  * If this code is submitted via a form and is subsequently output by the application to an HTML page, it will create an alert pop-up in the browser, although this is a pretty benign example

#### Sanitising HTML

  * One way of dealing with code injection is to sanitise HTML that is input via forms
  * Rack allows you to *escape* any HTML characters that are input by users (e.g. via a form) using a method called `Rack::Utils.escape_html`

```ruby
helpers do
  def sanitize(input)
    Rack::Utils.escape_html(inoput)
  end
end
```

  * This can then be used in a template view

```html
<h3><%=sanitize @some_var %></h3>
```

  * One drawback to this approach is that you have to remember to do it everywhere in every template where you output user-submitted content
  * A more thorough approach is to use a configuration setting to automatically escape html throughout the app

```ruby
configure do
  set :erb, :escape_html => true
end
```

  * When using this setting you need to change the way that you woudl normally output content by using a double equals sign `<%==` instead of a single one `<%=`

```html
<h3><%== @some_var %></h3>
```

### Bad Input

  * Another issue that applications commonly have to deal with is handling bad inoput
  * Say for example you had a route that had a parameter for a user id, and the url included an id that didn't exist, Sinatra would likely error (assuming your app tried working with a `nil` value in a way that would throw an exception)
  * A solution to this is to validate parameters that are included as part of a url

```ruby
def load_users(user_id)
  users = session[:users][user_id] if user_id
  return users if users

  session[:error] = "The specified user was not found."
  redirect "/"
end

get "/users/:id" do
  @user_id = params[:id].to_i
  @user = load_users(@user_id)
  erb :user, layout: :layout
end
```

### HTTP Methods and Security

  * There is a common mis-conception that `POST` requests are more secure for submitting data (via a form) than `GET` requests
  * In reality the data from both types of requests is easily available in the request itself
  * The only difference is that with a `GET` Request the data appears as parameters in the URL, with `POST` Requests the data is in the Body of the Request
  * One way to make a Request more secure is to use HTTPS rather than HTTP

### User Accounts

  * One way of securing an application is to limit certain actions to only signed-in users
  * A simple way to do this would be to create a sign-in form which, when submitted, sends a `POST` request to a sign-in route

```ruby
post "/users/signin" do
  if params[:username] == "admin" && params[:password] == "secret"
    session[:username] = params[:username]
    session[:message] = "Welcome!"
    redirect "/"
  else
    session[:message] = "Invalid credentials"
    status 422
    erb :signin
  end
end
```

  * If the correct combination of `username` and `password` are submitted then the `username` is added to the `params` hash
  * You could have an equivlent `signout` route that removes the `:username` key from the params hash

```ruby
post "/users/signout" do
  session.delete(:username)
  session[:message] = "You have been signed out."
  redirect "/"
end
```

  * The fact that the user is signed in can then be checked for when executing other routes
    * You could create one method to check if the `:username` session key exists and another to redirect with a warning message if the first method returns false

```ruby
def user_signed_in?
  session.key?(:username)
end

def require_signed_in_user
  unless user_signed_in?
    session[:message] = "You must be signed in to do that."
    redirect "/"
  end
end
```
  * In your routes you can then add the `require_signed_in_user` method at the start

```ruby
get "/:filename/edit" do
  require_signed_in_user

  # rest of route block
end
```

#### Working with YAML files

  * In a non-DB app, YAML files can be useful for storing data, such as user data
  * For example username and password combinations could be stored using YAML

```YAML
# users.yml
---
admin: secret
```

  * You could have a sign-in route that checked user credentials using the data in the YAML file

```ruby
require "yaml"

post "/users/signin" do
  credentials = YAML.load_file(users.yml)
  username = params[:username]

  if credentials.key?(username) && credentials[username] == params[:password]
    session[:username] = username
    session[:message] = "Welcome!"
    redirect "/"
  else
    session[:message] = "Invalid credentials"
    status 422
    erb :signin
  end
end
```

  * You can also nest data in a YAML file

```YAML
users.yaml
---
:karl:
  :email: karl@gmail.com
  :avatar: karl.png
  :address:
  - 5 Some Street
  - Some Town
  - AA11 2B
```

```ruby
@users = YAML.load_file('users.yaml') # => {:karl=>{:email=>"karl@gmail.com", :avatar=>"karl.png", :address=>["5 Some Street", "Some Town", "AA11 2B"]}}
```

#### Encryption

  * Storing passwords as plain text isn't very secure, and shoul **never** be done in a production application
  * One solution is to encrypt passwords using a hashing algorithm
    * User-submitted passwrods can then be hashed using the same hashing algorithm and the two hashed passwords compared
  * One hashing algorithm that is commonly used is `bcrypt`
    * `bcrypt` is designed to be slow - this helps deter brute-force attacks (where hackers use the same algorithm to iterate through a table of commonly used passwords to find a match)
    * A `bcrypt` hashed password is comprised of two parts - the 'salt' which is used as part of the encryption process, and the 'digest' which is the encrypted password itself.
    * By randomly generating the salt on a per-user basis, it means that for *each* encrypted password a hacker would have to run the bcrypt algorithm against a 'common passwords' table in order to brute-force it

    * To implement password hashing using `bcrypt` in a Sinatra app you would need to install the `bcrypt ` gem and then require `brypt` in your app file

```ruby
require "bcrypt"

def valid_credentials?(username, password)
  credentials = YAML.load_file(users.yml)

  if credentials.key?(username)
    bcrypt_password = BCrypt::Password.new(credentials[username])
    bcrypt_password == password
  else
    false
  end
end
```
  
  * You could then have a sign-up route that hashes the password when the user initially signs up

```ruby
post "/users/signup" do
  username = params['username']
  password = BCrypt::Password.create(params['password'])
  File.open("#{users_path}users.yml", 'a') do |file|
    file.puts "#{username}: #{password}"
  end
  session[:username] = username
  session[:success] = "User account created. Welcome, #{username}!"
  redirect "/"
end
```

<a name="testing"></a>
## Testing

### Testing Basics

  * Development of a web application can be facilitated by testing steps along the development path - such as adding a new route
  * Testing can be done via the use of a test suite, using a testing framework like Minitest
  * Since Sinatra is built on top of the Rack library, testing Sinatra applications can take advantage of the `Rack::Test` library

  * Say we wanted to test a simple route

```ruby
app.rb

require "sinatra"

get "/" do
  "Hello, world!"
end
```

  * We could create a test file

```ruby
app_test.rb

ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../app"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_equal "Hello, world!", last_response.body
  end
end
```

  * Setting `RACK_ENV` to `'test'` tells Sinatra and Rack that the context the requests are being issued in is a test environment, so it doesn't need to start up a web server
  * The `minitest` and `rack/test` libraries are required
  * The app file to be tested is required
  * A test class, in this case called `AppTest`, is defined, which sub-classes from `Minitest::Test`
    * The class mixes in the `Rack::Test::Methods` module to gain access to some useful helper methods. These methods expect a method called `app` to exist and return an instace of a Rack application when called, so an `app` method is defined in the class
  * The tests themselves are defined as normal Minitest tests except that in this instance HTTP Requests are made and the assertions test the reponse to that request using the `last_response` method
  * Test have access to `status`, `body` and `[]` (headers - via the header key) to perfom assertions on

### Isolating Test Execution

  * Normally you would want to isolate your tests to use separate sets of data for the testing and development environments
  * In addition you ideally want to take a SEAT approach to testing:
    * **Set up** the necessary objects.
    * **Execute** the code against the object we're testing.
    * **Assert** the results of the execution.
    * **Tear down** and clean up any lingering artifacts.

  * One strategy is to create a separate directory for test data. The directory paths can be set by a method which checks for which environment is currently running

```ruby
# app.rb

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end
```

  * It would also be normal to create the `test/data` directory before every test and destroy it after every test - the setup and teardown steps
  * You can do this by using the `setup` and `teardown` methods of `Rack::Test`
  * By requiring the `fileutils` module in your test file you can use some useful methods for working with directories and files, such as creating and destroying directories

```ruby
# app_test.rb
require "fileutils"

  ...

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end
```

  * You could then define a method to create a document in the test directory which can be used in certian tests

```ruby
# test/app_test.rb

  def create_document(name, content = "")
    File.open(File.join(data_path, name), "w") do |file|
      file.write(content)
    end
  end

  ...

  def test_index
    create_document "temp.md", "some content for the document"
    
    # rest of test
    
  end
```

<a name="deploying"></a>
## Deploying a Sinatra Application to Heroku

### Setting up an app for Deployment to Heroku

  * Deploying an app to Heroku requires having the [Heroku Toolbelt] installed and a Heroku account set up and for the app to be committed to a git repo
  * In `Gemfile` you need to specify the version of Ruby t be used
  * You can configure the app to use a production web server, such as Puma, in the `gemfile` by using a group

```ruby
group :production do
  gem "puma"
end
```

  * Note: Always run `bundle install` after making changes to a project's `Gemfile`. 

  * Create a `config.ru` file in the root of the project. This tells the webserver how to start the application

```ruby
require "./my_app"
run Sinatra::Application
```

  * Create a file called `Procfile` in the root of the project. This defines what types of processes are provided by the application and how to start them and will include the server settings for the specified app server

```ruby
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
```

  * You can test the `Procfile` locally by running `heroku local`
  * You should be able to visit the application at `localhost:5000` and test it out
  * If everything appears to be working, you can proceed with the next step: deploying to Heroku

### Deploying an app to Heroku

  1. Create a Heroku application using `heroku apps:create $NAME`, where `$NAME` is the application name you wish to use
    * If you don't provide this value, Heroku will generate a random application name for you
  2. Push the project to the new Heroku application using `git push heroku master`
    * Heroku only looks at the `master` branch of a repository when processing a `git push`, you can specify another local branch with `git push heroku local-branch-name:master`
  3. Visit your application and verify that everything is working
  4. Heroku to automatically sets the RACK_ENV environment variable to "production". To see how this works, run heroku config in the app's directory after deploying to Heroku

```ruby
$ heroku config
=== my-app Config Vars
LANG:     en_EN.UTF-8
RACK_ENV: production

```

## Extensions



## Sources

  * [Sinatra Docs](http://www.sinatrarb.com/intro.html)
  * [How to Handle Passwords](http://dustwell.com/how-to-handle-passwords-bcrypt.html)
  * [Collections in YAML](http://yaml4r.sourceforge.net/doc/page/collections_in_yaml.htm)