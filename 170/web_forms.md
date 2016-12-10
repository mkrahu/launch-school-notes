# Web Forms

*How does an HTML form element interact with the server-side code that processes it.*

There are a number of ways to get data into the `params` hash in Sinatra:

  * Using a Segment of the route as a parameter
  * Using query parameters in the url
  * By submitting a form using an `HTTP` request

### HTML Form Element

  * A form element requires `action` and `method` attributes

Example:
```html
<form action="/search" method="get">
```

  * The action should be the route or url that will process the form input
  * The method can be `GET` or `POST`
    * `GET` would generally be used if the action is non-destructove (e.g. a search form)
    * `POST` would generally be used for destructive actions (e.g. modifying some data or creating a new record)
  * Data in form inputs will be added to the `params` hash by Sinatra, accessible via the value of the `'name'` attribute of each input element


