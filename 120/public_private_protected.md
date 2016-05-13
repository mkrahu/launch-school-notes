# Public, Private, Protected

By default all methods defined in a class are *public*. A **public method** is a method that is available  to anyone who knows either the class name or the object's name. These methods are readily available for the rest of the program to use and together comprise the class's *interface* (how other classes and objects interact with this class and its objects).

Sometimes you will have methods doing work in the class (e.g. a *helper method*) but they don't need to be available to the rest of the program. These methods can be defined as **private**. The reserved word `private` is used within the class definition to define methods as private. Any methods below the word `private` are private methods.

#### Example 1:
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end

  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end

  private

  def human_years
    self.age / DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
```

If we try to call the `human_years` method on the `sparky` object we get an error message:
```ruby
NoMethodError: private method `human_years' called for
  #<GoodDog:0x007f8f431441f8 @name="Sparky", @age=28>
```

The method is not available outside of the GoodDog class. We can however call the `public_discolsure` method (which uses the private `human_years` method on the `sparky` object as this forms part of the clases interface.

### Protected

In some situations you will want an in-between approcah between public and private methods; this is when **protected** methods can be used. Protected methods essentially follow these two rules:

* from outside the class `protected` methods act just like `private` methods
* from inside the class, `protected` methods are accessible just like `public` methods

#### Example 2:
```ruby
class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method        # => Will this work? Yes, I'm protected!

fido.a_protected_method
  # => NoMethodError: protected method `a_protected_method' called for
    #<Animal:0x007fb174157110>
```

So the protected method can be called on the object from *inside* the class but cannot be called on the object from *outside* the class.

The rules for `protected` methods apply within the context of inheritance as well.
