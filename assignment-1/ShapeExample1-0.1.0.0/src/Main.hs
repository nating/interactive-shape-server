{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import qualified Data.ByteString.Base64 as Base64
import qualified Data.ByteString.Char8 as ByteStringChar8
import Data.Either
import Data.Either.Utils

import Render

serveSvg svg = do
    setHeader "Content-Type" "image/svg+xml"
    setHeader "Vary" "Accept Encoding"
    raw $ renderSvg svg

main = scotty 3000 $ do
  get "/" $ file "static-files/index.html"
  post "/:shape-input-encoded-using-base64" $ do
    base64Shapes <- param "shape-input-encoded-using-base-64"
    case isRight $ Base64.decode base64Shapes of
        True ->  do
            serveSvg $ createSvgFromDrawing $ read $ ByteStringChar8.unpack $ fromRight $ Base64.decode base64Shapes
        False ->  do
            return ()
