--use stack for Random https://coderedirect.com/questions/575205/haskell-cant-import-system-random
import System.Random;

-- 10 Random Numbers

-- 10.5.1 Implement sumRand
sumOfThreeRolls :: RandomGen g => (Int, Int) -> g -> (Int, g)
sumOfThreeRolls r g = (r1+r2+r3, g2)
    where
        (r1, g0) = randomR r g
        (r2, g1) = randomR r g0
        (r3, g2) = randomR r g1

-- Write a function sumRand that runs functions like sumOfThreeRolls for n times and sums up the result.
-- Think carefully about the type (HINT: use foldr).
sumRand :: (Num n, Ord n, RandomGen g) => n -> (Int, Int) -> g -> ((Int, Int) -> g -> (Int, g)) -> Int
sumRand n r g f= sum (randomValues n r g f)
    where
        randomValues n r g f | n > 0     = fst (f r g) : randomValues (n - 1) r (snd (f r g)) f
                             | otherwise = [fst (f r g)]

-- 10.5.2 Rolling Dices

-- Write a function rollNMDices which rolls N dices M times and computes the sum for each of the M rolls.
-- It should take a RandomGen instance but does not have to return one! HINT: consider the split function.
rollNMDices :: (RandomGen g) => Int -> Int -> (Int ,Int) -> g -> [Int]
rollNMDices _ 0 _ _ = []
rollNMDices n m r g = sum (throwADice n r (createSeeds n ((fst . split) g))) : rollNMDices n (m-1) r (snd (split g))

throwADice :: (RandomGen g) => Int -> (Int,Int) -> [g] -> [Int]
throwADice 0 _ _ = []
throwADice n r (x:xs) = fst(randomR r x) : throwADice (n-1) r xs

createSeeds :: (RandomGen g) => Int -> g -> [g]
createSeeds 0 _ = []
createSeeds n g = (fst . split) g : createSeeds (n-1) ((snd . split) g)

-- Write a function avg2Dices which calls rollNMDices M times with 2 dices and computes the average.
-- It should not take a RandomGen instance but an Int as initial seed.
-- HINT: To convert an Int to a Double for divison, use fromIntegral.
avg2Dices :: Int -> (Int, Int) -> Int -> Double
avg2Dices 0 _ _ = 0.0
avg2Dices m d s = fromIntegral (sum (rollNMDices 2 m d (mkStdGen s))) / fromIntegral m

-- Write a function replicate2Dices which performs  N runs of the avg2Dices, each 1000 times but with a different seed and compute the average of it
-- (you are therefore computing averages of the averages!).
replicate2Dices :: Int -> (Int, Int) -> Double
replicate2Dices 0 _ = 0.0
replicate2Dices n d = avg2Dices (n * 1000) d (randomVal n) + avg2Dices ((n-1) * 1000) d (randomVal (n-1)) / fromIntegral (n*1000)

randomVal :: Int -> Int
randomVal 0 = fst $ randomR (1,10000) (mkStdGen 0)
randomVal n = fst $ randomR (1,10000) (mkStdGen n)

-- replicate2Dices with 10.000 runs => 6.9997458000749075
-- Result is nearly 7 since expected value of 2 dice(1-6) is 7 (see: https://www.mathelounge.de/95654/wird-wurfeln-geworfen-bestimme-erwartungswert-augensumme)
