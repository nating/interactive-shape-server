module Transforms where

import qualified Text.Blaze.Svg11 as S

-----------Transformations------------
--TODO: Add more AttributeValues 
--http://support.hfm.io/1.5/api/blaze-svg-0.3.6.1/Text-Blaze-Svg.html

data Transform = Identity
           | Translate Double Double
           | Scale Double Double
           | Rotate Double
           | SkewX Double
           | SkewY Double
           | Compose Transform Transform
             deriving (Show,Read)

identity = Identity
translate = Translate
scale = Scale
rotate angle = Rotate
skewX = SkewX
skewY = SkewY
t0 <+> t1 = Compose t0 t1

transform :: Transform -> [S.AttributeValue]
transform Identity           = [S.scale 1 1]
transform (Translate tx ty)  = [S.translate tx ty]
transform (Scale sx sy)      = [S.scale sx sy]
transform (Rotate angle)     = [S.rotate angle]
transform (SkewX d)          = [S.skewX d]
transform (SkewY d)          = [S.skewY d]
transform (Compose t1 t2)    = transform t2 ++ transform t1
