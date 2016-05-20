# Truthiness

The ability to express __*true*__ or __*false*__ is an important concept in any programming language - it helps build conditional logic and understand the state of an object or expression. Usually the notion of whether a value is 'true' or 'false' is captured ina  **boolean** data type. A boolean is an object whose only purpose is to convey whether it is true of false.

In Ruby booleans are represented by the `true` and `false` objects. Like everything else in Ruby boolean objects have real classes defining the and methods can be called on `true` and `false`.

## True and False methods

```ruby
true.class          # => TrueClass
true.nil?           # => false
true.to_s           # => "true"
true.methods        # => list of methods you can call on the true object

false.class         # => FalseClass
false.nil?          # => false
false.to_s          # => "false"
false.methods       # => list of methods you can call on the false object
```

## Expressions and Conditionals

Generally `true` and `false` objects aren't used directly in a  conditional, instead it's likely some expression or method call will be evaluated in a conditional. Whatever the expression it should evaluate to a `true` or  `false` object.

#### Example 1:
```ruby
num = 5

if (num < 10)
  puts "small number"
else
  puts "large number"
end
```

In this example the output is `"small number"` because the expression `num < 0` evaluates to `true`.

#### Example 2:
```ruby
def some_method_call
  true
end

puts "it's true!" if some_method_call
```

In this example the output will be `"it's true!" since the return value of `some_method_call` is `true`


### Logical Operators

Logical operators are *comparison* opertors and will return a boolean when comparing two expressions.

* `&&`: this is the "and" operator and will return true only in **both** expressions compared are true.

#### Example 3:
```ruby
true && true # => true
true && false # => false

num = 5
num < 10 && num.odd? # => true
num > 10 && num.odd? # => false
```

One thing to note here is the order of precedence - Ruby considers `>` as a higher precedence than `&&` and so didn't get confused and think we were trying to do this: `num > (10 && num.odd?)`.

You can chain as many expressions as you like with `&&` and they will be evaluated from left to right. If any expression is `false` the entire `&&` chain will return false.

#### Example 4:
```ruby
num = 5

num < 10 && num.odd? && num > 0 # => true

num < 10 && num.odd? && num > 0 && false # => false
```

* `||`: this is the "or" operator and will return true if wither one of the comparison objects is true. It is less strict than the `&&` operator.

#### Example 5:

The only way to return `false` is if **all** expressions are `false`
```ruby
true || true # => true
false || false # = > false
true || false # => true
false || true # => true
```
As with `&&` you can chain as many expressions together as you like.

### Short Circuiting

The `&&` and `||` operators exhibit a behaviour called *short circuiting*, which means it will stop evaluating expressions once it can guarantee a return value.

#### Example 6:

The `&&` will short-circuit when it encounters the first `false` expression.
```ruby
false && 3/0 # => false
```

The code in this example doesn't generate a `ZeroDivisionError`. This is because the `&&` operator didn't evalaute the second expression - since the first expression is `false` it can short-circuit and return `false`. (Note: `false || 3/0` will generate an error).

#### Example 7:

The `||` will short-circuit when it encounters the first `true` expression.
```ruby
true || 3/0 # => true
```
(Note: similarly to before `true && 3/0` *will* generate an error).


## Truthiness

Truthiness differes from `true` in that Ruby considers more then the `true` object to be "truthy". In fact Ruby considers __*everything*__ to be truthy __*other than*__ `false` and `nil`.

This means **any** expression can be used in a conditional or with logical operators, and as long as it doesn't evaluate to `false` or `nil` it is considered 'true'. This is what "truthiness" means.

#### Example 8:
```ruby
num = 5

if num
  puts "valid number"
else
  puts "error!"
end
```

If you weren't familair with Ruby you might expect the above should either output `"error!"` or the program should generate an error of some sort. The program *actually* outputs `"valid number"`; the reson for this is that Ruby considers any integer to be "truthy". (Note: this does **not** mean that the `num` variable is equal to `true`).

This means that even the integer `0` is considered truthy - which is not the case in some other languages. Rubyists take advantage of truthiness to write some interesting code (which can at first appear confusing).

The important rule to remember is: everything in Ruby is considered "truthy" except `false` and `nil`.
