import Data.Char (toLower)
palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

correctpalindrom :: [Char] -> Bool
correctpalindrom [] = True
correctpalindrom l@(x:xs) = palindrome (map toLower ( filter (/= ' ') l))

dec2int :: [Int] -> Int
dec2int = foldl (\x y -> 10 * x + y) 0
