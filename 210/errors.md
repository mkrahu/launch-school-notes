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

```
a;             // Uncaught ReferenceError: a is not defined(…)
a();           // Uncaught ReferenceError: a is not defined(…)
```

<a name='TypeError'></a>
### TypeError

  * A `TypeError` usually occurs when you try to access a property on a vlaue that doesn't have any properties, such as `null`.
  * Trying to call something as a Function when it isn't a Function also raises a `TypeError`

Example:

```
var a;
typeof a; // undefined
a.name;   // Uncaught TypeError: Cannot read property 'name' of undefined(…)

a();      // Uncaught TypeError: a is not a function(…)
```

<a name='SyntaxError'></a>
### SyntaxError

  * A `SyntaxError` usually occurs immediately after loading a JavaScript program, and before it beings to run. Whereas `ReferenceError` and `TypeError` depend upon specific values encountered at runtime, `SyntaxError`s are detected based on the test of the program.

Example:

```
function ( {}   // SyntaxError: Unexpected token (
```

  * There are also case where JavaScript can throw a syntax error while a program is running.

Example:

```
JSON.parse('not really JSON'); // SyntaxError: Unexpected token o in JSON at position 1
```

<a name='preventing-errors'></a>
## Preventing Errors

  * The best way to handle errors is to prevent them from happening by pre-empting them.
  * In order to do this, you need to anticipate where they can occur.
  * One of the most common places errors can occur is with unexpected input, for example if your funciton is expecting a string of one or more characters and an empty string is input:

```
function lowerInitial(word) {
  return word[0].toLowerCase();
}

// This works fine
lowerInitial('Joe');       // "j"

// An empty string throws an error
lowerInitial('');          // TypeError: Cannot read property 'toLowerCase' of undefined
```

  * The assumptions that your code makes are usually where Errors occur; in the above example there was an assumption that the input would always be a string of non-zero length
  * An input error like this halts execution of the program entirely, which is generally not what you want to happen.

<a name='guard-clause'></a>
## Guard Clause

  * One way to avoid input errors is to perform some sort of validation on the input using a guard clause
  * A guard claue ensures that data meets certain conditions before it gets used

Example:

```
function lowerInitial(word) {
  if (word.length === 0) {          // If word contains an empty String,
    return '-';                     // return a dash instead of proceeding.
  }

  return word[0].toLowerCase();     // word is guaranteed to have at least 1 character due to the guard clause
}
```

  * Guard clauses are best used when a function can't trust that its arguments are validation
  * Invalid arguments are ones that can have incorrect types, structures, values, or properties

<a name='edge-cases'></a>
## Detecting Edge Cases

  * Most error prevention stems from examining the assumptions in your code
  * Situations that can violate those assumptions are referred to as edge cases because they often involve values at the extreme end of a possible range.
  * One place to start looking for edge cases is by considering the code's inputs; for a Function these are usually the arguments
  * It is also a good idea to consider how particular combinations of values can create unexpected conditions

<a name='planning-code'></a>
## Planning Your Code

  * Although you can't account for every possible permutation of arguments, it is useful to plan ahead
  * One way to do this is write out the common use cases for a new Function and check out the Function handles them. This is a great way to identify edge cases

<a name='catching-errors'></a>
## Catching Errors

  * It's not possible to prevent all errors. For example, some built-in JavaScript Functions can throw errors, but there is no practical way to predict and avoid them* Instead of trying to avoid errors, we can let the error be thrown and 'catch' it with a `try/catch/finally` block
  * The syntax for these blocks is similar to `if/else` blocks:


```
try {
  // Do something that might fail here and throw an Error.
} catch (error) {
  // This code only runs if something in the try clause throws an Error.
  // "error" contains the Error object.
} finally {
  // This code always runs, no matter if the above code throws an Error or not.
}
```

  * The `finally` clause is optional, and can be omitted

Example:

```
function parseJSON(data) {
  var result;

  try {
    result = JSON.parse(data);  // Throws an Error if "data" is invalid
  } catch (e) {
    // We run this code if JSON.parse throws an Error
    // "e" contains an Error object that we can inspect and use.
    console.log('There was a', e.name, 'parsing JSON data:', e.message);
    result = null;
  } finally {
    // This code runs whether `JSON.parse` succeeds or fails.
    console.log('Finished parsing data.');
  }

  return result;
}

var data = 'not valid JSON';

parseJSON(data);                // Logs "There was a SyntaxError parsing JSON data:
                                //       Unexpected token i in JSON at position 0"
                                // Logs "Finished parsing data."
                                // Returns null
```

  * `try/catch/finally` blocks should be used in the following situations:
    * A built-in JavaScript Function or method can throw an error and you need to handle or prevent that error
    * A simple guard clause is impossible or impractical to prevent the error
