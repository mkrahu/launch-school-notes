# Object Creation Patterns

  * [Introduction](#introduction)
  * [Factory Functions](#factory-functions)
  * [Constructor Pattern](#factory-functions)
  * [Objects and Prototypes](#objects-prototypes)
  * [Prototypal Inheritance and Behavior Delegation](#prototypal-inheritance-behaviour-delegation)
  * [Constructors and Prototypes](#constructors-prototypes)
  * [Constructors, Prototypes, and the Prototype Chain](#prototype-chain)
  * [The Pseudo-classical Pattern and the OLOO Pattern](#pseudo-classical-oloo)
  * [More Methods on the Object Constructor](#object-constructor-methods)

<a name="introduction"></a>
## Introduction

  * Unlike other mainstream languages, JavaScript doesn't implement behaviour sharing using class-based inheritance
  * JavaScript instead uses something called the *object prototype* to share properties
  * This concept of inheritance via the object prototype forms the basis for object-creation patterns that feature behaviour sharing

<a name="factory-functions"></a>
## Factory Functions

  * A basic way to create objects in JavaScript is to use object literals.
  * If you are creating a lot of similar objects, this approach can lead to a lot of repetition in your code.

**Example**

```
var joe = {
  firstName: 'Joe',
  lastName: 'Brown',
  fullName: function() {
    return (this.firstName + ' ' + this.lastName).trim();
  }
}

var jane = {
  firstName: 'Jane',
  lastName: 'Smith',
  fullName: function() {
    return (this.firstName + ' ' + this.lastName).trim();
  }
}
```

  * In the example above, the two person objects have the same properties and methods, and this causes repetition in the code
  * We can use 'factory functions' (also called the 'Factory Object Creation Pattern' or just the 'Factory Pattern') to create objects based on a pre-defined template

**Example**

```
function createPerson(firstName, lastName) {
  var person = {};
  person.firstName = firstName;
  person.lastName = lastName || '';
  person.fullName = function() {
    return (this.firstName + ' ' + this.lastName).trim();
  };

  return person;
}


var joe = createPerson('Joe', 'Brown');
var jane = createPerson('Jane', 'Smith');

// note: the function could just return an object literal
function createPerson(firstName, lastName) {
  return {
    firstName: firstName,
    lastName: lastName || '',
    fullName: function() {
      return (this.firstName + ' ' + this.lastName).trim();
    },
  };
}
```

  * The factory pattern lets us create objects of the same 'type' vary easily.
  * This pattern does have some disadvantages:
    * Every object created by the function has a full copy of the methods, which can be redundant
    * There isn't a way to inspect an object and know how it was created (i.e. by which function), for example if we wanted to identify its 'type'.

<a name="factory-functions"></a>
## Constructor Pattern

  * Another object creation pattern is the 'Constructor Pattern'.
  * The Constructor Pattern uses the `new` operator to call a constructor function
  * When a function is called with the `new` operator, the following happens:
    1. A new object is created
    2. `this` within the function is set to point to the newly created object
    3. The code in the function is executed
    4. `this` (i.e. the new object) is implicitly returned if there is no explicit return

**Example**

```
function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName || '';
  this.fullName = function() {
    return (this.firstName + ' ' + this.lastName).trim();
  };
}

var joe = new Person('Joe', 'Brown');
var jane = new Person('Jane', 'Smith');
```

  * The constructor function `Person` in the above example, is just a normal JavaScript function
  * The fact that the function's name is capitalised is not a syntactical requirement, but a convention used to indicate that it is a constructor function and should be called with the `new` operator.
  * If we call the function without the `new` operator, it behaves just like a normal function, and implicitly returns `undefined`

**Example**

```
var joe = Person('Joe', 'Brown');
joe; // undefined. The function implicitly return undefined
joe.fullName(); // TypeError: Cannot read property 'fullName' of undefined
```

  * Since `new` isn't used, no new object is created, and `this` isn't set to the new object, therefore `this` is the global obeject. The properties assigned to `this` by the function are assigned to the global object (which is the `window` object in browsers)

**Example**

```
window.firstName; // 'Joe'
window.fullName(); // 'Joe Brown'
```

### The `constructor` property

  * All objects inherit a property called `constructor`. This points to the constructor of that object.
  * When we create an object using literal notation, `constructor` points to the built in `Object` object. This is because the syntax for an object literal is an expression that describes the initialization of an `Object` (source: [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#Description)).

**Example**

```
var myObj = {};
myObj.constructor === Object; // true
```

  * This also holds true if the literal was created by a Factory Function

**Example**

```
function createObj() {
  return {};
}
var myObj = createObj(); // returns {}
myObj.constructor === Object; // true
```

  * However, if we create an object using a constructor function called with the `new` operator, the `constructor` property points to that function instead of `Object`

**Example**

```
function createObj() {
}
var myObj = new createObj(); // returns {}
myObj.constructor === Object; // false
myObj.constructor === createObj; // true
```

  * This aspect of the Constructor Pattern avoids one of the disadvantages of the Factory Pattern, in that we can determine *how* an object was created in order to determine its 'type'.

<a name="objects-prototypes"></a>
## Objects and Prototypes

### The `Object` object

  * JavaScript has a [built in object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object) called `Object`.
  * The `Object` object is unusual in that it is a constructor for other objects, and can also be called as a Function

  * We can call `Object` using the `new` operator, just like we would do with a constructor function we'd defined ourselves. This creates an empty object.

**Example**

```
var myObj = new Object();
myObj; // {}
```

  * We can also simply call `Object()` as a function without the `new` operator. Unlike a constructor function we've defined ourselves, this returns an empty object rather than `undefined`

**Example**

```
var myObj = Object();
myObj; // {}
```

  *

https://codeburst.io/various-ways-to-create-javascript-object-9563c6887a47

### The `instanceof` operator

<a name="prototypal-inheritance-behaviour-delegation"></a>
## Prototypal Inheritance and Behavior Delegation


<a name="constructors-prototypes"></a>
## Constructors and Prototypes


<a name="prototype-chain"></a>
## Constructors, Prototypes, and the Prototype Chain


<a name="pseudo-classical-oloo"></a>
## The Pseudo-classical Pattern and the OLOO Pattern


<a name="object-constructor-methods"></a>
## More Methods on the Object Constructor
