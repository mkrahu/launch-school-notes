# Web Security

*Why is user-entered content a security risk? Be aware of how to mitigate this risk.*

## Risk: Packet Sniffing

- Requests and resposnes are sent as *strings*
- Malicious hackers on same network can employ *packet sniffing* to read these strings
- Since requests can contain session id, this can copied and the hacker pose as the client
  - Hackers could craft a request to server which gives impression of being logged in without need for username and password

#### Mitigating Risk: HTTPS

- Secure HTTP (HTTPS) is a version of the HTTP protocol
- Requests using this protocol start with `https://` in the browser address bar rather than `http://`
- A lock icon is often displayed in the browser address bar
- With HTTPS every request/ response is encrypted
  - If packets are *sniffed* data is encrypted and therefore cannot be used by hackers
- HTTPS send data through a cryptographic protocol - `TLS`
  - Earlier versions of HTTPS used `SSL` (Secure Sockets Layer) until TLS developed
- `TLS` and `SSL` use *certificates* to comunicate with remote servers and exchange security keys before data encryption occurs
- Certificates can be viewed by clicking on the padlock icon
  - Most modern browsers do some high-level certificate check, though manually checking can be an extra security check

## Risk: Session Hijacking

- The session plays an important role in giving HTTP the impression of 'statelessness'
  - The **session id** serves as a unique token to identify each session
  - Session id is usually implemented as a random string and comes in the form of a browser cookie
  - The session id is sent with every request from client ot server - this is used by many web applications with authentication systems
- If a hacker gets hold of the session id they can potentially access the web application posing as the user

#### Mitigating Risk: Resetting Sessions

- With authentication systems a succesful login must render an old session id invalid.
- Many websites implment this by making sure users reauthenticate when entering any potentially sensitve area or performing some action (e.g. charging a credit card)

#### Mitigating Risk: Expiring Sessions

- Sessions that do not expire give attackers an infinite amount of time to pose as the user
- Expiring sessions after, say, 30 minutes, narrows the window of attack

#### Mitigating Risk: HTTPS

- Using HTTPS across the entire site can minimise the chance that an attacker can get ot the session id

#### Mitigating Risk: Same Origin Policy

- Same origin policy permits resources originating from the same site to access each other
- It prevents access to documents/ resources on different sites
- Documents in the same **origin** must have the same
  - protocol
  - hostname
  - port number
- While secure it can be cumbersome for web developers
  - There are legitimate needs for cross-domain content access
  - **CORS* (Cross-origin Resource Sharing) was developed
  - CORS is a mechanism that allows resources from one domain to be requested from another domain (by-passing the same origin policy)
  - CORS works by adding new HTTP headers which allow servers to serve resources to permitted origin domains

## Risk: Cross-Site Scripting (XSS)

- XXS happens when you allow users to input HTML or JavaScript that ends up being displayed on the site directly (e.g. a comment section on a blog post)
- If the server doesn't do any inout sanitization the user input will beinjected into the page contents (i.e. the browser will interpret the HTML and JS and execute it)
- Attackers can craft malicious HTML and JS that can be destructive to the server as well as other visitors to the page (e.g. the attacker could use a JS script to grab the session od of every future visitor to the page)
- XXS can by-pass same origin policy because the code is executed on the site itself

#### Mitigating Risk: Sanitizing Input

- Eliminate problematic input, such as `<script>` tags
- Disallow HTML and Javascript altogether in favour of something safer (e.g. Markdown)

#### Mitigating Risk: Escaping User-input Data

- If allowing users to input HTML and JS is necessary, then when it is printed ensure the the browser does not interpret it as code. This can be done by *escaping* the input when displaying it (e.g. wrapping it in certain special tags to render it in a specific way)


