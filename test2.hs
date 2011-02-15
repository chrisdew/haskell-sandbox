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


main :: IO ()
main = do
       box <- newEmptyMVar
       forkIO $ stepA box
       forkIO $ stepB box
       threadDelay 10000000 -- sleep this thread for at least 10 seconds

