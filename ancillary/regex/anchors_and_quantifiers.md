# Anchors and Quantifiers

  * [Anchors](#anchors)
    * [Start/ End of line](#start-end-of-line)
    * [Lines vs Strings](#lines-vs-strings)
    * [Start/End of String](#start-end-of-string)
    * [Word Boundaries](#word-boundaries)
  * [Quantifiers](#quantifiers)
    * [Zero or More](#zero-or-more)
    * [One or More](#one-or-more)
    * [Zero or One](#zero-or-one)
    * [Ranges](#ranges)
    * [Greediness](#greediness)

<a name='anchors'></a>
## Anchors

  * Unlike other special characters used in regex, anchors don't actually match any characters
  * Anchors ensure that a regex only matches a string at a certain place in a string:
    * The beginning of a string
    * The end of a string
    * The beginning of a line
    * The end of a line
    * On a word boundary
    * On a non-word boundary

<a name='start-end-of-line'></a>
### Start/ End of line

  * The `^` and `$` meta-characters are *anchors* which fix a regex match to the beginning or ending of a line of text
  * The `^` character will anchor a regex to the beginning of a line
  * The `$` character will anchor a regex to the end of a line


  * Using `^` forces whatever pattern that follows it to only match at the beginning of each line

Examples:

```ruby
'cat'.match(/^cat/) # matches
'catastrophe'.match(/^cat/) # matches
'wildcat'.match(/^cat/) # does not match
'I love my cat'.match(/^cat/) # does not match
'<cat>'.match(/^cat/) # does not match
```

* Using `$` forces whatever pattern that follows it to only match at the end of each line

Examples:

```ruby
'cat'.match(/cat$/) # matches
'catastrophe'.match(/cat$/) # does not match
'wildcat'.match(/cat$/) # matches
'I love my cat'.match(/cat$/) # matches
'<cat>'.match(/cat$/) # does not match
```

  * You can combine `^` and `$` (or any other anchors) to provide more flexibility

Examples:

```ruby
'cat'.match(/^cat$/) # matches
'catastrophe'.match(/^cat$/) # does not match
'wildcat'.match(/^cat$/) # does not match
'I love my cat'.match(/^cat$/) # does not match
'<cat>'.match(/^cat$/) # does not match
```

<a name='lines-vs-strings'></a>
### Lines vs Strings

  * There's some subtelty involved with how `^` and `$` work with Ruby
  * This arises when attempting to match a string that contains one or more newline characters
  * In Ruby, `^` and `$` anchor the start and end of *lines*, rather than the start and end of *strings*

Examples:

```ruby
'cat\ndog'.match(/^cat/) # matches
'cat\ndog'.match(/cat$/) # matches
'cat\ndog'.match(/^cat$/) # matches
'cat\ndog'.match(/^dog/) # matches
'cat\ndog'.match(/dog$/) # matches
'cat\ndog'.match(/^dog$/) # matches
```

  * The JavaScript regex engine does not make this distinction between lines and strings

<a name='start-end-of-string'></a>
### Start/End of String

  * Since Ruby makes a distinction between atart/ end of line and start/ end of string, and `^` & `$` are used to anchor start and end of line, the Ruby regex engine provides other special characters to anchor start and end of string
  * The `\A` anchor ensures that a regex only matches at the start of a string
  * The `\Z` and `\z` anchors only match at the end of a string
    * `\z` always matches at the end of a string, whereas `\Z` will match up to but not including a newline at the end of a string
    * As a rule you should generally use `\z` rather than `\Z` unless there is a specific reason not to

Examples:

```ruby
'cat\ndog'.match(/\Acat/) # matches
'cat\ndog'.match(/cat\z/) # does not match
'cat\ndog'.match(/\Acat\z/) # does not match
'cat\ndog'.match(/\Adog/) # does not match
'cat\ndog'.match(/dog\z/) # matches
'cat\ndog'.match(/\Adog\z/) # does not match
```

<a name='word-boundaries'></a>
### Word Boundaries

  * A word boundary occurs at the beginning and end of a sequance of word characters
  * For the purposes of word boundary anchors, word characters are any characters denoted by the `\w` meta-character, so alphanumerics of both cases and underscore
  * A word boundary occurs at the beginning or ending of a sequence of word characters bounded by either a whitespace or the begining or end of a string, or a non-alphanumeric character (e.g. `!` or `?`)
  * To anchor a regex to a word boundary, the `\b` meta-character is used
  * There is also a non-word boundary meta-character `\B`, although its use is rarer. A non-word boundary occurs everywhere that a word boundary doesn't occur (e.g. between two alphanumeric characters)
  * Note, `\b` and `\B` do not work as word boundaries inside of character classes (i.e. you cannot use them inside square brackets)

Examples:

```ruby
'cat dog'.match(/\bcat\b/) # matches
'cat dog'.match(/\bcat\B/) # does not match
'cat dog'.match(/\bdog\b/) # matches
'cat dog'.match(/\bdog\B/) # does not match
```

<a name='quantifiers'></a>
## Quantifiers

  * Quantifiers can be used to construct patterns that match sequences of various lengths

Example:

  * If you wanted to construct a regex that matched strings of three or more of any digit, you might try writing something like this, using alternation:

```ruby
/\b(\d\d\d\d\d\d|\d\d\d\d\d|\d\d\d\d|\d\d\d)\b/
```

  * The problem here is that it only matches strings of between three and six digits, strings of seven digits would not be matched. You can't simply keep adding digits forever using alternation.
  * In this situation, quantifiers can be used to indicate 'quantities' of a character or pattern to be matched

<a name='zero-or-more'></a>
### Zero or More

  * The `*` special character is the quantifier for zero or more
  * When used, it matches zero or more occurences of the pattern to its left
  * The `*` quantifier is often used with concatenation. If used to quantify a single pattern with no others concatenated, it will simply match every string, since it is matching *zero or more* occurences of the pattern
  * Grouping parantheses can be used to enclose the pattern that you want to quantify

Example:

```ruby
'cat'.match(/cat*/) # matches
'car'.match(/cat*/) # matches
'can'.match(/cat*/) # matches
'cut'.match(/cat*/) # does not match
```

<a name='one-or-more'></a>
### One or More

  * The `+` special character is the quantifier for one or more
  * When used, it matches one or more occurences of the pattern to its left
  * Note: not all regex engines offer the the `+` quantifier, but the Ruby and JavaScript engines do

Example:

```ruby
'ca'.match(/cat+/) # does not match
'cat'.match(/cat+/) # matches
'catt'.match(/cat+/) # matches
'cart'.match(/cat+/) # does not match
```

<a name='zero-or-one'></a>
### Zero or One

  * The `?` special character is the quantifier for zero or one
  * When used, it matches one or one (but not more than one) occurences of the pattern to its left
  * The `?` quantifier is often used with concatenation. If used to quantify a single pattern with no others concatenated, it will simply match every string, since it is matching *zero or one* occurences of the pattern

```ruby
'ct'.match(/co?t/) # matches
'cot'.match(/co?t/) # matches
'coot'.match(/co?t/) # does not match
```

<a name='ranges'></a>
### Ranges

  * Sometimes zero or more, one or more, or zero or one are not specific enough to quantify the pattern that you want to match
  * Ranges can be used to provide more precision
  * The range quantifier consists of a pair of curly braces `{}` containing one or two (comma-separated) numbers
    * If the braces contain one number, the quantifier matches that exact number of occurences of the pattern to its left
    * If the braces contain two, comma-separated, numbers the quantifier matches occurences of the pattern to its left between the first number and the second number

Example:

```ruby
'ct'.match(/ca{1}t/) # does not match
'cat'.match(/ca{1}t/) # matches
'caat'.match(/ca{1}t/) # does not match
'ct'.match(/ca{1,4}t/) # does not match
'cat'.match(/ca{1,4}t/) # matches
'caat'.match(/ca{1,4}t/) # matches
'caaat'.match(/ca{1,4}t/) # matches
'caaaat'.match(/ca{1,4}t/) # matches
'caaaaat'.match(/ca{1,4}t/) # does not match
```

<a name='greediness'></a>
### Greediness

  * Quantifiers are **greedy** by nature. This means that they always try to match as many characters as possible
    * For example, using the regex `/a[abc]*c/` against the string 'xabcbcbacy', it will match *all* the characters between 'x' and 'y', even though there are sections within those characters which match the regex on their own
  * Most of the time, this greedy behaviour is what you want. Sometimes though you need to match the fewest number of characters possible; this is called a **lazy** match
  * In Ruby and JavaScript, you can request a lazy match by adding a `?` just after the quantifier.
    * For example, using the regex `/a[abc]*?c/` against the string 'xabcbcbacy', it will match 'abc' and 'ac', rather than simply *all* the characters between 'x' and 'y'
  * The difference between greedy and lazy can be defined as:
    * Greedy quantifiers keep going after they find an initial match, until the string stops matching the pattern
    * Lazy quantifiers stop as soon as they find an initial match (though they can find another match later in the string as a separate match)
