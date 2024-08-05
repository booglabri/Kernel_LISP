; D(e,X) -
;          Will compute the symbolic derivative of expression e with respect
; to variable X. We take the expression in standard lisp prefix form and will
; use the following rules of differentiation.
;
;         D(x)    = 1
;         D(a)    = 0
;         D(ln u) = D(u)/u 
;         D(u+v)  = D(u)+D(v)
;         D(u-v)  = D(u)-D(v)
;         D(u*v)  = D(u)*v + u*D(v)
;         D(u/v)  = D(u)*v + (u*D(v))/v^2
;         D(v^u)  = (v^u)*(u*D(v)/v + D(u)*ln(v))
;
(fun D (e X)
     (cond (verbose (princ "----- ")(princ e)))
     (cond ((equal e X)
	    (cond (verbose (princ " = 1")(terpri)))
	    1)
	   ((atom? e)
	    (cond (verbose (princ " = 0")(terpri)))
	    0)
	   (t (let [(u (cadr e)) (v (caddr e))]
		(cond (verbose (princ " | u = ")(princ u)(princ " | v = ")(princ v)(terpri)))
		(cond ((equal (car e) 'ln) `(/ ,(D u X) ,u))
		      ((equal (car e) '+)  `(+ ,(D u X) ,(D v X)))
		      ((equal (car e) '-)  `(- ,(D u X) ,(D v X)))
		      ((equal (car e) '*)  `(+  (* ,(D u X) ,v) (* ,(D v X) ,u)))
		      ((equal (car e) '/)  `(-  (/ ,(D u X) ,v)
						(/ (* ,u ,(D v X)) (^ ,v 2))))
		      ((equal (car e) '^)  `(* ,e (+ (/ (* ,v ,(D u X)) ,u))
					       (* ,(D v X) (ln ,u))))
		      (t (princ "ERROR") (exit)))))))

;
; Fold(e) -
;         Will traverse the expression 'e' and construct a new expression.
; It checks for things like (* 1 <exp>), (* <exp> 0), (^ <exp> 1), (+ <exp> 0)
; and replaces them with the appropriate things <exp>,0,<exp> and <exp>
; respectively. These simple algabraic modifications greatly reduce the output
; complexity but do not do a complete job by any means. We use the macros
; ?times, ?plus and ?power to do the dirty work for us. We set displace-macros
; to t to cause PC-LISP to substitute the code into the body of Fold thus
; making it much faster.
;

(fun ?times lam (v e)
     (and (equal (car e) '*) (member v e)))

(fun ?divide lam (v e)
     (and (equal (car e) '/) (member v e)))

(fun ?plus lam (v e)
     (and (equal (car e) '+) (member v e)))

(fun ?minus lam (v e)
     (and (equal (car e) '-) (member v e)))

(fun ?power lam (v e)
     (and (equal (car e) '^) (equal (caddr e) v)))

(fun Fold (e)
;     (princ "----- ")(princ e)(terpri)
     (cond ((atom? e) e)
	   (t (setq e (cons (Fold (car e)) (Fold (cdr e))))
	      (princ ">>> ")(princ e)(terpri)
	      (cond ((?times 0 e) 0)
		    ((?times 1 e) (cond ((equal (cadr e) 1) (caddr e))
					(t (cadr e))))
		    ((?divide 0 e) (cond ((equal (cadr e) 0) (cadr e))
					 (t (princ "Error: Divide by 0")(terpri))))
		    ((?power 1 e) (cadr e))
		    ((?plus  0 e) (cond ((equal (cadr e) 0) (caddr e))
					(t (cadr e))))
		    ((?minus  0 e) (cond ((equal (cadr e) 0) (cons '- (caddr e)))
					 ((equal (caddr e) 0) 
					 (t (cadr e))) ))
		    (t e)))))

(fun Differentiate(e x)
     (Fold (D e x)))
;     (D e x))

; ----------------- end if differentiate module ------------------

;(setq verbose nil)
(setq verbose t)

(princ "                      SYMBOLIC DIFFERENTIATION")(terpri)
(terpri)
(princ "Following is the Input Expression Y")(terpri)
(setq y '(* x (ln (+ x a))))
(pp y)(terpri)

(terpri)
(princ "Computing 1st Derivitive of Y with respect to x, Y'")(terpri)
(setq Dy (Differentiate y 'x))
(pp Dy)(terpri)

(terpri)
(princ "Computing 2nd Derivitive of Y with respect to x, Y''")(terpri)
(setq DDy (Differentiate Dy 'x))
(pp DDy)(terpri)

(terpri)
(princ "Computing 3rd Derivitive of Y with respect to x, Y'''")(terpri)
(setq DDDy (Differentiate DDy 'x))
(pp DDDy)(terpri)

;(terpri)
;(princ "Computing 4th Derivitive of Y with respect to x, Y''''")(terpri)
;(setq DDDDy (Differentiate DDDy 'x))
;(pp DDDDy)(terpri)

;(terpri)
;(princ "Computing 5th Derivitive of Y with respect to x, Y'''''")(terpri)
;(setq DDDDDy (Differentiate DDDDy 'x))
;(pp DDDDDy)(terpri)

(terpri)
(princ "Done (finally)")(terpri)

eof
