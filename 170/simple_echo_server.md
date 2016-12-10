# Simple Echo Server

## Intro

We can create a simple echo server in Ruby just using components from the Ruby Standard library and Ruby language itself.

```ruby
# echo_server.rb

require 'socket'

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  client.puts request_line
  client.close
end
```

`Socket` is a class in the Ruby Standard Library. It subclasses from `BasicSocket` (which is also an ancestor of `TCPServer`), which in turn subclasses from `IO`.

In the above code a new instance of `TCPServer` is created with parameters for hostname (optional) and port (required) passed to it (this creates a new server socket bound to port and hostname if given). The local variable `server` is assigned to the new `TCPServer` instance.

Within a loop, the `#accept` method of `TCPServer` is called on the `server` instance and the local variable `client` assigned to it (this accepts an incomming connection and returns a new `TCPSocket` object). Therefore the local variable `client` is an instance of `TCPSocket`. `TCPSocket` represents a TCP/IP client socket meaning it can receive TCP/IP data from a client that it is connected to via the `TCPServer` to and send TCP/IP data to a client that it is connected to via the `TCPServer`

The `#gets` method of `IO` is called on the `TCPSocket` object and the local variable `request_line` is assigned to it. This method call in this context *reads lines* from the client - the lines here being the http request sent by the client (e.g. browser). this includes the method and path, as well as parameters headers and body if supplied. `gets` reads one line at a time, so here only the first line of the HTTP request is assigned to the `request_line` variable. HTTP Requests are text files made up of lines, each line being ended by a cariage return and new line `\r` and `\n`. The \r character is a carriage-return (CR). The \n character is a line-feed (LF). The HTTP request protocol requires that parts of the request be terminated with CRLF pairs.

The `#puts` method of `IO` is called with the `request_line` local variable passed to it as an argument, this outputs the value of `request_line` to the console.

The `#puts` method of `IO` is called on the `client` (which is the `TCPSocket` object`) with the `request_line` local variable passed to it as an argument, this outputs the value of `request_line` to the client (in this case the browser).

The `#close` method of `IO` is then called on `client` (which is the `TCPSocket` object`). This closes ios and flushes any pending writes to the operating system. The stream is unavailable for any further data operations; an IOError is raised if such an attempt is made.

The loop starts again when prompted (on a browser refresh)

## Parsing Path and Parameters

A request that is made to a server can be thought of in a similar way as a function call - you pass arguments to the function (the request) and it returns a value (the response).

The simplest way to pass information to a web application is to use the url, particularly:

  * path (e.g. `/`)
  * query parameters (e.g. `?name=value`)

In order to parse the parameters, we can take the string from the first line of the http request and use ruby methods such as `String#split` in order to extract the specific portions of that string (since we know how it is going to be formatted). We could wrap that code in a method something like this:

```ruby
def parse_request(request_line)
  http_method, path_and_params, protocol = request_line.split
  path, params = path_and_params.split('?')
  params = params.split('&').map { |param| param.split('=') }.to_h

  [http_method, path, params]
end
```
We can then use these parsed elements of the request to respond in a particular way.

### Sending a Complete Response

A complete, valid response would contain all of the required components for an HTTP Response

  * Status
  * Headers (if any)
  * HTTP Body (note, there should be an empty line between the status/ headers and the body)

With the following code included in our application:

```ruby
  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html><body><h1>Hello World!</h1></body></html>"
```

The first three line will not be output to the browser window as they are identified as specific parts of the response that are not part of the body.

### Dealing with Empty Requests

Receiving an empty request can cause the running program to crash (e.g. by trying to call `#split` on `nil`). THis can be avoided by adding a line such as this to your code:

```ruby
next unless request_line
```

So that if `request_line` is `nil` the loop skips to the next turn.

### Persisting State in the URL

Since there is nowhere natively to store data within the HTTP protocol, in order to persist state using HTTP everything has to exist as part of the request (e.g. in the URL).

For example, if you had a page to increment or decrement a number you could add links to the page that take the current value of the number and link to the same page but with parameter values for number increased or decreased by 1 respectively.

```ruby
client.puts '<h1>Counter!</h1>'
  
  number = params['number'].to_i

  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"
  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
```

Although nothing is actually being stored, setting up an app in this way gives the impression that state is being persisted. This type of scheme is often used in websites that have pagination.

#### Reference

[CRLF Line Endings in HTTP requests](http://stackoverflow.com/questions/6686261/what-at-the-bare-minimum-is-required-for-an-http-request)
[Difference between \n and \r 1](http://stackoverflow.com/questions/1761051/difference-between-n-and-r)
[Difference between \n and \r 2](http://stackoverflow.com/questions/1552749/difference-between-cr-lf-lf-and-cr-line-break-types)
