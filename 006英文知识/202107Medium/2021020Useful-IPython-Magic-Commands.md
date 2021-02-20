# Useful IPython Magic Commands

Towards becoming a Jupyter Notebook power-user

Zolzaya Luvsandorj

[Useful IPython magic commands. Towards becoming a Jupyter Notebook… | by Zolzaya Luvsandorj | Feb, 2021 | Towards Data Science](https://towardsdatascience.com/useful-ipython-magic-commands-245e6c024711)

When using Jupyter Notebook with IPython kernel, IPython magic commands come in handy. These magic commands make it easier to complete certain tasks. You can think of them as an extra set of helpful syntax in addition to Python syntax. In this post, we will get familiar with a few useful magic commands that you could use in Jupyter Notebook.
Image for postImage for post
Photo by Ramón Salinero on Unsplash
IPython magic commands 💫
If you aren’t familiar with magic commands, it’s very likely that you may have been using some unknowingly. Does this syntax: %matplotlib inline look familiar to you? Probably, yes? %matplotlib is a IPython magic command. You see how this command start with %? This is a common characteristic of magic commands: they start with %. There are two kinds of magic commands:
line magic commands (start with %)
cell magic commands (start with %%)
For a line magic command, inputs are provided following the command in the same line. For a cell magic command, contents in the entire cell become its inputs. If you are not too sure what we mean by this, an example in section 3 will hopefully clarify.
Now we know a little bit about them, it’s time to explore a handful of useful magic commands and familiarise with their example usage! ✨
📍 1. Import code with %load
We can load code from an external source into a cell in Jupyter Notebook using this magic command. Here’s one useful application of this:
For most data science projects, you may find yourself importing the same set of libraries over and over again across different notebooks. To make this process quicker, we can prepare a standard setup script for a Jupyter Notebook and import this script at the beginning of each notebook to reduce the repetitive typing. Let’s look at an example to illustrate what we mean by this.
Image for post
Imagine that we are working in magic_commands.ipynb that is located in project1 folder and setup.py contained the following setup script:
# Contents in setup.py
# Data manipulation
import numpy as np
import pandas as pd
pd.options.display.max_columns=None
pd.options.display.float_format='{:.2f}'.format
# Visualisation
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(style='whitegrid', context='talk', palette='rainbow')
We could import the contents in setup.py with the following one liner without leaving the notebook:
%load setup.py
Image for postImage for post
Press Ctrl + Shift to run cell
As we can see from this example, when we run the command, it inserts the code from setup.py and comments itself. Since standard imports can be used across most projects, you may prefer to save the script in Desktop (the parent directory) and have a project specific setup in the project folder only when needed (for instance, NLP projects will need additional set of imports).
Image for post
If we wanted to load setup.py from the parent folder in the same notebook, we can update the file path to reflect the change:
%load ..\setup.py
Although this example case may seem trivial, it is a small change you could start practicing and it will hopefully inspire other applications.
Before we move on to the next command, it’s worth mentioning that while importing code from .py file is common, you can also import content from other files such as .txt and .md. In addition, you can also import code from URL like this:
%load https://gist.githubusercontent.com/zluvsand/74a6d88e401c4e3f76c2ae783a18689b/raw/5c9fd80a7bed839ba555bf4636e47572bd5c7e6d/pickle.py
📍 2. Save code with %%writefile
This command lets us do the opposite of the previous command. We can save code to an external source from a cell in Jupyter Notebook using this magic command. If we imagine ourselves still being inside magic_commands.ipynb, this is how we would create setup.py to Desktop without leaving the notebook:
%%writefile ..\setup.py
# Data manipulation
import numpy as np
import pandas as pd
pd.options.display.max_columns=None
pd.options.display.float_format='{:.2f}'.format
# Visualisation
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(style='whitegrid', context='talk', palette='rainbow')
This will create a setup.py file if doesn’t exist. Otherwise, it will overwrite the contents in the existing file.
📍 3. Time code with %timeit or %%timeit
There are often multiple ways to accomplish the same task. One important consideration when choosing between the options is speed. Or sometimes you just want to time your code to understand its performance. Whatever your use case might be, it’s useful to know how to time your code. Fortunately, timing code is easy with %[%]timeit.
Firstly, we will prepare some dummy data:
import numpy as np
np.random.seed(seed=123)
numbers = np.random.randint(100, size=1000000)
Let’s imagine we wanted to time this code: mean = np.mean(numbers). We can do so with the following one liner:
%timeit mean = np.mean(numbers)
Image for post
Output shows mean and standard deviation of the speed across multiple runs & loops. This is more rigorous way to time your code compared to timing based on a single run.
Now let’s understand the difference between %timeit and %%timeit (the following guideline is true for most line and cell magic commands):
◼ ️️To use %timeit, a line magic command, the code you want to time should consist of a single line and be written in the same line following the magic command. Although this is a good general rule, multiple lines is possible with tweaks according to the documentation (see documentation for details).
◼ To use %%timeit, a cell magic command, the code you want to time can consist of any number of lines and written in the next line(s) following the magic command.
Here’s the equivalent of the previous code using %%timeit:
%%timeit
mean = np.mean(numbers)
Image for post
It’s likely that the code you want to time will consist of multiple lines, in which case %%timeit will come in handy.
Here’s a quick quiz to test your understanding. What do you think is the difference between the outputs of the following two cells? Try to think of the answer before proceeding. 💭
##### Cell A start #####
%timeit mean = np.mean(numbers)
np.mean(numbers)
##### Cell A end #####
##### Cell B start #####
%%timeit 
mean = np.mean(numbers)
np.mean(numbers)
##### Cell B start #####
Here comes the answer. In cell A, first we time the first line of code: mean = np.mean(numbers) then we find the average whereas in cell B, we time two lines of code:
Image for post
You can see that cell B’s mean speed is about twice as cell A’s. This makes sense because we are essentially timing the same code twice (one with assignment and one without assignment) in cell B.
%[%]timeit automatically adjusts the number of loops depending on how long it takes to execute the code. This means that the longer the runtime, the less number of repetitions and vice versa so that it will always take about the same amount of time to time regardless of the complexity of the code. However, you can control the number of runs and loops by tweaking the optional arguments. Here’s an example:
%timeit -n500 -r5 np.mean(numbers)
Image for post
Here, we have specified 5 runs and 500 loops.
📍 4. Check session history with %history, %notebook, %recall
These sets of commands are very useful if you experimented with a bunch of things and it’s already starting to get messy so it’s hard to remember exactly what you did. We can check the history of commands we ran in the current session with %history. Of note, %hist can be used instead of %history.
Let’s imagine we started a new session in section 3. We can see session history with:
%history
Image for post
This is great but a little hard to see where one command ends and the other starts. Here’s how to check the history with each command numbered:
%history -n
Image for post
This is easier to work with. Now, let’s learn how to export the history. If we want to write the history to a file named history.py in the same directory as the notebook, then we could use:
%history -f history.py
If we want to write the history to a Jupyter Notebook called history.ipynb in the same directory as the current notebook, then we use %notebook:
%notebook history.ipynb
This will insert each command into a separate cell. Quite convenient isn’t it?
Sometimes, we may want to recall a section of commands from the history to tweak it or rerun it. In this case, we can use %recall. When using %recall, we need to pass the corresponding numbers for the section of commands from history like this example:
%recall 1-2
Image for postImage for post
The code above inserts first two commands from history into the next cell.
📍 5. Other magic commands
We have only covered a small subset of commands in this post. So in this section, I want to provide a simple guide on how to explore more magic commands on your own.
◼️ To see all available magic commands, run %lsmagic.
◼️ To access documentation for all commands, either check the documentation page or run %magic.
◼️ To access documentation of a magic command, you can run the magic command followed by ?. For example: %load?.
Lastly, try running the following one liner in your Jupyter Notebook:
%config MagicsManager
Image for post
If you get the same output, even if we don’t write % or %% at the beginning of a magic command, it will still be recognised. For instance, if you try running the following syntax, you will see the same output as before:
config MagicsManager
While I think it is a convenient feature, writing the prefix makes the code more readable as it’s easy to tell it’s a magic command by the prefix.
Voila❕ We have covered a few useful magic commands and you are equipped to explore more on your own.✨ As Stephen R Covey once said “to learn and not to do is really not to learn. To know and not to do is really not to know”, I hope you will practice these magic commands to consolidate what we have learned today.
Thank you for reading my post. If you are interested, here are links to some of my posts:
◼️ Introduction to Python Virtual Environment for Data Science
◼️ Introduction to Git for Data Science
◼️ Organise your Jupyter Notebook with these tips
◼️ Simple data visualisations in Python that you will find useful
◼️ 6 simple tips for prettier and customised plots in Seaborn (Python)
◼️️ 5 tips for pandas users
◼️️ Writing 5 common SQL queries in pandas