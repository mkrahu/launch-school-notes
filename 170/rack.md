# Rack

## Rack Overview

### Basics

  * Rack provides a minimal interface between webservers that support Ruby and Ruby frameworks. 
  * It is technically a low-level framework but gives back a lot of functionality - writing even a little bit of code allows use to set up our own frameworks on top of Rack.
  * At its most basic level, Rack is an HTTP parser
  * It acts as a layer in between a web server application and a (Rack-based) Ruby framework - such as Sinatra or Rails
  * It was developed so that Ruby frameworks wouldn't need to implement their own HTTP functionality as it deals with that for you
  * It puts in place a set of conventions for enabling communication between a Ruby framework and a browser

### Request/ Response, `env` and `call`

  * A typical request from a client to a server would look something like this:
```bash
GET /users HTTP/1.1
Host: localhost
Connection: close
```

  * A typical response from a server to a client would look something like this:
```bash

HTTP/1.1 200 OK
Content-Length: 25
Content-Type: text/html
<html>
...
</html>
```

  * A framework such as Sinatra or Rails does not deal with these requests and responses directly.
  * Rack converts the HTTP request into a format that the framework can work with easily - a hash of the HTTP Request headers

Example `env` hash:
```bash
env = {
  'REQUEST_METHOD' => 'GET',
  'PATH_INFO' => '/users',
  'HTTP_VERSION' => '1.1',
  'HTTP_HOST' => 'localhost',
  ...
  ...
```

  * In order to work with Rack, a Ruby application/ framework needs to have an object that responds to a method named `call`
  * The `call` method should takes the `env` hash as a parameter
  * The `call` method should return an array with three elements:
    * The HTTP Response Code
    * A Hash of HTTP Response Headers
    * The Response body, which must respond to the `Enumerable#each` method
  * Any app/ framework (such as Sinatra or Rails) which conforms to these rules is a 'Rack application'
  * 'Rack applications' can work on most modern 'rack-based' web-app servers (Unicorn, Puma, Passenger, Thin, etc..)

Example `call` return value:
```bash
[
  200,
  {
    'Content-Length' => '25',
    'Content-Type' => 'text/html'
  },
  [
    '<html>',
    '...',
    '</html>'
  ]
]
```

  * The server takes this array and converts it to a valid HTTP response which it sends to the client

  * Rack acts as a *specification* of these two things:
    * What the server should send to the app
    * What the app should return to the server

## Rack Deep Dive

Tyler's notes on the Rack tutorial video

#### These notes are based on this [Rack Tutorial](https://www.youtube.com/watch?v=iJ-ZsWtHTIg&list=WL&index=2)
#### The Rack::Builder [source code](https://github.com/rack/rack/blob/master/lib/rack/builder.rb) is also referenced.
#### I also made some changes myself so that this tutorial conforms to current versions of Rack, Ruby, and Rails

-----

### Table of Contents

[Why Rack Was Created](#introduction)  
[A Simple Application- Hello World](#hello_world)  
[env](#env)  
[Combine one app with another](#combine_apps)  
[A Deeper Look](#deeper_look)  
[More Building Blocks for EnvironmentOutput](#more_for_environmentout)  
[Middleware](#middleware)  
[Refactoring The Response](#refactor_response)  
[Cleaning Up](#clean_up)  
[Mapping](#mapping)  
[Metal](#rails_metal)  

-----

IMPORTANT: If you are having trouble at some point returning a response or using `each`, then please refer to my NOTE that I list later on. For responses, just point 1 should do.

<h3 id="introduction"> Why was Rack created and what is Rack?</h3>

The creator of Rack noticed that there was a lot of code duplication between frameworks the basically all do the same thing. Any yet all Ruby developers seem to be writing their own handlers for the web server they wan to use. In the end, HTTP is actually pretty easy, you get a request and you return a response

Rack works as middleware. It falls into that category because it sits in the middle, between your web server and your web application. It helps handle communication between the server and the application itself.

Rack parses HTTP but it also does quite a bit more. Here are some modules that are included with Rack:

- Request
- Response
- URLMap
- Session
- Logging
- Auth
- Cookies
- Exceptions

<h3 id="hello_world"> A Simple Rack Application - Hello World</h3>

We can run a rack app through a rackup file(extension .ru)

Here we’ll use an easy example of Hello World. This rack appliction must work with one very important method, `call(env)`

The `call` method must return an array, and that array should contain 3 element.

1. A Status Code represented by a String
2. Headers - These will be in the form of key-pairs inside a hash.  The key will be a header name and the corresponding value will be the value for that header.
3. Response - This object can be anything, as long as that object can respond to an `each` method. More on that later.

```ruby
# Here is what our simple Rack app will look like.
class HelloWorld
  def call(env)
    out = "<ul>\n"
    env.each {|key,value| out += "<li>#{key}=#{value}</li>"}
    out += "\n</ul>"
    ["200",{"Content-Type" => "text/html"}, [out]]
  end
end
run HelloWorld.new
```

To run it, we can hop into the terminal and use the `rackup` command.

```ruby
$ rackup app.ru -p 9595
```

The -p option at the end there allows us to specify which port we want out application to run on. I chose 9595, but it could be any other number. It will accept any valid port number between 0 and 65535\. Typically, we’ll use a port number that is 4 digits in length.

If we try to access our application on port 9595, the following is the response we get.

```ruby
$ http get localhost:9595
HTTP/1.1 200 OK
Content-Type: text/plain
Transfer-Encoding: chunked

Hello World

```

<h3 id="env"> env</h3>

Rack is an HTTP parser. It grabs the information from TCP/IP, parses it and sends it to our applicaiton so that we may use it.

Much of that information will be found in the `env` variable. `env` is a hash, let’s take a look at it.

```sh
rack.version=[1, 3]
rack.errors=#
rack.multithread=true
rack.multiprocess=false
rack.run_once=false
SCRIPT_NAME=
QUERY_STRING=
SERVER_PROTOCOL=HTTP/1.1
SERVER_SOFTWARE=puma 3.6.0 Sleepy Sunday Serenity
GATEWAY_INTERFACE=CGI/1.2
REQUEST_METHOD=GET
REQUEST_PATH=/
REQUEST_URI=/
HTTP_VERSION=HTTP/1.1
HTTP_HOST=localhost:9595
HTTP_CONNECTION=keep-alive
HTTP_CACHE_CONTROL=max-age=0
HTTP_UPGRADE_INSECURE_REQUESTS=1
HTTP_USER_AGENT=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
HTTP_ACCEPT=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
HTTP_ACCEPT_ENCODING=gzip, deflate, sdch
HTTP_ACCEPT_LANGUAGE=en-US,en;q=0.8
HTTP_COOKIE=rack.session=BAh7DEkiD3Nlc3Npb25faWQGOgZFVEkiRTBmOGRjNjJlMGVkMjA5YjlkM2Ez%0AZmE1NTg3OGUzNDliMmJiYmUwNDM3N2U1ZWM1YzZhMDNiNDkwMWE2YWVhMTYG%0AOwBGSSIJY3NyZgY7AEZJIiU3M2I3MmIzMTBiMWNhYWQyOGY3N2JhNjNmNjQy%0AODFhNwY7AEZJIg10cmFja2luZwY7AEZ7B0kiFEhUVFBfVVNFUl9BR0VOVAY7%0AAFRJIi0yNzY0NDMxOTJjZWRhMzQ3MDAyOTBhM2UxOGZkYmIzNDY0YmNiODVk%0ABjsARkkiGUhUVFBfQUNDRVBUX0xBTkdVQUdFBjsAVEkiLTY2ZWFlOTcxNDky%0AOTM4YzJkY2MyZmIxZGRjOGQ3ZWMzMTk2MDM3ZGEGOwBGSSIMYmFsYW5jZQY7%0AAEZpX0kiCGJldAY7AEZJIgcxMAY7AFRJIgpndWVzcwY7AEZJIgYzBjsAVEki%0AEnRhcmdldF9udW1iZXIGOwBGaQY%3D%0A--595adda8ed2b6fc01c628007580b5078c3267b7c; _netflux_session=amxyTmRhT0xGbE5TeG4yQmF0b1F3SFFDcUZwN0J4Snk0VzZMbTMwUTN4elRPUVFhTk8wdDBMdkQ4YzYzZzFkWmhjUzJONkdvZE9KanRwSEdJYk50VkltTjJZMTVoU2s0K3FmOEZSMWgwOXVpKzFCeGdZRmVRZzZ5WVlwWnptckZDclpvOXZBd0JIVzlaV2x4UXFVcUUzczlyUzdXdXU1VkY2eXBtVDVXc09lWUhZUVpXNi9ETXdDbzBrME5ZM0x1dFhkd1ZzR0dkWUcyN1E4Y0x6djZ5QT09LS1MWHFTMUVndlFiWEFUZUVhSWN2UVFBPT0%3D--2b28d415d6523b5caff855b2d77c08fbfedbeff3
SERVER_NAME=localhost
SERVER_PORT=9595
PATH_INFO=/
REMOTE_ADDR=::1
puma.socket=#
rack.hijack?=true
rack.hijack=#
rack.input=#
rack.url_scheme=http
rack.after_reply=[]
puma.config=#
rack.tempfiles=[]
```

The above is all the environment variable and information that we could want related to our HTTP request. More about what each of these `env` key-value pair represent will be covered later.

<h3 id="combine_apps"> Combine one app with another</h3>

We can make this app a bit more dynamic. Right now all is does is get called and then run. What if our HelloWorld app could interface with other apps?

We need to pass in an object of type `RackApplication` to our current app. Let’s call this variable `app`, as it will represent the app that is trying to call our HelloWorld application.

```ruby
class EnvironmentOutput
  def initialize(app = nil)
    @app = app
  end

  def call(env)
    out = ""
    unless(@app.nil?)
      response = @app.call(env)[2]
      out += response
    end
    out += "\n<ul>\n"
    env.each {|key,value| out += "<li>#{key}=#{value}</li>"}
    out += "\n</ul>"

    ["200",{"Content-Type" => "text/html"}, [out]]
  end
end
run EnvironmentOutput.new

```

Instead of this being `HelloWorld` it can be called `EnvironmentOutput` to better reflect its function. `app` is set to `nil` initially, just in case this application, `EnvironmentOutput` isn’t called from another application, but instead by itself as we have been doing thus far.

Recall that a rack application response is in three parts, the status code, the headers(in the form of a hash) and finally a response object. We’re trying to get at the response directly from `@app`, so using the item at index 2 does jus tthis. Then it can be appended onto the output. Let’s test that this application still works after making the changes above. Restart this application with:

```sh
$ rackup app.ru -p 9595
```

Then navigate to the localhost at the specified port, and we get the same output as before.

Restarting the server every time we make a changes isn’t all that user friendly. From now on, let’s use the `shotgun` gem to handle server restarts for us.

```sh
$ gem install shotgun --no-rdoc --no-ri
```

That is the above terminal command to install it if it isn’t already instaalled.

Shotgun runs by default on port 9393 and now the command to run our rack application is

```sh
$ shotgun app.ru
```

Now, what if we want our current app to do more than just show output. Instead, it could fulfill a purpose as a middleware application. We can use Rack to make this happen.

Let’s create another class called `MyApp`. It will be much the same as our previous class, we’ll add it just after `EnvironmentOutput`

```ruby
class MyApp
  def call(env)
    ["200",{"Content-Type" => "text/html"}, ["<h2>Hello There</h2>"]]
  end
end
```

Now if we want to run `MyApp` through `EnvironmentOutput` , we can write the following at the end of our file.

```ruby
use EnvironmentOutput
run MyApp.new
```

The above is equivalent to calling:

```ruby
run EnvironmentOutput.new(MyApp.new)
```

This gives an output of:

```sh
Hello There

rack.version=[1, 3]
rack.errors=#
rack.multithread=true
rack.multiprocess=false
rack.run_once=false
SCRIPT_NAME=
QUERY_STRING=
SERVER_PROTOCOL=HTTP/1.1
SERVER_SOFTWARE=puma 3.6.0 Sleepy Sunday Serenity
GATEWAY_INTERFACE=CGI/1.2
REQUEST_METHOD=GET
REQUEST_PATH=/
REQUEST_URI=/
HTTP_VERSION=HTTP/1.1
HTTP_HOST=localhost:9393
HTTP_CONNECTION=keep-alive
HTTP_CACHE_CONTROL=max-age=0
HTTP_UPGRADE_INSECURE_REQUESTS=1
HTTP_USER_AGENT=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
HTTP_ACCEPT=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
HTTP_ACCEPT_ENCODING=gzip, deflate, sdch
HTTP_ACCEPT_LANGUAGE=en-US,en;q=0.8
SERVER_NAME=localhost
SERVER_PORT=9393
PATH_INFO=/
REMOTE_ADDR=127.0.0.1
puma.socket=#
rack.hijack?=true
rack.hijack=#
rack.input=#
rack.url_scheme=http
rack.after_reply=[]
puma.config=#
```

This all seems good, but there seems to be a bit more going on here than just HTTP parsing. Let’s take a deeper look at Rack.

<h3 id="deeper_look"> A Deeper Look</h3>

Rack at it’s core is an HTTP parser that takes information from your web server and hands it off in nicely packaged ways to your applicaiton. It then accepts information back from your application and hands it off to the web server so that it can serve it back to the browser.

It is technically a low-level framework, but it gives back a lot of functionality. Writing even a little bit of code allows use to set up our own frameworks on top of Rack.

If we hop into the GH for Rack, and go from the top-level to lib, to the rack directory. We’ll see that Rack comes with a fair amount of pre-built modules. A lot is done for us. These modules are mainly there to enable functionality at a higher level.

For instance there is a `Rack::Request` module that take the `env` and breaks it up into pieces we can better work with and understand.

There’s also a module for responses, `Rack::Response`.

`Rack::URLMap` - Take a hash mapping of URLs or paths to applications and dispatches them accordingly. The environment keys, SCRIPT\_NAME and PATH\_INFO are used to do this.

The documentation for these modules can be found in the rdoc for Rack. <http://www.rubydoc.info/github/rack/rack/Rack>

`Rack::Builder`: This is where `run` and `use` are defined. We can find out how they work and what they do for us here in this module.

Quoting from the documentation: "`use` adds middleware to the stack, `run` dispatches to an application. You can use map to construct a `Rack::URLMap` in a convenient way."

Here’s the whole process. We call `rackup`. `rackup` calls `Builder` and builder then takes a look at what is needed to run the application we specify(with `run`) and puts it all together. `builder` itself is a Rack application. You can tell this from how it has a `call(env)` method.

At this point, it may seem like there is one application built ontop of another, and you wouldn’t be wrong. This is where Rack gets its name. Rack is a webserver interface that is build upon several modular pieces and that allow us to stack together several applications.

There also tthe `rack-contrib` library that adds additional functionality to rack.

You can hypothetically build up a sophisticated framework that allows you to use rack in a far more streamlined manner through a DSL. Such a framework does exist and one example is, Sinatra.

<h3 id="more_for_environmentout"> More Building Blocks for EnvironmentOutput</h3>

We don’t want to directly inject html into our application as our response. Instead, ideally we want to use templating engines.

To further build upon our example. let’s make a Haiku file. Instead of our application `MyApp` outputting a String literal, we’ll have it output a Haiku. So, first let’s start with the Haiku class.

```ruby
class Haiku
  POEMS =
    [
      "The wren\nEarns his living\nNoiselessly.",
      "Winter seclusion -\nListening, that evening,\nTo the rain in the mountain.",
      "Toward those short trees\nWe saw a hawk descending\nOn a day in spring.",
      "First autumn morning\nthe mirror I stare into\nshows my father's face.",
      "The lamp once out\nCool stars enter\nThe window frame.",
      "No one travels\nAlong this way but I,\nThis autumn evening.",
      "From time to time\nThe clouds give rest\nTo the moon-beholders."
    ].freeze

  def random
    poem = POEMS.sample
    poem.split("\n").join("<br />")
  end
end

```

I saved this file at the top-level next to `app.ru`. Next, we’ll create a view template. But for just for simplicity, let’s follow some restful conventions to do this. The folder can be called “views” and the file can be called `index.haml`. We need break statements instead of newlines. All whitespace characters get collapsed when used in HTML.

Here is what the file will look like:

```haml
!!! 5

%html
  %body
    %h1= poem
```

Haml is a templating language like erb. It uses indentation to close off HTML tags. Adding “%” at the start of a word denotes the following text as an HTML tag. “!!! 5” is setting the doctype to HTML 5.

An equal sign is used directly after a tag to add in some dynamic code. In this case `poem` will be the haiku poem we wish to display.

Next, lets hop back into `app.ru`. We'll need some gems to make all of this work.

We have to `require` both our `haiku` file, as well as the `haml` library. After that, we’ll have to gain access to our view template, as well as a templating engine. The engine will allow us to parse the view template and embed our poem into our haml view. Let’s do that now.

```ruby
require './haiku'
require 'haml'

class MyApp
  def call(env)
    poem = Haiku.new.random
    template = File.open("view/index.haml").read
    engine = Haml::Engine.new(template)
    out = engine.render(Object.new, poem: poem)
    ["200",{"Content-Type" => "text/html"}, out]
  end
end
```

A couple things to notice here. We use our `engine` object in the code above. The engine has to know what file to work with, which is why initially the view template in question is passed into it when `new` is caled.

When `engine.render` is called, it reads the file, and then adds in any dynamic content to that file. We added in `poem` as dynamic content, so we have to tell the engine what “poem” means. We do that by setting lcoal variables with k-v pairs.

There’s also that first argument to consider, `Object.new`. This tells the engine which scope to run in. `Object.new` tells the engine to simply pay attention to itself and not run in some external scope.

It seems like we have two dependent gems for our application. If you want to, then install theses gems on your system. You can also use a Gemfile. Just remember to use `bundle exec shotgun app.ru` if you do choose to use a Gemfile.

Now to test this all out. We’ve just rigged up a simple templating engine. Here’s the output.

```
Toward those short trees
We saw a hawk descending
On a day in spring.


* GATEWAY\_INTERFACE=CGI/1.1
* PATH\_INFO=/
* QUERY\_STRING=
* REMOTE\_ADDR=127.0.0.1
* REMOTE\_HOST=127.0.0.1
* REQUEST\_METHOD=GET
* REQUEST\_URI=http://localhost:9393/
* SCRIPT\_NAME=
* SERVER\_NAME=localhost
* SERVER\_PORT=9393
* SERVER\_PROTOCOL=HTTP/1.1
* SERVER\_SOFTWARE=WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
* HTTP\_HOST=localhost:9393
* HTTP\_CONNECTION=keep-alive
* HTTP\_CACHE\_CONTROL=max-age=0
* HTTP\_UPGRADE\_INSECURE\_REQUESTS=1
* HTTP\_USER\_AGENT=Mozilla/5.0 (Macintosh; Intel Mac OS X 10\_11\_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
* HTTP\_ACCEPT=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,\*/\*;q=0.8
* HTTP\_ACCEPT\_ENCODING=gzip, deflate, sdch
* HTTP\_ACCEPT\_LANGUAGE=en-US,en;q=0.8
* rack.version=[1, 3]
* rack.input=\#
* rack.errors=\#
* rack.multithread=true
* rack.multiprocess=false
* rack.run\_once=false
* rack.url\_scheme=http
* rack.hijack?=true
* rack.hijack=\#
* rack.hijack\_io=
* HTTP\_VERSION=HTTP/1.1
* REQUEST\_PATH=/

EnvironmentOutput was an interesting test, but it isn’t needed any longer let’s remove it. Now we just have our haiku.

From time to time
The clouds give rest
To the moon-beholders.
```

We have the start of a framework, but `MyApp` isn’t the greatest name. Hmm let’s call it “Avery”. Also notice, that the `call` method is doing a bit too much in class “Avery”, lets move some things around.

```ruby

require './haiku'
require 'haml'

class Avery
  def initialize
    @response = ""
  end

  def get(template, locals)
    @response = haml("index", locals)
  end

  def haml(template_name, locals)
    template = File.open("views/#{template_name}.haml").read
    engine = Haml::Engine.new(template)
    engine.render(Object.new, locals)
  end

  def call(env)
    ["200",{"Content-Type" => "text/html"}, response]
  end

  private

  def response
    [@response]
  end
end

run Avery.new
```

We also don’t want the logic for getting the correct page in our `call` method, so we can move that to a `get` method, as done above. We’ll have the response set to the return value of our call to `haml`

This is all good so far; we’ve built up a nice little framework. But, what’s a framework without an application to use it? Notice that we’ve removed the calls related to our haiku class. We used that context to build up this framework. If we run our code as it is above, we should get a blank screen back. Let’s now make an app that utilizes this framework.

We’l create an application that is once again called `MyApp`. And it is this application that will be our Haiku app. It should inherit from the Avery class.

```ruby
class MyApp < Avery
  def initialize
    get("index", poem: Haiku.new.random)
  end
end
run MyApp.new
```

Now if we run this, we should get the same functionality as when the Haiku app was built into our Avery framework.

<h3 id="middleware"> Middleware</h3>

Working with Rack has moved into a few different usage patterns. First we built a framework, and then we built an application on top of that framework. Now we’re going to explore the 3rd way to work with Rack and that is with middleware.

Middleware works as a filter. We can move these status codes, headers, and responses through other Rack applications that can alter them in some way.

So, first we’ll show how Rack can be used to build up some middleware, and then later we’ll show how to use actual applications as middleware.

Let’s start by changing MyApp to be called `HaikuFilter`; it will no longer inherit from `Avery`.

```ruby
class HaikuFilter
  def initialize(app)
    @app = app
  end

  def call(env)
  end
end
```

The code above is a typical rack middleware setup. It accepts an application passed in, does some work on the response from that application, and then passes off that as a new response via the `call` method. The `env` hash, with all the related environment variables would typically be used here as well to pass on header values.

The just like before, we have to specify `use` for any middleware we wish to utilze with our application.

```ruby
class HaikuFilter
  def initialize(app = nil)
    @app = app
  end

  def call(env)
    response = ""
    if (@app)
      response = @app.call(env)[2]
    end
    response[0] += "<p>#{Haiku.new.random}</p>"
    ["200", {"Content-Type" => "text/html"}, response]
  end
end

class MyApp < Avery
  def initialize
    get("index", poem: "Hello World!")
  end
end

use HaikuFilter
run MyApp.new
```

One thing to note is that we are directly appending the haiku to the initial response from our application. Then that is getting sent to the client(browser). The trouble here is that we are adding in content that is outside out `html` tags. We can get around that by instead treating the response as an object and not as just a String. We’ll address that in a bit.

To work towards that, let’s create another piece of middleware and add it to our “rack” of middleware. We’ll call it Massive, and it will start much the same as our haiku middleware.

```ruby
class Massive
  def initialize(app = nil)
    @app = app
  end

  def call(env)
    response = ""
    if (@app)
      response = @app.call(env)[2]
    end
    response[0] = "<div style='font-size:5.0em'>#{response[0]}</div>"
    ["200", {"Content-Type" => "text/html"}, response]
  end
end
```

Our chain of calls now looks like:

```ruby
use Massive
use HaikuFilter
run MyApp.new
```

This is all run in reverse order. We start up the application, then pass its response to the `HaikuFilter`, and then we pass the `HaikuFilter`s response to `Massive`, and then finally it gets sent off to the client. This is all possible because of `Rack::Builder`, which was mentioned earlier.

Now, let’s introduce one new class, “Quote" to further explore the capabilities of Rack middle. We’ll also re-introduce our `EnvironmentOutput` class as well. This time it will have its own file and be called `EnvironmentOut`.

```ruby
# quote.rb
class Quote
  def initialize
    @quotes = [
      "Look deep into nature, and then you will understand everything better.",
      "I have found the paradox, that if you love until it hurts, there can be no more hurt, only more love.",
      "What we think, we become.",
      "Love all, trust a few, do wrong to none.",
      "I like nonsense; it wakes up the brain cells.",
      "Lost time is never found again.",
      "Nothing will work unless you do."
    ]
  end

  def random
    @quotes.sample
  end
end

```

```ruby
# environmentout.rb
class EnvironmentOut
  def initialize(app = nil)
    @app = app
  end

  def call(env)
    response = ""
    unless @app.nil?
      response = @app.call(env)[2][0]
    end
    response += "<br /><ul>"
    env.each { |key, value| response += "<li>#{key}: #{value}</li>" }
    response += "<br />"
    ["200", {"Content-Type" => "text/html"}, [response]]
  end
end

```

Let also add in some middleware related to our `Quote` class. It will perform exactly the same as `HaikuFilter`,
but it will have to call `Quote.new.random` instead of `Haiku.new.random`.

The chain of calls for our middleware now looks like:

```ruby
use EnvironmentOut
use Massive
use HaikuFilter
use QuoteFilter
```

If we try to run `MyApp` using all of the middleware above, you’ll find the output on the browser screen to
be rather large. That is because of the `Massive` module. If we comment that out, and then run our Rack based
application we get the following back:

Hello World!
============

Look deep into nature, and then you will understand everything better.

```
Toward those short trees
We saw a hawk descending
On a day in spring.

* GATEWAY\_INTERFACE: CGI/1.1
* PATH\_INFO: /
* QUERY\_STRING:
* REMOTE\_ADDR: 127.0.0.1
* REMOTE\_HOST: 127.0.0.1
* REQUEST\_METHOD: GET
* REQUEST\_URI: http://localhost:9393/
* SCRIPT\_NAME:
* SERVER\_NAME: localhost
* SERVER\_PORT: 9393
* SERVER\_PROTOCOL: HTTP/1.1
* SERVER\_SOFTWARE: WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
* HTTP\_HOST: localhost:9393
* HTTP\_CONNECTION: keep-alive
* HTTP\_CACHE\_CONTROL: max-age=0
* HTTP\_UPGRADE\_INSECURE\_REQUESTS: 1
* HTTP\_USER\_AGENT: Mozilla/5.0 (Macintosh; Intel Mac OS X 10\_11\_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
* HTTP\_ACCEPT: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,\*/\*;q=0.8
* HTTP\_ACCEPT\_ENCODING: gzip, deflate, sdch
* HTTP\_ACCEPT\_LANGUAGE: en-US,en;q=0.8
* rack.version: [1, 3]
* rack.input: \#
* rack.errors: \#
* rack.multithread: true
* rack.multiprocess: false
* rack.run\_once: false
* rack.url\_scheme: http
* rack.hijack?: true
* rack.hijack: \#
* rack.hijack\_io:
* HTTP\_VERSION: HTTP/1.1
* REQUEST\_PATH: /
```

Let’s examine the order of the output above. Recall that the calls to our various middleware happen in reverse order, with our applications response returning first. The order now is:

“Hello World” from `MyApp` -\> `QuoteFilter` which appends a random quote -\> `HaikuFilter` which appends a random Haiku -\> `EnvironmentOut` which appends a list of our environment variables and their values.

This all happens due to the following calls. The order of those calls is important.

```ruby
use EnvironmentOut
# use Massive
use HaikuFilter
use QuoteFilter
run MyApp.new
```

This has been a quick tour of chaining middleware. Now, notice that we’ve had to do a bit of work to pass our response through all this middleware. In each module, we have to access the response which is wrapped in an array. And then finally that array wrapped response gets returned to the client from the last bit of middleware.

We’ve also been negligently appending html text after our haml template. This create some malformed HTML. Let’s address all these concerns no

<h3 id="refactor_response"> Refactoring The Response</h3>

A framework like we’ve created(Avery) should be able to grab a response(even a filtered one) and inject that into the template being used by our application.

Right now we’re ignored this and just appending onto the response we get from our application’s `index` template.

Let’s implement what we would need in one of our filters, we'll assume that middleware always receives an application. This means we can remove the check for `if @app`. We'll also implement an `each` method. For now, we'll only do this in one of our filters, `HaikuFilter`.

```ruby
class HaikuFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, @response = @app.call(env)[2]

    ["200", {"Content-Type" => "text/html"}, response]
  end

  def each(&block)
    block.call("<p>#{Haiku.new.random}</p>")
    @response.each(&block)
  end
end

```

This entire time we’ve only been working with the response body. But, we should have at least implemented an opton to also work with the headers and status code. That is implemented above as well.

There are some other things that should be changed. We should also be passing on the status, headers, and response from `@app`. Right now we have hard-coded values for the returns of status code and headers. Let's fix that as well.

```ruby
require './models/haiku'

class HaikuFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, @response = @app.call(env)[2]

    [status, headers, self]
  end

  def each(&block)
    block.call("<p>#{Haiku.new.random}</p>")
    @response.each(&block)
  end
end
```

The code above may look a bit odd. We’re calling `each` in `HaikuFilter` at some point and then inside that call we call `each` on our response? What’s going on here? Well, we’re going to return `self` for in place of our response. We do this because when that response is returned `each` is automatically called on it. This will causes the `each` method in `HaikuFilter` to be called, and subsequently the `each` method for our response object.

##### Aside

What we're dealing with here is a Rackk application. All that is required for this to be a Rack application is for there to be a `call` method. This `call` method will help build up, consolidate and pass on the status, headers, and response.

Just to clarify things, lets take a deeper look at some of the methods we’ve been using, such as `run` and `use`, and see what’s really going on. The following are code excerpts from the Rack documentation in module `Rack::Builder`.

```ruby
# Rack::Builder

def initialize(&block)
  @ins = []
  instance_eval(&block) if block_given?
end

# ...

def use(app)
  @ins << lambda { |app| middleware.new(app, *args, &block) }
end

def run(app)
  @ins << app
end

# ...

def to_app
  @ins[-1] = Rack::URLMap.new(@ins.last) if Hash === @ins.last
  inner_app = @ins.last
  @ins[0...-1].reverse.inject(inner_app) { |a, e| e.call(a) }
end

def call(env)
  to_app.call(env)
end
```

A couple things of note here. When we call `use` it takes our middleware and makes a new instance wrapped in a lambda.  
When we call `run` it takes our application and directly shovels it into the `@ins` array.  Recall the order of how
things are run in a Rack application. It functions like a stack, FILO(first in last out)

Notice that `Rack::Builber` is an app itself. So, the order of things is:

1. We specify what to run in a rackup file(.ru)
2. That file then goes through and sees what we specify to `run` and what to `use` and shovels these application or middleware
into an array called `@ins`.  
3. At the end of all this, `Rack::Builder` calls its own `call` method. This method calls `to_app`. The `to_app` looks a bit tricky.
But it is here that each application is `call`ed in reverse order. Ruby reads a file line by line, from top to bottom.  
4. Notice that `inject` is being used in this method, with an argument of the last item added to `@ins`. That last item should be
whatever was passed to `run`. Then each application or middleware gets called as it is popped off the stack, `@ins`.
5. If we're to take our current middelware stack and application as an example, then as each application/middle uses `call`
the response if built up.
6. Finally, it is all appended together an entire response with this call to `inject` and then sent off to the Client.

Now that we’ve gone over that, let’s get back to our application and middleware stack that we’ve built up.

We’ll add the changes we’ve made to `HaikuFilter` to the rest of our middleware as well.

```ruby
# enironment_out.rb
class EnvironmentOut
  def initialize(app)
    @app = app
  end

  def call(env)
    @env = env
    status, headers, @response = @app.call(env)
    [status, headers, self]
  end

  def each(&block)
    output = ""
    output += "<ul>"
    @env.each { |key, value| output += "<li>#{key}: #{value}</li>" }
    output += "</ul>"
    block.call("#{output}")
    @response.each(&block)
  end
end

```

```ruby
# quote_filter.rb
require './models/quote'

class QuoteFilter
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, @response = @app.call(env)
    [status, headers, self]
  end

  def each(&block)
    block.call("<p>#{Quote.new.random}</p>")
    @response.each(&block)
  end
end

```

```ruby
# massive_filter.rb
class Massive
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, @response = @app.call(env)
    [status, headers, self]
  end

  def each(&block)
    block.call("<div style='font-size:5.0em'>")
    @response.each(&block)
    block.call("</div>")
  end
end

```

**NOTE: Since the making of the video that these notes are based on, Rack and Ruby have been updated. So there are a few things that won’t work if you are using an updated version of Rack and following along. **

1. `String` no longer has an `each` method. So, initially, in the earlier parts of this framework and rack application,
you’ll have to wrap your String responses in an Enumberable object. The easiest way to get around this is to use an Array
literal. `StringIO` should also work.

2. The solution presented for chaining calls to well `call` and then using an `each` method internally won’t work for the
final part of our response(the one we actually get from MyApp). This happens because we first traverse all our in reverse order.
And then append going down. Look at the `call` method for `Avery` , it also calls the `call` method for the app passed in and so on.

That means we go through a chain of `call` until we get to the top middleware in our list, in our case that is `EnvironmentOut`.

3. After this we return from each call in reverse order appending values onto our whole response with each `middleware` and
`application` `each` method. This also explain why the output is now in reverse order.
4. Finally, the source code for Rack itself has changed a bit, so what you see when you look at it on GH may be a bit different
than what is listed in this tutorial. Overall, the same functionality still exists.

I had to make a fix to this application stack so that it works. When we finally get to the call for `@response.each` for our
original response “Hello World”, we won’t get any output. Once again, this is because strings don’t have an `each` method.
We need an `each` method added to `Avery` that will add all the characters in our original message onto the entire response,
post middleware. This should do the trick.

```ruby
class Avery

  # Ommitted for brevity
  def call(env)
    ["200",{"Content-Type" => "text/html"}, self]
  end

  def each(&block)
    @response.chars.each(&block)
  end
end
```

<h3 id="clean_up"> Cleaning Up</h3>

Make sure to move models to "models" folder
Move middleware classes to their own files
Rename app.ru to config.ru
show that shotgun looks for a file called config.ru, this lets us just write `shotgun` in the termainl,
we can leave out the configuration filename.

Now that we’ve done all that, let’s show a benefit we get from using one of the conventions above.
shotgun expect there to be a configuration application called `config.ru` by default.
This lets us just write `shotgun` in the termainl, we can leave out the configuration filename.

<h3 id="mapping"> Mapping</h3>

Middleware doesn’t have to be in the form of a response filiter. It can also function as a sub-application.
You see this alot with Sinatra.

Let’s start by jumping over to config.ru . For this part, we won’t need our filters, so lets remove them,
along witht he `require` s for those module.

```ruby
require './my_app'

run MyApp.new
```

Make sure to refresh the application and check that everything is still working.

Now, lets set some groundwork. Replace the name of the `MyApp` class with `HaikuApp`. Then copy that application and create an app called `QuoteApp`. You may put these in separate files, or for the sake of expediency, it is fine to put this all in `myapp.rb`.

So far we’ve been only been queuing up our application. When the server is started we run this applicat. But this means that no matter what URL we hit, it will always do just one thing. Run the application we have specified. We can also use a method called `map`.

`map` allows us to map a URL to an application. Let's take a look.

```ruby
require './my_app.rb'

map "/" do
  run HaikuApp.new
end

map "/quote" do
  run HaikuApp.new
end

```

Look at that it works. We can even be a bit more explicit here. Lets map the URL for the haiku app to “/haiku”.

```ruby
map "/haiku" do
  run HaikuApp.new
end
```

That seems to work as well. So, what we’ve just done is used Rack to orchestrate sub-applications into a larger application. One that is made up of multiple URL endpoints that perform different functions.  
This doesn’t just apply to our custom framework “Avery”. We can link sub-applications together with Rack as long those applications are rack based. This would work with linking Sinatra apps together or linking Rails applications as well.

<h3 id="rails_metal"> Rails ActionController#Metal</h3>

Let’s give this a shot. We’ll try squeezing in Haiku into a Rails application.
For this example we’ll create a new rails applicatoin to test this out.

**NOTE: If you haven’t gotten to Rails yet that is fine. Just follow along.**

We’ll create a new Rails app, and the under the `app` folder, we’ll create a new one called “middleware"
Within that folder, we’ll make two new files called “haiku.rb” and “haiku\_filter.rb"

I think you can guess what we’re doing next. Let’s copy and paste our previous work on haiku and haiku filter into those files.

Next, we need to tell Rails to use our HaikuFilter middleware. Let’s do that now by navigating to `/application.rb`

We need to add the following line within class Application.

```ruby
module MiddlewareTestApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.use "HaikuFilter"
  end
end
```

We don’t have to add the middleware directory to the autoload path. In the current version of rails, any folders in app directory are all recursively autoloaded.

I’ve added in a couple of things to replace what was done in this video. I’ve added a simple index route to ApplicationController. When we hit the root path “/“ it should just say “Hello World”. But since we tied in our Middleware, it will also show our Haiku. Lets take a look.

This is what the browser looks like:

The lamp once out
Cool stars enter
The window frame.

Hello World

Great it works. We’ve tied in Rack middleware, `HaikuFilter` into a simple Rails application.

In Rails parlance, this is called, “Rails Metal”. We’re injecting little bits of middleware that sidestep the Rails framework.

Since this video, Rails Metal has been removed. Instead what we would use here is `ActionController::Metal`. As it is set up now, HaikuFilter would run for our entire Application, and that is not ideal.

```ruby
# app/controller/haiku_controller.rb
class HaikuController < ActionController::Metal
  use "HaikuFilter", only: :haiku

  def haiku
  end
end
```

```ruby
# config/routes.rb

get "haiku", to: HaikuController.action(:haiku)
```

These example for using metals were a bit arbitrary. But sometimes it can be really useful to utilize parts of a middleware stack. It can allow you to use these small sub-applications to handle requests that may not require the entire Rails application.

That’s it, I hope this has been useful.


## Sources/ Further Reading
  
  * [Rack Official Project Site](https://rack.github.io/)
  * [Rack Interface Specification](http://www.rubydoc.info/github/rack/rack/master/file/SPEC)
  * [Explanation of differences between web servers and app servers](http://www.justinweiss.com/articles/a-web-server-vs-an-app-server/)
  * [TekPub Rack Tutorial video](https://www.youtube.com/watch?v=iJ-ZsWtHTIg&list=WL&index=2)
  * [Tyler's Note's on Rack Tutorial Video](https://gist.github.com/Reltre/de3ed56842c5b96bd2a69a65128e542c/7eda8c1a3539e25735e42bbcd323becfbc09da02#file-rack_notes-md)
  * [Rack Web App Servers Comparison](https://www.digitalocean.com/community/tutorials/a-comparison-of-rack-web-servers-for-ruby-web-applications)
  