{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Data.Monoid (mconcat)
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import qualified Data.ByteString.Base64 as BS
import qualified Data.ByteString.Char8 as B
import Data.Either
import Data.Either.Utils
import Data.ByteString.Lazy.Char8
import Control.Monad.IO.Class

import Render

serveSvg svg = do
    setHeader "Content-Type" "image/svg+xml"
    setHeader "Vary" "Accept Encoding"
    raw $ renderSvg svg

main = scotty 3000 $ do
  get "/not-using-rn" $ do
    serveSvg $ createSvg "lnakwn"
  get "/" $ file "static-files/index.html"
  post "/:base64-shapes" $ do
    base64Shapes <- param "base64-shapes"
    case isRight $ BS.decode base64Shapes of
        True ->  do
            serveSvg $ createSvgFromDrawing $ read $ B.unpack $ fromRight $ BS.decode base64Shapes
        False ->  do
            serveSvg $ createSvgFromDrawing $ read $ "[(Scale 5 6,Circle)]"

{-
  post "/gave-up-on-for-now" $ do
    svgJson <- rescue jsonData return
    case lookup ("shapes" svgJson) of
        Just shapes -> serveSvg $ createSvgFromJson shapes
        Nothing -> return --TODO: Add code here to return an error to the user

        

        -}