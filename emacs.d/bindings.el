;; Global Key Bindings
;; ***************************************************************
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-h" 'delete-backward-char)
;(global-set-key [delete] 'help-command)

;(global-set-key "\C-cq" 'quote-region)
;(global-set-key "\C-cu" 'un-quote-region)

(global-set-key "\M-o" (lambda () (interactive) (other-window 1)))
(global-set-key "\M-p" (lambda () (interactive) (other-window -1)))

(define-key global-map [help] 'info)
(define-key global-map [f1] 'describe-variable)
(define-key global-map [s-f1] 'info)
(define-key global-map [f2] 'describe-key)
;; (define-key global-map [f3] 'goto-line)
(define-key global-map [f4] 'query-replace)
(define-key global-map [f5] 'comment-region)
(define-key global-map [f5] 'c-comment-line)
(define-key global-map [f6] 'c-uncomment-line)
;(define-key global-map [f6] (lambda ()
;			      (interactive "r")
;			      (interactive)
; 			      (narrow-to-region (point) (mark))
;			      (universal-argument) 
;			      (comment-region)
;			      (comment-region start end)
;			      ) )
;(define-key global-map [f7] 'scheme-comment-line)
;(define-key global-map [f8] 'scheme-uncomment-line)
(define-key global-map [f7] 'xquery-comment-line)
(define-key global-map [f8] 'xquery-uncomment-line)
(define-key global-map [f9] 'svn-status)
;; ;; ;; (define-key global-map [f10] 'save-buffer)
;; ;; ;; (define-key global-map [f11] 'eval-region)
(define-key global-map [f12] 'indent-region)

(define-key global-map [insert] 'other-window)     ; kp insert
(define-key global-map [f29] 'scroll-down)         ; kp 9
(define-key global-map [f35] 'scroll-up)           ; kp 3
(define-key global-map [f27] 'beginning-of-buffer) ; kp 7
(define-key global-map [f33] 'end-of-buffer)       ; kp 1

