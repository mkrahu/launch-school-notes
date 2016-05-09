# Classes and Objects

Classes and Objects are used as *containers for data* that can be changed and manipulated without affecting
the entire program. They allow programs to become teh interaction of many small parts rather than one big blob
of dependency.

Using Objects and Classes allows you to achieve certain things which form part of the OOP coding paradigm:

#### Encapsulation

Encapsulation is hiding pieces of functionality and making it unavailable to the rest of the code base. It defines
the boundaries of the application and allows code to achieve higher levels of complexity.

#### Polymorphism

Polymorphism is the ability for data to be represented as many different types. 

The concept of **inheritance** is
used in Ruby where a class inherits behavious from another class, referred to as the **superclass**. This gives
the ability to define basic classes with large reusability and smaller **subclasses** for more fine-grained,
detailed behaviours.

Another way to apply polymorphic structure is to use a `Module`. Including a module in a class can allow that
class to share behaviours from that module, however you cannot create an object from a module.

## Objects

1. Everything in Ruby is an Object!
2. Objects are created from Classes
  * An object is an *instance* of a class 
3. Individual objects contain different information from other objects 
yet they are instances of the same class

#### Example 1:
```ruby
"hello".class # => String

"goodbye".class # => String
```

Both `"hello"` and `"goodbye"` objects in this example are *instances* of String class

## Classes

Classes define objects. Ruby defines the attributes and behaviours of its objects in **classes**. A class is
essentially a *mould* from which an object is made - it defines the basic outlines of what an object should be
and what it should be able to do.

Classes are defined using the `class` keyword with class names written in CamelCase.

```ruby
class GoodDog
end

sparky = GoodDog.new # here we are creating an instance of GoodDog class
```

In the example an *instance* of GoodDog class is *instantiated* by calling the `new` method on the GoodDog class
and stored in the local variable `sparky`. This instance of GoodDog is an object.
