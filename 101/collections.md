# Collections

1. Collections are a way to store lists of data

2. String, Hash, Array, Range, Set, Enumerable and Enumerator are all collection objects in Ruby

3. A Range is a collection of numbers in order
..1. Range can be iterated like other collections but it is not a container for arbitrary elements
..2. Range is useful for combining with arrays to slice an array

4. An Array is a data object which stores an ordered list of values
..1. Square brackets denote the beggining and end of an Array
..2. Arrays are heterogeneous - each spot in an array can point to any type of data object 
(i.e you can have different data types in the same array)
..3. An array object can be referenced using its index (which is an integer). Indexes run in order beginning at 0
..4. Ruby Arrays are dynamic so you don't need to pre-allocate space in them for objects
..5. Ruby returns nil rather than an exception if you attempt to reference a non-existent index
..6. There is a syntax short-cut for array creation - %notation

5. A Hash is a collection which stores list of key/ value pairs (effectively an associative array)
..1. Curly brackets denote the beginning and end of a hash
..2. Hashes are heterogeneous and both the keys and values can be of any data type
..3. it is popular to use symbols as keys beacuse they are descriptive like strings but fast like integers
..4. A Hash object can be referenced using its key
..5. a non-existent key will return nil

6. A set is an unordered collection of unique elements
..1. A require statement is needed to use the Set class
..2. Set uses hash as storage but can be initialised using an array
..3. A set will not add elements that it already includes

7. Enumerable is a module that can be used by various collection Object Classes in Ruby
..1. The class must include enumerable
..2. A class must define an each method in order to use enumerable
..3. The each method should yield each item in the collection t a block
..4. Enumerable provides several functions for searching/ filtering collections, e.g. select, detect, reject, collect.
grep is also useful for filtering  in a block
..5. Enumerable can also be used for sorting

8. Enumerator is an object that is returned by an Enumerable method if no block is passed to it
..1. Enumerator objects contain the information about how to iterate through a collection
..2. The fact that an enumerator is returned by an enumerable method is what allows method chaining in Ruby

9. You can loop through collections using for and while loops
10. Collections also have specific methods for looping
11. Collections can be nested. Different collection types can be nested in each other (e.g. an array of hashes)
12. Multi-dimensional arrays are often referred to as matrices
13. Objects in nested collections can be referenced using a combination of indices and/or keys

#### Example 1: Example of a range
```ruby
numbers = 1..5 # This is a collection of all the integers from 1 to 5 (i.e. including 5)

numbers.each { |number| puts number } # This will output each number from 1 to 5

numbers = 1...5 # This is a collection of all the integers from 1 up to 5 (i.e. not including 5)

numbers.each { |number| puts number } # This will output each number from 1 to 4
```
#### Example 2: initialising an array
```ruby
my_array = [1, 2, 3, 4]
```
####Example 3: a heterogeneous array
```ruby
my_het_array = [1, "two", 3, "four"]
```
#### Example 3: referencing an array object
```ruby
my_het_array[1] # => "two"
```
#### Example 4: Ruby returns nil for non-existent indices
```ruby
my_array[10] # => nil
```
#### Example 5: Array shortcut notation
```ruby
my_shortcut_array = %w{1 2 3 4 5} # => [1, 2, 3, 4, 5]
```
#### Example 6: initialising a hash
```ruby
my_hash = {1 => 'One', 2 => 'Two', 3 => 'Three', 4 => 'Four'}
```
#### Example 7: a heterogeneous hash
```ruby
my_het_hash = {1 => 'One', 'Two' => 2, [3] => [3]}
```
#### Example 8: initialising a hash with symbols as keys (no hash rocket needed)
```ruby
my_symbol_hash = {a: 'one', b: 'two', c: 'three'}

my_hash[1] # => 'One'
```
#### Example 9: a non-existent key returns nil
```ruby
my_hash['One'] # => nil
```
#### Example 10: initialising a set
```ruby
my_set = Set.new([1, 2, 3]) # => {1, 2, 3}
```
#### Example 11: A set will not add elements it already includes
```ruby
my_set.add(2) # => {1, 2, 3}
```
#### Example 12: iterating a collection with a for loop
```ruby
my_loop_array = [1, 2, 3, 4, 5]

for i in 0..(my_loop_array.length-1)
  puts my_loop_array[i]
end
```
#### Example 13: using each to iterate
```ruby
my_loop_array.each { |i| puts i }
```
#### Example 14: a nested hash
```ruby
my_outer_hash = { 
  'inner hash 1' => {1 => 'a', 2 => 'b', 3 =>'c'},
  'inner hash 2' => {4 => 'd', 5 => 'e', 6 => 'f'}
}
```
#### Example 15: reerencing an object from a nested collection
```ruby
my_outer_hash['inner hash 1'][2] # => 'b'
```