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
