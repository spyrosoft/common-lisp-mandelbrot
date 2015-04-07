(ql:quickload :zpng)
(ql:quickload :iterate)

(defpackage :firefractal-mandelbrot-png
	(:use :common-lisp :zpng :iterate)
	(:export :generate-png))

(in-package :firefractal-mandelbrot-png)

;(declaim (optimize (safety 0) (debug 0) (speed 3)))
(declaim (optimize (safety 3) (debug 3) (speed 3)))

(setq *read-default-float-format* 'double-float)

(defvar benchmark-start-time)
(defvar benchmark-stop-time)

(defvar setting-zoom-level)
(defvar setting-x)
(defvar setting-y)
(defvar setting-canvas-width)
(defvar setting-canvas-height)
(defvar setting-invert-colors)
(defvar setting-max-iterations)
(defvar setting-colors)

(defvar color-transition-map)
(defvar pixel-iteration-map)
(defvar max-pixel-iteration)
(defvar min-pixel-iteration)

(load "settings.lisp")
(load "benchmark.lisp")
(load "generate-color-transition-map.lisp")
(load "generate-pixel-iteration-map.lisp")
(load "png.lisp")

(initialize-settings)

(defun initialize-globals ()
	(setq max-pixel-iteration 0)
	(setq min-pixel-iteration setting-max-iterations))

(defun generate-png ()
	(benchmark-start "Start Generate PNG")
	(initialize-settings)
	(initialize-globals)
	(generate-color-transition-map)
	;(generate-pixel-iteration-map)
	;(write-pixel-iteration-map-to-png)
	(benchmark-stop "End Generate PNG"))

(generate-png)