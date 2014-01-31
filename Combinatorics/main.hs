{- | 

Little Chef's big brother is getting married. 
Therefore, Chef's parents put up a sign that says 'COMBINATORICS'. 
The sign is so big that exactly one letter fits on each panel. 
Some of the Chef's younger cousins got bored during the reception and decided to rearrange the panels. 
So determine in how many unique ways can the panels be arranged (counting the original arrangement)?

Input

First line contains a single integer T(less than 1000) denoting the total number of test cases.

Each test case contains a string S having atmost 15 characters from A to Z. Output

For each word, output the number of unique ways that the letters can be rearranged (counting the original arrangement).

Strategy:

If we ignore that the characters can be the same, then there are (length text)! different rearrangements.
Now if there is a character c more than one (say n) times in the text we can rearrange those occurences in n! ways
without changing the real count.
The idea is now to compress the text into a "signature": "HALLO" -> [(1,'H'), (1, 'A'), (2, 'L'), (1, 'O')]
and use this to divide through the product of each possible character rearrangement

-}

module Main where

import Control.Monad (forM_)
import Data.List (sort)

main :: IO ()
main = do
    count <- readLn :: IO Int
    forM_ [1..count] processCase

processCase :: a -> IO ()
processCase _ = do
    text <- getLine
    putStrLn . show $ nrOfRearrangements text

nrOfRearrangements :: String -> Integer
nrOfRearrangements text = totalRear `div` identRear
    where totalRear = fact (fromIntegral . length $ text)
          identRear = product [ fact s | (s, _) <- signature text, s > 1 ]

signature :: Ord a => [a] -> [(Integer, a)]
signature as = col (sort as) []
    where col [] acc    = acc
          col (c:cs) [] = col cs [(1, c)]
          col (c:cs) ((n,c'):acc)
            | c == c'   = col cs ((n+1,c):acc)
            | otherwise = col cs ((1, c):(n,c'):acc)

fact :: Integer -> Integer
fact n = product [1..n]