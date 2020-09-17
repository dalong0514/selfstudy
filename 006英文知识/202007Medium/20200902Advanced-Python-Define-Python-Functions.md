# Advanced Python: Consider These 10 Elements When You Define Python Functions

[Advanced Python: Consider These 10 Elements When You Define Python Functions | by Yong Cui, Ph.D. | Better Programming | Aug, 2020 | Medium](https://medium.com/better-programming/advanced-python-consider-these-10-elements-when-you-define-python-functions-61c0be8a10ed)

Yong Cui, Ph.D.

Aug 26 · 12 min read

No matter what implementation mechanisms programming languages use, all of them have a reserved seat for functions. Functions are essential parts of any code project because they’re responsible for preparing and processing data and configuring user interface elements. Without exception, Python, while positioned as an object-oriented programming language, depends on functions to perform data-related operations. So, writing good functions is critical to building a resilient code base.

It’s straightforward to define a few simple functions in a small project. With the growth of the project scope, the functions can get far more complicated and the need for more functions grows exponentially. Getting all the functions to work together without any confusion can be a headache, even to experienced programmers. Applying best practices to function declarations becomes more important as the scope of your project grows. In this article, I’d like to talk about best practices for declaring functions — knowledge I have accrued over years of coding.

## 01. General Guidelines

You may be familiar with these general guidelines, but I’d like to discuss them first because they’re high-level, good practices that many programmers don’t appreciate. When developers don’t follow these guidelines, they pay the price — the code is very hard to maintain.

### 1.1 Explicit and meaningful names

We have to give meaningful names to our functions. As you know, functions are also objects in Python, so when we define a function, we basically create a variable of the function type. So, the variable name (i.e. the name of the function) has to reflect the operation it performs.

1『第一次知道，Python 里函数也是一种「对象」，跟 JS 里的函数一样。』

Although readability has become more emphasized in modern coding, it’s mostly talked about in regards to comments — it’s much less often discussed in relation to code itself. So, if you have to write extensive comments to explain your functions, it’s very likely that your functions don’t have good names. Don’t worry about having a long function name — almost all modern IDEs have excellent auto-completion hints, which will save you from typing the entire long names.

```py
# Too generic, wanting others to guess what it does??
def foo(): pass

# Lack of details, requiring contexts to understand
def do_step1(): pass

# Not following naming conventions, which should be snake style and all lowercase
def GETData(): pass

# A few explicit and meaningful names
def get_account_info(): pass

def generate_sales_report(): pass
```

1-2『每个语言还是按照每个语言推荐的编程规范把，比如 Python 里函数的命令是全小写的蛇形命名。做一张 Python 编程规范的主题卡片。』——已完成

Good naming rules should also apply to the arguments of the function and all local variables within the function. Something else to note is that if your functions are intended to be used within your class or module, you may want to prefix the name with an underscore (e.g., def \_internal\_fun():) to indicate that these functions are for private usages and they’re not public APIs.

### 1.2 Small and Single Purpose

Your functions should be kept small, so they’re easier to manage. Imagine that you’re building a house (not a mansion). However, the bricks you’re using are one meter cubed. Are they easy to use? Probably not — they’re too large. The same principle applies to functions. The functions are the bricks of your project. If the functions are all enormous in size, your construction won’t progress as smoothly as it could. When they’re small, they’re easier to fit into various places and moved around if the need arises.

It’s also key for your functions to serve single purposes, which can help you keep your functions small. Another benefit of single-purpose functions is that you’ll find it much easier to name such functions. You can simply name your function based on its intended single purpose. The following is how we can refactor our functions to make each of them serve only one purpose each. Another thing to note is that by doing that, you can minimize the comments that you need to write — because all the function names tell the story.

```py
# Embed all operations with one single function
def process_data():
    # a bunch of code to read data
    # a bunch of code to clean the data
    # a bunch of code to generate the report
    pass

# Refactor by create additional smaller functions
def read_data_from_path(filepath):
    return data

def clean_data(data): 
    return cleaned_data

def generate_report(cleaned_data):
    return report

def process_data():
    data = read_data_from_path(filepath="path_to_file.csv")
    cleaned_data = clean_data(data)
    report = generate_report(cleaned_data)
    return report
```

### 1.3 Don’t reinvent the wheel

You don’t have unlimited energy and time to write functions for every operation you need, so it’s essential to be familiar with common functions in standard libraries. Before you define your own functions, think about whether the particular business need is common — if so, it’s likely that these particular and related needs have already been addressed.

For instance, if you work with data in the CSV format, you can look into the functionalities in the CSV module. Alternatively, the pandas library can handle CSV files gracefully. For another instance, if you want to count elements in a list, you should consider the Counter class in the collections module, which is designed specifically for these operations.

3『

[csv — CSV File Reading and Writing — Python 3.8.5 documentation](https://docs.python.org/3/library/csv.html)

[pandas - Python Data Analysis Library](https://pandas.pydata.org/)

』

## 02. Default Arguments

### 2.1 Relevant scenarios

When we first define a function, it usually serves one particular purpose. However, when you add more features to your project, you may realize that some closely related functions can be merged. The only difference is that the invocation of the merged function sometimes involves passing another argument or setting slightly different arguments. In this case, you can consider setting a default value to the argument.

The other common scenario is that when you declare a function, you already expect that your function serves multiple purposes, with function calls using differential parameters while some other parameters requiring few variations. You should consider setting a default value to the less varied argument.

### 2.2 Set default arguments

The benefit of setting default arguments is straightforward — you don’t need to deal with setting unnecessary arguments in most cases. However, the availability of keeping these parameters in your function signature allows you to use your functions more flexibly when you need to. For instance, for the built-in sorted() function, there are several ways to call the function, but in most cases, we just use the basic form: sorted(the\_iterable), which will sort the iterable in the ascending lexicographic order. However, when you want to change the ascending order or the default lexicographic order, we can override the default setting by specifying the reverse and key arguments.

We should apply the same practice to our own function declaration. In terms of what value we should set, the rule of thumb is you should choose the default value that is to be used for most function calls. Because this is an optional argument, you (or the users of your APIs) don’t want to set it in most situations. Consider the following example:

```py
# Set the price to the sale price or clearance sale with has addition discount
def set_regular_sale_price(price, discount):
    price *= discount
    return price


def set_clearance_sale_price(price, discount, additional_discount):
    sale_price = set_sale_price(price, discount)
    return sale_price * additional_discount


# A refactored combined function
def set_sale_price(price, discount, additional_discount=1):
    sale_price = price * discount
    return sale_price * additional_discount
```

### 2.3 Avoid the pitfalls of mutable default arguments

There is a catch for setting the default argument. If your argument is a mutable object, it’s important that you don’t set it using the default constructor — because functions are objects in Python and they’re created when they’re defined. The side effect is that the default argument is evaluated at the time of function declaration, so a default mutable object is created and becomes part of the function. Whenever you call the function using the default object, you’re essentially accessing the same mutable object associated with the function, although your intention may be having the function to create a brand new object for you. The following code snippet shows you the unwanted side effect of setting a default mutable argument:

```py
>>> def add_item_to_cart(new_item, shopper_name, existing_items=[]):
...     existing_items.append(new_item)
...     print(f"{shopper_name}'s cart has {existing_items}")
...     return existing_items
... 
... 
... shopping_list_wife = add_item_to_cart("Dress", "Jennifer")
... shopping_list_husband = add_item_to_cart("Soccer", "David")
... 
Jennifer's cart has ['Dress']
David's cart has ['Dress', 'Soccer']
```

As shown above, although we intended to create two distinct shopping lists, the second function call still accessed the same underlying object, which resulted in the Soccer item added to the same list object. To solve the problem, we should use the following implementation. Specifically, you should use None as the default value for a mutable argument:

```py
def add_item_to_cart(new_item, shopper_name, existing_items=None):
    if existing_items is None:
        existing_items = list()
    existing_items.append(new_item)
    print(f"{shopper_name}'s cart has {existing_items}")
    return existing_items
```

1『

自己的实现：

```py
def add_item_to_cart(new_item, shopper_name, existing_items=[]):
    existing_items.append(new_item)
    print(f"{shopper_name}'s cart has {existing_items}'")
    return existing_items

def add_item_to_cart_refactor(new_item, shopper_name, existing_items=None):
    if existing_items is None:
        existing_items = list()
    existing_items.append(new_item)
    print(f"{shopper_name}'s cart has {existing_items}'")
    return existing_items

if __name__ == "__main__":
    add_item_to_cart_refactor('Dress', 'Jennifer')
    add_item_to_cart_refactor('Soccer', 'David')
```

』

## 03. Consider Returning Multiple Values

### 3.1 Multiple values in a tuple

When your function performs complicated operations, the chances are that these operations can generate two or more objects, all of which are needed for your subsequent data processing. Theoretically, it’s possible that you can create a class to wrap these objects such that your function can return the class instance as its output. However, it’s possible in Python that a function can return multiple values. More precisely speaking, these multiple values are returned as a tuple object. The following code shows you a trivial example:

```py
>>> from statistics import mean, stdev
... 
... def evaluate_test_result(scores):
...     scores_mean = mean(scores)
...     scores_std = stdev(scores)
...     return scores_mean, scores_std
... 
... evaluation_result = evaluate_test_result([1, 1, 1, 2, 2, 2, 6, 6, 6])
... print(f"Evaluation Result ({type(evaluation_result)}): {evaluation_result}")
... 
Evaluation Result (<class 'tuple'>): (3, 2.29128784747792)
```

As shown above, the returned values are simply separated by a comma, which essentially creates a tuple object, as checked by the type() function.

1『大赞，原来 Python 能直接返回多个值，以元组的类型返回，试了下，返回 3 个数值的话，返回的是一个含有 3 个元素的元组。但目前还没遇到过该使用场景，它解决了什么问题？（2020-09-03）』

### 3.2 But no more than three

One thing to note is that although Python functions can return multiple values, you should not abuse this feature. One value (when a function doesn’t explicitly return anything, it actually returns None implicitly) is best — because everything is straightforward and most users usually expect a function to return only one value. In some cases, returning two values is fine, returning three values is probably still OK, but please don’t ever return four values. It can create a lot of confusion for the users over which are which. If it happens, this is a good indication that you should refactor your functions — your functions probably serve multiple purposes and you should create smaller ones with more dedicated responsibilities.

## 04. Use Try…Except

When you define functions as public APIs, you can’t always assume that the users set the desired parameters to the functions. Even if we use the functions ourselves, it’s possible that some parameters are created out of our control and they’re incompatible with our functions. In these cases, what should we do in our function declaration?

The first consideration is to use the try…except statement, which is the typical exception handling technique. You embed the code that can possibly go wrong (i.e., raise certain exceptions) in the try clause and the possible exceptions are handled in the except clause.

Let’s consider the following scenario. Suppose that the particular business need is that your function takes a file path and if the file exists and is read successfully, your function does some data processing operations with the file and returns the result, otherwise returns -1. There are multiple ways to implement this need. The code below shows you a possible solution:

```py
def get_data_from_file(filepath):
    try:
        with open(filepath) as file:
            computed_value = process_data(file)
    except Exception:
        return -1
    else:
        return computed_value

def process_data(file):
    # process the data
    return computed_value
```

In other words, if you expect that users of your functions can set some arguments that result in exceptions in your code, you can define functions that handle these possible exceptions. However, this should be communicated with the users clearly, unless it’s part of the feature as shown in the example (return -1 when the file can’t be read).

## 05. Consider Argument Validation

The previous function using the try…except statement is sometimes referred to as the EAFP (Easier to Ask Forgiveness than Permission) coding style. There is another coding style called LBYL (Look Before You Leap), which stresses the sanity check before running particular code blocks.

Following the previous example, in terms of applying LBYL to function declaration, the other consideration is to validate your function’s arguments. One common use case for argument validation is to check whether the argument is of the right data type. As we all know, Python is a dynamically-typed language, which doesn’t enforce type checking. For instance, your function’s arguments should be integers or floating-point numbers. However, calling the function by setting strings — the invocation itself — won’t prompt any error messages until the function is executed.

The following code shows how to validate the arguments before running the code:

```py
# Check type before running the code
def add_numbers(a, b):
    if not(isinstance(a, (float, int)) and isinstance(b, (float, int))):
        raise TypeError("Numbers are required.")
    return a + b
```

### Discussion: EAFP vs. LBYL

It should be noted that both EAFP and LBYL can be applied to more than just dealing with function arguments. They can be applied anywhere in your functions. Although EAFP is a preferred coding style in the Python world, depending on your use case, you should also consider using LBYL which can provide more user-friendly function-specific error messages than the generic built-in error messages you get with the EAFP style.

## 06. Consider Lambda Functions As Alternatives

### 6.1 Functions as parameters of other functions

Some functions can take another function (or are callable, in general terms) to perform particular operations. For instance, the sorted() function has the key argument that allows us to define more custom sorting behaviors. The following code snippet shows you a use case:

```py
>>> # A list of dictionary objects for sorting
>>> grades = [{'name': 'John', 'score': 97},
...           {'name': 'David', 'score': 96},
...           {'name': 'Jennifer', 'score': 98},
...           {'name': 'Ashley', 'score': 94}]
>>> def sorting_grade(x):
...     return x['score']
... 
>>> sorted(grades, key=sorting_grade)
[{'name': 'Ashley', 'score': 94}, {'name': 'David', 'score': 96}, {'name': 'John', 'score': 97}, {'name': 'Jennifer', 'score': 98}]
```

### 6.2 Lambda functions as alternatives

Notably, the sorting_grade function was used just once and it’s a simple function — in which case, we can consider using a lambda function.

If you’re not familiar with the lambda function, here’s a brief description. A lambda function is an anonymous function declared using the lambda keyword. It takes zero to more arguments and has one expression for applicable operations with the form: lambda arguments: expression. The following code shows you how we can use a lambda function in the sorted() function, which looks a little cleaner than the solution above:

```py
>>> sorted(grades, key=lambda x: x['score'])
[{'name': 'Ashley', 'score': 94}, {'name': 'David', 'score': 96}, {'name': 'John', 'score': 97}, {'name': 'Jennifer', 'score': 98}]
```

Another common use-case that’s relevant to many data scientists is the use of lambda functions when they work with the pandas library. The following code is a trivial example how a lambda function assists data manipulation using the map() function, which operates each item in a pandas Series object:

```py
>>> import pandas as pd
>>> interest_rates = pd.Series([0.023, 0.025, 0.037])
>>> interest_rates.map(lambda x: f"{x:.2%}")
0    2.30%
1    2.50%
2    3.70%
dtype: object
```

1『自己经常用 pandas 干类似上面的操作，只是大多数用的 apply 回调函数。』

## 07. Consider Decorators

### 7.1 Decorators

Decorators are functions that modify the behavior of other functions without affecting their core functionalities. In other words, they provide modifications to the decorated functions at the cosmetic level. If you don’t know too much about decorators, please feel free to refer to my earlier articles (1, 2, and 3). Here’s a trivial example of how decorators work in Python.

3『

[How to Write Python Decorators That Take Parameters | by Yong Cui, Ph.D. | Better Programming | Medium](https://medium.com/better-programming/how-to-write-python-decorators-that-take-parameters-b5a07d7fe393)

[Why You Should Wrap Decorators in Python | by Yong Cui, Ph.D. | Jul, 2020 | Towards Data Science](https://towardsdatascience.com/why-you-should-wrap-decorators-in-python-5ac3676835f9)

[Three Decorators Commonly Used in Python Custom Classes | by Yong Cui, Ph.D. | The Startup | Medium](https://medium.com/swlh/three-decorators-commonly-used-in-python-custom-classes-acc34a145dcf)

』

```py
>>> # Define a decorator function
... def echo_wrapper(func):
...     def wrapper(*args, **kwargs):
...         func(*args, **kwargs)
...         func(*args, **kwargs)
...     return wrapper
... 
>>> # Define a function that is decorated by echo_wrapper
... @echo_wrapper
... def say_hello():
...     print('Hello!')
... 
>>> # Call the decorated function
... say_hello()
Hello!
Hello!
```

As shown, the decorator function simply runs the decorated function twice. To use the decorator, we simply place the decorator function name above the decorated function with an @ prefix. As you can tell, the decorated function did get called twice.

1『上面的知识点没看懂。（2020-09-03）』

### 7.2 Use decorators in function declarations

For instance, one useful decorator is the property decorator that you can use in your custom class. The following code shows you how it works. In essence, the @property decorator converts an instance method to make it behave like a regular attribute, which allows the access of using the dot notation.

```py
>>> class Product:
...     def __init__(self, item_id, price):
...         self.item_id = item_id
...         self.price = price
... 
...     @property
...     def employee_price(self):
...         return self.price * 0.9
... 
>>> product = Product(12345, 100)
>>> product.employee_price
90.0
```

Another trivial use case of decorators is the time logging decorator, which can be particularly handy when the efficiency of your functions is of concern. The following code shows you such a usage:

```py
>>> from time import time
... 
... # Create the decorator function
... def logging_time(func):
...     def logged(*args, **kwargs):
...         start_time = time()
...         func(*args, **kwargs)
...         elapsed_time = time() - start_time
...         print(f"{func.__name__} time elapsed: {elapsed_time:.5f}")
... 
...     return logged
... 
... @logging_time
... def calculate_integer_sum(n):
...     return sum(range(n))
... 
... @logging_time
... def calculate_integer_square_sum(n):
...     return sum(x*x for x in range(n))
... 
>>> calculate_integer_sum(10000)
calculate_integer_sum time elapsed: 0.00027
>>> calculate_integer_square_sum(10000)
calculate_integer_square_sum time elapsed: 0.00110
```

## 08. Use \*args and \*\*kwargs — But Parsimoniously

In the previous section, you saw the use of \*args and \*\*kwargs in defining our decorator function, the use of which allows the decorator function to decorate any functions. In essence, we use \*args to capture all (or an undetermined number of, to be more general) position arguments while \*\*kwargs to capture all (or an undetermined number of, to be more general) keyword arguments. Specifically, position arguments are based on the positions of the arguments that are passed in the function call, while keyword arguments are based on setting parameters to specifically named function arguments.

If you’re unfamiliar with these terminologies, here’s a quick peek to the signature of the built-in sorted() function: sorted(iterable, *, key=None, reverse=False). The iterable argument is a position argument, while the key and reverse arguments are keyword arguments.

The major benefit of using \*args and \*\*kwargs is to make your function declaration looks clean, or less noisy for the same matter. The following example shows you a legitimate use of \*arg in function declaration, which allows your function to accept any number of position arguments.

```py
>>> # Define a function that accepts undetermined position arguments
>>> def stringify(*args):
...     return [str(x) for x in args]
... 
>>> stringify(2, False, None)
['2', 'False', 'None']
```

The following code shows you a legitimate use of \*\*kwargs in function declaration. Similarly, the function with \*\*kwargs allows the users to set any number of keyword arguments, to make your function more flexible.

```py
>>> # Define a function that accepts undetermined keyword arguments
... def generate_score_reports(name, **kwargs):
...     print(f"***** Report for {name} *****")
...     for key, value in kwargs.items():
...         print(f"### {key}: {value}")
...     print("***** Report End *****\n")
... 
... scores = {"John": {"math": 99, "phys": 97},
...           "Jan": {"math": 94, "bio": 98}}
... 
>>> for name, scores in scores.items():
...     generate_score_reports(name, **scores)
... 
***** Report for John *****
### math: 99
### phys: 97
***** Report End *****

***** Report for Jan *****
### math: 94
### bio: 98
***** Report End *****
```

However, in most cases, you don’t need to use \*args or \*\*kwargs. Although it can make your declaration a bit cleaner, it hides the function’s signature. In other words, the users of your functions have to figure out exactly what parameters your functions take. So my advice is to avoid using them if you don’t have to. For instance, can I use a dictionary argument to replace the \*\*kwargs? Similarly, can I use a list or tuple object to replace \*args? In most cases, these alternatives should work without any problems.

1『确实，个人也觉得用列表或字典传参进去就行了。』

## 09. Type Annotation for Arguments

As mentioned previously, Python is a dynamically-typed programming language as well as an interpreted language, the implication of which is that Python doesn’t check code validity, including type compatibility, during coding time. Until your code actually executes, will type incompatibility with your function (e.g., send a string to a function when an integer is expected) emerge.

For these reasons, Python doesn’t enforce the declaration of the type of input and output arguments. In other words, when you create your functions, you don’t need to specify what types of parameters they should have. However, it has become possible to do that in recent Python releases. The major benefit of having type annotation is that some IDEs (e.g., PyCharm or Visual Studio Code) could use the annotations to check the type compatibility for you, so that when you or other users use your functions you can get proper hints.

Another related benefit is that if the IDEs know the type of parameter, it can give proper auto-completion suggestions to help you code faster. Certainly, when you write docstrings for your functions, these type annotations will also be informative to the end developers of your code.

## 10. Responsible Documentation

I equate good documentation with responsible documentation. If your functions are for private uses, you don’t have to write very thorough documentation — you can make the assumption that your code tells the story clearly. If anywhere requires some clarification, you can write a very brief comment that can serve as a reminder for yourself or other readers when your code is revisited. Here, the discussion of responsible documentation is more concerned with the docstrings of your function as public APIs. The following aspects should be included:

1. A brief summary of the intended operation of your function. This should be very concise. In most cases, the summary shouldn’t be more than one sentence.

2. Input arguments: Type and explanation. You need to specify what type of your input arguments should be and what they can do by setting particular options.

3. Return Value: Type and explanation. Just as with input arguments, you need to specify the output of your function. If it doesn’t return anything, you can optionally specify None as the return value.

## Conclusions

If you’re experienced with coding, you’ll find out that most of your time is spent on writing and refactoring functions. After all, your data usually doesn’t change too much itself— it’s the functions that process and manipulate your data. If you think of data as the trunk of your body, functions are the arms and legs that move you around. So, we have to write good functions to make our programs agile.

I hope that this article has conveyed some useful information that you can use in your coding.