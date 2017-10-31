# Functional Programming Assignment 1

## Specification

1. 
 * Extend the Shape DSL to support a new type of transformation that affects not the size and position of a shape but it's colour and shading.  
 * Implement at least two transformations that support this style. ( examples given are: affect the thickness of the lines that the shape is drawn with, and specify that a shape should be drawn with a shaded interior ) 
2. Use the BlazeSVG DSL to provide an interpretation function for our Shape language that can convert Shapes to SVG documents
3. Use the Scotty package to create a Haskell web service which can (1) accept a text description of a diagram (in our Shape language) and (2) return an SVG to the browser for that diagram (i.e wrap up the interpretation from step 2 in a web service).


## Notes
* To parse the shape input, just have the compiler derive a "Read" instance for the necessary types and use that.  
* Suitably document it by writing it as a literate Haskell program.
* It's OK to make any changes that you feel you need to the EDSL so long as you motivate them clearly in the documentation. 
* Justify all changes to the initial code that you make
* Only modify Shape.hs. You probably don’t need to edit any other file. You only need the shape language.
