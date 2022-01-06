import Test.QuickCheck
import Graphics.Win32 (FLOAT)
-- 16.6.1 Checking msort (5 Points)

-- 5 Recursive Functions

-- 5.5.2 Merge Sort
mergeSort :: Ord a => [a] -> [a] -> [a]
mergeSort x [] = x
mergeSort [] y = y
mergeSort (x:xs) (y:ys) | x <= y    = x:mergeSort xs (y:ys)
                        | otherwise = y:mergeSort (x:xs) ys

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort x = mergeSort (msort(fst(halve x))) (msort(snd(halve x)))

-- Halve (4.6.6 Defining Functions)
halve :: [a] -> ([a],[a])
halve x = splitAt(div (length x) 2) x

-- Source: https://stackoverflow.com/questions/67613294/haskell-how-to-print-array-for-each-sorted-element-in-mergesort
isSorted xs = and $ zipWith (<=) xs (drop 1 xs)

prop_isSorted :: [Int] -> Bool
prop_isSorted x = isSorted (msort x)

-- Own Version
myIsSorted :: Ord a => [a] -> Bool
myIsSorted (x:y:ys) = x > y && myIsSorted (y:ys)
myIsSorted _ = True

prop_MyIsSorted :: [Int] -> Bool
prop_MyIsSorted x = myIsSorted (msort x)
-- Source: https://jesper.sikanda.be/posts/quickcheck-intro.html
-- 16.6.2 Verify algebraic laws of addition (5 Points)
prop_isassociative :: Int -> Int -> Int -> Bool
prop_isassociative a b c = a + (b + c) == (a + b) + c

prop_iscommutative  :: Int -> Int  -> Bool --https://studyflix.de/mathematik/kommutativgesetz-2733
prop_iscommutative  a b  = a + b  == b + a

-- In computer science, unlike mathematics, floating point additions are usually not associative or commutative. This is also the case with haskell.
-- See:
-- https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html
-- https://en.wikipedia.org/wiki/Associative_property#:~:text=In%20mathematics%2C%20addition%20and%20multiplication,sized%20values%20are%20joined%20together.
prop_isassociativeFloat :: Float -> Float -> Float -> Bool
prop_isassociativeFloat a b c = a + (b + c) == (a + b) + c

prop_iscommutativeFloat :: Float -> Float -> Float -> Bool
prop_iscommutativeFloat a b c = a + (b + c) == (a + b) + c