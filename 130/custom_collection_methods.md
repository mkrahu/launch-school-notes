# Custom Collection Methods

It is possible to build custom collection methods which take a block by wrapping the `yield` in a loop so that the block is yielded to multiple times by the method, each iteration passing in a different value or object to the block as an argument. Writing a generic iterating method allows method callers to add additional implementation details at method invocation time by passing in a block.


#### Example 1: Custom 'times' method
```ruby

# method implementation
def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end

  number                   
end

# method invocation
times(5) do |num|
  puts num
end

# Output:
# 0
# 1
# 2
# 3
# 4
# => 5
```

* `times` method is called with an argument of `5` and a block passed to it
* The method assigns the local variable `number` to the value `5` and then the variable `counter` to `0`
* A `while` loop iterates while `counter` is less than `number`
    * In each loop the method yields the current value of `counter` to the block
    * The block outputs the value that has been yielded to it
    * `counter` is incremented by `1`
* After the loop has completed (`counter` is no longer less than `number`) `number` is then returned by the method

#### Example 2: Custom 'each' method
```ruby
def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter]) # yield to the block, passing in the current element to the block
    counter += 1
  end

  array # returns the `array` parameter, similar in spirit to how `Array#each` returns the caller
end

each([1, 2, 3, 4, 5]) do |num|
  puts num
end

# 1
# 2
# 3
# 4
# 5
# => [1, 2, 3, 4, 5]
```

This is fairly similar to the times method except an object from the parameter is passed to the block instead of an incremented counter value

* `each` method is called with an argument of `[1, 2, 3, 4, 5]` (an array) and a block passed to it
* The method assigns the local variable `array` to the array and then the variable `counter` to `0`
* A `while` loop iterates while `counter` is less than the number of items in the array (`array.size`)
    * In each loop the method yields an object from array in turn by using the current value of `counter` as the index
    * The block outputs the object that has been yielded to it
    * `counter` is incremented by `1`
* After the loop has completed (`counter` is no longer less than `array.size`) `array` is then returned by the method


#### Example 3: Custom 'select' method
```ruby
def select(array)
  counter = 0
  new_array = []
  
  while counter < array.size
    new_array << array[counter] if yield(array[counter])
    counter += 1
  end

  new_array
end

p select([1, 2, 3, 4, 5]) { |num| num.odd? } 

# => [1, 3, 5]

p select([1, 2, 3, 4, 5]) { |num| num.even? } 

# => [2, 4]
```

This is fairly similar to the each method except a conditional element is added and a new array is returned instead of the orignial array

* `select` method is called with an argument of `[1, 2, 3, 4, 5]` (an array) and a block passed to it
* The method assigns the local variable `array` to the array and then the variable `counter` to `0`. It also initializes an empty array assigned to the variable `new_array`
* A `while` loop iterates while `counter` is less than the number of items in the array (`array.size`)
    * In each loop the method yields an object from array in turn by using the current value of `counter` as the index
    * The conditional logic pushes that object to the `new_array` (using the shovel method `<<` of array) only if the the block returns `true` based on the object yielded to it being evaluated by the logic in the block
    * `counter` is incremented by `1`
* After the loop has completed (`counter` is no longer less than `array.size`) `new_array` is then returned by the method


#### Example 4: Custom 'reduce' method
```ruby
def reduce(array, default_accumulator=0)
  counter = 0
  accumulator = default_accumulator
  
  while counter < array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end

  accumulator
end

p reduce([1, 2, 3, 4, 5]) { |acc, num| acc + num }                    # => 15
p reduce([1, 2, 3, 4, 5], 10) { |acc, num| acc + num }                # => 25
```

This is fairly similar to the each method except variable assignment is done within the loop, two values are passed to the block and a new array is returned instead of the orignial array

* `reduce` method is called with an argument of `[1, 2, 3, 4, 5]` (an array) and a block passed to it (in the second method call a second argument of `10` is passed to the method)
* The method assigns the local variable `array` to the array and if a second argument has been passed this is set to the variable `default_accumulator` - if only one argument is passed this variable is set to the default value of `0`
* The variable `counter` to `0`. 
* It also sets the value of `accumulator` to tat of `default_accumulator` (either a passed in value or `0`)
* A `while` loop iterates while `counter` is less than the number of items in the array (`array.size`)
    * In each loop the method yields an object from array in turn by using the current value of `counter` as the index; in additiona the current value of `accumulator` is passed to the block
    * The return value of the `yield` (based on the logic in the block) is then set as a value of `accumulator`
    * `counter` is incremented by `1`
* After the loop has completed (`counter` is no longer less than `array.size`) `accumulator` is then returned by the method
