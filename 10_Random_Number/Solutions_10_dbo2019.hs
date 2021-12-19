--use stack for Random https://coderedirect.com/questions/575205/haskell-cant-import-system-random
import System.Random;

sumOfThreeRolls :: RandomGen g => (Int, Int) -> g -> (Int, g)
sumOfThreeRolls r g = (r1+r2+r3, g2)
    where
        (r1, g0) = randomR r g
        (r2, g1) = randomR r g0
        (r3, g2) = randomR r g1

-- write a function sumRand that runs functions like sumOfThreeRolls for n times and sums up the result. Think carefully about the type (HINT: use foldr). The following should hold:


sumRand :: Integer RandomGen g => (Int, Int) -> g -> (Int, g)-> (Int, g)