{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Data.Monoid (mconcat)
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)

import Shapes
import Render (render,defaultWindow)

svg drawing = do
    setHeader "Content-Type" "image/svg+xml"
    setHeader "Vary" "Accept Encoding"
    raw $ renderSvg drawing

{-

main = scotty 3000 $ do
  get "/:word" $ svg svgDoc
-}
main = scotty 3000 $ do
  get "/" $ file "static/index.html"
  get "/example" $ file "static/example.html"


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