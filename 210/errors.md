# JavaScript Errors

  * [Overview](#overview)
    * [ReferenceError](#ReferenceError)
    * [TypeError](#TypeError)
    * [SyntaxError](#SyntaxError)
  * [Preventing Errors](#preventing-errors)
    * [Guard Clause](#guard-clause)
    * [Detecting Edge Cases](#edge-cases)
    * [Planning Your Code](#planning-code)
  * [Catching Errors](#catching-errors)

<a name='overview'></a>
## Overview

  * There are many situations that can occur where the JavaScript interpreter cannot continue executing a program due to a problem with the code. In these situations it creates an *Error* that describes the problem and stops the program
  * Although you generally want to avoid errors as far as possible, there are sometimes errors that can't be avoided. In these cases there are techniques that can be used to handle them in a particular way.
  * When an error occurs in a JavaScript program we say it *throws* an error. Some programming languages use the term *exceptions* for errors, similarly some languages use the term *raising* instead of *throwing*. These terms basically all mean the same thing.
  * Some of the most common types of error are `ReferenceError`, `TypeError`, and `SyntaxError`; errors such as `RangeError`, and `URIError` are less common.

<a name='ReferenceError'></a>
### ReferenceError

  * This occurs when you reference a variable or function that doesn't exist.

Example:

```JavaScript
a;             // Uncaught ReferenceError: a is not defined(…)
a();           // Uncaught ReferenceError: a is not defined(…)
```

<a name='TypeError'></a>
### TypeError

  * A `TypeError` usually occurs when you try to access a property on a vlaue that doesn't have any properties, such as `null`.
  * Trying to call something as a Function when it isn't a Function also raises a `TypeError`

Example:

```JavaScript
var a;
typeof a; // undefined
a.name;   // Uncaught TypeError: Cannot read property 'name' of undefined(…)

a();      // Uncaught TypeError: a is not a function(…)
```

<a name='SyntaxError'></a>
### SyntaxError

  * A `SyntaxError` usually occurs immediately after loading a JavaScript program, and before it beings to run. Whereas `ReferenceError` and `TypeError` depend upon specific values encountered at runtime, `SyntaxError`s are detected based on the test of the program.

Example:

```JavaScript
function ( {}   // SyntaxError: Unexpected token (
```

  * There are also case where JavaScript can throw a syntax error while a program is running.

Example:

```JavaScript
JSON.parse('not really JSON'); // SyntaxError: Unexpected token i in JSON at position 0
```

<a name='preventing-errors'></a>
## Preventing Errors

<a name='catching-errors'></a>
## Catching Errors
