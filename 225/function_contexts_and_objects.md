# Function Contexts and Objects

  * [JavaScript and First-class Functions](#first-class-functions)
  * [The Global Object](#global-object)
  * [Implicit and Explicit Function Execution Contexts](#implicit-explicit-contexts)
  * [Hard Binding Functions with Contexts](#hard-binding-contexts)
  * [Dealing with Context Loss](#context-loss)
  * [The `this` Keyword in JavaScript](#this)

<a name="first-class-functions"></a>
## JavaScript and First-class Functions

  * Understanding function execution context is essential to understanding JavaScript
  * An important thing to understand is that JavaScript has *first-class functions*
    * A programming language is said to have First-class functions when functions in that language are treated like any other variable. For example, in such a language, a function can be passed as an argument to other functions, can be returned by another function and can be assigned as a value to a variable. [Source](https://developer.mozilla.org/en-US/docs/Glossary/First-class_Function)
    * First-class functions have no context when they are defined (i.e. the context is **not** determined lexically)
    * First-class functions receive their context when the program executes them
  * Since JavaScript is both an objiect-oriented language and a language with first-class functions, it must meet the requirements for both. In particular it must let the developer control the function execution context.

<a name="global-object"></a>
## The Global Object

  *

<a name="implicit-explicit-contexts"></a>
## Implicit and Explicit Function Execution Contexts

<a name="hard-binding-contexts"></a>
## Hard Binding Functions with Contexts

<a name="context-loss"></a>
## Dealing with Context Loss

<a name="this"></a>
## The `this` Keyword in JavaScript
