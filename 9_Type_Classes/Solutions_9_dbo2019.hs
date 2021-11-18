
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
  pure x = Z (repeat x)
  
  -- <*> :: ZipList (a -> b) -> ZipList a -> ZipList b
  (Z gs) <*> (Z xs) = Z (zipWith ($) gs xs)



-- Monoid under addition.
newtype Sum a = Sum a


instance Num a => Monoid (Sum a) where
    mempty = Sum 0
    mappend (Sum x) (Sum y) = Sum (x + y)



-- newtype All a = All a

-- instance  where
-- instance Foldable Tree where
-- foldMap _ (Leaf a)     = mempty
--   foldMap g (Branch l  r) = foldMap g l `mappend` foldMap g r
  
--   foldr g a (Leaf b)         = a
--   foldr g a (Branch l  r) = foldr g (foldr g a r) l
