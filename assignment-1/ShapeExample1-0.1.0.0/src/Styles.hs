module Styles where

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)

import Color

-----------Styles------------
--TODO: Add more AttributeValues 
-- https://hackage.haskell.org/package/blaze-svg-0.3.6.1/docs/Text-Blaze-Svg11-Attributes.html

data Style = Fill Color
           | FillOpacity Double
           | StrokeWidth Double
           | StrokeColor Color
           | StyleCompose Style Style
             deriving (Show,Read)

fill = Fill
fillOpacity = FillOpacity
strokeWidth = StrokeWidth
strokeColor = StrokeColor
s0 <-> s1 = StyleCompose s0 s1

style :: Style -> [S.Attribute]
style (Fill c)             = [A.fill $ S.stringValue (show c)]
style (FillOpacity d)      = [A.fillOpacity $ S.stringValue (show d)]
style (StrokeWidth d)      = [A.strokeWidth $ S.stringValue (show d)]
style (StrokeColor c)      = [A.stroke $ S.stringValue (show c)]
style (StyleCompose s0 s1) = style s0 ++ style s1