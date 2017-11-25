module Styles where

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A

import Color

data Style = Fill Color
           | FillOpacity Double
           | StrokeWidth Double
           | StrokeColor Color
           | StyleCompose Style Style
             deriving (Show,Read)

style :: Style -> [S.Attribute]
style (Fill c)             = [A.fill $ S.stringValue (show c)]
style (FillOpacity d)      = [A.fillOpacity $ S.stringValue (show d)]
style (StrokeWidth d)      = [A.strokeWidth $ S.stringValue (show d)]
style (StrokeColor c)      = [A.stroke $ S.stringValue (show c)]
style (StyleCompose s0 s1) = style s0 ++ style s1