module Main where

import Control.Applicative ((<$>))
import Data.Array
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

solveProblem :: Problem -> Maybe Solution
solveProblem (Problem am rs) = Solution . snd <$> get am rupeeCount
  where rupeeCount = length rs
        rups       = array (1, rupeeCount) [(i, rs!!(i-1)) | i <- [1..rupeeCount]]
        rupeeAt i  = rups!i
        arr        = array ((0,1), (am, rupeeCount)) [((a,r), choose a r) | a <- [0..am], r <- [1..rupeeCount]]
        get a rI
          | a == 0 && rI < 1 = Just (0, [])
          | rI < 1           = Nothing
          | otherwise        = arr!(a,rI)
        choose a rI
          | rupeeAt rI > a = 
            let r = rupeeAt rI
                zeroTo :: (Int, [(Rupee, Int)]) -> (Int, [(Rupee, Int)])
                zeroTo (c, []) = (c, [(r,0)])
                zeroTo (c, ss@((r',_):_))
                  | r == r'   = (c, ss)
                  | otherwise = (c, (r,0):ss)
            in zeroTo <$> get a (rI-1)
          | otherwise      =
            let r = rupeeAt rI
                addTo :: (Int, [(Rupee, Int)]) -> (Int, [(Rupee, Int)])
                addTo (c, []) = (c+1, [(r,1)])
                addTo (c, ss@((r',rc):tl))
                  | r == r'   = (c+1, (r,rc+1):tl)
                  | otherwise = (c+1, (r,1):ss)
            in case (get (a-r) rI, get a (rI-1)) of
              (Nothing, Nothing)  -> Nothing
              (Nothing, Just sb)  -> Just sb
              (Just sa,  Nothing) -> Just (addTo sa)
              (Just sa@(ac, _),  Just sb@(bc, _))
                                  -> if ac < bc 
                                     then Just (addTo sa)
                                     else Just (addTo sb)

printSolution :: Maybe Solution -> IO ()
printSolution (Just sol) = putStr . show $ sol
printSolution Nothing    = putStrLn "not solvable"

instance Show Solution where
  show (Solution ss) = unlines . map (\(r,n) -> "Rupee " ++ show r ++ " coin " ++ show n) . reverse $ ss