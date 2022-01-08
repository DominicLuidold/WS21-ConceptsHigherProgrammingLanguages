import Data.IORef
import Control.Concurrent.Async (wait, async)
-- 15 Monads In Use: Parallel and Concurrent Programming

-- 15.3.1 Primes IORef
primesConcurrent :: Integer -> IO ()
primesConcurrent  y = do
    ref <- newIORef []
    as <- mapM (async . primesThread ref) [2..y]
    mapM_ wait as
    n <- readIORef ref
    print n

-- TODO - Calc primes
-- TODO - Do what exercise actually wants from us
primesThread :: IORef [Integer] -> Integer -> IO()
primesThread ref n = atomicModifyIORef ref (\acc -> (if is_prime acc n then acc ++ [n] else acc ,())) -- Currently calcs fibonacci

is_prime :: [Integer] -> Integer -> Bool
is_prime  [] _  = True
is_prime (x:xs) n = mod n x /= 0 && is_prime xs n 

