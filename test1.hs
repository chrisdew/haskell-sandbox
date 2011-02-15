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

hello :: W Int
hello = do
        foo <- W 3
        bar <- W 4
        let baz = foo + bar
        return baz

main :: IO ()
main = do
       putStrLn $ show hello

