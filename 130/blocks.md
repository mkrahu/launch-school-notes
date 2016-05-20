# Blocks

Blocks are used very commonly in Ruby code.

#### Example 1:

```ruby
[1, 2, 3].each do |number|
  puts number
end

[1, 2, 3].each { |number| puts number }
```

These examples are typical syntax for a block in Ruby.

## Closures in Ruby

A *closure* is a general programming concept that allows programmers to *save a 'chunk of code'* and execute it at a later time. It is called a 'closure' because it is said to *bind* to its surrounding artifacts (variables, methods, objects, etc) and build an 'enclosure' around everything so that they can be referenced when the closure is later executed.

It is sometimes useful to think of a closure as a method that you can pass around and execute but it is not defined with an explicit name.

In Ruby a closure is implemented through a `Proc` object. A `Proc` object can be passed around as a 'chunk of code'. Essentially a `Proc` is a 'chunk of code' that retains references to its surrounding artifacts - its **bindings**.

There are three main ways to work with closures in Ruby (or `Proc` objects):

1. Instantiating an object from the `Proc` class
2. Using **lambdas**
3. Using **blocks**

## Calling Methods with Blocks

Breaking down the example from earlier:

```ruby
[1, 2, 3].each do |number|
  puts number
end
```

This is the object we're working with - an `Array` of numbers:
```ruby
[1, 2, 3]
```
This is the method we are calling on that object, i.e. `Array#each`:
```ruby
         .each
```
The rest of the code (the `do ... end` part) is the **block**:
```ruby
                do |number|
  puts number
end
```

The block here is an *argument* to the method call (in this case `Array#each`). `[1, 2, 3].each { |number| puts number }` is actually *passing in* the blcok of code to the `Array#each` method.

Whe passing a block to a method it is important to understand the return value of the method.

#### Example 2:
```ruby
3.times do |number|
  puts number
end

# => 3
```
The `times` method of `Integer` returns `self`, i.e. the *calling object*, which in this case is `3`.

#### Example 3:
```ruby
[1, 2, 3].map do |number|
  number + 1
end

# => [2, 3, 4]
```

The `map` method of `Array` returns a new array, with the values manipulated according to the logic in the block.

The fact that sometimes the code in the block affects the return value and sometimes not is nothing to do with the block - it is due to the way the method is implmented in the class of the calling object. The block has nothing to do with the method implementation - it is simply passed into the method like any other parameter - it is up to the method implementation to decide what to do witht he block of code given to it.


## Writing Methods that take Blocks

In Ruby every method can take an optional block as an implicit parameter, even if that method is not defined as taking any argmuments - you can just add it on the end of teh method invocation.

#### Example 4:
```
def echo(str)
  str
end

echo # => ArgumentError: wrong number of arguments (0 for 1)
echo("hello!") # => "hello!"
echo("hello", "world!") # => ArgumentError: wrong number of arguments (2 for 1)

# this time, called with an implicit block
echo { puts "world" } # => ArgumentError: wrong number of arguments (0 for 1)
echo("hello!") { puts "world" } # => "hello!"
echo("hello", "world!") { puts "world" } # => ArgumentError: wrong number of arguments (2 for 1)
```
Unlike other parameters the block does not cause an `ArgumentError`.

### Yielding

In the above examples the block was being passed to the `echo` method, but the method wasn't defined to do anything with the block once passed. One way the passed-in block can be invoked by the method is by using the `yield` keyword.

#### Example 5:
```ruby
def echo_with_yield
  yield
  str
end

echo_with_yield("hello!") { puts "world" }   # "world"
                                             # => "hello!"
```

The method call here outputs the string `"world"` and then returns the string `"hello!"`. What is happening here is that the `yield` keyword is executing the code in the block, which is `puts "world"`.

A method containing a `yield` means that after the method is fully implemented, additional code can be injected into the method at a later date (without modifying the method implementation) by passing in a block. This is one of the mahor use cases for blocks.

#### Example 6:

If we call the method without passing in a block we getr an error.
```ruby
echo_with_yield("hello!") # => LocalJumpError: no block given (yield)
```
In order to allow calling of the method with or without a block the `yield` can be wrapped in a conditional using the `block_given?` method of `Kernel`.
```ruby
def echo_with_yield(str)
  yield if block_given?
  str
end
```

### Passing Execution to the Block

#### Example 7:
```ruby
def say(words)
  yield if block_given?
  puts "> " + words
end

# method invocation
say("hi there") do
  system 'clear'
en
```

In this example the code is executed in a particular order. 
* First the `say` method is called with the argument "hi there" passed to it and the block passed in.
* The string "hi there" is assigned to the `words` variable of the method
* Execution is then *yielded* to the block, which clears the screen
* execution then passes back to the methos which outputs "> hi there" and return nil (since the last line is a call to `puts`)


### Yielding with an Argument

Sometimes the block we pass into the a method requires an argument. 

#### Example 8:
```ruby
[1, 2, 3].each do |number|
  puts number
end
```
The `number` variable here between the `|` and `|` is the *argument to the block*. Within this block of code `number` is a block local variable. This is a special type of local variable where the scope is constrained to the block - it's important to make sure that this variable has a unique name and doesn't conflict with other local variables outside of the block, otherwise you'll encounter *variable shadowing* which can have unintended consequences.

#### Example 9:
```ruby
def increment(number)
  if block_give?
    yield(number + 1)
  else
    number + 1
  end
end

increment(5) do |num|
  puts num
end
```
The method invocation here will output six.
* The `increment` method is called with the argument `5` passed to it and the block passed in.
* The integer `5` is assigned to the `number` variable of the method
* Execution is then *yielded* to the block and the `number + ` *passed* to the block
* The code in the block executes, outputting `6` (`number + 1`)
* The method finishes executing

Calling the block here is almost like calling another method - here we are passing an argument to the block, just as we would for a method call.

Note: unlike a method call, when passing an argument to a block you can pass in the wrong number of arguments and the block wil still execute without raising an `ArgumentError`. The rules around enforcing the number of arguments you can call on a closure in Ruby is called its *arity*. In Ruby, blocks have lenient arity rules, which is why it doesn't complain when you pass in different number of arguments; `Proc` objects and `lambda`s have different arity rules.


### Return value of Yielding to the block

Suppose that rather than have the code in the block *do* something (e.g. output a value) we want to use the *return value* of the block in some way.

#### Example 10:
```ruby
def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end
```

Here the local variable `after` is assigned to the return value of the block. The method then outputs this value interpolated in a string. The output from the method invokation varied depening on the code in the block:
```ruby
compare('hello') { |word| word.upcase } 

# "Before: hello"
# "After: HELLO"

compare('hello') { |word| word.slice(1..2) }

# "Before: hello"
# "After: el"

compare('hello') { |word| "nothing to do with anything" }

# Before: hello
# After: nothing to do with anything
```

### When to use blocks in your own methods

There are many ways that blocks can be useful but the two main use cases are:

1. Defer some implementation code to the method invocation decision
2. Methods that need to perform some 'before' and 'after' actions - sandwich code

#### Example 11:

**Deferring some implementation code to method invocation decision**

There are two roles involved in any method: the **method implementor** and the **method caller**. There are times when the method implementor is not entirely certain how the method wil be called or wants to leave some flexibility in the method call at invocation time.

To allow for this flexibility without a block you could pass in an extra argument as a 'flag' and then use that flag in a  conditional.
```ruby
def compare(str, flag)
  after = case flag
          when :upcase
            str.upcase
          when :capitalize
            str.capitalize
          # etc, we could have a lot of 'when' clauses
          end

  puts "Before: #{str}"
  puts "After: #{after}"
end

compare("hello", :upcase)

# Before: hello
# After: HELLO
```

This isn't nearly as flexible as using a block - which allows the method caller to *refine* the method implementation without actually modifying the method implementation for any other method calls.

Many of the standard library's most useful methods are useful precisely because they are built in a generic way - allowing the method caller to refine the method through a block at invocation time. The `Array#select` method is a good example of this because we can pass in any expression that evaluates to a boolean in the block parameter.

If you encounter a scenario where you're calling a method from multiple places, with one little tweak in each case, it may be a good idea to try implementing the method in a generic way by yielding to a block.

#### Example 12:

**Sandwich Code**

There will be times when you want to wite a generic method that performs some "before" and "after" action. In terms of the method definition it doesn't matter what the *filling* in teh sandwich is - it could be anything; the method implementor doesn't care - they leave the choice of filling up to the method caller (to pass in in a block).

```ruby
def time_it
  time_before = Time.now
  yield                       # execute the implicit block
  time_after= Time.now

  puts "It took #{time_after - time_before} seconds."
end

time_it { sleep(3) }                    # It took 3.003767 seconds.
                                        # => nil

time_it { "hello world" }               # It took 3.0e-06 seconds.
                                        # => nil
```
In this example, it doesn't matter what is passed in in the block, the output of the method will be how long it took to execute.


### Methods with an explicit block parameter

As well as passing a block to a method implicitly using the standard `do ... end` or `{ ... }` syntax, blocks can also be pased to a method *explicitly*.

#### Example 13:
```ruby
def test(&block)
  puts "What's &block? #{block}"
end
```

The `&block` is a special parameter that converts the implicitly passed in block into a `Proc` object. (Note: the `&` is dropped when using the parameter in the method implmentation; also the parameter can be called whatever you wnat as long as it has a leading `&`).
```ruby
test { sleep(1) }

# What's &block? #<Proc:0x007f98e32b83c8@(irb):59>
# => nil
```

Doing this provides additional flexibility. Before all we could do witht eh block was `yield` to it, turning it into a `Proc` by explicitly passing it into the method means *the block can be passed to another method*. Thisis essentially saving the block into a variable - you can invoke the block with the `call` method (e.g. `block.call`) or you can pass it to antoher method.
