import qualified Data.Char
-- 6 Higher-Order Functions

-- 6.7.2 Pipelining
-- Missing example!?

-- TODO

-- 6.7.5 Decimals to Integer
dec2int :: [Int] -> Int
dec2int = foldl (\x xs -> 10 * x + xs) 0

-- 6.7.6 Palindrome Checker
palindrome :: [Char] -> Bool
palindrome [] = True
palindrome x = reverse x == x

palindrome' :: [Char] -> Bool
palindrome' [] = False
palindrome' x = palindrome (map Data.Char.toLower (filter (/= ' ') x))

-- 6.7.7 Unfolding
myunfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
myunfold p h t x
  | p x       = []
  | otherwise = h x : myunfold p h t (t x)

mymap :: (b -> a) -> [b] -> [a]
mymap func = myunfold (null) (func . head) tail  -- null testet ob liste leer ist

-- http://zvon.org/other/haskell/Outputprelude/iterate_f.html 
myiteration :: (a -> a) -> a -> [a]
myiteration = myunfold (const False) id -- http://zvon.org/other/haskell/Outputprelude/id_f.html
