# Using Regular Expressions in Ruby and JavaScript

  * [Overview](#overview)
  * [Matching Strings](#matching-strings)
  * [Splitting Strings](#splitting-strings)
  * [Capturing Groups](#capturing-groups)
  * [Transforming Strings](#transforming-strings)
    * [Transformations in Ruby](#transformations-ruby)
    * [Transformations in JavaScript](#transformations-javaScript)
  * [Resources](#resources)
  * [Cheatsheet](#cheatsheet)

<a name='overview'></a>
## Overview

  * There are many methods available in both Ruby and JavaScript that use regex.
  * Many of these are methods of the `Regexp` (Ruby) and `RegExp` (JavaScript) classes, but some of the most commonly used methods are those of the `String` classes of Ruby and JavaScript

<a name='matching-strings'></a>
## Matching Strings

  * The `match` method is one of the most basic methods for matching regex patterns
  * The `match` method returns a value that indicates whether a match was made and what exactly was matched
  * This return value is 'truthy' and can be tested in a conditional expression in either Ruby or JavaScript to test if a given string matched a regex

Examples:

  * In the following two examples, `fetch_url` is only called if the `text` variable contains a string that looks like a URL (as defined by the regex).

```ruby
# ruby

fetch_url(text) if text.match(/\Ahttps?:\/\/\S+\z/)
```

```javascript
// javascript

if (text.match(/^https?:\/\/\S+$/)) {
  fetch_url(text);
}
```

  * The method returns an object (specifically a `MatchData` object in Ruby) if a match is made, and `nil` (Ruby) or `null` (JavaScript) if there is no match
  * Ruby's [String#match](http://ruby-doc.org/core-2.4.2/String.html#method-i-match) method
    * Ruby's [String#=~](http://ruby-doc.org/core-2.4.2/String.html#method-i-3D-7E) method is similar to `String#match`, but returns the index within the String at which the regex matched (if a match is made) rather than a `MatchData` object; (both methods return `nil` in the event of no match). It is also faster than `String#match`
    * Ruby's [String#scan](http://ruby-doc.org/core-2.4.2/String.html#method-i-scan) method; it is a global form of match that returns an array of all matching substrings
  * JavaScript's [String.prototype.match](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match) method

<a name='splitting-strings'></a>
## Splitting Strings

  * Quite often when dealing with strings, they need to be split into smaller sub-strings in order to be processed or analysed.
  * Such substrings are often delineated by some sort of special character, such as the newline or tab characters
  * In order to break up strings into sub-strings, the `split` method is often used
  * `split` is often used with a simple string as a delineator rather than a regex, which is fine if the delineators occur in a uniform patterns within the string
  * If the delineators don't occur in a uniform pattern within the string, a regex can be useful

Examples:

```ruby
"xyzzy\t3456\t334\tabc".split("\t") # => ['xyzzy', '3456', '334', 'abc']
"xyzzy  3456  \t  334\t\t\tabc".split("\t") # => ["xyzzy  3456  ", "  334", "", "", "abc"]
"xyzzy  3456  \t  334\t\t\tabc".split(/\s+/) # => ["xyzzy", "3456", "334", "abc"]
```

  * Ruby's [String#split](http://ruby-doc.org/core-2.4.2/String.html#method-i-split) method
  * JavaScript's [String.prototype.split](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split) method

<a name='capturing-groups'></a>
## Capturing Groups

  * Capturing groups are defined by grouping part of a match patterns in parentheses
  * Capturing groups capture information from a matched string
  * Information captured by a capture group can later be used within the same regex
  * To reuse the capturing group, you use a *backreference*, which is denoted by a backslash (Ruby) or dollar sign (JavaScript) followed by a digit, e.g. `\1` or `$1`
  * A regex may contain multiple capturing groups
  * Backreferences go in order from `\1` or `\$1` for the backreference for the first capturing group that occurs in the regex, through `\2` or `$2`, `\3` or `$3`, etc.

Example:

```ruby
/(['"]).+?\1/
```

  * This will match either a single-quote `'` or a double-quote `"`, followed by one or more characters, and then another quote of the same type as that captured by the capturing group

<a name='transforming-strings'></a>
## Transforming Strings

  * Transforming strings with regex involves matching the string against a regex and using the results of the match to construct a new string
  * While regex-based transformations are conceptually similar in Ruby and JavaScript, the implementations are different

<a name='transformations-ruby'></a>
### Transformations in Ruby

  * In Ruby, transformations are usually done using the `sub` and `gsub` methods (or `sub!` and `gsub!` for in-place transformations)
  * The `String#sub` method transforms the fist part of a string that matches a given regex
  * The `String#gsub` method transforms every part of the string that matches the regex

Example:

```ruby
'Four score and seven'.sub(/[aeiou]/, '') # => 'Fur score and seven'
'Four score and seven'.gsub(/[aeiou]/, '') # => 'Fr scr nd svn'
```

  * Ruby's [String#sub](http://ruby-doc.org/core-2.4.2/String.html#method-i-sub) method
  * Ruby's [String#gsub](http://ruby-doc.org/core-2.4.2/String.html#method-i-sub-21) method
  * Ruby's [String#sub!](http://ruby-doc.org/core-2.4.2/String.html#method-i-gsub) method
  * Ruby's [String#gsub!](http://ruby-doc.org/core-2.4.2/String.html#method-i-gsub-21) method

<a name='transformations-javaScript'></a>
### Transformations in JavaScript

  * In JavaScript, transformations are usually done using the `replace` method
  * `replace` transforms the part of a string that matches a given regex; if the regex includes the `g` options, the transformation is applied to every match in the string

Example:

```javascript
'Four score and seven'.replace(/[aeiou]/, ''); // 'Fur score and seven'
'Four score and seven'.replace(/[aeiou]/g, ''); // => 'Fr scr nd svn'
```

  * JavaScript's [String.prototype.replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace) method

<a name='resources'></a>
## Resources

### Sites and Tutorials

  * [Essential Guide To Regular Expressions: Tools and Tutorials](https://www.smashingmagazine.com/2009/06/essential-guide-to-regular-expressions-tools-tutorials-and-resources/)
  * [Regular-Expressions.info](http://www.regular-expressions.info/)
  * [Regex Tutorial—From Regex 101 to Advanced Regex](http://www.rexegg.com/)

### Tools

  * [Rubular](http://rubular.com)
  * [Scriptular](http://scriptular.com)

### Books

  * [Introducing Regular Expressions](http://shop.oreilly.com/product/0636920012337.do)
  * [Mastering Regular Expressions](http://shop.oreilly.com/product/9780596528126.do)

<a name='cheatsheet'></a>
## Cheatsheet

### Basic Matching

| Pattern        | Meaning                                       |
|----------------|-----------------------------------------------|
| `/a/`          | Match the character `a`                       |
| `/\?/`, `/\./` | Match a meta-character literally              |
| `/\n/`, `/\t/` | Match a control character (newline, tab, etc) |
| `/pq/`         | Concatenation (`p` followed by `q`)           |
| `/(p)/`        | Capturing Group                               |
| <code>/(p&#124;q)/</code> | Alternation (`p` or `q`)                      |
| `/p/i`         | Case insensitive match                        |

### Character Classes and Shortcuts

| Pattern          | Meaning                                         |
|------------------|-------------------------------------------------|
| `/[ab]/`         | `a` or `b`                                      |
| `/[a-z]/`        | `a` through `z`, inclusive                      |
| `/[^ab]/`        | Not (`a` or `b`)                                |
| `/[^a-z]/`       | Not (`a` through `z`)                           |
| `/./`            | Any character except newline                    |
| `/\s/`, `/[\s]/` | Whitespace character (space, tab, newline, etc) |
| `/\S/`, `/[\S]/` | Not a whitespace character                      |
| `/\d/`, `/[\d]/` | Decimal digit (`0-9`)                           |
| `/\D/`, `/[\D]/` | Not a decimal digit                             |
| `/\w/`, `/[\w]/` | Word character (`0-9`, `a-z`, `A-Z`, `_`)       |
| `/\W/`, `/[\W]/` | Not a word character                            |

### Anchors

| Pattern          | Meaning                                   |
|------------------|-------------------------------------------|
| `/^p/`           | Pattern at start of line                  |
| `/p$/`           | Pattern at end of line                    |
| `/\Ap/`          | Pattern at start of string                |
| `/p\z/`          | Pattern at end of string (after newline)  |
| `/p\Z/`          | Pattern at end of string (before newline) |
| `/\bp/`          | Pattern begins at word boundary           |
| `/p\b/`          | Pattern ends at word boundary             |
| `/\Bp/`          | Pattern begins at non-word boundary       |
| `/p\B/`          | Pattern ends at non-word boundary         |

### Quantifiers

| Pattern          | Meaning                                |
|------------------|----------------------------------------|
| `/p*/`           | 0 or more occurrences of pattern       |
| `/p+/`           | 1 or more occurrences of pattern       |
| `/p?/`           | 0 or 1 occurrence of pattern           |
| `/p{m}/`         | `m` occurrences of pattern             |
| `/p{m,}/`        | `m` or more occurrences of pattern     |
| `/p{m,n}/`       | `m` through `n` occurrences of pattern |
| `/p*?/`          | 0 or more occurrences (lazy)           |
| `/p+?/`          | 1 or more occurrences (lazy)           |
| `/p??/`          | 0 or 1 occurrence (lazy)               |
| `/p{m,}?/`       | `m` or more occurrences (lazy)         |
| `/p{m,n}?/`      | `m` through `n` occurrences (lazy)     |

### Common Ruby Methods for Regex

| Method            | Use                                 |
|-------------------|-------------------------------------|
| `String#match`    | Determine if regex matches a string |
| `string =~ regex` | Determine if regex matches a string |
| `String#split`    | Split string by regex               |
| `String#sub`      | Replace regex match one time        |
| `String#gsub`     | Replace regex match globally        |

### Common JavaScript Functions for Regex

| Method            | Use                                 |
|-------------------|-------------------------------------|
| `String.match`    | Determine if regex matches a string |
| `String.split`    | Split string by regex               |
| `String.replace`  | Replace regex match                 |
