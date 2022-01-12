{-# LANGUAGE FlexibleContexts #-}
import Data.Foldable
import Data.Binary.Get (label)
import Control.Monad.State
-- 12 Monads Defined

-- 12.12.1 CPS

-- Rewrite your solution of the function which solves the quadratic equation from Defining Functions to make use of Continuation Passing Style (CPS).
-- You should be able to test it by quadraticCPS 6 11 (-35) print.

quadraticEquasion :: Float -> Float -> Float -> (Float, Float)
quadraticEquasion a b c = if z > 0 then (x,y) else error "Cannot solve equasion - sqrt is negative"
    where
        x = -b / (2 * a) + sqrt z / (2 * a)
        y = -b / (2 * a) - sqrt z / (2 * a)
        z = (b * b) - (4 * a * c)

quadraticCPS :: Float -> Float -> Float -> ((Float,Float) -> r) -> r
quadraticCPS a b c k =
        calcX a b c $ \x ->
        calcY a b c $ \y ->
        tuple x y k

calcX :: Float -> Float -> Float -> (Float -> r) -> r
calcX a b c k = k ( -b / (2 * a) + sqrt z / (2 * a)) where z = (b * b) - (4 * a * c)

calcY :: Float -> Float -> Float -> (Float -> r) -> r
calcY a b c k = k (-b / (2 * a) - sqrt z / (2 * a)) where z = (b * b) - (4 * a * c)

tuple :: Float -> Float -> ((Float,Float) -> r) -> r
tuple x y k = k (x,y)

-- 12.12.2 Monad Basics

-- Write a liftM2 function, which works similar to liftM but instead lifts functions with 2 arguments into a monadic action.
-- An example usage is liftM2 (,) (Just 3) (Just 5) = Just (3,5)
liftM2' :: Monad m => (a -> b -> c) -> m a -> m b -> m c
liftM2' f m1 m2 = m1 >>=
    \a -> m2 >>=
        \b -> return (f a b)

-- Write a Monad instance for newtype Identity a = Id a. You need to provide an implementation for Functor and Applicative as well!
-- An example usage is liftM2 (+) (Id 10) (Id 11) = Id 21.
-- Show with algebraic reasoning that the 3 monadic laws hold for your implementation.

newtype Identity a = Id a deriving Show

instance Functor Identity where
    fmap f (Id a) = Id (f a)

instance Applicative Identity where
    pure a = Id a
    (Id a) <*> something = fmap a something

instance Monad Identity where
    return a = Id a
    (Id a) >>= f = f a

-- Implement mapM and mapM_ assuming the Traversable to be a list, therefore the types change to:
-- mapM :: Monad m => (a -> m b) -> [a] -> m [b] and
-- mapM_ :: Monad m => (a -> m b) -> [a] -> m ()

mapM' :: Monad m => (a -> m b) -> [a] -> m [b]
mapM' _ [] = return []
mapM' f (x:xs) = f x >>=
    \x' -> mapM' f xs >>=
        \xs' -> return (x' : xs')

mapM_' :: Monad m => (a -> m b) -> [a] -> m ()
mapM_' _ [] = return ()
mapM_' f (x:xs) = f x >>=
    \x' -> mapM_' f xs >>=
        \xs' -> return ()

-- Implement mapM_ but now with the original type (HINT: Foldable is the key):
-- mapM_ :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()
mapM_'' :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()
mapM_'' g t = mapM_' g $ toList t

-- 12.12.3 Tree Labeling
data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving Show

tree :: Tree Char
tree = Node (Node (Leaf 'c') 'b' (Node (Leaf 'e') 'd' (Leaf 'f'))) 'a' (Leaf 'g')

-- Implement labelTree as a pure function.
labelTree :: Tree a -> Tree (a, Int)
labelTree (Leaf a) = Leaf (a, 0)
labelTree (Node lt a rt) = labelTree' (Node lt a rt) (-1)
    where
        labelTree' :: Tree a -> Int -> Tree(a, Int)
        labelTree' (Leaf a)     index = Leaf (a, index + 1)
        labelTree' (Node l a r) index = Node (labelTree' l (index + 1))
                                             (a, index + 1)
                                             (labelTree' r (treeDepth l + index + 1))
        treeDepth :: Tree a -> Int
        treeDepth (Leaf _) = 1
        treeDepth (Node l _ r) = treeDepth l + treeDepth r + 1

-- Implement labelTree with the StateComp from Monads Motivated.
newtype StateComp s a = S (s -> (a,s))

(-->) :: StateComp s a -> (a -> StateComp s b) -> StateComp s b
(-->) (S fa) cont = S (\s -> let (a,s') = fa s
                                 (S fb) = cont a
                             in fb s')

toState :: a -> StateComp s a
toState a = S (\s -> (a, s))

runStateComp :: StateComp s a -> s -> (a,s)
runStateComp (S f) s = f s

labelTree' :: Tree a -> StateComp Int (Tree (a, Int))
labelTree' (Leaf a)     = S (\labelNo -> (Leaf (a, labelNo + 1), labelNo + 1))
labelTree' (Node l a r) = S (\labelNo -> ((a, labelNo + 1), labelNo + 1)) -->
                            \a' -> labelTree' l -->
                                \l' -> labelTree' r -->
                                    \r' -> S (\labelNo -> (Node l' a' r', labelNo))

-- Implement labelTree with the State Monad for which you need to import Control.Monad.State.
labelTree'' :: MonadState Int m => Tree a -> m (Tree (a, Int))
labelTree'' (Node l x r) = do 
                          l' <- labelTree'' l
                          r' <- labelTree'' r
                          n <- get
                          modify (+1)
                          return (Node l' (x,n) r')
labelTree'' (Leaf a) = do
    n <- get
    modify (+1)
    return (Leaf (a,n))
