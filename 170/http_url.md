# HTTP URL

*Identify the components of a URL. Construct a URL that contains a few params and values.*

A URL like this:

`http://www.example.com:88/home?item=book`

is comprosed of several components.

  * `http` - this is the URL scheme (it comes before the `://`) and tells the web client *how* to access the resource - i.e. which *protocol* to use. Some other schemes are: `ftp`, `mailto` & `git`.

  * `www.example.com` - this is teh resource path or **host**. It tells the client where the resource is hosted or located.

  * `:88` this is the port number. The default port for http requests is `80` and this default is always asmed if no port number is specified, so you don't need tominclude the port number if you intend to just use the default.

  * `/home/` - this is teh URL path - it shows where the specific resource being requested is located (It is optional and only required if a specific resource is being requested)

  * `?item=book` - these are query string parameters. They consist of name-value pairs separated by a `=` sign and coming after a `?` sign. They can be used to send data to the server about the request being made. Query parameters are optional.

### Query Strings and Parameters

A URL with query strings might look like this:

```bash
http://www.example.com?search=ruby&results=10
```
It has several components:

  * `?` this marks the start of a query string. It is a reserved character (i.e. you can't use it elsewhere in a url)

  * `search=ruby` - name value pair for a certain parameter

  * `&` - used as a divider between each name value pair when adding multiple parameters to a query string (also a reserved character)

  * `results=10` - another name value pair for a different parameter

Query strings are used to pass informtation from the client to the server about the request being made. For example in the url:

```bash
http://www.phoneshop.com?product=iphone&size=32gb&color=white
```

the query string is being passed to the server and can be used by the web application on the server side to filter the available data sent back to the client so that only the data relevant to the search is sent.

**Because query strings are passed in through the url they are only used in HTTP GET requests.**

Query strings do have some limits to their use:

  * They have a maximum length, so there is a limit to the amount of data you can pass with them
  * The nams/value pairs are visible in the url (so they are not recommended for things like passing username and password)
  * They cannot use spaces and special characters (such as `&`). They must be url encoded

#### URL Encoding

  * URLS are designed to only accept some characters in the ASCII character set

  * Unsafe or reserved characters not included in the set have to be encoded

    * Encoding involves replacing these characters with a `%` symbol followed by two hexadecimal digits for the ASCII code of the character

    * Some common ASCII codes are:

      * `20` - space
      * `21` - `!`
      * `2B` - `+`
      * `23` - `#`

  * Characters must be encoded if:

    * They haveno corresponding character in the ASCII character set
    * The character is 'unsafe' because it is used for encoding other characters (e.g. `%`)
    * The character is reserved for special use within the URL scheme (e.g. `/`, `?`, `&`)

  * Characters that do not require encoding are:
    * alphanumeric characters
    * The special characters `$` `-` `_` `.` `+` `!` `'` `(` `)` `"` `
    * Reserved characters as long as they are being used for their reserved purpose


