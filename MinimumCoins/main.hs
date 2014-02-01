module Main where

import Control.Applicative ((<$>))
import Data.List (sort, delete)

type Rupee    = Int
type Amount   = Int
data Problem  = Problem  { amount :: Amount, rupees :: [Rupee]}
data Solution = Solution [(Rupee, Int)]

main :: IO ()
main = getProblem >>= printSolution . solveProblem

getProblem :: IO Problem
getProblem = do
  am <- readLn
  rs <- sort . read . curly2brace <$> getLine
  return $ Problem am rs
  where curly2brace :: String -> String
        curly2brace = ('[':) . (++"]") . delete '{' . delete '}'

solveProblem :: Problem -> Solution
solveProblem _ = undefined

printSolution :: Solution -> IO ()
printSolution = putStrLn . show

instance Show Solution where
  show (Solution ss) = unlines . map (\(r,n) -> "Rupee " ++ show r ++ " coin " ++ show n) $ ss