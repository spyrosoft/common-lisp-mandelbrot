(defun write-mandelbrot-to-png ()
	(with-open-file (file "first.png" :direction :output :if-exists :supersede)
		(let* ((png (make-instance 'png
															 :color-type :truecolor
															 :width setting-canvas-width
															 :height setting-canvas-height))
					 (image-data (data-array png)))
			(dotimes (x setting-canvas-width (write-png png file))
				(dotimes (y setting-canvas-height)
					(let ((rgb '()))
						(setq rgb (get-pixel-iteration-colors x y))
						(setf (aref image-data y x 0) (aref rgb 0))
						(setf (aref image-data y x 1) (aref rgb 1))
						(setf (aref image-data y x 2) (aref rgb 2))
						)))
			)))

(defun get-pixel-iteration-colors (x y)
	(let* ((optimized-iteration (aref pixel-iteration-map x y)))
		(declare (type fixnum optimized-iteration))
		(setq optimized-iteration (get-contrast-optimized-iteration optimized-iteration))
		(setq optimized-iteration (get-pixel-iteration-to-color-transition-translation optimized-iteration))
		(if setting-invert-colors
				(setq optimized-iteration (- (1- (length color-transition-map)) optimized-iteration)))
		(make-array '(3)
								:element-type 'fixnum
								:initial-contents (list
																	 (aref color-transition-map optimized-iteration 0)
																	 (aref color-transition-map optimized-iteration 1)
																	 (aref color-transition-map optimized-iteration 2)))
		))

(defun get-contrast-optimized-iteration (optimized-iteration)
	;; If they are the same, the maximize contrast code tries to divide by zero. Min needs to be decremented - not max - for the image to maintain full luminosity.
	(if (= min-pixel-iteration max-pixel-iteration)
			(setq min-pixel-iteration (1- min-pixel-iteration)))
	(round (* (- optimized-iteration min-pixel-iteration) (/ max-pixel-iteration (- max-pixel-iteration min-pixel-iteration))))
	)

(defun get-pixel-iteration-to-color-transition-translation (optimized-iteration)
	(round (* (/ (1- (first (array-dimensions color-transition-map))) max-pixel-iteration) optimized-iteration)))