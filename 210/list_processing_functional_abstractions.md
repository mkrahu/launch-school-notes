# List Processing and Functional Abstractions

  * [Overview](#overview)
    * [Passing Functions as Arguments](#functions-as-arguments)
    * [Declarative Programming with Abstractions](#declarative-programming-abstractions)
    * [List Processing Abstractions](#list-procesing-abstractions)
      * [Iteration](#iteration)
      * [Filtering / Selection](#filtering)
      * [Transformation](#transformation)
      * [Reducing](#reducing)
      * [Interrogation](#interrogation)
      * [Sorting](#sorting)
    * [Combining Abstractions](#combining-abstractions)
    * [Functional Abstractions on Objects](#functional-abstractions-objects)
    * [Using Low-level Abstractions](#low-level-abstractions)

<a name='overview'></a>
## Overview

  * Functions are used to extract common functionality from multiple locations to a single location
  * Abstractions are coding patterns that reduce something to a particular set of essential characteristics
  * Functional abstractions therefore allow us to build specialized functions that fulfill a clear, specific, and abstract purpose
  * This allows us to write code at a higher level of abstraction since we can think in these abstractions when solving a coding problem rather than having to think imperatively
  * Some different types of abstraction are [listed here](https://martinfowler.com/articles/collection-pipeline/#op-catalog)

<a name='functions-as-arguments'></a>
## Passing Functions as Arguments

  * Since functions are first-class values in JavaScript, they can be stored in variables to be used later
  * As a result of this behaviour, we can pass functions as arguments to other functions; this allows you to compose programs combining multiple Functions and so build complex behaviour from simple pieces
  * Functions that only take data as arguments are pretty inflexible, since the only thing that someone using that funtion can control is the data passed to the function at execution
  * Functions that take other functions as arguments, are more flexible as they allow more choice at the point of execution; their functionality is not so limited by their implementation

Example:

This is a basic function that only takes data (in this case an array) as an argument. Here, the function parameters determine which array to iterate through, whereas the function's inherent behaviour determines how to iterate through the array and also what to do with each element.

```JavaScript
function iterate(array) {
  for (var i = 0; i < array.length; i++) { // for each element in the Array
    console.log(array[i]);                 // log the element to the console
  }
}
```

This next function takes another function, assigned to the callback parameter, as an argument. This allows us to defer some of the choice about how what the function does to the point of execution, and so allows the function to be used in a number of different ways.

Here, the function parameters determine which array to iterate through and also what to do with each element, whereas the function's inherent behaviour determines only how to iterate through the array.

```javascript
function iterate(array, callback) {
  for (var i = 0; i < array.length; i++) { // for each element in the Array
    callback(array[i]);                    // invoke callback and pass the element
  }
}
```

This alows us to separate the concerns of our original function into multiple abstractions with specific responsibilities.

```javascript
var count = [1, 2, 3, 4, 5];

function logger(number) {
  console.log(number);
}

iterate(count, logger);
// logs
1
2
3
4
5
```

  * Defining functions in this way allows us to build a program from multiple abstractions
  * In the second example above, there are two abstractions:
    * The first, `iterate()`, simply deals with iterating through an array
    * the second, `logger()` deals with logging values to the console.
  * By giving these functions specific responsibilities, and naming them appropriately, it allows us to think at a higher level in terms of individual abstractions

<a name='declarative-programming-abstractions'></a>
## Declarative Programming with Abstractions

### Imperative Style Programming

  * Imperative programming focusses on the *steps* or *mechanics* of solving a problem.
  * Each line of code has a purpose, but that purpose comes from understanding the developer's implementation
  * This can make the code difficult to read as you have to parse it line-by-line to understand what is happening

### Imperative Style Programming with Some Functional Abstractions

  * We can replace some our imperative code with functional abstractions
  * This makes it a bit easier to read as we can quickly determine what a particular piece of code is doing, or is supposed to do, just by the name of the function
  * By extracting the "how to do something" to a separate function, and focusing on "what we need to do," we raise the abstraction level of the program.

### Further Abstraction

  * As we replace more of our code with functional abstractions (perhaps using some of JavaScript's inbuilt abstractions) it raises the abstraction level even more
  * This allows us to express the solution more in terms of *what* we want to do rather than *how* exactly to do it
  * The resulting code is:
    * More readable, and more closely aligned to our mental model of the problem
    * More concise, since it uses less lines of code
    * Potentially more robust, if we use inbuilt abstractions instead of writing our own functions

### Declarative Programming

  * A declarative style deals more in terms of *what* you wnat to do than the specifics of *how* you want to do it.
  * This allows you to think at higher levels of abstraction and think more about solving a problem than the specific mechanics of how to implement a solution.
  * the higher the level of abstraction, the more declarative your code is.
  * In a sense, using a declarative style narrow the 'mental gap' between the 'problem solving' phase and the 'implementation' phase.
  * It also allows your code to communicate it's true intent

<a name='list-procesing-abstractions'></a>
## List Processing Abstractions

  * We can perform many operations on 'lists' of values
  * List processing operations are common Abstractions
  * We can group these operatins together based on their use case:
    * Iteration: Perform an operation on each element of an array
    * Filtering/ Selection: Select a subset of elements
    * Transformation: Compute a new value for each element
    * Ordering: Rearrange elements into a specific order
    * Reducing/ Folding: Iteratively compute a result based on all the element values
    * Interrogation: Determine whether all or some or none of the elements in a list meet a condition
  * JavaScript has built in Array methods for each of the above categories which take a Function as an argument.
    * The Function implements an abstractin of some sort, and the method invokes the function for each element in the array.
    * The developer defines **how** to implement the chosen abstraction.
    * Because the methods 'call back' the Function, we often refer to this function as a *callback*

<a name='iteration'></a>
### Iteration

  * Iteration is used to carry out an operation on each element in a list, such as an array
  * Iteration can be carried out using `for`, `while`, and `do...while` loops
  * JavaScript's `Array` prototype provides a method to carry out iteration: `forEach`
  * `forEach` invokes a callback function once for each element in an array
  * The callback takes three arguments:
    * The value of the current element
    * The index of the current element
    * The array being processed
  * `forEach` returns `undefined`. It must therefore have 'side effects' to be useful

  * [forEach Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach)

<a name='filtering'></a>
### Filtering / Selection

  * Filtering is the process of forming a new list containing a subset of the original list
  * JavaScript's `Array` prototype provides a method to carry out filtering: `filter`
  * `filter` takes a single argument, which should be a function
  * `filter` invokes the callback function once for each element in the array
  * The callback function has three arguments:
    * The value of the current element
    * The index of the current element
    * The array being processed
  * If the callback returns `true`, the element is included in the new array returned by `filter`, if `false` the element is excluded
  * `filter` returns a new array containing a subset of the elements in the original based on the condition imposed by the callback

  * [filter Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)

<a name='transformation'></a>
### Transformation

  * Transformation is the creation of a new list, with all of the elements in the original list changed in some particular way
  * JavaScript's `Array` prototype provides a method to carry out filtering: `map`
  * `map` takes a single argument: a callback function
  * `map` invokes the callback function once for each element in the array
  * The callback function has three arguments:
    * The value of the current element
    * The index of the current element
    * The array being processed
  * The values returned by the callback function become the elements in the new array
  * The return value of `map` is the new array with the transformed elements from the original array

  * [map Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)

<a name='reducing'></a>
### Reducing

  * Reducing combines the elements in a list in some way, often to produce a single value
  * JavaScript's `Array` prototype provides a method to carry out filtering: `reduce`
  * `reduce` takes a callback function, and an optional initial value as arguments
  * The callback function has four arguments:
    * An accumulator. This is the return value of the previous callback invocation (or the intial value on the first iteration)
    * The value of the current element
    * The index of the current element (if an initial value is specified, this starts at 0, otherwise it starts at 1)
    * The array being processed
  * The initial value is optional; if not passed, then teh first element of the array is used as the initial value
  * The values returned by the callback then becomes the accumulator
  * The return value of `recuce` is the return of the callback on the final invocation

  * [reduce Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce?v=a)

<a name='interrogation'></a>
### Interrogation

  * Interrogation lets you determine if any, all or none of the elements in a list satisfy a particular condition
  * JavaScript's `Array` prototype provides two methods to carry out interrogation: `some` and `every`
  * `every` iterates over all of the elements in the array until the callback returns a falsy value; `every` stops iteration and immediately return `false` when this happens. If `every` iterates over all the elements without the callback returning `false`, then the method returns `true`
  * `some` iterates over all the elments in the array until the callback returns a truthy value; `some` stops iteration and immediately return `true` when this happens. If `some` iterates over all the elements without the callback returning `true`, then the method returns `false`
  * The callback function used by `every` and `some` has three arguments:
    * The value of the current element
    * The index of the current element
    * The array being processed
  * The return value of `every` and `some` is a Boolean
    * `some` returns `true` if the callback returns a truthy value for *at least one* element in the array, and `false` otherwise
    * `every` returns `false` if the callback returns a falsy value for *at least one* element in the array, and `true` otherwise

  * [every Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every)
  * [some Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/some)

<a name='sorting'></a>
### Sorting

  * Sorting lets you rearrange the elements in a list from highest to lowest value, or lowest to highest, according to certain logic, e.g. which specifies how the values should be compared
  * JavaScript's `Array` prototype provides a method to carry out sorting: `sort`
  * `sort` performs an **in-place** sort of an array (that is, it mutates the array)
  * `sort` takes one argument, a comparison function callback, which determines the sort order between two elements being compared at a time
  * The callback function takes two arguments, `item1` and `item` two, which are the two elements from the array that are compared each time the function is invoked
  * the callback function should return either a numeric value either less than, greater than or equal to 0.
    * If less than 0, then `item1` comes after `item2` in sort order
    * if greater than 0, then `item2` comes after `item1` in sort order
    * If equal to 0, then sort order between `item1` and `item2` is not important and arbitrary

  * [sort Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort)

<a name='combining-abstractions'></a>
## Combining Abstractions

  * Abstractions such as iteration, filtering, reducing, etc. are useful tools for working with list/ collections.
  * Many problems will require more than one of these abstractions in order to be solved
  * The return value of one of these methods can be used as the input for another one; the return value of that operation can then be used as the imput value for a third, and so on.
  * When thinking about using mutliple list processing abstractions, it helps to think about the inputs and outputs of each step; in fact this often helps to clarify the overall strategy of your solution

<a name='functional-abstractions-objects'></a>
## Functional Abstractions on Objects

  * JavaScript doesn't have a set of list-processing methods for objects as it does for Arrays
  * You can use the `Object.keys()` method to work with objects at higher levels of abstraction
  * `Object.keys()` returns an array of an object's keys, which you can then work with as you would any other array
  * You can iterate over an object's keys using `forEach` and then use side effects to build up a new data structure

<a name='low-level-abstractions'></a>
## Using Low-level Abstractions

  * A top-down, abstraction-focused problem solving approach doesn't necessarily always yield the best results
  * Sometimes you will still need to work in a fairly imperative way, rather than a completely declarative one
  * In such cases you can still use lower-level abstractions such as basic looping structures
  * In cases where you need to return from a loop early, this approach is particulalry useful since (other than `some` and `every`), the list-processing array methods traverse the entire list; for example `forEach` will call the cllback on every element in an array, whereas a conditional statement can be used in a `for` loop so that it returns early and stops iteration if the condition is met.
