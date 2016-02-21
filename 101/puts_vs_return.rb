# puts_vs_return.rb

# 1. In Ruby, every method returns the evaluated result of the last line that is executed unless an explicit return comes before it
# 2. puts outputs the value of an object as a string to stdout

# Example 1: printing value of variable and return value of method

def some_method(string)
  string = "another string"
end

a = "some string"

puts a # => "some string" - this outputs the value of (a)
puts some_method(a) # => "another string" - this calls some_method() on (a) and outputs its return value
puts a # => "some string" - the method did not change the value of (a)

# Example 2: mutating the caller and returning a value

def mutate(array)
  array.pop
end

a = [1, 2, 3]

p a # => [1, 2, 3] - this is the value of (a)
p mutate(a) # => 3 - this is the return value of mutate() when called on (a)
p a # => [1, 2] - this is the value of (a) after mutate() has been called on it

# Example 3: Return value is last line executed

def conditional(value)
  if value > 5
    "Greater than five"
  else
    "Not greater than five"
  end
end

p conditional(9) # => "Greater than five" - this is the return value of conditional() since it is the last line executed

p conditional(4) # => "Not greater than five" - this is the return value of conditional() in this instance

# Example 4: Explicit return

def replace_string(string)
  return string = "another string"
  string.replace "a third string"
end

s = "some string"

p s # => "some string" - this is the value of (s)
p replace_string(s) # => "another string" - this is the return value of replace_string() since we used an explicit return
p s # => "some string" - the value of (s) has not changed since string.replace was not executed - return stopped method execution
