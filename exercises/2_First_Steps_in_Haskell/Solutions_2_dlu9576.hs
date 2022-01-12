-- 2 - First Steps in Haskell

-- 2.7.3 - Redefining 'last'
myLast :: [a] -> a
myLast [x] = x
myLast x = head (reverse x)

-- 2.7.4 - Another 'last' implementation
myLast2 :: [a] -> a
myLast2 [x] = x
myLast2 x = x !! (length x-1)

-- 2.7.5 -- Redefining 'init'
myInit :: [a] -> [a]
myInit [x] = [x]
myInit x = reverse(drop 1 (reverse x))

myInit2 :: [a] -> [a]
myInit2 [x] = [x]
myInit2 x = take (length x-1) x
