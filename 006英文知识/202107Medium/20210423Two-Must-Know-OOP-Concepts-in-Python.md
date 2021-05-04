# 2 Must-Know OOP Concepts in Python

Inheritance and Polymorphism

Soner Yıldırım

2 days ago·4 min read

[2 Must-Know OOP Concepts in Python | by Soner Yıldırım | Apr, 2021 | Towards Data Science](https://towardsdatascience.com/2-must-know-oop-concepts-in-python-48d643a7385)

Object oriented programming (OOP) paradigm is built around the idea of having objects that belong to a particular type. In a sense, the type is what explains us the object.

Everything in Python is an object and every object has a type. These types are declared and defined using classes. Thus, classes can be considered as the heart of OOP.

In order to develop robust and well-designed software products with Python, it is essential to obtain a comprehensive understanding of OOP. In this article, we will elaborate on two key concepts of OOP which are inheritance and polymorphism.
Both inheritance and polymorphism are key ingredients for designing robust, flexible, and easy-to-maintain software. These concepts are best explained via examples. Let's start with creating a simple class.

```py
class Employee():
   def __init__(self, emp_id, salary):
      self.emp_id = emp_id
      self.salary = salary
  def give_raise(self):
      self.salary = self.salary * 1.05
```

We have created a class called Employee. It has two data attributes which are employee id (`emp_id`) and salary. We have also defined a method called `give_raise`. It applies a 5-percent increase on the salary of an employee.

We can create an instance of the Employee class (i.e. an object with Employee type) and apply the `give_raise` method as follows:

```
emp1 = Employee(1001, 56000)
print(emp1.salary)
56000
emp1.give_raise()
print(emp1.salary)
58800.0
```

OOP allows us to create a class based on another class. For instance, we can create the Manager class based on the Employee class.

```py
class Manager(Employee):
   pass
```

In this scenario, Manager is said to be a child class of the Employee class. The child class copies the attributes (both data and procedural) from the parent class. This concept is called inheritance.

It is important to note that inheritance does not mean copying a class. We can partially inherit from a parent (or base class). Python also allows for adding new attributes as well as modifying the existing ones. Thus, inheritance comes with a great deal of flexibility.

We can now create a manager object just like we create an employee object.

```py
mgr1 = Manager(101, 75000)
print(mgr1.salary)
75000
```

A child class can have new attributes in addition to the ones inherited from the parent class. Furthermore, we have the option to modify or override the inherited attributes.

Let's update the `give_raise` method so that it applies a 10-percent increase for the managers.

```py
class Manager(Employee):
   def give_raise(self):
      self.salary = self.salary * 1.10
```

```
mgr1 = Manager(101, 75000)
print(mgr1.salary)
75000
mgr1.give_raise()
print(mgr1.salary)
82500
```

We will create another child class of the Employee class. The Director class inherits the attributes from the Employee class and modifies the `give_raise` method with a 20-percent increase.

```py
class Director(Employee):
   def give_raise(self):
     self.salary = self.salary * 1.20
```

We now have three different class and they all have a `give_raise` method. Although the name of the method is the same, it behaves differently for different type of objects. This is an example of polymorphism.

Polymorphism allows for leveraging the same interface for different underlying operations. Regarding our example of manager and director objects, we can use them as they were an instance of the employee class. Let's see polymorphism in action. We will define a function that applies raise to a list of employees.

```py
def bulk_raise(list_of_emps):
   for emp in list_of_emps:
      emp.give_raise()
```

The `bulk_raise` function takes a list of employees and apply the `give_raise` function to each object in the list. The next step is to create a list of employees of different types.

```
emp1 = Employee(101, 45000)
emp2 = Manager(103, 60000)
emp3 = Director(105, 70000)
list_of_emps = [emp1, emp2, emp3]
```

Our list contains one employee, one manager, and one director objects. We can now call the `bulk_raise` function.

```
bulk_raise(list_of_emps)
print(emp1.salary)
47250.0
print(emp2.salary)
66000.0
print(emp3.salary)
84000.0
```

Although each object in the list has a different type, we do not have to explicitly state it in our function. Python knows which `give_raise` method to apply. As we see in the examples, polymorphism is accomplished using inheritance. Subclasses (or child classes) make use of the methods from the parent class to establish polymorphism.

1-3『又想到那句金句：面向对象，从下往上看是继承，从上往下看是多态。（2021-04-23）』

## Conclusion

Both inheritance and polymorphism are fundamental concepts of object oriented programming. These concepts help us to create code that can be extended and easily maintainable.

Inheritance is a great way to eliminate unnecessary repetitive code. A child class can inherit from the parent class partially or entirely. Python is quite flexible with regards to inheritance. We can add new attributes and methods as well as modify the existing ones.

Polymorphism contributes to Python's flexibility as well. An object with a particular type can be used as if it belonged to a different type. We have seen an example of it with the `give_raise` method.
