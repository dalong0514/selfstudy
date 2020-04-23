# 9 JavaScript Interview Questions

Ace Your Interview with Examples of Common and Curveball Questions

Bret Cameron

May 16, 2019 · 12 min read

[9 JavaScript Interview Questions - Bret Cameron - Medium](https://medium.com/@bretcameron/9-javascript-interview-questions-48416366852b)

JavaScript is considered a great language for beginners. It’s partly because of its wide use on the internet, and partly because several of its features make it possible to write less-than-perfect code that still runs: it’s not as strict as many other languages, whether you’ve missed out a semi-colon or you don’t want to worry about memory management.

But by the time you’re ready for interviews, you’ll want to feel confident that you know the ins and outs of the language, including some things that are done automatically and ‘behind the scenes’.

In this article, we’ll cover some common JavaScript interview questions — as well as a few curveballs! Of course, every interview is different, and you may or may not be asked any questions of this kind. But the more you know, the better prepared you’ll be.

2『 [Bret Cameron – Medium](https://medium.com/@bretcameron)，发现作者写了很多高质量有关 JS 的文章，抽空整理。』

## PART I: CURVEBALL QUESTIONS

It would seem pretty tough if any of the following questions cropped up in an interview. Nevertheless, these questions should still prove useful in preparation: they reveal some interesting quirks of JavaScript and they highlight some of the decisions that have to be made when coming up with a programming language in the first place. For more quirky JavaScript features, I recommend checking out https://wtfjs.com.

2『 [wtfjs - a little code blog about that language we love despite giving us so much to hate](https://wtfjs.com/)，GitHub 地址：[brianleroux/wtfjs: wtfjs.com!](https://github.com/brianleroux/wtfjs)，内容去爬取下来。』

### 1. Why is Math.max() smaller than Math.min()?

The fact that Math.max() > Math.min() returns false sounds wrong, but it actually makes a lot of sense. If no arguments are given, Math.min() returns infinity and Math.max() returns -infinity. This is simply part of the specification for the max() and min() methods, but there is good logic behind the choice. To understand why, take a look at the following code:

```js
Math.min(1) 
// 1

Math.min(1, infinity)
// 1

Math.min(1, -infinity)
// -infinity
```

If -infinity was considered the default argument of Math.min() , then every result would be -infinity , which is pretty useless! Whereas, if the default argument is infinity , the addition of any other argument would return that number — and that’s the behaviour we want.

### 2. Why does 0.1 + 0.2 === 0.3 return false?

In short, it’s to do with how accurately JavaScript can store floats in binary. If you type the following equations into Google Chrome’s console, you’ll get:

```js
0.1 + 0.2
// 0.30000000000000004

0.1 + 0.2 - 0.2
// 0.10000000000000003

0.1 + 0.7
// 0.7999999999999999
```

This is unlikely to cause problems if you’re performing simple equations without the need for a high degree of accuracy. But it can cause headaches even in simple applications if you need to test for equality. There are a few solutions to this.

#### 2.1 Fixed Point

For example, if you know the maximum precision you’ll need (for example, if you’re dealing with currencies), you can integer type to store the value. So instead of \$4.99 , you could store 499 and perform any equations on that. You could then display the result to the end-user using an expression like result = (value / 100).toFixed(2) , which returns a string.

#### 2.2 Binary Coded Decimals

If precision is really important, another option is to use the Binary Coded Decimals (BCD) format, which you can access in JavaScript using this BCD library. Every decimal value is stored separately in a single byte (8 bits). This is inefficient, as a byte can store 16 separate values and this system only uses values 0–9. However, if precision is important for your application, it may be worth the trade-off.

### 3. Why Does 018 Minus 017 Equal 3?

The fact that 018 - 017 returns 3 is a result of silent type conversion. In this case, we’re talking about octal numbers.

#### 3.1 A Quick Introduction to Octal Numbers

You’re likely aware of the use of binary (base-2) and hexadecimal (base-16) number systems in computing, but octal (base-8 ) also has a prominent place in the history of computers: in the late 1950s and 1960s, it was used to abbreviate binary, cutting material costs in what were highly expensive systems to manufacture!

Hexadecimal came shortly afterwards: The IBM 360 [released in 1965] took the definitive step from octal to hexadecimal. To those of us accustomed to octal, we were shocked at the extravagance! — Vaughan Pratt

#### 3.2 Octal Numbers Today

But what’s octal useful for in modern programming languages? Octal has an advantage over hexadecimal for some use cases because it doesn’t require any non-numerical digits (using 0–7 rather than 0–F). One common use is in file permissions for Unix systems, where there are exactly eight permission variations:

```
   4 2 1
0  - - - no permissions
1  - - x only execute
2  - x - only write
3  - x x write and execute
4  x - - only read
5  x - x read and execute
6  x x - read and write
7  x x x read, write and execute
```

For similar reasons, It is also used for digital displays.

#### 3.3 Back to the Question

In JavaScript, the prefix 0 will convert any number to octal. However, 8 is not used in octal, and any number containing an 8 will be silently converted to a regular decimal number. Therefore, 018 - 017 is in fact equivalent to the decimal expression 18 - 15 , because 017 is octal but 018 is decimal.

## PART II: COMMON QUESTIONS

In this section, we’ll look at some of the more common JavaScript interview questions. These are the kind of things that are easy to overlook when you’re first learning JavaScript, but knowledge of them could prove really useful when it comes to writing the best possible code.

### 4. How Does a Function Expression Differ from a Function Declaration?

A function declaration uses the keyword function , followed by the name of the function. By contrast, a function expression begins with var , let or const , followed by the name of the function and the assignment operator = . Here are some examples:

```js
// Function Declaration
function sum(x, y) {
  return x + y;
};

// Function Expression: ES5
var sum = function(x, y) {
  return x + y;
};
// Function Expression: ES6+
const sum = (x, y) => { return x + y };
```

In usage, the key difference is that function declarations are hoisted, while function expressions are not. That means function declarations are moved to the top of their scope by the JavaScript interpreter, and so you can define a function declaration and call it anywhere in your code. By contrast, you can only call a function expression in linear sequence: you have to define it before you call it.

1『哈哈，现在可以轻松理解了。函数声明在函数执行上下文的创建阶段里会被扫描，声明会存入词法环境里的「环境记录」里，这就是所谓的「提升」。（2020-04-23）』

There are a handful of reasons why, today, many developers prefer function expressions: 1) First and foremost, function expressions enforce a more predictable, structured codebase. Of course, a structured codebase is also possible with declarations; it’s just that declarations allow you to get away with messy code more easily. 2) Second, we can use ES6 syntax for function expressions: this is generally more concise, and let and const provide more control over whether a variable can be re-assigned or not, as we’ll see in the next question.

### 5. What are the differences between var, let and const?

I imagine this has been a pretty common interview question since the release of ES6, by those companies making full use of the more modern syntax. var was the variable declaration keyword from the very first release of JavaScript. But its disadvantages lead to the adoption of two new keywords in ES6: let and const . These three keywords have different approaches to assignment, hoisting and scope — so we’ll cover each one separately.

#### 5.1 Assignment

The most basic difference is that let and var can be re-assigned while const cannot. This makes const the best choice for variables that don’t need to change, and it will prevent mistakes such as accidental re-assignment. Note that const does allow for variable mutation, which means that if it represents an array or an object, these can change. You just can’t re-assign the variable itself.

Both let and var can be re-assigned, but — as the following points should make clear — let has significant advantages over var , making it a better choice in most, if not all circumstances where a variable needs to change.

#### 5.2 Hoisting

Similar to the difference between function declarations and expressions (discussed above), variables declared using var are always hoised to the top of their respective scope, while variables declared using const and let are hoisted, but if you try to access them before they’re declared, you will get a ‘temporal dead zone’ error. This is useful behaviour, since var can be more prone to errors, such as accidental re-assignment. Take the following example:

```js
var x = "global scope";
function foo() {
  var x = "functional scope";
  console.log(x);
}

foo(); // "functional scope"
console.log(x); // "global scope"
```

Here, the result of foo() and console.log(x) are as we expect. But what if we were to drop the second var ?

```js
var x = "global scope";
function foo() {
  x = "functional scope";
  console.log(x);
}

foo(); // "functional scope"
console.log(x); // "functional scope"
```

Despite being defined within a function, x = "functional scope" has overridden the global variable. We needed to repeat the keyword var to specify that the second variable x is scoped only to foo() .

1『上面的这个分析目前还没弄明白。（2020-04-23）』

#### 5.3 Scope

While var is function-scoped, let and const are block-scoped: in general, a block is any code within curly braces {} , including functions, conditional statements, and loops. To illustrate the difference, take a look at the following code:

```js
var a = 0; 
let b = 0;
const c = 0;
if (true) {
  var a = 1;
  let b = 1; 
  const c = 1;
}

console.log(a); // 1
console.log(b); // 0
console.log(c); // 0
```

Within our conditional block, the globally-scoped var a has been redefined, but the globally-scoped let b and const c have not. In general, making sure local assignments stay local will make for cleaner code and fewer mistakes.

### 6. What happens if you assign a variable without a keyword?

What if you define a variable without using a keyword at all? Technically, if x hasn’t already been defined, then x = 1 is shorthand for window.x = 1. I discussed this in a recent article on memory management in JavaScript, as it’s a common cause of memory leaks.

3『 [What JavaScript Developers Can Learn from C++ - Bret Cameron - Medium](https://medium.com/@bretcameron/what-javascript-developers-can-learn-from-c-3cdb93ab8658) 』

To prevent this shorthand altogether, you can use strict mode — introduced in ES5 — by writing use strict at the top of your document or a particular function. Then, when you try to declare a variable without a keyword, you’ll get an error: Uncaught SyntaxError: Unexpected indentifier.

### 7. What’s the difference between Object Oriented Programming (OOP) and Functional Programming (FP)?

JavaScript is a multi-paradigm language, meaning that it supports multiple different programming styles, including event-driven, functional and object-oriented. There are many different programming paradigms, but in contemporary computing two of the most popular styles are Functional Programming (FP) and Object-Oriented Programming (OOP) — and JavaScript can do both.

#### 7.1 Object-Oriented Programming

OOP is based around the concept of「objects」. These are data structures that contain data fields — known in JavaScript as「properties」— and procedures — known as「methods」. Some of JavaScript’s in-built objects include Math (used for methods such as random , max and sin ), JSON (used for parsing JSON data), and primitive data types like String , Array , Number and Boolean. Whenever you rely on in-built methods, prototypes or classes, you are essentially using Object-Oriented Programming.

#### 7.2 Functional Programming

FP is based around the concept of「pure functions」, which avoid shared state, mutable data and side-effects. This might seem like a lot of jargon, but chances are you’ve created written many pure functions in your code. Given the same inputs, a pure function always returns the same output. It does not have side effects: these are anything, such as logging to the console or modifying an external variable, beyond returning the result.

As for shared state, here’s a quick example of it state can change the output of a function, even if the input is the same. Let’s set out a scenario with two functions: one to add a number by 5, and one to multiply it by 5.

```js
const num = {
  val: 1
}; 
const add5 = () => num.val += 5; 
const multiply5 = () => num.val *= 5;
```

1『原来上面的就是函数式编程的风格，细细品品。』

If we call add5 first and multiply5 second, the overall result is 30 . But if we call the functions the other way around and log the result, we get something different: 10. This goes against the principle of functional programming, as the result of the functions differs depending on the context. We can re-write the above code so that the results are predictable:

```js
const num = {
  val: 1
};
const add5 = () => Object.assign({}, num, {val: num.val + 5}); 
const multiply5 = () => Object.assign({}, num, {val: num.val * 5});
```

Now, the value of num.val remains 1, and regardless of the context add5(num) and multiply5(num) will always produce the same result.

2『第二个场景里看到 assign() 函数了，去查下具体信息。』

### 8. What’s the difference between imperative and declarative programming?

We can also think about the difference between OOP and FP in terms of the difference between「imperative」and「declarative」programming. These are umbrella terms that describe shared characteristics between multiple different programming paradigms. FP is an example of declarative programming, while OOP is an example of imperative programming.

In a basic sense, imperative programming is concerned with how you do something. It spells out the steps in the most essential way, and is characterised by for and while loops, if and switch statements, and so on.

```js
const sumArray = array => {
  let result = 0;
  for (let i = 0; i < array.length; i++) { 
    result += array[i]
  }; 
  return result;
}
```

By contrast, declarative programming is concerned with what to do, and it abstracts away the how by relying on expressions. This often results in more concise code, but at scale, it can become more difficult to debug because it’s that much less transparent. Here’s a declarative approach to our sumArray() function, above.

```js
const sumArray = array => { return array.reduce((x, y) => x + y) };
```

### 9. What is Prototype-Based Inheritance?

Finally, we come to prototype-based inheritance. There are several different styles of Object-Oriented Programming, and the one JavaScript uses is Prototype-Based Inheritance. The system allows for repeated behaviour via the use of existing objects that serve as「prototypes」.

Even if the idea of prototypes is new to you, you will have encountered the prototype system by using in-built methods. For example, functions used to manipulate arrays such as map, reduce, splice and so on are all methods of the Array.prototype object. In fact, every instance of an array (defined using square brackets [], or — more unusually — using new Array()) inherits from Array.prototype , which is why methods like map, reduce and splice are available by default.

The same is true of virtually every other built-in object, such as strings and booleans: only a few, such as Infinity , NaN , null and undefined have no properties or methods. At the end of the prototype chain we find Object.prototype , and almost every object in JavaScript is an instance of Object.prototype: Array.prototype and String.prototype, for example, both inherit properties and methods from Object.prototype.

To add properties and methods to an object using prototype syntax, you can simply initiate the object as a function, and use the prototype keyword to add properties and methods:

```js
function Person() {};
Person.prototype.forename = "John";
Person.prototype.surname = "Smith";
```

#### 9.1 Should I Override or Extend the Behaviour of Prototypes?

It’s possible to change the behaviour of built-in prototypes in exactly the same way that we can create and extend our own prototypes, but most developers (and most companies) would advise against this. If you want several objects to share the same behaviour, you can always create a custom object (or define your own ‘class’ or ‘subclass’) that inherits from a built-in prototype without making any changes to the prototype itself. If you’re going to be working with other developers, they’ll have certain expectations about JavaScript’s default behaviour, and editing this default behaviour can easily lead to errors.

It’s worth noting, however, that not everyone shares this strong opposition to extending built-in prototypes. See, for example, this article from Brendan Eich, the creator of JavaScript. In this article (from 2005), Eich suggested that the prototype system in fact was built — in part — to make extensions possible!

3『

[JavaScript 1, 2, and in between – Brendan Eich](https://brendaneich.com/2005/06/javascript-1-2-and-in-between/)

Brendan Eich 的这篇文章一定要去读，同时去抓取他的博客。

』

Overall, I hope these questions have helped you better understand JavaScript — both its core features and its more unusual quirks — and that it helps you feel more prepared for your next interview.
