# My top 10 Python packages for data science

After making a leap from SAS to Python over 4 years ago, I never looked back.

Zeming Yu

Mar 25, 2019 · 4 min read

[My top 10 Python packages for data science - Towards Data Science](https://towardsdatascience.com/my-top-10-python-packages-for-data-science-2dee7f3dee94)

Over the last 4 years, I have transitioned from using SAS exclusively for all data processing and statistical modeling tasks to using Python for these tasks. One barrier I had to overcome was to keep discovering and learning to use all the great packages put together by the open-source community.

There are a lot of benefits of adopting these open source packages, including:

1. Everything is free

2. Most likely they are constantly being updated and improved

3. There’s a large community offering support to each other on websites like Stack Overflow

It does take some time to get familiar with these packages. However, if you are the kind of person who’s curious / excited about learning new things, you’ll actually enjoy the process.

Today I’m sharing my top 10 Python packages for data science, grouped by tasks. Hopefully, you find it useful!

## 01. Data processing

pandas

Developed by Wes McKinney more than a decade ago, this package offers powerful data processing capabilities. For people with a SAS background, it is a bit like SAS data steps. You can do sorting, merging, filtering, etc. The key difference is in pandas, you call a function to perform these tasks.

By the way, I was really amazed to know that Wes McKinney was able to develop pandas after only a few years of Python experience. Some people are just really gifted!

His book Python for Data Analysis is highly recommended if you are just starting out your Python data science journey.

numpy

Pandas builds on top of this package numpy. So when you will often rely on this package for basic data manipulations. For example, when you need to create a new column based on the age of the customer, you need to do something like:

    df['isRetired'] = np.where(df['age']>=65, 'yes', 'no')

qgrid

An amazing package that allows you to sort, filter, and edit DataFrames in Jupyter Notebooks.

## 02. Graphing

The next three packages are all to do with graphing — which is a key step in exploratory data analysis.

matplotlib

This package allows you to do all sorts of graphs. If you are using it in a Jupyter Notebook, remember to run this line of code to enable the display of the graphs:

    %matplotlib inline

seaborn

With the help of this package, you can make matplotlib graphs looking much more attractive.

plotly

Nowadays we come across interactive graphs everywhere. They really offer a much better user experience.

When we hover the mouse over a line plot we expect some text to pop up. When we select a line, we expect it to stand out from the other lines. Sometimes we would like to zoom into parts of the graph. These are the areas where interactive graphs shine.

plotly allows you to build interactive graphs easily with a Jupyter Notebook. Over time, I see a lot of potential in sending Jupyter Notebooks with beautiful plotly graphs to the stakeholders.

## 03. Modeling

statsmodels

This package allows you to build Generalized Linear Models (GLMs) which are still widely used by actuaries today.

It also offers time series analysis and other statistical modelling capabilities.

scikit-learn

This is the main machine learning package allowing you to complete most machine learning tasks, including classification, regression, clustering, and dimensionality reduction.

I also use model selection and pre-processing functions. From k-fold cross-validation to scaling data and encoding categorical features, it has so much to offer.

lightgbm

This is one of my favorite machine learning packages for Gradient Boost Machine (GBM). I gave a talk in the 2018 Data Analytics seminar about this package.

For a fraction of the time and effort needed to build GLMs, you could run a GBM, look at the importance matrix to find out the most important features for your model and have a good initial understanding of the problem. This can be a stand-alone step, or a quick first step before building a full GLM that’s more readily accepted by the stakeholders.

lime

Model interpretation still remains a challenge for machine learning models like GBM. When stakeholders don’t understand a model, they can’t trust it, and as a result, there’s no adoption.

However, I feel model interpretation packages like lime is starting to change this. It allows you to examine each model prediction and work out what’s driving the prediction.

## Conclusion

I’ve listed my top 10 packages. Have you come across any other useful packages? Please share your comments below.