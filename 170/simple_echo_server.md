# Simple Echo Server

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

#### Reference

[CRLF Line Endings in HTTP requests](http://stackoverflow.com/questions/6686261/what-at-the-bare-minimum-is-required-for-an-http-request)
[Difference between \n and \r 1](http://stackoverflow.com/questions/1761051/difference-between-n-and-r)
[Difference between \n and \r 2](http://stackoverflow.com/questions/1552749/difference-between-cr-lf-lf-and-cr-line-break-types)
