{-# LANGUAGE OverloadedStrings #-}
module Lessons.Exercises where

import Core
import Util (chooseItem, chooseItemUniformly, chooseItemsUniformly, combineGenerators, combineGeneratorsUniformly)
import System.Random (StdGen)
import qualified Data.Text as T
import qualified Data.Map as M

-- Exercise: recall gismu meaning
generateGismuMeaningExercise :: [Gismu] -> StdGen -> Exercise
generateGismuMeaningExercise gismuList = combineGenerators [(4, f1), (1, f2), (7, f3), (3, f4)] where
        -- Exercise: match gismu with keyword
        f1 :: StdGen -> Exercise
        f1 r0 = MatchingExercise text items where
            (chosenGismu, _) = chooseItemsUniformly r0 3 $ gismuList
            item gismu = (gismuText gismu, head $ gismuEnglishKeywords gismu)
            text = "Match gismu with keyword"
            items = map item chosenGismu
        -- Exercise: match gismu with full definition
        f2 :: StdGen -> Exercise
        f2 r0 = MatchingExercise text items where
            (chosenGismu, _) = chooseItemsUniformly r0 3 $ gismuList
            item gismu = (gismuText gismu, gismuEnglishDefinition gismu)
            text = "Match gismu with definition"
            items = map item chosenGismu
        -- Exercise: choose the correct keyword for a gismu
        f3 :: StdGen -> Exercise
        f3 r0 = SingleChoiceExercise text correctAlternative incorrectAlternatives False where
            (chosenGismu, _) = chooseItemsUniformly r0 4 $ gismuList
            text = "Select keyword for **" `T.append` (gismuText $ head chosenGismu) `T.append` "**"
            alternative gismu = head $ gismuEnglishKeywords gismu
            correctAlternative = alternative $ head chosenGismu
            incorrectAlternatives = map alternative $ tail chosenGismu
        -- Exercise: choose the correct definition for a gismu
        f4 :: StdGen -> Exercise
        f4 r0 = SingleChoiceExercise text correctAlternative incorrectAlternatives False where
            (chosenGismu, _) = chooseItemsUniformly r0 4 $ gismuList
            text = "Select definition for **" `T.append` (gismuText $ head chosenGismu) `T.append` "**"
            alternative gismu = gismuEnglishDefinition gismu
            correctAlternative = alternative $ head chosenGismu
            incorrectAlternatives = map alternative $ tail chosenGismu
        -- Exercise (TODO): match gismu with image
        -- Exercise (TODO): choose the correct image for a gismu

-- Exercise: recall gismu place structure
generateBasicGismuPlacesExercise :: [Gismu] -> StdGen -> Exercise
generateBasicGismuPlacesExercise gismuList = combineGeneratorsUniformly [f1, f2] where
    f1 :: StdGen -> Exercise
    f1 r0 = MatchingExercise text items where
        (chosenGismu, _) = chooseItemUniformly r0 . filter ((>=3) . length . gismuEnglishPlaces) $ gismuList
        placeTags = map T.pack . map (\n -> 'x' : show n) $ [1..]
        placeKeywords = gismuEnglishPlaces chosenGismu
        text = "Identify the place structure of **" `T.append` (gismuText chosenGismu) `T.append` "**"
        items = zip placeTags placeKeywords
    f2 :: StdGen -> Exercise
    f2 r0 = SingleChoiceExercise text (displayPlaceStructure correctAlternative) (map displayPlaceStructure incorrectAlternatives) False where
        (chosenGismu, r1) = chooseItemUniformly r0 . filter ((>=3) . length . gismuEnglishPlaces) $ gismuList
        correctAlternative = gismuEnglishPlaces chosenGismu
        (incorrectAlternatives, _) = reorderSumtiPlaces correctAlternative r0
        text = "Select the place structure of **" `T.append` (gismuText chosenGismu) `T.append` "**"

generateAdvancedGismuPlacesExercise :: [Gismu] -> StdGen -> Exercise
generateAdvancedGismuPlacesExercise gismuList = combineGeneratorsUniformly [f1, f2] where
    f1 :: StdGen -> Exercise
    f1 r0 = MatchingExercise text items where
        (chosenGismu, r1) = chooseItemUniformly r0 . filter ((>=3) . length . gismuEnglishPlaces) $ gismuList
        placeGismu = map ((`T.append` (gismuText chosenGismu)) . (`T.append` " ") . displayPlacePrefix) [1..]
        placeKeywords = take 5 $ gismuEnglishPlaces chosenGismu
        text = "Identify the place structure of **" `T.append` (gismuText chosenGismu) `T.append` "**"
        items = zip placeGismu placeKeywords
    f2 :: StdGen -> Exercise
    f2 r0 = SingleChoiceExercise text (snd correctAlternative) (map snd incorrectAlternatives) False where
        (chosenGismu, r1) = chooseItemUniformly r0 . filter ((>=3) . length . gismuEnglishPlaces) $ gismuList
        placeGismu = map ((`T.append` (gismuText chosenGismu)) . (`T.append` " ") . displayPlacePrefix) [1..]
        placeKeywords = take 5 $ gismuEnglishPlaces chosenGismu
        allAlternatives = zip placeGismu placeKeywords
        (correctAlternative, _) = chooseItemUniformly r1 $ allAlternatives
        incorrectAlternatives = filter (/= correctAlternative) allAlternatives
        text = "Select the keyword for **" `T.append` (fst correctAlternative)

reorderSumtiPlaces :: [T.Text] -> StdGen -> ([[T.Text]], StdGen)
reorderSumtiPlaces [x1, x2, x3] r0 = (l, r0) where
       -- [x1, x2, x3]
    l = [ [x1, x3, x2] ]
reorderSumtiPlaces [x1, x2, x3, x4] r0 = (l, r0) where
       -- [x1, x2, x3, x4]
    l = [ [x1, x3, x2, x4]
        , [x1, x2, x4, x3]
        ] -- problematic (TOFIX): always take 2x(x2), 2x(x4)
reorderSumtiPlaces [x1, x2, x3, x4, x5] r0 = (l, r0) where
       -- [x1, x2, x3, x4, x5]
    l = [ [x1, x3, x2, x4, x5]
        , [x1, x3, x4, x2, x5]
        , [x1, x3, x2, x4, x5]
        {-, [x1, x2, x4, x3, x5]-}
        {-, [x1, x2, x3, x5, x4]-}
        --TODO: randomize
        ] -- problematic (TOFIX): ...

displayPlacePrefix :: Int -> T.Text
displayPlacePrefix 1 = "lo"
displayPlacePrefix 2 = "lo se"
displayPlacePrefix 3 = "lo te"
displayPlacePrefix 4 = "lo ve"
displayPlacePrefix 5 = "lo xe"

displayPlaceStructure :: [T.Text] -> T.Text
displayPlaceStructure placeKeywords = T.intercalate ", " $ zipWith T.append placeTags placeKeywords where
    placeTag n = "(x" ++ (show n) ++ ") "
    placeTags = map (T.pack . placeTag) [1..]

-- Other exercises...
-- Exercise: given a portion of a sentence, choose its syntactical function
{-generateExercise6 :: StdGen -> Exercise-}
{-generateExercise6 r0 =-}
    {-let allAlternatives = ["bridi", "selbri", "sumti"]-}
        {-(correctAlternative, r1) = chooseItemUniformly r0 allAlternatives-}
        {-incorrectAlternatives = filter (/= correctAlternative) allAlternatives-}
        {-text = "Choose the synatical function of the highlighted text: "-}
    {-in SingleChoiceExercise text correctAlternative incorrectAlternatives-}
