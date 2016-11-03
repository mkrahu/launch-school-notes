# How the Web Works

## Overview

Web Development Frameworks are powerful and often fairly simple to pick up and use; it is easy to lose sight of the core concepts underpinning these frameworks and web development itself.

**A framework is just a tool. Understanding the core concepts enables you to pick up and start using a new tool quickly and easily**

### Parts of the Web

  * **Client:** This could refer to either an actual computer/ device (within the Client-Server network model) or a piece of software running on that device (e.g. a web-browser or other application)

  * **Server:** A machine connected to the internet that *serves* a `Response` following a `Request` from a **Client**. There are many different types of server - web servers, database servers, file servers, application servers.

  * **IP Address:** Internet Protocol Address - a unuique numerical identifier for a device on a TCP/IP network. The format is four sets of up to three digits separated by a decimal point (e.g. 244.155.65.2).

  * **TCP/IP:** Transmission Control Protocol/Internet Protocol. The set of *standards and rules* for transmitting data over a TCP/IP network (such as the internet)

  * **DNS:** Domain Name System. A distributed database which translates 'human-friendly' addresses such as 'mywebsite.com' to an IP Address.

  * **Domain Name:** These are the 'human-friendly' addresses. They consist of several parts - the TLD (top-level domain, such as '.com' and then subdomains of this TLD; e.g. in the url `www.mysite.com` 'mysite' is a sub-domain of 'com' and 'www' is a sub-domain of 'mysite'.

  * **Port Number:** A 16-bit integer that identifies a specific port on a server and is always associated with an IP address. It serves as a way to identify a specific process on a server that network requests could be forwarded to.

  * **Host:** A computer connected to a network. It can be a client, server or other type of device.

  * **HTTP:** Hyper-text Transfer Protocol. The protocol used by web browsers and web servers to communicate over the internet

  * **URL:** Uniform Resource Locator. URLs identify a particular web resource, e.g. `http://mywebsite.com/mypage'. The URL specifies the protocol ('http') the host name ('mywebsite.com') and the specific resource ('mypage').

### The journey from code to webpage

All these 'parts of the web' come into play as part of the process that starts when you enter a web addres into the address bar of your browser and ends when the actual web page is rendered in the browser window.

1. Type a *URL* into the address bar of the browser
2. Thebrowser parses the information contained in the URL, splitting it into its component parts:
  * The protocol (e.g. 'http')
  * The domain name (e.g. 'mysite.com')
  * The resource (e.g. '/somepage' - if no resource is specified after the TLD the browser will just add a '/' to indicate the webroot of the domain
3. The browser communicates with your ISP to do a DNS lookup of the IP Address for the Web Server that hosts the domain (the DNS service will first contact a Root Name Server, which replies with the IP address for the name server of the TLD; once it has this address the DNS service does another outreachto the host of the TLD and asks for the next address down the chain and so on until it reaches the domain pointing to web root)
4. Once the ISP receives the IP address of the destination server it sends it to the web browser - this can consist of:
  * The protocol
  * The IP address
  * A specific port to use (http defaults to port 80 and https to port 443)
5. The browser takes this information and opens a TCP socket connection. At this point the web browserand web server are connected.
6. The browser sends an HTTP (GET) request to the web server to request the specific resource
7. The web server receives the request and attempts to locate the resource. IF the resource exists the web server prepares an HTTP response and sends it back to the browser. If the server cannot find the resource, it will send an HTTP 404 error message which stands for 'Page Not Found'.
8. The browser takes the HTTP response and parses the body of the response (generally this is a webpage) looking for other assets that are listed (such as images, CSS and JS files)
9. For each asset listed the browser repeats the entire process above making additional HTTP GET Requests and parsing the Response
10. Once the browser has finished loading all of the assets the complete page will be rendered in the browser window and the connection will be closed.

### TCP/IP

It is worth noting how the information involved in the above process gets transmitted. When you make a request, the information is broken up into tiny chunks called *packets*. Each packet is tagged with a TCP 'header' which includes the source and destination port numbers, and an IP header which includes the source and destination IP addresses. The packet is then transmitted through the network and is allowed to travel on any route and take as many *hops* as needed to reach its final destination. Once there the packets are reassembled and delivered as one piece.

TCP/IP is a two part system and functions as the internet's fundamental 'control system':
  * **IP:** Internet Protocol - sends and routes packets to other computers using the IP headers (IP addresses) on each packet
  * **TCP:** Transmission Control Protocol - responsible for breaking the message into smaller packets and routing the packets to the correct application on the destination computer using TCP (port) headers, resending any lost packets and reassembling packets in the correct order at the other end.

### Rendering a Webpage

Once the browser has the resources comprising the webpage (HTML, CSS< JS, images etc.) it has to go through several steps to render them in a human-readable format. The browser has a *rendering engine* responsible for doing this, which includes an HTML parsing algorithm that tells the browser how to parse the resources.

Once parsed the browser creates a tree structure of the DOM (Document Object Model) elements. These
objects or 'nodes' can be manipulated using scripting languages like Javascript. Once the DOM is built, stylesheets are parsed to style the nodes (the browser traverses the DOM and calculates the style, position, etc.. ofr each node) Once the broswser has all the nodes and their styles it 'paints' the page to the screen in the browser window.

---

## Client-Server Model & the Structure of a Web Application

### The Client-Server Model

The client-server model is a way to describe the concept of communication between the client and server in a web application. The client and server have differnt responsibilities in this relationship. There are lots of ways to configure a web application but a basic structure might include a client, a server and a database.

#### The client

Responsible for 'client-side' code - most of what the end-user actually sees and interacts with. Responsible for:

1. Defining the **structure** of a web page
2. Setting the **style** of a web page
3. Defining the**beahvious** (implementing a mechanism for responding the *user interactions*)

**Structure:** the structure of a page is defined by HTML (usually HTML5) which stands for 'Hyper Text Markup Language'. HTML *semantically* defines what the different nodes in the DOM represent, e.g. `<h1>` is a the highest level headin, `<h2>` the second highest, `<p>` is a paragraph, and so on. Each HTML element describes a different element in the document.

**Style:** the *look and feel* of the website is defined using CSS (Cascading Style Sheets). CSS lets you describe how HTML elements should be styled in terms of position on the page, colour, font, etc.

**Behaviour:** JavaScript is often used to handle user interactions such as pop-ups, image sliders, animations and so on. This behaviour is generally implemented on the client-side (without makng an HTTP request to the server).

#### The Server

The server can refer to a computer but can also refer to a specific web-server application (e.g. Apache or NGINX) that runs on the computer and has the responsibility to listening for HTTP Requests directed via a certain port to the ip address and responding to them via an HTTP Response.

#### The Database

Databases are stores of data structured using specific database application software (e.g. MySQL, Postgres SQL). Databases can exist on the same machine as the web-server or on a different machine altogether. Either way the database is queried by web applications when they require access to the data stored in the database. Database records can be read, updated, created or deleted.

#### Scaling a Web Application

A basic Client > Server > Database structure is fine for simple applications, but as an application grows a single web-server won't be able to handle thousands or millions of concurrent requests. Scaling the structure to handle high-volume traffic involves distributing the requests across multiple servers.

##### Load Balancing

Since each of these servers will have a different IP address you need to use a load balancer to distribute the traffic. A load balancer routes client requests across the servers in thr fastest and most efficient manner possible.

Generally DNS will point to a Virtual IP address for the Load Balancer which then directs the request to the appropriate server. The way in which it does this is to use algorithms, for example:

  * Round Robin: this algorithm involves evenly distributing incoming requests across all servers. Typically used if the servers all have similar specifications

  * Least Connections: the next request is sent to the server with the least number of active connections

There are many more algorithms that can be implemented dependant on need.

##### Services

As well as load-balancing HTTP requests, splitting an application's functionality across multiple **services** can help to scal an application. A service is another server that intereacts with the web server to perform a specific task as part of the overall application functionality. Each service has a self-contained unit of functionality, such as authorising users or providing a search functionality.

The main benefit of distributing responsibility in this way is it allows you to scale services indepentently of each other. The application code for each 'service' can also managed and developed independently.

Note: there are complexities involved in scaling web applications in this way such as managing persistence (i.e. handling multiple requests from clients to the same server for the duration of a session).

#### Content Delivery Networks (CDNs)

Things like load-balancing and services are great for scaling traffic, but the application is still centralised in one location. If the user-base is global, users far away from the server location will experience longer load times due to the time it takes to deliver packets across the network.

A common tactic to solve this is to use a content delivery network. A CDN is a large, distributed system of 'proxy' servers deployed across many data-centres globally. Proxy servers work by storing commonly used elements like HTML, CSS, files and images used by the application so that they can be delivered more quickly to clients located close to that proxy (meaning lower latency of the network connection).

---

## HTTP and REST

Clearly understanding HTTP is crucial for web developers because it facilitates the flow of information in web applications (allowing better user interactions and improved site performance).

### HTTP

In the Client-Server model, clients and servers exchenge messages in a 'Request-Response' pattern - the client sends a Request to the server and the server returns a Response.

In order to manage this interaction clients and servers adhere to a common language and set of rules - or protocol - called **HTTP**.

The HTTP protocol defines the *syntax* (data format and encoding), *semantics* (meaning assocaited with the syntax), and *timing* (speed and sequencing). Each HTTP Request and Response exchanged is considered a single **HTTP transaction**.

#### High-level Features

  * HTTP is text-based. Requests and Responses are bits of text. Messages contain two parts: header and body

  * HTTP is an application layer protocol. It's an abstraction layer that standardises how hosts communicte - it still relies on underlying protocols - such as TCP/IP - to actually transmit the data.

  * HTTPS is similar but different. An HTTP Request-Response is not encrypted. HTTPS is more secure and uses encryption. It stands for HTTP over TLS/SSL. SSL is a security protocol that allows a client and server to communicate securely. THe client typically indicates it requires a secure connection by using a specific port number - 443. Once a client and server agree to use this protocol the open a stateful connection using a 'TLS handshake'. The establish secret session keys to encrypt and decrypt messages.

#### HTTP Header

HTTP Headers containt metadata (data about data), including:

  * The requst type (`GET`, `POST`, `PUT`, `DELETE`)
  * Path
  * Status Code
  * Content-Type
  * User-Agent
  * Cookie
  * Post Body (occasionally)

##### HTTP Request Header

###### User-Agent

The software acting on behalf of the user (e.g. a web browser) - e.g. `Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.73 Safari/537.36`

###### Accept-Encoding

Specifies the types of content encoding that the client (e.g. browser) is willing to accept - e.g. `gzip, deflate, sdch`

###### Accept-Language

Describes the language that we want the web-page to be in - e.g. `en-gb` for UK English

###### Host

The domain/ host name to which the request is being sent - e.g. `mysite.com`

###### Cookie

A piece of test that the web server can store on a user's machine via the browser and later retrieve. It consists on name-value pairs - e.g. `_octo=GH1.1.491617779.1446477115; logged_in=yes; dotcom_user=iam-peekay; _gh_sess=somethingFakesomething FakesomethingFakesomethingFakesomethingFakesomethingFakesomethingFakesomethingFake; user_session=FakesomethingFake somethingFakesomethingFakesomethingFake; _ga=9389479283749823749; tz=America%2FLos_Angeles_`

When a browser visits a website, the browser will check for a cookie previously set by the site; if it finds one it will send the name-value pairs as part of the Request header. The application can then use the name-value pairs (e.g. to set user preferences).

##### HTTP Response Header

###### Request URL

The URL requested - e.g. http://mysite.com/

###### The Request Method

The type of HTTP method being used - e.g. `GET`

###### Status Code

A way for the server to inform the client about the result of its request - e.g. `200` OK (which means the resource was found and is being sent)

###### Remote Address

The IP address and port number of the website visited - e.g. 192.30.252.129:80

###### Content-Encoding

The encoding of the resource that is received - e.g. `gzip` (this tells the client that the content is compressed)

###### Content-Type

Specified the representation of the data in the response body (including the type and sub-type; type describes the overall data type while subtype indicates a specific format of that type of data) - e.g. `text/HTML; charset=utf8`

#### HTTP Body

The body is esentially the 'data' of the response (as opposed to the 'metadata' in the head). What is actually contained in the body depends on what was requested. In the case of a request for an HTML file - e.g. 'somepage.html' the body would contain the HTML from that page, if the request was for a JavaScript file - e.g. `scripts.js` the body would contain the JavaScript from that file, etc. 

[Note: depending on the type of request the body of an HTTP Response can also be empty]

#### HTTP Methods

HTTP Methods tell the server what action needs to be performed on which resource.

E.g.

  * `GET` http://www.example.com/users (get all users)
  * `POST` http://www.example.com/users/a-unique-id (create a new user)
  * `PUT` http://www.example.com/comments/a-unique-id (update a comment)
  * `DELETE` http://www.example.com/comments/a-unique-id (delete a comment) 

There are methods other than these (such as `HEAD` and `OPTIONS` but they are more rarely used).

When a client makes an HTTP Request, it will indicate the type of request in the header.

##### GET

`GET` is the most commonly used method. It is used to read information for a given url from a server. `GET` Requests are read-only (they don't *change* data) and are therefore considerd 'safe' opertions (calling it multiple times will have the same effect - they are **idempotent**).

`GET` Requests shoul receive a Response with a status code of `200 OK` if the resource was found and `404 NOT FOUND` if the resource was not found.

##### POST

`POST` is used to create a new resource - e.g. a new user via a user sign-up form. `POST` is not considered 'safe' or 'idempotent' (making two identical post requests will likely cause two resources to be created).

`POST` Requests receive a Response with a status code of `201 CREATED` along with a location header with the link to the new resource.

##### PUT

`PUT` is used to *update* the resource identified by the URL using the information in teh request body. `PUT` can also be used to create a new resource. `PUT` Requests arenot considered 'safe' operations as they modify state, they are however 'idempotent' because subsequent identical requests have the same effect as the first.

`PUT` Requests respond with a status code of `200 OK` if the resource was successfully updated and `404 NOT FOUND` if the resource was not found.

##### DELETE

`DELETE` is used to delete the resource identified by the URL. `DELETE` requests are considered 'idempotent' because you cannot delete the same resource multiple times, so subsequent identical requests have no effect. It is not considered 'safe' however as `DELETE` Requests modify state.

`DELETE` Requests respond with a status code of `200 OK` (or `204 No Content`) if the resource was successfully deleted and `404 NOT FOUND` if the resource was not found (which would likely be the case if multiple identical requests were issued.)


All Requests return a status code of `500 INTERNAL SERVE ERROR` if procesing fails and the server errors as a result.


#### REST

REST stands for 'Representational State Transfer'. It's an architectural style (essentially a set of guidelines) for designing applications. THe HTTP methods represent a lot of what REST is.

The basic idea is to use a 'stateless', 'client-server', 'cacheable' protocol (usually HTTP(S)) - these form part of a set of constraints to design an application with.

A full set of these constraints can be seen here:

https://en.wikipedia.org/wiki/Representational_state_transfer

Two of the most important are:

##### Uniform Interface

This constraint is to define the interface between the Client and Server in a way that simplifies and decouples the architecture -

  * Resources must be identifiable in a request. A *resource* (e.g. data in a database) is the data that defines the *resource representation* (e.g. HTML). Resources and Resource Representations are separate things. The client only deals with the Resource Representation.

  * The client must have enough information to manipulate resources on the server using the representation of the resource.

  * Every message exchanged between client and server needs to be *self-descriptive*, with information on how to process the message (e.g. meta content)

  * Clients must send *state data* using:
    * HTTP Request headers
    * HTTP body content
    * Query Parameters
    * the URL
  * Servers must send *state data* using:
    * HTTP Response Headers
    * HTTP body content
    * Response Codes

  * The HTTP methods (e.g. 'GET', 'POST', 'PUT', 'DELETE') make up a *major portion* of the 'uniform interace' because they represent uniform actions that happen to resources.

##### Stateless

This constraint says that all state data needed to handle a Request must be contained within the request itself (URL, query parameters, HTTP Body or HTTP Headers) and all state data to handle a Response must be sent by the server within the Response itself (HTTP Headers, Status Code, HTTP Response body)

*State, or 'application state' is the data necessary for a server to fulfill a request*

For every request the state information is sent and resent back and forth so that the server doesn't have to maintain and update the state.

Having a stateless system makes applications more scalable as no single server has to worry about maintaining the same session state over multiple requests - everything needed to get teh state data is available in the request and response iteself.

---

#### Sources

  * [How the Web Works: Overview](https://medium.freecodecamp.com/how-the-web-works-a-primer-for-newcomers-to-web-development-or-anyone-really-b4584e63585c#.g82gdlity)
  * [Client-Server Model & the Structure of a Web Application](https://medium.freecodecamp.com/how-the-web-works-part-ii-client-server-model-the-structure-of-a-web-application-735b4b6d76e3#.qr7bic5wz)
  * [HTTP and REST](https://medium.freecodecamp.com/how-the-web-works-part-iii-http-rest-e61bc50fa0a#.suxov4bi1)