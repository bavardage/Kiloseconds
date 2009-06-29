import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Expr
import Data.Char (toLower)
import Control.Monad
import Data.Time hiding (parseTime)


data Time = Time { hours :: Int
                 , minutes :: Int } | Now | Error String deriving Show
data AMPM = AM | PM | Hour24 deriving Show
data Relative = Past | To

isValidTime t = (hours t) < 24 && (minutes t) < 60

applyAMPMToTime :: AMPM -> Time -> Time
applyAMPMToTime PM t = t { hours = (12 + hours t) }
applyAMPMToTime _ t  = t


timeToKiloseconds (Time h m) = return $ 
                               (3600 * fromIntegral h + 60 * fromIntegral m) / 1000
timeToKiloseconds Now = liftM ks getZonedTime
    where
      diffTimeToKiloSeconds diffTime = (fromRational $ toRational diffTime) / 1000
      secondsSinceMidnight = timeOfDayToTime . localTimeOfDay . zonedTimeToLocalTime
      ks = diffTimeToKiloSeconds . secondsSinceMidnight
timeToKiloseconds _ = return 0


parseAMPM = am <|> pm <|> parseTimeOfDay
am = string "am" >> return AM
pm = string "pm" >> return PM

parseTimeOfDay = try morning <|> try afternoon <|> try evening <|> return Hour24
inThe when = do
  spaces
  many $ string "in"
  spaces
  many $ string "the"
  spaces
  string when
morning = inThe "morning" >> return AM
afternoon = inThe "afternoon" >> return PM
evening = inThe "evening" >> return PM


makeNumberParser = foldr (<|>) (fail "not a digit") .
                   map (\(s,d) -> try (string s >> return d))

parseUnits = makeNumberParser                  
                     [("one", "1"), ("two", "2"), ("three", "3"),
                      ("four", "4"), ("five", "5"), ("six", "6"), 
                      ("seven", "7"), ("eight", "8"), ("nine", "9")]

parseOddities = makeNumberParser
                [("ten", "10"), ("eleven", "11"), ("twelve", "12"),
                 ("thirteen", "13"), ("fourteen", "14"), ("fifteen", "15"),
                 ("sixteen", "16"), ("seventeen", "17"), ("eighteen", "18"),
                 ("nineteen", "19")]

parseTens = makeNumberParser
            [("twenty", "2"), ("thirty", "3"), ("fourty", "4"), ("fifty", "5")]

parseWholeDoubleDigit = do
  t <- parseTens
  many (oneOf " -")
  u <- parseUnits <|> return "0"
  return (t ++ u)

parseSpecialHour =
    try (string "midnight" >> return "0") <|>
    try (string "noon" >> return "12") <|>
    try (string "midday" >> return "12")

parseWrittenNumber = parseWholeDoubleDigit <|> parseOddities <|> parseUnits

hour = do
  hs <- many1 digit <|> parseWrittenNumber <|> parseSpecialHour
  let x = (read hs)
  if x < 24
     then return x
     else fail "hours must be less than 24"

minute = do
  ms <- many1 digit <|> parseWrittenNumber
  let x = read ms
  if x < 60
     then return x
     else fail "minutes must be less than 60"

period = (string "quarter" >> return 15) 
         <|> (string "half" >> return 30)

parsePastTo = past <|> to
past = string "past" >> return Past
to = string "to" >> return To

parsePastToPhrase = do
  m <- minute <|> period
  spaces
  pt <- parsePastTo
  spaces
  h <- hour
  tod <- parseTimeOfDay
  t <- case pt of
        Past -> return $ Time h m
        To -> return $ Time (h-1) (60-m)
  let time = applyAMPMToTime tod t
  if isValidTime time
     then return time
     else return $ Error "that time isn't valid"
  
  
parseNumeric = do
  hours <- hour
  skipMany1 (char ':') <|> spaces
  minutes <- minute
  spaces
  amPM <- parseAMPM
  let time = (applyAMPMToTime amPM) $ Time hours minutes
  if isValidTime time
     then return time
     else return $ Error "that time isn't valid"


parseSpecial = parseSpecialHour >>= \h -> return $ Time (read h) 0


parseTime = try parseNumeric <|> try parsePastToPhrase <|> parseSpecial 
            <|> (string "now" >> return Now)

parseTimeString :: String -> Time
parseTimeString input = case (parse parseTime "" input) of
                Left err -> Error "oh noes"
                Right t -> t

test = parseTest parseTime


loop = do
  putStrLn "Enter time:"
  str <- getLine
  let time = parseTimeString (map toLower str)
  ks <- timeToKiloseconds time
  putStrLn $ "Time is " ++ (formatKS 3 ks) ++ " ks"
  loop
      where
        formatKS n ks = let (b,a) = properFraction ks
                            c     = round $ a * 10^n
                        in show(b) ++ "." ++ show(c)
  
main = loop