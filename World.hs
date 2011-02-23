module World (
version, Room
)
where

newtype Oid = Oid Int

data Room = Room { rmOid :: Oid
                 , rmName :: String
                 , rmDesc :: String
                 }

version = "0.0.1"
