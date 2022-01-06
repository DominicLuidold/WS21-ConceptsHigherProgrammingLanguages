-- 2 - First Steps in Haskell

-- 2.7.3 - Redefining 'last'
listLast :: [a] -> a
listLast [x] = x --base case is when there's just one element remaining
listLast (_:xs) = listLast xs --iterate through the list until there is no successor left 
listLast [] = error "Can't do last of an empty list!"

-- 2.7.4 - Another 'last' implementation

listLast1 :: [a] -> a
listLast1 [x] = x --base case is when there's just one element remaining
listLast1 x =  x!!(length x-1)

listLast2 :: [a] -> a
listLast2 [x] = x --base case is when there's just one element remaining
listLast2 x = head (reverse x)

-- 2.7.5 -- Redefining 'init'
myinit :: [a] -> [a]
myinit [] = []
myinit [x] = [] --base case is when there's just one element remaining
myinit (x:xs) = x : myinit xs ---recursive call until there is no more successor

myinit1 :: [a] -> [a]
myinit1 [x] = [] --base case is when there's just one element remaining
myinit1 x = take (length x-1) x

myInit2 :: [a] -> [a]
myInit2 [x] = [x]
myInit2 x = reverse(drop 1 (reverse x))
