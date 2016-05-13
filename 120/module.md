# Modules

Modules are another way to achieve polymorphism in Ruby. A **module** is a 
collection of behaviours that is usable in other classes via **mixins**. A
module is *mixed in* to a class by using the `include` reserved word (or the `extend`
reserved word for class methods). 

Modules are defined using the `module` reserved word.

#### Example 1:

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


## Namespacing

As well as being used to group common behaviours so that they can be 'mixed in' to classes, modules can also be used for **namespacing**. In this context namespacing means organising similar classes under a module; in other words modules are used to group related classes.

* The first advantage of namespacing in this way is that it becomes easy to recognise related classes in the codebase.
* The scond advantage is that it reduces the likelihood of similarly named classes colliding.

#### Example 2:
```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```

Classes in a module are called by apending the class name to the module name with two colons (`::`).
```ruby
buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')           => "Arf!"
kitty.say_name('kitty')       => "kitty"
```

## Modules as Containers

Another use-case for modules is using modules as a **container** for methods. This involves using modules to house methods called module methods. These methods are prepended by the reserved word `self`.

#### Example 3:
```ruby
module Mammal
  def self.a_module_method(num)
    num ** 2
  end
end
```

Defining methods in this way means we can call them directly from the module:
```ruby
value = Mammal.a_module_method(4) # => 16

value = Mammal::a_module_method(4) # => 16

# The syntax of both these method calls is valid though the former is usually preferred
```
