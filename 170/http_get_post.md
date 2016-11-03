# HTTP GET and POST

*Explain the difference between GET and POST, and know when to choose each.*

GET and POST are both HTTP Request methods. They are a way for the Client to tell the Server what action to perform on a resource.

### GET Requests


  * `GET` Requests appear in a link or the address bar of the browser. When you type a web address in to the browser address bar or click on a hyperlink you are issuing a GET Request.
  * `GET` Requests are used to retrieve a resource (most links are GETs)
  * The response received following a GET request can be anything, but if it is HTML and that HTML references other resources, a web browser will automatically issue GET requests for those resources (as aopposed to a pure HTTP tool, which will stop processing once the initial Response is received)
  * There are size and security limitations to using GET Requests

### POST Requests

  * `POST` Requests are used to send or submit data to the server or initiate some sort of action on the server. 
  * Typically from within a browser you use `POST` when submitting a form
  * `POST` allows for the sending of much larger and more sensitive data to the server (e.g. a username and password being sent for authentication)
    * Since post requests are not sent through query strings their contents are not immediately visible (i.e. in the address bar), however unencrypted transmissions can still be accessed
    * POST requests also sidestep the query string size limitation - significantly larger forms of information (e.g. an upoad of a large file) can be sent to the server
    * The data for a POST Request is sent in the HTTP Body

### Other Types of Request

  * Other Types of Request are:
    * `PUT`
    * `DELETE`
    * `PATCH`
    * `HEAD
    * `CONNECT`
    * `OPTIONS`
    * `TRACE`

### HTTP Headers

  * Both GET and POST requests include HTTP Headers as part of the Request (a GET Request is usually only Headers)
  * HTTP Headers allow the Client and Server to send additional information (metadata) during the Request-Response cycle.
  * Headers are colon-separated name-value pairs
  * Headers are sent in plain text

### When to use GET and when to use POST

  * If you simply want to retreive a resource from the Server then a GET Request is most appropriate
  * If you want to submit some data or initiate an action on the server (e.g .to update or delete a resource) then a POST Request is most appropriate

### Questions

1. What determines whether a request should use GET or POST as its HTTP method?



`GET` **requests should only retrieve content from the server**. They can generally be thought of as "read only" operations, although there are some subtle exceptions to this rule. For example, consider a webpage that tracks how many times it is viewed. GET is still appropriate since the main content of the page doesn't change.

`POST` **requests involve changing values that are stored on the server**. Most HTML forms that submit their values to the server will use POST. Search forms are a noticeable exception to this rule, and they often use GET since they are not changing any data on the server, only viewing it.
