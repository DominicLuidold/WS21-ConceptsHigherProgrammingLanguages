{-# LANGUAGE DeriveFunctor #-}
import System.IO
import Control.Monad.Free
import Control.Monad.Trans.Writer

-- 17 Free Monads
-- What is a Free Monad: https://stackoverflow.com/questions/13352205/what-are-free-monads
-- Eine freeMonade erfüllt alle Monadengesetze, führt aber keine Kollabierung (d. h. keine Berechnung) durch. Sie baut lediglich eine verschachtelte Reihe von Kontexten auf. Der Benutzer, der einen solchen freien monadischen Wert erzeugt, ist dafür verantwortlich, etwas mit diesen verschachtelten Kontexten zu tun, so dass die Bedeutung einer solchen Komposition aufgeschoben werden kann, bis der monadische Wert erzeugt worden ist.
fix :: (a -> a) -> a
fix f = f (fix f)

-- 17.7.1 map Fixed-Point Recursion
-- Source: https://stackoverflow.com/a/55131965/5232876
-- Thanks to Chi it is ultimately understood

-- mapFix = \f v -> case v of
--   []   -> [] -- empty list stays empty list
--   x:xs -> f x : mapFix f xs -- run function on first element and go to next

-- mapFix f = \v -> case v of -- f is every time the same
--   []   -> []
--   x:xs -> f x : mapFix f xs -- f is always the same

mapFix :: (a -> b) -> [a] -> [b]
mapFix f = fix (\rec v ->
    case v of -- fix entry of function point
        []   -> [] -- empty list stays empty
        x:xs -> f x : rec xs) -- 

-- 17.7.2 Fibonacci Fixed-Point Recursion
fib :: Int -> Int
fib = fix (\rec -> \x -> if x < 2
                            then x
                            else rec (x-1) + rec (x-2))

-- 4.6.8 Fibonacii (as comparison)
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = fibonacci(x - 1) + fibonacci(x - 2)

-- 17.7.3 cos Fixed-Point Recursion
fixCosIter :: Double -> [Double]
fixCosIter = fix (\func n -> [n] ++ func (cos n))

calcFixCosEndVal:: Double -> Double
calcFixCosEndVal = fix (\f b ->
     if cos b == b
        then b
         else f (cos b)
     )

checkWithEpsilon:: Double -> Bool
checkWithEpsilon value = abs(value - calcFixCosEndVal 0.75) > 0.0001

checkFixCos :: Double -> (Int,Double)
checkFixCos n = getLengthandLastValue (takeWhile checkWithEpsilon (fixCosIter n))

getLengthandLastValue :: [Double] -> (Int,Double)
getLengthandLastValue xs = (length xs,last xs)
