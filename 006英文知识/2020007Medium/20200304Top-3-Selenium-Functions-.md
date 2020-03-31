# Top 3 Selenium Functions To Make Your Life Easier

Basic functions everyone should know about.

Lazar Gugleta

[Top 3 Selenium Functions To Make Your Life Easier - Towards Data Science](https://towardsdatascience.com/top-3-selenium-functions-to-make-your-life-easier-84b174d2a0fe)

In such a quick-paced world today, there are many things that we have to automate in order to be more productive or efficient although we sometimes don’t really feel like it. Imagine you have one task that takes you 2 hours to do, but you can make a tool that achieves that for you automatically in 30 seconds.

That is what Web Scraping is for. It is a term for getting the data from webpages and making it so that you do not have to move a finger! Get the data and then process it any way you want. That is why today I want to show you some of the top functions that Selenium, which is a library for Web Scraping, has to offer.

I have written articles about Selenium and Web Scraping before, so before you begin with these, I would recommend you read this article「[Everything About Web Scraping | Towards Data Science](https://towardsdatascience.com/everything-you-need-to-know-about-web-scraping-6541b241f27e)」, because of the setup process. And if you are already more advanced with Web Scraping, try my advanced scripts like「[How to Save Money with Python - Towards Data Science](https://towardsdatascience.com/how-to-save-money-with-python-8bfd7e627d13)」and「[How to make Analysis Tool with Python | Towards Data Science](https://towardsdatascience.com/how-to-make-an-analysis-tool-using-python-c3e4477b6d8)」.

Let’s just jump right into it!

## get()

The get command launches a new browser and opens the given URL in your Chrome Webdriver. It simply takes the string as your specified URL and opens it for testing purposes. If you are using Selenium IDE, it is similar to open command.

Example:

    driver.get("https://google.com");

The ‘driver’ is your Chrome Webdriver on which you are going to perform all actions and it looks like this after executing the command above:

## find\_element()

This function is crucial when you want to access elements on the page. Let’s say we want to access the「Google search」button in order to perform a search. There are many ways to access elements, but my preferred one is to find XPath of the element. XPath is the element's ultimate location on the web page.

By clicking F12 you will inspect the page and get the background information about the page you are at. By clicking the selection tool, you will be able to select elements. After finding the button, click on the right at the blue marked section and Copy element’s「Full Xpath」.

    self.driver.find_element_by_xpath('/html/body/div/div[4]/form/div[2]/div[1]/div[3]/center/input[1]')

That is the full command in order to find the specific element. I prefer full XPath over the regular XPath because regular one can be changed if the element in a new session changes and then next time you perform your script it does not work.

## send_keys() and click()

I added a bonus function for you so we can follow through with this example and make it fully work. Send_keys function is used for typing the text into a field to you selected by using the find\_element function. Let’s say we want to type「plate」into google and perform a search. We already have our「Google search」button, now we just need to type in the text and click the button with the help of click function.

```
google_tray = self.driver.find_element_by_xpath('/html/body/div/div[4]/form/div[2]/div[1]/div[1]/div/div[2]/input')
google_tray.send_keys("plate")
google_search = self.driver.find_element_by_xpath('/html/body/div/div[4]/form/div[2]/div[1]/div[3]/center/input[1]')
google_search.click()
```

I saved the elements in their respective variables and then performed functions on them for more clarity. At the end you end up with this:

Last words: As mentioned before, this is not my first time writing about Selenium and Web Scraping in general. There are many more functions I would love to cover and many more to come. In order to keep up, follow me for more!
