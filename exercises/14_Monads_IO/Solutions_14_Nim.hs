import Data.Char
import Text.XHtml (input)
-- 14 Monads In Use: IO
-- 14 .7.3 Nim

-- Implement the game of Nim in Haskell, where the rules of the game are as follows:

-- The initial board comprises five rows of stars.

--Inspired By https://github.com/rst0git/Nim-Game-Haskell/blob/master/nim.hs
-- haskel book https://staff.emu.edu.tr/zekibayram/Documents/courses/CMPE462/Haskell%20code/nim.hs.txt
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

showboard :: [Int] -> String 
showboard [] = "" 
showboard (x:board) = showLine x ++ showboard board

showLine :: Int -> String 
showLine input = if input == 0 then "\n" else "|" ++ showLine (input-1)


play:: [Int] -> Int -> IO ()
play board player = do 
                     putStrLn ("Player " ++ show (player+1) ++ " Choose Line and How Many you will take Format: Line,Count")
                     input <- getLine
                     let (x,y) = handleInput input
                     if isValid board x y then do
                        let movedboard = gameMove board x y
                        isOver movedboard (if player == 0 then 1 else 0)
                     else do
                        putStr "non Valid move\n"
                        play board player

charToString :: Char -> String
charToString = (:[])

-- isOver checks if the Board is empty, and checks whether the game is over or
-- the next turn must be called
isOver :: [Int] -> Int -> IO()
isOver board player = do if board == [0, 0, 0, 0, 0]
                           then putStrLn ("Player " ++ (show player) ++ ", you win!")
                           else do putStrLn ("\n" ++ (showboard board))
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


main :: IO ()
main = nim

-- first turn
nim :: IO ()
nim = do putStrLn "Welcome to nim!"
         putStrLn (showboard [5, 4, 3, 2, 1])
         play [5, 4, 3, 2, 1] 0