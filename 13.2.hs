-- ghc -dynamic 13.2.hs
-- ./13.2
-- heavily influenced by: https://github.com/pbv/advent2024

{-# LANGUAGE RecordWildCards #-}
module Main where

import System.Environment
import Data.Char
import Data.List
import Data.Maybe
import Control.Applicative
import Control.Monad

main :: IO ()
main = do
  let path = "input/13.txt"
  input <- readInput path
  print (part2 input)

type Input = [Puzzle]

type Loc = (Int,Int)
type Vec = (Int,Int)

data Puzzle = Puzzle { buttonA :: Vec
                     , buttonB :: Vec
                     , target :: Loc
                     }
              deriving Show

readInput :: FilePath -> IO Input
readInput path = do
  txt <- readFile path
  case parseInput txt of
    Just lst -> return lst
    Nothing -> error "invalid input"

parseInput :: String -> Maybe Input
parseInput xs = do
  (p, xs) <- parsePuzzle xs
  (do xs <- newline xs    
      ps <- parseInput xs
      return (p:ps)
      <|>
      return [p])


parsePuzzle :: String -> Maybe (Puzzle, String)
parsePuzzle xs = do
  xs<-consume "Button A: " xs
  (vecA,xs) <- parseVec xs
  xs <- newline xs
  xs <- consume "Button B: "xs
  (vecB,xs) <- parseVec xs
  xs <- newline xs  
  xs <- consume "Prize: "xs
  (loc,xs) <- parseLoc xs
  xs <- newline xs    
  return (Puzzle { buttonA = vecA, buttonB = vecB, target= loc }, xs)

parseVec :: String -> Maybe (Vec, String)
parseVec xs = do
  xs <- consume "X+" xs
  (x,xs) <- parseInt xs
  xs<- consume ", Y+" xs
  (y,xs) <- parseInt xs
  return ((x,y),xs)

parseLoc :: String -> Maybe (Loc, String)
parseLoc xs = do
  xs <- consume "X=" xs
  (x,xs)<-parseInt xs
  xs <- consume ", Y=" xs
  (y,xs) <- parseInt xs
  return ((x,y),xs)

parseInt :: String  -> Maybe (Int,String)
parseInt xs@(x:_)
  | isDigit x = let xs' = takeWhile isDigit xs
                    xs''= dropWhile isDigit xs
                in Just (read xs', xs'')
parseInt _ = Nothing

newline :: String -> Maybe String
newline = consume "\n"


consume :: String -> String -> Maybe String
consume str xs
  | str `isPrefixOf` xs = Just (drop (length str) xs)
  | otherwise = Nothing

part2 :: Input -> Int
part2 input = sum [3*a+b | Just (a,b) <- map (solve_fast . adjust) input ]

-- adjust the coordinates of targets
adjust :: Puzzle -> Puzzle
adjust p@Puzzle{..} = p { target = (x + scale, y + scale) }
  where (x,y) = target
        scale = 10000000000000

solve_fast :: Puzzle -> Maybe Vec
solve_fast Puzzle{..}
  | x`mod`det == 0 && y`mod`det == 0 = Just (x`div`det, y`div`det)
  | otherwise = Nothing
  where
    x = by*tx-bx*ty
    y = -ay*tx+ax*ty 
    det = ax*by - bx*ay
    (ax,ay) = buttonA
    (bx,by) = buttonB
    (tx,ty) = target
        
  