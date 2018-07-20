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

#### Example

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

#### Example

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

#### Example

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

https://www.youtube.com/watch?v=9ooYYRLdg_g

http://jasonjl.me/blog/2014/10/15/javascript/

https://stackoverflow.com/questions/6605640/javascript-by-reference-vs-by-value

<a name="functions-object-factories"></a>
## Functions as Object Factories

<a name="object-orientation"></a>
## Object Orientation
