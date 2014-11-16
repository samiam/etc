;;; =================================================================
;;; Name: .emacs ---  Elisp functions
;;; Copyright: It's just a emacs file.  Use it if you want.
;;; Author: Sam Napolitano
;;; $Id$
;;; =================================================================

;; Path settings
;; ***************************************************************
(add-to-list 'load-path "~/.emacs.d")

(load "init.el")
(load "functions.el")
(load "bindings.el")

(add-to-list 'load-path "~/.emacs.d/xquery-mode")

(load "xquery-mode/setup.el")
