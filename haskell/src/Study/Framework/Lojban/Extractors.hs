-- | This module provides utilities for extracting a desired entity from a broader one.
module Study.Framework.Lojban.Extractors
( extractTrivialBridiGeneratorFromVocabulary
, extractSimpleBridiGeneratorFromTranslationGenerator
, extractLojbanSentencesFromTranslationGenerator
, extractLojbanSentencesFromTranslation
) where

import Core
import Language.Lojban.Core
import Util (chooseItemUniformly)
import Language.Lojban.Canonicalization (extractSimpleBridi)
import Study.Framework.Lojban.TranslationUtils (narrowTranslationGenerator)
import qualified Data.Text as T

-- | Produces trivial bridi (i.e. bridi with no sumti) from the vocabulary.
extractTrivialBridiGeneratorFromVocabulary :: Vocabulary -> SimpleBridiGenerator
extractTrivialBridiGeneratorFromVocabulary vocabulary r0 = (simpleBridi, r1) where
    (brivla, r1) = chooseItemUniformly r0 $ vocabularyBrivlaList vocabulary
    simpleBridi = SimpleBridi False brivla [] []

-- | Extracts a SimpleBridi among the sentences included in the translation generator.
--
-- Warning: the translation generator must consist solely of parsable sentences, otherwise
-- this function will yield an error upon encountering a non-parsable sentence.
extractSimpleBridiGeneratorFromTranslationGenerator :: TranslationGenerator -> SimpleBridiGenerator
extractSimpleBridiGeneratorFromTranslationGenerator translationGenerator r0 = (simpleBridi, r1) where
    narrowedTranslationGenerator = narrowTranslationGenerator translationGenerator
    (sentence, r1) = extractLojbanSentencesFromTranslationGenerator narrowedTranslationGenerator r0
    simpleBridi = case (extractSimpleBridi sentence) of
        Left msg -> error $ "extractSimpleBridiFromTranslationGenerator: unable to parse sentence\nsentence: \"" ++ (T.unpack sentence) ++ "\"\nmessage: " ++ msg ++ "\""
        Right simpleBridi' -> simpleBridi'

-- | Extracts a Lojban sentence among those included in the translation generator.
extractLojbanSentencesFromTranslationGenerator :: TranslationGenerator -> TextGenerator
extractLojbanSentencesFromTranslationGenerator translationGenerator r0 = (sentence, r2) where
    (translation, r1) = translationGenerator r0
    (sentence, r2) = chooseItemUniformly r1 $ extractLojbanSentencesFromTranslation translation

-- | Extracts the list of Lojban sentences from the translation.
extractLojbanSentencesFromTranslation :: Translation -> [T.Text]
extractLojbanSentencesFromTranslation (lojban_sentences, translated_sentences) = lojban_sentences
