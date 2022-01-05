-- 12.12.1 CPS

-- Rewrite your solution of the function which solves the quadratic equation from Defining Functions to make use of Continuation Passing Style (CPS).
-- You should be able to test it by quadraticCPS 6 11 (-35) print.



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

newtype Identity a = Id a

instance Functor Identity where
    fmap f (Id a) = Id (f a)

instance Applicative Identity where
    pure x = Id x
    -- TODO ...
    
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

