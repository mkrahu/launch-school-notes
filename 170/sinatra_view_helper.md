# Sinatra View Helpers

*Write a view helper and use it within a view template.*

  * A *helper* or *view helper* is a method that is made available in templates by Sinatra
  * They are used for teh purpose of filtering or processing data that is rendered to the page
  * Helpers are defined within a `helper` block

Example:

```ruby
helpers do
  def slugify(text)
    text.downcase.gsub(/\s+/, "-").gsub(/[^\w-]/, "")
  end
end
```
  
  * Helpers can be used like any other method in a template

Example:

```html
<a href="/articles/<%= slugify(@title) %>"><%= @title %></a>

<!-- which would render the output -->

<a href="/articles/today-is-the-day">Today is the Day</a>
```


