# HTTP Overview

*What is HTTP and what is the role of the request and the response?*

HTTP stands for Hyper Text Transfer Protocol. To break that down it is a **protocol** (i.e. a set of rules and guidelines) used to **transfer** (movefrom once place to another) a specific type of **text** known as **hypertext**.

*At the most basic level, __hypertext__ is text that contains links to other text*

HTTP follows a simple model where a client (e.g. a web-browser on a computer) makes an **HTTP Request** to a server and in return receives an **HTTP Response**. It is therefore referred to as a *Request-Response** protocol.

The role of the request and Response is to enable the Client to communicate with the Server. The client uses and HTTP Request to request a resource from the Server and the Server uses the HTTP Response to respond to that request.


  * *HTTP* is a text-based protocol that is the foundation of the web.
  * There are two parties involved in HTTP: the *client* and the *server*.
  * A complete HTTP interaction involves a *request* which is sent from the client to the server, and a *response* which is sent from the server to the client.
  * A request is sent to a *host* and must include a *method* and a *path*. It may also include *parameters*, *headers*, or a *body*.
  * `GET` is the HTTP method used to retrieve a resource from the server.
  * A response must include a *status*. It may also include *headers* or a *body*.
  * A `200 OK` status in a response means the request was successful.
  * Modern web browsers include debugging tools that allow you to inspect the HTTP activity of a page.
