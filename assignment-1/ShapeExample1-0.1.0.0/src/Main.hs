module Main where

import Shapes
import Render (render,defaultWindow)
import Server (serve)

exampleDrawing =  [ (scale (point 0.5 0.25) <+> translate (point 1.2 0.4), circle) ]

main = serve
