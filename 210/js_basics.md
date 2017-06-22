# JavaScript Basics

  * [Code Style](#code-style)
  * [Data Types](#data-types)
  * [Primitive Values](#primitive-values)
  * [Variables](#variables)
  * [Operators](#operators)
  * [Expressions and Statements](#expressions-statements)
  * [Input and Output](#input-output)
  * [Primitive Type Coercions](#primitive-type-coercions)
  * [Conditionals](#conditionals)
  * [Looping and Iteration](#looping-iteration)
  * [Resources](#resources)


<a name="code-style"></a>
## Code Style

### Variable Names

  * Var names should never start with an uppercase letter
  * Multi-word var names use camel case, but with first letter lowercase
  * Object properties use the same convention

Example:

```javascript
var myNumber = 42;
var myObject = {
  myNumber: 42,
};
```

### Formatting

  * Use 2 space characters to indent (not tabs)
  * Multi-line code using curly braces have the opening brace on same line as initial statement and closing brace on its own line
  * Semicolons always terminate a statement
  * `if`, `for`, and `while` statements always use spaces between keyword and opening paren, and between closing paren and opening brace
  * Space characters should also be placed before and after the equals symbol
  * Use one `var` declaration per variable (this avoids swapping between `,` and `;`)

Example:

```javascript
if (myObject.hasOwnProperty('foo')) {
  console.log('Foo is defined');
} else {
  console.log('Foo is undefined');
}

// Bad
i=0;
while(i<15){
  i+=1;
}

// Good
i = 0;
while (i < 15) {
  i += 1;
}

// Bad
var firstName = 'Karl',
    lastName = 'Lingiah',
    age = 42;

// Good
var firstName = 'Karl';
var lastName = 'Lingiah';
var age = 42;
```

<a name="data-types"></a>
## Data Types

In JavaScript (ES5), there are five primitive data types:

  * number
  * boolean
  * string
  * null
  * undefined

and one compound data type:

  * object

You can use the `typeof` operator to get the data type of any value:

```javascript
typeof 'hello' // "string"
typeof 42 // "number"
```

### Number

  * Javascript uses 64-bit [double precision floats](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) to store numbers in memory
  * Numbers support the basic arithmetic operations, including `+`, `-`, `*` & `/`
  * Javascript uses a floating point system to represent all numbers (unlike some other languages that have distinct number types)

#### Floating Point Values

  * Floating point values cannot precisely represent values because of how the computer represents them (this is not specific to Javascript).
  * This can cause slight discrepancies or rounding errors

Example:

```javascript
0.1 + 0.2;   // returns 0.30000000000000004, not 0.3!
```

  * The best practice is to avoid fractional numbers as much as you can, and use integer numbers of the smallest relevant units
  * There are a few special number values:
    * `Infinity`: when you need to represent a number that's greater than any other number
    * `-Infinity`: when you need to represent a number that's less than any other number
    * `NaN`: "not a number" -- this occurs a lot when a maths function encounters an error

### Boolean

  * Boolean values represent the truth-values of logic
  * There are only two possible boolean values: `true` and `false`
  * The result of a comparison operation is a boolean value

Example:

```javascript
2 > 1 // true
1 > 3 // false
```

### String

  * A `String` is a sequence of characters. It is the data type used to represent text within a JavaScript program
  * JavaScript strings have no size limit and can contain any amount of text
  * You can use either single or double quote marks for strings (there is no functional distinction between the two)
  * A common string operation is concatenation (which uses the `+` operator)

Example:

```javascript
'Hello' + ' World!'; // "Hello World!"
```

#### Special Characters

 * Strings can hold any character in the UTF-16 character set
 * Formatting characters, e.g. newlines, need special handling using escape sequences

Example:

```javascript
var multiline = 'This string...\nspans multiple lines';
```

Here the `\n` is an escape sequence used to specify a newline

  * Some common formatting characters are:
    * `\n`: newline
    * `\t`: tab
    * `\r`: carriage return
    * `\v`: vertical tab
    * `\b`: backspace
  * You may sometimes need to escape standard characters, for example quote marks.

Example:

```javascript
var quote = '"It\'s hard to fail, but it is worse never to have tried to succeed." - Theodore Roosevelt';
```

#### String Concatenation

  * String concatenation uses the `+` symbol, as does numerical addition
  * JavaScript always performs concatenation when `+` is used with a string operand, otherwise it performs addition

#### Character Access & String Length

  * Strings act like an ordered collection of characters; this collection is zero-indexed
  * To access a character in a string we can use the `charAt()` method, passing the index value of the character as an argument
  * Square brackets can perform the same operation

Example:

```javascript
'hello'.charAt(1) // "e"
'hello'[1] // "e"
```

  * Strings have a `length` property to tell you the number of characters in the string

Example:

```javascript
'hello'.length; // 5
```

#### Working with Long Strings

  * Assigning long literal strings to a variable can make readability an issue.
  * We can use concatenation with the `+` operator to write the string out in chunks
  * Alternatively you cna place a `\` at the end of each line; this tells JavaScript to ignore the following newline and treat them as loteral spaces or tabs

<a name="primitive-values"></a>
## Primitive Values

  * Many of the common datatypes are *primitive types*; JavaScript represents them at the lowest level of language implementation
  * JavaScript promitives inclies these five types:
    * number
    * string
    * boolean
    * null
    * undefined
  * All JavaScript primitives are immutable; you cannot change them once you create them
  * Primitive values (especailly strings) may *appear* to change during the lifetime of a program, however JavaScript doesn't change the values, it assigns new values to variables that used to contain different values
  * You need to assign an expression in order to change the value in a variable; no function, method or other operation will modify it for you

Example:

```javascript
var a = 'hello';
a.toUpperCase();
a; // "hello"
a = a.toUpperCase();
a; // "HELLO"
```

  * All other javascript constructs, including arrays and functions, are JavaScript Objects.
  * Objects are mutable; you can modify them without losing their identity

<a name="variables"></a>
## Variables

  * JavaScript makes use of variables to store values
  * This provides a way of associating data with descriptive names
  * It can be helpful to think of variables as containers that hold data

### Variable Naming Guidelines

  * JavaScript variables are case-sensitive; `my_variable` is not the same as `my_Variable`
  * Variable names can be of any length
  * Variable names must sturt with a Unicode letter, the underscore (`_`), or the dollar sign (`$`)
  * Succeeding letters after the first must be Unicode letters, numbers, or undrscores
  * A variable name must not e a [reserved word](http://www.ecma-international.org/ecma-262/5.1/#sec-7.6.1)

Examples:

```javascript
// valid variable names

_count
$price
value
my_variable
otherVariable

// invalid variable names

1count
my#variable
```

### Declaring and Assigning Variables

  * Variables must be declared before they are used
  * In JavaScript, variables are declare using the `var` keyword
  * After a variable is declared you can use the `=` operator to assign it
  * You can also combine variable declaration with an initialization assignment
  * Any variable that is declared but not assigned will be initialized with a value of `undefined`


Examples:

```javascript
var myVariable; // variable declaration

myVariable = 'Hello'; // variable assignment

var myVariableToo = 'Goodbye'; // combined declarationa and assignment

var myUndefinedVar;
myUndefinedVar // undefined
```

### Dynamic Typing

  * JavaScript is a dynamically typed language
  * This means a variable can hold a reference to any data type and can be reassigned to a different type without error
  * A variable in JavaScript is jsut a name for a particular value at a particular time

Example:

```javascript
var myVariable = 'Hello';
myVariable = 42;
myVariable; // 42
```

<a name="operators"></a>
## Operators

  * An operator is a symbol which tells a program to perform operations on values (operands)
  * Operators usually operate on two operands; e.g. in the statement `a + b`, `+` is the operator, `a` and `b` are operands
  * The operancs serve as the operator's input

### Arithmetic Operators

  * Arithmetic operators take two numeric values as operands and return a single numeric value
  * The standard arithmetic operators are `+`, `-`, `/`, `*`, and `%`
  * `%` is the remainder or operator. t uses a built-in modulo function to produce the result
  * This modulo function is implemented differntly to the modulo operator found in some other programming languages (e.g. Ruby)
    * With positive integers there is no distintion, e.g. `10 % 3` returns `1` with either modulo or remainder
    * If one of the numbers is negative, `10 % -3` returns `1` using JavaScript (i.e. in JS) and `-2` using Ruby

### Assignment Operators

  * The assignment operator (`=`) assigns the value of the right operand to the left operand.
  * E.g. `x = 10` assigns `10` to `x`
  * JavaScript also has compound assignment opertors. These couple arithmetic operators with assignment using shorthand notation
  * E.g. `a += 1` actually means `a = a + 1`

Examples:

```javascript
a = b   // assignment
a += b  // addition assignment
a -= b  // subtraction assignment
a *= b  // multiplication assignment
a /= b  // division assignment
a %= b  // remainder assignment
```

### Comparison Operators

  * A comparison operator compares its operands and returns a boolean value (`true` or `false`)
  * When the operands are of different data types, JavaScript tries to implicitly convert them to suitable types when certain operators are used
  * This implicit conversion can cause problems, so many JavaScript programmers avoid teh sue of `==` and `!=` in favour of the stricter versions (`===` and `!==`)
  * These stricter comparison operators do not prompt JavaScript to perform any conversion

Examples:

```javascript
== // equal; returns true if the operands are equal
!= // not equal; returns true if the operands are not equal
=== // strict equal; returns true if the operands are equal and of the same type
!== // strict not equal; returns true if operands are not equal or of different types
> // greater than; returns true if the left operand is greater than the right
< // less than; returns true if the left operand is less than the right
```

### String Operators

  * You can perform comparisons on string values
  * String comparisons use Unicode lexicographical ordering

Examples:

```javascript
'a' < 'b' // true
'Ant' > 'Falcon' // false
'50' < '6' // true; the str
```

  * Strings support concatenation using the `+` operator. You can use shorthand notation `+=` to combine concatenation and assignment

Example:

```javascript
var a = 'Hello';
a += ' World!';

a; // "Hello World!"
```

### Logical Operators

  * You can combine boolean values with logical operator
  * Logical operators also work on non-boolean values, though they work slightly differently in this case

#### Logical And (`&&`)

  * For boolean values, returns `true` if both operands are `true`, `false` otherwise
  * For non-boolean values, returns the first operand if it can be converted to `false`, the second operand otherwise

Examples:

```javascript
true && true; // true
true && false; // false
false && true; // false
false && false; // false
false && []; // false
```

#### Logical Or (`||`)

  * For boolean values, returns `true` if at least one operands is `true`, `false` otherwise
  * For non-boolean values, returns the first operand if it can be converted to `false`, the second operand otherwise

Examples:

```javascript
true || true; // true
true || false; // true
false || true; // true
false || false; // false
false || []; // [] (the second operand is a non-boolean and is returned as it is)
```

#### Logical Not (`!`)

  * Returns `true` if its operand can be converted to `false`, `false` otherwise
  * This is a unary operator: it only takes one operand, before which the `!` must be specified

Examples:

```javascript
!true; //false
!false; // true
!!true; // true
!1; // false
![]; // false
```

<a name="expressions-statements"></a>
## Expressions and Statements

### Expressions

  * An expression is any valid code that resolves to a value

Examples:

```javascript
'hello'; // a single string is an expression
1 + 1; // arithmetic operations are expressions
a = 5; // assignments are expressions
```

  * The most common expression types are:
    * Arithmetic: expressions that evaluate to a number
    * String: expressions that evaluate to a character string
    * Logical: expressions that evaluate to a boolean

  * An expression can appear anywhere that JavaScript expects or allows a value

Examples:

```javascript
var a;
var b;
var c;

a = 'hello' + ' world';
b =  6 * 3;
c = 10 > 6;
```

#### Operator Precedence

  * JavaScript uses similar precedence rules to other programming languages
    * E.g. multiplication before division, addition before subtraction
  * Parentheses can be used to override precedence

Example:

```javascript
3 + 3 * 4 // 15
(3 + 3) * 4 // 24
```

#### Increment and Decrement Operators in Expressions

  * The increment (`++`) and decrement (`--`) operators increment and decrement operands by 1
  * They can appear either before (prefix) or after (postfix) the operand
  * In a standalone expression there is no difference between postix and prefix
  * In more complicated expressions the one you choose can have an effect:
    * With postfix, JavaScript evaluates the expression then modifies the operand
    * With prefix, JavaScript modifies the operand then evaluates the expression

Examples:

```javascript
var a = 1;
a ++; // a is now 2
++a; // a is now 3
a--; // a is now 2
--a; // a is now 1

var b;
var c;

b = a++; // equivalent to "b = a; a++;", so b is 1 and a is 2
c = ++a; // equivalent to "++a; c = a;", so c is 3 and a is 3
```

#### Logical Short Circuit Evaluation in Expressions

  * When a stement contains logical And or logical Or operators, JavaScript evaluates them using 'short-circuit' rules:
    * Given `a || b`, if `a` is `true`, the result is always `true` -- `b` does not need to be evaluated
    * Given `a && b`, if `a` is `false`, the result is always `false` -- `b` does not need to be evaluated


### Statements

  * Unlike expressions, statements in JavaScript don't necessarily resolve to a value
  * Statments generally control the execution of a program
  * Variable assignments are expressions, but variable declarations are statements
  * Other types of statements include `if... else...` and `switch` for conditonals, `while` and `for` for loopiong, etc.
  * It is useful to think of statements as code that 'does something' rather than just providing a value to use

Examples:

```javascript
var a; // declaring a variable is a statement
var b;
var c;

var b = (a = 1); // this works becuse assignments are expressions too
var c = (var a = 1); // this gives an error, since statements can't be used as part of an expression
```

<a name="input-output"></a>
## Input and Output

  * The `prompt()` method pops up a dialog box with an optional message and a field for the user to enter some text
  * In the browser environment you can use this method to collect user input
  * If the user enters some text and clicks `Ok`, `prompt()` returns the text as a string
  * If the user clicks `Cancel`, `prompt()` returns `null`
  * If you want to use the input as anything other than a string you have to perform coversion on it

Example:

```javascript
var name = prompt('What is your name?');
var guess = prompt; // blank prompt window
```

  * The `alert()` method pops up a dialog box with a message and an `Ok` button to dismiss the dialog
  * In a browser environment you can use this method to notify the user of something

Example:

```javascript
alert('Hello world!'); // dialog with message
alert(): // empty dialog
```

### Logging Messages to the Console

  * The `console.log` method outputs a message to the JavaScript console
  * This method can be used for debugging purposes

Example:

```javascript
var name = prompt('What is your name?');

console.log(name);
```

<a name="primitive-type-coercions"></a>
## Primitive Type Coercions

### Explicit Primitive Type Coercions

  * We sometimes want to convert primitive JavaScript values into values of different types
  * E.g. we may want to convert the String `"345"` into the number `345`
  * Such operations are called **coercions** or **conversions**
  * Since in JavaScript primitive types are immutable, the values aren't actually *converted*, instead a value of the required type is *returned* by the operations

#### Strings to Numbers

  * We can use `Number()` to turn Strings that contain a numeric value to a Number
  * If a String cannot be converted to a Number, `Number()` returns `NaN`
  * The `parseInt()` and `parseFloat()` global functions turn Strings into Numbers, only handling numeric values ion an integer or floating-point format respectively
  * `parseInt` takes an optional `radix` argument which represents the numerical base -- it is good practice to always specify this to make clear the intention and have more predicatable behaviour

Examples:

```javascript
Number('1'); // 1
Number('abc'); // NaN

parseInt('123', 10); // 123
parseInt('123.45, 10); // 123 -- Will only return integers
parseFloat('123.45'); 123.45 -- can handle floating point values
```

#### Numbers to Strings

  * You can use the `String()` function to turn Numbers into Strings, passing in the Number as an argument
  * You can also call the `toString()` method on Numbers
  * Another option is to convert the Number by 'adding' it to a String using the `+` operator. This is not recommended as the intent is not as clear

Examples:

```javascript
String(123); // "123"
String(1.23); // "1.23"
(123).toString(); // "123"
(1.23).toString(): // "1.23"
123 + ''; // "123"
'' + 1.23; // "1.23"
```

#### Booleans to Strings

  * To turn boolean values to Strings youo can use the `String()` function or call the `toString()` method on the value

Examples:

```javascript
String(true); // "true"
String(false); // "false"
true.toString(): // "true"
false.toString(); // "false"
```

#### Primitives to Strings

  * There is no direct coercion of string to boolean, but if you have a string representation of a boolean you can compare it with `'true'` (whilst being mindful of case)

Example:

```javascript
var a = 'true';
var b = 'false';
a === 'true';    // true
b === 'true';    // false
```

  * You can also use the `Boolean()` function to convert any value into a boolean based on the *truthy* and *falsy* rules in JavaScript
  * `null`, `NaN`, `0`, `''`, `false`, and `undefined` all evaluate to `false`; any other value evaluates to `true`

Examples:

```javascript
Boolean(null);        // false
Boolean(NaN);         // false
Boolean(0);           // false
Boolean('');          // false
Boolean(false);       // false
Boolean(undefined);   // false
Boolean('abc');       // other values will be true
Boolean(123);         // true
Boolean('true');      // including the string 'true'
Boolean('false');     // but also including the string 'false'!
```

  * The double `!` opertor (`!!`) provides a simpler way than the `Boolean()` method to coerce a truthy or falsy value to its boolean equivalent.
  * Since a single `!` returns the opposite of the value's boolean equivalent, a double `!` returns the value's boolean equivalent

Examples:

```javascript
!!(null);       // false
!!(NaN);        // false
!!(0);          // false
!!('');         // false
!!(false);      // false
!!(undefined);  // false

!!('abc');      // true
!!(123);        // true
!!('true');     // true
!!('false');    // this is also true! All strings are truthy in JavaScript
```

### Implicit Primitive Type Coercions

  * In many programming languages, trying to combine values of different types in an expression will produce errors
  * JavaScript attempts to make sense of the expression by performing implicit conversion, which can have some unexpected results

Examples:

```javascript
1 + true // true is coerced to the number 1, so the result is 2
'4' + 3 // 3 is coerced to the string "3", so the result is "43"
false == 0 // false is coerced to the number 0, so the result is true
```

  * Implicit conversion may seem convenient, but this flexibility makes bugs likelier; such bugs can often be hard to detect/ debug
  * As a rule, these automatic conversion types should be avoided, but it's important to be aware of what they are and the results they produce

#### Arithmetic Operators

  * The unary plus opertor converts values into numbers
  * The binary plus operator (with two operands) is used for additon with numbers and for concatenation with strings
    * If used in a mixed way with both strings and numbers, JavaScript tries to convert the other operand to a string
  * Other arithmetic operators are only defined for numbers, so  Javascript will try to coerce the operands to numbers

Examples:

```javascript
+('123') // 123
+('') // 0
+(null) // 0
+('a') // NaN

1 + true // 2
'123' + 123 // "123123" -- number is coerced into a string
123 + '123' // "123123"
'a' + null // "anull" -- null is coerced into a string

1 - true // 0
'123' * 3 // 369 -- string is coerced into a number
'8' - '1' // 7 -- both strings are coerced into numbers
```

#### Relational Operators

  * The relational operators `<`, `>`, `<=`, and `>=` are defined for numbers (numeric comparisons) and strings (lexicographical order)
  * Here, JavaScript tries to coere the opertion into a number comparison unless both operands are strings

Examples:

```javascript
11 > '9' // true -- string coerced to number
123 > 'a' // false -- 'a' coerced to NaN. Any number comparison with NaN returns false
```

#### Equality Operators

  * Javascript provides both non-strict equality operators `==` and `!=`, and strict equality operators `===` and `!==`
  * The strict equality operators never perform type coercions
  * The non-strict operators have a complex set of rules to coerce types before performing comparison

Examples:

```javascript
// non strict

0 == false // true -- false coerced into number 0
true == 1 // true -- true is coerced into number 1.
'true' == true // false. true is ocerced to numer 1.  comparison of boolean and non-boolean will coerce boolean into a number
'' == undefined // false -- undefined coerced into string "undefined"
'' == 0 // true -- '' is coerced into number 0

// strict
0 === false // false
'' === undefined // false
'' === 0 // false
true === 1 // false
'true' === true // false
```

### Best Practices

  * Understanding JavaScript's implicit type coercions is important when you debug problems in existing code
  * When writing your own programs it's best to avoid writing code that uses implicit conversions:
    * **Always use explicit type coercions**
    * **Always use strict equality operators**
  * As well as helping to avoid bugs, by being explicit in your code you clearly show the intentions of that code

<a name="conditionals"></a>
## Conditionals

  * Conditional statements are a set of commands trigered when a condition is true
  * In JavaScript there are two types of conditional statement: `if...else` and `switch`

### if...else

  * An `if` statement is made up of the `if` keyword, followed by a condition, and then a block of code which runs if the condition is true
  * A block is delimited by curly braces and groups zero or more statements together
  * An `if` statement can have an optional `else` clause. This runs when the `if` statement's condition evaluates as `false`
  * Another `if` statement may follow the `else` keyword; this lets you test multiple conditions
  * When there are multiple conditions, only the first conditional statement which evaluates as true executes 
  * `if` statments can also be nested, though statements with many nested levels can be difficult to parse mentally
  * When the expression in an `if` statement doesn't evaluate as boolean `true` or `false`, javaScript tries to translate the result to a boolean value

Examples:

```javascript
var score = 80;

//if
if (score > 70) {
  alert('You passed!');
}


//if else
if (score > 70) {
  alert('You passed!');
} else {
  alert('Not yet');
}


// if else if
if (score > 70) {
  alert('You passed!');
} else if (score > 65) {
  alert('Almost');
} else {
  alert('Not yet');
}

//nested
if (condition1) {
  if (nestedCondtion) {
    // statements
  } else {
    // statements
  }
} else if (condition2) {
  // statements
}
```

### Switch

  * The switch statement compares an expression with multiple `case` labels.
  * When it finds a match, the statements following the matched case label execute
  * As with `if` statements, `switch` looks for the first `case` lavel that matches
  * Unlike `if`, `switch` will then continue through the rest of the `case` statements until it reaches the `default` clause or a `break` statement
  * This is referred to as execution 'falling through' to the next case. To correct this, insert a `break` in each `case` statement

Examples:

```javascript
var myNumber = 2;

// no break clause
switch (myNumber) {
  case 1:
    alert('The number is 1');
  case 2:
    alert('The number is 2');
  case 3:
    alert('The number is 3');
  default:
    alert('The number is greater than 3');
}

// output
'The number is 2'
'The number is 3'
'The number is greater than 3'

// with break clause
switch (myNumber) {
  case 1:
    alert('The number is 1');
    break;
  case 2:
    alert('The number is 2');
    break;
  case 3:
    alert('The number is 3');
    break;
  default:
    alert('The number is greater than 3');
}

// output
'The number is 2'
```

### Comparing values with NaN

  * `NaN` is a special value in JavaScript that represents an illegal operation on numbers
  * `NaN` stands for 'Not a Number', thouogh its data type in JavaScript is still actually `Number`
  * Comparing `NaN` with any value evaluates to false, even if that value is `NaN` itself
  * Since the usual comparison methods cannot be used with `NaN`, we must use the `isNaN` function instead
    * `isNaN` returns true if the value is not a number, false if it is a number

Examples:

```javascript
Number('a'); // NaN
undefined + 1; // NaN

typeof(NaN); // number -- NaN is actually a number in terms of data type

10 === NaN; // false
10 < NaN; // false
10 > NaN; // false

NaN == NaN; // false
isNaN(NaN;) // true
```

  * Since `isNaN` returns true for any value that is not a number, including any non-numeric data type, if we want to check if a value is equal to `NaN`, we must also check if its type is numeric

Example:

```javascript
var varA = 'a';
var varB = NaN;

isNaN(varA); // true
isNaN(varB); // true
typeof(varA) == 'number' && isNaN(varA); // false
typeof(varB) == 'number' && isNaN(varB); // true
```

<a name="looping-iteration"></a>
## Looping and Iteration

  * Loops provide a way to execute a statement or blockof statements repeatedly while certain conditions are true

### The 'while' Loop

  * A `while` loop first evaluates the condition
  * If the condition has a truthy value, it executes the statements in the loop body
  * When execution reaches the end of the block, control passes back to the condition expresion again
  * If the condition *still* has a truthy value, the process is repeated until the condition produces a falsy value
  * An infinite loop results if the condition never produces a falsy value
  * A `break` statement exits from a loop immediately
  * A `continue` statement skips the current iteration of the loop and returns to the top of the loop

Examples:

```javascript
// a simple while loop

var counter = 0;
var limit = 5;

while (counter < limit) {
  console.log(counter);
  counter += 1;
}


// an infinite loop

var counter = 0;
var limit = 5;

while (counter < limit) {
  console.log(counter);
}

// using break

var counter = 0;
var limit = 5;

while (true) {
  counter += 1;
  if (counter > limit) {
    break;
  }

  console.log(counter);
}

// using continue

var counter = 0;
var limit = 5;

while (true) {
  counter += 1;
  if (counter === 3) {
    continue;
  }

  if (counter > limit) {
    break;
  }

  console.log(counter);
}
```

### The 'do...while' Loop

  * The `do...while` loop is similar to the `while` loop, except it always iterates at least once (the `while` loop won't iterate if the condition is falsy)
  * With `do...while`, JavaScript evaluates the condition after executing the loop body, so the loop body always executes once

Example:

```javascript
var counter = 0;
var limit = 0;

do {
  console.log(counter);
  counter++;
} while (counter < limit);
```

### The 'for' Loop

  * The `for` loop is the most common looping structure in JavaScript
  * It lets you combine the three elements used to control a loop in a single statement:
    * Setting the initial state
    * Evaluating a condition
    * Making some sort of change before re-evaluating the condition
  * Most `for` loops use an 'iterator' variable which, by convention, is commonly named `i` or `j`

Example:

```javascript
for (initialExpession; condition; incrementExpression) {
  // statements
}

for (var i = 0; i < 10; i++) {
  console.log(i);
}
```

  * The flow of execution for a `for` loop is as follows:
    1. Execute initializaton statement (the statement may include variable declarations)
    2. Evaluate the condition (the loop terminates if the condition has a falsy value)
    3. Execute the body of the loop
    4. Execute the increment expression
    5. Return to step 2 for the next iteration

  * You can skip any of the three components of the `for` statement and simply include them elsewhere in the code

Examples:

```javascript
// initialization outside the loop

var i = 0;
for (; i < 10; i++) {
  console.log(i);
}

// manually check condition within loop body to break out of the loop
// if condition is omitted in 'for', JavaScript assumes true

for (var i = 0; ; i++) {
  if (i >= 10) {
    break;
  }

  console.log(i);
}

// manually increment iterator in loop body

for (var i = 0; i < 10;) {
  console.log(i);
  i++;
}
```

<a name="resources"></a>
## Resources

  * [MDN: Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
  * [MDN: Javascript String Methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/prototype)
  * [MDN: Javascript Arithmetic Operators](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators)
