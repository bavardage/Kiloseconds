(require 'cl)

(defun ks-from-time (seconds minutes hours)
  (/ (+ seconds (* minutes 60) (* hours 3600))1000.0))

(defun ks-time ()
  (interactive)
  (message "It's %.3f ks" (apply 'ks-from-time (subseq (decode-time) 0 3))))

(defun erc-cmd-KS ()
  (erc-send-message
   (format "It's %.3f ks" (apply 'ks-from-time (subseq (decode-time) 0 3)))))
