# SQL and Pandas: Where and how should these tools be used?

Kailey Smith

Mar 8, 2019 · 6 min read

[SQL and Pandas - Towards Data Science](https://towardsdatascience.com/sql-and-pandas-268f634a4f5d)

As I mentioned in my previous post, my technical experience has almost exclusively been in SQL. While SQL is awesome and can do some really cool things, it has its limitations — these limitations are in large part why I decided to acquire Data Science superpowers at Lambda School. In my previous data roles, I’ve needed to analyze data files from external sources and the tools I had access to either limited the amount of data it could process or took an exorbitant amount of time, making the task so mundane as to be almost impossible to complete thoroughly.

In all the positions I’ve held there has been a data pipeline that goes a little something like this:

![](./res/2020001.png)

We received data from an outside source which needed to be analyzed for quality and understanding of ETL requirements. We used excel to do this, but anyone who has tried to use excel for large files knows what a nightmare it is. So we’d write excel macros, but since each file is so different they weren’t always very helpful. We could have spent money on tools built for data analysis, but those cost money, and are a hard sell when those paying the bill don’t directly feel or understand the pain of the data life.

Enter: Python’s Pandas library. My mind was blown.

How could I not have known about this incredibly useful, FREE tool? It would have made my life so much easier! How, you ask? Well, let me tell you.

## 01. Pandas

Unlike SQL, Pandas has built-in functions that help when you don’t even know what the data looks like. This is especially useful when the data is already in a file format (.csv, .txt, .tsv, etc). Pandas also allows you to work on data sets without impacting database resources.

I’ll explain and show some examples of a few of the functions that I really like:

### pandas.read_csv()

First you need to pull the data into a dataframe. Once you’ve set it to a variable name (‘df’ below), you can use the other functions to analyze and manipulate the data. I used the ‘index_col’ parameter when loading the data into a dataframe. This parameter is setting the first column (index = 0) as the row labels for the dataframe. You can find other helpful parameters here. Sometimes you have play around with parameters before it’s in the correct format. This function won’t return an output if it is set to a variable, but once set you can use the next function to view the data.

```
# Command to import the pandas library to your notebook
import pandas as pd
# Read data from Titanic dataset.
df = pd.read_csv('...titanic.csv', index_col=0) 
# Location of file, can be url or local folder structure
```

### pandas.head()

The head function is really helpful in just previewing what the dataframe looks like after you have loaded it up. The default is to show the first 5 rows, but you can adjust that by typing .head(10).

    df.head(10)

First 5 rows of dataframe

This is a great place to start. We can see that there is a combination of strings, ints, floats, and that some columns have NaN values.

### pandas.info()

The info function will give a breakdown of the dataframe columns and how many non-null entries each have. It also tells you what the data type is for each column and how many total entries are in the dataframe.

    df.info()

### pandas.describe()

The describe function is really useful to see the distribution of your data, particularly numerical fields like ints and floats. As you can see below, it returns a dataframe with the mean, min, max, standard deviation, etc for each column. In order to see all columns, not just numeric, you’ll have to use the include parameter shown below. Notice that ‘unique’, ‘top’, and ‘freq’ have been added. These are only shown for non-numeric data types and NaN for numberic. The other breakdowns from above are NaN for these new columns.

```
df.describe()
df.describe(include='all')
```

### pandas.isna()

The isna function on it’s own isn’t particularly useful since it will return the whole dataframe with either False if the field is populated or True if it is a NaN or NULL value. If you include.sum() with isna(), then you’ll get an output like the one below with a count of NaN or NULL fields for each column.

    df.isna().sum()

### pandas.plot()

Pandas plot function is really useful to just get a quick visualization of your data. This function uses matplotlib for visualizations, so if you are familiar with that library, this will be easy to understand. You can find all the different parameters you can use for this function here.

    df.plot(x='age', y='fare', kind='scatter')

These are just some of the useful Pandas functions I’ve used for initial data analysis. There are many other functions for data analysis and manipulation that you can find here.

## 02. When to use SQL vs. Pandas

Which tool to use depends on where your data is, what you want to do with it, and what your own strengths are. If your data is already in a file format, there is no real need to use SQL for anything. If your data is coming from a database, then you should go through the following questions to understand how much you should use SQL.

### Questions to answer

How much access do you have to the DB?

If you only have access to write a query and someone else runs it for you, you won’t be able to really look at your data. This is a time where you should just pull all the data you think you might be needing and export into a csv to use pandas.

Another consideration: if a query you will need to run for your data is going to take up a lot of database resources and you know that your database admin wouldn’t allow it or like it, then just pull the data and do the work outside of the database with pandas. Avoid SELECT * in your queries, especially when you aren’t sure how much data could be in a table.

How are you wanting to transform/join your data?

If you already know some of the things you want to do with the data like filter out certain values, join to another table, combine certain fields in a calculation or concatenation, etc, it’s going to be easier to run SQL to pull the data as you want it and then export into a csv for any data analysis or data science work.

What are your strengths?

The biggest question is where your strengths are. If you feel more comfortable in one or the other, then stick with that language to do your data manipulation.

## To Summarize

Both of these tools are really useful. I recommend learning both. The combination will give you the ability to do a broad range of data analysis and manipulation efficiently. Soon, you won’t have to deal with Excel crashing on you anymore.

*Note: If you are working with really large data sets, you can use Dask which is built on Pandas specifically for big data. I may do a write-up on Dask basics in the future.
