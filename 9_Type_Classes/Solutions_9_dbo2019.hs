data Tree a = Leaf a 
            | Branch  (Tree a) (Tree a) deriving Show

instance Functor Tree where
    fmap f (Leaf x)  = Leaf (f x)
    fmap f (Branch  l r) = Branch (fmap f l) (fmap f r)     

newtype ZipList a = Z [a] deriving Show

instance Functor ZipList where
  -- fmap :: (a -> b) -> ZipList a -> ZipList b
  fmap g (Z xs) = Z (map g xs)

instance Applicative ZipList where
  -- pure :: a -> ZipList a
  pure x = Z [x]
  
  -- <*> :: ZipList (a -> b) -> ZipList a -> ZipList b
  (Z gs) <*> (Z xs) = Z (gs xs)



test:: [a -> b] -> [a] -> [b]
test f x = f x