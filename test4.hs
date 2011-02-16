module Test (
main
)
where 

data W x = W x deriving Show

instance Functor W where
   fmap f (W x) = W (f x)

instance Monad W where
   return x = W x
   W x >>= f = f x

lft :: (a -> b) -> MVar a -> MVar b -> IO ()
lft f c d = forever $ do
                      x <- takeMVar c
                      putMVar d (f x)

lft :: a -> MVar a -> IO ()
lft x b = forever $ do
                    putMVar b x

bracket :: String -> String
bracket x = "(" ++ x ++ ")"

getLineW :: W String
putStrLnW :: String -> W ()


hello :: W Int
hello = do
        foo <- getLineW
        let baz = bracket foo
        
        return baz

main :: IO ()
main = do
       forkIO hello

