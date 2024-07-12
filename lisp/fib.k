(fun fib (n)
  (cond ((< n 2) n)
        (t (+ (fib (- n 1)) (fib (- n 2))))))

(fun fibtest (count)
  (cond ((= count 0) nil)
  	(t (print (fib count)) (terpri) (fibtest (-- count)))))

(fibtest 20)

eof
