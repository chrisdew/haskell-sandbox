{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, TypeSynonymInstances #-}

module Main (
main
)
where 

import Control.Concurrent (forkIO, MVar, newEmptyMVar, putMVar, takeMVar, ThreadId, threadDelay)
import Control.Monad (forever, liftM)

class Stream a b c where
    (->>) :: a -> b -> c

instance Stream (IO d) (d -> IO c) (IO c) where
    f ->> g = f >>= g 

instance Stream d (d -> IO c) (IO c) where
    f ->> g = g f 

{-
(->>) :: IO a -> (a -> IO ()) -> IO ()
f ->> g = f >>= g
-}

-- This simply wraps a string in brackets.
bracket :: String -> String
bracket x = "(" ++ x ++ ")"

lbracket :: IO String -> IO String
lbracket x = liftM bracket x

hello :: String
hello = "Hello World!"

lhello :: IO String
lhello = do return hello

-- Just like C's main.
main :: IO ()
main = do
       --forkIO $ getLine >>= putStrLn
       --forkIO $ lhello ->> lbracket ->> putStrLn
       forkIO $ lhello ->> putStrLn
       --wbracket = lft bracket 
       --getLine ->> wbracket ->> putStrLn 
       threadDelay 10000000 -- Sleep for at least 10 seconds before exiting.

