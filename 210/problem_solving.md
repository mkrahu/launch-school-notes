# A General Problem Solving Approach



## The PEDAC Problem Solving Process

  * **Problem**: Analyse and understand the problem
  * **Examples**: Write out examples and test cases
  * **Data Structure**: Decide what data structure(s) are required?
  * **Algorithms**: Write a step-by-step solution in pseudocode
  * **Code**: Translate the pseudocode solution into code

### Tips

  * Don't rush to code
  * Spend time with the problem before spending time on the solution
  * Make sure you clearly understand all of the requirements


### Understanding the Problem

  * Requirements can be explicit or implicit
    * Implicit knowledge needs to be captured and modeled
    * As questions for clarification when necessary
    * Take notes
  * Write a list of 'rules' the the solution has to follow, based on the problem requirements
  * Identify and define important terms and concepts

### Examples and Test Cases

  * Test cases are defined by the rules of the problem
    * Should decide on what the input to method/ function is and what the required output is
      * What are the data types
      * With strings do you need to handle uppercase and lowercase
      * Is the output of the function just the return value or should it print/ output something to the screen
  * Test cases serve *two* purposes:
    * Help you to understand the problem
    * Allow you to verify the solution
  * Look for edge cases
    * Focus on input - does input need to be verified?
    * Do we need to account for empty input (nil/ null, "", [], {}, etc.)
    * What are the boundary conditions, e.g. if there is a range of possible inputs, what is the highest and lowest points of that range? Test for these.
  * Error cases/ failure/ bad input: how to deal with these
    * Raise an exception or Error
    * Return a special value (nil/ null, "", [], {}, etc.)
    * Use guard clauses to return early with non-standard cases

### Data Structure

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

### Algorithms

  * Algorithms have to be described in the language of the chosen data structure. This helps with the step of translating the pseudocode to code.
    * You might refer by name to abstractions relevant to the data structure. For example, if the structure is an array you might say in your algorithm that you need to map or reduce the array, etc.
  * The aim of the algorithm should be to provide a logical and clearly defined and-to-end path from the input to the output.
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

### Code
