# Arrays

  * [Overview](#overview)
    * [Iterating Through and Array](#iterating)
    * [Accessing, Modifying, and Detecting Values](#accessing-values)
    * [Arrays are Objects](#arrays-objects)
  * [Array Methods](#array-methods)
    * [`push`](#push)
    * [`pop`](#pop)
    * [`shift`](#shift)
    * [`unshift`](#unshift)
    * [`indexOf`](#indexOf)
    * [`lastIndexOf`](#lastIndexOf)
    * [`slice`](#slice)
    * [`splice`](#splice)
    * [`concat`](#concat)
    * [`join`](#join)
  * [Arrays and Operators](#arrays-operators)
    * [Arithmetic Operators](#arithmetic-operators)
    * [Comparison Operators](#comparison-operators)


<a name='overview'></a>
## Overview

  * The basic collection type used in JavaScript
  * Hold a list of values indexed by a non-negative integer values
  * Can be created using a simple Array literal syntax, or with a constructor

Examples:

```JavaScript
[] // an empty Array

[0, 1, 2] // an Array holding thre values

[42, 'hi', false, [true, 'hello', 5]] // Arrays can contain other objects

// Creating an array with a constructor:

var count = new Array(1, 2, 3);

// usually written as:

var count = [1, 2, 3];
```

<a name='iterating'></a>
### Iterating Through an Array

  * The `for` loop can be used to iterate through the elements of an Array

Example:

```JavaScript
var count = [1, 2, 3, 4];
for (var i = 0; i < count.length; i++) {
  console.log(count[i]);
}

// logs all the elements in count to the console
```

<a name='accessing-values'></a>
### Accessing, Modifying, and Detecting Values

  * JavaScript Arrays are indexed collections that use zero-based indexes; i.e. the first element has an index of `0`
  * Bracket notation can be used to access the value of an element at a given index position
  * Attempting to access an out-of-bounds value returns `undefined`

Example:

```JavaScript
var myNumbers = [7, 8, 9, 10, 11];

myNumbers[0]; // 7
myNumbers[2]; // 9
myNumbers[50]; // undefined
```

  * Values can be added in a similar way
  * You can asign a value to any position in an Array; `undefined` is inserted into any skipped positions

  Example:

  ```JavaScript
  var myNumbers = [7, 8, 9, 10, 11];

  myNumbers[5] = 12;
  myNumbers; // [7, 8, 9, 10, 11, 12]
  myNumbers[8] = 13;
  myNumbers; // [7, 8, 9, 10, 11, 12, undefined, undefined, 13]
  myNumbers[6]; // undefined
  myNumbers.length; // 9
  ```

    * The `length` property of Array returns a value one higher than the highest index
    * You can change the Array's length by assigning a new value to the `length` property
      * If the new length is greater than the previous length, `undefined` is inserted into any additional positions
      * If the new length is less than the previous length, excess elements are lost

Example:

```JavaScript
var myNumbers = [7, 8, 9, 10, 11];
myNumbers.length; // 5
myNumbers.length = 8;
myNumbers; // [7, 8, 9, 10, 11, undefined, undefined, undefined]
myNumbers.length = 2;
myNumbers; // [7, 8]
```

<a name='arrays-objects'></a>
### Arrays are Objects

  * JavaScript Arrays are really Objects
  * If you need to determine if something is an Array, you can use `Array.isArray()` instead of `typeof`

Example:

```JavaScript
typeof []; // 'object'
Array.isArray([]); // true
Array.isArray('array'); // false
```
<a name='array-methods'></a>
## Array Methods

  * JavaScript has a set of [built-in Array methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)
  * JavaScript has an `Array` **global object**; this object has something called a **prototype object**.
    * It is the prototype object that defines the methods for Arrays
    * All JavaScript Arrays inherit from the prototype object
    * Some of the most common Array methods are `push`, `pop`, `shift`, `unshift`, `indexOf`, `lastIndexOf`, `slice`, `splice`, `concat`, and `join`

<a name='push'></a>
### `push`

Syntax:

```JavaScript
arr.push([element1[, ...[, elementN]]])
```

  * [Array.prototype.push](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push) adds one or more elements to the **end** of an array and returns the new length of the array

Examples:

```JavaScript
var numbers = [1, 2, 3];
numbers.push(4);
numbers; // [1, 2, 3, 4]
numbers.push(5, 6, 7);
numbers; // [1, 2, 3, 4, 5, 6, 7]
```

<a name='pop'></a>
### `pop`

Syntax:

```JavaScript
arr.pop()
```

  * [Array.prototype.pop](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop) removes the **last** element from an array and returns that element. THis method changes the length of the array

Examples:

```JavaScript
var a = [1, 2, 3];
a.pop(); // returns 3
a; // [1, 2]
```

<a name='shift'></a>
### `shift`

Syntax:

```JavaScript
arr.shift()
```

  * [Array.prototype.shift](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift) removes the **first** element from an array and returns that element. This method changes the length of an array

Examples:

```JavaScript
var a = [1, 2, 3];
a.shift(); // returns 1
a; // [2, 3]
```

<a name='unshift'></a>
### `unshift`

Syntax:

```JavaScript
arr.unshift([element1[, ...[, elementN]]])
```

  * [Array.prototype.unshift](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift) adds one or more elements to the **beginning** of an array and returns teh new length of the array

Examples:

```JavaScript
var a = [1, 2, 3];
a.unshift(4);
a; // [4, 1, 2, 3]
a.unshift(5, 6, 7);
a; // [5, 6, 7, 4, 1, 2, 3]
```

<a name='indexOf'></a>
### `indexOf`

Syntax:

```JavaScript
arr.indexOf(searchElement[, fromIndex])
```

  * [Array.prototype.indexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf) returns the **first** index at which a given element can be found in the array, or `-1` if the element is not present in the array
  * `fromIndex` is an optional second parameter indicating the index of the array at which to start searching.
    * If it is greater than the array's length, `-1` is returned.
    * If it is a negative number, it is taken as an offset from the end of the array (though the array is still searched from front to back)
    * If the index calculated is less than `0` then the whole array will be searched
    * Default is `0`

Examples:

```JavaScript
var a = [2, 9, 2, 9];
a.indexOf(2); // 0
a.indexOf(9); // 1
a.indexOf(7); // -1
a.indexOf(9, 2); // 3
a.indexOf(9, 4); // -1
a.indexOf(2, -3); // 2
a.indexOf(9, -5); // 1
```

<a name='lastIndexOf'></a>
### `lastIndexOf`

Syntax:

```JavaScript
arr.lastIndexOf(searchElement)
arr.lastIndexOf(searchElement, fromIndex)
```

  * [Array.prototype.lastIndexOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/lastIndexOf) returns the **last** index at which a given element can be found in the array, or `-1` if the element is not present in the array. The array is searched backwards starting at `fromIndex`
  * `fromIndex` is an optional second parameter indicating the index of the array at which to start searching.
    * If it is greater than or equal to the array's length, then the whole array will be searched, from back to front.
    * If it is a negative number, it is taken as an offset from the end of the array (though the array is still searched from back to front)
    * If the index calculated is less than `0`, -1 is returned
    * Default is array length minus one (`arr.length - 1`)

Examples:

```JavaScript
var a = [2, 9, 2, 9];
a.lastIndexOf(2); // 2
a.lastIndexOf(9); // 3
a.lastIndexOf(7); // -1
a.lastIndexOf(9, 2); // 1
a.lastIndexOf(9, 4); // 3
a.lastIndexOf(9, -4); // -1
a.lastIndexOf(9, -5); // -1
```

<a name='slice'></a>
### `slice`

Syntax:

```JavaScript
arr.slice()
arr.slice(begin)
arr.slice(begin, end)
```

  * [Array.prototype.slice](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice) returns a shallow copy of a portion of an array into a new array object selected from `begin` to `end` (not inclusive). The original array is not modified.
    * `begin` is an optional parameter which indicates the index at which to begin extraction
      * A negative value indicates an offset from the end of the array
      * If `undefined` it `slice` beginsa at `0`
    * `end` is an optional parameter which indicates the index before which to end extraction (i.e. the item at the index equal to `end` is not included in the new array)
      * A negative value indicates an offset from the end of the array
      * If ommitted, or is greater than the length of the array, `slice` extracts through the end of the array (arr.length)

Examples:

```JavaScript
var a = [1, 2, 3, 4, 5];
a.slice(); // [1, 2, 3, 4, 5]
a.slice(2); // [3, 4, 5]
a.slice(2, 4); // [3, 4]
a.slice(2, 10); // [3, 4, 5]
a.slice(-3); // [3, 4, 5]
a.slice(-10) // [1, 2, 3, 4, 5]
```

<a name='splice'></a>
### `splice`

Syntax:

```JavaScript
array.splice(start)
array.splice(start, deleteCount)
array.splice(start, deleteCount, item1, item2, ...)
```

  * [Array.prototype.splice](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice) changes the contents of an array by removing existing elements and/ or adding new elements. Ite returns a new array of the removed elements (if no elements are removed, an empty array is returned).
    * `start` indicates the index at which to start changing the array.
      * If greater than the length of the array, the starting index will be set to the length of the array
      * A negative value indicates an offset from the end of the array, and will be set to `0` if it would otherwise result in an index less than `0`
    * `deleteCount` is an optional parameter; it is an integer indicating the number of old array elements to remove.
      * If `0` then no elements are removed; in this case you should specifcy at least one new element.
      * If omitted, or greater than `array.length - start`, all remaining elements from start onwards are removed
    * `item1, item2, ...` are optional parameters indicating items to add to the array, beginning at the start index.
      * If no items are specified, `splice()` will only remove items

Examples:

```JavaScript
var a = [1, 2, 3, 4, 5];
a.splice(2); // [3, 4, 5]
a; // [1, 2]

var a = [1, 2, 3, 4, 5];
a.splice(2, 0); // []
a; // [1, 2, 3, 4, 5]

a.splice(2, 2, 6, 7) // [3, 4]
a; // [1, 2, 6, 7, 5]
```

<a name='concat'></a>
### `concat`

Syntax:

```JavaScript
var new_array = old_array.concat(value1[, value2[, ...[, valueN]]])
```

  * [Array.prototype.concat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat) is used to merge two or more arrays. It does not change the existing arrays but returns a new array.

Examples:

```JavaScript
var a = [1, 2, 3];
var b = a.concat(4); // [1, 2, 3, 4]
var c = b.concat([5, 6, 7]); // [1, 2, 3, 4, 5, 6, 7]
a; // [1, 2, 3]
b; // [1, 2, 3, 4]
c; // [1, 2, 3, 4, 5, 6, 7]
```

<a name='join'></a>
### `join`

Syntax:

```JavaScript
arr.join()
arr.join(separator)
```

  * [Array.prototype.join](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join) joins all elements of an array (or an array-like object) into a string and returns the string. If the length of the array is `0` then an empty string is returned.
    * `separator` is an optional parameter that specifies a string with which to separate each element in the array.
      * If separator is an empty string, then all the elements are joined with no character in between.
      * The default is `','`

Examples:

```JavaScript
var a = ['one', 'two', 'three'];
a.join(); // 'one,two,three'
a.join('-'); // 'one-two-three'
a.join(''); // 'onetwothree'
```

<a name='arrays-operators'></a>
## Arrays and Operators

  * The common operators used in JavaScript (and many other pogramming languages) such as `+`, `-`, `/`, `*`, `%`, `+=`, `-=`, `==`, `!=`, `===`, `!==`, `>`, `>=`, `<`, and `<=` are almost useless with Array objects

<a name='arithmetic-operators'></a>
### Arithmetic Operators

  * Arithmetic operators convert Arrays to Strings before performing an operation
  * This operation is non-mutating (i.e. it doesn't modify the array), but the results of the operation are generally not what is expected or desired
  * The danger of using operators on Arrays is that they run without producing a warning; this makes it easy for bugs to go undetected

Examples:

```JavaScript
var initials = ['A', 'H', 'E'];
initials + 'B';                   // 'A,H,EB'
initials;                         // [ 'A', 'H', 'E' ]
initials + ['B'];      //  'A,H,EB'
initials;              // [ 'A', 'H', 'E' ]

[1] * 2;              // 2
[1, 2] * 2;           // NaN
```

<a name='comparison-operators'></a>
### Comparison Operators

  * Neither equality `==` nor strict-equality `===` consider Arrays with the same values to be equal, since they are different array objects
  * Arrays are only equal if they ar the same object

Examples:

```JavaScript
var friends = ['Bob', 'Josie', 'Sam'];
var enemies = ['Bob', 'Josie', 'Sam'];
friends == enemies;        // false
friends === enemies;       // false

var friends = ['Bob', 'Josie', 'Sam'];
var roommates = friends;
friends == roommates;      // true
friends === roommates;     // true
```
