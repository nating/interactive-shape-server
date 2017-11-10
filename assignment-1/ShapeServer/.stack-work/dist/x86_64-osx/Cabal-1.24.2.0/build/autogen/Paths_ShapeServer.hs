{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_ShapeServer (
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

bindir     = "/Users/GeoffreyNatin/Documents/GithubRepositories/functional/assignment-1/ShapeServer/.stack-work/install/x86_64-osx/lts-9.12/8.0.2/bin"
libdir     = "/Users/GeoffreyNatin/Documents/GithubRepositories/functional/assignment-1/ShapeServer/.stack-work/install/x86_64-osx/lts-9.12/8.0.2/lib/x86_64-osx-ghc-8.0.2/ShapeServer-0.1.0.0"
dynlibdir  = "/Users/GeoffreyNatin/Documents/GithubRepositories/functional/assignment-1/ShapeServer/.stack-work/install/x86_64-osx/lts-9.12/8.0.2/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/GeoffreyNatin/Documents/GithubRepositories/functional/assignment-1/ShapeServer/.stack-work/install/x86_64-osx/lts-9.12/8.0.2/share/x86_64-osx-ghc-8.0.2/ShapeServer-0.1.0.0"
libexecdir = "/Users/GeoffreyNatin/Documents/GithubRepositories/functional/assignment-1/ShapeServer/.stack-work/install/x86_64-osx/lts-9.12/8.0.2/libexec"
sysconfdir = "/Users/GeoffreyNatin/Documents/GithubRepositories/functional/assignment-1/ShapeServer/.stack-work/install/x86_64-osx/lts-9.12/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ShapeServer_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ShapeServer_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ShapeServer_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ShapeServer_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ShapeServer_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ShapeServer_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
