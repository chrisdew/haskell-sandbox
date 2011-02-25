module Main (
main
)
where 

import Control.Concurrent (forkIO, MVar, newEmptyMVar, putMVar, takeMVar, ThreadId, threadDelay)
import Control.Monad (forever)

stepA :: MVar String -> IO ()
stepA boxa = forever $ do
                       line <- getLine
                       putMVar boxa line

stepB :: MVar String -> IO ()
stepB boxb = forever $ do
                       line <- takeMVar boxb
                       putStrLn line

-- This simply wraps a string in brackets.
bracket :: String -> String
bracket x = "(" ++ x ++ ")"

-- This lifts a function into an action which forever performs the function
-- between two MVars given.
lft :: (a -> b) -> MVar a -> MVar b -> IO ()
lft f c d = forever $ do
                      x <- takeMVar c
                      putMVar d (f x) 

-- Just like C's main.
main :: IO ()
main = do
       box <- newEmptyMVar
       box2 <- newEmptyMVar
       forkIO $ stepA box
       forkIO $ lft bracket box box2
       forkIO $ stepB box2
       threadDelay 10000000 -- Sleep for at least 10 seconds before exiting.

