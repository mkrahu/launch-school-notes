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

Other comparison methods sunch as `<`, `>` and `===` can also be over-ridden.


### Comparison Methods


