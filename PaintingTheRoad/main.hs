{- | 
## Description
There is a kingdom, that has a long straight road of length L meters and width 0. Coordinate x on the road denotes point that is at x meters from the start of the road. That is coordinate 0 denotes beginning of the road and coordinate L denotes end of the road. The road has to be painted with color. There are K proposals, Each proposal is of the form a, b, c which means that the road can be painted from coordinate a to coordinate b for the cost c. Note that some part of road can be painted multiple times and it is still considered to be painted.

The king wants to know if the whole road can be painted and if possible, also wants to know the minimum cost that is required to paint the entire road.

## Input
First line of the input is the number of test cases T. It is followed by T test cases.In each test case first line has two space separated integers, the length of the road L and the number of proposals K. It is followed by K lines, which are K proposals, each proposal is 3 space separated integers a b and c.

## Output
For each test case output a single integer, that is minimum cost required to paint the enitre road. If it is impossible to paint the entire road, print -1.

## Constraints
1 <= T <= 10
1 <= L <= 256
1 <= K <= 512
0 <= a < b <= L
1 <= c <= 1000

## Strategy
I think the best bet is to go dynamic programming.
So crunch out an array where the the entry `arr[(i,j)]` will stand for the minimum cost of painting the road till length `j` if you only use the first `i` probosals.
-}

module Main where

import Control.Monad (forM_, forM)
import Control.Applicative ((<$>))
import Data.Array

type Cost     = Int
type Distance = Int

data Proposal = Prop 
  { fromCoord :: Distance
  , toCoord   :: Distance
  , cost      :: Cost 
  }

main :: IO ()
main = do
    count <- readLn :: IO Int
    forM_ [1..count] processCase

processCase :: a -> IO ()
processCase _ = do
    (roadLen, nrProp) <- readParams
    proposals <- forM [1..nrProp] readProposal
    let minCost = calculateCost roadLen proposals
    putStrLn . showCost $ minCost
    where readParams = do
            (l:n:_) <- map read . words <$> getLine
            return (l,n)
          readProposal _ = do
            (a:b:c:_) <- map read . words <$> getLine
            return $ Prop a b c
          showCost Nothing   = "-1"
          showCost (Just c)  = show c

calculateCost :: Distance -> [Proposal] -> Maybe Cost
calculateCost roadLen proposals = get count roadLen
    where arr                   = array ((1,0), (count, roadLen)) [((i,j), choose i j) | i <- [1..count], j <- [0..roadLen]]
          probs                 = array (1, count) [(i, proposals !! (i-1)) | i <- [1..count]]
          count                 = length proposals
          prob i                = probs!i
          get i j
            | j == 0            = Just 0
            | i < 1             = Nothing
            | otherwise         = arr!(i,j)
          choose i j
            | j < f || j > t    = get (i-1) j
            | otherwise         =
                case (get (i-1) j, get (i-1) f) of
                  (Nothing, Nothing) -> Nothing
                  (Nothing, Just b)  -> Just $ b + c
                  (Just a, Nothing)  -> Just a
                  (Just a, Just b)   -> Just $ min a (b + c)
            where (Prop f t c)  = prob i