# False vs Nil

1. All programming lanuages need a way to express 'nothing'. In Ruby this is done using 'nil'
2. nil is an object of the NilClass class
3. nil is evaluated as a false condition in a conditional statement
4. False is a boolean value. It is an object of the FalseClass class
5. Every object and every expression in Ruby evaluates to either true or false
6. False is evaluated as false in a conditional statement
7. Despite both evaluating as false in conditonals false and nil are not equivalent
8. By default nil is used to hold empty places in an array

#### Example 1: nil evaluated as false in a conditional

```ruby
if nil
  puts "some string" # nothing is output as nil evaluates to false so the condition is not run
end
```
#### Example 2: false evaluated in a conditional
```ruby
a = false

if a
  puts "some other string" # nothing is output as a evaluates to false so the condition is not run
end
```
#### Example 3: nil and false both evalute to false using true&
```ruby
p true&nil # => false
p true&false # => false
```
#### Example 3: nil and false are not equivalent
```ruby
p nil == false # => false. This outputs false becuase false and nil are not equivalent
p nil != false # => true. Test the opposite condition outputs true, again showing they are not equivalent
```
#### Example 4: nil as a placeholder
```ruby
a = Array.new(3)

p a # => [nil, nil, nil] - the array ahs three indices but what is in them was not specified at initialisation so
    # nil is used as a placeholder by default
```
