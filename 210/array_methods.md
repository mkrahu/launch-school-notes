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

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.some()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.includes()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.find()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.findIndex()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.indexOf()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.lastIndexOf()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

## Sorting, Filtering and Reducting

### `Array.prototype.filter()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.reduce()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.reduceRight()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.sort()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

## Adding, Removing, Slicing and Splicing

### `Array.prototype.pop()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.push()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.shift()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.unshift()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.slice()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

### `Array.prototype.splice()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

## Iteration

### `Array.prototype.forEach()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```

## Miscellaneous

### `Array.isArray()`

  * Description

#### Parameters

  *

#### Return Value

  *

#### Example

```JavaScript

```
