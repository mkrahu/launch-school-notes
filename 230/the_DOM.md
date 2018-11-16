# The DOM

  * [The Document Object Model (DOM)](#dom)
  * [A Hierarchy of Nodes](#node-hierarchy)
  * [Node Properties](#node_properties)
  * [Determining Node Type](#node-type)
  * [Inheritance](#inheritance)
  * [Documentation](#documentation)
  * [Node Traversal](#node-traversal)
  * [Element Attributes](#element-attributes)
  * [Finding DOM Nodes](#finding-nodes)
  * [Traversing Elements](#traversing-elements])
  * [Creating and Moving DOM Nodes](#creating-moving-nodes)
  * [The Browser Object Model (BOM)](#bom)

<a name="dom"></a>
## The Document Object Model (DOM)

  * The Document Object Model (DOM) is an in-memory representation of an HTML document.
  * It provides a way of interacting with a web-page using JavaScript. This fact is leveraged to build modern, interactive user experiences on the web.
  * What the DOM isn't:
    * The HTML code you write. Although this is parsed by the browser and *turned into* the DOM
    * The code you can see in 'View Source' in a browser. This just shows the HTML that makes up the page.
  * What the DOM is:
    * The code you see in a browser's Dev Tools. This is pretty much a visual representation of the DOM.
  * The representation of the DOM shown in Dev Tools may look very similar to HTML code that was written, but there are key differences:
    * The browser can add missing elements/ fix mistakes in the written HTML. These exist in the DOM but not in the source.
    * JavaScript can manipulate the DOM. If you, for example, add some content to an element using JavaScript, this shows in the DOM (visually represented in Dev Tools) but not in the source HTML.
  * AJAX and Templating: this ability of the DOM to be manipulated means we can use AJAX to get data/ content from a source and add it to a webpage, or update part of a page. This can be combined with templating to create interactive web experiences or single page applications
  * JavaScript and the DOM. The DOM isn't part of JavaScript (the language), it is part of the browser; essentially an API for the browser. JavaScript is used to interact with it, but they are separate entities.
  * There are specific [DOM Levels](https://developer.mozilla.org/fr/docs/DOM_Levels) (e.g. 'DOM Level 1') which provide different features. The DOM Level which a particular browser supports indicates which DOM features can be used.

### Sources

  * https://css-tricks.com/dom/
  * http://www.w3.org/TR/DOM-Level-2-Core/introduction.html
  * https://developer.mozilla.org/en-US/docs/DOM/DOM_Reference/Introduction
  * http://en.wikipedia.org/wiki/Document_Object_Model

<a name="node-hierarchy"></a>
## A Hierarchy of Nodes

  * The DOM is a hierarchical tree structure of 'nodes' (imagine each 'branch' of the tree ending in a node):
    * Element nodes represent HTML tags, e.g. `HTML`, `HEAD`, `DIV`, `H1`, `P`, etc.
    * Text nodes represent text that appears in the document
    * Comment nodes represent HTML comments
  * Text nodes can either contain actual text, or they can contain whitespace (such as tabs, newlines, etc.). Text nodes containing whitespace are sometimes referred to as 'empty nodes', but they are still essentially text nodes.
  * Forgetting to count 'empty' text nodes as nodes can lead to bugs. For example, if your code expects to find en element node next to another element node and there is some whitespace between them, the code may end up targetting the wrong node. Although these 'empty' text nodes are not reflected visually in the browser, they **do** exist in the DOM.

<a name="node_properties"></a>
## Node Properties

  * Nodes are objects. As such they can have properties and methods.
  * `document` is a particular type of node which represents the HTML document. Other nodes are 'child nodes' of `document`
  * `document` has a method called `querySelector()`, which returns the first *Element* node that matches the specified selector (passed in as an argument)

**Example**

```
document.querySelector('p'); // this would return the first paragraph element in the document
```

<a name="node-type"></a>
## Determining Node Type

<a name="inheritance"></a>
## Inheritance

<a name="documentation"></a>
## Documentation

<a name="node-traversal"></a>
## Node Traversal

<a name="element-attributes"></a>
## Element Attributes

<a name="finding-nodes"></a>
## Finding DOM Nodes

<a name="traversing-elements]"></a>
## Traversing Elements

<a name="creating-moving-nodes"></a>
## Creating and Moving DOM Nodes

<a name="bom"></a>
## The Browser Object Model (BOM)
