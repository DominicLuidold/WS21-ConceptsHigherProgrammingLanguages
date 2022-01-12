merge :: Ord a => [a] -> [a] -> [a]
merge x [] = x
merge [] x = x
merge l1@(x:xs) l2@(y:ys)
  | x < y     = x:(merge xs l2)
  | otherwise = y:(merge l1 ys)

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort x =  merge (msort (fst (halve x))) (msort (snd (halve x)))

halve :: [a] -> ([a],[a])
halve xs = splitAt (length xs `div` 2) xs
