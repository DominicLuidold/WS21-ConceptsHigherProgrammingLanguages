data Nat = Zero 
         | Succ Nat deriving Show

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

data Tree a = Leaf a | Node a (Tree a) (Tree a)

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
checkcomplete (Node x a b) = checkcomplete a && checkcomplete b && abs( checkheight a - checkheight  b) <=1

checkheight :: Tree a -> Int
checkheight (Leaf _) = 0
checkheight (Node a x y) = max(checkheight x) (checkheight y) + 1 --https://www.geeksforgeeks.org/write-a-c-program-to-find-the-maximum-depth-or-height-of-a-tree/


sub' :: Nat -> Nat -> Nat
sub' m Zero = m
sub' Zero n = error ("No Natrual Number result maybe negative")
sub' (Succ m) (Succ n) = sub m n

division :: Nat -> Nat -> Nat
division _ Zero = Zero
division x y = sub x y