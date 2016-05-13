# Instance Variables and Methods

## Instance variables

If we wanted to initialise a new instance of a class and assign a state to it
at instantiation we could do this by defining the `initialize` method of that class
as requiring an argument. This argument could then be assigned as a value to an instance
variable.

Instance variables have a `@` before the variable name; other than that they look like 
local variables (written in `snake_case`).

An instance variable exists as long as the object instance exists and is one of the ways data
is tied to objects.

#### Example 1:
```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end

sparky = GoodDog.new("Sparky") # => creates an instance of GoodDog class with the @name
                               # instance variable set to the string "Sparky"
```

In this example the string "Sparky" is passed from the `new` method through to the
`initialize` method and is assigned to the local variable `name`. Within the constructor
(i.e. the `initialize` method) the instance variable `@name` is then set to `name` (which 
results in assigning the string "Sparky" to the `@name` instance variable).

Instance variables are responsible for keeping track of information about the *state* of an
object. The name of the `sparky` object is the string "Sparky". this state for the object
is tracked in the instance variable `@name`. Every object's state is unique and instance 
variables are how we keep track.

## Instance Methods

Instance methods define the *behaviours* available to an object (or instance) from within 
the definition of the class from which that object is instantiated.

If we want `sparky` to bark we can define a `bark` method in the GoodDog class.

#### Example 2:
```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof! Woof!"
  end
end

sparky = GoodDog.new("Sparky")

sparky.bark # => "Woof! Woof!"
```

Instance methods can also be used to expose information about the state of an object.

#### Example 3:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def bark
    puts "#{@name} says Woof! Woof!"
  end
end

sparky = GoodDog.new("Sparky")

sparky.bark # => "Sparky says Woof! Woof!"
```

In this example we include the `@name` instance variable in the output of the `bark`
instance method. In this way we are using the method to expose the state of name from
the `sparky` object.
