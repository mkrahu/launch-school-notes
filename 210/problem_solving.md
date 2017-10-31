# A General Problem Solving Approach

* [The PEDAC Problem Solving Process](#built-in-objects)
  * [Tips](#tips)
  * [Understand the Problem](#problem)
  * [Examples and Test Cases](#examples)
  * [Data Structure](#data-structure)
  * [Algorithm](#algorithm)
  * [Code](#code)

<a name='overview'></a>
## The PEDAC Problem Solving Process

  * **Problem**: Analyse and understand the problem
  * **Examples**: Write out examples and test cases
  * **Data Structure**: Decide what data structure(s) are required?
  * **Algorithms**: Write a step-by-step solution in pseudocode
  * **Code**: Translate the pseudocode solution into code

<a name='tips'></a>
### Tips

  * Don't rush to code
  * Spend time with the problem before spending time on the solution
  * Make sure you clearly understand all of the requirements

<a name='problem'></a>
### Understanding the Problem

  * Requirements can be explicit or implicit
    * Implicit knowledge needs to be captured and modeled
    * As questions for clarification when necessary
    * Take notes
  * Write a list of 'rules' the the solution has to follow, based on the problem requirements
    * To help come up with explicit rules, it can help to work through an example and then try to generalise it
  * Identify and define important terms and concepts
  * The bulk of 'understanding the problem' involves translating the problem into a specific and explicit set of definitions and rules
  * Problem requirements can vary. They may already be given in explicit 'technical terms'; they may be expressed in higher-level 'problem domain' terms, or use implied knowledge that must be captured

<a name='examples'></a>
### Examples and Test Cases

  * A test case is an example of how some code can be used
  * Test cases usually have a combination of the *input* value that the problem accepts, and the desired *output*
  * Test cases are defined by the rules of the problem
    * Should decide on what the input to method/ function is and what the required output is
      * What are the data types
      * With strings do you need to handle uppercase and lowercase
      * Is the output of the function just the return value or should it print/ output something to the screen
  * Test cases serve *two* purposes:
    * Help you to understand the problem. Working through the test cases forces you to fully understand the requirements and explore the edges of the requirements
    * Allow you to verify the solution. Test cases give us runnable code that we can use to verify that we ave successfully solved the problem
  * To come up with good test cases you should:
    * Focus on input
      * Can the method/ function handle different types of input? (numbers, strings, booleans)
      * Does input need to be verified?
  * Look for edge cases
    * Do we need to account for empty input (nil/ null, "", [], {}, etc.)
    * If the input is a number, do we need to work with zeros, negative numbers, or fractional numbers?
    * What are the boundary conditions, e.g. if there is a range of possible inputs, what is the highest and lowest points of that range? Test for these.
    * Ensure that test cases cover both general requirments and special cases/ edge cases
    * Look for the word 'if' in the problem description and ensure that both 'sides' of the condition are covered
  * Error cases/ failure/ bad input: how to deal with these
    * Raise an exception or Error
    * Return a special value (nil/ null, "", [], {}, etc.)
    * Use guard clauses to return early with non-standard cases

<a name='data-structure'></a>
### Data Structure

  * The primary concern with the choice of data structure is how to represent data so that we can best utilize built-in abstractions of teh programming language
  * The data structure that you work with is based on a few things:
    * The input data, i.e the raw input.
    * The required final output
    * The rules and requirements of the problem
    * E.g. if the input and output are both a string, then the internal data structure might be a string. But if you need to do something with every word or character, then you might need to convert it to an array in order to work witht he data more easily.
  * Typical data structures (unless using custom objects) are:
    * String
      * If the problem requirements are such that you need to concat, strip, reverse, etc.. then using a string as an internal data structure might be appropriate
      * A major advantage of using a string is that you can use Regular Expressions. This is useful for propblems where you need to treat certain characters in a particular way, e.g. remove punctuation, etc.
    * Array
      * Arrays are appropriate as an internal data structure if you need to walk throught he data in a sequenctial manner, or need to refer to sub-sets of the data via a sequential (indexed) position
      * Arrays have a numebr of useful built in abstractions:
        * map
        * reduce
        * select/ filter
        * all /any
        * sort
        * etc..
    * Hash/ object
      * This is an appropriate internal data structure when you need to implement a lookup table/ dictionary
    * Number
      * Numbers are appropriate internal data structures when you need to do some sort of mathematical operations
      * Depending on the input and the requirements, having numbers as strings (and converting them when you need to) might be more advantageous.
      * If the input is a number in string form, but you don't need to do any mathematical calculation, then keeping it at as string might be more appropriate
    * Compound Data Structures
      * Sometimes you might need to use compund structures to express the requirements of the problme, such as an array of arrays, or a hash/ object with arrays as values
    * Data structures can sometimes be used to represent some of the rules of the problem (e.g. a lookup table for mapping values to input)

<a name='algorithms'></a>
### Algorithms

  * Algorithms have to be described in the language of the chosen data structure. This helps with the step of translating the pseudocode to code.
    * You might refer by name to abstractions relevant to the data structure. For example, if the structure is an array you might say in your algorithm that you need to map or reduce the array, etc.
  * The aim of the algorithm should be to provide a logical and clearly defined and-to-end path from the input to the output.
    * The main goal of the algorithm step is devide how to convert the input data into the data structure of choice, and then express the steps to produce the required output by using methods and abstractions available to the data structure type
    * The algorithm is somewhere in between the requirements breakdown and actual code. It uses language much closer to the actual coding language that will be used.
    * Once the algorithm is written, it should be a simple process to then translate it to code
  * In order to be able to write good algorithms, it's important to be fluent with the various data structures and their important methods:
    * String/ Regex
    * Array
      * Ruby: Enumerable
      * Javascript: Higher Order Functions
    * Hash/ Object
      * Creation
      * Access
      * Iteration
  * The more familiar you are with these data types and their methods (existing abstractions), the easier it is to describe the algorithm/ solution at a higher level of abstraction
    * Rely on built-in language abstractions that exists as methods of various data types
    * Avoid solving big problems! Using abstractions helps break the problem down.
  * Abstractions allow you to lay out the general steps of an algorithm without having to go into details about the implementation; e.g. saying 'map' is simpler than saying 'transform each item in the array into an equivalent item according to some logic as defined in an iterative operation'.
  * If there aren't any in-built abstractions for a process step that you need, you can still write your algorithm using abstractions but create a helper method or function to encapsulate that abstractions
  * The implementation detals should be pushed to the methods/ functions, and the algorithm should deal with the problem at a high level
  * The algorithm should be verified using examples and test cases

<a name='code'></a>
### Code

  * With clearly written rules and breakdown of the problem, well worked out test cases and a well structured algorithm, translating the solution into code *should* be a straightforward step
  * If this step is difficult then it may be tht you haven't clearly understood and modeled the problem domain
  * When coding, run your code often to verify the assumptions of the various rules in your breakdown and the sequential steps of your algorithm
  * You can run test cases to verify and debug your solution
