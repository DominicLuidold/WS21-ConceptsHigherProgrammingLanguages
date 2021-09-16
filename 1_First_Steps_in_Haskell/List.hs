--Aufgabe Last
--From Prelude
listLast :: [a] -> a
listLast [x] = x --base case is when there's just one element remaining
listLast (_:xs) = listLast xs --if there's anything in the head, continue until there's one element left
listLast [] = error "Can't do last of an empty list!"

listLast1 :: [a] -> a
listLast [x] = x --base case is when there's just one element remaining
listLast x =  x!!(length x-1)

listLast2 :: [a] -> a
listLast [x] = x --base case is when there's just one element remaining
listLast x =  head (reverse x)

--Aufgabe init
myinit :: [a] -> [a]
myinit [x] = [] --base case is when there's just one element remaining
myinit (x:xs) = x : myinit xs ---recursive call until there is no more successor

myinit1 :: [a] -> [a]
myinit1 [x] = [] --base case is when there's just one element remaining
myinit1 (x) = take (length x-1) x
