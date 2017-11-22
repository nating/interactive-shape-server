{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Data.Monoid (mconcat)
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)

import Render (createSvgFromJson)

serveSvg svg = do
    setHeader "Content-Type" "image/svg+xml"
    setHeader "Vary" "Accept Encoding"
    raw $ renderSvg svg

main = scotty 3000 $ do
  get "/" $ file "static/index.html"
  get "/example" $ file "static/example.html"
  post "/render-input" $ do
    svgJson <- param "postSvgJson"
    serveSvg $ createSvgFromJson svgJson