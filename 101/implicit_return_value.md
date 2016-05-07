# Implicit Return Value

1. In Ruby the return value of a method or block is implicit
2. You do not have to use the return keyword to explicitly return a value
3. The implicitly returned value is the value of last executed line in the method or block
4. If you explicitly return a value this stops execution and returns the explicitly returned value

#### Example 1: Implicitly returned value
```ruby
def implicit_return
  "Implicit return value"
end

p implicit_return # => "Implicit return value" this value is returned from the method even though we did not explicitly return it
```
#### Example 2: Last executed line is returned
```ruby
def last_line
  "First Line"
  "Second Line"
  "Last Line"
end

p last_line # => "Last Line" - this is the last line executed by the method and so is returned

def explicit_return
  "First Line"
  return "Second Line"
  "Last Line"
end

p explicit_return # => "Second Line" - returned even though it is not the last line because it is returned explicitly

def stop_execution(string)
  return string = "Returned String"
  string.replace "New String"
end

a = "Some string"

p stop_execution(a) # => "Returned String" - this is explicitly returned

p a # => "Some string" - a is unchanged as return stops method execution so string.replace is never run
```