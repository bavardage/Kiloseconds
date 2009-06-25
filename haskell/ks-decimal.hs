import Data.Time

getS = timeOfDayToTime . localTimeOfDay . zonedTimeToLocalTime
getKS s = (fromRational $ toRational s) / 1000
formatKS n ks = let (b,a) = properFraction ks
                    c     = round $ a * 10^n
               in show(b) ++ "." ++ show(c)
ks = formatKS 2 . getKS . getS

main = do
  c <- getZonedTime
  putStrLn ("Current time: " ++ (ks c) ++ " kiloseconds")

