module Shapes(
  Shape, 
  --Point, Vector, 
  Transform, 
  --Drawing,
  --point, getX, getY,
  empty, circle, square,
  identity, translate, rotate, scale, (<+>)
  --,inside
  )  where

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)

{-
-- Utilities

data Vector = Vector Double Double
              deriving Show
vector = Vector

cross :: Vector -> Vector -> Double
cross (Vector a b) (Vector a' b') = a * a' + b * b'

mult :: Matrix -> Vector -> Vector
mult (Matrix r0 r1) v = Vector (cross r0 v) (cross r1 v)

invert :: Matrix -> Matrix
invert (Matrix (Vector a b) (Vector c d)) = matrix (d / k) (-b / k) (-c / k) (a / k)
  where k = a * d - b * c
        
-- 2x2 square matrices are all we need.
data Matrix = Matrix Vector Vector
              deriving Show

matrix :: Double -> Double -> Double -> Double -> Matrix
matrix a b c d = Matrix (Vector a b) (Vector c d)

getX (Vector x y) = x
getY (Vector x y) = y

-- Shapes

type Point  = Vector

point :: Double -> Double -> Point
point = vector
-}

--------------Shapes------------------

data Shape = Empty 
           | Circle 
           | Square
             deriving Show

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
             deriving Show

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

{-
-- Drawings

type Drawing = [(Transform,Shape)]

-- interpretation function for drawings

inside :: Point -> Drawing -> Bool
inside p d = or $ map (inside1 p) d

inside1 :: Point -> (Transform, Shape) -> Bool
inside1 p (t,s) = insides (transform t p) s

insides :: Point -> Shape -> Bool
p `insides` Empty = False
p `insides` Circle = distance p <= 1
p `insides` Square = maxnorm  p <= 1


distance :: Point -> Double
distance (Vector x y ) = sqrt ( x**2 + y**2 )

maxnorm :: Point -> Double
maxnorm (Vector x y ) = max (abs x) (abs y)

testShape = (scale (point 10 10), circle)
-}