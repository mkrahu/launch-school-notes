# Function Contexts and Objects

  * [JavaScript and First-class Functions](#first-class-functions)
  * [The Global Object](#global-object)
  * [Implicit and Explicit Function Execution Contexts](#implicit-explicit-contexts)
  * [Hard Binding Functions with Contexts](#hard-binding-contexts)
  * [Dealing with Context Loss](#context-loss)
  * [The `this` Keyword in JavaScript](#this)

<a name="first-class-functions"></a>
## JavaScript and First-class Functions

  * Understanding function execution context is essential to understanding JavaScript
  * An important thing to understand is that JavaScript has *first-class functions*
    * A programming language is said to have First-class functions when functions in that language are treated like any other variable. For example, in such a language, a function can be passed as an argument to other functions, can be returned by another function and can be assigned as a value to a variable. [Source](https://developer.mozilla.org/en-US/docs/Glossary/First-class_Function)
    * First-class functions have no context when they are defined (i.e. the context is **not** determined lexically)
    * First-class functions receive their context when the program executes them
  * Since JavaScript is both an objiect-oriented language and a language with first-class functions, it must meet the requirements for both. In particular it must let the developer control the function execution context.

<a name="global-object"></a>
## The Global Object

  * JavaScript creates a **global object** when it starts running
  * The global object serves as the **implicit** execution context
  * In a browser, the global object is the code `window` object
    * In non-browser JavaScript environments, such as Node, the global object is not `window` but `global`. Other than that its behaviour remains the same
  * Global values, like `Infinity` and `NaN`, and global functions, like `isNan()` and `parseInt()`, are properties of the global object

**Example**

```
window.Infinity; // Infinity
window.isNaN; // function isNaN() { ... }
```

  * Like any other JavaScript object, you can add properties to the global object

**Example**

```
window.foo = 1;
window.foo; // 1
```

  * The global object is the implicit context when expressions are evaluated
  * If no explicit context is specified then the context is the global object

**Example**

```
foo = 1; // this is the same as executing window.foo = 1;
foo; // 1
window.foo; // 1
```

### Global Variables and Function Declarations

  * When we define global variables or functions, JavaScript adds them to the global object as properties

**Example**

```
var bar = 2;
function baz() {
  return 1;
}

window.bar; // 2
window.baz; // function baz() { return 1; }
window.baz(); // 1
```

  * This may seem identical to what happens if you don't define a variable, but there is an important difference
  * You can *delete* global variables that you don't define, but not those that you do

**Example**

```
var foo = 1;
moreFoo = 2;
function bar() { return 1; };
baz = function() { return 2; };

window.foo; // 1
window.moreFoo; // 2
window.bar; // function bar () { return 1; }
window.baz; // function baz () { return 2; }

delete window.foo; // false
delete window.moreFoo; // true
delete window.bar; // false
delete window.baz; // true

window.foo; // 1
window.moreFoo; // undefined
window.bar; // function bar () { return 1; }
window.baz; // undefined
```

<a name="implicit-explicit-contexts"></a>
## Implicit and Explicit Function Execution Contexts

  * Every time a JavaScript function is invoked, it has access to the object which is the **execution context** of that function invocation.
  * This object is accessible through the keyword `this`
  * A JavaScript function can be invoked in a variety of ways; which object `this` refers to depends on the how the function was invoked
  * The key thing to remember is that `this` (the execution context for a function) is **not** determined lexically, but instead by how the function is invoked. In other words, `this` is not determined at the point where the code is written, but at the point where the function is executed. The same function can be invoked in different ways to provide a different execution context

### Implicit Execution Context

  * The implicit execution context for a function (also called implicit binding), is the context for a function invoked without supplying an explicit context
  * In JavaScript this is the gloabl object (so `window` in a browser)
  * Binding a function to a context object occurs when you execute the function, not when you define it

**Example**

```
var object = {
  foo: function() {
    return 'this is ' + this;
  }
}

object.foo(); // "this is [object Object]"

bar = object.foo;
bar(); // "this is [object Window]"
```

  * The implicit execution context for a method call is the object which owns the method and thus calls the method at execution

**Example**

```
var foo = {
  bar: function() {
    return this;
  }
}

foo.bar() === foo; // true
```

  * If we add the function as a property of a different object, and then call the it as a method on that object, this changes the execution context

**Example**

```
var foo = {
  bar: function() {
    return this;
  }
}

var otherFoo = {};

otherFoo.baz = foo.bar;

otherFoo.baz() == foo; // false
otherFoo.baz() == otherFoo; // true
```

### Explicit Execution Context

  * JavaScript lets us use the `call` and `apply` methods to change a function's execution context at execution time
  * In other words we can *explicitly bind* a function's execution context to an object of opur choosing when we execute the function

**Example**

```
function whatIsThis() {
  return this;
}

var foo = {}
var otherFoo = {};

whatIsThis() === window; // true
whatIsThis.call(foo) === foo; // true
whatIsThis.apply(otherFoo) === otherFoo; // true
```

  * As well as the context object, both `call` and `apply` can take additional arguments
  * With `call`, those arguments are supplied as a list
  * With `apply`, the arguments are supplied as elements in an array

**Example**

```
someObject.someMethod.call(context, arg1, arg2, arg3..)

someObject.someMethod.apply(context, [arg1, arg2, arg3..])
```

<a name="hard-binding-contexts"></a>
## Hard Binding Functions with Contexts

  * The `call` and `apply` methods can be used to change a function's execution context at the point where it is executed
  * JavaScript also has a `bind` method. This method let's you **permanently** bind a function to a particular context object
  * Unlike `call` and `apply`, `bind` doesn't actually execute the function, instead it creates and returns a new function that is permanently bound to a given object
  * Since the binding is permanent, we can pass the function around without being worried that its context will change

**Example**

```
function whatIsThis() {
  return this;
}

var foo = {}
var otherFoo = {};

var boundWhatIsThis = whatIsThis.bind(foo); // permanently bind foo as the context object for boundWhatIsThis

whatIsThis() === window; // true
whatIsThis.call(foo) === foo; // true
whatIsThis.apply(otherFoo) === otherFoo; // true

boundWhatIsThis === window; // false
boundWhatIsThis === foo; // true

// even when we explicitly set the context using call or apply, the context remains foo
boundWhatIsThis.apply(otherFoo) == otherFoo; // false
boundWhatIsThis.apply(otherFoo) == foo; // true
```

<a name="context-loss"></a>
## Dealing with Context Loss

<a name="this"></a>
## The `this` Keyword in JavaScript
