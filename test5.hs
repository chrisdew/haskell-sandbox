import Network (listenOn, withSocketsDo, accept, PortID(..), Socket)
import System (getArgs)
import Control.Monad( forever)
import System.IO (hSetBuffering, hGetLine
                 ,hPutStrLn, BufferMode(..), Handle)
import Control.Concurrent (forkIO)
import World

commandProcessor :: Handle -> IO ()
commandProcessor handle = do
    line <- hGetLine handle
    case words line of
        [] -> return ()
        ("echo":cmdData) -> echoCommand handle cmdData
        ("add":cmdData) -> addCommand handle cmdData
        _ -> hPutStrLn handle "Unknown command"

main :: IO ()
main = withSocketsDo $ do
            let port = 9999
            sock <- listenOn $ PortNumber port
            putStrLn $ "Listening on " ++ show port
            forever $ sockHandler sock

sockHandler :: Socket -> IO ()
sockHandler sock = do
    (handle, _, _) <- accept sock
    hSetBuffering handle NoBuffering
    forkIO . forever $ commandProcessor handle
    return ()

echoCommand :: Handle -> [String] -> IO ()
echoCommand _ [] = return ()
echoCommand handle xs = hPutStrLn handle $ unwords xs

addCommand :: Handle -> [String] -> IO ()
addCommand handle (arg1:arg2:_) =
    hPutStrLn handle . show $ read arg1 + read arg2
addCommand handle _ = return ()


