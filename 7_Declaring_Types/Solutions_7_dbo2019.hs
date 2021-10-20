data Nat = Zero 
         | Succ Nat deriving Show

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

data Tree a = Leaf a | Node  (Tree a) a (Tree a) deriving Show

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


sub :: Nat -> Nat -> Nat
sub n  Zero = n
sub (Succ m) (Succ n) = sub m n

checkcomplete :: Tree a -> Bool 
checkcomplete (Leaf a) = True
checkcomplete (Node a x b) = checkcomplete a && checkcomplete b && abs( checkheight a - checkheight  b) <=1

checkheight :: Tree a -> Int
checkheight (Leaf _) = 0
checkheight (Node l _ r) = max(checkheight l) (checkheight r) + 1 --https://www.geeksforgeeks.org/write-a-c-program-to-find-the-maximum-depth-or-height-of-a-tree/


sub' :: Nat -> Nat -> Nat
sub' m Zero = m
sub' Zero n = error ("No Natrual Number result maybe negative")
sub' (Succ m) (Succ n) = sub m n

division :: Nat -> Nat -> Nat
division _ Zero = Zero
division x y = sub x y

-- Binary Tree
countLeafs :: Tree a -> Int
countLeafs (Leaf _) = 1
countLeafs (Node l _ r) = countLeafs l + countLeafs r

treeDepth  :: Tree a -> Int -- Tiefe startet mit 0
treeDepth  (Leaf _) = 0
treeDepth  (Node l _ r) = max(treeDepth  l) (treeDepth  r) + 1 --https://www.geeksforgeeks.org/write-a-c-program-to-find-the-maximum-depth-or-height-of-a-tree/
-- Node (Node (Leaf 1) 3 (Leaf 4)) 5 (Node (Leaf 6) 7 (Leaf 9))