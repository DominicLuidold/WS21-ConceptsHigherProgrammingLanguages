import qualified Data.Char
-- 6 Higher-Order Functions

-- 6.7.2 Pipelining
-- Missing example!?
-- pipeline :: Int a => (a -> a) -> [a] -> [a]
-- pipeline _ [] = []
-- pipeline f (x:xs) = 

-- 6.7.3 Redefine with 'foldr'
mapR :: (a -> b) -> [a] -> [b]
mapR _ [] = []
mapR f xs = foldr (\x xs -> f x : xs) [] xs

filterR :: (a -> Bool) -> [a] -> [a]
filterR _ [] = []
filterR p xs = foldr (\x xs -> if p x then x:xs else xs) [] xs

-- 6.7.5 Decimals to Integer
dec2int :: [Int] -> Int
dec2int = foldl (\x xs -> 10 * x + xs) 0

-- 6.7.6 Palindrome Checker
palindrome :: [Char] -> Bool
palindrome [] = False
palindrome x = (reverse x) == x

palindrome' :: [Char] -> Bool
palindrome' [] = False
palindrome' x = palindrome (map Data.Char.toLower (filter (/= ' ') x))

customUnfold :: (a -> Bool) -> (a -> a) -> (a -> a) -> a -> [a]
customUnfold p h t x
    | p x       = []
    | otherwise = h x : customUnfold p h t (t x)

-- map with unfold --> ??

-- iterate with unfold --> ??
