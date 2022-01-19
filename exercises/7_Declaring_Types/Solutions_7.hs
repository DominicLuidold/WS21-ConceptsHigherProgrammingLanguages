import Data.Maybe
-- 7 Declaring Type

-- 7.8.2 Nat multiplication
data Nat = Zero
         | Succ Nat deriving Show

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

data Tree  a = Leaf a | Node  (Tree a) a (Tree a) deriving Show

add :: Nat -> Nat -> Nat
add Zero     n = n
add (Succ m) n = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult Zero  _ = Zero
mult  _ Zero = Zero
mult m (Succ n) = mult' m m  n

mult' ::  Nat -> Nat -> Nat -> Nat
mult' n  _ Zero = n
mult' m morg (Succ n) = mult' (add m morg) morg n

multbetter :: Nat -> Nat -> Nat
multbetter Zero  _ = Zero
multbetter  _ Zero = Zero
multbetter m (Succ n) = add m  (multbetter m  n)

-- 7.8.3 Implementing folde
-- Define a suitable function folde, a fold for expressions, and give a few examples of its use. 
-- The idea is that you provide a function for each of the possible data values of an Expr, 
-- that is a function for Val, Add, Mult, which takes the arguments and produces the result, 
-- without hard-coding the actual arithmetic operation. folde can then be used in the following way:
-- eval = folde id (+) (*). Think careful about the type of folde: 
-- it should be as generic as possible and allow for transforming Expr not only into 
-- Int but if necessary also into a String such as in folde show (\e1 e2 -> e1 ++ " + " ++ e2) (\e1 e2 -> e1 ++ " * " ++ e2).
-- Source: https://github.com/pankajgodbole/hutton/blob/master/exercises.hs
data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
folde                 :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f g (Val n)     =  f n
folde f g (Add e1 e2) =  g (folde f g e1) (folde f g e2)

evaluate             :: Expr -> Int
evaluate (Val n)     =  n
evaluate (Add e1 e2) =  folde toEnum (+) (Add e1 e2)

-- 7.8.4 Complete Tree
checkcomplete :: Tree a -> Bool
checkcomplete (Leaf a) = True
checkcomplete (Node a x b) = checkcomplete a && checkcomplete b && abs( checkheight a - checkheight  b) <=1

checkheight :: Tree a -> Int
checkheight (Leaf _) = 0
checkheight (Node l _ r) = max (checkheight l) (checkheight r) + 1 --https://www.geeksforgeeks.org/write-a-c-program-to-find-the-maximum-depth-or-height-of-a-tree/

-- 7.8.5 Natural Number sub and division

sub :: Nat -> Nat -> Nat
sub n  Zero = n
sub (Succ m) (Succ n) = sub m n

sub' :: Nat -> Nat -> Nat
sub' m Zero = m
sub' Zero n = error ("No Natrual Number result maybe negative")
sub' (Succ m) (Succ n) = sub' m n

-- https://math.stackexchange.com/questions/186421/how-to-divide-using-addition-or-subtraction
-- https://www.youtube.com/watch?v=c9R7cGenD8Y
-- Test nat2int( division (int2nat 18) (int2nat 3) )
-- Test  division (int2nat 18) (int2nat 0) for the infinity version
division :: Nat -> Nat -> Nat
division Zero _ = Zero
division x y = Succ (division (sub' x y) y)

-- 7.8.6 Binary Tree
-- Example  Node (Node (Leaf 1) 3 (Leaf 4)) 5 (Node (Leaf 6) 7 (Leaf 9))
countLeafs :: Tree a -> Int
countLeafs (Leaf _) = 1
countLeafs (Node l _ r) = countLeafs l + countLeafs r

treeDepth :: Tree a -> Int -- Tiefe startet mit 0
treeDepth (Leaf _) = 0
treeDepth (Node l _ r) = max(treeDepth  l) (treeDepth  r) + 1 --https://www.geeksforgeeks.org/write-a-c-program-to-find-the-maximum-depth-or-height-of-a-tree/

countNodes :: Tree a -> Int
countNodes (Leaf _) = 0
countNodes (Node l _ r) = countNodes l + countNodes r + 1

getVal :: Ord a => Tree a -> a
getVal (Leaf v)   =  v
getVal (Node _ v _)   = v

isSorted :: Ord a => Tree a -> Bool
isSorted (Leaf _)   = True
isSorted (Node l v r) = (getVal l <= v) &&  (getVal r > v) && isSorted l && isSorted r

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
