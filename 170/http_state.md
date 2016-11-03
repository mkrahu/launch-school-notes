# HTTP State

*What is state and why is the HTTP protocol said to be stateless?*

State is information about the exchange of data between client and server. For example, if a user is 'signed-in' to an application the fact that they are signed in is part of the *state* of the exchange between client and server.

A protocol is said to be **stateless** when each Request-Response pair is completely independent of the previous one.

It is important to be aware of HTTP as a stateless protocol. This means that the server does not need to store state between requests. 

The fact that HTTP is *stateless* make it a resilient protocol but also one that is difficult for building stateful applications. There are tricks and techniques that web developers and web development frameworks use to make it seem like an application is stateful (so that, for example, you don't have to log-in again every time you perform an action on a website - even though each action is a seperate Request-Response cycle), but in reality the web is built on http which is a stateless protocol.

# Stateful Web Applications

Since HTTP is stateless (i.e. the server **does not** hang on to information between each Request-Response cycle, so each request made to a resource is treated as a brand new entity) it makes it difficult for web developers to build **stateful** web applications.

Certain techniques are used to make displaying dynamic content on the client easy. These approaches include:

  * Session
  * Cookies
  * Asynchronous JavaScript call (AJAX)

### Sessions

  * The stateless HTTP protocol has to be augmented to maintain a sense of statefulness.

  * With help brom the client (i.e. browser) HTTP can be made to act as if it were maintaining a stateful connection (even though it isn't)

  * One way to achieve this is to send some sort of unique *token* to the client

    * Whenever the client makes a request, the client appends the token
      * This allows the server to identify the client
      * This token is referred to as the **session identifier** or `session id`

    * This creates the *impression* of persistent connection between requests, but has consequences:
      
      * Every request must be inspected to see if it has a `session id`
      * If it does the id must be checked to ensure it is still valid (the server needs to maintain rules on how to handle session expiration and how to store session data)
      * The server needs to retrieve the session data based on the `session id`
      * The server needs to recreate the application state based on the session data and send it back to the client as the Response
      * In order to avoid having to recreate and send the *entire* application state with each new request, AJAX can be used
      * One way to store session information is in a *cookie*

### Cookies

  * A *cookie* is a piece of data stored in the Client during a Request-Response cycle.
    * **HTTP Cookies are small files stored in the browser
    * They contain session *information* (which is used as a *key* when making a Request to the server), though the actual *session data* is stored on the server
      * Session data stored on the server can sometimes be stored in just memory and sometimes in some form of persistent storage like a database
    * When you make an HTTP Request, the Server will check for the existence of a cookie, and if it exists check to see if its session information matched session data stored on teh server - if so it will use that session data
    * The `session id` sent with a cookie is unique and expires in a relatively short time, it is also destroyed if you log out

### Ajax

  * AJAX is short for 'Asynchronous JavaScript and XML'
  * It allows browsers to issue requests and process responses *without a full page refresh*
    * When AJAX is used, all Requests sent from the client are performed *asynchronously*
    * Responses from these requests are processed by a `callback`
    * A `callback` is a piece of logic that you can pass to some function to be executed after a certain event has happened - in this case the `callback` is triggered when the Response is received
    * AJAX Requests are just like normal HTTP Request - they have all of the same components, the server handles them like any other request. The only difference is that instead of the browser refreshing and processing the response the response is processed by a call-back function (usually some client-side JavaScript code)
