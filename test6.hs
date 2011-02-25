{-# LANGUAGE MultiParamTypeClasses #-}

module Main (
main
)
where 

import Control.Concurrent (forkIO, MVar, newEmptyMVar, putMVar, takeMVar, ThreadId, threadDelay)
import Control.Monad (forever)

{-
class Stream a b where
    stream :: a -> (a -> b) -> b

instance Stream d where
    stream :: IO d -> (IO d -> IO ()) -> IO ()
    stream f g = g . f
-}

(->>) :: IO a -> (a -> IO ()) -> IO ()
f ->> g = f >>= g


-- This simply wraps a string in brackets.
bracket :: String -> String
bracket x = "(" ++ x ++ ")"

-- Just like C's main.
main :: IO ()
main = do
       --forkIO $ getLine >>= putStrLn
       forkIO $ getLine ->> putStrLn
       forkIO $ getLine ->> putStrLn
       --wbracket = lft bracket 
       --getLine ->> wbracket ->> putStrLn 
       threadDelay 10000000 -- Sleep for at least 10 seconds before exiting.

