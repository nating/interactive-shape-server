module Transforms where

import qualified Text.Blaze.Svg11 as S

data Transform = Identity
           | Translate Double Double
           | Scale Double Double
           | Rotate Double
           | SkewX Double
           | SkewY Double
           | Compose Transform Transform
             deriving (Show,Read)

transform :: Transform -> [S.AttributeValue]
transform Identity           = [S.scale 1 1]
transform (Translate tx ty)  = [S.translate tx ty]
transform (Scale sx sy)      = [S.scale sx sy]
transform (Rotate angle)     = [S.rotate angle]
transform (SkewX d)          = [S.skewX d]
transform (SkewY d)          = [S.skewY d]
transform (Compose t1 t2)    = transform t2 ++ transform t1
