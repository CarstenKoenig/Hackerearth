module Main where

import Control.Monad (forM_)
import Data.List (sort)

type Problem = ()
type Solution = ()

main :: IO ()
main = getProblem >>= printSolution . solveProblem

getProblem :: IO Problem
getProblem = undefined

solveProblem :: Problem -> Solution
solveProblem _ = undefined

printSolution :: Solution -> IO ()
printSolution = undefined