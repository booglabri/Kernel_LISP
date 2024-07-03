(fun increment ulam (vars)
  (prog [last]
     loop
        (cond [(null? vars) (return last)])
        (setq last (set (car vars)              ;; increment variable
                        (++ (eval (car vars)))))
        (setq vars (cdr vars))                  ;; next variable
        (go loop)))

(setq x 10 y 20)
x
y
(increment x y)
x
y
