# 202102. AutoLISP-Basics

[AutoLISP Basics - YouTube](https://www.youtube.com/watch?v=SkHnD9xQTPE)

it makes up its own unique syntax  and has things like curly braces and and things whereas for Lisp they said well let's just use mathematics.

 ```
(setq Radius (+ 2 2 9 7))
 ```
 
 Statement set cute set Q stands for set  the quoted variable so with that and so it it's a little easier to just memorize how to set Q rather than what it needs or you know but int this case I'm setting a variable and the variable is radius I want to set the variable I'm inventing a very radius so I want from this point futher I want auto lisp to treat the radius as what waht we can see it's the contents these parentheses here.
 
## 01. Data Type
 
只有 4 种数据类型。

Boolean: T / nil.

Integer

Real

String

## 02. List

1 Basic

2 3D Point

3 Lists within lists (within lists (within lists))

4 Entity access

1『

CAD 里任意实体对象的数据集，视频里列举了 line 的数据集，这里再一次加深了 dxf code 67 的意义：实体对象是在 Model 空间还是在 Paper 空间。0 表示是 model space。

调用 command 命令竟然还能拆解步骤的，涨见识了，视频里的例子（对其进行了深化）：

```
(defun c:foo (/ insPt1 insPt2) 
  (setq insPt1 (getpoint))
  (command "line" insPt1)
  (setq insPt2 (polar insPt1 (/ PI 4) 1000))
  (command insPt2 "")
)
```

意外的收获了函数 polar，给定初始坐标点、角度、距离，获取第二个坐标点，这个函数应用的场景超级多。

然后突然想到之前帮给排水做的一个功能是转轴侧图，封装了一个函数：

```
; 2021-02-02
; refactored at 2021-06-25
(defun TranforCoordinateToPolarUtils (insPt /)
  (polar (list (car insPt) 0 0) (/ PI 4) (cadr insPt))
)
```

』

## 03. Function Basic

(defun c: Myfunction () (xx: Do_Stuff))

(if This (Dothat) (Otherwise_Somethingelse 1.0))   

(while  (Still Clicking) (Dofancythings))   

(xx: Makecircle Point1 Radius Layer)

1『看函数的文档说明：数学公式函数、get...类函数（比如 getpoint）、实体对象数据集相关函数（比如 entget）、提示类函数（比如 alert/princ）、List 相关函数。』

## 04. Design Philosophy

1『作者视频中将软件开发类比于「战斗机」的制造，提到了维护的问题。』

## 05. Code Writing Do's and Do Not Do's

## 06. Development Environment

## 07. Example - change the color of entity layer

1、CAD 里直接选择颜色的命令。

```
(acad_colordlg 0)
```

可以在 autolisp 实现让用户自己在面板里选颜色，很赞啊。

```
(setq newcolor (acad_colordlg 0))
```

上面语句返回的值用户自己选择的 color 数值。

2、可以把刷新的命令（re）嵌入到 autolisp 命令里，正对于某些场景。

```
(commmand "REGEN")
```