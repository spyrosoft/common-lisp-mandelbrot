(defun benchmark-start (benchmark-message)
	(print benchmark-message)
	(setq benchmark-start-time (get-universal-time)))

(defun benchmark-stop (benchmark-message)
	(setq benchmark-stop-time (get-universal-time))
	(print (- benchmark-stop-time benchmark-start-time))
	(print benchmark-message))