# Method Lookup Path

The Method Lookup Path informs Ruby where to look for a method when
that method is called. The `ancestors` method of `Module` can be called on
any class to see its method lookup chain.

#### Example 1:
```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class Human
  include Speak
end

puts GoodDog.ancestors # =>
# GoodDog
# Speak
# Object
# Kernel
# BasicObject

puts Human.ancestors # =>
# Human
# Speak
# Object
# Kernel
# BasicObject
```

If a method is called on an object (or class) and cannot be found in the lookup chain then Ruby will throw an error.

If more than one module is inluded in a lcass, the order in which they are included affects their position in the lookup chain.

#### Example 2:
```ruby
module Speak
end

module Walk
end

class Human
  include Speak
end

puts Human.ancestors # =>
# Human
# Walk
# Speak
# Object
# Kernel
# BasicObject
```

This example shows that modules appear in the method lookup path in the reverse order to which they are included in a class.