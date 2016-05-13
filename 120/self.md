# Self

We use `self` to define a certain scope for a program. 

The word `self` can refer to different things depending on where it is used:

* `self` is used when calling setter methods from within a class - this allows Ruby to disambiguate between initialising a local variable and calling a setter method.
* `self` is used for class method definitions.

### Self and Instance Methods

#### Example 1:
```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
 # => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```

If we call the `what_is_self` method on the `sparky` object we can see that the value for `self` that is returned by the method is essentially the calling object itself. Therefore from within the `change_info` method calling `self.name` is the same as calling `sparky.name`.


### Self and Class Methods

The other place `self` is used is to define class methods.

#### Example 2:
```ruby
class MyClass
  def self.this_is_a_class_method
  end
end
```

When `self` is prepended to a method definition it is defining a **class method**. This works because `self a class but *outside* an instance method is referring to the class itself (whereas `self` *inside* an instance method is referring to the object calling that method). Therefore a method definition prefixed with `self` is the same as defining the method on the class.

Just to reiterate:

* `self` inside of an instance method references the instance (object) which called the method
* `self` inside a class but outside an instance method references the class and can be used to define class methods.
