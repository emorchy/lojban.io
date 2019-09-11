{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

-- | This module defines documents pertaining to the course, such as lesson materials and lesson plans.
module Courses.English.Grammar.Introduction.Documents where

import Courses.Framework.DocumentBuilders (buildDocumentFromMarkdownCode)
import Data.FileEmbed (embedStringFile)
import qualified Text.Pandoc as P

-- * Lesson contents
-- | Lecture for the first lesson.
lecture1 :: P.Pandoc
Right lecture1 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/01.md")

-- | Lecture for the second lesson.
lecture2 :: P.Pandoc
Right lecture2 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/02.md")

-- | Lecture for the third lesson.
lecture3 :: P.Pandoc
Right lecture3 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/03.md")

-- | Lecture for the fourth lesson.
lecture4 :: P.Pandoc
Right lecture4 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/04.md")

-- | Lecture for the fifth lesson.
lecture5 :: P.Pandoc
Right lecture5 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/05.md")

-- | Lecture for the sixth lesson.
lecture6 :: P.Pandoc
Right lecture6 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/06.md")

-- | Lecture for the seventh lesson.
lecture1to6 :: P.Pandoc
Right lecture1to6 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/checkpoint_01to06.md")

-- | Lecture for the eighth lesson.
lecture8 :: P.Pandoc
Right lecture8 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/08.md")

-- | Lecture for the nineth lesson.
lecture9 :: P.Pandoc
Right lecture9 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/09.md")

-- | Lecture for the tenth lesson.
lecture10 :: P.Pandoc
Right lecture10 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/10.md")

-- | Lecture for the eleventh lesson.
lecture11 :: P.Pandoc
Right lecture11 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/11.md")

-- | Lecture for the twelveth lesson.
lecture12 :: P.Pandoc
Right lecture12 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/12.md")

-- | Lecture for the thirteenth lesson.
lecture8to12 :: P.Pandoc
Right lecture8to12 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/checkpoint_08to12.md")

-- | Lecture for the fourteenth lesson.
lecture14 :: P.Pandoc
Right lecture14 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/14.md")

-- | Lecture for the fifteenth lesson.
lecture15 :: P.Pandoc
Right lecture15 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/15.md")

-- | Lecture for the sixteenth lesson.
lecture16 :: P.Pandoc
Right lecture16 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/16.md")

-- | Lecture for the seventeenth lesson.
lecture17 :: P.Pandoc
Right lecture17 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/lectures/17.md")

-- * Lesson plans

-- | Plan for the first lesson.
plan1 :: P.Pandoc
Right plan1 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/01.md")

-- | Plan for the second lesson.
plan2 :: P.Pandoc
Right plan2 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/02.md")

-- | Plan for the third lesson.
plan3 :: P.Pandoc
Right plan3 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/03.md")

-- | Plan for the fourth lesson.
plan4 :: P.Pandoc
Right plan4 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/04.md")

-- | Plan for the fifth lesson.
plan5 :: P.Pandoc
Right plan5 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/05.md")

-- | Plan for the sixth lesson.
plan6 :: P.Pandoc
Right plan6 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/06.md")

-- | Plan for the seventh lesson.
plan1to6 :: P.Pandoc
Right plan1to6 = buildDocumentFromMarkdownCode ""

-- | Plan for the eighth lesson.
plan8 :: P.Pandoc
Right plan8 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/08.md")

-- | Plan for the nineth lesson.
plan9 :: P.Pandoc
Right plan9 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/09.md")

-- | Plan for the tenth lesson.
plan10 :: P.Pandoc
Right plan10 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/10.md")

-- | Plan for the eleventh lesson.
plan11 :: P.Pandoc
Right plan11 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/11.md")

-- | Plan for the twelveth lesson.
plan12 :: P.Pandoc
Right plan12 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/12.md")

-- | Plan for the thirteenth lesson.
plan8to12 :: P.Pandoc
Right plan8to12 = buildDocumentFromMarkdownCode ""

-- | Plan for the fourteenth lesson.
plan14 :: P.Pandoc
Right plan14 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/14.md")

-- | Plan for the fifteenth lesson.
plan15 :: P.Pandoc
Right plan15 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/15.md")

-- | Plan for the sixteenth lesson.
plan16 :: P.Pandoc
Right plan16 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/16.md")

-- | Plan for the seventeenth lesson.
plan17 :: P.Pandoc
Right plan17 = buildDocumentFromMarkdownCode $(embedStringFile "courses/english/grammar/introduction/planning/17.md")