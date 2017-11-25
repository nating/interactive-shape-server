{-# LANGUAGE OverloadedStrings #-}

module Render where

import Shapes
import Styles

import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import Data.Text.Lazy

-- render a drawing into a window
createSvg :: String -> S.Svg
createSvg s = svgDoc--createSvgFromDrawing testDrawing

createSvgFromDrawing :: Drawing -> S.Svg
createSvgFromDrawing x = S.docTypeSvg ! A.version "1.1" ! A.width "500" ! A.height "500" ! A.viewbox "0 0 50 50" $ do
      createSvgShapes x

createSvgShapes :: [(Transform,Shape,Style)] -> S.Svg
createSvgShapes [(tr,sh,st)] = Prelude.foldl (!) (svgShape sh) ( (svgTransform (Shapes.transform tr)) : (Styles.style st) )
createSvgShapes (x:xs) = ( createSvgShapes [x] ) >> ( createSvgShapes xs )

svgShape :: Shape -> S.Svg
svgShape Empty = S.rect
svgShape Circle = S.circle ! A.r "1"
svgShape Square = S.rect ! A.width "1" ! A.height "1"

svgTransform :: [S.AttributeValue] -> S.Attribute
svgTransform t = A.transform $ mconcat $ t


type Drawing = [(Transform,Shape,Style)]
testDrawing = [(Scale 5 5,Circle,Fill (read "Red"))]


--TODO: maybe take the original rendering of their input and add to it when they put more input in?
