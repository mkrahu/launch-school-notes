# Objects

  * [Objects and Methods](#objects-methods)
  * [Mutating Objects](#mutating-objects)
  * [Functions as Object Factories](#functions-object-factories)
  * [Object Orientation](#object-orientation)

<a name="objects-methods"></a>
## Objects and Methods

  * Objects can contain properties and methods. A method is essentially a property whose value is a function
  * Methods are functions which have a specific *receiver* (the object where they are called on)
    * Functions invoked **with** an explicit receiver are methods (method invocation)
    * Functions invoked **without** an explicit receiver are functions (function invocation)

**Example**

```
var myObj = {
  hello: function () {
    console.log('Hello');
  }
};

function goodbye() {
  console.log('Goodbye');
}

myObj.hello(); // method invocation: myObj is the receiver/calling object

goodbye(); // function invocation: no explicit receiver
```

  * Just because a function is defined as a property of an object, that doesn't mean it *has* to be called as a method. We can assign that function to a variable using a function expression, and then call it as we would do any other function.

**Example**

```
var myObj = {
  hello: function () {
    console.log('Hello');
  }
};

var functionHello = myObj.hello;

functionHello(); // function invocation: no explicit receiver
```

### `this` during Method Invocation

  * During method invocation, `this` is a reference to the calling object

**Example**

```
var myObj = {
  someProp: 5,
	someMethod: function() {
		console.log(this);
    },
  logProp: function() {
		console.log(this.someProp);
    }
}

myObj.someMethod(); // logs myObj
myObj.logProp(); // logs 5
```

<a name="mutating-objects"></a>
## Mutating Objects

  * JavaScript has different types of values such as String, Number, Array, Object, etc.
  * These types of values can be split into two groups: Primitive Types and Compound or Object Types

### Primitive Types

  * The following data types are Primitive types: String, Number, Boolean, Null, Undefined. In ES6 there is also Symbol
  * Primitive types are a single value; i.e. they don't have properties.
  * Primitive types are immutable; i.e. they cannot be mutated, only reassigned.

**Example**

```
var a = 1;
var b = a; // b is also 1, but this a copy rather than the 1 assigned to a

a = 2; // reassigns a to 2, but doesn't affect the value of b

b; // returns 1 because b is still assigned to 1
```

### Object Types

  * Object types include: Objects, Array, Functions
  * Object types are sometimes called compound data because they are made up of properties
  * Because they have properties, object types are mutable; i.e. we *change* a property of the object rather than reassigning to a new object

**Example**

```
var myObj = { a: 1 };
myObj.a = 2;
myObj; // { a: 2 } this is the same object originally assigned to `myObj`, only the property `a` has changed
```

  * Note: if we were to reassign, then the object would be new object with a separate set of properties

**Example**

```
var myObj = { a: 1 };
var myObj = { a: 2 }; // this is a new object with it's own `a` property
```

  * Object types are sometimes called *reference* types because when they are assigned to a variable, it is a reference to the actual object in memory that is assigned. This is in contrast to primitive types where the primitive value is assigned.

**Example**

```
var a = 1; // value `1` is created, assigned to variable a, and stored on the memory stack
var b = a; // another value `1` is created (copied from the value assigned to a), assigned to b and stored on the stack
// at this point there are two values of the number 1 stored on the stack with different vars assigned to them

var myObj = { a: 1 }; // the object is created on the memory heap. What is assigned to the var myObj is actually a reference
// to the object on the heap; the reference is stored on the stack.
// what is happening here is actually more like this:
var myObj = myObjRef => { a: 1 } // myObjRef is stored on the stack and points to the object on the heap
```

### Object Mutability

  * The fact that JavaScript stores references to objects is important for object mutability, because if we assign the same object to another variable the two variables both have a copy of the object reference which points to the same object on the heap

**Example**

```
var myObj = { a: 1 };
var myObj2 = myObj; // myObj2 is assigned to a copy of the reference to the object
// at this point there are two identical values for the object reference stored on the stack
// but both point to the same object on the heap

// what is happening here is actually more like this:
var myObj = myObjRef => { a: 1 }
var myObj2 = myObjRef => { a: 1 } // another `myObjRef` is created (copied from the value assigned to `myObj`)
// but this points to the SAME object on the heap

// since both variables reference the SAME object, they can both be used to access and change that object's properties
myObj2.a = 2;
myObj2; // { a: 2 }
myObj; // { a: 2 }
```

  * Watch [this video](https://www.youtube.com/watch?v=9ooYYRLdg_g) for a more in-depth explanation

### Passing Variables to Functions

  * The way object mutability works is important for how objects are dealt with when we pass variables as function arguments
  * We can think of JavaScript as a pass-by-value language, in that copies of the values assigned to variables are passed to functions.
    * It might *seem* that JavaScript acts like pass-by-reference or call-by-sharing in the case of objects, but this is because the values copied in this case are actually *references* to the actual object on the heap.

**Example: Primitives as Function Arguments**

```
function changeVal(value) {
  value = 2;
}

var a = 1;
changeVal(a);
a; // a is still 1 for 2 reasons:
// 1) JavaScript passes in a copy of the value 1 which is assigned to the param `value` in the function
// 2) Primitives are immutable, so even if the actual value were passed in rather than a copy, we couldn't change it, just reassign it
```

**Example: Objects as Function Arguments**

```
function changeVal(obj) {
  obj.a = 2;
}

var myObj = { a: 1 };
changeVal(myObj);
myObj; // { a: 2 }
// when we pass `obj` to changeVal, we are actually passing a copy of the the reference to the object, not a copy of the object itself
// what is happening here is actually more like this:

var myObj = myObjRef => { a: 1 };
changeVal(myObjRef);
// within the function, the param obj is assigned to `myObjRef`, which points to the same object as `myObj` does outside the function.
// So when we reassign the `a` property of the object in the function, this affects the object itself and not just a copy of it.
```

### Objects as Object properties

  * Object properties can either be Primitive values or other Objects
  * These values behave in the same way as object properties as they would do if assigned to a variable
    * Properties whose values are primitives are not mutable, they can only be reassigned
    * Properties whose values are objects actually have a reference to the object as their value, not the object itself, these properties are therefore mutable.

**Example**

```
var myObj = {
  a: 1,
  b: [1, 2, 3]
}

myObj.a = 2; // the value of the a property cannot be mutated, but a can be reassigned to another value
myObj.b.pop(); // calling the Array.pop() method on b mutates the array to which the reference assigned to b points

myObj; // { a: 2, b: [1, 2] } a has been assigned a new value, whereas the array referenced by b has been mutated
```

  * This is an important thing to understand when making copies of objects
    * For properties that have primitive values, copying the value creates a new primitive
    * For properties that have object/ reference values, copying the value creates a new reference to the same object

**Example**

```
var myObj = {
  a: 1,
  b: [1, 2, 3]
}

var myObj2 = Object.assign({}, myObj);
// Object.assign copies the values of all enumerable own properties from one or more source objects to a target object.
// Here we are copying the values of myObj to an empty object
// myObj2 is a NEW object with the same properties as myObj

myObj2.a = 2; // this affects only the value of a in myObj2
myObj2.b.pop(); // this affects the array referenced by b in both myObj2 AND myObj

myObj; // { a: 1, b: [1, 2] } a is still 1 here, but a number has been removed from the b array
myObj2; // { a: 2, b: [1, 2] } a is 2 here and a number has been removed from the b array
```

<a name="object-orientation"></a>
## Object Orientation

  * Objected-oriented programming is a pattern that uses objects as the basic building blocks of a program instead of variables and functions

**Example**

```
// imagine that we need to store some values about a car. We could just use variables like this

var fuel = 7.9;
var mpg = 37;

// if we need to store values for multiple vehicles, we would need multiple variables. THese would need to be named in a way that identifies which variable goes with which vehicle

var smallCarFuel = 7.9;
var smallCarMpg = 37;

var largeCarFuel = 9.4;
var largeCarMpg = 29;

var truckFuel = 14.4;
var truckMpg = 23;

// with an Objected-oriented approach, we would group these values into objects using properties

var smallCar = {
  fuel: 7.9,
  mpg: 37,
};

var largeCar = {
  fuel: 9.4,
  mpg: 29,
};

var truck = {
  fuel: 14.4,
  mpg: 23,
};
```

  * Grouping values like this into objects also makes it easier if we need to interact with those values in a context where the grouping logically fits the interaction

**Example**

```
// say we want to calculate a vehicle's range using its fuel and mpg values
// without objects, we could define a function and call that function passing in the different sets of varaibles each time

function vehicleRange(fuel, mpg) {
  return fuel * mpg;
}

vehicleRange(smallCarFuel, smallCarMpg); // => 292.3
vehicleRange(largeCarFuel, largeCarMpg); // => 272.6
vehicleRange(truckFuel, truckMpg);       // => 331.2

// with an oo approach, we define our function in a way that interacts with the properties of an object passed into the function

function vehicleRange(vehicle) {
  return vehicle.fuel * vehicle.mpg;
}

vehicleRange(smallCar);     // => 292.3
vehicleRange(largeCar);     // => 272.6
vehicleRange(truck);        // => 331.2
```

  * We can go further still by defining the function as a property of the object and then calling that function as a method with the object as the receiver.

**Example**

```
var smallCar = {
  fuel: 7.9,
  mpg: 37,
  range: function() {
    return this.fuel * this.mpg;
  },
};

smallCar.range();   // => 292.3
```

  * Using objects to group together attributes and behaviours can make code easier to read an maintain. Objects:
    * organize related data and code together.
    * are useful when a program needs more than one instance of something.
    * become more useful as the codebase size increases.

  * Object oriented code makes these questions easier to answer:
    * What are the important concepts in the program?
    * What are the properties of a vehicle?
    * How do we create vehicles?
    * What operations can I perform on a vehicle?
    * Where should we add new properties and methods?

<a name="functions-object-factories"></a>
## Functions as Object Factories

  * Organising data into objects can have many benefits, but doing this alone can still lead to a lot of duplication. For example we have to define the properties and methods in each object we create:

**Example**

```
var smallCar = {
  fuel: 7.9,
  mpg: 37,
  range: function() {
    return this.fuel * this.mpg;
  },
};

var largeCar = {
  fuel: 9.4,
  mpg: 29,
  range: function() {
    return this.fuel * this.mpg;
  },
};

var truck = {
  fuel: 14.4,
  mpg: 23,
  range: function() {
    return this.fuel * this.mpg;
  },
};
```

  * One thing we can do is use a function to create objects that have the same properties nad methods, but store different values for those properties

**Example**

```
function makeVehicle(fuel, mpg) {
  return {
    fuel: fuel,
    mpg: mpg,
    range: function() {
      return this.fuel * this.mpg;
    },
  };
}

var smallCar = makeVehicle(7.9, 37);
smallCar.range();   // => 292.3

var largeCar = makeVehicle(9.4, 29);
largeCar.range();   // => 272.6

var truck = makeVehicle(14.4, 23);
truck.range();      // => 331.2
```

  * This approach of using functions to create objects is known as the **factory pattern** of object creation
  * There are other object creation patterns, and each have their pros and cons
