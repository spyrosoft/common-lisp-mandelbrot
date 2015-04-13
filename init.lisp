(ql:quickload :zpng)
(ql:quickload :iterate)

(defpackage :firefractal-mandelbrot-png
	(:use :common-lisp :zpng :iterate)
	(:export :generate-png))

(in-package :firefractal-mandelbrot-png)

;(declaim (optimize (speed 3) (safety 0) (space 0) (debug 0) (compilation-speed 0)))
(declaim (optimize (speed 3) (safety 3) (space 0) (debug 3) (compilation-speed 0)))

(setq *read-default-float-format* 'double-float)

(defvar *setting-zoom-level*)
(defvar *setting-x*)
(defvar *setting-y*)
(defvar *setting-canvas-width*)
(defvar *setting-canvas-height*)
(defvar *setting-invert-colors*)
(defvar *setting-max-iterations*)
(defvar *setting-colors*)

(defvar *color-transition-map*)
(defvar *pixel-iteration-map*)
(defvar *max-pixel-iteration*)
(defvar *min-pixel-iteration*)

(load "settings.lisp")
(load "generate-color-transition-map.lisp")
(load "generate-pixel-iteration-map.lisp")
(load "png.lisp")

(defun initialize-globals ()
	(setq *max-pixel-iteration* 0)
	(setq *min-pixel-iteration* *setting-max-iterations*))

(defun generate-png ()
	(print "Initialize Settings")
	(time (initialize-settings))
	(print "Initialize Globals")
	(time (initialize-globals))
	(print "Generate Color Transition Map")
	(time (generate-color-transition-map))
	(print "Generate Pixel Iteration Map")
	(time (generate-pixel-iteration-map))
	(print "Write PNG File")
	(time (write-mandelbrot-to-png)))

(generate-png)