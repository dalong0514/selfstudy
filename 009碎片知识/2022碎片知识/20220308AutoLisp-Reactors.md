## AutoLisp-Reactors

by Kenny Ramage

[Reactors - Part 1 | AfraLISP](https://www.afralisp.net/visual-lisp/tutorials/reactors-part-1.php)

[Reactors - Part 2 | AfraLISP](https://www.afralisp.net/visual-lisp/tutorials/reactors-part-2.php)

[Reactors - Part 3 | AfraLISP](https://www.afralisp.net/visual-lisp/tutorials/reactors-part-3.php)

3『

参考资料：

[AutoCAD 2021 Developer and ObjectARX 帮助 | Reactor Functions Reference (AutoLISP/ActiveX) | Autodesk](https://help.autodesk.com/view/OARX/2021/CHS/?guid=GUID-B83B512E-CEF6-43C5-9099-398999E254AF)

[Using Object Reactors - AutoCAD AutoLISP & Visual LISP Documentation](https://documentation.help/AutoCAD-ALISP-VLISP/WS73099cc142f4875516d84be10ebc87a53f-7c28.htm)

[AutoLISP Developer's Guide: Understanding Reactor Types and Events](http://docs.autodesk.com/ACD/2011/ENU/filesALG/WS73099cc142f4875516d84be10ebc87a53f-7c33.htm)

』

### Part 1

#### 1.1 What are Reactors?

"What the heck is a reactor?" I asked myself exactly the same question when I first came across the phrase. "It must be another name for an Event", I said to myself. I was wrong, again!

A reactor is an Object you attach to AutoCAD Objects to have AutoCAD notify your application when a particular event, or events occur. (Remember, that an AutoCAD Object can be an Object within your drawing, the drawing itself, or even AutoCAD, the application - just thought I'd tell you). This is the general procedure :

1 An Event occurs in your drawing.

2 AutoCAD notifies the Reaction associated with that Event.

3 The reaction then notifies your application, known as a callback function, passing to it certain information applicable to the Event in the form of arguments.

4 Your application then does it's thing using the information passed to it from the Reactor.

So, in simple terms, a Reactor is the "link" between the Event and the callback function.

1『这里对 Reactor 的定义真精辟：反应器是事件与回调函数的连接器。正巧前几天开发自动标注时知道了「关联标注」的概念，关联标注的自动更新就是靠的反应器来连接标注和被标注图形的。（2022-03-08）』

Before we get into looking at the different types of AutoCAD Reactors and Events, let's have a look at a fairly straightforward Reactor to give you an idea of how simple they can be. Before you start though, you must ask yourself two questions :

1 Before, after or during what Event do you want your function to occur?

2 What do you want your function to do?

For this example, I will answer both these questions on your behalf.

1 I want my function to run every time a drawing Save is completed.

2 I want the function to tell me what the name of the drawing is, and how big the drawing is.

O.K. Looking at the Reactor listings, (Refer to Visual Lisp Reference), under the Editor Reactor Types, I find a reactor called vl-dwg-reactor. This reactor, I am led to believe, responds to the "Save Complete" event of a drawing, and returns callback data of a string containing the actual file name used for the save. Hey, this is just what we are looking for. Let's order two to take-away…

1-3『

[AutoLISP Developer's Guide: Understanding Reactor Types and Events](http://docs.autodesk.com/ACD/2011/ENU/filesALG/WS73099cc142f4875516d84be10ebc87a53f-7c33.htm)

上面的官方链接里列出了所有的反应器类型，而且从这里知道了，直接用命令是可以查的。

```
(defun c:foo ()
  (vlr-types)
)
```

(:VLR-Linker-Reactor :VLR-Editor-Reactor :VLR-AcDb-Reactor :VLR-DocManager-Reactor :VLR-Command-Reactor :VLR-Lisp-Reactor :VLR-DXF-Reactor :VLR-DWG-Reactor :VLR-Insert-Reactor :VLR-Wblock-Reactor :VLR-SysVar-Reactor :VLR-DeepClone-Reactor :VLR-XREF-Reactor :VLR-Undo-Reactor :VLR-Window-Reactor :VLR-Toolbar-Reactor :VLR-Mouse-Reactor :VLR-Miscellaneous-Reactor :VLR-Object-Reactor)

』

Enough of this childish wit! Let's have a look at the reactor definition and syntax first :

vlr-dwg-reactor - Constructs an editor reactor object that notifies of a drawing event.

```
(vlr-dwg-reactor data callbacks)
```

Arguments :

data : AutoLisp data to be associated with the reactor object, or nil, if no data

callbacks : A list of pairs of the following form :

```
(event-name . callback_function)
```

where event-name is one of the symbols listed in the "DWG reactor events" table, and `callback_function` is a symbol representing the function to be called when the event fires. Each callback function will accept two arguments :

`reactor_object` - the VLR object that called the callback function,

list - a list of extra data elements associated with the particular event.

#### 1.2 How does it work?

I don't know about you? But, whew…! Right, let's try and put this into simple English. Let's look at the syntax again :

```
(vlr-dwg-reactor data callbacks)
```

The first part vlr-dwg-reactor is easy. This is the name of the reactor type. This name will be sent to your call back function.

The first argument data, is User Application Data. We usually set this to a reactor name of our choosing. This way we can distinguish between reactors if an Objects has multiple reactors attached.

The second argument callbacks is a straightforward list of dotted pairs.

1 The first element of the list is the name of the reactor "event" that will trigger the reactor and then call your callback function.

2 The second element, is the name of your Callback function.

This is what our reactor function will look like :

```
(vlr-dwg-reactor "Save Complete"  '((:vlr-savecomplete . savedrawinginfo)))
```

Or, graphically :

![](./res/2022001.png)

Let's have a look at our Reactor Function in action. Copy and Paste this coding into the Visual LISP Editor and save it as SaveDrawingInfo.lsp. Next Load the application, but do not run it.

```
;;----------------------------------------------------------------------------------
; setup and intilise the reactor
(vlr-dwg-reactor "Save Complete" '((:vlr-savecomplete . savedrawinginfo)))

;;----------------------------------------------------------------------------------
(defun saveDrawingInfo (calling-reactor commandInfo / reactInfo reactType reactData reactCall reactEvent reactCallback dwgname filesize)
  ; get the reactor Object
  (setq reactInfo calling-reactor
    ; get the reactor Type
    reactType (vl-symbol-name (vlr-type reactInfo))
    ; get the Application Data
    reactData (vlr-data reactInfo)
    ; get the Callback list
    reactCall (car (vlr-reactions reactInfo))
    ; extract the Event Reactor
    reactEvent (vl-symbol-name (car reactCall))
    ; extract the Callback Function
    reactCallback (vl-symbol-name (cdr reactCall))
  )
  ; get the Drawing Name
  (setq dwgname (cadr commandInfo)
    ; extract the filesize
    filesize (vl-file-size dwgname)
  )
  ;display the Drawing Name and Size
  (alert (strcat "The file size of " dwgname " is " (itoa filesize) " bytes."))
  ;Display the Reactor Information
  (alert
    (strcat
      "A " "\"" reactType "\"" " named " "\"" reactData "\"" "\n"
      "was triggered by a " "\"" reactEvent "\"" " event call." "\n"
      "Callback Data was passed to the" "\n"
      "\"" reactCallback "\"" " call back function."))
  (princ)
)
;;----------------------------------------------------------------------------------
```

1『

```
(vlr-dwg-reactor "Save Complete" '((:vlr-savecomplete . savedrawinginfo)))
```

放在 lisp 文件的最外层，确保该程序一直在跑。

意外之喜：自动保存也会触发 Reactor。解决了之前想要收集的工时数据问题。（2022-03-08）

借鉴上面的代码，自己写了一个 CAD 里任意新增一个实体对象即可触发 Reactor 的功能：

```
;;----------------------------------------------------------------------------------
(vlr-acdb-reactor "Object Appended" '((:vlr-objectAppended . objectAppendedinfo)))

(defun ObjectAppendedInfo (calling-reactor commandInfo / reactInfo reactType reactData reactCall reactEvent reactCallback dwgname filesize)
  ; get the reactor Object
  (setq reactInfo calling-reactor
    ; get the reactor Type
    reactType (vl-symbol-name (vlr-type reactInfo))
    ; get the Application Data
    reactData (vlr-data reactInfo)
    ; get the Callback list
    reactCall (car (vlr-reactions reactInfo))
    ; extract the Event Reactor
    reactEvent (vl-symbol-name (car reactCall))
    ; extract the Callback Function
    reactCallback (vl-symbol-name (cdr reactCall))
  )
  ;display the Drawing Name and Size
  (princ "\write data to file\n")
  (princ (car commandInfo))
  (princ "\n")
  (princ (cadr commandInfo))
  (princ)
)
;;----------------------------------------------------------------------------------
```

』

Once the application is loaded, return to AutoCAD and save the drawing. This dialog will appear :

Followed by this dialog :

Do you notice the calling-reactor and commandInfo argument declarations? This information, the Reactor Object Name and the Event Parameter Information is passed to our Callback Function from the Reactor. Clever hey?

In Part 2, we'll have a look at some Drawing Reactors.

### Part 2

#### 2.1 Drawing Reactors

Another Editor Type of reactor is the VLR-Command-Reactor. This reactor notifies us of a Command Event. In this instance we will make use of the vlr-commandEnded reactor event which returns a event parameter list containing a string identifying the command that has been cancelled. Every time a drawing is plotted, our call back function will first, save the drawing, and secondly save the drawing to a backup directory, namely C:/Backup. Let's have a look at the coding :

```
;;----------------------------------------------------------------------------------

(prompt " \nLoad Only....Do NOT Run...")
(vl-load-com)

;;----------------------------------------------------------------------------------
(vlr-command-reactor 
 "Backup After Plot" '((:vlr-commandEnded . endPlot)))

;;----------------------------------------------------------------------------------
(defun endPlot (calling-reactor endcommandInfo / thecommandend dwgName newname)
  (setq thecommandend (nth 0 endcommandInfo))
    (if (= thecommandend "PLOT")
      (progn
        (setq acadDocument (vla-get-activedocument (vlax-get-acad-object)))
        (setq dwgName (vla-get-name acadDocument))
        (setq newname (strcat "c:\\backup\\" dwgName))
        (vla-save acadDocument)
        (vla-saveas acadDocument newname)
      )
    )
  (princ)
)
```

A word of warning! Did you notice how I used ActiveX statements and functions to "Save" and "SaveAs". You cannot use interactive functions from within a reactor as AutoCAD may still be processing a command at the time the event is triggered. Therefore, avoid the use of input-acquisition methods such as getPoint, ensel, and getkword, as well as "selection set" operations and the command function.

Here's another interesting command event reactor :

When a user adds Text or Hatch to the drawing, the layer will automatically change to Layer "4" or Layer "6" respectively. When the command is completed, or cancelled, the user is returned to the original Layer he was on before he started the command. Save the file as LayMan.lsp, BUT please remember, that as this routine contains reactors, you must only Load it and NOT Run it. If you want to use this routine on a permanent basis, you'll have to ensure that it is loaded at startup. There is also no checking to ensure that the layers exist, are frozen, switched off, etc. and no other form of error checking. I've got to leave something for you to do!

```
(prompt " \nLoad Only....Do NOT Run...")
(vl-load-com)

;;----------------------------------------------------------------------------------
(vlr-command-reactor 
 nil '((:vlr-commandWillStart . startCommand)))
(vlr-command-reactor 
 nil '((:vlr-commandEnded . endCommand)))
(vlr-command-reactor 
 nil '((:vlr-commandCancelled . cancelCommand)))

;;----------------------------------------------------------------------------------
(defun startCommand (calling-reactor startcommandInfo / thecommandstart)
  (setq *OldLayer* (getvar "CLAYER"))
  (setq thecommandstart (nth 0 startcommandInfo))
  (cond
    ((= thecommandstart "TEXT") (setvar "CLAYER" "4"))
    ((= thecommandstart "MTEXT") (setvar "CLAYER" "4"))
    ((= thecommandstart "DTEXT") (setvar "CLAYER" "4"))
    ((= thecommandstart "HATCH") (setvar "CLAYER" "6"))
    ((= thecommandstart "BHATCH") (setvar "CLAYER" "6"))
  )
  (princ)
);defun
;;----------------------------------------------------------------------------------

(defun endCommand (calling-reactor endcommandInfo / thecommandend)
  (setq thecommandend (nth 0 endcommandInfo))
  (cond
    ((= thecommandend "TEXT") (setvar "CLAYER" *OldLayer*))
    ((= thecommandend "MTEXT") (setvar "CLAYER" *OldLayer*))
    ((= thecommandend "DTEXT") (setvar "CLAYER" *OldLayer*))
    ((= thecommandend "HATCH") (setvar "CLAYER" *OldLayer*))
    ((= thecommandend "BHATCH") (setvar "CLAYER" *OldLayer*))
  )
  (princ)
)

;;----------------------------------------------------------------------------------
(defun cancelCommand (calling-reactor cancelcommandInfo / thecommandcancel)
  (setq thecommandcancel (nth 0 cancelcommandInfo))
  (cond
    ((= thecommandcancel "TEXT") (setvar "CLAYER" *OldLayer*))
    ((= thecommandcancel "MTEXT") (setvar "CLAYER" *OldLayer*))
    ((= thecommandcancel "DTEXT") (setvar "CLAYER" *OldLayer*))
    ((= thecommandcancel "HATCH") (setvar "CLAYER" *OldLayer*))
    ((= thecommandcancel "BHATCH") (setvar "CLAYER" *OldLayer*))
  )
  (princ)
)
```

Did you notice that this application used three command reactors with three different command events. We could have incorporated all three reactor events and call back functions under one command reactor type, but I prefer to leave them separate for clarity and ease of debugging.

OK that's enough of command reactors. Let's have a look at Object Reactors. See you in Part 3.

### Part 3

#### 3.1 Object Reactors

Object Reactors, or VLR-Object-Reactor, fall under general reactor types. They are almost identical in functionality to Drawing and Command reactors except for a couple of things! They need to include a reference to the Object that will be reacted upon, (Crikey, that sounds terrible!) and the reference to the Object needs to be created before the reactor is called. Let's have a look at the syntax of an Object reactor :

```
(vlr-object-reactor owners data callback)
```

The data and callback arguments, we are familiar with. But what is the owners argument? This is an AutoLISP list of Visual Lisp Objects identifying the drawing Objects to be watched. In other words, a reference to the Object that contains the reactor.

The reactor event we are going to use is the :vlr-modified event, and our Callback function will be named print-length. Have a look at the coding for our reactor :

```
(vlr-object-reactor (list myLine) "Line Reactor"
  '((:vlr-modified . print-length)))
```

As I mentioned earlier though, we need to have a reference to the Object before we can call this statement. Consider the following :

```
(vl-load-com)

;;---------------------------------------------------------------------
(defun line-draw (/ acadDocument mspace apt pt myLine lineReactor)
  (setq acadDocument (vla-get-activedocument (vlax-get-acad-object)))
  (setq mspace (vla-get-modelspace acadDocument))
  (setq apt (getpoint "Specify First Point: "))
  (setq pt (getpoint "Specify next point: " apt))
  (setq myLine (vla-addline mspace (vlax-3d-point apt)(vlax-3d-point pt)))
  (setq lineReactor (vlr-object-reactor (list myLine)
  "Line Reactor" '((:vlr-modified . print-length))))
  (princ)
)
```

We started off by drawing a line. As the line was created from scratch, and created using Visual LISP functions, we already have a reference to the line Object (myLine). We can now safely run our reactor function and attach it to our Line. "But where is the Callback function?"

1『感觉这里的思想跟关联标注类似，生成的标注以及原图形里都增加了 Reactor 对象。（2022-03-08）』

Hah, I was waiting for that. We've made the Callback function a separate function for one main reason. If we didn't, every time we ran the application it would prompt us to draw a new line. So, what we have to do now, is link the reactor function to our Callback function so that when our line is modified, only the Callback function is put into motion. The reactor sends three arguments to the Callback function, the notifier-object (our line), the reactor-object (:vlr-modified), and the event parameter-list which in this case is nil.

Here's the coding for the Callback function :

```
(defun print-length (notifier-object reactor-object parameter-list)
  (cond
    ((vlax-property-available-p notifier-object "Length")
    (alert (strcat "The length is now "
                          (rtos (vla-get-length notifier-object)))))
  )
  (princ)
)
```

Copy all of this coding into one file and save it as Line-Draw.lsp. Now load Line-Draw.lsp and then run the line-draw function. Draw a single line when prompted. Now stretch the line so that it's length changes. A dialog will appear displaying the new length of the line :

AutoCAD Message

In essence, this is what happened :

1 We loaded Line-Draw.lsp and all functions contained within were placed into memory.

2 We ran the line-draw function which prompted us to draw a line. The reactor was then loaded and linked to both the line Object and the Callback function.

3 As the Callback function print-length was also loaded into memory, every time we modify the line Object, the Callback function is processed and the length of the line is displayed.

Did you notice how we checked that our Object had a Length Property before continuing? Good idea, as this validation can save lot's of problems.

"But what happens when I close my drawing? Will I lose all my reactors?" Good questions. Reactors can be transient or persistent. Transient reactors are lost when the drawing closes and this is the default reactor mode. Persistent reactors are saved with the drawing and exist when the drawing is next open.

1『关键信息来了，Reactor 分为暂时性的和永久性的，类似于 entityname 和 entityhandle，而且可以用函数 vlr-pers 把临时性的改为永久性的，用函数 vlr-pers-release 把永久性的改为临时性的。（2022-03-05）』

You can use the vlr-pers function to make a reaction persistent. To remove a persistence from a reactor and make it transient, use the vlr-pers-release function. To determine whether a reactor is persistent or transient, use the vlr-pers-p function. Each function takes the reactor Object as it's only argument :

```
_$(vlr-pers lineReactor)
#<VLR-Object-Reactor>
```

If successful vlr-pers returns the specified reactor Object.

Note : A reactor is only a link between an event and a Callback function. The Callback function is not part of the reactor, and is normally not part of the drawing. The reactors saved in the drawing are only usable if their associated Callback functions are loaded in AutoCAD. In other words, if we made our reactor lineReactor persistent, we would have to ensure that the Callback function print-length was loaded every time the drawing containing our lines with reactors was opened.

If you would like the source coding for all the examples in this tutorial, then you can download them from here.

2『已下载源码「20220308AutoLisp-Reactors」作为该碎片文章的附件。（2022-03-08）』