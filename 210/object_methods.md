# Object Methods

  * [MDN Object Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

### `Object.keys()`

  * Returns an array of the objects enumerable properties (or keys)

#### Arguments

  * An object

#### Return Value

  * An array of strings that represent all the enumerable properties of a given object

#### Example

```JavaScript
var myObject = {
  a: '1',
  b: '2',
  c: '3',
};

Object.keys(myObject); // returns ["a", "b", "c"]
```

### `Object.values()`

  * Returns an array of the values of the objects enumerable properties

#### Arguments

  * An object

#### Return Value

  * An array containing the values of the given object's enumerable properties

#### Example

```JavaScript
var myObject = {
  a: '1',
  b: '2',
  c: '3',
};

Object.values(myObject); // returns ["1", "2", "3"]
```
