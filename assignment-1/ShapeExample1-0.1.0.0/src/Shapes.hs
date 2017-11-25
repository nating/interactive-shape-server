{-
Shapes.hs

Created by Geoffrey Natin on 15/11/2017

https://github.com/nating/interactive-shape-server/src/Shapes.hs
-}

module Shapes where

data Shape = Empty 
           | Circle 
           | Square
             deriving (Show,Read)