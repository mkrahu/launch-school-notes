# HTTP Client Side and Server Side Code

*What is the difference between client-side and server-side code? For each file in a Sinatra project, be able to say which it is.*

Server-side code is *executed* on by the server (e.g. web server application). Client-side code is *executed* by the client (e.g. browser)

#### Gemfile

The Gemfile is serverside as this lists the dependencies required by the Ruby application in order to run correctly on the **server**

#### Ruby files (`.rb`)

Ruby files are server-side as they contain the application logic for running the application on the server. They have to be interpreted by software that is installed on the server.

#### Stylesheets (`.css`)

Stylesheets are client-side. They are served to the client following an http request and can typically be parsed by the requesting client (e.g. web browser)

#### JavaScript Files (`.js`)

JavaScript Files are typically client side and can be served to the client following an http request and can typically be parsed by the requesting client (e.g. web browser). Sometimes JavaScript can be run on the server as part of the application logic (e.g. Node.js)

#### View Templates (`.erb`)

View Templates are server-side as they need to be interpreted first of all by the application on the server. They output HTML which is then sent to the client.
