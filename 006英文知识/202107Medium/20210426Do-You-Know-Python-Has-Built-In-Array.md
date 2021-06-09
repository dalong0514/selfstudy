# Do You Know Python Has Built-In Array?

Everyone uses「List」, but Python does have「Array」

Christopher Tao

2021-04-26

[Do You Know Python Has Built-In Array? | by Christopher Tao | Apr, 2021 | Towards Data Science](https://towardsdatascience.com/do-you-know-python-has-built-in-array-c2afa4200b97)

## Summary

In this article, I have introduced Python Array which is built-in to Python. It is not the Python List that we are quite familiar with. It is also not the NumPy array that is very powerful in terms of mathematical calculations and modelling. It is built-in to Python that is quite restricted in that it can only contain elements of the same type.

If you're interested in other Python Container types and other built-in cool features, please check out my previous paper.

[6 Python Container Data Types You Should Know | by Christopher Tao | Apr, 2021 | Towards Data Science](https://towardsdatascience.com/6-python-container-data-types-you-should-know-81dad6c4f61d)

## 00

When we say「array」in Python, very likely we mean「list」. That's true. Python List is a very powerful and flexible container type in Python. Although it is a little bit confusing, we always use List in Python just like the equivalent concept「Array」in most other programming languages.

Or, you might say that Python does have「Array」, but it is from the NumPy library. That's also true. When we are dealing with mathematical problems, typically multidimensional array or matrix, NumPy array is a must-have tool.

However, neither above two will be introduced in this article today. I'm going to introduce the「Array」in Python. Yes, neither the「List」nor NumPy「Array」, but Python built-in「Array」. Have you ever know there is such a thing?

## 01. Python Array Basics

The Array is built-in Python, which only means that you don't need to download and install it because it comes with native Python for sure. However, just like the other built-in libraries such as「datetime」, you still need to import it.

```py
import array
```

Before we can use the array, it is important to understand that it is still quite different from typical array concepts that would be found in most of the other programming languages. The most special feature is that it has to be defined with a Type Code. We can list all the available type codes as follows.

```py
array.typecodes
```

Each character is corresponding to a specific data type that the array will contain. The Type Codes and corresponding types can be found in the official documentation as follows.

Table from Python Official Documentation: array

1『图片详见原文。（2021-06-03）』

The type code of an array has to be defined upon the array is instantiated. This also means:

Python array can only contain elements with a certain type.

This is quite different from a List, right? For a Python List, we can flexibly put whatever objects in a single list without worrying about their types.

Now, let's define an array. I would like to import the library again as follows because I don't want to have `array.array()` in my code, just like `datetime.datetime.now()` is kind of ugly.

```py
from array import array
```

We can define an array of chars as follows.

```py
arr = array('u', 'abcdefg')
```

Refer to the table above-shown, the type code「u」means that this array contains Unicode characters. So, these letters will be treated separated and we have 7 elements in this array now.

## 02. Functions of Array

OK. This built-in array seems to be quite unique. So, it also has some quite unique features as follows.

1 Get the Type Code. Since the type code is very important to an array, which determined what kind of elements that the array can have. We can get the type code by accessing its property typecode.

```py
arr.typecode
```

2 Get Size of Array Item. As above-mentioned, unlike Python List, the Array is much more rigid. That is, the items that an array contains must be of the same type. Therefore, the size of the item will also be the same. We can check the size of each item.

```py
arr.itemsize
```

Don't be confused that this is not the length of the array, but the size of a single item in the array.

3 Count the Number of Occurrences. Like Python List, the Array also has the count() function that will count the number of occurrences of a certain item in the array. Maybe you don't even know that Python List has this? Try it out.

```py
arr.count('b')
```

4 Append and Extend. If we want to add new items into an array, we can either use the append() or the extend() function. The former will add a single element, while the latter can add multiple items at one time.

```py
arr.append('h')

arr.extend('ijk')
```

5 Manipulating the Index. As an array, we must be able to do something with it using the index. Yes, we can get the index of a certain item. Please be noticed that we will only have the index of the first occurrence if the item repeated in this array.

```py
arr.index('c')
```

Also, we can insert an item at a certain index.

```py
arr.insert(2, 'x')
```

If we want to delete an item at a certain index, we can use the pop() function.

```py
arr.pop(2)
```

After poping the item out of the array, the original array will be updated in place. We can also reverse the array as follows.

```py
arr.reverse()
```

6 Array to List. Of course, we don't have to be limited within the scope of Array because it is quite restricted. If we want to convert it to a normal Python List, it is very easy to do so.

```py
my_list = arr.tolist()
```

## 03. When to Use Python Array?

I guess this is the most important problem. If the Python Array is much more restricted than Python List, why we need to have it? In other words, when we should use it?

The short answer is: you may never use it because Lists and NumPy Arrays usually are much better alternatives. That's also the reason why rarely people knows Python has a built-in Array type.

However, when something is restricted, it must bring some benefits. That is the so-call「trade-off」. In this case, Python Array will have a smaller size than Python List.

1『太扯淡了，看到这里才说不建议用 Array 数据类型，唯一的优势是数据体积小，但现在根本不缺存储空间的。那这篇文章压根不应该写的。（2021-06-03）』

Let's make up an example. A Python List with 100,000 integers is created. Then, it is converted to Python Array.

```py
list_large = list(range(0, 100000))

arr_large = array('I', list_large)
```

Let's have a look at the size of them.

```py
arr_large.__sizeof__()

list_large.__sizeof__()
```

It can be seen that the size of the array is only about half of the size of the list, even smaller than half. This is because the type code of the array is fixed and the number of bytes of each item is also fixed. It loses some flexibility but has less overhead.

Python Array uses less memory size than Python List.