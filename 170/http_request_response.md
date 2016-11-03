# HTTP Request-Response

*What are the components of an HTTP request and an HTTP response?*

### HTTP Request

  * An HTTP Request is made of HTTP Headers (and sometimes also a HTTP Body for POST Requests)
  * HTTP headers are meta-data (data about data)
  * HTTP Request Headers contain data about the Request being made
  * Examples of an HTTP Request Header are:
    * Host - the domain name of the server
    * Accept-Language - list of acceptable languages (e.g. 'en-US')
    * User-Agent - A string that identifies the client
    * Connection - The type of connection the client would prefer (e.g. 'Connection:keep-alive')
    * HTTP Method - the type of method with which the request is being made:
      * GET - the method usually used when the client wants to *retrieve* a resource from the server
      * POST - the method usually used to send or submit data to the server or initiate some action
  * Unless a Request times out it will receive a Response

### HTTP Response

  * An HTTP Response is the data sent back by the server following a Request from the client
  * A Response is made up of a Status Code, HTTP Headers and an HTTP Body
  * Status Code - (a three digit number signifying the status of Request)
    * `200 OK` - indicates that the requested resource was found
    * `302 Found` - The requested resource has changed temporarily (usually results in a redirect)
    * `404 Not Found` - the requested resource cannot be found
    * `500 Internal Server Error` - the server has encountered a generic error.
  * Examples of HTTP Response Headers include:
    * Request Method (e.g. `GET`, `POST`)
    * Content-Type - the representation of the data in the response body
    * Content-Encoding - The type of encoding used on teh data (e.g. `gzip`)
    * Location - notift the client of a new resource location (e.g. in the event of a redirect)
    * Server - the name of the server
  * An HTTP Response body contains the actual data of the requested resource (e.g if a HTML document is requested the Response Body will be the HTML)

### Questions

1. What are the required components of an HTTP request? What are the additional optional components?

HTTP method and path are required. Parameters, headers, and body are optional.

2. What are the required components of an HTTP response? What are the additional optional components?

Status code is required. Headers and body are optional.

3. Is the host component of a URL included as part of an HTTP request?

**No**. While the host (and port if there is one) is used to connect to the server and therefore is required to make an HTTP request, only the URL's path and parameters are included in the actual request.
