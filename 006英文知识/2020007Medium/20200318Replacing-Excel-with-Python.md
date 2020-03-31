# Replacing Excel with Python

Ankit Gandhi

Mar 5, 2019 · 10 min read

[Replacing Excel with Python - Towards Data Science](https://towardsdatascience.com/replacing-excel-with-python-30aa060d35e)

After spending almost a decade with my first love Excel, its time to move on and search for a better half who in thick and thin of my daily tasks is with me and is much better and faster and who can give me a cutting edge in the challenging technological times where new technology is getting ditched by something new at a very rapid pace. The idea is to replicate almost all excel functionalities in Python, be it using a simple filter or a complex task of creating an array of data from the rows and crunching them to get fancy results.

The approach followed here is to start from simple tasks and move to complex computational tasks. I will encourage you to please replicate the steps yourself for your better understanding.

The inspiration to create something like this came from the non-availability of a free tutorial which literally gives all. I heavily read and follow Python documentation and you will find a lot of inspiration from that site.

GitHub repo link: [ank0409/Ditching-Excel-for-Python: Functionalities in Excel translated to Python](https://github.com/ank0409/Ditching-Excel-for-Python)

### Importing Excel Files into a Pandas DataFrame

Initial step is to import excel files into DataFrame so we can perform all our tasks on it. I will be demonstrating the read_excel method of Pandas which supports xls and xlsx file extensions.

read_csv is same as using read_excel, we wont go in depth but I will share an example.

Though read_excel method includes million arguments but I will make you familiarise with the most common ones that will come very handy in day to day operations.

Though read_excel method includes million arguments but I will make you familiarise with the most common ones that will come very handy in day to day operations

I’ll be using the Iris sample dataset which is freely available online for educational purpose.

Please follow the below link to download the dataset and ensure to save it in the same folder where you are saving your python file

https://archive.ics.uci.edu/ml/datasets/iris

### The first step is to import necessary libraries in Python

We can import the spreadsheet data into Python using the following code:

pandas.read_excel(io, sheet_name=0, header=0, names=None, index_col=None, parse_cols=None, usecols=None, squeeze=False, dtype=None, engine=None, converters=None, true_values=None, false_values=None, skiprows=None, nrows=None, na_values=None, keep_default_na=True, verbose=False, parse_dates=False, date_parser=None, thousands=None, comment=None, skip_footer=0, skipfooter=0, convert_float=True, mangle_dupe_cols=True, **kwds)

Since there’s a plethora of arguments available, lets look at the most used one’s.

Important Pandas read_excel options.

If we are using the path for our local file by default its separated by「\」however python accepts「/」, so make to change the slashes or simply add the file in the same folder where your python file is. Should you require detailed explanation on the above, refer to the below medium article. https://medium.com/@ageitgey/python-3-quick-tip-the-easy-way-to-deal-with-file-paths-on-windows-mac-and-linux-11a072b58d5f

We can use Python to scan files in a directory and pick out the ones we want.

### Import a specific sheet

By default, the first sheet in the file is imported to the dataframe as it is.

Using the sheet_name argument we can explicitly mention the sheet that we want to import. Default value is 0 i.e. the first sheet in the file.

We can either mention the name of the sheet(s) or pass an integer value to refer to the index of the sheet


Using a column from the sheet as an Index


Unless explicitly mentioned, an index column is added to the DataFrame which by default starts from a 0.


Using the index_col argument we can manipulate the index column in our dataframe, if we set the value 0 from none, it will use the first column as our index.


Skip rows and columns


The default read_excel parameters assumes that the first row is a list of column names, which is incorporated automatically as column labels within the DataFrame.


Using the arguments like skiprows and header we can manipulate the behavior of the imported DataFrame.


Import specific column(s)


Using the usecols argument we can specify if we have import a specific column in our DataFrame


Its not the end of the features available however its a start and you can play around with them as per your requirements


Lets have a look at the data from 10,000 feet


As now we have our DataFrame, lets look at the data from multiple angles just to get a hang of it/


Pandas have plenty of functions available that we can use. We’ll use some of them to have a glimpse of our dataset.


「Head」to「Tail」:


To view the first or last five rows.


Default is five, however the argument allows us to use a specific number


View specific column’s data


Getting the name of all columns


Info Method


Gives the summary of DataFrame


Shape Method


Returns the dimensions of DataFrame


Look at the datatypes in DataFrame


Slice and Dice i.e. Excel filters


Descriptive reporting is all about data subsets and aggregations, the moment we are to understand our data a little bit we start using filters to look at the smaller sets of data or view a particular column maybe to have a better understanding.


Python offers a lot of different methods to slice and dice the DataFrames, we’ll play around with a couple of them to have an understanding of how it works


View a specific column


There exists three main methods to select columns:


Use dot notation: e.g. data.column_name


Use square braces and the name of the column:, e.g. data[‘column_name’]


Use numeric indexing and the iloc selector data.loc[:, ‘column_number’]


View multiple columns


View specific row’s data


The method used here is slicing using the loc function, where we can specify the start and end row separated by colon


Remember, index starts from a 0 and not 1


Slice rows and columns together


Filter data in a column


Filter multiple values


Filter multiple values using a list


Filter values NOT in list or not equal to in Excel


Filter using using multiple conditions in multiple columns


The input should always be a list


We can use this method to replicate advanced filter function in excel


Filter using numeric conditions


Replicate the custom filter in Excel


Combine two filters to get the result


Contains function in Excel


Get the unique values from DataFrame


If we want to view the entire DataFrame with the unique values, we can use the drop_duplicates method


Sort Values


Sort data by a certain column, by default the sorting is ascending


Statistical summary of data


DataFrame Describe method


Generate descriptive statistics that summarize the central tendency, dispersion and shape of a dataset’s distribution, excluding NaN values


Summary stats of character columns


Data Aggregation


Counting the unique values of a particular column


Resulting output is a Series. You can refer it as a Single column Pivot Table


Count cells


Count non-NA cells for each column or row


Sum


Summarising the data to get a snapshot of either by rows or columns


Replicates the method of adding a total column against each row


Add a total column to the existing dataset


Sum of specific columns, use the loc methods and pass the column names


Or, we can use the below method


Don’t like the new column, delete it using drop method


Adding sum-total beneath each column


A lot has been done above, the approach that we are using is:


Sum_Total: Do the sum of columns


T_Sum: Convert the series output to DataFrame and transpose


Re-index to add missing columns


Row_Total: append T_Sum to existing DataFrame


Sum based on criteria i.e. Sumif in Excel


Sumifs


Averageif


Max


Min


Groupby i.e. Subtotals in Excel


Pivot Tables in DataFrames i.e. Pivot Tables in Excel


Who doesn’t love a Pivot Table in Excel, its one the best ways to analyse your data, have a quick overview of the information, helps you slice and dice the data with a super easy interface, helps you plots graphs basis on the data, add calculative columns etc.


No, we wont have an interface to work, we’ll have to explicitly write the code to get the output, No, it wont generate charts for you, but I don’t think we can complete a tutorial without learning about the Pivot tables.


A simple Pivot table showing us the sum of SepalWidth in values, SepalLength in Row Column and Name in Column Labels


Lets see if we can complicate it a bit.


Blanks are now replaced with 0’s by using the fill_value argument


We can have individual calculations on values using dictionary method and can also have multiple calculations on values


If we use margins argument, we can have total row added


Vlookup

What a magical formula is vlookup in Excel, I think its the first thing that everyone wants to learn before learning how to even add. Looks fascinating when someone is applying vlookup, looks like magic when we get the output. Makes life easy. I can with very much confidence can say its the backbone of every data wrangling action performed on the spreadsheet.

Unfortunately we don’t have a vlookup function in Pandas!

Since we don’t have a「Vlookup」function in Pandas, Merge is used as an alternate which is same as SQL. There are a total of four merge options available:


‘left’ — Use the shared column from the left DataFrame and match to right DataFrame. Fill in any N/A as NaN


‘right’ — Use the shared column from the right DataFrame and match to left DataFrame. Fill in any N/A as NaN


‘inner’ — Only show data where the two shared columns overlap. Default method.


‘outer’ — Return all records when there is a match in either left or right DataFrame.


The above might not be the best example to support the concept, however the working is the same.

