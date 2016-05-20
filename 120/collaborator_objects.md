# Collaborator Objects

Classes group common *behaviours* (methods) and objects encapsulate *state* (in instance variables). Instance methods can operate on the instance variables. Often the instance variable will be assigned to a string or number - e.g. a `Person` object's `name` attribute can be saved in a `@name` instance variable as a string.

Instance variables can however hold **any** object - not just strings and integers; it can hold data structures like arrays or hashes.

#### Example 1:
```ruby
class Person
  def initialize
    @heroes = ['Deadpool', 'Spiderman', 'Wolverine']
    @cash = {'ones' => 12, 'fives' => 2, 'tens' => 0}
  end

  def cash_on_hand
    # some method to calculate total cash from the hash items
  end

  def heroes
    @heroes.join(', ')
  end
end

joe = Person.new
joe.cash_on_hand # => $22.00
joe.heroes # => "Deadpool, Spiderman, Wolverine"
```

Instance variables can be set to any object, even an object of a custom class we've created.

#### Example 2:
```ruby
class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
paws = Cat.new

bob.pet = paws
```

In this example the `@pet` instance varibale for the `bob` `Person` object is set to the `paws` which is an object of `Cat` class. Calling `bob.pet` will return the `paws` `Cat` object.
```ruby
bob.pet # => #<Cat:0x007fd8399eb920>
bob.pet.class # => Cat
```

If we wanted to allow multiple pets we could change the implementation and use a collection to store the pet objects - the instance variable would be assigned to the collection.

 #### Example 3:
 ```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

paws = Cat.new
bud = Bulldog.new

bob.pets << paws
bob.pets << bud

bob.pets  # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
 ```

The pet Cat and Bulldog objects are stored in an array. Because it's an array you can't just call methods of the objects classes stored in the array on the `pets` accessor.
```ruby
bob.pets.jump # NoMethodError: undefined method `jump' for [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]:Array
```

Since there's no `jump` method defined in the `Array` class calling `jump` on `pets` (which is an array) throws an error. If we wanted to make each individual pet jump we'd have to parse out the elements in the array (e.g. by iterating through it) and operate on each individual object in the array (this is assuming `jump` is defined in both `Cat` and `Bulldog` class or a common ancestor of those classes).

#### Example 4:
```ruby
bob.pets.each do |pet|
  pet.jump
end
```

Working with collaborator objects in your class is no different than working with strings or integers or arrays or hashes. When modeling complicated problem domains, using collaborator objects is at the core of OO programming, allowing you to chop up and modularize the problem domain into cohesive pieces.
