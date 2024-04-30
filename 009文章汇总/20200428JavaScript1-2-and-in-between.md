# JavaScript 1, 2, and in between

BRENDAN EICH

POSTED ONJUNE 13, 2005 BY BRENDAN EICH

[JavaScript 1, 2, and in between – Brendan Eich](https://brendaneich.com/2005/06/javascript-1-2-and-in-between/)

With DHTML and AJAX hot (or hot again; we’ve been here before, and I don’t like either acronym), I am asked frequently these days about JavaScript, past and future. In spite of the fact that JS was misnamed (I will call it JS in the rest of this entry), standardized prematurely, then ignored and stagnated during most of its life, its primitives are strong enough that whole ecologies of toolkit and web-app code have emerged on top of it. (I don’t agree with everything Doug Crockford writes at the last two links, but most of his arrows hit their targets.)

Too many of the JS/DHTML toolkits have the “you must use our APIs for everything, including how you manipulate strings” disease. Some are cool, for example TIBET, which looks a lot like Smalltalk. Some have real value, e.g. Oddpost, which Yahoo! acquired perhaps as much for its DHTML toolkit as for the mail client built on that toolkit.

Yet no JS toolkit has taken off in a big way on the web, probably more on account of the costs of learning and bundling any given API, than because of the “you must use our APIs and only our APIs” problem. So people keep inventing their own toolkits.

Inventing toolkits and extension systems on top of JS is cool. I hoped that would happen, because during Netscape 2 and 3 days I was under great pressure to minimize JS-the-language, implement JS-the-DOM, and defer to Java for “real programming” (this was a mistake, but until Netscape hired more than temporary intern or loaner help, around the time Netscape 4 work began, I was the entire “JS team” — so delegating to Java seemed like a good idea at the time). Therefore in minimizing JS-the-language, I added explicit prototype-based delegation, allowing users to supplement built-in methods with their own in the same given single-prototype namespace.

In listening to user feedback, participating in ECMA TG1 (back during Edition 1 days, and again recently for E4X and the revived Edition 4 work), and all the while watching how the several major “JS” implementors have maintained and evolved their implementations, I’ve come to some conclusions about what JS does and does not need.

1. JS is not going away, so it ought to evolve. As with sharks (and relationships, see Annie Hall), a programming language is either moving forward, or it’s dead. Now dead languages (natural and programming) have their uses; fixed denotation and grammar, and in general a lack of “versionitis”, are virtues. You could argue that JS’s stagnation, along with HTML’s, was beneficial for the “Web 1.0” build-out of the last decade. But given all the ferment on the web today, in XUL and its stepchildren, and with user scripting, there should be a JS2, and even a JS1.6 on the way toward JS2.

2. JS does not need to become Java, or C#, or any other language. 

3. JS does need some of its sharp corners rounded safely. See the table below for details.

4. Beyond fixing what was broken in JS1, JS should evolve to solve problems that users face today in the domains where JS lives: web page and application content (including Flash), server-side scripting (whether Rhino or .NET), VXML and similar embeddings, and games.

5. For example, it should be trivial in a future version of JS to produce or consume a “package” of useful script that presents a consistent interface to consumers, even as its implementation details and new interfaces evolve to better meet existing requirements, and to meet entirely new requirements. In no case should internal methods or properties be exposed by default.

6. It’s clear to me that some users want obfuscated source code, but I am not in favor of standardizing an obfuscator. Mozilla products could support the IE obfuscator, if someone wants to fix bug 125525. A standard obfuscator is that much less obscure, besides being unlikely to be adopted by those who have already invented their own (who appear to be the only users truly motivated by a need for obfuscation at this point).
A more intuitive numeric type or type tower would help many users, although to be effective it would have to be enabled via a new compile-time option of some sort. Numeric type improvements, together with Edition 4’s extensible operator and unit proposals, would address many user requests for enhancement I’ve heard over the years.

7. Too much JS, in almost every embedding I’ve seen, suffers from an execution model that appears single-threaded (which is good for most users) yet lacks coroutining or more specific forms of it such as generators (Boo has particularly nice forms, building on Python with a cleanup or two). So users end up writing lots of creepy callbacks, setTimeout chains, and explicit control block state machines, instead of simply writing loops and similar constructs that can deliver results one by one, suspending after each delivery until called again.

That’s my “do and don’t” list for any future JS, and I will say more, with more specifics, about what to add to the language. What to fix is easier to identify, provided we can fix compatibly without making a mess of old and new.

Here are the three most-duplicated bug reports against core language design elements tracked by Mozilla’s bugzilla installation:

I argue that we ought to fix these, in backward-compatible fashion if possible, in a new Edition of ECMA-262. If we solve other real problems that have not racked up duplicate bug counts, but fail to fix these usability flaws, we have failed to listen to JS users. Let’s consider these one by one:

1. Unlike object and array initialisers, and E4X’s XML literals, regular expression literals correspond one-for-one with objects created during parsing. While this is often optimal and even useful, when combined with the g (global) flag and the lastIndex property, these singleton literals make for a pigeon-hole problem, and a gratuitous inconsistency with other kinds of “literals”. To fix this compatibly, we could add a new flag, although it would be good to pick a letter not used by Perl (or Perl 6, which fearlessly revamps Perl’s regular expression sub-language in ways that ECMA-262 will likely not follow).

2. The Date.prototype.getYear method is a botch and a blight, the only Y2K bug in Mozilla-based browsers that still ships for compatibility with too many web sites. This bug came directly from java.util.Date, which was deprecated long ago. I’d like to get rid of it, but in the mean time, perhaps we should throw in the towel and emulate IE’s non-ECMA behavior (ECMA-262 did standardize getYear in a non-normative annex).
The solution here is a new default number type, with arbitrary precision and something equivalent to decimal radix. Mike Cowlishaw has advocated and implemented his own flavor of decimal arithmetic, but it is not popular in ECMA TG1. Still, I bet we could make life better for many JS users with some innovation here.

There are other bugs in JS1 to fix, particularly to do with Unicode in regular expressions, and even in source text (see the infamous ZWNJ and ZWJ should not be ignored bug). More on these too, shortly, but in a wiki, linked with informal discussion here.
