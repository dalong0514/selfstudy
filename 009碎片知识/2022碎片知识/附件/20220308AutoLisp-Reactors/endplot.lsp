(prompt " \nLoad Only....Do NOT Run...")

(vl-load-com)

;*******************************************************
(vlr-command-reactor 

	"Backup After Plot" '((:vlr-commandEnded . endPlot)))

;*******************************************************
(defun endPlot (calling-reactor endcommandInfo / 

		   thecommandend drgName newname)

(setq thecommandend (nth 0 endcommandInfo))

	(if (= thecommandend "PLOT")

	(progn

	(setq acadDocument (vla-get-activedocument
 			   (vlax-get-acad-object)))

	(setq drgName (vla-get-name acadDocument))

	(setq newname (strcat "c:\\backup\\" drgName))

	(vla-save acadDocument)

	(vla-saveas acadDocument newname)

	);progn

	);if
  
(princ)
  
);defun

;*********************************************************

(princ)