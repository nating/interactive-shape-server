module Main where

import Server (serve)
import Shapes
import Render (render,defaultWindow)

exampleDrawing =  [ (scale (point 0.5 0.25) <+> translate (point 1.2 0.4), circle) ]

main = serve--render defaultWindow exampleDrawing
