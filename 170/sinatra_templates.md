# Sinatra Templates

*What are the benefits of using view templates? Be able to use an ERB template in a Sinatra route.*

  * Templates (or *view templates*) are files that contain text that is converted to HTML before being sent to the browser in a response.

  * There are a lot of different *templating languages* that provide different ways to define what HTML to generate and how to embed dynamic values.

  * A popular templating language for Sinatra and other Ruby frameworks is `ERB`
    * The name comes from *embeded Ruby*
    * It essentially embeds bits of Ruby in other code (e.g. HTML) using special tags

Example:
```ruby
<h1><%= @title ></h1>
```

Here is an erb tag inside an HTML tag. When the template is *rendered* the value for `@title` will replace the erb tag.

  * Any Ruby code can be placed in an `.erb` file by including it between `<%` and `%>`
  * If you want to display a value use a special start tag `<%=`
  * To use a template in a route in Sinatra you add it to the route
    * The name of the templete is passed to `erb` as a symbol
    * Sinatra will look for templates in a directory called `views` in the root of the app

Example:
```ruby
get "/" do
  erb :home
end
```

### Tilt

  * `tilt` is a thin interface over different ruby template engines
  * it attempts to make their usage as generic as possible
  * https://github.com/rtomayko/tilt
  * When using a templating engine like ERB it is useful to require `tilt`  in the app file
    * Although `erb` is included in Ruby, requiring it through `tilt` uses a specific implementation - `erubis`
      * This confers some performance benefits and other benefits (such as the the ability to auto-escape content)
      * `erubis` is also used in Rails
      * Note: the 'standard' implementation of `erb` included in Ruby is called `eruby`

Example:

```ruby
require "tilt/erubis"
```

https://launchschool.com/posts/02ef60e4

### Layouts

  * There can be a lot of duplication between view templates
  * Sinatra uses the concept of *layouts*
    * Layouts can be thought of a templates which wrap around other templates
    * Shared HTML can be put in a layout
    * HTML specific to a view can be put in a template

```html
<html>
  <head>
    <title>Using Layouts</title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

  * The `yield` keyword is used in a layout toindicate where the content from the template should go.
  * Sinatra will always look for a `layout.erb` file in the `views` folder and use it for all routes if it exists.

  * You can define a specific layout to use other than the default

Example:
```ruby
get '/' do
  erb :index, :layout => :post
end
```
