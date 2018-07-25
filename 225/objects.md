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

<a name="functions-object-factories"></a>
## Functions as Object Factories

<a name="object-orientation"></a>
## Object Orientation
