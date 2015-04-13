(defun initialize-settings ()
	;; This is temporary - need to replace this with json
	
	(declare (type integer *setting-zoom-level*))
	;Is double-float or long-float appropriate for x & y?
	(declare (type double-float *setting-x* *setting-y*))
	(declare (type fixnum *setting-canvas-width* *setting-canvas-height* *setting-max-iterations*))
	
	;; Testing
	;(setq *setting-zoom-level* 4)
	;(setq *setting-x* -0.75)
	;(setq *setting-y* 0.0)
	;(setq *setting-canvas-width* 5)
	;(setq *setting-canvas-height* 5)
	;(setq *setting-invert-colors* nil)
	;(setq *setting-max-iterations* (- 7 1))
	
	;; Matt's Destination
	;(setq *setting-zoom-level* 210453397504)
	;(setq *setting-x* -0.7491458005271852)
	;(setq *setting-y* -0.05256299708659451)
	;(setq *setting-canvas-width* 900)
	;(setq *setting-canvas-height* 500)
	;(setq *setting-invert-colors* nil)
	;(setq *setting-max-iterations* (- 767 1))
	
	;; VistaPrint Poster Test
	(setq *setting-zoom-level* 466876366840)
	(setq *setting-x* -0.7491457822750298)
	(setq *setting-y* -0.052562994794231745)
	;; Large Full Bleed
	(setq *setting-canvas-width* 5475)
	(setq *setting-canvas-height* 3675)
	;; Large Trim Size
	;(setq *setting-canvas-width* 5400)
	;(setq *setting-canvas-height* 3600)
	;; Medium Full Bleed
	(setq *setting-canvas-width* 4288)
	(setq *setting-canvas-height* 3238)
	;; Medium Trim Size
	;(setq *setting-canvas-width* 4200)
	;(setq *setting-canvas-height* 3150)
	;; Small Full Bleed
	(setq *setting-canvas-width* 3062)
	(setq *setting-canvas-height* 2012)
	;; Small Trim Size
	;(setq *setting-canvas-width* 3028)
	;(setq *setting-canvas-height* 1969)
	(setq *setting-invert-colors* nil)
	(setq *setting-max-iterations* 1000)

	;; Matt's Colors
	(setq *setting-colors* '((0 36 92) (255 0 0) (255 144 0) (4 160 63)))
	;; Black and White
	;(setq *setting-colors* '((0 0 0) (255 255 255)))
	)