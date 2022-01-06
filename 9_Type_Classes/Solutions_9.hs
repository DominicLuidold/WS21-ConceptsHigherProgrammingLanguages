-- 9 Type Classes

-- 9.14.1 - Natural Numbers 'Ord' and 'Enum'
data Nat = Zero | Succ Nat

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

nat2int :: Nat -> Int
nat2int Zero     = 0
nat2int (Succ n) = 1 + nat2int n

instance Eq Nat where
    Zero == Zero = True
    Zero == (Succ _) = False
    (Succ _) == Zero = False
    (Succ a) == (Succ b) = a == b

instance Ord Nat where
    Zero <= Zero = True
    Zero <= (Succ _) = True
    (Succ _) <= Zero = False
    (Succ a) <= (Succ b) = a <= b

instance Enum Nat where
    toEnum 0 = Zero
    toEnum x = int2nat x
    fromEnum Zero = 0
    fromEnum x = nat2int x

-- 9.14.2 Functorial Tree
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

  -- 9.14.3 ZipList
newtype ZipList a = Z [a] deriving Show

instance Functor ZipList where
  -- fmap :: (a -> b) -> ZipList a -> ZipList b
  fmap g (Z xs) = Z (map g xs)

instance Applicative ZipList where
  -- pure :: a -> ZipList a
  pure x = Z (repeat x)
  
  -- <*> :: ZipList (a -> b) -> ZipList a -> ZipList b
  (Z gs) <*> (Z xs) = Z (zipWith ($) gs xs)

-- 9.14.4.1 Boolean Monoids
instance Semigroup All where
  All m1 <> All m2 = All (m1 && m2)

-- Source: Programming in Haskell GRAHAM HUTTON
-- Boolean monoid under conjunction.
newtype All = All { getAll :: Bool }
        deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid All where
        mempty = All True
        All x `mappend` All y = All (x && y)

instance Semigroup Any where
  Any m1 <> Any m2 = Any (m1 || m2)

-- Boolean monoid under disjunction.
newtype Any = Any { getAny :: Bool }
        deriving (Eq, Ord, Read, Show, Bounded)
instance Monoid Any where
        mempty = Any False
        Any x `mappend` Any y = Any (x || y)

-- 9.14.4.2 Maybe Monoid
data MyMaybe a = MyJust a | MyNothing deriving Show

instance Semigroup a => Semigroup (MyMaybe a) where 
    MyNothing <> a = a
    a <> MyNothing = a
    MyJust a <> MyJust b = MyJust $ a <> b

instance Semigroup a => Monoid (MyMaybe a) where
    mempty = MyNothing
    mappend = (<>)

-- 9.14.5 Foldable Tree
-- instance Functor Tree where
--     fmap f (Leaf x)  = Leaf (f x)
--     fmap f (Branch  l r) = Branch (fmap f l) (fmap f r)

-- instance Foldable Tree where
--   foldMap f (Leaf a)     = f a
--   foldMap g (Branch l  r) = foldMap g l `mappend` foldMap g r
--   foldr g a (Leaf b)         = a
--   foldr g a (Branch l  r) = foldr g (foldr g a r) l

treeDepth :: Tree a -> Int
treeDepth (Leaf _) = 0
treeDepth (Branch leftSubtree rightSubtree) = 
 1 + max (treeDepth leftSubtree) (treeDepth rightSubtree)
