(define-derived-mode myracket-mode nil "My Racket"
  ""
  (set (make-local-variable 'font-lock-defaults) '(myracket-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'myracket-indent-line))

;; (setq lexical-binding t)

(defconst myracket-font-lock-keywords
  (list "define" "car" "cdr" "cons" "list" "let" "if" "cond" "else"
	"apply" "values"))

(defun first-linep ()
  (= 1 (count-lines 1 (point))))

(defun myracket-indent-line ()
  (interactive)
  (if (first-linep)
      (progn
	(indent-line-to 0))
    (progn
      (indent-line-to
       (column-at-pos (point))))))

(defun column-at-pos (point)
  (save-excursion
    (goto-char point)
    (current-column)))

(defun beginning-of-form (pos)
  (defun bof-helper (matched-right pos)
    (if (= (char-after pos) ?\()
	(if matched-right
	    (bof-helper nil (1- pos))
	  pos)
      (bof-helper matched-right (1- pos))))
  (if (= (char-after pos) ?\))
      (bof-helper t pos)
    (bof-helper nil pos)))
