# Regular Expressions

  * [Overview](#overview)
  * [Basic Matching](#basic-regex)
    * [Alphanumerics](#alphanumerics)
    * [Non-alphanumeric Characters](#non-alphanumerics)
    * [Concatenation](#concatenation)
    * [Alternation](#alternation)
    * [Control Character Escapes](#control-character-escapes)
    * [Ignoring Case](#ignoring-case)

<a name='overview'></a>
## Overview

  * Regular Expressions, or 'regex' are used for tasks that involve testing, analyzing, and modifying strings
  * Regex are special strings, also known as *patterns*, that are used to identify particular parts within a string or set of strings
  * They can be used as expressions in various programming languages to:
    * Perform conditional tests
    * Extract substrings from a larger string
    * Modify parts of a string

<a name='basic-regex'></a>
### Basic Regex

  * At their most basic, regex are expressed as a string of characters between two `/` characters, e.g. `/cat/`
    * This regex would match the string `'cat'`, even as part of a larger word, e.g. `'scatter'`, but would not match `'Cat'` or `'CAT'`
  * Regex patterns can be much more complex than this however, and incorporate various special characters, anchors and quantifiers in order to match very specific string patterns

<a name='overview'></a>
## Basic Matching

<a name='alphanumerics'></a>
### Alphanumerics

  * The simplest regex pattern is one that matches a specific alphanumerics character. For example `/s/` can match the character string `'s'` anywhere it appears inside of larger string, whether that's on its own or as part of a word.
  * Regex are case-sensitive, so `/s/` doesn't match `'S'` or any occurences of it in a string (unless we specify that we want to ignore the case)

Example:

  * A simple example of how such a patterns might be used can be demonstrated through the `match` method of String (which exists in both Ruby and JavaScript)

```ruby
# Ruby

'cast'.match(/s/) # matches
'cat'.match(/s/) # does not match
```

```javascript
// JavaScript

'cast'.match(/s/); // matches
'cat'.match(/s/); // does not match
```

<a name='non-alphanumerics'></a>
### Non-alphanumeric Characters

  * Regex can also match non-alphanumeric characters.
  * When matching such characters however, it is important to be aware that some of these 'special characters' have a particular meaning inside a regex and so require special treatment.
  * The following special characters have specific meanings in a Ruby or JavaScript regex:

```
$ ^ * + ? . ( ) [ ] { } | \ /
```

  * In relation to regex, these characters are called 'meta-characters'
  * Note: some other variants of regex have different meta-characters, so it's important to always be aware of the specific regex syntax for the programming language you are working in
  * When trying to match a meta-character as an actual character in a string, the meta-character must be escaped in the pattern by using a backslash

  Example:

    * Say was are looking to match the `?` character, again using the `match` method of String

  ```ruby
  # Ruby

  'cat?'.match(/\?/) # matches
  'cat'.match(/\?/) # does not match
  ```

  ```javascript
  // JavaScript

  'cat?'.match(/\?/); // matches
  'cat'.match(/\?/); // does not match
  ```

<a name='concatenation'></a>
### Concatenation

  * You can concatenate two or more regex patterns into a longer pattern

Example:

  * The regex `/cat/` is a concatenation of the three patterns `c`, `a`, and `t`, and matches any string that has those three strings immediately following each other in that order

```ruby
# Ruby

'cat'.match(/cat/) # matches
'cast'.match(/cast/) # does not match
```

  * Concatenation is not limited to such simple patterns (joining together multiple characters)
  * You can concatenate any pattern to another pattern to produce a longer regex, and can concatenate as many patterns as you need
  * Lots of concatenation of many complex patterns can soon become difficult to read, so this trade-off must be considered when using them

<a name='alternation'></a>
### Alternation

  * Alternation is a simple way regex that can match one of several sub-patterns
  * In its most basic form, you write two or more patterns separated by pipe `|` characters, then surround the entire expression in parentheses

Example:

```ruby
# Ruby

'cat'.match(/(cat|rabbit|dog)/) # matches
'rabbit'.match(/(cat|rabbit|dog)/) # matches
'dog'.match(/(cat|rabbit|dog)/) # matches
'fish'.match(/(cat|rabbit|dog)/) # does not match
```

  * Alternation can involve any number of patterns, and the patterns can be as complex as needed
  * the use of parentheses is not always required, but is strongly recommended. Parentheses are used for 'grouping' in regex
  * Since `(`, `|`, and `)` are beign used as meta-characters rather than literal instances of those characters, they do not need escaping

<a name='control-character-escapes'></a>
### Control Character Escapes

  * Most programming languages use special 'control character escapes' in strings to represent certain characters that don't have a 'visual' representation.
  * `\n`, `\r` and `\t` are near-universal ways of representing line-feeds, carriage returns, and tabs respectively.
  * It is important to note that some characters that look like control escape characters are actually not, and have some other use or meaning; for example:
    * `\s` and `\d` are special character classes
    * `\A` and `\z` are anchors
    * `\x` and `\u` are special character code markers

<a name='ignoring-case'></a>
### Ignoring Case

  * Regex are case-sensitive by default, i.e. if you want to match a lowercase `'s'`, you have to use a lowercase `s` in your pattern, and vice-versa
  * You can over-ride this default behaviour by appending an `i` after the closing `/` of your Regex

Example:

```ruby
# Ruby

'cat'.match(/cat/i) # matches
'Cat'.match(/cat/i) # matches
'CAT'.match(/cat/i) # matches
'cAt'.match(/cat/i) # matches
'caT'.match(/cat/i) # matches
```

  * As well as the `i` option, there are several other useful options (also called *flags* or *modifiers*); these tend to be language-specific
