-- 7.8.7 - Key-Value-Store
data KVS key value = Empty | Elem key value (KVS key value) deriving Show

kvs1 :: KVS Integer [Char]
kvs1 = Elem 1 "ABC" (Elem 2 "DEF" Empty)

insert :: (Eq a) => KVS a b -> a -> b -> KVS a b
insert Empty k v = Elem k v Empty
insert (Elem k v s) key value
                    | k /= key  = Elem k v (Elem key value s)
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
                    | otherwise = has s key
