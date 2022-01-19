import Test.QuickCheck
-- 16 Property-Based Testing
-- Source: https://www.dcc.fc.up.pt/~pbv/aulas/tapf/handouts/quickcheck.html
-- 16.6.1 Checking msort (5 Points)

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
prop_isAssociative :: Int -> Int -> Int -> Bool
prop_isAssociative a b c = a + (b + c) == (a + b) + c

prop_isCommutative :: Int -> Int  -> Bool --https://studyflix.de/mathematik/kommutativgesetz-2733
prop_isCommutative a b = a + b == b + a

-- In computer science, unlike mathematics, floating point additions are usually not associative or commutative. This is also the case with haskell.
-- See:
-- https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html
-- https://en.wikipedia.org/wiki/Associative_property#:~:text=In%20mathematics%2C%20addition%20and%20multiplication,sized%20values%20are%20joined%20together.
prop_isAssociativeFloat :: Float -> Float -> Float -> Bool
prop_isAssociativeFloat a b c = a + (b + c) == (a + b) + c

prop_isCommutativeFloat :: Float -> Float -> Bool
prop_isCommutativeFloat a b  = a + b  == b + a
-- 16.6.3 Dice
-- UseFull Link: https://www.st.cs.uni-saarland.de/edu/seminare/2005/advanced-fp/slides/meiser.pdf

-- Problem -> We can not create a new Arbitrary Int  
-- dice :: Gen Int
-- dice =
--     choose (1, 6)

-- sum_dice :: Gen Int
-- sum_dice = do
--     d1 <- dice
--     d2 <- dice
--     return (d1 + d2)

-- instance Arbitrary Int where
--     arbitrary = choose (1, 6)

-- -- coverage
-- --  quickCheck (checkCoverage checkCover)
-- checkCover :: Int -> Int -> Property
-- checkCover a  b = cover 16.67 (a + b == 7) "sum equals 7" (a + b == a + b)


-- Own Dice Type Like the Color in the Script 
newtype Dice = Dice Int deriving Show

roleDice :: Gen Dice
roleDice = elements [Dice 1, Dice 2, Dice 3, Dice 4, Dice 5, Dice 6]

instance Arbitrary Dice where
    arbitrary = roleDice

-- coverage
-- quickCheck (checkCoverage checkDiceSum)
-- See https://hackage.haskell.org/package/QuickCheck-2.14.2/docs/Test-QuickCheck.html
checkDiceSum :: Dice -> Dice -> Property
checkDiceSum (Dice a) (Dice b) = cover 16.67 (a + b == 7) "equal 7" (a + b == a + b) -- Expected Value 1/6 => http://mathcentral.uregina.ca/QQ/database/QQ.09.97/thompson1.html