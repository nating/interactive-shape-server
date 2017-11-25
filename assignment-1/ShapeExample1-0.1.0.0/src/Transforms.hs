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

transformToAttributes :: Transform -> [S.AttributeValue]
transformToAttributes Identity           = [S.scale 1 1]
transformToAttributes (Translate tx ty)  = [S.translate tx ty]
transformToAttributes (Scale sx sy)      = [S.scale sx sy]
transformToAttributes (Rotate angle)     = [S.rotate angle]
transformToAttributes (SkewX d)          = [S.skewX d]
transformToAttributes (SkewY d)          = [S.skewY d]
transformToAttributes (Compose t1 t2)    = transformToAttributes t2 ++ transformToAttributes t1
