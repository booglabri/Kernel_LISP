(fun mean vlam (n)
     (prog [(sum 0) (count 0)]
           (and (= n 0) (return 0))                ;; no numbers
        loop
           (and (>= count n) (return (/ sum count)))
           (setq count (++ count)                  ;; increment count
                 sum (+ sum (arg count)))         ;; add next number
           (go loop)))

(mean 10 20.5 3 90)
(mean 11)

eof
