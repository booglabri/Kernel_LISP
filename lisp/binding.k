(fun if mlam (expr)
     `(cond [,(car expr) ,(cadr expr)]		;; then
     	    [t ,(caddr expr)]))			;; else

(fun len (obj)
        (if (list? obj) (length obj)
         else 0))

(binding 'len)