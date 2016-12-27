{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}
module Util where

import Control.Applicative ((<$>), (<*>))
import System.Random (StdGen, random)
import qualified Data.Text as T
import Data.Text.Encoding (decodeUtf8)
import Data.List (group, sort)
import System.Random
import System.Random.Shuffle (shuffle')

-- List manipulation
stripLeft :: (Eq a) => a -> [a] -> [a]
stripLeft x = dropWhile (==x)

stripRight :: (Eq a) => a -> [a] -> [a]
stripRight x = reverse . stripLeft x . reverse

strip :: (Eq a) => a -> [a] -> [a]
strip x = stripLeft x . stripRight x

replace :: (Eq a) => a -> a -> [a] -> [a]
replace x y = map r where
    r z = if z == x then y else z

filterOutWords :: [T.Text] -> [T.Text] -> [T.Text]
filterOutWords forbiddenWords expressions = foldr filterOutWord expressions forbiddenWords

filterOutWord :: T.Text -> [T.Text] -> [T.Text]
filterOutWord forbiddenWord = filter $ not . (T.isInfixOf forbiddenWord)

sortUniq :: (Ord a) => [a] -> [a]
sortUniq = (map head) . group . sort

headOrDefault :: a -> [a] -> a
headOrDefault d [] = d
headOrDefault _ (h:_) = h

infixr 5 ?:
(?:) :: (Eq a) => a -> [a] -> [a]
x ?: xs
    | x `elem` xs = xs
    | otherwise   = x:xs

-- String manipulation
substr :: Int -> Int -> T.Text -> T.Text
substr beg end = T.drop beg . T.take end

subfield :: Int -> Int -> T.Text -> T.Text
subfield beg end = T.strip . substr beg end

-- Random (TODO: assert that sum > 0)
shuffleList :: StdGen -> [a] -> [a]
shuffleList r0 xs = shuffle' xs (length xs) r0

chooseItem :: StdGen -> [(Int, a)] -> (a, StdGen)
chooseItem r0 [] = error "choosing item from empty list"
chooseItem r0 xs = (f 0 xs, r1) where
    (val, r1) = (random r0)
    pos = val `mod` (sum $ map fst xs)
    f acc ((n, x):xs)
        | (acc+n) > pos = x
        | otherwise = f (acc+n) xs

chooseItemUniformly :: StdGen -> [a] -> (a, StdGen)
chooseItemUniformly r0 xs = chooseItem r0 $ map (1,) xs

chooseItemsUniformly :: (Eq a) => StdGen -> Int -> [a] -> ([a], StdGen)
chooseItemsUniformly r0 0 _ = ([], r0)
chooseItemsUniformly r0 _ [] = error "not enough items to choose from"
chooseItemsUniformly r0 q xs = (y:ys, r2) where
    (y, r1) = chooseItemUniformly r0 xs
    (ys, r2) = chooseItemsUniformly r1 (q-1) (filter (/= y) xs)

-- combineSimpleFunctions :: [(Int, a)] -> (StdGen -> a)

combineFunctions :: [(Int, StdGen -> a)] -> (StdGen -> a)
combineFunctions fs r0 =
    let (f, r1) = chooseItem r0 fs
    in f r1

combineFunctionsUniformly :: [StdGen -> a] -> (StdGen -> a)
combineFunctionsUniformly fs r0 = combineFunctions (map (1,) fs) r0

-- Tests
testChooseItem :: Int -> T.Text
testChooseItem x = fst $ chooseItem (mkStdGen x) [(5, "a"), (2, "b"), (3, "c"), (10, "d")]

testChooseItemUniformly :: Int -> T.Text
testChooseItemUniformly x = fst $ chooseItemUniformly (mkStdGen x) ["a", "b", "c", "d"]

testChooseFunctionUniformly :: Int -> T.Text
testChooseFunctionUniformly x = combineFunctionsUniformly [\r -> "a", \r -> "b", \r -> "c"] (mkStdGen x)

-- Old implementations

{-chooseItemUniformly :: StdGen -> [a] -> (a, StdGen)-}
{-chooseItemUniformly r0 [] = error "choosing item from empty list"-}
{-chooseItemUniformly r0 list =-}
    {-let len = length list-}
        {-(p, r1) = random r0-}
        {-x = list !! (p `mod` len)-}
    {-in (x, r1)-}

{-chooseFunctionUniformly :: [(StdGen -> a)] -> (StdGen -> a)-}
{-chooseFunctionUniformly [] r0 = error "choosing function from empty list"-}
{-chooseFunctionUniformly fs r0 =-}
    {-let len = length fs-}
        {-(f, r1) = chooseItemUniformly r0 fs-}
    {-in f r1-}

curryUniformly :: (a -> b) -> [a] -> (StdGen -> b)
curryUniformly f [] r0 = error "choosing argument from empty list"
curryUniformly f xs r0 =
    let len = length xs
        (p, r1) = random r0
        x = xs !! (p `mod` len)
    in f x
