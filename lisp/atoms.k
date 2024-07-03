(fun atoms (expr)
     (cond [(null? expr) 0]                  ;; empty expression
           [(atom? expr) 1]                  ;; exactly one atom
           [t (+ (atoms (car expr)) (atoms (cdr expr)))]))

(atoms '(a b (c d) e))
