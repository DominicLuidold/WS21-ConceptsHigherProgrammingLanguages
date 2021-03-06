import Data.Maybe
-- 14 Monads In Use: IO
-- 14 .7.2 Key Value Store IO

printKVS :: (Eq a, Show a, Show b) => KVS a b -> IO ()
printKVS Empty = do
    putStrLn "All values printed!"

printKVS (Elem k v s) = do
    putStrLn (show k ++ ":" ++ show v)
    printKVS s

-- 7.8.7 - Key-Value-Store
data KVS key value = Empty | Elem key value (KVS key value) deriving Show

kvs1 :: KVS Integer [Char]
kvs1 = Elem 1 "ABC" (Elem 2 "DEF" Empty)

insert :: (Eq a) => KVS a b -> a -> b -> KVS a b
insert Empty k v = Elem k v Empty
insert kvs@(Elem k v s) key value
                    | isJust(get kvs key) && k /= key  = (Elem k v (insert s key value))
                    | isNothing(get kvs key) && k /= key  = Elem k v (Elem key value s)
                    | k == key  = Elem key value s
                    | otherwise = insert s key value

remove :: (Eq a) => KVS a b -> a -> KVS a b
remove Empty _ = Empty
remove (Elem k v s) key
                    | k /= key  = Elem k v (remove s key)
                    | otherwise = s

get :: (Eq a) => KVS a b -> a -> Maybe b
get Empty _ = Nothing
get (Elem k v s) key
                    | k == key   = Just v
                    | otherwise  = get s key

has :: (Eq a) => KVS a b -> a -> Bool
has Empty _ = False
has (Elem k _ s) key
                    | k == key  = True
                    | otherwise = has s key