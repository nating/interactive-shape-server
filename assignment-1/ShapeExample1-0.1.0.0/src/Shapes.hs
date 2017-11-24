module Shapes where

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)


--------------Shapes------------------

data Shape = Empty 
           | Circle 
           | Square
             deriving (Show,Read)

empty, circle, square :: Shape
empty = Empty
circle = Circle
square = Square

-----------Transformations------------
--TODO: Add more AttributeValues (http://support.hfm.io/1.5/api/blaze-svg-0.3.6.1/Text-Blaze-Svg.html)


data Transform = Identity
           | Translate Double Double
           | Scale Double Double
           | Rotate Double
           | Compose Transform Transform
             deriving (Show,Read)

identity = Identity
translate = Translate
scale = Scale
rotate angle = Rotate
t0 <+> t1 = Compose t0 t1

transform :: Transform -> [S.AttributeValue]
transform Identity                 = [S.scale 1 1]
transform (Translate tx ty)        = [S.translate tx ty]
transform (Scale sx sy)            = [S.scale sx sy]
transform (Rotate angle)           = [S.rotate angle]
transform (Compose t1 t2)          = transform t2 ++ transform t1


-- Drawings

type Drawing = [(Transform,Shape)]

testDrawing = [(scale 5 5,circle)]
