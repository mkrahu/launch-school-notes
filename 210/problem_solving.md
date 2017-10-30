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
