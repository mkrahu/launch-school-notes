# Objects

  * [Overview](#overview)
    * [Standard Built-in Objects](#built-in-objects)
    * [Creating Custom Objects](#custom-objects)
    * [Properties](#properties)
      * [Accessing Property Values](#property-values)
      * [Adding and Updating Properties](#adding-updating-properties)
      * [Stepping through Object Properties ](#stepping-through-properties)
    * [Methods](#methods)
    * [A Note on Style](#style)
  * [Arrays and Objects](#arrays-objects)
    * [Arrays are Objects](#arrays-are-objects)
    * [Using Object Operations with Arrays](#object-opertions-with-arrays)
  * [Mutability of Values and Objects](#mutability)
  * [Pure Functions and Side Effects](#pure-functions-side-effects)
  * [The Math Object](#math-object)
  * [The Date Object](#date-object)
  * [Working with the Function Arguments Object](#function-arguments-object)

<a name='overview'></a>
## Overview

  * JavaScript is an object-oriented language
  * JavaScript programs use objects to organise code and data
  * Typically, data values and the functions that operate on those values are part of the same object

<a name='built-in-objects'></a>
### Standard Built-in Objects

  * JavaScript provides built in objects, e.g `String`, `Array`, `Object`, `Math`, `Date`.
  * Technically JavaScript has both *primitive* and *object* strings
  * When you apply a method to a primitive, JavaScript automatically converts it to an object

Example:

```JavaScript
a = 'hi';                         // Create a primitive string with value 'hi'
typeof a;                         // "string", this is a primitive string value

var stringObject = new String(a); // Convert the primitive to an object
typeof stringObject;              // "object", this is a String object

stringObject.toUpperCase();       // Call the method on the object: "HI"
```

<a name='custom-objects'></a>
### Creating Custom Objects

  * Custom objects can be created for programs where the standard built-in objects are insufficient
  * Custom objects can be created using:
    * The object literal notation
    * With a constructor function, e.g. `new String('foo')`
    * Using the `Object.create()` method

Example:

```JavaScript
// creating an object using the object literal notation

var myObject = {};

typeof myObject; // 'object'
```

  * Objects are containers for two things: data and behaviour
  * Data consists of named items with values. The values represent the attributes of the object and are referred to as **properties**
  * Functions define the behaviour of an object. When they are part of an object we call them **methods**

<a name='properties'></a>
### Properties

  * A property name can be any valid string
  * A property value can be any valid expression

Example:

```javascript
var myObject = {
  name: 'Karl',                 // name is a string with quotes omitted
  'age': 42,                    // property name with quotes
  'favourite colour': 'green',  // two word string as a property name
  languages: {                  // object as a property value
    a: 'English',
    b: 'French',
  },
  greeting: function() {         // function expression as property value
    return 'hello';
  },
};
```

<a name='property-values'></a>
#### Accessing Property Values

  * You can access property values using 'dot notation' or 'bracket notation'
  * JavaScript style guides usually recommend dot notation when possible

Example:

```JavaScript
myObject.name; // 'Karl'. Using dot notation
myObject['age'];  // 42. Using bracket notation
myObject.height; // undefined when property is not defined
myObject.languages.a; // 'English'. Dot notation can be chained to access properties in nested objects
myObject.greeting(); // 'hello'. Calling the method 'greeting'
```

<a name='adding-updating-properties'></a>
#### Adding and Updating Properties

  * To add a new property to an object, use dot notation or bracket notation along with the assignment operator
  * If the named property already exists, the assignment updates the property's value
  * The reserved keyword `delete` can be used to delete properties from objects

Examples:

```javascript
myObject.height = '178cm';
myObject.height; // '178cm'
myObject['weight'] = '76kg';
myObject['weight']; // '76kg'

myObject.weight = '74kg';
myObject.weight; // '74kg'

delete myObject.weight;
myObject.weight; // undefined
```

<a name='stepping-through-properties'></a>
#### Stepping through Object Properties

  * Objects are a collection type and so a single object can store multiple values
  * This means youcan 'step through' all of the objects properties and perform a common task for each organise
  * You can also retrieve an array of all the names of the properties of an object with the `Object.keys()` methods

Examples:

```javascript
var country;

var countriesAndCapitals = {
  'France': 'Paris',
  'Germany': 'Berlin',
  'Spain': 'Madrid',
}

for (country in countriesAndCapitals) {
  console.log(country);
  console.log(countriesAndCapitals[country]);
}

// logs:
'France'
'Germany'
'Spain'
'Paris'
'Berlin'
'Madrid'

Object.keys(countriesAndCapitals); // ['France', 'Germany', 'Spain']
```

<a name='methods'></a>
### Methods

  * To call a method on an object, you access the method as though it is a property (which it effectively is), and appending parentheses
  * You can pass arguments to the method by listing them between the parentheses
  * We can think of JavaScript methods as functions that are specific to an object (with some added behaviours)

Examples:

```javascript
(5.234).toString();       // '5.234'
'pizza'.match(/z/);       // [ 'z', index: 2, input: 'pizza' ]
Math.ceil(8.675309);      // 9
Date.now();               // 1467918983610
```

<a name='style'></a>
### A Note on Style

  * Custom objects that use object literal notation always use a trailing comma when written across multiple lines
  * This means the last property or method of an object ends in a comma
  * The benefits of this are:
    * When changing the position of a property or method, you just have to move it to its new position without worrying about adding or removing commas
    * Without a trailing comma, adding a property shows as 2 lines of change when running `git diff` (adding the line, and adding a comma tothe previous line)
  * For simple one-line literals, you don't need the trailing comma

Examples:

```javascript
var objectOne = {
  prop1: 'a',
  prop2: 'b',
};

var objectTwo = { prop1: 'x', prop2: 'y' };
```

<a name='arrays-objects'></a>
## Arrays and Objects

  * JavaScript uses Arrays and Objects to represent compund data
    * Arrays should be used if you need to maintain data in a specific order, e.g. if the data is like a list that contains many items (often of the same type, although the types can be different)
    * Objects should be used to contain data that is more like an 'entity' with many parts, and if it makes sense to retrieve values based on the names of teh keys assocaited with those values

<a name='arrays-are-objects'></a>
### Arrays are Objects

  * Although Arrays and Objects can fit different use-cases, arrays are actually objects

Example:

```javascript
var a = [1, 2, 3];

typeof a // 'object'
a['0']; // 1
Object.keys(a); // ['0', '1'] The array indices are the keys of the object
```

  * Although an array is an object, it displays specific behaviours in terms of its properties
  * If you add a property to an array object that is not a non-negative integer, the that property does not form part of the array's **elements**
  * The length of an array is calculated as one higher than property with the highest non-negative integer value (i.e. one more than the highest index)

Examples:

```javascript
var myArray = [1, 2, 3];
myArray.length         // returns 3
myArray['-1'] = 4;
myArray.length         // returns 3
myArray['-1'];         // returns 4
myArray['foo'] = 'bar';
myArray['foo'];       // return 'bar'
myArray.length        // returns 3
myArray;              // [1, 2, 3]
myArray['5'] = 4;
myArray.length        // returns 6
myArray;              // [1, 2, 3, undefined × 2, 4]
```

<a name='object-opertions-with-arrays'></a>
### Using Object Operations with Arrays

  * Since arrays are objects, you can use object operations such as `in` and `delete` on arrays. Doing so, however, can introduce cnfusion and lead to surprising results
  * You should use more idiomatic ways to acomplish the same tasks

Examples:

```
// using in to see if an Object contains a specific key:
0 in []; // false
0 in [1]; // true

// Although the above works, it doesn't necessarily make the intent of the code clear
// A more idiomatic solution would be to check if an index is less than the array's length:
var numbers = [4, 8, 1, 3];
2 < numbers.length;          // true
```

  * Although you can use `delete` on Arrays, it isn't usually a good idea
  * If you need to remove a value from an Array, use `Array.prototype.splice` instead of `delete`

<a name='mutability'></a>
## Mutability of Values and Objects

  * Some values in JavaScript are *primitive* types: strings, numbers, booleans, `null`, and `undefined`
  * One distinction between primitve values and Objects is their *mutability*
    * Primitive values are *immutable*; you cannot modify them. Operations on primitive values return **new** values of the same type
    * Objects are *mutable*; you can modify them without changing their identity. Objects contain other data inside themselves; it's this 'inner' data that you change

<a name='pure-functions-side-effects'></a>
## Pure Functions and Side Effects

  * Functions can modify external values, either by directly modifying variables defined in outer scopes, or mutating objects passed to functions as arguments.
  * Changes to values that exist outside of the function can be referred to as **side effects**
  * When a function doesn't have any side effects, it is known as a **pure function**
  * Pure functions use their arguments only to determine their *return value*, not to modify any values that exist outside of the function
  * If you use a function for its return value, you usually want to call the function as part of an expression, or as the right hand side of an assignment
  * If you use a function for a side effect, it is good practice to pass the variable(s) you want to mutate as (an) argument(s)

<a name='math-object'></a>
## The Math Object

  * The `Math` object has a number of useful properties and methods that can be used in JavaScript programs
  * An explanation of these properties and methods are available in the [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math)
  * Some of the more commonly used properties and methods are:
    * [Math.PI](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/PI). This property represents the ratio of the circumference of a circle to its diameter, approximately 3.14159
    * [Math.abs()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs). This method return the absolute value of a number; e.g. `Math.abs(-4)` will return `4`
    * [Math.sqrt()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sqrt). This method feturns the square root of a number; e.g. `Math.sqrt(9)` will return `3`.
    * [Math.pow()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/pow). This method takes two arguments, the `base` and the `exponent`, and returns the base to the power of the exponent; e.g. `Math.pow(2, 2)` will return `4`.
    * [Math.round()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round). This method returns the value of a number rounded to the nearest integer. If the fractional portion of the argument is greater than 0.5, the argument is rounded to the integer with the next higher absolute value. If it is less than 0.5, the argument is rounded to the integer with the lower absolute value.  If the fractional portion is exactly 0.5, the argument is rounded to the next integer in the direction of +∞; e.g. `Math.round(4.5)` will return `5`, `Math.round(-4.5)` will return `-4` (rather than `-5` as it might in some other languages).
    * [Math.ceil()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/ceil). This method returns the smallest integer greater than or equal to a given number; e.g. `Math.ceil(1.1)` will return `2`.
    * [Math.floor()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/floor). This method returns the largest integer less than or equal to a given number; e.g. `Math.floor(1.9)` will return `1`
    * [Math.random()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random). This method returns a floating-point, pseudo-random number in the range `[0, 1]`; that is form `0` (inclusive) up to but not including `1`. You can then scale this value to your desired range.

Example use of `Math.random()`:

```javascript
// Getting a random integer between two values
function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
}

// Getting a random integer between two values, inclusive
function getRandomIntInclusive(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min; //The maximum is inclusive and the minimum is inclusive
}
```

<a name='date-object'></a>
## The Date Object

  * The `Date` object has a number of useful properties and methods that can be used in JavaScript programs
  * `Date` objects are based on a time value that is teh number of milliseconds since 1 January, 1970 UTC.
  * An explanation of these properties and methods are available in the [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date)
  * A `Date` object can be created with the following syntax:

```javascript
new Date();
new Date(value);
new Date(dateString);
new Date(year, month[, date[, hours[, minutes[, seconds[, milliseconds]]]]]);
```

  * `value` is an integer value representing the number of milliseconds since 1 January 1970 00:00:00 UTC.
  * `dateString` is a String value representing a date. The string should be in a format recognised by the `Date.parse()` method.
  * `year` is an integer value representing the year. Values from 0 to 99 map to 1900 to 1999
  * `month` is an integer value from 0 (for January) to 11 (for December) representing the month
  * `date`, `hours`, `minutes`, `seconds`, and `millisecond` are all optional integer values representing a day of the month (in the case of `date`) or a segment of time.
  * If no arguments are provided, the constructor creates a JavaScript date object for the current date and time according to system settings.
  * **Note:** `Date` objects can only be instantiated by calling `Date()` as a constructor (i.e. by using the `new` keyword). Calling it as a regular function (without `new`) will return a string rather than a `Date` object.

Examples:

```javascript
var today = new Date();
var birthday = new Date('December 17, 1995 03:24:00');
var birthday = new Date('1995-12-17T03:24:00');
var birthday = new Date(1995, 11, 17);
var birthday = new Date(1995, 11, 17, 3, 24, 0);
```

  * Some of the more commonly used properties and methods of `Date` are:
    * [`Date.prototype.getDay()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getDay). This method returns the day of the week for the specified date according to local time, where 0 represents Sunday. It returns an integer value from 0 (Sunday) to 6 (Saturday).
    * [`Date.prototype.getDate()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getDate). This method returns the day of the month for the specified date according to local time. The return value is an integer between 1 and 31.
    * [`Date.prototype.getMonth()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getMonth). This method returns the month in the specified date according to local time, as a zero based value. The return value is an integer between 0 (January) and 11 (December).
    * [`Date.prototype.getFullYear()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getFullYear). This method returns the year of the specified date according to local time. Note, this method should be used rather than `Date.prototype.getYear()`, which is deprecated (because it does not return full years, it incorrectly maps years greater or equal to 2000)
    * [`Date.prototype.getTime()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime). This method returns the numeric value corresponding to the time for the specified date according to universal time. The return value is a number representing the milliseconds elampsed between 1 January 1970 00:00:00 UTC and the given date.
    * [`Date.prototype.getHours()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getHours). This method the hour for the specified date, according to local time. The return value is an integer between 0 and 23.
    * [`Date.prototype.getMinutes()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getMinutes). This method returns the minutes in the specified date according to local time. The return value is an integer between 0 and 59.
    * [`Date.prototype.setDate()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/setDate). This method sets the day of the `Date` object relative to the beginning of the currently set month. It takes one parameter, an integer representing the day of the month.
    * [`Date.prototype.toDateString()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toDateString). This method returns the date portion of a `Date` object in human readable form.

<a name='function-arguments-object'></a>
## Working with the Function Arguments Object

  * Functions in JavaScript handle arguments in a particular way:
    * They set the value for any missing arguments as `undefined`
    * They ignore any excess arguments
  * This means that when defining a Function you must know how many arguments will be passed to it
  * The JavaScript `arguments` object lets you circumvent this limitation
  * The `arguments` object is an Array-like local variable that is available inside all Functions. It contains all the arguments passed to the Function, no matter how many are provided or how many parameters the Function's definition includes.

Example:

```javascript
function logArgs(a) {
  console.log(arguments[0]);
  console.log(arguments[1]);
  console.log(arguments.length);
}

logArgs(1, 'a');

// logs:
1
a
2
```

  * We can, for example, use `arguments` to create Functions that can take any number of arguments.

Example:

```javascript
function sum() {
  var result = 0;
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i];
  }

  return result;
}

sum();                // 0
sum(1, 2, 3);         // 6
sum(1, 2, 3, 4, 5);   // 15
```

  * **Note:** the Function definition doesn't list any arguments at all, which makes it slightly difficult to read and understand. ES6 fixes this problem with its [rest syntax](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Functions/rest_parameters) `(...args)`.  

  * Although `arguments` is 'Array-like' (in that you can access the arguments based on their index position, and it has a `length` method) it is not an actual Array.
  * You can convert `arguments` to an Array in the following way:

```javascript
var args = Array.prototype.slice.call(arguments);
```
