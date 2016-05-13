# Class Variables and Methods

Whereas instance variables and methods pertain to a particular instance of a class
(i.e. a specific object), class variables and methods relate to the class itself.

## Class Methods

Class methods can be called directly on the class iteself without having to instantiate na object.
When defining a class the method name is prepended witht eh reserved word `self`.

#### Example 1:
```ruby
class MyClass
  def self.my_class_method
    puts 'I am a class method'
  end
end

MyClass.my_class_method # => 'I am a class method'
```

Class methods deal with functionality that does not pertain to individual objects. Objects contain
state, and if a method does not need to reference an object's state then it can be a class method.


## Class Variables

Whereas instance variables capture information related to secific instances of a class (i.e. objects),
variables can be created that capture information for an entire class - **class variables**.
Class variables use `snake_case` and are prepended by two `@` symbols like so `@@`.

#### Example 2:
```ruby
class MyClass
  @@number_of_instances = 0

  def initialize
    @@number_of_instances += 1
  end

  def self.total_number_of_instances
    @@number_of_instances
  end
end

puts MyClass.total_number_of_instances # => 0

instance_1 = MyClass.new
instance_2 = MyClass.new

puts MyClass.total_number_of_instances # => 2
```

In this example the class variable `@@number_of_instances` is initialised to 0. Within the constructor
method `initialize` that number is incremented by 1. Since initialize gets called every time a new instance
of the class is created, after calling `new` on the class twice the variable is now 2.

Class variables give the ability to kep track of class level detail that pertains only to the class not
to individual objects.


## Constants

When creating classes there may also be certain variables that you never want to change. This can be done
by creating what are called **constants**. Constants are defined by using an upper case letter at the beggining of the variable name. In practise most Rubyists make the entire variable uppercase (though this is
not strictly required).

#### Example 3:
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age # => 28
```

In this example the constant `DOG_YEARS` is used to calculate the value for the instance variable
`age` when the object is created. (Note: setter methods are used in the initialize method definition).

`DOG_YEARS` is a variable that will never change for any reason so a constant can be used. It is possible to reassign the value of a constant but Ruby will throw a warning.


## The to_s method

The `to_s` method comes built into every class in Ruby. By default when the `to_s` method is called on an object it prints the object's class and an encoding of the object id.

Calling `sparky.to_s` will return something like `#<GoodDog:0x000000027db2a0>`

It is possible to add a custom `to_s` method to a class which outputs something more readable/ useful.

#### Example 4:
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.to_s # => "This dog's name is Sparky and it is 28 in dog years."
```

### puts and p

`puts sparky` will output the return value in the example above as `puts` automatically calls `to_s` and outputs its return.

As well as being called automatically when using `puts`, another important atribue of the `to_s` method is that is is automatically called in string interpolation.

In a similar way, calling `p` on an object outputs the return value of the `inspect` method (this is another method that is automatically built into all classes). As well as returning the class and object id, `p` also returns the names and values of instance variables (i.e. the state) of the object.

`p sparky # => #<GoodDog:0x000000027db2a0 @name="Sparky", @age=28>`

Unlike `to_s`, `inspect` generally isn't over-ridden by custom method definitions as it useful for debugging purposes.
