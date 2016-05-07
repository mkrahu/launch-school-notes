# Variables as Pointers

1. Variables are pointers to physical space in memory - they act as labels for a physical memory address
2. When a variable is assigned in Ruby it acts as a pointer to a specific memory space.
We are re-using the label for a differert address
3. The = operator is used for variable assignment
4. When a variable is reassigned it points to a different memory space
5. We can affect the objects in the memory space by performing a destructive action on the variable.
When this happens the variable is still pointing to the same memory space but we are mutating the caller -
changing the actual address space in memory
6. When passing arguments to a method we are essentially assigning a variable to another variable
7. Different memory spaces can hold the same value but are still different places in memory
8. For some object classes - Fixnum, nil, true, false - you cannot mutate the caller, you can only reassign

#### Example 1: Variable assignment/ reassignment
```ruby
a = "some place in memory" # this points (a) to a specific memory space

b = a # this points (b) to the same memory space as (a)

puts a # => "some place in memory"

puts b # => "some place in memory"

a = "some other place in memory" # this points (a) to a different memory space

puts a # => "some other place in memory" (a) was reassigned to a different memory space

puts b # => "some place in memory" (b) is still pointing to the original memory space. It was not reassigned 
```

#### Example 2: Mutating the caller
```ruby
a = "some place in memory"

b = a

puts a # => "some place in memory"

puts b # => "some place in memory"

b.replace "still the same place in memory" # mutates the caller - i.e. changes what is in the memory space

puts a # => "still the same place in memory"

puts b # => "still the same place in memory"

# both (a) and (b) are still pointing to the same memory space as before but what is in that space has changed
```

#### Example 3: passing a variable as a method argument
This is the same as the previous example but extracted to a method
```ruby
def some_method(b)
  b = "some other place in memory"
end

def some_other_method(b)
  b.replace "still the same place in memory"
end

a = "some place in memory"

some_method(a) # When calling the method the method parameter (b) is assigned to the method call argument (a)

puts a # => "some place in memory" here (b) was reassigned to a different memory space. The caller was not mutated.

some_other_method(a) # again we are assigning (b) to (a), effectively doing this: b = a

puts a # => "still the same place in memory" here the caller was mutated - what was in the memory space was changed.

# It is important to note that even though some_method() does not mutate the caller (a) 
# it still RETURNS the value of the reassigned (b)
```

#### Example 4: Different memory spaces holding the same value
```ruby
a = "some place in memory"

b = "some place in memory"

# even though the value of (a) and (b) are the smae they point to different spaces in memory
# the object ids of the variables would be different

a.object_id # e.g. 8159000
b.object_id # e.g. 8299900

b.replace "still the same memory space b was pointed to"

puts a # => "some place in memory" - mutating (b) does not affect (a)

puts b # => "still the same memory space b was pointed to" - what is in the memory space (b) is pointed to has changed

# the object ids would be the same as they were before
# each variable is still pointed to the same memory space that it was previously

a.object_id # e.g. 8159000
b.object_id # e.g. 8299900
```
