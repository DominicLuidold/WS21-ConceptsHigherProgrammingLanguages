-- 3 - Types and Class Constraints

-- 3.7.1 - Inferring Types
-- ['a','b','c'] :: [Char]

-- ('a','b','c') :: (Char, Char, Char)

-- [(False,'0'),(True,'1')] :: [(Bool, Char)]

-- ([False,True],['0','1']) :: ([Bool], [Char])

-- [tail, init, reverse] :: [[a] -> [a]]

-- 3.7.2 - Inferring Types
second :: [a] -> a
second xs = head (tail xs)

swap :: (x,y) -> (y,x)
swap (x,y) = (y,x)

pair :: x -> y -> (x,y)
pair x y = (x,y)

double :: Int -> Int
double x = x*2

palindrome :: Eq a => [a] -> Bool -- overloaded polymorphic function
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a -- (a -> a) = function; -> a = second parameter; -> a = return type
twice f x = f (f x)

-- 3.7.3 -- Inferring Expressions
bools :: [Bool]
bools = [True, False]

nums :: [[Int]]
nums = [[1], [2], [3]]

add :: Int -> Int -> Int -> Int
add x y z = x + y + z

copy :: a -> (a,a)
copy x = (x,x)

apply :: (a -> b) -> a -> b
apply f x = f x

-- 3.7.4 - Filling gaps
e1 :: [Bool]
e1 = [True,False,True]

e2 :: [[Int]]
e2 = [[1,2],[3,4]]

e3 :: (Char,Bool)
e3 = ('a',False)

e4 :: [(String,Int)]
e4 = [("true", 1),("false", 0)]

e5 :: Num a => a -> a
e5 n = n*2

e6 :: Int -> Int -> Int
e6 x y = x - y

e7 :: (a,b) -> (b,a)
e7 (x,y) = (y,x)

e8 :: a -> (a,a)
e8 x = (x,x)

nums2 :: Num a => [a] -- [Num] does not work! --> Type Class
nums2 = [1,2,3,4,5]

table :: Num a => [(Bool,a)]
table = [(False,1),(True,2),(False,3)]

one :: a -> [a]
one x = [x]

three :: a -> (a,a,a)
three x = (x,x,x)

first :: a -> b -> a
first x y = x

mult :: Num a => a -> a -> a
mult m n = m*n
