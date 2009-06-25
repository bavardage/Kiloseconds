import Data.Time

diffTimeToKiloSeconds diffTime = (fromRational $ toRational diffTime) / 1000
secondsSinceMidnight = timeOfDayToTime . localTimeOfDay . zonedTimeToLocalTime
kiloSecondsSinceMidnight = diffTimeToKiloSeconds . secondsSinceMidnight

main = do localTime <- getZonedTime
          putStrLn $ "It's "
                     ++ show (kiloSecondsSinceMidnight localTime)
                     ++ " kiloseconds"

