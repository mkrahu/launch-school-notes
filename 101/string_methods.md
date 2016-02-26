## String Methods

#### str \* integer --> new_str

Copy: Returns a **new string** containing multiples of the original string as defined by the integer.

```ruby
"Hello! " * 3 # => "Hello! Hello! Hello! "
```

#### str + other_str --> new_str

Concatenation: Returns a **new string** containing the two strings concatenated together.

```ruby
"Hello" + " world" # => "Hello world"
```

#### str << obj --> str

Append: Concatenates `obj` to `str` **mutates the caller**. Note: `concat(obj)` works in the same way.


```ruby
"Hello" << " world" # => "Hello world"
```

#### prepend(other_str) --> str

Prepend: Returns `str` with `other_str` prepended. **Mutates the caller**

```ruby
"world".prepend("Hello ") # => "Hello world"
```

#### str == obj --> true or false
#### str === obj --> true or false
#### eql?(other) --> true or false

Equality: The first two use the same implementation. In these cases if `obj` is not an instance of String but responds to `to_s` then the `===` of the Object class is used using case equality to compare the two strings, otherwise they return similarly to `eql?` comparing length and content - i.e. the two strings are equal if they have the same length and content.

#### str =~ obj

Match: if `obj` is a Regular Exression it is used as a pattern match against `str`. If there is a match then the **zero-based** location at which the match starts is returned. If there is no match then `nil` is returned.

```ruby
"abcdefgh" =~ /f/ ' => 5
```

#### str[index] --> new_str or nil
#### str[start, length] --> new_str or nil
#### str[range] --> new_str or nil
#### str[regexp] --> new_str or nil
#### str[regexp, capture] --> new_str or nil
#### str[match_str] --> new_str or nil

Element Reference: returns either a new string or `nil`. If a new string is returned, the content of that string depends on the argument passed to `[]`

Note: `slice()` has the same functionality, but also has a destructive version `slice!` which as well as returning the specified portion of `str` as `new_str` also deletes the specified portion from `str`.

```ruby
"Lorem ipsum"[2] # => r - single index passed, single character returned from 
                 # that index in the string
"Lorem ipsum"[2, 3] # => rem - index and length passed, characters equal to 
                    # length returned starting at index
"Lorem ipsum"[2..6] # => rem i - range passed, characters between beggining an 
                    # end of renage returned
"Lorem ipsum"[/[aeiou]/] # => o - returns a substring matching the first instance 
                         #of the regular expression
"Lorem ipsum"["sky"] # => nil - returns the matching substring if present or 
                     # returns nil if not present
```

#### str[index]= --> new_str or nil
#### str[start, length]= --> new_str or nil
#### str[range]= --> new_str or nil
#### str[regexp]= --> new_str or nil
#### str[regexp, capture]= --> new_str or nil
#### str[match_str]= --> new_str or nil

Element assignment. replaces some or all of the content of `str` depending on the argument passed to `[]=`

#### capitalize --> new_str
#### capitalize! --> str or nil

The first method returns a new string, the second affects the existing string - **mutates the caller**

```ruby
"karl".capitalize # => "Karl" - returns a new string with the first character in
                  # the string in uppercase
"karl".capitalize! # => "Karl" - amends the existing string
"Karl".capitalize! # => nil - returns nil as the first character is already uppercase
```

#### center(width, padstr=' ') --> new_str
#### ljust(integer, padstr=' ') --> new_str
#### rjust(integer, padstr=' ') --> new_str

Centres, left justifies or right justifies `str` in `width`. If `width` is greater than the length of `str` returns a new string of length `width` and padded with the value of `padstr`

```ruby
"centred".center(21) # => "       centred       "
"centred".center(21, 'x') # => "xxxxxxxcentredxxxxxxx"
"centred".rjust(21) # => "              centred"
```

#### chomp(separator=$/) --> new_str
#### chomp!(separator=$/) --> str or nil

Removes carriage return characters (`\n`, `\r`) unless a different record separator is passed to it as an argument. The non-bang method returns a new string, the bang method modifes `str` in place.

#### chop --> new_str
#### chop! --> str or nil

The non-bang method returns a new string with the final character removed. The bang method removes the final character of `str` in place.

#### chr --> new_str

Returns a new string containing the first character of `str`

#### clear --> str

Makes `str` empty, **mutates the caller**

#### delete([other_str]) --> new_str
#### delete!([other_str]) --> str or nil

The non-bang method returns a new string with the characters matching the argument passed to it removed. The bang method performs the same action on `str` in place.

#### downcase --> new_str
#### downcase! --> str or nil

The non-bang method returns a new string with all uppercase letters replaced with their lowercase counterparts. The bang method performs the smae action on `str` in place.

#### swapcase --> new_str
#### swapcase! --> str or nil

Returns a new string with the case of each character changed to their uppercase or lowercase equivalent as required. The bang method performs the same action on `str` in place.

#### uppcase --> new_str
#### uppcase! --> str or nil

Returns a new string with the case of each character changed to their uppercase equivalent as required. The bang method performs the same action on `str` in place.

#### each_char { |var| block } --> str

Passes each character in `str` to a block to perform an action on the character. Returns the original string.

Note: calling `each_char.to_a` is the same as calling `chars`. This returns an array of all the characters in `str`.

#### empty? --> true or false

Returns a boolean value - true or false. Returns true if `str` has a length of `0`.

```ruby
"hello".empty? # => false
" ".empty? # => false
"".empty? # => true
```
#### start_with?([prefixes]) --> true or false
#### end_with?([suffixes]) --> true or false

Returns a boolean value. Returns true if one of the prefixes/ suffixes passed as an argument matches the ned of the string.

```ruby
"Dr Foster".start_with?("Dr") # => true
"mickey.mouse@disney.com".end_with?(".com", ".co.uk") # => true
"donald.duck@disney.net".end_with(".com", ".co.uk") # => false
```

#### gsub(pattern, replacement) --> new_str
#### gsub!(pattern, replacement) --> str or nil

The non-bang method returns a new string (a copy of `str`) with **all** the occurences of the pattern bassed as the first argument to the method substituted for the second argument. The abng method performs the same action on `str` in place.The
Note: there are several different options for using `gsub` in terms of how the arguments are passed to the method, e.g. a hash can be passed, or a block can be used with the matched string passed in as a parameter.

Note: `sub` and `sub!` perform the same action but only on the **first** occurennce of `pattern`.
Note: if you simply want to replace the entire string you can use `str.replace(other_str)` instead of `gsub`

#### include? other_str --> true or false

Returns a boolean. Returns `true` if `str` contains `other_str`

#### insert(index, other_str)

Returns the string with `other_str` inserted into `str` at the index specified in the first argument. **Mutates the caller**

#### length --> integer
#### size --> integer

Returns the character length of `str` as an integer

#### strip --> new_str
#### strip! --> str or nil
#### lstrip --> new_str
#### lstrip! --> str or nil
#### rstrip --> new_str
#### rstrip! --> str or nil

The non-bang methods return anew string with the contents of the original string but stripped of all, left-hand or right-hand whitespace respectively. The bang methods perform the same action to `str` in place.

#### reverse --> new_str
#### reverse! --> new_str

Returns a new string with the characters fro `str` in reverse order. The bang method performs the same action on `str` in place.

#### split(pattern=$;,[limit]) --> anArray

Divides `str` into substrings based on a delimiter, returning an array of these substrings. The default (if no argument is passed) is to split on whitespace.


### Methods from the Comparable Module

The String class has some methods available to it from the comparable module

#### str <=> other_str --> -1, 0, 1, nil

Comparison: Returns `-1`, `0`, `1`, `nil` depending on whether `str` is longer or shorter than `other_str`. `nil` is returned if the two values are not comparable. Note: `<=>` is case sensitive. `casecmp(other_str)` is a case insensitive version.

```ruby
"Green" <=> "Yellow" # => -1
"Green" <=> "Black" # => 0
"Green" <=> "Grey" # => 1
"Green" <=> 123 # => nil
```

<=> is the basis for other methods included from the comparable module: `<`, `<=`, `>`, `>=`, `between?`
The String method `==` does not use Comparable `==`

```ruby
"Green" < "Black" # => false
"Green" <= "Black" # => true
"Green" > "Black" # => false
"Green" >= "Black" # => true
"Green".between?("Blue", "Orange") => true
```

