;; Demonstration of dynamic scoping

;; This is a "global" variable
(setq myglobal "this is my global variable")

;; Another global variable
(setq yourglobal "this is your global variable")

;; a function which prints the symbols
(fun dosomething (mine yours)
  (princ " * Mine is  - ")
  (princ mine)
  (terpri)
  (princ " * Yours is - ")
  (princ yours)
  (terpri))

;; override the symbols
(fun nolocals ()
  (setq mine "I have set mine to a new value")
  (setq yours "I have set yours to a new value")
  (dosomething mine yours))

(fun main ()
  ;; define two symbols
  (setq mine myglobal)
  (setq yours yourglobal)
  
  ;; print them
  (princ "calling dosomething")
  (terpri)
  (dosomething mine yours)
  (princ "calling nolocals")
  (terpri)
  (nolocals)
  (princ "calling dosomething again")
  (terpri)
  (dosomething mine yours))

(main)

eof
