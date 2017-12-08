# A General Apprach to Problem Solving

## Understand the Problem

  * Fully read the problem description
  * If necessary, rewrite the problem description in more *explicit* language. Some of the problem requirements may be *implicitly* expressed in the problem description
  * Identify and define any important terms and concepts

## Examples and Test Cases

  * For iterative type problems, or transformation/ creation of data, it can be useful to work through a problem with a step-by-step example of the transformational process
  * If tests are provided, check if they cover all of the necessary cases
    * If not add more tests to cover all cases
    * Identify edge/ corner cases:
      * Is input validation required?
      * Do you need t test for empty/ null input?
      * What are the boundary conditons? (max or min input). Test for these.
      * Is repetition or duplication of data an issue?
      * What data types can be expected as input?
    * Decide how to deal with bad input
      * Raise an exception / report an error
      * return a special value (null, 0, '', [], etc..)
  * Ask questions to verify understanding

## Data Structures

  * Look at the input data and required output data
  * Are any intermediate data structures required?
  * Choice of data structure often depends on what you need to do with the data:
    * String: concat, slice, reverse, use regex to match or replace
    * Array: iterate or walk thorugh, use abstractions like map, reduce, select, some, all, etc..
    * Hash: can be used as a lookup table
    * Number: Used for mathematical operations
    * Compound structures are sometimes useful (array or array, hash with array values)

## Algorithm

  * Describe the algorithm in the language of the chosen data structure (split the string,map the array, etc..)
  * Walk through the solution step by step to make sure that you have every requirement covered
  * Verify the algorithm with test cases

## Code

  * Run code early and often
  * Test individual lines or ideas in console (or irb/ pry for Ruby)
  * Think about scope, return value, side effects, mutation
