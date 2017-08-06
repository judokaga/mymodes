(define-derived-mode myracket-mode nil "My Racket"
  ""
  (set (make-local-variable 'font-lock-defaults) '(myracket-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'myracket-indent-line)
  (set (make-local-variable 'indent-var) 2))

(defconst myracket-font-lock-keywords
  (list "define" "car" "cdr" "cons" "list" "let" "if" "cond" "else"
	"apply" "values"))

(defun myracket-indent-line ()
  (interactive)
  ; (beginning-of-line)
  (indent-line-to indent-var)
  (setq indent-var (+ 2 indent-var)))
