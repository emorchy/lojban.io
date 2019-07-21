{-# LANGUAGE OverloadedStrings #-}
module Core where

import System.Random (StdGen)
import qualified Data.Text as T
import qualified Text.Pandoc as P

-- Dictionary
type WordGenerator = StdGen -> (T.Text, StdGen)

-- Course
data Course = Course
    { courseTitle :: String
    , courseStyle :: CourseStyle
    , courseLessons :: [Lesson]
    } deriving (Show)

data CourseStyle = CourseStyle
    { courseStyleColor1 :: Maybe String
    , courseStyleIconUrl :: Maybe String
    } deriving (Show)

data Lesson = Lesson
    { lessonTitle :: String
    , lessonExercises :: ExerciseGenerator
    , lessonLecture :: P.Pandoc
    , lessonPlan :: P.Pandoc
    }

instance Show Lesson where
    show lesson = "Lesson { title = " ++ show (lessonTitle lesson) ++ " }"

-- Translations
type Translation = ([LojbanSentence], [EnglishSentence])
type TranslationGenerator = StdGen -> (Translation, StdGen)
type EnglishSentence = T.Text
type LojbanSentence = T.Text

type TranslationsByExpression = [(T.Text, [Translation])]
type TranslationGeneratorByExpression = [(T.Text, TranslationGenerator)]

type SentenceComparer = LojbanSentence -> LojbanSentence -> Bool

type SentenceCanonicalizer = T.Text -> Either String T.Text

-- Exercises
data Exercise =
    MultipleChoiceExercise
        { mceTitle :: T.Text
        , mceSentences :: [ExerciseSentence]
        , mceCorrectAlternatives :: [T.Text]
        , mceIncorrectAlternatives :: [T.Text]
        , mceFixedOrdering :: Bool
        } |
    SingleChoiceExercise
        { sceTitle :: T.Text
        , sceSentences :: [ExerciseSentence]
        , sceCorrectAlternative :: T.Text
        , sceIncorrectAlternatives :: [T.Text]
        , sceFixedOrdering :: Bool
        } |
    MatchingExercise
        { mteTitle :: T.Text
        , mteSentences :: [ExerciseSentence]
        , mteItems :: [(T.Text, T.Text)]
        } |
    TypingExercise
        { tpeTitle :: T.Text
        , tpeSentences :: [ExerciseSentence]
        , tpeValidate :: T.Text -> Bool
        , tpeCanonicalAnswer :: T.Text
        }

type ExerciseGenerator = StdGen -> Exercise

instance Show Exercise where
    show (MultipleChoiceExercise title sentences correctAlternatives incorrectAlternatives fixedOrdering) = "MultipleChoiceExercise { mceTitle = " ++ (show title) ++ ", mceSentences = " ++ (show sentences) ++ ", mceCorrectAlternatives = " ++ (show correctAlternatives) ++ ", mceIncorrectAlternatives = " ++ (show incorrectAlternatives) ++ ", fixedOrdering = " ++ (show fixedOrdering) ++ "}"
    show (SingleChoiceExercise title sentences correctAlternative incorrectAlternatives fixedOrdering) = "SingleChoiceExercise { sceTitle = " ++ (show title) ++ ", sceSentences = " ++ (show sentences) ++ ", sceCorrectAlternatives = " ++ (show correctAlternative) ++ ", sceIncorrectAlternatives = " ++ (show incorrectAlternatives) ++ ", fixedOrdering = " ++ (show fixedOrdering) ++ "}"
    show (MatchingExercise title sentences items) = "MatchingExercise { mteTitle = " ++ (show title) ++ ", mteSentences = " ++ (show sentences) ++ ", mteItems = " ++ (show items) ++ "}"
    show (TypingExercise title sentences _ canonicalAnswer) = "TypingExercise {tpeTitle = " ++ (show title) ++ ", tpeSentences = " ++ (show sentences) ++ ", canonicalAnswer = " ++ (show canonicalAnswer) ++ "}"

data ExerciseSentence = ExerciseSentence
    { esLojbanic :: Bool
    , esText :: T.Text
    } deriving (Show)
