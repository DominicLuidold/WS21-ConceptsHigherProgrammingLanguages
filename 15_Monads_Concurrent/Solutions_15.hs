import Data.IORef
import Control.Concurrent.Async (wait, async)
-- 15 Monads In Use: Parallel and Concurrent Programming

-- 15.3.1 Primes IORef
primesConcurrent :: (Integer,Integer) -> IO ()
primesConcurrent (x, y) = do
    ref <- newIORef 1
    as <- mapM (async . primesThread ref) [x..y]
    mapM_ wait as
    n <- readIORef ref
    print n

-- TODO - Calc primes
-- TODO - Do what exercise actually wants from us
primesThread :: IORef Integer -> Integer -> IO()
primesThread ref n = atomicModifyIORef ref (\acc -> (acc * n, ()))
