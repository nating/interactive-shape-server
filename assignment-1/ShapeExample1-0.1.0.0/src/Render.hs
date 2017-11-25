{-
Render.hs

Created by Geoffrey Natin on 15/11/2017

https://github.com/nating/interactive-shape-server/src/Render.hs
-}

{-# LANGUAGE OverloadedStrings #-}

module Render where

import Shapes
import Styles
import Transforms
import Text.Blaze.Svg11 
import Text.Blaze.Svg11.Attributes

createSvgFromDrawing :: Drawing -> Svg
createSvgFromDrawing x = docTypeSvg ! version "1.1" ! width "500" ! height "500" ! viewbox "0 0 50 50" $ do
      createSvgShapes x

createSvgShapes :: [(Transform,Shape,Style)] -> Svg
createSvgShapes [(tr,sh,st)] = Prelude.foldl (!) (svgShape sh) ( (svgTransform (transformToAttributes tr)) : (Styles.style st) )
createSvgShapes (x:xs) = ( createSvgShapes [x] ) >> ( createSvgShapes xs )

svgShape :: Shape -> Svg
svgShape Empty = rect
svgShape Circle = circle ! r "1"
svgShape Square = rect ! width "1" ! height "1"

svgTransform :: [AttributeValue] -> Attribute
svgTransform t = transform $ mconcat $ t

type Drawing = [(Transform,Shape,Style)]