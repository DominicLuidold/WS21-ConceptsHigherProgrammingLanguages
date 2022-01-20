import Control.Concurrent (MVar, newEmptyMVar, putMVar, takeMVar)
import Control.Concurrent.Async (async, wait)
import Control.Concurrent.STM
import Control.Concurrent.STM (STM, TChan, atomically, isEmptyTChan, newTChanIO, readTChan, writeTChan)
import Control.Monad (forM, forM_, join, replicateM, replicateM_, when)
import Data.IORef
import Data.IORef (IORef, atomicModifyIORef, newIORef, readIORef)
import GHC.IO.Handle (BufferMode (LineBuffering), hSetBuffering)
import System.IO (stdout)

-- 15 Monads In Use: Parallel and Concurrent Programming

-- 15.3.1 Primes IORef
primesConcurrent :: Integer -> IO ()
primesConcurrent y = do
  ref <- newIORef []
  as <- mapM (async . primesThread ref) [2 .. y]
  mapM_ wait as
  n <- readIORef ref
  print n

primesThread :: IORef [Integer] -> Integer -> IO ()
primesThread ref n = atomicModifyIORef ref (\acc -> 
  (if is_prime acc n then acc ++ [n] else acc, ()))

is_prime :: [Integer] -> Integer -> Bool
is_prime [] _ = True
is_prime (x : xs) n = mod n x /= 0 && is_prime xs n

-- 15.3.2 Primes with MVar (5 Points)
-- Compute the prime numbers between 1-n concurrently using an MVar and Async/Wait:
-- there are c consumers which take the next number to compute from the MVar.
-- The main producer is the main thread.
-- Think of how to communicate the end of computation to the consumers.
-- Information from: https://www.tcs.ifi.lmu.de/lehre/ss-2020/fun/material/folien/folien-10-druckversion

mVarPrimes :: Integer -> Integer -> IO () -- Siehe Powerpoint Page 20
mVarPrimes n c = do
  -- n max Value of Prime,  c count of Consumers
  -- line buffering, otherwise output is garbage
  hSetBuffering stdout LineBuffering
  -- create a new empty MVar
  var <- newEmptyMVar
  -- create c consumer
  consumers <- replicateM (fromInteger c) (async $ consume var)
  -- create producer
  produce var n 1 c
  mapM_ wait consumers -- Page 25

produce :: MVar Integer -> Integer -> Integer -> Integer -> IO () -- producer is the main thread.
produce var n curr c =
  if curr < n
    then do
      -- n max Value of Prime, curr -> Value for computation,  c count of Consumers
      let next = curr + 1
      putMVar var next -- save Next value
      -- continue by recursion
      produce var n next c -- start next produce
    else do
      putMVar var (-1)
      when (c > 0) (produce var n curr (c - 1)) -- end recursion

-- Source: https://stackoverflow.com/questions/4690762/determining-if-a-given-number-is-a-prime-in-haskell
isPrime :: Integer -> Bool
isPrime k = (k > 1) && null [ x | x <- [2..k - 1], k `mod` x == 0]

consume :: MVar Integer -> IO () -- See page 19
consume var = do
  n <- takeMVar var -- read value
  if n <= -1 -- if maximal requested prime is reached
    then return ()
    else
        do
            when (isPrime n) (print n)
            consume var

-- 15.3.3 Primes with TChan 
-- Compute the prime numbers between 1-n concurrently using TChan and Async/Wait.

-- Hints:

-- 1 The main thread enqueues each natural number into a TChan and then creates c consumer threads which take the next number from the TChan.
-- A consumer checks the natural number whether it is prime or not and in case it is, puts it into a different TChan which contains only the final prime numbers.
-- The prime number check can therefore happen in the STM Monad.
-- 3. The consumer threads should terminate as soon as there are no more elements in the natural number TChan.
-- The main thread waits for the termination of all consumer threads using wait and then prints the content of the primes TChan.
-- Source: https://hackage.haskell.org/package/stm-2.5.0.2/docs/Control-Concurrent-STM-TChan.html
-- Source: https://stackoverflow.com/questions/12945690/selective-send-on-tchan

tChanPrimesmain :: Integer -> Integer -> IO () -- Siehe Powerpoint Page 20
tChanPrimesmain n c = do
  -- n max Value of Prime,  c count of Consumers
  numbers <- newTChanIO
  result <- newTChanIO
  -- Write number each to TChan
  let numsToChan count = do
        writeTChan numbers count
        when (count < n) (numsToChan (count + 1))
  atomically $ numsToChan 1

  -- create c consumer
  consumers <- replicateM (fromInteger c) (async $ atomically $ consume' numbers result)
  mapM_ wait consumers -- Page 25

  let consuming = do
        isEmpty <- atomically $ isEmptyTChan result
        -- 3
        if isEmpty then do
            return ()
        else do
            --print all primes
            a <- atomically $ readTChan result
            print a
            consuming
  consuming


consume' :: TChan Integer -> TChan Integer -> STM () 
consume' n result = do
  isEmpty <- isEmptyTChan n
  if isEmpty -- if no value is there
    then do
      return ()
    else do
        currentvalue <- readTChan n
        when (isPrime currentvalue) (writeTChan result currentvalue)
        consume' n result