# Character Classes

  * [Overview](#overview)
  * [Set of Characters](#set-of-characters)
  * [Range of Characters](#range-of-characters)
  * [Negated Classes](#negated-classes)
  * [Character Class Shortcuts](#character-class-shortcuts)
    * [Any Character](#any-character)
    * [Whitespace](#whitespace)
    * [Digits and Hex Digits](#digits-and-hex-digits)
    * [Word Characters](#word-characters)

<a name='overview'></a>
## Overview

  * Character classes are patterns that let you specify a 'set' of characters that you want to match
  * Character class patterns are expressed as a list of characters between square brackets

<a name='set-of-characters'></a>
## Set of Characters

  * Character class patterns allow to define sets of characters, with each 'member' of that set being matched individually

Example:

```ruby
'cast'.match(/aeiou/) # does not match as this is searching for the 'aeiou' all following each other in that order
'cast'.match(/[aeiou]/) # matches, as this is searching for any occurence of any of the letters in the 'set'
```

  * Single character classes, e.g. `/[a]/` are possible, and are sometimes used, though it is more common to see classes with two or more characters
  * Charcter classes come in handy when you need to match an upper or lowercase character but can't use to the `i` flag

Example:

```ruby
'Cast'.match(/[Cc]ast/) # matches
'cast'.match(/[Cc]ast/) # matches
'CAST'.match(/[Cc]ast/) # does not match
```

  * When writing character classes, it is good practice to group characters by type:
    * Digits
    * Uppercase letters
    * Lowercase letters
    * Whitespace characters
    * Non-alphanumeric characters

  * One thing to note, is that inside a character class most special characters act the same as normal characters and do not need to be escaped, with the exception of the following:
    * `^`
    * `\`
    * `-`
    * `[`
    * `]`

<a name='range-of-characters'></a>
## Range of Characters

  * Sometimes character classes might need to represented a natural sequence of characters; e.g. letters a-z.
  * Ranges of characters can be abbreviated inside of character classes by specifying the starting character, followed by a hyphen, and then the ending character of the sequence.
  * Ranges can also be combined for more flexibility

Examples:

```JavaScript
/[a-z]/ // matches any lowercase alphabetic character
/[j-p]/ // matches any lowercase alphabetic character between j and p, inclusive
/[0-9]/ // matches any decimal digit
/[a-z0-9]/ // matches any lowercase alphabetic character or decimal digit
```

  * While it's possible to construct ranges that cover non-alphanumeric characters, this is best avoided as it's not obvious what such a range would include

Example:

```javascript
/[A-Za-z]/ // covers all lowercase and uppercase alphabetic characters
/[A-z]/ // covers all lowercase and uppercase alphabetic characters, but also non-alphanumeric characters between Z and a
```

<a name='negated-classes'></a>
## Negated Classes

  * Another useful feature of character classes is negation; negated classes are used to identify characters to *exclude* from the pattern
  * Negations are specified like ordinary character classes, except that they are prepended by a caret `^`
  * The negated character class matches any character *other than* the characters identified by the negated character class pattern

Examples:

```javascript
/[^a]/ // matches any character except lowercase a
/[^a-z]/ // matches any character except lowercase alphanumerics
/[^0-9aeiou]/ // matches any character except numerics digits or lowercase alphanumerics
```

<a name='character-class-shortcuts'></a>
## Character Class Shortcuts

  * Some character classes are used so often that many regex engines build in shortcuts for them

<a name='any-character'></a>
### Any Character

  * This represents **any**, including alphanumerics, punctuation, whitespace, etc
  * Any character is represented by a `.`
  * By default, this shortcut does not match across newline characters, but you can use the multi-line flag `m` to change this behaviour
  * To use the `.` character class shortcut, you use the meta-character for that shortcut rather than the `[]` syntax normally associated with character classes. Inside the brackets it would simply represent a period/ full-stop

Example:

```javascript
/./ // matches any character
/./m // matches any character over mutliple lines (across newline characters)
```

<a name='whitespace'></a>
### Whitespace

  * `\s` matches any whitespace characters and `\S` matches any non-whitespace characters
  * By definition, the whitespace characters are space `' '`, tab `'\t'`, vertical tab `'\v'`, carriage return `'\r'`, line feed `'\n'` and form feed `'\f'`

Examples:

```javascript
/\s/ // matches any whitespace character. Equivalent to /[ \t\v\r\n\f]/
/\S/ // matches any non-whitespace character. Equivalent to /[^ \t\v\r\n\f]/
```

  * `\s` and `\S` can be used either inside or outside square brackets
    * Outside they simply stand for one of the appropriate characters
    * Inside the represent an additional member of a class

Examples:

```javascript
/\sa/ // matches any whitespace character followed by a lowercase 'a'
/[\sa]/ // matches any whitespace character OR any lowercase 'a'
```

<a name='digits-and-hex-digits'></a>
### Digits and Hex Digits

  * Decimal digits (0-9) generally have their own character class shortcut
  * Hexadecimal digits (0-9, a-f, A-F) may also have a shortcut in certain regex engines
  * `\d` matches any decimal digits
  * `\D` matches any character except decimal digits
  * `\h` matches any hexadecimal digit (in the Ruby regex engine)
  * `\H` matches any character except hexadecimal digits (in the Ruby regex engine)
  * These shortcuts may be used inside or outside square brackets

<a name='word-characters'></a>
### Word Characters

  * `\w` matches word characters, which means all of the alphabetic characters (in both upper and lower case), all of the nuberical digits, and the underscore
  * `\W` matches any character that is not one of these characters
  * Essentially, `/\w/` is equivalent to `/[0-9a-zA-Z_]`, and `/\W` is equivalent to `/[^0-9a-zA-Z_]`
  * These shortcuts may be used inside or outside square brackets
