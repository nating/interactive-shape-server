{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_ShapeExample1 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/users/ugrad/nating/functional/assignment-1/ShapeExample1-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/bin"
libdir     = "/users/ugrad/nating/functional/assignment-1/ShapeExample1-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/lib/x86_64-linux-ghc-8.0.2/ShapeExample1-0.1.0.0"
dynlibdir  = "/users/ugrad/nating/functional/assignment-1/ShapeExample1-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/users/ugrad/nating/functional/assignment-1/ShapeExample1-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/share/x86_64-linux-ghc-8.0.2/ShapeExample1-0.1.0.0"
libexecdir = "/users/ugrad/nating/functional/assignment-1/ShapeExample1-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/libexec"
sysconfdir = "/users/ugrad/nating/functional/assignment-1/ShapeExample1-0.1.0.0/.stack-work/install/x86_64-linux/lts-9.12/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ShapeExample1_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ShapeExample1_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ShapeExample1_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ShapeExample1_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ShapeExample1_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ShapeExample1_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
