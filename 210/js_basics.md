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



<a name="operators"></a>
## Operators

<a name="expressions-statements"></a>
## Expressions and Statements

<a name="input-output"></a>
## Input and Output

<a name="primitive-type-coercions"></a>
## Primitive Type Coercions

<a name="conditionals"></a>
## Conditionals

<a name="looping-iteration"></a>
## Looping and Iteration

<a name="resources"></a>
## Resources

  * [MDN: Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
  * [MDN: Javascript String Methods](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/prototype)
