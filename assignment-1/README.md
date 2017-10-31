# Functional Programming Assignment 1

## Specification

1.1 Extend the Shape DSL to support a new type of transformation that affects not the size and position of a shape but it's colour and shading.
1.2 Implement at least two transformations that support this style. ( examples given are: affect the thickness of the lines that the shape is drawn with, and specify that a shape should be drawn with a shaded interior ) 
2. Use the BlazeSVG DSL to provide an interpretation function for our Shape language that can convert Shapes to SVG documents
3. Use the Scotty package to create a Haskell web service which can (1) accept a text description of a diagram (in our Shape language) and (2) return an SVG to the browser for that diagram (i.e wrap up the interpretation from step 2 in a web service).