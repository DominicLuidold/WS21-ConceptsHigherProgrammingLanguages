{-# LANGUAGE DeriveFunctor #-}
import System.IO
import Control.Monad.Free
import Control.Monad.Trans.Writer

-- 17 Free Monads

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

-- 17.7.4 Reproduce Hangman
data HangmanEff a
  = PrintLine String a
  | ReadSecretLine a
  | Guess (Maybe String -> a)
  deriving Functor

type HangmanProgram = Free HangmanEff

printLine :: String -> HangmanProgram ()
printLine str = liftF (PrintLine str ())

readSecretLine :: HangmanProgram ()
readSecretLine = liftF (ReadSecretLine ())

guess :: HangmanProgram (Maybe String)
guess = liftF (Guess id)

hangman :: HangmanProgram ()
hangman = do
  printLine "Think of a word: "
  readSecretLine
  printLine "Try to guess it:"
  play

play :: HangmanProgram ()
play = do
  printLine "? "
  ret <- guess
  case ret of
    Nothing -> printLine "You got it!"
    (Just diff) -> do
      printLine diff
      play

-- Powerpoint IO Monad
getCh :: IO Char
getCh = do
    hSetEcho stdin False
    x <- getChar
    hSetEcho stdin True
    return x

sgetLine :: IO String
sgetLine = do
    x <- getCh -- see below
    if x == '\n' then do
        putChar x
        return []
    else do
        putChar '-'
        xs <- sgetLine
        return (x:xs)

match :: String -> String -> String
match xs ys = map (\x -> if x `elem` ys then x else '-') xs

-- InterpretIO

interpretIO :: Maybe String -> HangmanProgram a -> IO a
interpretIO _ (Pure a) = return a
interpretIO s (Free (PrintLine str a)) = do
  putStrLn str
  interpretIO s a
interpretIO _ (Free (ReadSecretLine a)) = do
  secret <- sgetLine -- see slides on IO Monad
  interpretIO (Just secret) a
interpretIO (Just secret) (Free (Guess fa)) = do
  word <- getLine 
  if word == secret then
    interpretIO Nothing (fa Nothing)
  else
    interpretIO (Just secret) (fa (Just $ match secret word)) -- see slides on IO Monad

-- 17.7.5 Pure Hangman Interpreter
-- See Script interpretPure 
pureHangmanInterpreter :: [String] -> String -> HangmanProgram a -> Writer String a
pureHangmanInterpreter _              _      (Pure a) = return a
pureHangmanInterpreter guesses secret (Free (PrintLine str g))  = tell (str    ++ "\n") >> pureHangmanInterpreter guesses secret g -- \n because putStrLn
pureHangmanInterpreter guesses secret (Free (ReadSecretLine g)) = tell (map (const '-') secret ++ "\n") >> pureHangmanInterpreter guesses secret g -- map function always add a - see https://stackoverflow.com/questions/31731757/map-a-function-over-a-string
pureHangmanInterpreter (x:xs) secret (Free (Guess g))          = tell (x      ++ "\n") >> if x == secret then pureHangmanInterpreter [] secret (g Nothing) --See Line 131
                                                                                                    else pureHangmanInterpreter xs secret (g (Just $ match secret x)) -- See line 133
                                                                                        
runPureHangmanInterpreter :: ((),String)                                                               
runPureHangmanInterpreter = runWriter $ pureHangmanInterpreter ["H","l","Has","Haskell"] "Haskell" hangman

checkResult :: Bool
checkResult = runPureHangmanInterpreter == ((),"Think of a word: \n-------\nTry to guess it:\n? \nH\nH------\n? \nl\n-----ll\n? \nHas\nHas----\n? \nHaskell\nYou got it!\n")

prettyPrintPureHangmanRunner :: IO () -- Idea stolen from Falco (not the musician)
prettyPrintPureHangmanRunner = putStr (snd runPureHangmanInterpreter)

--Inspiredby:  https://github.com/thalerjonathan/NimFreeMonad/blob/main/src/Nim.hs
