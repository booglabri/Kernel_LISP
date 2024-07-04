(fun fib (n)
  (cond ((< n 2) n)
        (t (+ (fib (- n 1)) (fib (- n 2))))))

(fun fibtest (i count)
  (cond ((= count 0) nil)
  	(t (fib i) (fibtest i (-- count)))))

(fun fibtest-iter (i count)
  (do count (fib i)))

(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
(fib 9)
(fib 10)

(fibtest 5 10)
(fibtest-iter 5 10)

eof
