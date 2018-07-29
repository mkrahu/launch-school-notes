# Function Contexts and Objects

  * [JavaScript and First-class Functions](#first-class-functions)
  * [The Global Object](#global-object)
  * [Implicit and Explicit Function Execution Contexts](#implicit-explicit-contexts)
  * [Hard Binding Functions with Contexts](#hard-binding-contexts)
  * [Dealing with Context Loss](#context-loss)
  * [Summary of the `this` Keyword in JavaScript](#this)

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

  * The fact that a function's execution context is determined at the point of invocation means that care must be taken to ensure that we don't inadvertently change the context without intending to
  * There are various different situations where execution context can change and a function can 'lose' its original context
  * There are also a number of ways in which this 'context loss' can be dealt with, depending on the situation

### Methods losing context when taken out of an object

  * If you remove a method from its containing object and execute it, it loses its original context (the context instead becomes the global object)

**Example**

```
var myObj = {
  a: 1,
  myMethod: function() {
    console.log('The value of a is ' + this.a);
  }
};

var myFunc = myObj.myMethod; // this strips the function of its context
myFunc(); // 'The value of a is undefined'
```

  * You could use `call` or `apply` to restore the context, but if you don't want to execute the function right away or you need to pass it to another function, then `myObj` could be out of scope

**Example**

```
function callOtherFunction(func) {
  func.call(myObj); // myObj is out of scope
}

function foo() {
  var myObj = {
    a: 1,
    myMethod: function() {
      console.log('The value of a is ' + this.a);
    }
  };

  callOtherFunction(myObj.myMethod); // Strips context
}

foo(); // Uncaught ReferenceError: myObj is not defined
```

  * There are a couple of solutions to this situation:
    1. You could add an extra parameter to `callOtherFunction`, which represents the desired context.

**Example**

```
function callOtherFunction(func, context) {
  func.call(context);
}

function foo() {
  var myObj = {
    a: 1,
    myMethod: function() {
      console.log('The value of a is ' + this.a);
    }
  };

  callOtherFunction(myObj.myMethod, myObj); // Strips context
}

foo(); // 'The value of a is 1'
```

    2. You could hard bind the function to the object using `bind`.

```
function callOtherFunction(func) {
  func();
}

function foo() {
  var myObj = {
    a: 1,
    myMethod: function() {
      console.log('The value of a is ' + this.a);
    }
  };

  callOtherFunction(myObj.myMethod.bind(myObj)); // binds context
}

foo(); // 'The value of a is 1'
```

### Internal functons losing method context

  * Another situation where methods can lose context is when you have a function defined and then executed within a method call
  * In this situation, the context of the outer method **does not propogate** to the internal function. The context of the function in this case is the global object.

**Example**

```
var myObj = {
  myMethod: function() {
    function myFunc() {
      console.log(this);
    }

    myFunc(); // the execution context here is the global object, not myObj
  }
};

myObj.myMethod(); // [object Window]
```

  * There are a few solutions to this problem.

    1. Preserve context with a local variable in the lexical scope
      * You can store the value of `this` (i.e. the context object) top a variable named `self` or `that` before calling the function, and then reference that variable in the function

**Example**

```
var myObj = {
  myMethod: function() {
    var self = this;
    function myFunc() {
      console.log(self);
    }

    myFunc(); // the execution context here is still the global object, not myObj, but we have passed myObj to as the variable self to be used in myFunc
  }
};

myObj.myMethod(); // [object myObj]
```

    2. Explictly set the context when calling the function

**Example**

```
var myObj = {
  myMethod: function() {
    function myFunc() {
      console.log(this);
    }

    myFunc.call(this); // the execution context here is explicitly set to myObj using the this keyword
  }
};

myObj.myMethod(); // [object myObj]
```  

    3. Hard bind the context using a function expression
      * Note that to use `bind` you must use a function expression; a function declaration won't work.

**Example**

```
var myObj = {
  myMethod: function() {
    var myFunc = function() {
      console.log(this);
    }.bind(this);

    myFunc(); // the execution context has been hard bound to myObj, so however the function is executed, the context will always be myObj
  }
};

myObj.myMethod(); // [object myObj]
```

  * One advantage of using `bind` is that you can bind the function once and then call it as many times as you want without worrying about providing a context

### Function being used as an argument and so losing its surrounding context

  * A function passed as an argument to antoher function is called without an explicit context, which means its context is the global object.

**Example**

```
var myObj = {
  myMethod: function() {
    [1, 2, 3].forEach(function(number) {
      console.log(String(number) + ': ' + this); // the context of the function passed to forEach is the global object
    });
  }  
};

myObj.myMethod();

// 1: [object Window]
// 2: [object Window]
// 3: [object Window]
```

  * There are a few ways to deal with this issue

    1. Use a local variable in the lexical scope to store this

**Example**

```
var myObj = {
  myMethod: function() {
    var self = this;
    [1, 2, 3].forEach(function(number) {
      console.log(String(number) + ': ' + self);
    }); // the context of the function passed to forEach is still the global object, but myObj can be referenced from within the function using the self variable
  }  
};

myObj.myMethod();

// 1: [object myObj]
// 2: [object myObj]
// 3: [object myObj]
```

    2. Hard bind the function passed in as an argument to the surrounding context

**Example**

```
var myObj = {
  myMethod: function() {
    [1, 2, 3].forEach(function(number) {
      console.log(String(number) + ': ' + this);
      }.bind(this)); // the context of the function passed to forEach has been bound to myObj
  }  
};

myObj.myMethod();

// 1: [object myObj]
// 2: [object myObj]
// 3: [object myObj]
```

    3. Use the optional `thisArg` argument
      * Some methods, such as `forEach` allow an optional arguments that defines the context to use when executing the function passed in

**Example**

```
var myObj = {
  myMethod: function() {
    [1, 2, 3].forEach(function(number) {
      console.log(String(number) + ': ' + this);
    }, this); // the context of the function passed to forEach is set as MyObj by the thisArg argument
  }  
};

myObj.myMethod();

// 1: [object myObj]
// 2: [object myObj]
// 3: [object myObj]
```

<a name="this"></a>
## Summary of the `this` Keyword in JavaScript

  * As previously stated, `this` in JavaScript represents the execution context (i.e. the identity of the context object) at the point where a function is invoked
  * The way a function is invoked therefore affects the execution context. JavaScript has four function invoked types:
    * Function invocation
    * Method invocation
    * Constructor invocation
    * Indirect invocation

### Function Invocation

  * With standard function invocation, `this` is the Global object. In a browser environment this is the Window object

**Example**

```
function myFunc() {
  console.log(this);
}

myFunc(); // [object Window]
```

### Method Invocation

  * With method invocation, `this` is the calling object (i.e. the object to which the method belongs)

**Example**

```
var myObj = {
  myMethod: function() {
    console.log(this);
  }
}

myObj.myMethod(); // [object myObj]
```

  * If a method is extracted from an object and then invoked as a function, this is function invocation **not** method invocation. The execution context is therefore the gloabl object

**Example**

```
var myObj = {
  myMethod: function() {
    console.log(this);
  }
}

var myFunc = myObj.myMethod;
myFunc(); // [object Window]
```

### Constructor Invocation

  * Constructor invocation is performed when a function invocation is prepended by the `new` keyword.
  * Executing a function in this way creates a new object that is returned by the function
  * In this situation, the execution context of the function is the newly created object

**Example**

```
function myFunc() {
  console.log(this);
}

var myNewObj = new myFunc(); // [object myNewObj]
```

### Indirect Invocation/ Explicit Function Execution

  * Indirect Invocation is calling a function with an inherited method of the `Function` object that allows you to explicitly set the execution context of the function being invoked.
  * The methods of the `Function` object that allow you to do this are `call` and `apply`
  * When `call` or `apply` are used, the execution context of teh function is the first argument passed to those methods

**Example**

```
function myFunc() {
  console.log(this);
}

var myObj = {};

myFunc.call(myObj); // [object myObj]
myFunc.apply(myObj); // [object myObj]
```

### Other Changes to Execution Context

  * As well as being changed by the four function invocation types, the execution context of a function can be changed in other situations:
    * Hard binding of a function
    * use of Arrow Functions (ES6)

#### Hard Binding

  * A function can be bound to a particular object by use of the `bind` keyword.
  * In this situation, however the function is subsequently invoked (except for constructor invocation), the execution context is always the object to which it was bound
  * Note: you can't bind directly to a function declaration, only a function expression

**Example**

```
function myFunc() {
  console.log(this);
}

var myObj = {};

var someFunc = myFunc.bind(myObj);
someFunc(); // [object myObj]
```

#### Arrow Functions

  * Arrow functions are a syntax for declaring functions in JavaScript ES6
  * With arrow functions, the execution context is defined `lexically`. In other words, the context is is determined when the function is declared rather than at the point of execution.
  * An arrow function is bound to its lexical context

### Resources

  * [Gentle explanation of 'this' keyword in JavaScript](https://web.archive.org/web/20180209163541/https://dmitripavlutin.com/gentle-explanation-of-this-in-javascript/)
  * [JavaScript: The Keyword ‘This’ for Beginners](https://codeburst.io/javascript-the-keyword-this-for-beginners-fb5238d99f85)
