;;; =================================================================
;;; Name: .emacs ---  Elisp functions
;;; Copyright: It's just a emacs file.  Use it if you want.
;;; Author: Sam Napolitano
;;; $Id$
;;; =================================================================

(message "* --[ Loading my Emacs init file ]--")

;; Variable settings and behavior
;; ***************************************************************
(setq default-major-mode 'text-mode)         ; always text mode
(setq text-mode-hook 'turn-on-auto-fill)     ; auto-fill-mode
(setq fill-column 70)                        ; 70 cols
(setq scroll-step 1)                         ; scroll x lines b/t pages
(setq inhibit-startup-message t)             ; not again
(setq initial-scratch-message nil)           ; and again
;(setq display-time-day-and-date t)           ; show date with time
;(setq require-final-newline t)               ; end file with a newline
(setq next-line-add-newlines nil)            ; stop at EOF & don't add \n
(show-paren-mode 1)                          ; parenthesis matching
(transient-mark-mode t)                      ; highlight marked region

(setq global-font-lock-mode t)                    ; go for it
(setq font-lock-maximum-decoration t)        ; go all out with color
;(setq font-lock-support-mode 'lazy-lock-mode)
(setq lazy-lock-defer-time 1)                ; give it a sec
;(set-scroll-bar-mode 'right)                ; emacs 23

(put 'upcase-region 'disabled nil)      ; C-x C-u uppercase region
(put 'downcase-region 'disabled nil)    ; C-x C-l lowercase region

(line-number-mode t)
(column-number-mode t)
(savehist-mode t)                       ; store minibuffer b/t sessions

(setq backup-directory-alist
   '(("." . "~/etc/emacs.d/backups")))

;; Swap alt and command on mac
(when (eq system-type 'darwin)
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(setq delete-by-moving-to-trash nil)       ; delete by moving to trash

;; Subprocess
;; ***************************************************************
(display-time)
;(server-start)

;; Modes
;; ***************************************************************
;;
;; Goes into auto-fill-mode with wrap set at 70 cols
;; ***************************************************************
(defun good-mode ()
  (text-mode)
  (auto-fill-mode 70))

(defun my-html-mode ()
  (rhtml-mode)
  (auto-fill-mode -1))

;; Go into different modes depending on extension
;; ***************************************************************
(setq auto-mode-alist
      (append (list
               '("\\.xslt$"  . nxml-mode)
               '("\\.xml$"  . nxml-mode)
               '("\\.xsh$"  . shell-script-mode)
               '("\\.rb$"  . ruby-mode)
               '("\\.pro$"  . prolog-mode)
               '("\\.ss$"   . scheme-mode)
               '("\\.html$" . html-helper-mode)
               '("\\.txt$"  . good-mode)
               '("\\.doc$"  . good-mode)
               '("\\.erb$"  . my-html-mode)
               '("\\.sass$"  . my-html-mode)
               '("\\.haml$"  . my-html-mode)
                )
              auto-mode-alist))


;; Package setups
(require 'tramp)
(setq tramp-default-method "scp")
