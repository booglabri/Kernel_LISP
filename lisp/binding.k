(fun if mlam (expr)
     `(cond [,(car expr) ,(cadr expr)]		;; then
     	    [t ,(caddr expr)]))			;; else

(fun len (obj)
        (if (list? obj) (length obj) 0))

(setq x 6)
(len x)
(binding 'len)

(setq x '(a b c))
(len x)
(binding 'len)
