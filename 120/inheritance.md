# Inheritance

**Inheritance** is when a class **inherits** behavious from another class. The class that is inheriting is called the *subclass* and the class it inherits from the *superclass*.

Inheritance is used as a way to extract common behaviours from classes that share that behaviour. This enables logic to bekept in one place and follows DRY (Don't Repeat Yourself) methodology. Inheritance is a great way to remove duplication from your codebase.

#### Example 1:
```ruby

class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak           # => Hello!
puts paws.speak             # => Hello!
```

In this example the `speak` method is extracted to the superclass `Animal` and is made available to both the `GoodDog` and `Cat` subclasses via inheritance.

The `<` operator is used to signify that the subclasses are inheriting from the superclass. When a class inherits from another class, all of that other class's methods become available to it.

### Method Over-riding

If you want a subclass to use certain methods from the superclass but to use its own specific implementation for other methods that are defined in the superclass then those methods can be over-ridden by defining that method in the subclass also.

#### Example 2:
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak           # => Sparky says arf!
puts paws.speak             # => Hello!
```

In this example, the `speak` method from `Animal` class is over-ridden by defining a `speak` method in the `GoodDog` class. This works because when you call a method on an object, Ruby checks that object's class first to see if the method is defined in that class - if it is the that method implementation will be used, if not then the superclass will be checked to see if the method is defned there, and so on up the line of inheritance. This is called the *method lookup path*.

### super

In Ruby there is a builtin function called `super` that allows the calling of methods up the hierarchy. When `super` is called from within a method it will search the inheritance hierarchy for the new definition of a method by the same name and then invoke it.

#### Example 3:
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak        => "Hello! from GoodDog class"
```

In this example the `sparky` object (an instance of `GoodDog` class) is calling the `speak` method from `GoodDog` class (which over-rides the inherited method). This method uses `super` to invoke the `speak` method from the superclass and concatentates the return value ("Hello!") with the string " from GoodDog class". Using super in this way extends the functionality of the `speak` method from the `Animal` class.

A more common use of `super` is with `initialize`.

#### Example 4:
```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(name, age)
    super(name)
    @age = age
  end
end

GoodDog.new("Sparky", 4) # => #<GoodDog:0x007fb40b2beb68 @name="Sparky", @age=4>
```

When called with specified arguments, super will send those arguments up the method lookup chain. IN this example we see two arguments ("Sparky", 4) being passed the `new` method call on `GoodDog` class to be used by the parameters of the `initialize` method. One of these arguments is used by the `age` parameter of that method, and the other is used by the `name` parameter to passed to the call to `super` which in turn passes it to the `initialize` method of `Animal` class.

An interesting concept to note is that if `super` is called without an argument being passed to it but the method that super is calling form the superclass requires a argument then super will pass another parameter from the method within which it is being called (if there is one).

#### Example 5:
```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(age)
    super
    @age = age
  end
end

GoodDog.new(4) # => #<GoodDog:0x007fb40b2beb68 @name=4, @age=4>
```

In this example super takes the `age` parameter and passes it to the `initialize` method of `Animal` class so that both `@name` and `@age` variables are assigned to `4`.


## Mixing in Modules

[Modules](modules.md) are another way of following DRY principles to remove duplication from code. An example of how using a module within an inheritance hierarchy would be if there were cerain behaviours you wanted different classes to inherit but it didn't make logical sense to inherit them from a shared superclass.

#### Example 6:
```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable         # mixing in Swimmable module
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable         # mixing in Swimmable module
end
```

In this example it wouldn't make sense to include the `swim` method int he `Animal` class from which `Fish` and `Dog` both inherit but we also don't want to have to define `swim` separately in both `Fish` and `Dog` so we can instead define it in a module and `include` that module in both `Fish` and `Dog` so that they inherit the `swim` method of that module.

*Note: a common convention in Ruby is to suffix the verbs used for module names with "able". Not all modules are names in this manner but it is quite common.


## Inheritance vs Modules

Class inheritance are the two primary ways Ruby implements inheritance. There are certain things to remember when choosing to use one or the other.

* You can only subclass from one class but can mix in as many modules as you like.
* If it is an 'is a' relationship use class inheritance, e.g. a dog is an animal. If it is a 'has a' relationship use modules, e.g. a dog has an ability to swim.
* You cannot instantiate modules (i.e. object can be creatd from a module). Modules are sued only for namespacing and grouping common methods.


## Accidental Method Overriding

It is important to remember that every custom class that is created inherently subclasses from class `Object`. This class is built into Ruby and comes with many critical methods. Methods defined in the `Object` class are available in **all** classes. 

We've already seen an example of where you might want to over-ride one of `Object`'s methods with your own definition with `to_s` but in the majority of cases it is genreally not a good idea to overide the method's of the `Object` class.
