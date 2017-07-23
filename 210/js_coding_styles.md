# JavaScript Coding Styles

* [Style Guides](#style-guides)
* [Basic Rules](#basic-rules)
  * [Spacing](#spacing)
  * [Blocks](#blocks)
  * [Semicolons](#semicolons)
  * [Naming Conventions](#naming-conventions)
  * [Strings](#strings)
  * [Numbers](#numbers)
  * [Boolean](#boolean)
  * [Functions](#functions)

<a name="style-guides"></a>
## Style Guides

  * Code writing Style Guides are often used by development teams to keep code in a consistent style
  * Style guides typically have two types of rules:
    * Formatting and aesthetic: indentation, spacing, single v double quotes, etc. Consistently formatted code is easier to read.
    * Best Practice: how to perform type coercions, define variables with hoisting rules, etc. Following best practice rules helps avoid pitfalls that can lead to bugs.
    * The [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript) is a popular and recommended guide

<a name="basic-rules"></a>
## Basic Rules
<a name="spacing"></a>
### Spacing

  * Use soft tabs set to two spaces
  * Place one space before a leadng brace
  * Place one space before opening parens in control statments (`if`, `while`, etc).
  * Place no space between the argument list and function name in function calls and declarations
  * Set off operators with spaces
  * Do not add spaces inside parens
  * Unaray special-character operators (`!`, `++`, etc) must not have spaces between then and their operand
  * No preceding spaces before `,` and `;`
  * No whitespace at the end of line or blank lines
  * The `?` and `:` in a ternary conditional must have space on both sides
  * Ternaries should not be nested and should generally be single line expressions
  * Avoid unneeded ternary statements

**Examples:**

```javascript
// space before leading brace

function myFunction() {
  // function definition
}

// space before parens in control statement, no space between arg list and function name

if (true) {
  doThing();
}

function doThing() {
  console.log('Thing');
}

// set off operators with spaces

var x = y + 5;

// ternary conditional spacing

var maybe1 > maybe2 ? 'bar' : null;
```

<a name="blocks"></a>
### Blocks

  * Leave a blank line after blocks and before the next statement
  * Do not pad your blocks with blank lines
  * Use braces with all mullti-line blocks
  * Mutli-line block `if..else` statments should have `else` on the same line as the `if` block's closing brace

**Examples:**

```javascript
// blank line after blocks

if (foo) {
  return bar;
}

return baz;

// else aligned with block

if (test) {
  thing1();
  thing2();
} else {
  thing3();
}
```

<a name="semicolons"></a>
### Semicolons

  * Use semi-colons after every statement except for statements ending with blocks

<a name="naming-conventions"></a>
### Naming Conventions

  * Use camelCase var and function names

**Examples:**

```javascript
var hello = 'hello';
var myName = 'john';
function callMe() {};
```

<a name="strings"></a>
### Strings

  * Use single quotes `''` for strings
  * Use explicit coercion

**Examples:**

```javascript
// explicit coercion

var a = 9;

var string = String(a);
```

<a name="numbers"></a>
### Numbers

  * Use `Number` for type casting and `parseInt` always with radix for parsing strings

**Examples:**

```javascript
var inputValue = '4';

var val = Number(inputValue);

var val = parseInt(inputValue, 10);
```

<a name="boolean"></a>
### Boolean

  * Use the `Boolean()` function or double bang `!!` for conversion to boolean

**Examples:**

```javascript
var age = 0;

// bad
var hasAge = new Boolean(age);

// good
var hasAge = Boolean(age);

// best
var hasAge = !!age;
```

<a name="functions"></a>
### Functions

  * Never declare a function in a non-function block (`if`, `while`, etc), use assignment to an anonymous function instead
  * Never name a parameter `arguments`; this takes precedence over the `argumetns` object that is given to every function scope

**Examples:**

```javascript
// function declaration in  a non-function block

// bad
if (currentUser) {
  function test() {
    console.log('Nope.');
  }
}

// good
var test;
if (currentUser) {
  test = function() {
    console.log('Yup.');
  };
}
```
