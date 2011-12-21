(import '(java.util Calendar))

(defn kiloseconds
  "Current time in kiloseconds."
  []
  (let [calendar (Calendar/getInstance)
        hours (. calendar (get Calendar/HOUR_OF_DAY))
        minutes (. calendar (get Calendar/MINUTE))
        seconds (. calendar (get Calendar/SECOND))
        kiloseconds (/ (+ (* hours 3600) (* minutes 60) seconds) 1000)]
    (println (str "Kiloseconds: " (float kiloseconds)))))

;; call it
(kiloseconds)
