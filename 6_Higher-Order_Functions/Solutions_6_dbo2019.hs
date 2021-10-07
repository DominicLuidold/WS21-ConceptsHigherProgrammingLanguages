import Data.Char (toLower)

-- TODO
-- Pipelining (1 Point)
-- Using higher-order functions write a function pipeline which implements a transformation pipeline on lists of integers which multiplies each element by its index (starting with 1!), removes the odd values, and computes the sum. For example

palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

correctpalindrom :: [Char] -> Bool
correctpalindrom [] = True
correctpalindrom l@(x:xs) = palindrome (map toLower ( filter (/= ' ') l))

dec2int :: [Int] -> Int
dec2int = foldl (\x y -> 10 * x + y) 0

myunfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
myunfold p h t x
  | p x       = []
  | otherwise = h x : myunfold p h t (t x)

mymap :: (b -> a) -> [b] -> [a]
mymap func = myunfold (null) (func . head) tail  -- null testet ob liste leer ist

-- http://zvon.org/other/haskell/Outputprelude/iterate_f.html 
myiteration :: (a -> a) -> a -> [a]
myiteration = myunfold (const False) id -- http://zvon.org/other/haskell/Outputprelude/id_f.html