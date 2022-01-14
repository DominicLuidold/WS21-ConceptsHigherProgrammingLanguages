{-# LANGUAGE DeriveFunctor #-}
import System.IO
import Control.Monad.Free
import Control.Monad.Trans.Writer
import Data.ByteString (putStr)

-- 17 Free Monads

-- 17.7.6 Nim Free Monads
-- For a better solution, please head over to: https://github.com/thalerjonathan/NimFreeMonad/blob/main/src/Nim.hs (😁)
-- Inspired by https://github.com/thalerjonathan/NimFreeMonad/blob/main/src/Nim.hs (👍)
data NimActions a
    = ReadLine (String -> a)
    | PrintText String a
    deriving Functor

type NimProgram = Free NimActions

readLine :: NimProgram String
readLine = liftF (ReadLine id)

printLine :: String -> NimProgram ()
printLine str = liftF (PrintText str ())

startBoard :: [Int]
startBoard = [5,4,3,2,1]

endboard :: [Int] -> Bool
endboard = all (== 0)

-- Regeln von https://de.wikipedia.org/wiki/Nim-Spiel
isValid ::  [Int] -> Int -> Int -> Bool
isValid b r count = b  !! (r-1) >= count

gameMove :: [Int] -> Int -> Int -> [Int]
gameMove board row num = [update r n | (r,n) <- zip [1..] board]
   where update r n = if r == row then n-num else n

showBoard :: [Int] -> String 
showBoard [] = "" 
showBoard (x:board) = showLine x ++ showBoard board

showLine :: Int -> String 
showLine input = if input == 0 then "\n" else "|" ++ showLine (input-1)

-- Attention start of NimActions usage 
play:: [Int] -> Int -> NimProgram ()
play board player = do 
                     printLine ("Player " ++ show (player+1) ++ " Choose Line and How Many you will take Format: Line,Count")
                     input <- readLine
                     let (x,y) = handleInput input
                     if isValid board x y then do
                        let movedboard = gameMove board x y
                        isOver movedboard (if player == 0 then 1 else 0)
                     else do
                        printLine "non Valid move\n"
                        play board player

charToString :: Char -> String
charToString = (:[])

-- isOver checks if the Board is empty, and checks whether the game is over or
-- the next turn must be called
isOver :: [Int] -> Int -> NimProgram()
isOver board player = do if board == [0, 0, 0, 0, 0]
                           then printLine ("Player " ++ (show player) ++ ", you win!")
                           else do printLine ("\n" ++ (showBoard board))
                                   play board player

handleInput:: String -> (Int,Int)
handleInput [] = (0,0)
handleInput input = arrayToTuple (split ',' input)

arrayToTuple:: [String] -> (Int,Int)
arrayToTuple (xs:x2:x) = (toInt xs,toInt x2)

split :: Char -> String -> [String]
split _ "" = []
split c s = firstWord : (split c rest)
    where firstWord = takeWhile (/=c) s
          rest = drop (length firstWord + 1) s

toInt :: String -> Int
toInt x = read x :: Int

-- first turn
nim :: NimProgram ()
nim = do printLine "Welcome to Nim!"
         printLine (showBoard [5, 4, 3, 2, 1])
         play [5, 4, 3, 2, 1] 0

interpretNimIO :: NimProgram a -> IO a
interpretNimIO (Pure p) = return p
interpretNimIO (Free (PrintText str p)) = do
  putStrLn str
  interpretNimIO p
interpretNimIO (Free (ReadLine fun)) = do
    word <- getLine 
    interpretNimIO (fun word)


-- See Script interpretPure 
pureNimInterpreter :: [String]  -> NimProgram a -> Writer String a
pureNimInterpreter _     (Pure a)                  = return a
pureNimInterpreter moves (Free (PrintText str g))  = tell (str ++ "\n") >> pureNimInterpreter moves g 
pureNimInterpreter (x:xs) (Free (ReadLine g)) = tell (x ++ "\n") >> pureNimInterpreter xs (g x) -- see https://stackoverflow.com/questions/31731757/map-a-function-over-a-string

runPureNimInterpreterTest :: ((), String)
runPureNimInterpreterTest =  runWriter $ pureNimInterpreter ["1,5","2,4","3,3","4,2","5,1"] nim

checkResult :: Bool
checkResult = runPureNimInterpreterTest == ((),"Welcome to Nim!\n|||||\n||||\n|||\n||\n|\n\nPlayer 1 Choose Line and How Many you will take Format: Line,Count\n1,5\n\n\n||||\n|||\n||\n|\n\nPlayer 2 Choose Line and How Many you will take Format: Line,Count\n2,4\n\n\n\n|||\n||\n|\n\nPlayer 1 Choose Line and How Many you will take Format: Line,Count\n3,3\n\n\n\n\n||\n|\n\nPlayer 2 Choose Line and How Many you will take Format: Line,Count\n4,2\n\n\n\n\n\n|\n\nPlayer 1 Choose Line and How Many you will take Format: Line,Count\n5,1\nPlayer 1, you win!\n")

prettyPrintPureNimRunner :: IO ()
prettyPrintPureNimRunner = putStrLn (snd runPureNimInterpreterTest)
