# Array Methods

  * [MDN Array Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)


## Array Creation

### `Array.from()``

  * Creates a new Array instance from an array-like or iterable object

#### Parameters

  * An array like or iterable object to turn into an array
  * An optional map function to call on every element  of the array
  * An option value to use as `this` when executing the map function

#### Return Value

  * A new Array instance

#### Example

```JavaScript
Array.from('hello'); // ['h', 'e', 'l', 'l', 'o']
```

  * `Array.from` can be used with arrow functions to generate a sequence of numbers

```JavaScript
Array.from({length: 5}, (v, i) => i); // [0, 1, 2, 3, 4
```

### `Array.of()`

  * Creates a new Array instance with a variable number of arguments

#### Parameters

  * Elemements with which to populate the array

#### Return Value

  * A new Array instance

#### Example

```JavaScript
Array.of(7);       // [7]
Array.of(1, 2, 3); // [1, 2, 3]
```

## Transformation

### `Array.prototype.map()`

  * Creates a new array with the elements of the original array transformed by the results of calling a provided function on every element of the array

#### Parameters

  * A callback function which performs the transformation. The callback function takes three possible arguments:
    * The current element being processed
    * An optional index value for the current element being processed
    * An optional array value, which is the array that `map` was called on

  * As well as the callback function, `map` takes an optional value to use as `this` when executing the callback

#### Return Value

  * A new Array with the elements of the original array transformed by the callback function

#### Example

```JavaScript
[1, 2, 3].map(function(num) {
  return num * 2;
});

// returns [2, 4, 6]
```

  * The same code using arrow functions would be:

```JavaScript
[1, 2, 3].map(num => num * 2); // [2, 4, 6]
```

### `Array.prototype.concat()`

  * Merges two or more arrays to return a new array. Does not affect the existing arrays

#### Parameters

  * One or more arrays to concatenate to the array that the method is called on

#### Return Value

  * A new array formed of the array themethod is called on and the arrays passed in as arguments

#### Example

```JavaScript
[1, 2, 3].concat([4, 5, 6]); // [1, 2, 3, 4, 5, 6]
[1, 2, 3].concat([4, 5, 6], [7, 8, 9]); // [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### `Array.prototype.join()`

  * Joins all elements of an Array to form a String
  * If the array contains non-string elements, they are coerced into strings before joining

#### Parameters

  * An optional separator.
    * If used, the separator appears between each of the joined elements in the resulting string
    * If omitted, a comma `,` is used by default
    * If separator is an empty string, all the elements are joined without any characters between them

#### Return Value

  * A String formed of the Array elements

#### Example

```JavaScript
['a', 'b', 'c'].join(); // 'a,b,c'
['a', 'b', 'c'].join(', '); // 'a, b, c'
['a', 'b', 'c'].join(''); // 'abc'
[1, 2, 3].join(); // '1,2,3'
```

### `Array.prototype.copyWithin()`

  * Shallow copies part of an array to another location within the same array.
  * The target location must already contain an element (i.e. you cannot specify an undefiened index; `copyWithin` does not change the size of an array)

#### Parameters

  * A **target** index to which to copy the copied element to
    * If negative, it will be counted backwards from the end
    * If equal to or greater than `array.length`, nothing will be copied

  * An optional **start** index at which to start copying elements
    * If negative, it will be counted backwards from the end
    * If omitted, then it defaults to `0`

  * An optional **end** index before which to finish copying elements
  * If negative, it will be counted backwards from the end
  * If omitted, then it defaults to `array.length`

#### Return Value

  * The modified array.

#### Example

```JavaScript
['a', 'b' , 'c', 'd', 'e', 'f'].copyWithin(2); // ['a', 'b' , 'a', 'b' , 'c', 'd']
['a', 'b' , 'c', 'd', 'e', 'f'].copyWithin(2, 1); // ['a', 'b' , 'b' , 'c', 'd', 'e']
['a', 'b' , 'c', 'd', 'e', 'f'].copyWithin(2, 1, 3); // ['a', 'b' , 'b' , 'c', 'e', 'f']
```

### `Array.prototype.fill()`

  * Fills elements in an array with a static value

#### Parameters

  * The value with which to fill the array
  * An optional start index from which to begin filling. If omitted defaults to 0
  * An optional end index to fill up to (but not including). If omitted defaults to `array.length`

#### Return Value

  * The modified array

#### Example

```JavaScript
[0, 1, 2, 3, 4].fill('a'); // ['a', 'a', 'a', 'a', 'a']
[0, 1, 2, 3, 4].fill('a', 2); // [0, 1, 'a, 'a', 'a']
[0, 1, 2, 3, 4].fill('a', 2, 4); // [0, 1, 'a', 'a', 4]
```

### `Array.prototype.reverse()`

  * Reverses an array *in place*. The order of the array elements is reversed

#### Parameters

  * None. The method is called without parameters directly on the array to be reversed

#### Return Value

  * The modified array

#### Example

```JavaScript
[0, 1, 2, 3, 4].reverse(); // [4, 3, 2, 1, 0]
```

### `Array.prototype.toString()`

  * Returns a string representing the specified array and its elements

#### Parameters

  * None. The method is called without parameters directly on the array to be reversed

#### Return Value

  * A string representing the elements of the array, separated by commas

#### Example

```JavaScript
['a', 'b', 'c'].toString(); // 'a,b,c'
```

## Searching

### `Array.prototype.every()`

  * Determines whether all elements in the array pass a test implemented by a provided callback function

#### Parameters

  * A callback function to test each element. Takes three arguments:
    * The current element being processed in the array
    * An optional index for the current element being processed in the array
    * An optional array parameter, which is the array that the method was called on

  * An optional argument to use as `this` when executing a callback

#### Return Value

  * A boolean. `true` if every the function returns a truthy value for every element in the array, `false` otherwise

#### Example

```JavaScript
[1, 2, 3, 4, 5].every(function(num) {
  return num < 6;
}); // true

[1, 2, 3, 4, 5].every(function(num) {
  return num < 4;
}); // false

[1, 2, 3, 4, 5].every(num => num < 6); // true (with arrow functions)
```

### `Array.prototype.some()`

  * Determines whether at least one element in the array pass a test implemented by a provided callback function

#### Parameters

  * A callback function to test each element. Takes three arguments:
    * The current element being processed in the array
    * An optional index for the current element being processed in the array
    * An optional array parameter, which is the array that the method was called on

  * An optional argument to use as `this` when executing a callback

#### Return Value

  * A boolean. `true` if every the function returns a truthy value for at least one element in the array, `false` if none of the elements return a truthy value

#### Example

```JavaScript
[1, 2, 3, 4, 5].some(function(num) {
  return num > 6;
}); // false

[1, 2, 3, 4, 5].some(function(num) {
  return num > 4;
}); // true

[1, 2, 3, 4, 5].some(num => num > 6); // false (with arrow functions)
```

### `Array.prototype.includes()`

  * Determines whether an array includes a certain element

#### Parameters

  * The element to search for

#### Return Value

  * A boolean, `true` if the array contains the element, `false` otherwise

#### Example

```JavaScript
['a', 'b', 'c'].includes('a'); // true
['a', 'b', 'c'].includes('d'); // false
```

### `Array.prototype.find()`

  * Returns the value of the first element that satisfies a test provided by a callback function

#### Parameters

  * A callback function to test each element. Takes three arguments:
    * The current element being processed in the array
    * An optional index for the current element being processed in the array
    * An optional array parameter, which is the array that the method was called on

  * An optional argument to use as `this` when executing a callback

#### Return Value

  * The value of the first element to pass the test
  * `undefined` if no elements pass the test

#### Example

```JavaScript
[1, 2, 3, 4, 5].find(function(elem) {
  return elem > 3;
}); // 4

[1, 2, 3, 4, 5].find(function(elem) {
  return elem > 6;
}); // undefined

[1, 2, 3, 4, 5].find(elem => elem > 3); // 4 (using arrow functions)
```

### `Array.prototype.findIndex()`

  * Returns the index of the first element in the array that passes a test provided by a callback function

#### Parameters

* A callback function to test each element. Takes three arguments:
  * The current element being processed in the array
  * An optional index for the current element being processed in the array
  * An optional array parameter, which is the array that the method was called on

* An optional argument to use as `this` when executing a callback

#### Return Value

  * The index of the first element in the array that passes the test
  * `-1` if no elements pass the test

#### Example

```JavaScript
[1, 2, 3, 4, 5].findIndex(function(elem) {
  return elem > 3;
}); // 3

[1, 2, 3, 4, 5].findIndex(function(elem) {
  return elem > 6;
}); // -1

[1, 2, 3, 4, 5].findIndex(elem => elem > 3); // 3 (using arrow functions)
```

### `Array.prototype.indexOf()`

  * Returns the first index at which a given element can be found

#### Parameters

  * The element to search for
  * An option start index from which to begin searching
    * If equal to or greater than the array's length, `-1` is returned
    * If provided as a negative is taken as an offset from the end of the array. If the calculated negative index is less than `0`, then defaults to `0`

#### Return Value

  * The first index within the array at which the given element can be found
  * `-1` if the element is not found

#### Example

```JavaScript
[1, 2, 1, 2, 1, 2].indexOf(2); // 1
[1, 2, 1, 2, 1, 2].indexOf(3); // -1
[1, 2, 1, 2, 1, 2].indexOf(2, 2); // 3
```

### `Array.prototype.lastIndexOf()`

  * Returns the last index at which a given element can be found

#### Parameters

  * The element to search for
  * An option start index from which to begin searching
    * If equal to or greater than the array's length, `-1` is returned
    * If provided as a negative is taken as an offset from the end of the array. If the calculated negative index is less than `0`, then defaults to `0`

#### Return Value

  * The last index within the array at which the given element can be found
  * `-1` if the element is not found

#### Example

```JavaScript
[1, 2, 1, 2, 1, 2].lastIndexOf(2); // 5
[1, 2, 1, 2, 1, 2].lastIndexOf(3); // -1
[1, 2, 1, 2, 1, 2].lastIndexOf(1, 5); // -1
```

## Sorting, Filtering and Reducting

### `Array.prototype.filter()`

  * Creates a new array containing elements from the original array which pass a test provided by a callback function

#### Parameters

  * A callback function to test each element. Takes three arguments:
    * The current element being processed in the array
    * An optional index for the current element being processed in the array
    * An optional array parameter, which is the array that the method was called on

  * An optional argument to use as `this` when executing a callback

#### Return Value

  * A new array containing the elements that passed the test
  * returns an empty array if no elements pass the test

#### Example

```JavaScript
[1, 2, 3, 4, 5].filter(function(num) {
  return num > 3
}); // [4, 5]
[1, 2, 3, 4, 5].filter(function(num) {
  return num > 5
}); // []

[1, 2, 3, 4, 5].filter(num => num > 3); // [4, 5] (using arrow functions)
```

### `Array.prototype.reduce()`

  * Applies a function against an accumulator, and iterates through each element in the array from left to right to reduce it to a single value

#### Parameters

  * A callback function to execute on each element. Takes four arguments:
    * An accumulator. This accumulates the callback's return values. Its accumulated value is returned in the last invocation of the callback
    * The current element being processed in the array. This is the first element in the array if an initial value is provided, the second otherwise
    * An optional index for the current element being processed in the array. Starts at `0` if an initial value is provided, `1` otherwise
    * An optional array parameter, which is the array that the method was called on

  * An optional initial value to use as the first argument to the callback. If no initial value is provided then the first element of the array is used (if an empty array is reduced with no initial value, then an error is raised)

#### Return Value

  * The final value of the accumulator; i.e. the result of reducing all the values in the array according to the logic of the callback function

#### Example

```JavaScript
[1, 2, 3, 4, 5].reduce(function(total, num) {
  return total + num;
}); // 15

[1, 2, 3, 4, 5].reduce(function(total, num) {
  return total + num;
}, 10); // 25

[].reduce(function(total, num) {
  return total + num;
}); // TypeError

[].reduce(function(total, num) {
  return total + num;
}, 0); // 0

[1, 2, 3, 4, 5].reduce((total, num) => total + num); // 15 (using arrow function)
```

### `Array.prototype.reduceRight()`

* Applies a function against an accumulator, and iterates through each element in the array from right to left to reduce it to a single value

#### Parameters

  * A callback function to execute on each element. Takes four arguments:
    * An accumulator/ previous value. This accumulates the callback's return values. Its accumulated value is returned in the last invocation of the callback
    * The current element being processed in the array. This is the last element in the array if an initial value is provided, the second from last otherwise
    * An optional index for the current element being processed in the array. Starts at `array.length - 1` if an initial value is provided, `array.length - 2` otherwise
    * An optional array parameter, which is the array that the method was called on

  * An optional initial value to use as the first argument to the callback. If no initial value is provided then the last element of the array is used (if an empty array is reduced with no initial value, then an error is raised)

#### Return Value

* The final value of the accumulator; i.e. the result of reducing all the values in the array according to the logic of the callback function

#### Example

```JavaScript
['a', 'b', 'c', 'd', 'e'].reduceRight(function(accumulator, elem) {
  return accumulator + elem;
}); // 'edcba'

[].reduceRight(function(accumulator, elem) {
  return accumulator + elem;
}); // TypeError

[].reduceRight(function(accumulator, elem) {
  return accumulator + elem;
}, ''); // ''
```

### `Array.prototype.sort()`

  * Sorts elements of an array *in place*, according to logic defined by an optional callback function.

#### Parameters

  * An optional callback function used to define the sorting logic. If omitted, the default is string Unicode code points.
    * The compare function takes two arguments, the two elements being compared, and must return `0`, or an integer either greater than or less than `0`
      * Less than `0` if the first element is less than the second element
      * greater than `0` if the first element is greater than the second element
      * `0` if they are equal; i.e. the sort order between them is arbitrary

#### Return Value

  * The sorted array

#### Example

```JavaScript
['c', 'a', 'd', 'e', 'b'].sort() // ['a', 'b', 'c', 'd', 'e']

['c', 'a', 'd', 'e', 'b'].sort(function(a, b) {
  if (a > b) {
    return -1;
  } else if (a < b) {
    return 1;
  } else {
    return 0;
  }
}); // ['e', 'd', 'c', 'b', 'a']
```

## Adding, Removing, Slicing and Splicing

### `Array.prototype.pop()`

  * Removes the *last* element of an Array and returns it. Mutates the array.

#### Parameters

  * None. The method is called without parameters directly on the array.

#### Return Value

  * The removed element.
  * `undefined` if the array is empty

#### Example

```JavaScript
var arr = [1, 2, 3];
arr.pop(); // 3
arr; // [1, 2]
[].pop(); // undefined
```

### `Array.prototype.push()`

  * Adds one or more elements to the **end** of an array.

#### Parameters

  * One or more elements to be added to the array (comma separated)

#### Return Value

  * The new length of the array.

#### Example

```JavaScript
var arr = [1, 2, 3]
arr.push(4); // 4
arr; // [1, 2, 3, 4]
arr.push('a', 'b'); // 6
arr; // [1, 2, 3, 4, "a", "b"]
```

### `Array.prototype.shift()`

  * Removes the *first* element of an Array and returns it. Mutates the array.

#### Parameters

  * None. The method is called without parameters directly on the array.

#### Return Value

  * The removed element.
  * `undefined` if the array is empty

#### Example

```JavaScript
var arr = [1, 2, 3];
arr.shift(); // 1
arr; // [2, 3]
[].shift(); // undefined
```

### `Array.prototype.unshift()`

  * Adds one or more elements to the **start** of an array.

#### Parameters

  * One or more elements to be added to the array (comma separated)

#### Return Value

  * The new length of the array.

#### Example

```JavaScript
var arr = [1, 2, 3]
arr.unshift(4); // 4
arr; // [4, 1, 2, 3]
arr.unshift('a', 'b'); // 6
arr; // ["a", "b", 4, 1, 2, 3]
```

### `Array.prototype.slice()`

  * Creates a shallow copy of a portion of an array.

#### Parameters

  * An optional beginning index at which to begin extraction
    * If negative it is taken as an offset from the end of the array
    * If omitted, then defaults to `0`

  * An optional end index before which to end extraction
    * If negative it is taken as an offset from the end of the array
    * If omitted, defaults to `array.length`
    * If greater than `array.length` then defaults to `array.length`
    * If less than the start index, an empty array is returned

#### Return Value

  * A new array containing the extracted elements

#### Example

```JavaScript
[1, 2, 3, 4, 5].slice(1, 3); // [2, 3]
[1, 2, 3, 4, 5].slice(1, -1); // [2, 3, 4]
[1, 2, 3, 4, 5].slice(1); // [2, 3, 4, 5]
```

### `Array.prototype.splice()`

  * Removes existing elements and/ or adds new elements to an array

#### Parameters

  * An index at which to start changing the array.
    * If greater than the length of the array, then will be set to the length of the array
    * If negative it is taken as an offset from the end of the array. If the calculated index is less than `0` then it is set to `0`

  * An optional delete count, indicating teh number of items to remove
    * If omitted or larger than thenumber of elements from the start index to the end, then all the remaining elements are removed
    * If `0` or negative, no elements are removed (in this case at least one new element should be specified)

  * Zero or more optional new elements to add to the array, beginning at the start index. If omitted, `splice` will only remove elements

#### Return Value

  * An array containing the removed elements
    * If only one elements is removed, an array containing one element is returned
    * If no elements are removed, an emtpty array is returned

#### Example

```JavaScript
var arr = [1, 2, 3, 4, 5];
arr.splice(3); // [4, 5]
arr; // [1, 2, 3]

var arr = [1, 2, 3, 4, 5];
arr.splice(-4, 2); // [2, 3]
arr; // [1, 4, 5]

var arr = [1, 2, 3, 4, 5];
arr.splice(1, 3, 'a', 'b', 'c'); // [2, 3, 4]
arr; // [1, 'a', 'b', 'c', 5]

var arr = [1, 2, 3, 4, 5];
arr.splice(1, 0, 'a', 'b', 'c'); // []
arr; // [1, 'a', 'b', 'c', 2, 3, 4, 5]
```

## Iteration

### `Array.prototype.forEach()`

  * Executes a provided function once for each element in an array.

#### Parameters

  * A callback function to execute on each element. Takes three arguments:
    * The current element being processed in the array
    * An optional index for the current element being processed in the array
    * An optional array parameter, which is the array that the method was called on

  * An optional argument to use as `this` when executing a callback

#### Return Value

  * `undefined`

#### Example

```JavaScript
var arr = [1, 2, 3];

arr.forEach(function(elem) {
  console.log(elem);
}); // undefined

//logs
// 1
// 2
// 3
```

## Miscellaneous

### `Array.isArray()`

  * Determines whether the value passed is an Array

#### Parameters

  * The object to be checked

#### Return Value

  * A boolean; `true` if the object is an array, `false` otherwise

#### Example

```JavaScript
Array.isArray([]); // true
Array.isArray(new Array()); // true
Array.isArray(new Array('a', 'b', 'c', 'd')); // true
Array.isArray(new Array(3)); // true
Array.isArray(Array.prototype); // true

Array.isArray(); // false
Array.isArray({}); // false
Array.isArray(null); // false
Array.isArray(undefined); // false
Array.isArray(17); // false
Array.isArray('Array'); // false
Array.isArray(true); // false
Array.isArray(false); // false
```
