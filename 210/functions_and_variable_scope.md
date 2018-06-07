# Functions and Variable Scope

  * [Defining Functions](#defining-functions)
  * [Function Invocations and Arguments](#invocations-arguments)
  * [Nested Functions](#nested-functions)
  * [Functional Scopes and Lexical Scoping](#lexical-scoping)
  * [Function Declarations and Function Expressions](#declarations-function-expressions)
  * [Hoisting](#hoisting)

<a name="defining-functions"></a>
## Defining Functions

  * **Procedures** in programming let you extract common code to one place so that you can use it anywhere in your program
  * Procedures in JavaScript are known as functions
  * Functions must be declared before being used
  * A function declaration consists of:
    * The `function` keyword
    * The name of the function
    * A list of comma-separated parameters
    * A block of statements (the function body)

Example:

```javascript
function triple(number) {
  console.log('tripling in process...');
  return number + number + number;
}
```

### Function Return Value

  * The `return` statment specifies the value returned by the function
  * If the function does not contain an explicit return or the return statement does not include a value, the function implicitly returns `undefined`

### Parameters vs Arguments

  * The function defintion has *parameters*. For example we can say that a defined function 'takes' parameters, which are represented by variables in the parameter list
  * The actual values passed to the function at invocation are called *arguments*

Example:

```javascript
// here, a and b are parameters within the function declaration

function multiply(a, b) {
  return a * b;
}

// here, 5 and 6 are arguments to the function

multiply(5, 6);
```

  * During execution, JavaScript makes arguments passed to the function available to the function as local variables with the same names as the function's parameters
  * Within the fucntion body these are referred to as local variable arguments

<a name="invocations-arguments"></a>
## Function Invocations and Arguments

  * The standard way to invoke a function is to append `()` to its name
  * Function names in JavaScript are just local variables that happen to have a function as a value
  * Since function names are local variables, we can assign them to new local variables and call them using that new name

Example:

```javascript
function greeting() {
  console.log('Hello');
}

greeting(); // logs Hello

var hello = greeting;
hello(); // logs Hello
```

  * Many functions require parameters to fulfil their purpose
  * When calling a function we call these values arguments
  * If we don't provide the same number of arguments to the method call as are in the Function's declaration, then the missing parameters have a value of `undefined`
  * Calling a function with too few arguments *does not* raise an error
  * You can also pass more arguments to a function than it expects; additional arguments are simply ignored

<a name="nested-functions"></a>
## Nested Functions

  * You can nest functions inside other functions

Example:

```javascript
function circumference(radius) {
  function double(number) {  // nested function:
    return 2 * number;
   }

  return 3.14 * double(radius);  // call the nested function
}
```

  * There's no hard limit on how deep you can nest functions in JavaScript

<a name="lexical-scoping"></a>
## Functional Scopes and Lexical Scoping

  * A variable's scope is the part of the program that can access that variable by name
  * In JavaScript, every function creates a new variable scope

### The Global Scope

  * Very small JavaScript programs with no functions exist entirely within a single scope

Example:

```javascript
var name = 'Karl';
console.log(name);

for (var i = 0; i < 3; i++) {
  console.log(name);
}

console.log(name);
```

  * This program logs the String 'Karl' to the console five times
  * The variable is available everywhere in this program, both outside and inside of the `for` loop

### Function Scope

  * Functions inherit access to all varaibles in all surrounding scopes
  * this works no matter how deeply a function is nested

Example:

```javascript
var name = 'Karl';

function greet() {
  console.log(name);
}

greet(); // logs 'Karl'

function another_greet() {
  function say() {
    console.log(name);
  }

  say();
}

another_greet(); // logs 'Karl'
```

### Closures

  * When we define a function it retains access to, or *closes over*, the variable scope currently in effect
  * This is referred to as 'creating a closure'
  * A closure retains reference to everything in its scope when the closure is created, and retains those references for as long as the closure exists
  * This means a function can still access those references wherever we invoke the Function
  * The value of a variable can change *after* creating a closure tha includes the varaible; when this happens, the closure sees the new value, not the old one

Example:

```javascript
var count = 1;

function logCount() { // declaring the function creates a closure that includes the count variable
  console.log(count);
}

logCount(); // logs 1

count = 2; // reassign count
logCount(); // closure sees new value for count and logs 2
```

  * The variables that the closure retains access to are references to the values, not the actual values themselves

### Lexical Scoping

  * JavaScript uses *lexical scoping* to resolve variables
  * The structure of the code defines the scope
  * At any point in a JavaScript program, there is a hierarchy of scopes from local up to global
  * When JavaScript encounters a varaible it searches the hierarchy from bottom to top and stops at the first variable declaration it finds with a matching name
  * Variables in a 'lower' scope can *shadow*, or hide, variables of the same name in a higher scope

### Adding Varaibles to the Current Scope

  * This can be done in two ways:
    * Using the `var` keyword to declare a new variable
    * Arguments passed into functions

### Variable Assignment

  * Variable scoping rules apply to assignment and referencing equally
  * If a variable is assigned separately from a declaraton, JavaScript checks the current scope and then each higher scope until it finds a matching variable and then assigns the value
  * If JavaScript can't find a matching variable, it **creates a new global variable instead**. This is generally not the desired behaviour and can be the source of bugs.

Example:

```javascript
var country = 'France';

function update_country() {
  country = 'England';
  country_2 = 'Spain';
  var country_3 = 'Germany'
}

console.log(country); // logs: France

update_country();
console.log(country); // logs: England
console.log(country_2); // new global variable created. logs: Spain
console.log(country_3); // ReferenceError. country_3 is not available outside of the function scope
```

### Variable Shadowing

  * If a function has an argument with the same name as a variable from an outer scope, the argument 'shadows' the outer varaible

Example:

```javascript
var name = 'Karl';

function log_name(name) {
  console.log(name)
}

log_name('Kate'); // name param of the functions shadows the outer name variable. logs: Kate
```

### Important Scoping Rules to Note

  * Every Function declaration creates a new variable scope
  * All variables in the same or surrounding scope are available to your code


<a name="declarations-function-expressions"></a>
## Function Declarations and Function Expressions

### Function Declarations

  * A function declaration (sometimes called a *function statement*) defines a variable whose type is `function`
  * It does not require assignment to a varaible since it is already a variable
  * The value of the variable is the function itself
  * This 'function varaible' obeys general scoping rules, and can be used exactly like other JavaScript varaibles

Example:

```javascript
function outer() {
  funtion inner() {
    return 'hello';
  }

  return inner();
}

outer(); // returns hello
inner(); // can't access the local scope from here
```

### Function Expressions

  * A function expression defines a function as part of a larger expression syntax (typically a variable assignment)
  * We can declare an anonymous fuction and assign it to a variable
  * We can then use the variable to invoke the function

Example:

```
var hello = function() {
  return 'hello';

typeof hello // function
hello(); // returns 'hello'
```

### Named Function Expressions

  * You can also name function expressions, though the name is only available inside the function

Example:

```javascript
var hello = function foo() {
  console.log(typeof foo);
}

hello(): // logs: function

foo(); // Uncaught ReferenceError: foo is not defined
```

  * Most function expressions use anonymous functions, but named function expressions are useful for debugging since the debugger can show the function's name in the call stack

<a name="hoisting"></a>
## Hoisting

### Hoisting for Variable Declarations

  * JavaScript processes variable declarations **before** it executes any code within a scope
  * Declaring a variable anywhere in a scope is equivalent to declaring it at the top of the scope
  * This behaviour is called *hoisting*; JavaScript effectively moves the variable declarations to the top of the scope
  * JavaScript only hoists variable **declarations**, not **assignments**

Example:

```
var a = 1;
var b = 2;
```

is equivalent to:

```
var a; // at this point the variables have a value of undefined
var b;

a = 1;
b = 2;
```

### Hoisting for Function Declarations

  * JavaScript also hoists Function declarations to the top of the scope
  * It hoists the **entire** function declaration, including the body (i.e. the value of the 'function variable')

Example:

```
console.log(hello_world());

function hello_world() {
  return 'hello world!';
}
```

is equivalent to:

```
function hello_world() {
  return 'hello world!';
}

console.log(hello_world()); // logs "hello world"
```

### Hoisting for Function Expressions

  * Function expressions involve assigning a function to a variable
  * Since expressions are just variable declarations, they obey the same hoisting rules a varaible declarations

Example:

```
console.log(hello_world());

function hello_world = function() {
  return 'hello world!';
}
```

is equivalent to:

```
var hello_world;

console.log(hello_world()); // produces "Uncaught TypeError: hello_world is not a function"

hello_world = function() {
  return 'hello world!';
}
```

  * Here we are calling `hello_world()` as if it were a function in our `console.log()`, but it hasn't been assigned to the anonymous function yet since only the variable declaration has been hoisted.

### Hoisting Variable and Function Declarations

  * When both variable and function declarations exist, function declarations are processed first

Example:

```
function hello() {
  var b = 'hello';
  return a;

  var a = 'world';
}

var a = 123;
var b = 456;

hello();
```

is equivalent to:

```
function hello() {
  var b;
  var a;

  b = 'hello';

  return a;

  a = 'world';
}

var a;
var b;

a = 123;
b = 456;

hello();
```

Example 2:

```
function foo() {};
var foo;

var bar;
function bar() {};

console.log(foo);
console.log(bar);
```

is equivalent to:

```
function foo() {};
function bar() {};

// the var declaration is not present since it is redundant

console.log(foo);
console.log(bar);
```

### Best Practice

  * Hoisting can introduce confustion and subtle bugs. The following rules can help avoid issues:
    * Always declare variables at the top of their scope
    * Always declare functions before calling them
