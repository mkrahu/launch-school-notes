# Closures and Function Scope

  * [Closures and Functions](#clourses-functions)
  * [Higher Order Functions](#higher-order-functions)
  * [Closures and Private Data](#closures-privaate-data)
  * [Objects and Closures](#objects-closures)
  * [How Closures Affect Garbage Collection](#garbage-collection)
  * [Partial Function Application](#partial-function-application)
  * [Immediately Invoked Function Expressions (IIFEs)](#iife)

<a name="clourses-functions"></a>
## Closures and Functions

  * The `function` keyword creates JavaScript Functions
  * This can either be done using a function declaration or a function Expressions

**Example**

```
// function declaration
function myFunc() {
  // function body
}

// function expression
var myFunc = function() {
  // function body
}
```

  * Function expressions are useful when passing a function to another function as an argument
  * All functions, regardless of syntax used, obey the same lexical scoping rules:
    * They can access variables defined within the function
    * They can access variables that were in scope based on the context where the function was **defined**. This is known as its closure
  * The closure is a combination of the function and the lexical environment within which that function was declared
  * The closure retains references to everything that was in scope when the closure was created, and retains those references for as long as the closure exists. This means the Function can access those references whenever it is invoked
  * See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures) for more information on JavaScript closures

<a name="higher-order-functions"></a>
## Higher Order Functions

  * Functions in JavaScript are first class functions. This mean that they can be assigned to variables and passed around just like any other value.
  * The fact that JavaScript supports first class functions means that we can create Higher Order Functions. These are functions that work with other functions
  * To be classed as a Higher Order Function, a function must either take a function as an argument, return a function, or both

**Example**

```
// function passed in as an argument
[1, 2, 3].forEach(function(number) {
  console.log(number);
});

// function as a return value
function stringLogger(string) {
  return function() {
    console.log(string);
  };
}

var helloLogger = stringLogger('hello');
helloLogger(); // log 'hello'
```

<a name="closures-privaate-data"></a>
## Closures and Private Data

  * Functions *close over* the context at their definition point to create a **closure**.
  * They always have access to that context, regardless of when and where in the program the function is invoked
  * This fact can be leveraged to create *private data* that is accessible by the function but not by any other means

**Example**

```
function makeCounter() {
  var count = 0;
  return function() {
    count += 1;
    console.log(count);
  };
}

// the function returned by makeCounter has access to the count variable in its lexical scope at declaration. It can therefore increment and log the value of count
var counter = makeCounter();
counter(); // 1
counter(); // 2
counter(); // 3

// however, the count variable isn't accessible in any other way. It is effectively private data
console.log(count); // ReferenceError: count is not defined
console.log(counter.count); // undefined: count is not a property of the counter function, but a variable it has access to from its closure
```

  * Note that the variable `count` is only declared when the function `makeCounter` is executed.
  * If we execute the function again as new variable `count` is declared, separate from the first variable count

**Example**

```
function makeCounter() {
  var count = 0;
  return function() {
    count += 1;
    console.log(count);
  };
}

var counter = makeCounter();
var counter2 = makeCounter();

// counter and counter2 btoh have access to a count variable, but these are not the same count variable
counter(); // 1
counter(); // 2
counter(); // 3

counter2(); //1
counter2(); //2
```

<a name="objects-closures"></a>
## Objects and Closures

  * Instead of returning a function from a function, we can return an object
  * This object can have its own methods, creating a clearer and more flexible interface
  * The object can still have access to private data in the form of variables that are declared outside of the object, but that were in scope when the object was declared

**Example**

```
function objectMaker() {
  var myVar = 1;
  return {
    getVar: function() {
      return myVar;
    }
  };
}

var myObj = objectMaker(); // myObj assigned to object returned by objectMaker

// the getVar method of myObj can access the private data
myObj.getVar(); // 1

// but myVar can't be directly accessed
myVar; // Uncaught ReferenceError: myVar is not defined
myObj.myVar; // undefined (since myVar is not a property of MyObj, it is a varaible  in its closure)
```

  * Using closures to restrict data access is a good way to force other developers to use the intended interface (i.e. to access the dara via the provided methods)
  * This restriction helps protect data integrity and prevent unauthorised modification of the data
  * These benefits have a cost. For example, making data provite can make it harder to extend the code

<a name="garbage-collection"></a>
## How Closures Affect Garbage Collection

  * Garbage collection is a function of some programming languages that automatically frees up allocated memory once it is no longer required
  * The way that garbage collection (GC) determines whether memory is no longer required has evolved and become more advanced over time. Most modern programming languages that implement garbage collection do so using a mark and sweep algorithm. This algortihm determines if an object is still reachable in some way (e.g. it is referenced by a variable still in use, or exists in a closure); if it is not then it is marked for collection.
  * See the [MDN docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management) for more information on how GC works in JavaScript.

### Closures and GC

  * When you create a closure, it stores a reference to all the varaibles it can access at the point it was created
  * Theoretically, as long as the closure exists the primitives and objects assigned to the variables it references must be stored in memory (i.e. they cannot be garbage collected)
  * In practice, using closures can create situations where values should not be garbage collected but might be. See this [Stack Overflow post](https://stackoverflow.com/questions/24468713/javascript-closures-concerning-unreferenced-variables) for an example scenario.

**Example**

```
function myFunc() {
  var a = "some string";
  var b = "another string"

  return function() {
    console.log(a);
  };
}

var someVar = myFunc();
```

  * In the above example, when `myFunc` is called it returns a function that has `a` and `b` in its closure, however it only ever accesses `a`. In theory, as long as `someVar` exists, both `"some string"` and `"another string"` should be kept around since they referenced by variables in its closure, but in practice most JavaScript engines are clever enough to decide that `"another string"` is not required since it can never be accessed, and so can be garbage collected.

<a name="partial-function-application"></a>
## Partial Function Application

  * Partial Function Application is essentially creating functions that already have some of the arguments pre-set.
  * It uses a function that returns a new function which calls a third function that the initial function receives as an argument
  * This initial function also receives some of the third function's arguments. These arguments remain accessible to the third function because they are part of its closure

**Example**

```
function add(num1, num2) {
  return num1 + num2;
}

function creator(func, arg) {
  return function(funcArg) {
    return func(arg, funcArg);
  }
}

var add2 = creator(add, 2);
add2(3); // 5
```

  * In the example above, the call to `creator` returns a function that takes a single argument `funcArg`, and has `func` (in this case the function `add`) and `arg` (in this case the number `2`) in its closure.
  * The returned function is assigned to the variable `add2`, which when called as a function, takes the argument `3` and executes the `add` function from its closure with the number assigned to `arg` as the first argument to `add` and the number passed in to `add2` as the second argument to `add`.

### Partial Function Application and `bind`

  * In the example above, you could say that this works because the initial function passed in and the pre-set argument are *bound* to the returned function vai its closure.
  * It is actually possible to use `Function.prototype.bind` for Partial Function Application

**Example**

```
function add(num1, num2) {
  return num1 + num2;
}

var add2 = add.bind({}, 2); // the object that we bind to is irrelevant since we don't reference this
add2(3); // 5
```

  * In the example above, we use `bind` to return a copy of the `add` function that is permantly bound to some arbitrary object and also to the argument `2`
  * This returned function is assigned to the variable `add2` which, when called as a function, calls `add` but with the first argument `2` already bound to it

<a name="iife"></a>
## Immediately Invoked Function Expressions (IIFEs)

  * An IIFE is a function that we define and invoke simultaneously
  * Adding parentheses around the function definition makes it explicit that we want to parse the function as an expression
  * Adding parentheses at the end of the function expression immediately invokes it as a function

**Example**

```
(function() {
  console.log('hello');
})(); // logs 'hello'
```
  * An alternative syntax has the parentheses for the argument list inside the outer set of parntheses

**Example**

```
(function() {
  console.log('hello');
}()); // logs 'hello'
```

  * IIFEs can take arguments like any other function

**Example**

```
(function(word) {
  console.log(word);
})('goodbye'); // logs 'goodbye'
```

  * The outer parentheses can be omitted when a function definition is an expression that doesn't occur at the beginning of a line

**Example**

```
var foo = function() {
  return 'hello';
}();

console.log(foo);
```

  * In the example above, since the function being assigned to `foo` is already part of a function expression we can omit the outer parentheses. Adding the argument parentheses list at the end of the function declaration immediately invokes the function and it is the return value that is assigned to `foo`, not the function itself.

### Creating a Private Scope with an IIFE

  * Since functions create a private scope, and since immediately invoking a function as an IIFE means we don't need to name it, IIFEs can be used to isolate some code from the rest of the code base.
  * This can be useful if you need to run some code in a code base and you don't know if a particular name has already been used for a variable or function elsewhere in the codebase

**Example**

```
// lots of unknown code

(function() {
  // function body
})();

// lots of unknown code
```

  * The IIFE pattern provides a way to create a 'module' of sorts.
