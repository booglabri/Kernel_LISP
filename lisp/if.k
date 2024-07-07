(fun if mlam (expr)
     `(cond [,(car expr) ,(cadr expr)]          ;; then
     	    [t ,(caddr expr)]))			;; else

(setq x 0)
(if (= x 0) (print "x is zero")
    (print "x is nonzero"))

(setq x 1)
(if (= x 0) (print "x is zero")
    (print "x is nonzero"))

(setq x '(a b c))
(if (list? x) (length x) 0)

(setq x 1)
(if (list? x) (length x) 0)

eof
