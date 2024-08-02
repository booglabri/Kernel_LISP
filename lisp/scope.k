(setq x 10)

(fun f ()
  x)

(fun g ()
  (let [(x 20)]
  (f)))

(cond [(= (g) 10) (print "lexical")]
      [(= (g) 20) (print "dynamic")])

eof
