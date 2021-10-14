data Nat = Zero 
         | Succ Nat

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