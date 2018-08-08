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
  * The `Object` object is a global object that is used as a constructor for other objects.
  * We can call `Object` using the `new` operator, just like we would do with a constructor function we'd defined ourselves. This creates an empty object.

**Example**

```
var myObj = new Object();
myObj; // {}
myObj.constructor === Object; // true
```

  * We can also call `Object()` as a function without the `new` operator. Unlike a constructor function we've defined ourselves, this returns an empty object rather than `undefined`

**Example**

```
var myObj = Object();
myObj; // {}
myObj.constructor === Object; // true
```

  * When we define an object literal, this is using the *initializer notation* of `Object` to create a new object
  * An object initializer is an expression that describes the initialization of an Object (source: [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#Description))
  * This is functionally equivalent to using `Object` as a constructor or calling it as a function

**Example**

```
var myObj = {};
myObj; // {}
myObj.constructor === Object; // true
```

  * The advantage of using the literal or initializer notation is that you can quickly create objects with properties.

**Example**

```
var myObj = {
  a: 1,
  b: 2,
  total: function() {
    return this.a + this.b;
  }
};
```

  * Another way of creating objects is to use the `create` method of `Object`.
  * The `create` method takes a required argument, which must be another object or `null` (note: additionally the `create` method can take an optional argument, a properties object, which defines the newly created object's properties)

**Example**

```
var myObj = Object.create({});
myObj; // {}
myObj.constructor === Object; // true
```

### The `__proto__` property

  * Every JavaScript object has a `__proto__` property (pronounced 'dunder proto' for double-underscore proto)
  * This property always points to another object, which acts as a prototype of the object
  * When the `Object.create` method is used to create a new object, the value of the newly created object's `__proto__` property is set to the object passed in the required argument.
  * This is different from the value of the `constructor` property. With `Object.create`, the value of `constructor` is always `Object`, but the value of `__proto__` is set to the object passed in.

**Example**

```
var myObj = Object.create({});
myObj; // {}
myObj.constructor === Object; // true

var myObj2 = Object.create(myObj);
myObj2.constructor === Object; // true
myObj2.__proto__ === Object; // false
myObj2.__proto__ === myObj; // true
```

  * The `Object` object has a property called `prototype`.
  * The `Object.prototype` property represents the `Object` prototype object (i.e. the prototype object of `Object`)
  * When using literal syntax, or `Object` as a constructor or function, `__proto__` is set to this `Object.prototype` object

**Example**

```
var myObj = {};
myObj.__proto__ === Object.prototype; // true

var myObj2 = new Object;
myObj2.__proto__ === Object.prototype; // true

var myObj3 = Object();
myObj2.__proto__ === Object.prototype; // true
```

### Prototype Chain

  * We can use `Object.create` to create objects that form a prototype chain

**Example**

```
var myObj = {};
var myObj2 = Object.create(myObj);
var myObj3 = Object.create(myObj2);
var myObj4 = Object.create(myObj3);

myObj4.__proto__ === myObj3; // true
myObj3.__proto__ === myObj2; // true
myObj2.__proto__ === myObj; // true
myObj.__proto__ === Object.prototype; // true
```

  * The `Object.prototype` object is at the end of the prototype chain for all JavaScript objects.

#### Object.getPrototypeOf and isPrototypeOf

  * The `__proto__` proeerty is a non-standard object property introduced in Firefox. In the JavaScript specification this property is defined as `[[Prototype]]`, which is not a property you can interact with directly.
  * Although `__proto__` is standard in ES6 and supported in most modern browsers, for backwards compatibility reasons, it is best avoided in production code.
  * There are two methods that can be used instead of relying on `__proto__`
    * `Object.getPrototypeOf(obj)` can be used to get the prototype of the object passed in to the method
    * `obj.isPrototypeOf(otherObj)` is a method of `Object.prototype` and can check if the calling object is on the *prototype chain* of the object passed in to the method

**Example**

```
var myObj = {};
var myObj2 = Object.create(myObj);
var myObj3 = Object.create(myObj2);
var myObj4 = Object.create(myObj3);

Object.getPrototypeOf(myObj4) === myObj3; // true
Object.getPrototypeOf(myObj4) === myObj2; // false myObj2 isn't the protype of myObj4
myObj2.isPrototypeOf(myObj4); // true myObj2 is above myObj4 on its protype chain
```

<a name="prototypal-inheritance-behaviour-delegation"></a>
## Prototypal Inheritance and Behavior Delegation

  * When we try to access a property or method on an object, JavaScript first searches in the object itself, then searches in every object in up the protype chain until the end of the chain is reached

**Example**

```
var myObj = {
  a: 1,
  b: 2,
  hello: function() {
    console.log('hello');
  }
};

var myObj2 = Object.create(myObj);
var myObj3 = Object.create(myObj2);
var myObj4 = Object.create(myObj3);
myObj4.a; // 1
myObj4.b; // 2
myObj4.c; // undefined
myObj4.hello(); // logs 'hello'
```

  * Because `Object.prototype` is *usually* (unless we create an object from `null`) the 'final' point in the chain, all objects inherit from `Object.prototype`

**Example**

```
var myObj = {};
Object.getPrototypeOf(myObj) == Object.prototype; // true
var myObj2 = Object.create(myObj);
Object.getPrototypeOf(myObj2) == myObj; // true
Object.prototype.isPrototypeOf(myObj2); // true
```

  * Because all objects ultimately inherit from `Object.prototype`, all objects have access to its properties and methods

**Example**

```
var myObj = {a: 1};
var myObj2 = Object.create(myObj);
myObj2.a; // 1
myObj2.hasOwnProperty('a'); // false
// hasOwnProperty is a method of Object.prototype and so accessible to myObj2
// it returns false here since 'a' is a property of myObj not myObj2, even though it has access to it thorugh inheritance from myObj
```

  * If `null` is passed in as an argument to `Object.create` then the value of `__proto__` is set to `undefined`.

**Example**

```
var myObj = Object.create(null);
myObj.a = 1;
var myObj2 = Object.create(myObj);
myObj2.a; // 1
myObj2.hasOwnProperty('a'); // TypeError: myObj2.hasOwnProperty is not a function
// myObj2 has no access to the hasOwnProperty method since Object.prototype is not part of its prototype chain
```

### Execution context of inherited methods

  * Like all functions (in ES5 at least) the execution context of an inherited method (i.e. `this`) determined by how the method is called, not where it is defined

**Example**

```
var myObj = {
  hello: function() {
    return 'hello '  + this.name;
  }
};

var karl = Object.create(myObj);
karl.name = 'karl';
var world = Object.create(myObj);
world.name = 'world';

karl.hello(); // 'hello karl' this here is the karl object
world.hello(); // 'hello world' this here is the world object
```

### Prototypal Inheritance vs Behaviour Delegation

  * JavaScript's protype chain lookup for properties allows us to store data and behaviours anywhere on an object's prototype chain and have that object access it.
  * This is a powerful way to share data and behaviours, allowing us to cut down on duplication

**Example**

```
var dog = {
  speak: function() {
    console.log(this.name + ' says woof!');
  }
};

// we can use the dog object as a protype to share behaviours will multiple other objects

var fido = Object.create(dog);
fido.name = 'Fido';
fido.speak(); // 'Fido says woof'

var spot = Object.create(dog);
spot.name = 'Spot';
spot.speak(); // 'Spot says woof'
```

  * This pattern is sometimes referred to as JavaScript's **Prototypal Inheritance**, since it seems similar to the class-based inheritance models of languages such as Java, Ruby, Python, etc.
  * However, JavaScript isn't 'class oriented'. Objects can be created from any other objects and become part of that object's protype chain
  * From a run-time point of view, it copuld be said that objects at the bottom of the chain 'delegate' requests to upstream objects. This design pattern is therefore perhaps more accurately referred to as **Behaviour Delegation**.

### Over-riding Default Behaviour

  * Objects created from prototypes can over-ride shared behaviours by defining the same methods locally

**Example**

```
var dog = {
  speak: function() {
    console.log(this.name + ' says woof!');
  }
};

// we can use the dog object as a protype to share behaviours will multiple other objects

var fido = Object.create(dog);
fido.name = 'Fido';
fido.speak(); // 'Fido says woof!'

var spot = Object.create(dog);
spot.name = 'Spot';
spot.speak = function() {
  console.log(this.name + ' says woof woof woof!');
};
spot.speak(); // 'Spot says woof woof woof!'
```

### Methods on Object.prototype

  * Since `Object.prototype` is at the top of the prototype chain for all JavaScript objects, all of its methods can be called by any JavaScript object. For example:
    * `Object.prototype.toString()`: returns a string representation of the object
    * `Object.prototype.isPrototypeOf(obj)`: tests if the object is in another object's prototype chain
    * `Object.prototype.hasOwnProperty(prop)`: tests whether the property is defined on the object itself

### Object.getOwnPropertyNames

  * Another way of checking if a property is defined on an object is to use the `getOwnPropertyNames` method of object.
  * Calling this method and passing in an object as an arguments returns an array of the property names of the object passed in

**Example**

```
var myObj = {a: 1};
var myObj2 = Object.create(myObj);

myObj.a; // 1
myObj2.a; // 1

Object.getOwnPropertyNames(myObj); // ['a']
Object.getOwnPropertyNames(myObj2); // [] (empty array)
```
<a name="constructors-prototypes"></a>
## Constructors and Prototypes

  * In JavaScript all **constructors** have a special property called `prototype`. This property points to an object that has a `constructor` property that points back to the constructor.
  * For example, the `constructor` property of the `Object.prototype` object points to `Object`

**Example**

```
var objectPrototype = Object.prototype;
objectPrototype.hasOwnProperty('constructor'); // true
objectPrototype.constructor === Object; // true
```

  * This also holds true for custom constructors, such as functions that we define. In this case, when we define the function, an object is instantiated and assigned to the `prototype` property, and the `constructor` property of that object initialized with the function as its value

**Example**

```
function MyConstructor() {};
var funcPrototype = MyConstructor.prototype;
funcPrototype.hasOwnProperty('constructor'); // true
funcPrototype.constructor === MyConstructor; // true
```

  * The object referenced by a function's `prototype` property is only useful when the function is used as a constructor. In this case, all the objects that it constructs will have that prototype object set as the value of their `__proto__` property
  * Since those objects now have that prototype object on their prototype chain, they have access to the `constructor` property of that prototype object, which points to the constructor (in this case the function)

**Example**

```
function MyConstructor() {};
var funcPrototype = MyConstructor.prototype;

var myObj1 = new MyConstructor;
var myObj2 = new MyConstructor;

Object.getPrototypeOf(myObj1) === funcPrototype; // true
Object.getPrototypeOf(myObj2) === funcPrototype; // true

funcPrototype.constructor === MyConstructor; // true
myObj1.constructor === MyConstructor; // true
myObj2.constructor === MyConstructor; // true
```

  * The object to which the constructor's `prototype` property points is known as "the constructor function's prototype object."
  * It's important to note that this is **not** the prototype object of the constructor itself (which is assigned to it's `__proto__` property), but the prototype object of all the objects that the constructor creates.

**Example**

```
function MyConstructor() {};
MyConstructor.__proto__ === MyConstructor.prototype; // false

var myObj1 = new MyConstructor;
Object.getPrototypeOf(myObj1) === MyConstructor.prototype; // true
```

### Adding properties to the `prototype` object

  * Since the `prototype` object is just like any other JavaScript object, we can add properties to it

**Example**

```
function MyConstructor() {};
MyConstructor.prototype.a = 1;
MyConstructor.prototype.a; // 1
```

  * We can use the `prototype` object in order to set up behaviour delegation for objects created by a constructor

**Example**

```
function Dog() {};
Dog.prototype.speak = function() {
  console.log(this.name + ' says woof!');
};

var fido = new Dog;
fido.name = 'Fido';

var spot = new Dog;
spot.name = 'Spot';

fido.speak(); // 'Fido says woof!'
spot.speak(); // 'Spot says woof!'
```

  * In the above example, all objects created by the `Dog ` constructor share the behaviours on the object assigned to the constructor's `prototype` property
  * This approach of sharing behaviours is called the 'Prototype Pattern' of object creation

<a name="prototype-chain"></a>
## Constructors, Prototypes, and the Prototype Chain

  * Since the value of the `prototype` property is just an object, we can assign other custom objects to that property
  * By doing this we can create a 'Prototype Chain' of various objects that share behaviours to create more specialised objects at the bottom of the chain and more general ones at the top

### Using the object returned by a constructor

  * Using this method we can simply assign the `prototype` property of an object to another object returned by a constructor

**Example**

```
function Animal(type) {
  this.type = type;
}

Animal.prototype.move = function() {
  console.log(this.name + ' is moving.');
};

function Dog(name) {
  this.name = name;
}
Dog.prototype = new Animal('land');

Dog.prototype.speak = function() {
  console.log(this.name + ' says woof!');
};

fido = new Dog('Fido');
fido.move(); // 'Fido is moving.'
fido.speak(); 'Fido says woof!'
```

  * In the above example, the `prototype` property of the `Dog` constructor is set to the object returned by the `Animal` constructor.
  * The `fido` instance of `Dog` has access to the `speak` method created on the object assigned to the `prototype` property of `Dog` (i.e. the `Animal` instance object), but also to the `move` method created on the object assigned to the `prototype` property of `Animal`
  * We can even add new methods to the object assigned to the prototype propert of `Animal`, and these will be accessible to our `fido` instance object of `Dog`.

**Example**

```
Animal.prototype.sleep = function() {
  console.log(this.name + ' is sleeping.');
};

fido.sleep(); // 'Fido is sleeping.'
```

  * Something to be aware of with this approach is that attributes of the object returned by the constructor are also accesible to any objects created by a constructor with that object as the value of its `prototype` property

**Example**

```
fido.type; // 'land'
```

### Using the object created by `Object.create`

  * When you call `Object.create` and pass in an object, a new object is created with the value of its `__proto__` property set to the object passed in
  * Since we can pass in any object to `Object.create`, and the object assigned to `prototype` is just like any other JavaScript object, we can referece this object and pass it in.

**Example**

```
function Animal(type) {
  this.type = type;
}

Animal.prototype.move = function() {
  console.log(this.name + ' is moving.');
};

function Dog(name) {
  this.name = name;
}
Dog.prototype = Object.create(Animal.prototype);

Dog.prototype.speak = function() {
  console.log(this.name + ' says woof!');
};

fido = new Dog('Fido');
fido.move(); // 'Fido is moving.'
fido.speak(); 'Fido says woof!'
```

  * In the above example, the `prototype` property of the `Dog` constructor is set to the object returned by `Object.create`. The `__proto__` property of this object is set to the same object assigned to the `Animal` constructor's `prototype` property
  * The `fido` instance of `Dog` has access to the `speak` method created on the object assigned to the `prototype` property of `Dog` (i.e. object returned by `Object.create`), but also to the `move` method created on the object assigned to the `prototype` property of `Animal` (which is the same object assigned to the `__proto__` property of the object returned by `Object.create`)
  * As before, we can add new methods to the object assigned to the prototype propert of `Animal`, and these will be accessible to our `fido` instance object of `Dog`.

**Example**

```
Animal.prototype.sleep = function() {
  console.log(this.name + ' is sleeping.');
};

fido.sleep(); // 'Fido is sleeping.'
```

  * The above works because the object referenced by `Animal.prototype` is available to the `fido` object via its prototype chain

**Example**

```
fido.__proto__.__proto__ === Animal.prototype; // true
```

  * The difference in using `Object.create` is that unlike using `Animal` as a constructor, the object returned isn't a *direct* instance of `Animal` and so doesn't have access to the attibutes set by the `Animal` constructor

**Example**

```
fido.type; // undefined
```

### The `instanceof` operator

  * The `instanceof` operator tests whether the `prototype` property of a *constructor* appears anywhere in the protype chain of an object

**Example**

```
fido instanceof Dog; // true
```

  * Here, since the the object referenced by `Dog.prototype` is the same as the object referenced by `fido.__proto__`, `instanceof` returns `true`

**Example**

```
fido instanceof Animal; // true
```

  * This is the same story, except with one extra 'link' added in the chain. Since the the object referenced by `Animal.prototype` is the same as the object referenced by the `__proto__` property of the object referenced by `fido.__proto__`, `instanceof` returns `true`. In other words `fido.__proto__.__proto__ === Animal.prototype`

### Resetting the `constructor` property

  * Since the approaches detailed above assign the `prototype` of a constructor to a new object, the value of the `constructor` property of that object will be the constructor that created that object, not the constructor we are setting the value of `prototype` for

**Example**

```
function Animal() {}
function Dog() {}

fido = new Dog;
fido.constructor; // Dog

Dog.prototype = new Animal;

rex = new Dog;
rex.constructor; // Animal
```

  * To avoid this problem, after assigning an object to the `prototype` property of the constructor, we can reassign the value of the `constructor` property of that object to the constructor

**Example**

```
Dog.prototype.constructor = Dog;
rex.constructor; // Dog
```

<a name="pseudo-classical-oloo"></a>
## The Pseudo-classical Pattern and the OLOO Pattern

  * All of these approaches to the use of constructors and prototypes can be combined to provide various 'object creation patterns'.
  * There are a number of different object creation patterns that can be used to create JavaScript objects, but two of the most widely used and robust are the 'Pseudo-classical' pattern and the 'OLOO Pattern'

### The Pseudo-classical Pattern

  * The Pseudo-classical pattern is so called because it mimics the class-based approach found in many other languages such as Ruby and Python
  * JavaScript doesn't have classes, but a similar approach can be created by using this pattern which combines the use of constructors and prototypes
  * Constructors are used to initialize object states with arguments that can be passed into the constructor function
  * Behaviours are shared between like objects by adding them to the constructor's `prototype` object

**Example**

```
function Pet(name, type) {
  this.name = name;
  this.type = type;
}

Pet.prototype.speak = function() {
  console.log(this.name + ' is speaking!');
};

var rex = new Pet('Rex', 'dog');
var goldie = new Pet('Goldie', 'fish');

rex instanceof Pet; // true
goldie instanceof Pet; // true

rex.speak(); // 'Rex is speaking!'
goldie.speak(); // 'Goldie is speaking!'
```

### The OLOO Pattern

  * The OLOO Pattern refers to 'Objects Linking to Other Objects'
  * As an object creation pattern it doesn't try and mimic the class-based inheritance patterns of other languages, but instead leverages the fact that in JavaScript we can use `Object.create` to make objects inherit directly from other objects.
  * This pattern is based solely on the use of prototypes, and doesn't use constructors at all

**Example**

```
var Pet = {
  name: null,
  type: null,

  speak: function() {
    console.log(this.name + ' is speaking!');
  },

  init: function(name, type) {
    this.name = name;
    this.type = type;
    return this;
  },
};

var rex = Object.create(Pet).init('Rex', 'dog');
var goldie = Object.create(Pet).init('Goldie', 'fish');

Pet.isPrototypeOf(rex); // true
Pet.isPrototypeOf(goldie); // true

rex.speak(); // 'Rex is speaking!'
goldie.speak(); // 'Goldie is speaking!'
```

  * The example above uses an optional `init` method to initialize the properties of the new objects with the arguments passed in
  * For more information on the OLOO pattern, check out [this Stack Overflow question](https://stackoverflow.com/questions/29788181/kyle-simpsons-oloo-pattern-vs-prototype-design-pattern)

### Other Object Creation Patterns

  * There are other patterns that can be used to create objects in JavaScript besides the pseudo-classical and OLOO patterns.
  * [This article](https://john-dugan.com/object-oriented-javascript-pattern-comparison/) compares some of these patterns

<a name="object-constructor-methods"></a>
## More Methods on the Object Constructor

  * There are a number available on `Object` which are useful either on their own or in combination with other methods. A few of them are outlined below.

### `Object.create` + `Object.getPrototypeOf`

  * These methods can be combined to create a prototype chain which mimics classical inheritance
  * `Object.getPrototypeOf` simply returns object assigned to the `[[Prototype]]` property of the object passed into the method. This is the same object assigned to the `prototype` property of the constructor of that object.

**Example**

```
Object.getPrototypeOf([]) === Array.prototype; // true
```

  * We can leverage this fact to pass in that object directly to `Object.create`. That object then gets assigned to the `[[Prototype]]` property of the newly created object. We can then set that new object as the `prototype` value of a constructor

**Example**

```
function NewArray() {}
NewArray.prototype = Object.create(Object.getPrototypeOf([]));
```

  * If we now create an object using our `NewArray` constructor, it now has the `Array.prototype` object on its prototype chain
  * This means that it can access properties on that object

**Example**

```
var newArrObj = new NewArray;
newArrObj.__proto__ === NewArray.prototype; // true
newArrObj.__proto__.__proto__ === Array.prototype; // true

// newArrObj can access properties of Array.prototype
newArrObj.length; // 0
newArrObj.push('a'); // 1
newArrObj.length; // 1
```

  * However, we can add properties to `NewArray.prototype` which are then available to `NewArray` objects but not `Array` objects

**Example**

```
NewArray.prototype.first = function() {
  return this[0];
};

newArrObj.first(); // 'a'
oldArrObj = new Array;
oldArrObj.first(); // TypeError: oldArrObj.first is not a function
```

### `Object.defineProperties`

  * All properties in JavaScript have four attributes:
