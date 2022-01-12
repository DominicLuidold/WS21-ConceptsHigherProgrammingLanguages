import Text.XHtml (black)
import Distribution.Simple.Utils (xargs)
-- 4 - Defining Functions

-- 4.6.1 - Pattern matching over '||'
(||) :: Bool -> Bool -> Bool
False || False = False
False || True = True
True || False = True
True || True = True

(|||) :: Bool -> Bool -> Bool
False ||| False = False 
_ ||| _ = True -- "_" = wildcard

(||||) :: Bool -> Bool -> Bool
False |||| x = x
True |||| _ = True

-- 4.6.2 - Redefining '&&'
(&&&) :: Bool -> Bool -> Bool
(&&&) a b = if a == False then False else
                if b == False then False else True

-- 4.6.3 Redefining &&
(&&&&) :: Bool -> Bool -> Bool 
(&&&&) a b = if a == False then False else b

-- 4.6.4 Currying
mult :: Int -> Int -> Int -> Int 
mult = \x -> (\y -> (\z -> x * y * z))

-- 4.6.5 Implementing 'safetail'
safetailConditional :: [a] -> [a]
safetailConditional x = if null x then [] else drop 1 x

safetailGuarded :: [a] -> [a]
safetailGuarded x | null x    = []
                  | otherwise = drop 1 x

safetailPattern :: [a] -> [a]
safetailPattern [] = []
safetailPattern (_:xs) = xs

-- 4.6.6 Defining Functions
-- Absolute Difference
absTwoNumbers :: Int -> Int -> Int 
absTwoNumbers x y = (positive x) - (positive y)

positive :: Int -> Int
positive x | x >= 0    = x
           | otherwise = x * (-1)

-- Halve
halve :: [a] -> ([a],[a])
halve x = splitAt(div (length x) 2) x

-- Quadratic equasion
quadraticEquasion :: Float -> Float -> Float -> (Float, Float)
quadraticEquasion a b c = if z > 0 then (x,y) else error "Cannot solve equasion - sqrt is negative"
    where
        x = -b / (2 * a) + (sqrt z) / (2 * a)
        y = -b / (2 * a) - (sqrt z) / (2 * a)
        z = (b * b) - (4 * a * c)

-- Median of a list
median :: [Float] -> Float
median x = if odd (length x)
            then x !! l2
            else ((x !! l2 - 1) + (x !! l2)) / 2
            where
                l = length x
                l2 = div l 2

-- 4.6.7 Sumdown
sumdown :: Int -> Int
sumdown 0 = 0
sumdown x = x + sumdown (x -1)

-- 4.6.8 Fibonacii
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = fibonacci(x - 1) + fibonacci(x - 2)

-- 4.6.9 Euclid
euclid :: Int -> Int -> Int
euclid x y | x <= 0 Prelude.|| y <= 0 = 0
           | x == y = x
           | x > y = euclid (x - y) y
           | otherwise = euclid (y - x) x

-- 4.6.10 Consecutive Duplicates
compress :: [Char] -> [Char]
compress [] = []
compress [x] = [x]
compress (x:xs:xss) = if x == xs then compress (xs:xss) else x:compress (xs:xss)

-- 4.6.11 Packing
-- ??

-- 4.6.12 Run-Length Encoding
-- ??
