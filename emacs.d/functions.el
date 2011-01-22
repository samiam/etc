; Convert a buffer from dos ^M end of lines to unix end of lines
(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;vice versa
(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;; Un/Quoting messages
;; ***************************************************************
(defun quote-region (x y)
  "Add leading > signs to the region"
  (interactive "r")
  (setq lines
        (+ (count-lines x y)
           (if (= (current-column) 0) 1 0)))
  (goto-char x)
  (beginning-of-line)
  (while (> lines 0)
    (progn
      (insert ">")
      (next-line 1)
      (beginning-of-line)
      (setq lines (- lines 1))
      )))

(defun un-quote-region (x y)
  "Remove the leading > signs from the region"
  (interactive "r")
  (setq lines
        (+ (count-lines x y)
           (if (= (current-column) 0) 1 0)))
  (goto-char x)
  (beginning-of-line)
  (while (> lines 0)
    (progn
      (if (looking-at ">")
          (delete-char 1))
      (next-line 1)
      (setq lines (- lines 1))
      )))

(defun scheme-comment-line ()
  (interactive)
  (beginning-of-line)
  (insert "; ")
  (forward-line))

(defun scheme-uncomment-line ()
  (interactive)
  (beginning-of-line)
  (delete-char 2)
  (forward-line))

(defun c-comment-line ()
  (interactive)
  (beginning-of-line)
  (insert "/* ")
  (end-of-line)
  (insert " */")
  (forward-line))

(defun c-uncomment-line ()
  (interactive)
  (beginning-of-line)
  (delete-char 3)
  (end-of-line)
  (delete-backward-char 3)
  (forward-line))

; get these working - take an arbitrary char or better a function
; like c-comment-line
(defun quote-region2 (x y str)
  "Add leading characters to the region"
  (interactive "r")
  (setq lines
        (+ (count-lines x y)
           (if (= (current-column) 0) 1 0)))
  (goto-char x)
  (beginning-of-line)
  (while (> lines 0)
    (progn
      (insert str)
      (next-line 1)
      (beginning-of-line)
      (setq lines (- lines 1))
      )))

(defun un-quote-region2 (x y str)
  "Remove the leading characters from the region"
  (interactive "r")
  (setq lines
        (+ (count-lines x y)
           (if (= (current-column) 0) 1 0)))
  (goto-char x)
  (beginning-of-line)
  (while (> lines 0)
    (progn
      (if (looking-at str)
          (delete-char 1))
      (next-line 1)
      (setq lines (- lines 1))
      )))


