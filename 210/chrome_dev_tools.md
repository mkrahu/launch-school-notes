# Chrome Developer Tools

* [Overview](#overview)
* [The Debugger](#the-debugger)
* [Code Snippets](#code-snippets)
* [Resources](#resources)

<a name="overview"></a>
## Overview

### Accessing Dev Tools

  * To access Dev Tools in Chrome browser, you can:
    * Right-click on a web page and select 'Inspect'
    * Select 'More Tools > Developer Tools' from the Chrome menu button (top right)

### Sources Tab

  * The 'Sources' tab:
    * Makes the JavaScript code running on a webpage visible
    * Provides a number of different debugging tools and controls

### Console

  * To view the 'Console' within the Sources tab layout, hit the `Esc` key
  * The console will will display any JavaScript output from JavaScript code running in the page being inspected

#### Running JavaScript in the console

  * You can type JavaScript code into the console and it will be evaluated
  * You can access any existing function or any functions or variables within the scope of execution of a currently accessible source
  * Pressing `Enter` after typing code into the console automatically executes that code
  * You can type multi-line code by pressing `Shift-Enter` to move to a new line
  * For multi-line code it is usually easier to edit it ina separate file. This could be:
    *  An `.html` file with `<script>` tags containing the JavaScript code
    * A separate `.js` file linked from the `.html` file

<a name="the-debugger"></a>
## The Debugger

  * The Debugger is a window showing JavaScript code and a set of controls for manipulating that code

#### Accessing a JavaScript File

  * To access the code n a JavaScript file, click on the file in the file-tree of the sources window

#### Debugger Controls

  * Debugger controls are visible in the right-hand window
  * Step Through controls are displayed along the top of the debugger controls
  * The 'Play/ Pause' button is used along with the debugger. Clicking on it when paused will continue running from where it was paused until it hits another breakpoint or the program completes
    * When a script is paused, the values of local variables defined in the code at the current point of execution will be displayed (highlighted in orange). These also show in the 'Scope'
  * The 'Step Over Next Function Call' control allows you to step through the code and evaluate each function one at a time. Clicking it once moves forward a step.
  * The 'Step into Next Function Call' control is similar, but allows to to drill into a function to see what is happening within it rather than just evaluating what happens when it runs
  * The 'Step Out of Current Function' control moves out of a function the you have stepped into
  * Rather than stepping through every line one by one, you can right click on a line and select 'Continue to here'. DevTools runs all of the code up to that point, and then pauses on that line.
  * The 'Pause on Exceptions' control causes the program to automatically pause when an exception is encountered. When active it is highlighted in blue. If active and an exception is encountered, execution pauses at the line of code that is abiout to rais the exception and provides the error within the 'Call Stack' area. Clicking on the 'Play/ Pause' button then runs the code and the exception is raised

#### Current State controls

  * 'Call Stack' indicates where in the program execution is currently paused, and the rest of the functions up the stack. This allows you to step back through the execution of the program
  * 'Scope Values' displays the values of local variables defined in the code at the current point of execution
  * 'Breakpoints' displays any breakpoints that you have set in your code. Yiou can manage your breakpoints here bby disabling/ enabling or removing them (either check or uncheck a specific breakpoint, or right-click on a specific breakpoint or in the 'Breakpoints' window for a contextual menu)

#### Creating a Line of Code Breakpoint

  * A Line of Code Breakpoint marks a place that the browser is going to stop executing the code and pause in order to allow a developer to inspect the state of the page. Execution is stopped *before* the line of code is executed
  * A Breakpoint can be set by clicking on line number in the code window (breakpoint line numbers are displayed in blue)
  * After adding a Breakpoint the page should be reloaded, which then re-run the js until the the breakpoint is reached
    * Where the Breakpoint is set, the debugger highlights in blue the code that is about to be executed
    * The 'Play/ Pause' step-through control will be highlighted in blue to indicate that the script is paused
  * Conditional Line of Code Breakpoints can be created by right-clicking the line number and selecting 'Add conditional breakpoint' (these are displyed in orange rather than blue)

**Note:** you can acheive a similar effect to Line of Code Breakpoints by adding debugger statement (`debugger;`) in the actual code file and saving it (debugger statements should be removed before pushing code to production)

<a name="code-snippets"></a>
## Using Code Snippets

  * Google Chrome developer Tools has a code snippets feature that allows you to quickly write, test, save and re-use code snippets

### Creating a Code Snippet

  * Select the 'Snippets' tab in the file tree window of 'Sources'
  * Right-click and select 'New' and typing a name
  * You can then edit the snippet file in the file window

### Running a Code Snippet

  * You can run a code snippet by:
    * Using the 'Play/ Pause' control
    * Hitting `CTRL + Enter`
  * You can quickly access existing snippets by using the `CTRL + O` shortcut and typing the name of the snippet

<a name="resources"></a>
## Resources

  * [Docs: Breakpoints](https://developers.google.com/web/tools/chrome-devtools/javascript/breakpoints)
  * [Docs: Stepping Through Code](https://developers.google.com/web/tools/chrome-devtools/javascript/reference#stepping)
  * [Article: Using Code Snippets](https://www.alexkras.com/using-code-snippets-to-test-save-and-reuse-javascript-code-in-chrome-developer-tools/)
