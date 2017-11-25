{-
Main.hs

Created by Geoffrey Natin on 15/11/2017

https://github.com/nating/interactive-shape-server/src/Main.hs
-}

{-# LANGUAGE OverloadedStrings #-}

module Main where

import Render
import Web.Scotty
import Data.Either
import Data.Either.Utils
import Text.Blaze.Svg.Renderer.Utf8 (renderSvg)
import qualified Data.ByteString.Base64 as Base64
import qualified Data.ByteString.Char8 as ByteStringChar8

{-
ServeSvg wraps up a Blaze SVG with with the appropriate headers to be sent back as an HTTP response.
-}
serveSvg svg = do
    setHeader "Content-Type" "image/svg+xml"
    setHeader "Vary" "Accept Encoding"
    raw $ renderSvg svg

{-
The program serves an HTML page on port 3000.

Any HTTP GET requests to port 3000 will recieve the index page.

The index page contains a text input area where users can describe SVG shapes.
When the users enter their description, a POST request is made to the server.
The POST request of shape descriptions contains the description of the shapes
encoded in Base64. The encoding allows the descriptions (which may contain spaces and
new lines) to be passed through the URL without the need for the padding and parsing
of escape characters or sequences.

The server will attempt to decode the URL of any HTTP POST requests made to it
as if it is Base64. If the URL is successfully decoded, the server will attempt
to read the decoded URL in as a `Drawing` (see Render.hs) and create an SVG to
send back in the HTTP response.
-}
main = scotty 3001 $ do
  get "/" $ file "static-files/index.html"
  post "/:base64-shapes" $ do
    base64Shapes <- param "base64-shapes"
    case isRight $ Base64.decode base64Shapes of
        True ->  do
            serveSvg $ createSvgFromDrawing $ read $ ByteStringChar8.unpack $ fromRight $ Base64.decode base64Shapes
        False ->  do
            return ()
