## Object-Oriented Programming (OOP) in Python

Demystifying classes, objects, inheritance, and more

Sarah Beshr

### Conclusion

To sum up, we covered what OOP, classes, and objects are. We also covered the difference between instance methods as well as class methods and we did the same for instance attributes as well as class attributes. We also briefly covered what class inheritance is and what some of the best practices are when working with classes.

With this, we round up our guide. I hope that you found this article insightful! If you did, then you might find these interesting as well. As always, I would love to hear any comments or questions that you may have. Happy learning!

### 01. What is OOP?

Object-oriented programming is a method of organizing a program by grouping related properties and behaviors into individual objects. The basic building blocks of OOP are objects and classes.

A class is a code template for creating objects, we can think of it as a blueprint. It describes the possible states and behaviors that every object of a certain type could have. For instance, if we say that "every employee will have a name and salary, and can be given a raise", then we just defined a class!

An object is a data structure storing information about the state and behavior of a certain entity and is an instance of a class. For example, an object representing an employee can have certain attributes such as salary and position associated with them, and behaviors like being given a raise.

Object = state + behavior

Information regarding the state of an object is contained in attributes and behavior information in methods. Further, object attributes, or states, are represented by variables — like numbers, or strings, or tuples. Whereas object methods, or behaviors, are represented by functions.

The distinctive feature of OOP is that state and behavior are bundled together. This means that instead of thinking of employee data separately from employee actions, for instance, we think of them as one unit representing an employee. This is called encapsulation and is one of the core tenets of object-oriented programming.

### 02. Defining a Class

As we said earlier, classes are blueprints for creating objects. Now, let's bring our first blueprint to life.

```py
class Employee:
   pass
```

The Employee class doesn't have a lot of functionality right now. We'll start off by adding some properties that all Employee objects should have. To keep things simple, we'll just add name and salary attributes.

#### 2.1 Assigning attributes to a class

The properties that all Employee objects must have are defined in a method called `.__init__()`, or the constructor method. Every time a new Employee object is created, the constructor method is automatically called.

Let's update the Employee class with an `.__init__()` method that creates `.name` and `.salary` attributes:

```py
class Employee:
    def __init__(self, name, salary=0):
        self.name = name
        self.salary = salary
```

Note that self is used as the 1st argument in any method definition, including our constructor method. Also, self.name = name creates an attribute called name and assigns to it the value of the name parameter. The same happens for the salary attribute, except we set the default salary to 0.

#### 2.2 Instance attributes vs. class attributes

Attributes created in `.__init__()` are called instance attributes. An instance attribute's value is specific to a particular instance of the class. All Employee objects have a name and a salary, but the values for the name and salary attributes will vary depending on the Employee instance.

On the other hand, class attributes are attributes that have the same value for all class instances. You can define a class attribute by assigning a value to a variable name outside of `.__init__()` as follows:

```py
class Employee:
   # Class attribute
   organization = "xxx"
    def __init__(self, name, salary=0):
        self.name = name
        self.salary = salary
```

To sum up, class attributes are used to define characteristics that should have the same value for every class instance, while instance attributes are used to define properties that differ from one instance to another.

### 03. Assigning Methods To a Class

#### 3.1 Instance methods

These are functions that are defined inside a class and can only be called from an instance of that class. Just like the constructor method, an instance method's first parameter is always self. Let's demonstrate how we can write an instance method by building upon our Employee class example from earlier.

```py
class Employee:
   organization = "xxx"
   def __init__(self, name, salary=0):
        self.name = name
        self.salary = salary
    #Instance method
    def give_raise(self, amount):
        self.salary += amount
        return f"{self.name} has been given a {amount} raise"
```

As you can see, instance methods are similar to regular functions with the difference of having self as the first parameter.

#### 3.2 Class methods

A class method is a method that is bound to the class and not the object of the class. They have the access to the state of the class as it takes a class parameter, instead of the typical self, that points to the class and not the object instance.

To define a class method, you start with a classmethod decorator, followed by a method definition. The only difference is that now the first argument is not self, but cls, referring to the class, just like the self argument was a reference to a particular instance. Then you write it as any other function, keeping in mind that you can't refer to any instance attributes in that method.

Because the class method only has access to this cls argument, it can't modify the object instance state. That would require access to self. However, class methods can still modify the class state that applies across all instances of the class.

```py
class MyClass:
   # instance method 
   def method(self):
        return 'instance method called', self

    @classmethod
    def classmethod(cls):
        return 'class method called', cls
```

The idea of the class method is very similar to the instance method, the only difference being that instead of passing the instance as a first parameter, we're now passing the class itself as a first parameter. Since we're passing only a class to the method, no instance is involved. This means that we don't need an instance at all and we call the class method as if it was a static function:

```py
MyClass.classmethod()
```

Whereas if we wanted to call the instance method we'd do have to instantiate an object first and then call the function as follows:

```py
object = MyClass()
object.method()
```

If you're unsure about what instantiating an object means, we'll be covering this next.

### 04. Instantiate an Object

Creating a new object from a class is called instantiating an object. We can instantiate new Employee objects with the below attributes as such:

```py
e1 = Employee("yyy", 5000)
e2 = Employee("zzz", 8000)
```

You can access the attributes using dot notation as follows:

```py
# access first employee's name attribute
e1.name

# access second employee's salary attribute
e2.salary
```

### 05. Class Inheritance

Class inheritance is the mechanism by which one class takes on the attributes and methods of another. Newly formed classes are called child classes, and the classes that child classes are derived from are called parent classes. A child class has all of the parent data.

Parent classes' attributes and methods can be overridden or extended by child classes. In other words, child classes inherit all of their parent's attribites and methods, but they can also define their own attributes and methods.

Declaring a child class that inherits from a parent class is very straightforward.

```py
class Manager(Employee):
   pass
```

Now, we can create a Manager object even though we didn't define a constructor.

```py
m1 = Manager("aaa", 13000)
```

#### 5.1 Customizing functionality via inheritance

Say we want to add extra attributes to our child class. We can easily do this by customizing constructors specifically for our child class and calling the constructor of the parent class.

```py
class Manager(Employee):
   def __init__(self, name, salary=0, department):
        Employee.__init__(self, name, salary=0)
        self.department = department
```

### 06. Best Practices

There are a few guidelines to keep in mind when working with classes and objects.

1 To name your classes, use camel case, which means that if your class name contains several words, they should be written without delimiters, and each word should start with a capital letter.

2 For methods and attributes, it's the opposite — words should be separated by underscores and start with lowercase letters.

3 The name "self" is a convention. You could actually use any name for the first variable of a method, it will always be treated as the object reference regardless. Although this is the case, it's always best to stick to using self.

4 Don't forget to write docstrings for your classes so that your code is more understandable to potential collaborators and future you.