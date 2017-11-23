# Number Methods

  * [MDN Number Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number)

### `Number.prototype.toString()`

  * Returns a string representing the specified number object
  * [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toString)

#### Parameters

  * A radix between 2 and 36, which specifies the base to use for representing numeric values. If no radix is supplied, JavaScript will infer the radix from the number on which the method is called

#### Return Value

  * A string representation of the number on which the method is called

#### Example

```JavaScript
var num = 5;
num.toString(10); // returns '5'
num.toString(2); // returns '101'
```

### `Number.parseInt()`

  * Parses a string and returns an integer of the specified radix/ base
  * [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/parseInt)

#### Parameters

  * A string to parse.
    * If the argument passed in is not a string it is first converted to a string by the `ToString` internal operation
    * Leading whitespaces in the string are ignored
  * An optional radix between 2 and 36, which specifies the base to use for representing numeric values. If no radix is supplied, JavaScript will infer the radix from the number on which the method is called

#### Return Value

  * An integer number parsed from the string
  * If the first character of the string cannot be converted to a number, `NaN` is returned

#### Example

```JavaScript
Number.parseInt('5', 10); // returns 5
Number.parseInt('5.01', 10); // returns 5
Number.parseInt('010'); // returns 10
Number.parseInt('010', 2); // returns 2
```

### `Number.parseFloat()`

  * Parses a string and returns a foating point number
  * [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/parseFloat)

#### Parameters

  * A string to parse.

#### Return Value

  * An floating point number number parsed from the string
  * If the value cannot be converted to a number, `NaN` is returned

#### Example

```JavaScript
Number.parseFloat('5.01'); // returns 5.01
Number.parseFloat('5'); // returns 5
```

### `Number.isInteger()`

  * Determines if a passed in value is an integer
  * [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isInteger)

#### Parameters

  * A value to be tested

#### Return Value

  * `true` if the tested value is an integer
  * `false` if the tested value is not an integer

#### Example

```JavaScript
Number.isInteger(5); // returns true
Number.isInteger(5.01); // returns false
Number.isInteger('5.01'); // returns false
Number.isInteger('5'); // returns false
```

### `Number.isNaN()`

  * Determines if a passed in value is `NaN` and it's type is `Number`
  * [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isNaN)

#### Parameters

  * A value to be tested

#### Return Value

  * `true` if the tested value is `NaN` and its type is `Number`
  * `false` if the tested value is not `NaN` or its type is not `Number`

#### Example

```JavaScript
Number.isNaN(NaN); // returns true
Number.isInteger(5); // returns false
Number.isInteger('hello'); // returns false
Number.isNaN('NaN'); // returns false
```
