# Getter and Setter

Getter and setter methods allow you to get or set the value of an instance variable.

#### Example 1:
```ruby
class Human
  def initialize(name)
    @name = name
  end
end

kate = Human.new('kate')

kate.name # => NoMethodError: undefined method 'name' for...
```

In this example, although the instance variable @name was set to "Kate" at object
instantiation, there is currently no way of *getting* or *setting* the value of that
variable.

To do this getter and setter methods need to be defined in the class.

## Getter Method

#### Example 2:
```ruby
class Human
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

kate = Human.new('Kate')


kate.name # => "Kate"
```

In this example, because we have defined a *getter* method `name` we can *get* the 
value of the `@name` instance variable by calling the `name` getter method on the 
`kate` object. The only job of the `name` method is to return the value of the
`@name` instance variable.

## Setter Method

What if we want to change the value of the `@name` instance variable to something
other than "Kate"? For this we can use a setter method

#### Example 3:
```ruby
class Human
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

kate = Human.new('Kate')


kate.name = "Bob" # => sets the value of @name to 'Bob' and returns it
```

In this exampe we call the `name=` method on our `kate` object passing in
the argument "Bob". The `name=` method sets the value of the `@name` variable to
this.

It is usual to name the getter and setter methods to the same name as the instance 
variable they are exposing.

## attr_*

Because these getter and setter methods are so commonplace there is an inbuilt way in Ruby
to create them without actually defining a method in the class - this is done using the attr_*
syntax.

#### Example 4:
```ruby
class Human
  attr_reader :name
  attr_writer :name

  def initialize(name)
    @name = name
  end
end

kate = Human.new('Kate')

kate.name # => "Kate"
kate.set_name = "Bob" # => sets the value of @name to 'Bob' and returns it
```

In this example `attr_reader` takes the place of the getter method and `attr_writer` 
takes the place of the setter method.

Since we have both of them we could actually use `attr_accessor` which takes the place
both the getter and the setter.

All of the `attr_*` methods take a `Symbol` as parameters. If there is more than one
parameter they can be comma separated `attr_accessor :name, :height, :weight`
