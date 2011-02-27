{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, TypeSynonymInstances, OverlappingInstances #-}
{-# OPTIONS_GHC #-}

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

instance Stream d (d -> c) c where
    x ->> y = y $ x

x ->>> y = y $ x

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
       --forkIO $ (lhello ->> bracket) ->> putStrLn
       forkIO $ (bracket $ hello) ->> putStrLn
       --forkIO $ (hello ->> bracket) ->> putStrLn
       forkIO $ bracket hello ->> putStrLn
       forkIO $ lbracket lhello ->> putStrLn
       --wbracket = lft bracket 
       --getLine ->> wbracket ->> putStrLn 
       threadDelay 10000000 -- Sleep for at least 10 seconds before exiting.

