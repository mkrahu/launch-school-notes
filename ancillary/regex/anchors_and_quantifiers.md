# Anchors and Quantifiers

## Anchors

  * Unlike other special characters used in regex, anchors don't actually match any characters
  * Anchors ensure that a regex only matches a string at a certain place in a string:
    * The beginning of a string
    * The end of a string
    * The beginning of a line
    * The end of a line
    * On a word boundary
    * On a non-word boundary

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

### Word Boundaries

  * A word boundary occurs at the beginning and end of a sequance of word characters
  * For the purposes of word boundary anchors, word characters are any characters denoted by the `\w` meta-character, so alphanumerics of both cases and underscore
  * A word boundary occurs at the beginning or ending of a sequence of word characters bounded by either a whitespace or the begining or end of a string
  * To anchor a regex to a word boundary, the `\b` meta-character is used
  * There is also a non-word boundary meta-character `\B`, although its use is rarer
  * Note, `\b` and `\B` do not work as word boundaries inside of character classes (i.e. you cannot use them inside square brackets)

Examples:

```ruby
'cat dog.'.match(/\bcat\b/) # matches
'cat dog.'.match(/\bcat\B/) # does not match
'cat dog.'.match(/\bdog.\b/) # does not match
'cat dog.'.match(/\bdog.\B/) # matches
```
