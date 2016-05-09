# Modules

Modules are another way to achieve polymorphism in Ruby. A **module** is a 
collection of behaviours that is usable in other classes via **mixins**. A
module is *mixed in* to a class by using the `include` reserved word (or the `extend`
reserved word for class methods). 

Modules are defined using the `module` reserved word.

#### Example 1

Say we wanted GoodDog class to have a `speak` method but have other classes which we
want to use the same `speak` method we could define the method in a module and then
`include` the module in the class.

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class Human
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!") # => "Arf!"
bob = Human.new
bob.speak("Hello!") # => "Hello!"
```

Both the object created from the the GoodDog class (sparky) and the object created from
the Human class (bob) have access to the `speak` instance method. 
