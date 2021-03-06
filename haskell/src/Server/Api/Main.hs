{-# LANGUAGE OverloadedStrings #-}

module Server.Api.Main (handleRoot) where

import Server.Core
import Control.Monad (msum)
import Happstack.Server
import qualified Server.Api.V0.Main as V0

handleRoot :: ServerConfiguration -> ServerResources -> ServerPart Response
handleRoot serverConfiguration serverResources = msum
    [ dir "v0" $ V0.handleRoot serverConfiguration serverResources
    ]
