import GHC.Generics



newtype ZipList a = Z [a] deriving Show


instance Functor ZipList where
  -- fmap :: (a -> b) -> ZipList a -> ZipList b
  fmap g (Z xs) = Z (map g xs)

instance Applicative ZipList where
  -- pure :: a -> ZipList a
  pure x = Z (repeat x)
  
  -- <*> :: ZipList (a -> b) -> ZipList a -> ZipList b
  (Z gs) <*> (Z xs) = Z (zipWith ($) gs xs)





instance Semigroup All where
  All m1 <> All m2 = All (m1 && m2)

-- Source: Programming in Haskell GRAHAM HUTTON
-- | Boolean monoid under conjunction.
newtype All = All { getAll :: Bool }
        deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid All where
        mempty = All True
        All x `mappend` All y = All (x && y)
        

instance Semigroup Any where
  Any m1 <> Any m2 = Any (m1 || m2)

-- | Boolean monoid under disjunction.
newtype Any = Any { getAny :: Bool }
        deriving (Eq, Ord, Read, Show, Bounded)
instance Monoid Any where
        mempty = Any False
        Any x `mappend` Any y = Any (x || y)


-- instance Semigroup a => Monoid (Maybe a) where
--   Nothing <> a = a
--   a <> Nothing = a
--   Just x <> Just y = Just $ x <> y

-- instance Semigroup a => Monoid (Maybe a) where
--   mappend = (<>)
--   mempty = Nothing

data Tree a = Leaf a 
            | Branch  (Tree a) (Tree a) deriving Show

instance Functor Tree where
    fmap f (Leaf x)  = Leaf (f x)
    fmap f (Branch  l r) = Branch (fmap f l) (fmap f r)

instance Foldable Tree where
  foldMap f (Leaf a)     = f a
  foldMap g (Branch l  r) = foldMap g l `mappend` foldMap g r

  foldr g a (Leaf b)         = a
  foldr g a (Branch l  r) = foldr g (foldr g a r) l

