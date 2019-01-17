; Use from shell:
; for f in $*;
; do
;   emacs -batch $f -l ~/.emacs.d/untabify.el -f emacs-format-function 
; done

(defun emacs-format-function ()
   "Format the whole buffer."
;   (c-set-style "stroustrup")
;   (indent-region (point-min) (point-max) nil)
   (untabify (point-min) (point-max))
   (save-buffer)
)
