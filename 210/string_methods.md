# String Methods

  * [MDN String Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/prototype)


## Searching

### `String.prototype.charAt()`

  * Returns the character at the specified index within a string

#### Arguments

  * An index value within the string the method is being called on

#### Return Value

  * An single character string
  * An empty string if the index is out of range

#### Example

```JavaScript
'ABC'.chaAt(0); // returns 'A'
```

### `String.prototype.indexOf()`

  * Returns the index within a string of the first occurence of a specified substring

#### Arguments

  * An string to search for within the overall string
  * An optional starting index

#### Return Value

  * The index of the the first occurence of the search string within the string that the method is called on
  * `-1` if the search string is not found in the string

#### Example

```JavaScript
'ABC'.indexOf('A'); // returns 0
'ABCA'.indexOf('A'); // returns 0
'ABC'.indexOf('D'); // returns -1
```

### `String.prototype.lastIndexOf()`

  * Returns the index within a string of the last occurence of a specified substring

#### Arguments

  * An string to search for within the overall string
  * An optional starting index

#### Return Value

  * The index of the the last occurence of the search string within the string that the method is called on
  * `-1` if the search string is not found in the string

#### Example

```JavaScript
'ABC'.lastIndexOf('A'); // returns 0
'ABCA'.lastIndexOf('A'); // returns 3
'ABC'.lastIndexOf('D'); // returns -1
```

### `String.prototype.includes()`

  * Determines whether a substring exists within another string

#### Arguments

  * An string to search for within the overall string
  * An optional starting index

#### Return Value

  * `true` if the search string exists in the string that the method is called on
  * `false` if the search string does not exists in the string that the method is called on

#### Example

```JavaScript
'ABC'.includes('A'); // returns true
'ABC'.includes('D'); // returns false
```

### `String.prototype.startsWith()`

  * Determines whether a string starts with a specified substring

#### Arguments

  * An string to search for within the overall string
  * An optional index position to determine where to begin searching (defaults to `0`)

#### Return Value

  * `true` if the search string that the method is called on starts with the search string
  * `false` if the search string that the method is called on does not start with the search string

#### Example

```JavaScript
'ABC'.startsWith('A'); // returns true
'ABC'.startsWith('C'); // returns false
'ABC'.startsWith('A', 1); // returns false
```

### `String.prototype.endsWith()`

  * Determines whether a string ends with a specified substring

#### Arguments

  * An string to search for within the overall string
  * An optional length value to determine the 'end' of the string being searched in (the default is the actual string length)

#### Return Value

  * `true` if the search string that the method is called on ends with the search string
  * `false` if the search string that the method is called on does not end with the search string

#### Example

```JavaScript
'ABC'.endsWith('A'); // returns false
'ABC'.endsWith('C'); // returns true
'ABC'.endsWith('C', 2); // returns false
```

## Transforming

### `String.fromCharCode()`

  * Returns a string created by using the specified sequence of Unicode Values

#### Arguments

  * Can take multiple, comma separated arguments
  * Each argument is a Unicode value between 0 and 65535

#### Return Value

  * The return value is a string

#### Example

```JavaScript
String.fromCharCode(65, 66, 67);  // returns "ABC"
```

### `String.prototype.charCodeAt()`

  * Returns an integer between 0 and 65535 representing the Unicode value of a character at a certain index in a string

#### Arguments

  * An index value within the string the method is being called on

#### Return Value

  * An integer between 0 and 65535

#### Example

```JavaScript
'ABC'.charCodeAt(0); // returns 65
```


###Transformation###

String.prototype.toString()
String.prototype.valueOf()
String.prototype.split()
String.prototype.concat()
String.prototype.replace()
String.prototype.repeat()
String.prototype.toLowerCase()
String.prototype.toUpperCase()



###Searching###

String.prototype.match()
String.prototype.search()
String.prototype.startsWith()

###Slicing and Substrings###

String.prototype.slice()
String.prototype.substr()
String.prototype.substring()

###Trimming and Padding###

String.prototype.trim()
String.prototype.trimLeft()
String.prototype.trimRight()
String.prototype.padEnd()
String.prototype.padStart()
