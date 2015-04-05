(defun generate-pixel-iteration-map ()
	(setq pixel-iteration-map
		(make-array
			(list setting-canvas-width setting-canvas-height)
			:element-type 'fixnum))
	(generate-pixel-iteration-map-x))

(defun generate-pixel-iteration-map-x ()
	(let ((x0 0.0))
		(declare (type double-float x0))
		(loop for x-pixel from 0 to (- setting-canvas-width 1) do
				 (setq x0 (map-x-pixel-to-cartesian x-pixel))
				 (generate-pixel-iteration-map-y x0 x-pixel))))

(defun map-x-pixel-to-cartesian (x-pixel)
	(+ (/ (- x-pixel (/ setting-canvas-width 2)) setting-zoom-level) setting-x))

(defun generate-pixel-iteration-map-y (x0 x-pixel)
	(let ((y0 0.0) (iteration 0))
		(declare (type double-float y0))
		(declare (type fixnum iteration))
		(loop for y-pixel from 0 to (- setting-canvas-height 1) do
				 (setq y0 (map-y-pixel-to-cartesian y-pixel))
				 (setq iteration (iterate x0 y0))
				 (setf (aref pixel-iteration-map x-pixel y-pixel) iteration)
				 (if (> iteration max-pixel-iteration)
						 (setq max-pixel-iteration iteration))
				 (if (< iteration min-pixel-iteration)
						 (setq min-pixel-iteration iteration)))))

(defun map-y-pixel-to-cartesian (y-pixel)
	(+ (* -1 (/ (- y-pixel (/ setting-canvas-height 2)) setting-zoom-level)) setting-y))

(defun iterate (x0 y0)
	(let ((x 0.0) (y 0.0) (x-temporary 0.0))
		(declare (type double-float x y x-temporary))
		(do ((iteration 0 (1+ iteration)))
				((not (and
							 (< (- (* x x) (* y y)) 4)
							 (< iteration setting-max-iterations))) iteration)
			(setq x-temporary (+ (- (* x x) (* y y)) x0))
			(setq y (+ (* 2 x y) y0))
			(setq x x-temporary)
			;Hack to prevent floating point overflow
			(cond ((> (abs x) 1.0e25) (return iteration)
						 (> (abs y) 1.0e25) (return iteration))))))