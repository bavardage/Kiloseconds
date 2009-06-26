(multiple-value-bind (seconds minutes hours)
   (get-decoded-time)
 (print (/ (+ seconds
              (* minutes 60)
              (* hours 3600))
           1000.0)))
