# call_by_sharing.rb

# 1. Method arguments are scoped at the method level and are not avaialble outside of the method
# 2. The exception to (1) is when an action is performed on the argument that 'mutates the caller'
# 3. When an operation within the method mutates the caller, it will affect the original object
# 4. The only way to know which methods mutate the caller is by memorising them!
# 5. Ruby is neither pass-by-value or pass-by-reference - it is both!
# This is sometimes known as pass-by-reference-of-the-value or call-by-sharing
# 6. When writing our own methods we can put an exclamation-mark/ bang (!) in the method name
# This can be used to indicate that the method is 'destructive' (i.e. mutates the caller)

# Example 1: Argument scope limited to method. Variable (a) cannot be reassigned from within the method

def some_method(number)
  number = 7
end

a = 5
some_method(a)
puts a # This outputs '5' because calling the method on (a) did not reassign (a) outside of the method

# Example 2: A method mutating the caller

def mutate(array)
  array.pop
end

a = [1, 2, 3]

p a # This will output [1, 2, 3]

mutate(a) # This will return (3) from the method

p a # This will output [1, 2]

# Even though (a) is outside of the scope of the mutate method it is still affected becuae the pop method
# mutates the caller

# Example 3: a method not mutating the caller but still returning the same value

def no_mutate(array)
  array.last
end

a = [1, 2, 3]

p a # This will output [1, 2, 3]

no_mutate(a) # As with the mutate method this will return (3)

p a # This will still output [1, 2, 3] because the last method has not mutated the caller

# Example 4: Using a bang! to indicate a method is destructive


def destructive_method!(string) # Using a bang in the method name indicates that the method is destructive
  string.replace "Goodbye"
end

greeting = "Hello"

puts greeting # This will output 'Hello'

destructive_method!(greeting) # Calling the destructive_method! on greeting will mutate greeting

puts greeting # This will output 'Goodbye'
