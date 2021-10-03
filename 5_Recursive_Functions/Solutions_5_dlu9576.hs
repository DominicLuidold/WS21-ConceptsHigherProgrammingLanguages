import Distribution.Simple.Utils (xargs)
-- 5 Recursive Functions

-- 5.5.1 Reimplementing Prelude functions
customAnd :: [Bool] -> Bool
customAnd [] = True
customAnd (x:xs) = x && customAnd xs

customConcat :: [[a]] -> [a]
customConcat [] = []
customConcat ([]:xss) = customConcat xss
customConcat ((x:xs):xss) = x:customConcat(xs:xss)

myReplicate :: Int -> a -> [a]
myReplicate 0 _ = []
myReplicate x y = y:myReplicate (x-1) y

(!!!) :: [a] -> Int -> a
(!!!) []     _ = error "Empty"
(!!!) (x:_)  0 = x
(!!!) (_:xs) n = (!!!) xs (n-1)

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = error "Empty list"
myElem x (y:ys) | x == y = True
                | otherwise = x `elem` ys

-- 5.5.2 Merge Sort
mergeSort :: Ord a => [a] -> [a] -> [a]
mergeSort x [] = x
mergeSort [] y = y
mergeSort (x:xs) (y:ys) | x <= y    = x:mergeSort xs (y:ys)
                        | otherwise = y:mergeSort (x:xs) ys

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort x = mergeSort (msort(fst(halve x))) (msort(snd(halve x)))

-- Halve (4.6.6 Defining Functions)
halve :: [a] -> ([a],[a])
halve x = splitAt(div (length x) 2) x
