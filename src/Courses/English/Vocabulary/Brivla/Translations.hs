{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

-- | This module defines translations for the course.
module Courses.English.Vocabulary.Brivla.Translations where

import Core
import Data.List.Split (chunksOf)
import Data.FileEmbed (embedStringFile)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import qualified Data.Map as M
import qualified Data.Yaml as Y

-- * Auxiliar functions
loadTranslationsByExpressionFromYamlText :: T.Text -> TranslationsByExpression
loadTranslationsByExpressionFromYamlText yamlText = M.assocs $ M.map handleExpression yamlData where
    yamlData :: M.Map T.Text [M.Map T.Text [T.Text]]
    Right yamlData = Y.decodeEither $ TE.encodeUtf8 yamlText
    handleExpression :: [M.Map T.Text [T.Text]] -> [Translation]
    handleExpression = map handleTranslation
    handleTranslation :: M.Map T.Text [T.Text] -> Translation
    handleTranslation dict = (dict M.! "lojban_sentences", dict M.! "translated_sentences")

saveTranslationsByExpressionToYamlText :: TranslationsByExpression -> T.Text
saveTranslationsByExpressionToYamlText translationsByExpression = TE.decodeUtf8 $ Y.encode yamlData where
    yamlData :: M.Map T.Text [M.Map T.Text [T.Text]]
    yamlData = M.map encodeExpression $ M.fromList translationsByExpression
    encodeExpression :: [Translation] -> [M.Map T.Text [T.Text]]
    encodeExpression = map encodeTranslation
    encodeTranslation :: Translation -> M.Map T.Text [T.Text]
    encodeTranslation (lojban_sentences, english_sentences) = M.fromList $ [("lojban_sentences", lojban_sentences), ("translated_sentences", english_sentences)]

-- * Translations

-- | Translations for the corresponding lesson.
translations01 :: TranslationsByExpression
translations01 = loadTranslationsByExpressionFromYamlText $(embedStringFile "courses/english/vocabulary/brivla/01_easy.yaml")

-- | Translations for the corresponding lesson.
translations02 :: TranslationsByExpression
translations02 = loadTranslationsByExpressionFromYamlText $(embedStringFile "courses/english/vocabulary/brivla/02_easy.yaml")

-- | Translations for the corresponding lesson.
translations03 :: TranslationsByExpression
translations03 = loadTranslationsByExpressionFromYamlText $(embedStringFile "courses/english/vocabulary/brivla/03_easy.yaml")

-- | Translations for the corresponding lesson.
translations04 :: TranslationsByExpression
translations04 = loadTranslationsByExpressionFromYamlText $(embedStringFile "courses/english/vocabulary/brivla/04_easy.yaml")

-- | Translations for the corresponding lesson.
translations05 :: TranslationsByExpression
translations05 = loadTranslationsByExpressionFromYamlText $(embedStringFile "courses/english/vocabulary/brivla/05_easy.yaml")