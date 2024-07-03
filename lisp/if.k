(fun if mlam (expr)
     `(cond [,(car expr) ,(cadr expr)]          ;; then
     	    [t ,(caddr expr)]))			;; else

(setq x 0)

(if (= x 0) (print "x is zero")
    (print "x is nonzero"))

(setq x '(a b c))
(if (list? x) (length x) else 0)
