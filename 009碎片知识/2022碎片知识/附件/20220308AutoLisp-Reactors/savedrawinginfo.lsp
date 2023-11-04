(vl-load-com)

;**************************************************************

;setup and intilise the reactor
(vlr-dwg-reactor "Save Complete" '((:vlr-savecomplete . savedrawinginfo)))

;**************************************************************

(defun saveDrawingInfo (calling-reactor commandInfo / dwgname filesize)

;get the reactor Object
(setq reactInfo calling-reactor

      ;get the reactor Type
      reactType (vl-symbol-name (vlr-type reactInfo))

      ;gt the Application Data
      reactData (vlr-data reactInfo)

      ;get the Callbacl list
      reactCall (car (vlr-reactions reactInfo))

      ;extract the Event Reactor
      reactEvent (vl-symbol-name (car reactCall))

      ;extract the Callback Function
      reactCallback (vl-symbol-name (cdr reactCall))

);setq

;get the Drawing Name
(setq dwgname (cadr commandInfo)

     ;extract the filesize      
     filesize (vl-file-size dwgname)
      
);setq

;display the Drawing Name and Size
(alert (strcat "The file size of " dwgname " is "
	       
(itoa filesize) " bytes."))

;Display the Reactor Information
(alert

  (strcat
    "A " "\"" reactType "\"" " named " "\"" reactData "\"" "\n"
    "was triggered by a " "\"" reactEvent "\"" " event call." "\n"
    "Callback Data was passed to the" "\n"
    "\"" reactCallback "\"" " call back function."))

(princ)

);defun

;********************************************************

(princ)

;********************************************************