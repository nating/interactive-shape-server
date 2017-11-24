{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Data.Monoid (mconcat)
import Text.Blaze.Svg11 ((!), mkPath, rotate, l, m)
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as A
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import Data.ByteString.Base64
import Data.Either
import Data.Either.Utils
import Data.ByteString.Lazy.Char8
import Debug.Trace

import Render

serveSvg svg = do
    setHeader "Content-Type" "image/svg+xml"
    setHeader "Vary" "Accept Encoding"
    raw $ renderSvg svg

deg :: String -> String
deg s = trace ("this is the decoded text:"++show s) s

main = scotty 3000 $ do
  get "/not-using-rn" $ do
    serveSvg $ createSvg "lnakwn"
  get "/" $ file "static-files/index.html"
  post "/:base64-shapes" $ do
    base64Shapes <- param "base64-shapes"
    case isLeft $ decode base64Shapes of
        True ->  serveSvg $ createSvgFromDrawing $ read $ deg $ fromLeft $ decode base64Shapes
        False -> serveSvg $ createSvgFromDrawing $ read $ deg "\"[(scale 5 6,circle)]\""

{-
  post "/gave-up-on-for-now" $ do
    svgJson <- rescue jsonData return
    case lookup ("shapes" svgJson) of
        Just shapes -> serveSvg $ createSvgFromJson shapes
        Nothing -> return --TODO: Add code here to return an error to the user

        

        -}