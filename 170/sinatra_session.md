# Sinatra Session

*What is the session? Where it is stored? How it is used?*

  * The session is a Hash of key-value pairs
  * On the server-side the session is stored in and is accessible from a session variable
  * On the client-side the session is stored in a session cookie (a file that is stored on the client machine via the client software - e.g. web browser)
    * Since Sinatra uses the `Rack` session library, by default the name of the cookie is `rack.session`
  * The session is used to store data between requests. It is passed between the client and server in order to create the impression of state

  * The session in Sinatra is a Ruby `Hash` object

  * A session is used to keep state *during* requests. If activated there is one session hash per user session.
  * Activate sessions by enabling them in the application file

Example:
```ruby
enable :sessions
```

  * `enable :sessions` stores all data in a cookie.
  * A `:session_secret` can be set
    * If a value is not specified for `:session_secret`, Sinatra will set a random session secret each time Sinatra starts
      * if Sinatra is stopped and restarted the secret will be different
      * if the value changes any sessions that exists will become invalidated immediately
      * specifying the value of secret ensures that the session will continue to be valid even if Sinatra is restarted

Example
```ruby
configure do
  enable :sessions
  set :session_secret, 'secret'
end
# here a configure block is used to enable sessions and set the secret
```
  * An alternative is to use some Rack middleware to store the session