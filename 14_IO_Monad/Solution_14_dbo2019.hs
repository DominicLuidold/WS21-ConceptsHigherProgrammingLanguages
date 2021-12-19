-- Nim (20 Points)
-- Implement the game of Nim in Haskell, where the rules of the game are as follows:

-- The initial board comprises five rows of stars.

--Inspired By https://github.com/rst0git/Nim-Game-Haskell/blob/master/nim.hs
-- haskel book https://staff.emu.edu.tr/zekibayram/Documents/courses/CMPE462/Haskell%20code/nim.hs.txt
import Data.Char


startBoard :: [Int]
startBoard = [5,4,3,2,1]


endboard :: [Int] -> Bool
endboard = all (== 0)

-- Regeln von https://de.wikipedia.org/wiki/Nim-Spiel
isValid ::  [Int] -> Int -> Int -> Bool
isValid b r count = b  !! (r-1) >= count