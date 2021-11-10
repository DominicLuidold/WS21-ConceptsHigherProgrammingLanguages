data Tree a = Leaf a 
            | Branch  (Tree a) (Tree a) deriving Show

instance Functor Tree where
    fmap f (Leaf x)  = Leaf (f x)
    fmap f (Branch  l r) = Branch (fmap f l) (fmap f r)     