{-# LANGUAGE OverloadedStrings #-}

module Render where
import Shapes
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import Data.Text.Lazy

-- render a drawing into a window
createSvg :: String -> S.Svg
createSvg s = svgDoc--createSvgFromDrawing testDrawing

createSvgFromDrawing :: Drawing -> S.Svg
createSvgFromDrawing x = S.docTypeSvg ! A.version "1.1" ! A.width "500" ! A.height "500" ! A.viewbox "0 0 5 5" $ do
      createSvgShapes x

createSvgShapes :: [(Transform,Shape)] -> S.Svg
createSvgShapes [(t,s)] = svgShape s ! svgTransform (Shapes.transform t) 
createSvgShapes (x:xs) = ( createSvgShapes [x] ) >> ( createSvgShapes xs )

svgShape :: Shape -> S.Svg
svgShape Empty = S.rect
svgShape Circle = S.circle ! A.width "1" ! A.height "1"
svgShape Square = S.rect ! A.width "1" ! A.height "1"

svgTransform :: [S.AttributeValue] -> S.Attribute
svgTransform x = A.transform $ mconcat $ x


--------------Example blaze-svg code-----------------

svgDoc :: S.Svg
svgDoc = S.docTypeSvg ! A.version "1.1" ! A.width "500" ! A.height "500" ! A.viewbox "0 0 5 5" $ do
    S.g ! A.transform makeTransform $ do
      S.circle ! A.width "1" ! A.height "2" ! A.fill "#008d46"
      S.rect ! A.width "1" ! A.height "2" ! A.fill "#ffffff"
      S.rect ! A.width "1" ! A.height "2" ! A.fill "#d2232c"
      S.path ! A.d makePath

makePath :: S.AttributeValue
makePath = mkPath $ do
  l 2 3
  m 4 5

makeTransform :: S.AttributeValue
makeTransform = S.rotate 50

--TODO: maybe take the original rendering of their input and add to it when they put more input in?
