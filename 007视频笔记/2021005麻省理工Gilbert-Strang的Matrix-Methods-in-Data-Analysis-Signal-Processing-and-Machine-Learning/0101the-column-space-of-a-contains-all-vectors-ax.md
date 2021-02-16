MITOCW | 1. The Column Space of A Contains All Vectors Ax

The following content is provided under a Creative Commons license. Your support will help MIT OpenCourseWare continue to offer high quality educational resources for free. To make a donation or to view additional materials from hundreds of MIT courses, visit MIT OpenCourseWare at ocw.mit.edu.

GILBERT STRANG:

Shall we start? Let me just say, this is a great adventure for me to be here all on my own, teaching a course that involves learning from data. So it's an exciting subject, and a lot of linear algebra goes into it. So it's a second course on linear algebra. Can I just-- so there is a Stellar site established, and that will be the basic thing that we use. This is a public site-math.mit.edu/learningfromdata.

So a book is coming pretty quickly as we speak, or after we speak, and that site has the table of contents of the book, which would give you an idea of what could be in the course. And I printed out a copy for everybody just of that one page. This is probably the final-- first and last handout-- maybe-- with a table of contents, which you'll see there.

And also, you'll see there the first two sections of the book, which is what I'll talk about today and a little bit into Friday. So that's linear algebra, of course, because the course begins with linear algebra-- actually, things that you would know from 18.06, but this is a way to say this is really important stuff. So that's what I'll do today. I'd like to start on the linear algebra today.

Here's a great fact about the course. So we taught it last year, several of us together, and we knew there wouldn't be a final exam, but we imagined there might be quizzes along the way. But then we couldn't think of anything to put on the quizzes. So we canceled those. But you do we learn a lot, nevertheless. And so I guess we base the grades on the homeworks. So the homeworks will be partly linear algebra questions and partly online, like recognizing handwriting, stitching images together, many other things. And I'll talk about those as we go. Good.

So that's the general picture. And I'll say more about it today. And I could answer any question about it. So we're getting videotaped. So if anybody's bashful, sit in the far back. But it'll be fun. You may know the videos for 18.06. So this is the next step, 18.065. It's pretty exciting for me. So any question, or shall I do a little math? Why not? And then I'll say a little more about the course, just so you have an idea of what's ahead. And it looks like this room is exactly the right size to me, so I'm pleased.

So what's the deal in linear algebra? Forgive me if I start with what I do the very first day in 18.06, which is multiply a matrix by a vector. And then I'll graduate to multiplying a matrix by a matrix. And you will say, I know that stuff. But do you know it the right way? Do you think of the multiplication the right way? So let me tell you what I believe to be the right way. So let me take a matrix, say, 2, 3, 5, 1, 1, 7, and 3, 4, 12. And I'll always call matrices A.

So first step is just A times x, A times a vector. So I multiply A by, let's say, x1, x2, x3. And how do I look at that answer? So the choices-- think of the rows of the matrix or think of the columns. And if you think of the rows, which is the standard way to multiply, you would take the dot product. So the first way is dot products of row dotted with x. 2x1 plus x2 plus 3x3. It gives you the answer a component at a time.

That's the low level way. The good way to see it is vector-wise. See this as x1 multiplies that first column, x2 times the second column, 1, 1, 7, and x3 times the third column, 3, 4, 12. Good. So it's a combination of vectors, and of course, it produces a vector. And here, we have a 3 by 3 matrix on our vectors are in R3. And most vectors will be in R3 or Rn for this course.

So that's the right answer. And of course, the first component is 2x1 and 1x2 and 3x3. The same 2, 1, 3-- the same dot product, it comes out right. But you see it all at once instead of piecemeal. Part of the course-- I guess part of what I hope to get across is thinking of a matrix as a whole thing, not just a bunch of nine or m times n numbers. But thinking of it as a thing. A matrix multiplies a vector to give another vector.

So when I say Ax, you immediately think that-- you immediately think, OK, Ax has a clear meaning, it's a combination of the columns of A. So now let me take that next step. And the next step is think about all combinations of the columns of A. We take the matrix A, and we take all x's and we imagine all the outputs. And what I want to ask you is, what does that look like? If I just take 1 vector x, I get a vector output. It takes a vector to a vector.

But now I take all x's-- all of vectors x in 3D and I get all these answers, and I think of them all together. So I've got a bunch of vectors-- infinitely many vectors, actually. And the question is, if I plot those infinitely many vectors, what do I have? And the beauty of linear algebra is that questions like this-- you can answer them and you intuitively see it. You certainly see it in 3D and you have the right idea in 10 dimensions, even. Most of us don't see too well in 10d-- in R10. But here we got three. So do you see what I'm saying? I'm taking all x's. So all Ax gives us a big bunch of vectors. And that collection of vectors is called the column space of A. It's a space, in other words. That's the key word there, the column space of A. And I'll just write it as C of A when I need letters for it. So I'm going to ask you, what does this column space look like? And that depends on the matrix. Sometimes that column space would be the whole of R3. Sometimes it's a smaller set in R3, a space.

Do you know what it is in this case? Do I get all of 3D out of these guys by choosing all x1 and x2 and x3? It seems like if it was a random matrix, the answer would be, surely, yes. If a random three by three matrix is-- it's column space is going to be all of our three, its columns are going to be independent, its rows are going to be independent, it's going to be invertible, it's going to be great. But is this matrix-- what's up with that matrix? No, it's not.

So what do I get instead of all of R3? I get a plane, yeah. If you get that insight. So by taking x's-- everybody's with me-- all x's here. So that means that it fills in whatever. And, well, because it's linear algebra, it's going to be likely all of R3 or a plane, or even a line. Let me just bat over here for a moment. Give me a matrix whose column space would only be a line. All 1s? OK. Wow, that's a-- let me liven it up a little. 3, 3, 3, 8, 8, 8.

So I think that the combinations of those columns are all on the same line. That says that the column space is just a line. And I would say then that the matrix-- so column space of this A is a line. Another way I could say this is that the rank of the matrix is 1. The rank is sort of the dimension of the column space. Well, not sort, that's what it is. The rank is the dimension of the column-- everybody sees that you get a line? Because any combination x1 of that plus x2 of that plus x3 of that is going to go along that line.

Here's the first column, here's the second column. They're all on a line. So I'll never get off that line. If I allow all x's, I'll get the whole line. Now here, you said not a line. What was the column space for this guy? Plane. Now, why isn't it all of R3? What do you see that's special there-- because it is special-- that's making the column space special, a plane instead of the whole thing? Yeah, what's up with these three columns?

The third column is the sum of it.

The third column is the sum of these two. So the first column is fine, 2, 3, 5. Second column is in a different direction. And when I take combinations of the first two columns, what will I get? Sorry to keep asking you questions, but that's-- anyway, that's what I always do. So the combinations of those first two columns are--?

A plane.

A plane because they're in different-- everybody sees that picture. We've got column one going that way and column two going that way. And then if I take any multiple of column one, I've got a whole line, any multiple of column two. And then when I put the two together, it fills in the plane. Yeah. Your intuition says that's right.

So this is a matrix of rank. What's the rank of this matrix?

Two.

Two. Because it's got two independent columns, but the third column is dependent. The third column is a combination of the others. So matrices like this are really the building blocks of linear algebra, they're the building blocks of data science. They're rank one matrices. And let me show you a special way to write those rank one matrices. I think of this matrix as the column vector 1, 1, 1 times the row vector 1, 3, 8. So it's a column times a row. That's a rank one matrix.

Do you see-- that's a true multiplication there. It looks a little weird, but it's a 3 by 1 matrix times a 1 by 3 matrix. These numbers have to be the same, and then the output is 3 by 3. And it's that. And do you see that it factors? So I'm going to move on to that idea. The next idea coming up will be that we can see-- well, that's coming, that we're going to see matrices with two factors.

Let me move to that, but back for this original matrix. So what's with this? The column space is a plane. Think about now the key idea of independent columns. How many independent columns have I got here?

Two.

Two, correct. Two. The third column, if I want to especially pick on that one-- I'll often go left to right. So I'll say the first guy is good, second guy is good, the third guy is not independent of the others. So I just have two independent columns. And those two columns would be a basis for the column space. So that's the critical idea of linear algebra. That's what you compute when you find a basis, and everything in the column space is a combination of these, including that is also-- that's already a combination of those. But everything else in the column space is a combination of those two. So they're a basis for it.

So you have the idea of A times x. You have the idea of column space of A, which allows all x's. Then now, we're moving into the idea of independent columns, and the number of independent columns is the rank. So the rank-- shall I write that somewhere? Maybe here. The rank is the number of independent columns. And right now, what do I mean by independent columns? Well, let's just see what that means by using it.

Are we good? I know I'm reviewing here. But allow me for this first class and part of next time also to review. But you'll see something new. In fact, why don't we see something new right away. Let me follow up on the idea of independence in a systematic way. So here's my matrix A. Can I write that again? 2, 3, 5, 1, 1, 7, and this guy was the sum of those. So that's my matrix A.

So let's start from scratch and find a basis for the column space in the most natural way. So I'm going to take a basis-- what's a basis? A basis is independent columns. So all three together would not be a basis. But they have to be not just independent, but they have to fill the space-- their combinations have to fill the space. So 2, 3, 5-- let's say I want to create a basis. I'll call the matrix C, a basis for the column space.

So here's a natural way to do it. I look at the first column. It's not 0s. If it was all 0s, I wouldn't want that in a basis. But it's not. So I put it in. So that's the first vector in my basis. Then I go on to the second column. If that column was 4, 6, 10, what would I do? If that second column was 4, 6, 10, would I put it in the basis? No. But 1, 1, 7, is OK, right? 1, 1, 7 is in a different direction. It's not a combination of what we've already got. So I say, OK, that adds something new. Put it in.

Then I move on to the third column. Do I put that into a basis? You know the answer by now. No. Because I'm looking to see, is it a combination of these guys? And it is. It's one of that plus one of that. So it's not independent. So I've finished now. I've got a matrix C, which was taken directly from A, and I kept only independent columns and I worked from left to right. And I can see that right away now that the rank is two-- the column rank, I should say-- the column rank. The number of independent columns is two. Good? Now comes the key step. I'm going to produce a third matrix, R, which is going to tell me how to get these columns from these columns. And its shape is going to be-- well, its shape-- I don't have any choice. This is three by two, so Rx would be two by something. So I'm like so. I guess it has to be two by three because I want to come out this way, two by three. What am I going to do here? I'm just going to put it in the numbers R that make this correct.

So this is a first matrix factorization. It's not-- well, it is a famous one, actually. When we see it, we'll recognize what it is. It's famous in teaching linear algebra, but now, actually, C times R, columns times rows has become very, very important in large scale numerical linear algebra. So let's figure out what goes into R. What am I thinking here? I'm putting in R. So every one of these columns is a combination of these. That's the whole point. And I'm just going to put in the numbers that you need.

So what goes in the first column of R? What goes in the first column of R? So I want to look, what combination of that column and that column gives me this one? Yeah?

1, 0.

1, 0. Because you remember how we multiply a matrix by a vector? When I multiply that matrix by that vector, I take one of this plus zero of that. I see it vector-wise, and of course I get it right. And what about the second column of R? So the second column should be the combination that produces the second column of A correctly. What will that be?

0, 1.

0, 1. Thanks. And finally the third column?

1, 1.

1, 1. Yes, right. Because one of this plus one of this produces the third column. So all I did was put in the right numbers there, really. And this is correct now. A is C times R. And so this is-what I've done here is the first two pages of section 1.1 in these notes. So 1.1. And actually, I'll tell you literally what happened earlier this year. I had finished this. I wrote this down with a different example.

And then I realized something, that sitting here in front of me was the first great theorem in linear algebra, the fact that the column rank equals the row rank. The fact that if I have a matrix where that column plus that column gives that one. Oh. So what am I going to say here? I'm getting nervous about it. I believe that a combination of the rows gives 0. Do you believe that? You've got to believe it. This is linear algebra.

The matrix is not invertible, it's square. But the columns are dependent. So the rows have to be dependent. And I don't exactly see-- there's some combination of that row and that row that gives that one. And of course, when I looked at the first column, I thought, OK, it's going to be too easy. One of that and one of that gives that. But then my eye went over to the second column, and I realized it's not easy at all. So you're entitled to pull out your phone and figure this out.

But there is some damn combination of those--

[LAUGHTER]

--of those two rows that gives the third row. Otherwise, the course is over, we stop. Well, and maybe we're going to find somehow. So this is the theorem. So I have to tell you, I was really pleased.

So the first two pages got two more pages to follow up on that idea, that here, we were seeing something that-- I proved in 18.06, but not in the first lecture, that's for sure, and not maybe so clearly. But now I can try to prove it. There won't be a lot of proofs in this class, but this is such an important fact-- A equals CR is an important factorization. And out of it, we can connect them.

So what am I saying? I am saying that all-- so what's the row rank? I have to back up here. What's the row rank? What's the row space? So the row rank is going to be the dimension of that space. So I look at my matrix A. What's the row space of A? I'm going to look at its rows. Now, maybe just so we don't get whole new letters for the row space-- for me, the row space of A of a matrix-- so first of all, tell me in words what it is. What's the row space of the matrix?

[INAUDIBLE]

All combinations of the rows. All combinations of the rows, that's the space. So I would take all combinations of those rows. To get combinations of the rows-- well, two ways I can get combinations of the rows. And the way I'll do it is, I'll just transpose the matrix. So those rows become columns, and then I'm back to what I did. So the row space of A is the column space of A transpose. And this has the advantage that we don't introduce a new letter. So it'll be the column space of A transpose.

So we don't introduce a new letter. We keep the convention that vectors are column vectors, which would be the MATLAB and Julia and Python convention. So is that OK? The row space is the combination of these rows. But I'll flip-- I'll make them stand up-- 2, 1, 3-- to be column vectors. So it's a totally different space. And actually, I happened to take a three by three example, so that the column space is part of R3 and the row space is also part of R3. Because my matrix is three by three.

A better example-- and the whole point of data-- data doesn't come in square matrices. Fortunately for us, data very, very often comes in matrices. But the two-- the columns might be sample, it might be patients, and the rows might be diseases or something. They're different spaces. So matrices are not likely to be square. But anyway, we're good here. So the row space.

Now can I come back to the proof? Because what I want to say is that the proof of this fundamental fact is staring at us, but we don't quite see it yet. And I want to see it. So I claim that these rows are a basis for the row space. And we already saw that these columns are a basis for the column space. And two equals two, right? Two vectors here were a basis for the column space.

Now if I can see why it shows me that these two vectors are a basis for the row space, then my example is right, that both of these will give two. The column rank is two, two columns, the row rank is two, two rows. I have to explain why I believe that these two rows are a basis for the row space. Are you with me? I have to prove-- I have to see why.

First, so when I say basis, what do I have to check? Basis is the critical idea. I have to check that they're independent, so I haven't got too many vectors-- I haven't got any extra vectors in there. And I also have to check that their combinations produce--? All the rows. Should I say that again? Because that's what I'm going to check. I'm going to check that those guys are independent. Well, you can see that they're independent.

And I'm going to check that their combinations produce all three of these rows. We didn't create those numbers for this purpose, but what I'm saying is they work. So I claim that this is a basis, because what combination of those two rows would produce this first row? Yeah, let me just ask you that. What numbers should I multiply these two rows by to get the first row of A?

2, 1.

2 and 1. And where do you find 2 and 1? It's sitting there in C. Will it work again? Does three of this plus one of that give 3, 1, 4? Yes. So far, so good. Does five of this and seven of that-see, I'm multiplying-- I guess I'm doing matrix multiplication a backward way or a different way. I'm taking combinations of the rows of the second guy. The wonderful thing about matrix multiplication is you can do it a lot of ways, it comes out the same every way, and each way tells you something.

So five of that row plus seven of that row, sure enough, is here. Do you see that that is not accident? The proof is really to look at this multiplication, C times R, two ways. Look at it first as combinations of columns of C to give the columns. Look at it second to get as combinations of the rows of R, and that produces the rows. So that factorization A equals CR was the key idea.

And actually, this R that we've come up with has a name. Anybody remember enough 18.06? Have you all taken 18.06? No. I see-- how many have? Yes. OK. Good. For a while, 18.06 was taught in a very abstract way. I said, what's going on? But anyway, so if you took it that semester, you maybe never heard of the column space. I'm not sure. Or by a different name.

It has another name. What's its other name? The column space of a matrix? Range-- I think it's the range. Yeah. And of course, all this is fundamental in mathematics. So of course, everything here has different languages and different emphasis. But you see what the emphasis is here.

So you see the proof, that A equals CR just reveals everything. So it's our first idea of a factorization of a matrix. And we've multiplied C times R. I could just say-- so really, you've seen now the main point of Section 1.1 of the notes to come up with that factorization and that conclusion. And you see why C has the same number of-- the number of columns of C equals the number of rows of R, and those are the column rank and the row rank.

Yeah, it's just pretty neat. And here was the special case where those the column space is all multiples of U-- it's a line through U. The row space is all multiples of V-- it's a line through V. And that's the basic building block. Can I just say another little word before I push on beyond CR? That this has become-- if you have a giant matrix, like size 10 to the 5th, you can't put that into fast memory. It's a mess. How do you deal with a matrix of size 10 to the 5th, when you cannot deal with all the entries? That's just not possible. Well, you sample it.

So later in the course, we'll be doing random sampling of a matrix. So how could you sample a matrix? So you have a matrix. Of course you're looking at it, but it's-- and you want to get some typical columns. Here's the natural idea. You just look at A times x. Let x be a random vector. Rand of-- so it's got m rows and one column. It's a vector.

And what can I say about Ax? It's in the-- what space is it in?

Column.

Column space. Thanks. That was the first idea in this lecture. Ax is in the column space. So if you want a random vector in the column space, I wouldn't suggest to just randomly pick one of the columns. Better to take a mixture of columns by taking a random vector x, and looking at Ax. And if you wanted 100 random vectors, you'd take a 100 random x's, and that would give you a pretty good idea, in many cases, of what the column space looks like. That would be enough to work with often.

Can I just throw in another question? So Ax is in the column space of A. Let me just ask you this question. Is ABCx-- is that in the column space of A? Suppose I have matrices A, B, and C, and a vector x, and I take their product. Does that give me something in the column space of A?

Yes.

Yes, good for you. How do you know that?

[INAUDIBLE]

Yeah, it's A times something. Right. Putting parentheses in the right place is the key to linear algebra. And there it is. It's a question that just occurred to me. And I thought, well, I wonder if you'd do it. So we have still time to multiply matrices. Oh, I was going to say about C and R-so these are real columns from A. But R is-- the rows are not taken directly from the rows of A. Actually, there is a name for this. It's called the row reduced echelon form of the matrix, and it's a big goal in 18.06. It has the identity there, and then the other columns tell you the right combinations. Another big factorization would be to take columns from A-- so this is another-- so I'll put maybe or-- and we won't be doing this for a month. We could start to take columns of A and put them into C, if they were independent. And suppose I took rows of A. Now I'm going to take literally rows of A, and put them into R-- well, shall I call it R twiddle or something, because it'll be a different R. I'm not going to use those rows, but I'm going to take two actual rows of A. Then what?

So that's an important factorization, but it's not correct. If I took two other rows of R, it wouldn't work. So you have to put it in the middle some two by two matrix U that makes it correct. You'll see in that Section 1.1 that I got excited and wrote a page about CUR. Yeah, so I'll just mention that. So now I'm ready-- oh, I wanted to say something about the course. I got excited thinking about math, but there is this course. So what's up?

So there'll be linear algebra problems. But what makes this course special is the other homeworks, which are online. And you would use-- let's see. In principle, you could use any of the languages-- MATLAB, Python, which has become the biggest-- most used for deep learning, or Julia, which is the hot, new language. So last time, last year, the problems-- oh, so what happened last year?

Well, everything in this course is owed to a professor who visited from the University of Michigan, Professor Rao-- Raj Rao, who gave most of the lectures a year ago, brought these homework problems-- online homework problems, so that people brought laptops to class and we did things in class. So he had and has a very successful course at EE in Michigan. But he was a PhD from here, and he came back on a sabbatical, and he created this-- got us started. And we really owe a lot to him.

Also, Professor Edelman was involved with this course. And you maybe know that he created Julia. How many know what Julia is? Oh, wonderful. That will make his day. He tells me every time I see him, Julia is good. And I tell him, I believe it.

[LAUGHTER]

Anyway-- and it's become-- Professor Johnson in 18.06 has used Julia. And every semester, Steven Johnson gives in the first week a tutorial on Julia. And so that's arranged, and I promised to tell you where and when that is. So I think if you don't know anything about Julia, try to go. It's in Stata. It's on Friday at 5:00-- 5:00 to 7:00. So Julia from Professor Johnson. So he's done this multiple times. He's good at it.

I don't think we know yet what-- I guess I'm hoping that you'll have an option to use any of the three languages. But the online thing that we give you was created in Julia. So professor Rao had to learn Julia last spring, and the class did, too. And there was a certain amount of bitching about it.

[LAUGHTER]

But I think, with maybe one exception, who still got an A, everybody was OK and was glad to learn Julia. And Professor Rao now uses Julia entirely. So he's creating a new on ramp with Julia. MATLAB, by the way, has just issued an on ramp to deep learning that I'll tell you about, and probably get a MATLAB-- somebody from Math Works to say something about it.

So that's what's coming, that we don't quite know exactly how well organized those homeworks. We'll just take the first one and see what happens. So I'll certainly say more about homeworks when-- maybe even Friday.

But are there other questions that I should answer? Because some people will be thinking, OK, am I going to do this or am I going to sit in 6.036, or some other course in deep learning? Anything on your mind? And you can email me. So we will have a Stellar site and you'll see all the-- the TAs are still to be named. But the wonderful thing is that the undergraduates who took this course last year are volunteering to be graders for you guys. So they will know what those online homeworks were about.

So that's a first word about what's coming and about the language. I'm going to finish by a very important topic, multiplying A times B. Oh, look, a clean board. So now I want to multiply a matrix by a vector. Everybody knows how to do it. You take a row of A-- so you take a row of A and you take a column of B, and you take the dot product. So you get a dot product. Row dot column.

That's, again, low level, OK for beginners. But we want to see that matrix multiplication, AB, in a deeper way. And the deeper way is columns times row. Columns of A, rows of B. Columns times row. Oh, we had a column times a row. That was this rank one example. We had a column times a row, and it produced a matrix. And that's what it looked like. And its rank was one. So those are what-- so it's a combination of.

It's very like Ax. I'm really just extending the Ax idea to AB. So this is the old way. The new way is columns. So there's column K. It will multiply. Sure enough, it multiplies row K. Everybody sees that it will happen that way. If you do it the old way, when you do a dot product of something here, something here, you're doing these multiplications. And when you hit column K here, you hit row K there. So these are connected.

So I get things like column K of A times row K of B. And I don't know what notation to use, so I just wrote the words. But now that's one piece of the final answer, AB. That's a rank one piece. That's a building block. So I add from K equals 1 column one times row one. Column one of A times row one of B plus-- da, da, da, plus column K plus-- and of course, I stop at column n of A times row n of B. So it's a sum of outer products.

So everybody sees a sum because I have column one times row 1, column K times row K, column n times row n, and then I add those pieces. It's just the generalization of Ax to a matrix B there. So it's a sum of Column K row K of A row K of B. And maybe, should we check that that gives us the right answer? I won't do that here, but all we're doing is the same multiplications in a different order.

Actually, let's just quit with one minute. We can figure out how many multiplications are there. How many more applications to do an m by n matrix A times an n by p matrix B? So that's A times B. How many individual numbers-- because this would determine the cost of it.

How many numbers would we need? Well, suppose we do it the old way, by inner product, row times column. So how many multiplications to do a row times column and get one entry in the answer? n, right? The row has length n, the column has length n, n multiplications. So that's n. And now how many of those do I have to do?

mp.

mp. Because what's the size of this answer? The size of this answer is m by p. So if I do it in that old order, like n multiplication is to do a dot product. And I've got this many dot products in the answer. So I've mnp multiplied. Now suppose I do it this way. How many multiplications to do one of those guys? To multiply our column by a row?

This is an m by 1, and this is a 1 by p. One column, one row. How many multiplications for that guy? mp. And how many of those rank ones do I have to do? n. You got it? mp times n.

Now, the other way was n times mp. So it gives the same answer, mnp multiplication. In fact, they're exactly the same multiplications, just a different order. OK. We're at 1:55. Thanks for coming today. I'll talk more about the class and about linear algebra on Friday. Thank you.