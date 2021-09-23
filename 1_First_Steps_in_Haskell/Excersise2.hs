
safetailconditional :: [a]  -> [a]
safetailconditional xs = if null xs then [] else tail xs

safetailguarded :: [a]  -> [a]
safetailguarded xs | null xs  = []
                        | otherwise = tail xs

safetailpattern :: [a]  -> [a]
safetailpattern [] = []
safetailpattern (_:xs) = xs

absdiff :: Int -> Int -> Int
absdiff x y = myabs (x-y)

myabs :: Int -> Int
myabs n | n >= 0    = n
      | otherwise = -n

halve :: [a] -> ([a],[a])
halve xs = splitAt (length xs `div` 2) xs

-- midnight :: a -> b -> c-> (d,e)
-- TODO

median :: [Float] -> Float
median x | null x = 0
        | mod (length x) 2 /= 0 = x !! (length x `div` 2)
        | otherwise = (median (init x) + x !! ((length x `div` 2)))/2

fibonacci :: Int -> Int
fibonacci x | x <= 0  = 0
            | x == 1 = 1
            | otherwise = fibonacci(x - 1) + fibonacci(x-2)

sumdown :: Int -> Int
sumdown x | x <= 0 = 0
         | otherwise = x + sumdown (x - 1)


euclid :: Int -> Int -> Int
euclid a b | a <= 0 || b<=0 = 0
        | a == b = a
        | a < b = euclid (b - a) a
        |otherwise = euclid (a - b) b

compress :: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x1:x2:xs)
                | x1==x2 = compress (x2:xs)
                | otherwise = x1:compress (x2:xs)

--More Implementations https://wiki.haskell.org/99_questions/Solutions/9
pack :: Eq a => [a] -> [[a]]
pack [] = []
pack (x:xs) = let (first,rest) = span (==x) xs -- https://hackage.haskell.org/package/base-4.15.0.0/docs/Prelude.html#v:span
               in (x:first) : pack rest

encode :: Eq a => [a] -> [(Int, a)]
encode = map (\x -> (length x,head x)) . pack


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