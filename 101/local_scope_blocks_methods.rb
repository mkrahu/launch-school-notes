# local_scope_blocks_methods.rb

# Notes about Ruby local variable scope within blocks and methods

# GENERAL
# 1. A variable's scope determines where in the program it is available for use
# 2. A local variable's scope is determined by where in the program it is initialised or created
# 3. The two major areas where we encounter local variable scoping rules are blocks and methods
#
# BLOCKS
# 1. In Ruby, a local variable's scope is defined by a block
# 2. Blocks are defned by do/ end or {} (note: not all do/ end or {} pairs imply a block onlyif they immediately follow a method invocation)
# 3. The outermost scope of the program (outside any blocks or method definitions) is the top level scope
# 4. Blocks can be nested
# 5. Scope can bleed through blocks from out to in
#   - a variable initialised outside a block IS available inside the block
#   - a variable initialised inside a block IS NOT avaialble outside the block
# 6. Accessible variables can be reassigned from within a block
# 7. Peer scopes do not conflict
# 8. If a block takes a parameter, variable shadowing prevents access to variables of the same name outside the block
# 
# METHODS
# 1. A Method is the Ruby name for a programming procedure. Before using a method it must be defined
# 2. Methods create their own scope that's entirely outside the execution flow of the program
# 3. Methods cannot directly access variables initialised outside of the method
# 4. The execution flow cannot access variables initialised inside the method
# 5. Methods can access data that are explicitly passed into the method using arguments/ parameters
# 6. Methods can take default parameters
# 7. When blocks are used inside a method, the same block scope rules apply

# Example 1: Blocks are defined by do/ end or {} but only if they follow a method invocation

loop do # this follows a method invocation and so is a block therefore (a) cannot be accessed outside of the block
  a = 5
end

arr = [1, 2, 3]

for i in arr do # although this used do/ end it does not follow a method invocation and so is not a block
  b = 5					# it is just a part of the execution flow of the program therefore b can be accessed outside of it
end

# Example 2: Nested Block
# Here the third level can access variables initialised in the first, second and third levels (a, b, c)
# The second level can access variables initialised in the first and second levels (a, b)
# The first level (outermost) level can only access variables initialised in the first level (a)

a = 1 # first level

loop do # second level
  b = 2
  
  loop do # third level
    c = 3
    break
  end
  
  break
end

# Example 3: variable reassignment in a block

a = 1

loop do
  a = 2
  break
end

puts a # this would output 2 since the variable (a) has been reassigned to the value 2 within the block

# Example 4: Here the same name can be used to initialise variables in two peer blocks.
# The block cannot access each others' variables

loop do
  a = 2
end

loop do
  a = 4 # the first (a) is not accessible here
end

# Neither (a) is accessible here

# Example 5: Here variable shadowing prevents access to the first (a) by the block
# Note - this still is not good practise as it is not clear what the intention is

a = 5

[1, 2, 3].each do |a|
  puts a
end

# Example 6: Method
# Here the execution flow cannot access variables initialised in the method
# Also the method cannot (directly) access variables initialised in the execution flow

def some_method # (a) cannot be accessed here
  b = 1	
end

# (b) cannot be accessed here
a = 2 

# Example 7: Here the method can access (a) because it is passed into the method

def some_method(a)
  puts a
end

a = 5
some_method(a)

# Note the variable (a) in the method is completely separate from the variable (a) in the execution flow
# This would give the same result:

def some_method(b)
  puts b
end

a = 5
some_method(a)

# Example 8: Here variables initialed inside the blcok cannot be accessed outside of it

def some_method
  a = 1
  loop do # (a) can be acessed here
    b = 2 
  end
  # (b) cannot be accessed here
end

# Example 9: Method parameters and arguments

def some_method(parameter_1, parameter_2) # These are the parameters of the method definition
  puts "#{paremeter_1} #{parameter_2}"
end

some_method('Argument 1', 'Argument 2') # These are the arguments of the method invocation

# Example 10: If there is a default parameter set in the method defintition and no argument is passed for that parameter the default is used

def greeting(a='Hello')
  puts a
end

greeting # this would output the string 'Hello'
greeting('Goodbye') # This would output the string 'Goodbye'
