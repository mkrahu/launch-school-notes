# Fake Operators

In Ruby there is a fair bit of syntax that looks like like it might or should be an operator but is actually a method call. These are called __*fake operators*__.

On example would be the `==` symbol. In another language (e.g. PHP) this might simply be an equality operator. In Ruby it is actually a method rather than an operator and its functionality is determined by the way the method is defined in the class of the object on which you are calling it. `obj1 == obj2` is actually `obj1.==(obj2)` but Ruby allows us to use the more natural syntax.

## List of Operators (Real and Fake)

| Method? | Operator | Description |
|---------|----------|--------------------------------|
| yes | `[]`,`[]=` | Collection element getter and setter. |
| yes |  `**`  | Exponential operator |
| yes |  `!`, `~`, `+`, `-`  | Not, complement, unary plus and minus (method names for the last two are +@ and -@) |
| yes |  `*`, `/`, `%`   | Multiply, divide, and modulo |
| yes |  `+`, `-`  | Plus, minus |
| yes |  `>>`, `<<`  | Right and left shift |
| yes |  `&`   | Bitwise "and" |
| yes |  `^`, |  Bitwise inclusive "or" and regular "or" |
| yes |  `<=`, `<`, `>`, `>=`  | Less than/equal to, less than, greater than, greater than/equal to |
| yes |  `<=>`, `==`, `===`, `!=`, `=~`, `!~`  | Equality and pattern matching (!= and !~ cannot be directly defined) |
| no  | `&&`  | Logical "and" |
| no  | `||`  | Logical "or" |
| no  | `..`, `...`   | Inclusive range, exclusive range |
| no  | `? :`   | Ternary if-then-else
| no  | `=`, `%=`, `/=`, `-=`, `+=`, `|=`, `&=`, `>>=`, `<<=`, `*=`, `&&=`, `||=`, `**=`, `{` |   Assignment (and shortcuts) and block delimiter |

Everything marked with a 'yes' in the 'Method?' column means that these operators are actually methods and therefore that their functionality can be over-ridden by creating custom definitions for those methods in our codebase. This is a very powerful and useful option to have but also potentially dangerous so must be used sensibly.


### Equality Methods

One of the most commonly over-ridden fake operators is the `==` equality operator. It is very useful in a custom class to define how two objects of that class should be compared.

#### Example 1:
```ruby
class Person
  attr_accessor :name
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => false

bob_copy = bob
bob == bob_copy            # => true
```

Here the call to `==` on the `Person` object is calling the standard `==` method which the `Person` class inherits from teh `BasicObject` class. The default version of this method tests fro equality ans since `bob` and `bob2` are different objects they are not equal despite having the same name.

#### Example 2:
```ruby
class Person
  attr_accessor :name

  def ==(other)
    name == other.name     # relying on String#== here
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => true
```

In this example the `==` method is over-ridden to simply compare the value of the `name` instance variable of the two objects. So in this case `bob == bob2` returns `true`.

Note: if you define a `==` method you automatically get a `!=` method.


### Comparison Methods

Other comparison methods such as `<`  `>` can also be over-ridden/ defined in custom classes.

#### Example 3:
```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)
```

In this example there is a custom `Person` class with instance variables for `name` and `age` and two instances of the class have been created `bob` and `kim`. If we attempt a comparison of them however with the `>` comparison operator we get a `NoMethodError` because there isn't a `>` method for `Person` class.
```ruby
puts "bob is older than kim" if bob > kim # => NoMethodError
```

The method can be defined comparing the values of the `age` variable from both objects (which is a Fixnum and so uses the `>` method of `Fixnum` class):
```ruby
class Person
  # ... rest of code omitted for brevity

  def >(other_person)
    age > other_person.age
  end
end
```

The method can then be called using either the standard method call syntax or the more natural 'operator' syntax:
```ruby
puts "bob is older" if bob.>(kim)           # => "bob is older"
puts "bob is older" if bob > kim            # => "bob is older"
```

Note: defining a `>` method does not automatically provide a `<` method - this would have to be defined separately.


### The `<<` and  `>>` shift methods

Just like any other fake operators `<<` and `>>` can be over-ridden to do anything - they are just regular instance methods. When over-riding 'operator-like' methods it is always a good idea to define functionality that makes sense int eh context of the operator-like syntax. For example using `<<` fits well when working with a class that represents a collection.


### The Plus Method

`1 + 1` may seem like an operation but in Ruby this is actually a method call.
```ruby
1 + 1 # => 2
1.+(1) # => 2
```

Here when `+` is being called on an integer, this is an object of the `Fixnum` class and so the `+` method for that class is used. 

`+` does different things depending on its method implementation within the class for the object upon which it is being called.

* `Fixnum#+`: increments the value by value of the argument, returning a new integer
* `String#+`: concatenates with argument, returning a new string
* `Array#+`: concatenates with argument, returning a new array
* `Date#+`: increments the date in days by value of the argument, returning a new date

Generally though the `+` should be either incrementing or concatenating with the argument.


### Element setter and getter methods

Out of all the 'operator-like' methods `[]` and `[]=` are perhaps the most extreme in the way that they alter teh syntax from the standard method syntax.

#### Example 4:
```ruby
my_array = %w(first second third fourth)    # ["first", "second", "third", "fourth"]

# element reference
my_array[2]                                 # => "third"
my_array.[](2)                              # => "third"
```

In this example both method calls are identical but look dramatically different. This is just Ruby providing nice, readable syntax.

The difference in syntax for the `[]=` method is even more dramatic.

#### Example 5:
```ruby
# element assignment
my_array[4] = "fifth"
puts my_array.inspect                            # => ["first", "second", "third", "fourth", "fifth"]

my_array.[]=(5, "sixth")
puts my_array.inspect                            # => ["first", "second", "third", "fourth", "fifth", "sixth"]
```

When using custom definitions for element getter and setter methods in a class, this should be done with a class that represents a collection.
