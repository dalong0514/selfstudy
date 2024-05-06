(prompt " \nLoad Only....Do NOT Run...")
(vl-load-com)

;****************************************
(vlr-command-reactor 
	nil '((:vlr-commandWillStart . startCommand)))
(vlr-command-reactor 
	nil '((:vlr-commandEnded . endCommand)))
(vlr-command-reactor 
	nil '((:vlr-commandCancelled . cancelCommand)))
;******************************************************
(defun startCommand (calling-reactor startcommandInfo / 
		     thecommandstart)
(setq OldLayer (getvar "CLAYER"))
(setq thecommandstart (nth 0 startcommandInfo))
(cond
  ((= thecommandstart "TEXT") (setvar "CLAYER" "4"))
  ((= thecommandstart "MTEXT") (setvar "CLAYER" "4"))
  ((= thecommandstart "DTEXT") (setvar "CLAYER" "4"))

 ((= thecommandstart "HATCH") (setvar "CLAYER" "6"))
 ((= thecommandstart "BHATCH") (setvar "CLAYER" "6"))
);cond
(princ)
);defun
;****************************************************

(defun endCommand (calling-reactor endcommandInfo / 
		   thecommandend)
(setq thecommandend (nth 0 endcommandInfo))
(cond
  ((= thecommandend "TEXT") (setvar "CLAYER" OldLayer))
  ((= thecommandend "MTEXT") (setvar "CLAYER" OldLayer))
  ((= thecommandend "DTEXT") (setvar "CLAYER" OldLayer))
  ((= thecommandend "HATCH") (setvar "CLAYER" OldLayer))
  ((= thecommandend "BHATCH") (setvar "CLAYER" OldLayer))

);cond
 (princ)
);defun
;********************************************************
(defun cancelCommand (calling-reactor cancelcommandInfo / 
		      thecommandcancel)
(setq thecommandcancel (nth 0 cancelcommandInfo))
(cond
  ((= thecommandcancel "TEXT") (setvar "CLAYER" OldLayer))
  ((= thecommandcancel "MTEXT") (setvar "CLAYER" OldLayer))
  ((= thecommandcancel "DTEXT") (setvar "CLAYER" OldLayer))
  ((= thecommandcancel "HATCH") (setvar "CLAYER" OldLayer))
  ((= thecommandcancel "BHATCH") (setvar "CLAYER" OldLayer))
);cond
(princ)
);defun
;*********************************************************
(princ) 