(let* ([date-struct (seconds->date (current-seconds))]
       [seconds (date-second date-struct)]
       [minutes (date-minute date-struct)]
       [hours (date-hour date-struct)])
 (display (/ (+ seconds
                (* minutes 60)
                (* hours 3600))
             1000.0)))