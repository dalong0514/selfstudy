# Jupyter Superpower — Interactive Visualization Combo with Python

Nok

Mar 11, 2019 · 5 min read

[Jupyter Superpower — Interactive Visualization Combo with Python](https://towardsdatascience.com/jupyter-superpower-interactive-visualization-combo-with-python-ffc0adb37b7b)

## Introduction

altair is an interactive visualization library. It offers a more consistent API. This is how the authors describe the library.

Declarative statistical visualization library for Python

What does it mean is that it focuses on what to plot instead of how to plot, and you can easily combine different components like ggplot. Before I jump into the library, I want to quickly introduce two great tools that are useful for data exploratory. You can easily add more interactiveness to libraries like seaborn or matplotlib. Check out some simple examples on Github, I have included most of the example in the repository

ipywidgets

qgrid

altair

Ipywidgets

ipywidgets allows you to interact with Jupyter Notebook/Lab with your mouse, it makes Jupyter Notebook almost looks like a little app itself. You can add Slicer, Button, and Checkbox inside a notebook. Here are some nice projects that use ipywidgets.

https://www.hongkongfp.com/2019/01/21/hong-kong-nurses-protest-overcrowding-lack-resources-public-hospitals-health-chief-booed/

In response to Hong Kong overcrowding Hospital, I have made an example with Accident & Emergency (A&E) service waiting time. Here the plot shows the average waiting time by hospitals, while the ipywidgets here simply add a dropdown menu that you can change the color of the plot interactively.

Simple dropdown menu to interact with static plotting library

jupyter-widgets/ipyleaflet

A Jupyter - Leaflet.js bridge. Contribute to jupyter-widgets/ipyleaflet development by creating an account on GitHub.

github.com

jupyter-widgets/pythreejs

A Jupyter - Three.js bridge. Contribute to jupyter-widgets/pythreejs development by creating an account on GitHub.

github.com

qgrid

qgrid let you have an Excel-like table inside Jupyter Notebook/Lab, under the hood, it makes uses of ipywidgets. This is extremely useful when you are trying to understand your data, instead of typing a lot of code, you can sort your data with a click, filter some data temporarily with one click. It’s just awesome!

altair

altair has an example gallery that demonstrates a wide range of visualization that you can make.

Rich Example Gallery of altair

## 1. Interactive plotting

Upper left: Multiple Selection, Upper right: box style multiple selections, bottom left: single selection, bottom right: mouse hover single selection

altair offers a lot of choice for interactive plotting. The above gif gives you a sense of how easy it could be. With just 1 line of code, you can change the behavior of the chart. Interactiveness is crucial for data exploratory, as often you want to drill down on a certain subset of the data. Functions like cross-filtering are very common in Excel or Tableau.

## 2. Clean Syntax and Easy to Combine charts

The syntax is a bit like ggplot , where you create a Chart object and add encoding /color/scale on it.

If you have used matplotlib, you probably try to look up the doc a lot of times. altair make great use of symbol like + & | which are very intuitive when you want to combine different charts. For example, a|b mean stacking Chart aand Chart b horizontally. a+b mean overlay Chart b on Chart a.

The ability to overlay two charts is substantial, it allows us to plot two charts on the same graph without actually joining it.

Here is an example. I have two graphs created from 2 different datasets, while they are both connected to a selection filter with the hospital name. You can find my example here. Chart A shows historical average waiting Time by hours while Chart B shows the last 30 days average waiting Time by hours.

The bottom left chart is created simply using a+b, both chars are controlled by a filter in the upper left bar chart.

## 3. Export is easy

Often time you just want to share a graph. You just need to do Chart.save() and share the HTML directly with your colleague. The fact that it is just JSON and HTML also means that you could easily integrate it with your web front-end.

If you want a sophisticated dashboard with a lot of data, Tableau or tools like Dash (Plotly), Bokeh is still better at this point. I haven’t found a great solution to deal with large data with altair. I found it is most useful when you try to do interactive plotting no more than 4charts, where you have some cross-filtering, dropdown or highlights.

## Conclusion

These are the libraries that I tried to include in my workflow recently. Let me know what you feel and share the tools that you use. I think the interactive control of altair is the most interesting part, but it still has to catch up with other libraries in terms of functionalities and support more chart types.

I will try to experiment plotly + Dash to see if it is better. I have liked the API of altair so far but it may have less production-ready. Running altair data server may be a solution but I have not tried it yet.

Please give me a thumbs up if you think these tools are useful and don’t forget to give a star to the creators of these projects.

## Reference

https://www.youtube.com/watch?v=aRxahWy-ul8 (This is a really great talk from one of the altair author Brian Granger. I think altair is not just a visualization library, you can learn a lot from it’s API design as well)
