(defun generate-color-transition-map ()
	(setq *color-transition-map* '())
	(dotimes (setting-colors-index (1- (length *setting-colors*)))
		(generate-color-transition setting-colors-index))
	(setq *color-transition-map* (nreverse *color-transition-map*))
	(setq *color-transition-map* (make-array (list
																					(length *color-transition-map*)
																					(length (first *color-transition-map*)))
																				 :initial-contents *color-transition-map*
																				 :element-type 'fixnum))
	)

(defun generate-color-transition (setting-colors-index)
	(let ((start-colors) (end-colors) (colors-differences) (max-color-difference 0))
		(declare (type fixnum max-color-difference))
		(setq start-colors (nth setting-colors-index *setting-colors*))
		(setq end-colors (nth (1+ setting-colors-index) *setting-colors*))
		(setq colors-differences (mapcar #'abs (mapcar #'- start-colors end-colors)))
		(setq max-color-difference (iter (for colors-difference in colors-differences)
																		 (maximize colors-difference)))
		(add-color-transition-to-map max-color-difference start-colors end-colors)
		))

(defun add-color-transition-to-map (max-color-difference start-colors end-colors)
	(dotimes (current-color-transition-index max-color-difference)
		(let ((r 0) (g 0) (b 0))
			(declare (type fixnum r g b))
			(setq r (get-color-transition-color current-color-transition-index (first start-colors) (first end-colors) max-color-difference))
			(setq g (get-color-transition-color current-color-transition-index (second start-colors) (second end-colors) max-color-difference))
			(setq b (get-color-transition-color current-color-transition-index (third start-colors) (third end-colors) max-color-difference))
			(push (list r g b) *color-transition-map*))))

(defun get-color-transition-color (current-color-transition-index start-color end-color max-color-difference)
	(round (+ (/ (* current-color-transition-index (- end-color start-color)) max-color-difference) start-color)))