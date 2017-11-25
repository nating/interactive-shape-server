module Shapes where

data Shape = Empty 
           | Circle 
           | Square
             deriving (Show,Read)

empty, circle, square :: Shape
empty = Empty
circle = Circle
square = Square