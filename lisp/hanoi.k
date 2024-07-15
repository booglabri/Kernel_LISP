(fun hanoi(n)
  ( transfer 'A 'B 'C n ))

(fun print-move ( from to )
  (princ "Move Disk From ")
  (princ from)
  (princ " To ")
  (princ to)
  (terpri)
)

(fun transfer ( from to via n )
  (cond ((equal n 1) (print-move from to ))
	(t (transfer from via to (-- n))
	   (print-move from to)
	   (transfer via to from (-- n)))))     

(hanoi 3)

eof
