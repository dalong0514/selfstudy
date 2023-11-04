## Understanding how dimensions are associated with objects

By Ellen Finkelstein

This is a guest post by Sanjay Kulkarni, an AutoCAD programmer.

Learning AutoLISP (or any other programming language) doesn't compel you to become a programmer. You can still use it to better understand the internal working of AutoCAD and enhance your interactive working skill. This can also give you an edge over others.

Recently I received a client's drawing that was in AutoCAD 2004. Even when I saved it in AutoCAD 2010, the dimension would not adjust when I changed the length of a line. Only after I recreated the dimension was I able to use this capability. The reason, I found, was that the dimension in AutoCAD 2004 did not have the reactor (discussed below). Only when I created the dimension in AutoCAD 2010 was the reactor added.

Let's learn this lesson with an example.

Everybody knows that when you dimension an object, the dimension automatically updates when you modify the object. Have you ever wondered how the dimension knows it has to update? AutoLISP can help you find this out, if you don't already know.

Here's the example:

1 Draw a line.

2 Get its entity list by typing the following piece of AutoLISP code at the command prompt:

```
(entget (car (entsel)))
```

and selecting the line when prompted to select an object. You'll see something similar to the following at the command line in return.

```
((-1 . <Entity name: 7ee45a18>) (0 . “LINE”) (330 . <Entity name: 7ee43cf8>) (5 . “22B”) (100 . “AcDbEntity”) (67 . 0) (410 . “Model”) (8 . “0″) (100 . “AcDbLine”) (10 10.0 10.0 0.0) (11 160.0 160.0 0.0) (210 0.0 0.0 1.0))
```

This, you might have guessed, is the record that AutoCAD stores in its database.

3 Create a dimension (aligned for example) to show the length of the line and get the entity list of the line again. You should get a result similar to:

```
((-1 . <Entity name: 7ee45a18>) (0 . “LINE”) (5 . “22B”) (102 . “{ACAD_REACTORS”) (330 . <Entity name: 7ee45ae8>) (102 . “}”) (330 . <Entity name: 7ee43cf8>) (100 . “AcDbEntity”) (67 . 0) (410 . “Model”) (8 . “0″) (100 . “AcDbLine”) (10 10.0 10.0 0.0) (11 160.0 160.0 0.0) (210 0.0 0.0 1.0))
```

You might have noticed a new item starting with `(102 . “{ACAD_REACTORS”) (330 . <Entity name: 7ee45ae8>) (102 . “}”)` in the entity list of the line.

This is a reference to a reactor object that AutoCAD has created after adding the dimension. This reactor ensures that dimension gets modified when the object (line in this case) gets modified.

A reactor is a program that executes automatically when a particular action (change in the length of line in this case) is completed. A reactor executes only AFTER an editing action is completed. Hence, you see that the dimension is modified after the command that modifies the line completes and is not dynamically updated while length of line is being modified.

4 Next, entget the dimension using the same code but selecting the dimension this time. You will get something similar to:

```
((-1 . <Entity name: 7ee45a20>) (0 . “DIMENSION”) (5 . “22C”) (102 . “{ACAD_XDICTIONARY”) (360 . <Entity name: 7ee45a90>) (102 . “}”) (102 . “{ACAD_REACTORS”) (330 . <Entity name: 7ee45ae8>) (102 . “}”) (330 . <Entity name: 7ee43cf8>) (100 . “AcDbEntity”) (67 . 0) (410 . “Model”) (8 . “0″) (100 . “AcDbDimension”) (280 . 0) (2 . “*D6″) (10 173.511 146.489 0.0) (11 98.5106 71.4894 0.0) (12 0.0 0.0 0.0) (70 . 33) (1 . “”) (71 . 5) (72 . 1) (41 . 1.0) (42 . 212.132) (73 . 0) (74 . 0) (75 . 0) (52 . 0.0) (53 . 0.0) (54 . 0.0) (51 . 0.0) (210 0.0 0.0 1.0) (3 . “Standard”) (100 . “AcDbAlignedDimension”) (13 10.0 10.0 0.0) (14 160.0 160.0 0.0) (15 0.0 0.0 0.0) (16 0.0 0.0 0.0) (40 . 0.0) (50 . 0.0))
```

You will notice that exactly same reactor appears in the entity list of dimension. Thus, this reactor is the link between the line and dimension.

5 Add one more dimension to the line and get the entity list of line once more. You will see one more item with (330 . in the reactor reference. Thus each dimension associated with line is added as an item with 330 dxf code in the entity list of line.

6 Now delete one of the dimensions and get the new entity list of the line. You will find that one of the (330 . item has been removed.

7 After you delete all dimensions, the entity list of the line returns to its original form without any (102 . items.

A possibility to improve associativity

It is interesting to note that when object is deleted, dimension does not get deleted. Thus it lacks true associativity with the object.

You could create a situation whereby the dimension would be deleted when the object was deleted by adding a reference to one more reactor in the dimension's entity list that responds to deleting its associated object, but you would have to write code to do so.

Sanjay Kulkarni is an experienced CAD (AutoCAD, Inventor, SolidEdge, CATIA, NX) programmer and a member of the Autodesk Developer Network. He is fluent in AutoLISP, VBA, and VB.NET. He has written for AugiWORLD and Inside AutoCAD (a monthly magazine that has since gone out of publication). You can contact him at sanganakskha@gmail.com.

### 问答

MKshrestha

August 14, 2011 at 10:23 am

How to create a situation to delete dimension automatically when the object is deleted. This question has no answer mentioned in this topic. Please, Kindly send me about this?

Sanjay Kulkarni

August 18, 2011 at 2:55 pm

I just realized that the above study is little in-complete. Here are the missing details:

You can specify the required point to create linear dimensions in three ways:

1 Select an object (using Object option).

2 Use one / two snap points. Remember, these snap points are 'attached' to the object.

3 Use one / two points ‘in the air' – not attached to any object – in the blank area of the drawing.

You will find that in case of options 2 and 3 above, the entity-list of the dimensions does not contain any reference to the reactor. And it all seems logical since no object is attached to the dimension. Snap points are only snap points – not the object.

I mentioned this fact since it may help us clarify an issue in one of the future posts.

Alex

September 6, 2011 at 12:37 pm

I can not figure out how to dimension properly in paperspace. I have been using ACAD since release 11 and have never had this problem.

When I create a viewport and try to dimension it, when I put a dimension on an item inside the viewport (even thought the viewport is not active) it gives me the dimension of the model, but if i was to select a centerline that was drawn in paperspace, it gives me a different dimension.

There used to be a simple way to set up the dimensioning so that you can pick on any item, entity, area etc. of the paperspace drawing (even inside the Viewport) and have no problem.

In the previous releases this was no problem, but now I can't get it to work.

Is there some new way to dimension paperspace, or do i have to create 2 dimension styles, one for paperspace items and one for model space items?

Thanks

Ellen

September 6, 2011 at 2:12 pm

I'm not aware that the procedure for dimensioning in paper space has changed. I have a post on it at https://allaboutcad.com/tutorials-dimension-in-paper-space/. Also, have you tried using annotative dimensions? See https://allaboutcad.com/tutorial-automate-annotation/.

Chuck Lowell

March 21, 2012 at 9:05 pm

I have a dimensioning problem. This problem arises it seems when I do a lot of deleting, moving, inserting, etc in a good size file. After I do a bunch of dimensioning and start to move things around, one or two of the dimensions points will either stay at home (original spot before moving) while I move an object and the other dim point will stretch to the new location, or two dim lines will fly off into a different part of the drawing for no apparent reason.

I do select the complete item I am moving. I talked to a local AUTOCAD rep. but she never seen/heard about it before. I have a NFS (Not for Sale )version of 2007.

Can anyone help? Thank You

Ellen

March 21, 2012 at 10:43 pm

I've never heard of that. Try asking in the Autodesk discussion groups.

im

May 16, 2012 at 10:21 pm

how i can run a lisp thath automatic delete associative dimension after i delete they elements?