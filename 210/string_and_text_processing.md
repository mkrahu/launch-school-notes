# String and Text Processing

  * [Overview](#overview)
  * [String Processing Patterns](#string-processing-patterns)
  * [String Methods](#string-methods)
  * [regular Expressions](#regex)


## Overview

  * String/ text processing is the manipulation of text-based content
  * String/ text processing is a fairly common requirement in many software applications

## String Processing Patterns

  * String processing usually follows a certain pattern:
    1. Declare a new (empty) string to use as a 'container' for the result
    2. remove any unneeded characters from the text (often done with regex in combination with string methods such as `replace`)
    3. Break down or parse the original string to produce a list/ array of smaller units; typically this is done by line, sentence, word, character, or according to specific delimiters
    4. Depending on the shape of the problem, apply a suitable list-procesing strategy
    5. Recombine the results into a new string if required
  * Note: not every step of this pattern is necessarily required for every text processing operation, though usually some sort of list-processing will be involved

## String Methods

  * The following methods of `String` are particularly useful when performing string processing operations:
    * [indexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf): This method returns the numeric index of the **first** occurence of a character or substring of characters within the string. If the search string does not exist in the string, then it returns `-1`.
    * [lastIndexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/lastIndexOf): This method returns the numeric index of the **last** occurence of a character or substring of characters within the string. If the search string does not exist in the string, then it returns `-1`.
    * [replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace): This method performs a substitution operation on the original string, and returns the result as a **new** string. By default, `replace` substitutes the **first** occurence of the substring or regex pattern given as the first argument, with the value to replace it specified as the second argument. If you use a regex, with the `g` (global) flag, then `replace` will substitute all occurences of the matching pattern. `replace` does not modify the original string.
    * [split](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split): This method splits the string into an array of strings based on a separator. If a string is suppled as a separator, it splits the string on each occurence of that string. If an empty string is used as a separator, it splits the string into an array of single character strings. The returned array does not include instances of the separtor string or regex pattern.
    * [substr](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substr): This method takes two numeric arguments, a starting index and a character count, and returns the part of the original string in the indicated range. The first argument is the index of the first character you wish to extract. If you omit the second argument, `substr` returns every character from the selected index point to the end. A negative starting index can be used to select an index relative to the end of teh string.
    * [substring](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/substring): This method is easy to confuse with `substr` but actually works quite differently. It also returns a portion of a string that lies in a range specified by two arguments, but in this case the second argument indicates the end index. The returned substring contains all the characters from the start index upto, but not including, the end index. If the value of the second argument is lower than the first then the arguments are reversed (the secondis treated as the start index, and the first as the end).
    * [toUpperCase](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toLowerCase): This method changes the letter characters in a string from uppercase to lowercase. Non-letter characters are unaffected.
    * [toLowerCase](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toUpperCase): This method changes the letter characters in a string from lowercase to uppercase. Non-letter characters are unaffected.

## Regular Expressions

  * Regular Expressions (regex) are often used as part of a solution to a string processing problem
  * They let you write highly expressive and declarative code for matching patterns in strings.
  * JavaScript has two built-in objects that can be used with Regular Expressions: `String` and `RegExp`
  * The `String` object lets you use the following methods:
    * [String.prototype.search](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/search)
    * [String.prototype.match](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match)
    * [String.prototype.replace](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace)
  * The `RegExp` object lets you use the following methods (as well as several others):
    * [RegExp.prototype.exec](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/exec)
    * [RegExp.prototype.test](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test)
  * More general notes on Regex, and how they are used, are [available here](https://github.com/superchilled/launch-school-notes/tree/master/ancillary/regex)
