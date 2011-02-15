module Test (
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

bracket :: String -> String
bracket x = "(" ++ x ++ ")"

lft :: (a -> b) -> MVar a -> MVar b -> IO ()
lft f c d = forever $ do
                      x <- takeMVar c
                      putMVar d (f x) 

main :: IO ()
main = do
       box <- newEmptyMVar
       box2 <- newEmptyMVar
       forkIO $ stepA box
       forkIO $ lft bracket box box2
       forkIO $ stepB box2
       threadDelay 10000000 -- sleep this thread for at least 10 seconds

