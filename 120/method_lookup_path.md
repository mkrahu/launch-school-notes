# Method Lookup Path

The Method Lookup Path informs Ruby where to look for a method when
that mehod is called. The `ancestors` method of `Module` can be called on
any class to see its method lookup chain.

#### Example 1

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
