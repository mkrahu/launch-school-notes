## Array Methods

#### array & other_array --> new_array

Set Intersection: returns a new array with elements common to both arrays. Order preserved from original array.Set
```ruby
[1, 1, 3, 5] & [1, 2, 3] # => [1, 3]
```
#### array \* integer --> new_array
#### array \* string --> new_string

If an integer is passed as an argument returns a new array built by concatenating copies of the original array.
```ruby
[1, 2, 3] * 3 # => [1, 2, 3, 1, 2, 3, 1, 2, 3]
```
If a string is passed as an argument then acts the same as `array.join(string)` - returns a string.
```ruby
[1, 2, 3] * ", " # => "1, 2, 3"
```

#### array + other_array --> new_array

Concatenation - returns a new array built containing all the elements of the two contributing arrays.
```ruby
[1, 2, 3] + [4, 5] # => [1, 2, 3, 4, 5]
```

#### array - other_array --> new_array

Array Difference - returns a new array that is a copy of the orignal array removing any elements that also appear in `other_array`. Order is preserved from the original array.
```ruby
[1, 1, 2, 2, 3, 3, 4, 5] - [1, 2, 4] # => [3, 3, 5]
```

#### array << object --> array

Append - pushes the given object to the end of the array - **mutates the caller**. returns the original array so appends can be chained.
```ruby
[1, 2] << 3 << 4 # => [1, 2, 3, 4]
```

#### array <=> other_array --> -1, 0, 1, nil

Comparison - returns an integer if array is less than, equal to or greater than other array. Nil is returned if `other_array` is not an array or if the comparison of the two objects returned nil. Arrays are compared in an element-wise manner - the first element of `array` is compared to the first element of `other_array`, etc.
```ruby
["a", "a", "c"] <=> ["a", "b", "c"] # => -1

[1, 2, 3, 4] <=> [1, 2] # => +1

[1, 2] <=> [1, :two] # => nil
```

#### array == other_array --> boolean

Equality - returns true or false if the arrays contain the same number of elements and if each element is equal.
```ruby
[1, 2, 3] == [1, 2, 3] # => true

["1", 2, 3] == [1, 2, 3] # => false
```

#### array[] --> object, new array or nil (depending on argument passed)

* If an array index is passed then the object at that index is returned
* If an index and length is passed a new array is returned containing elements starting at the given index with the number of elements in the new array equal to the given length
* If a range is passed then a new array is returned in the same way as with index and length parameters with the first integer in that range taken as the starting index and the length of the range as the number of objects to be returned
```ruby
arr = ["a", "b", "c", "d", "e"]

a[2] # => "c"

a[1, 2] # => ["b", "c"]

a[1..3] # => ["b", "c", "d"]
```
Note: this has the same funtionality as `slice`. If you need to affect the array in place then the bang method of `slice` can be used: `slice!`.
Note: `array.at(index)` has the same functionality as `array[index]`

#### array[]= object --> object

Element assignment - if an index is given then assigns `object` to that index in the array and returns `object`. **Mutates the caller**. Start and length or range can also be given and antoher array passed. 
```ruby
a = Array.new

a[4] = "4" # => [nil, nil, nil, nil, "4"]
```

### any? {|object| block } --> boolean

Returns true or false based on the logic in the block
```ruby
[1, 2, 3].any? {|number| number > 4 } # => false
```

#### clear --> array

Removes all elements from the array and returns an empty array. **Mutates the caller**
```ruby
a = [1, 2, 3]
a.clear # => []
a # => []
```

#### collect { |item| block } --> new_array

Invokes the given block for each element in the array. Returns a new array containing the values returned by the block.
```ruby
a = [1, 2, 3 ,4]
a.collect { |number| number + 1 } # [2, 3, 4, 5]
```

Note: `collect!` works in the same way but on the array in place - **Mutates the caller**.
Note: `map` and `map!` are equivalent to `collect` and `collect!`.

#### keep_if { |item| block } --> array

Deletes every item of self for which the logic in the block evaluates to false.Deletes
```ruby
a = [1, 2, 3, 4, 5, 6]
a.keep_if { |number| number > 3 } # => [4, 5, 6]
```

#### compact --> new_array
#### compact! --> new_array

The non-bang method returns a new array with all `nil` elements removed. The bang method does the same but on `array` in place.
```ruby
[1, nil, 2, nil, nil].compact # => [1, 2]
```

#### concat(other_array)

Appends the elements of `other_array` to `array`
```ruby
[1, 2, 3].concat([4, 5]) # => [1, 2, 3, 4, 5]
```

#### count --> integer

Returns an integer equal to the number of elements in array. Can also be passed an object or block as an argument (if a block is passed then returns the number of array elements for whicht heblock returns true).Returns
```ruby
array = [1, 2, 3, 4, 4]

array.count # => 5

array.count(4) # => 2

array { |number| number > 2 } # => 3
```

#### delete(object) --> item or nil

Deletes all items from the array that are equal to object. Returns object (or nil if no items are equal to object). **Mutates the caller**
```ruby
a = [1, 2, 3, 4]

a.delete(1) # => 1
a # => [2, 3, 4]
```

#### delete_at(index) --> object or nil

Deletes the object at the given index. Returns the deleted object. **Mutates the caller**.
```ruby
a = [1, 2, 3, 4]

a.delete_at(1) # => 2
a # => [1, 3, 4]
```

#### delete_if { |item| block } --> array

Deletes every element in the array for which the block evaluates to `true`. **Mutates the caller**
```ruby
[1, 2, 3, 4].delete_if { |number| number < 3 } # => [3, 4]
```

#### drop(n) --> new_array

Returns a new array with the first `n` elements of the array removed

```ruby
[1, 2, 3, 4, 5].drop(2) # => [3, 4, 5]
```

#### take(n) --> new_array

Returns a new array containing the first `n` elements of `array`

```ruby
[1, 2, 3, 4, 5].take(2) # => [1, 2]
```

#### drop_while { |array| block } --> new_array

Returns a new array with the elements up to the frist element for which the block returns false removed.
```ruby
[1, 2, 3, 4, 5].drop_while { |number| number < 3 } # => [3, 4, 5]
```

#### each { |item| block } --> array

Calls the block once to each element in the array.
```ruby
[1, 2, 3].each { |number| puts number } # => "1" "2" "3"
```

#### each_index { |index| block } 

Same as `each` but passes the index of the element to the block instead of the element.

#### empty? --> true or false

returns true if the array contains no elements

eql?(other) --> true or false

Returns true if both objects are  an array with the same content.

#### fill(object) -->

Fills `array` with `object`. Can also be passed a atart and length or range, or passd a block instead of `object` (in which case the return from teh clock is used to fill the array)
```ruby
[1, 2, 3].fill(6) # => [6, 6 ,6]
```

#### find_index(object) --> integer or nil

Returns the index at which the first instance of `object` exists int he array. Returns nil if object is not in the array. Can be passed a block in which case returns the index of the first object for which block returns `true`.

Note: `index(object)` has the same functionality.

#### first --> object or nil
#### first(n) --> new_array

Returns the first element or first `n` elements of the array. If array is empty returns `nil`.

#### flatten --> new_array
#### flatten! --> new_array

The non-bang method returns a new array that is a one-dimensional flattening of the original array. The ang method does the same thing on array in place (mutates the caller).
```ruby
[[1, 2], [3, 4]].flatten # => [1, 2, 3, 4]
```

Note: an optional 'level' parameter can be passed which determines the number of levels to be flattened (from out to in).

#### include?(object) --> true or false

Returns true if `object` is present in `array` otherwise returns `false`
```ruby
[1, 2, 3].include?(2) # => true
```

#### insert(index, object) --> array

Inserts the given value(s) *before* the element with the given index. **Mutates the caller**.
```ruby
[1, 2, 3, 4].insert(1, 2) # => [1, 2, 2, 3, 4]
```

#### inspect --> string
#### to_s --> string

Creates a string representation of `array`
```ruby
[1, 2, 3, 4].to_s # => "[1, 2, 3, 4]"
```

#### join(separator=$) --> string

Returns a string created by converting each element of the arry to a string sparated by the give separator.
```ruby
[1, 2, 3].join(", ") # => "1, 2, 3"
```

#### last --> object or nil
#### last(n) --> new_array

Returns the last element of self. If the array is empty returns nil. 
Returns the last `n` elements of self as a new array.
```ruby
a = ['a', 'b', 'c', 'd', 'e']
a.last # => 'e'
a.last(2) => ['d', 'e']
```

#### length --> integer

Returns the integer value equivalent to the number of elements in self. May be `0`.
```ruby
[1, 2, 3, 4, 5].length # => 5
```

#### pop --> object or nil
#### pop(n) --> new_array

Removes the last element of self and returns it. Returns nil if the array is empty. **Mutates the caller**
Removes the last `n` elements of self and returns them as a new array. **Mutates the caller**
```ruby
a = [1, 2, 3, 4, 5]
a.pop # => 5
a.pop(2) # => [3, 4]
```


#### product(other_array, ...) --> new_array
