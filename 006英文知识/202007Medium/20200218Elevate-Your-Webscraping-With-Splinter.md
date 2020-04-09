# Elevate Your Webscraping With Splinter

[Elevate Your Webscraping With Splinter - Towards Data Science](https://towardsdatascience.com/elevate-your-webscraping-with-splinter-a926eee7f7d9)

In a previous blog, I explored the basics of webscraping using a combination of two packages; Requests, which fetched a website’s HTML and BeautifulSoup4, which makes sense of that HTML.

These packages are a great introduction to webscraping, but Requests has limitations, especially when the site you want to scrape requires a lot of user interaction.

As a reminder — Requests is a Python package that takes a URL as an argument, and returns the HTML that is immediately available when that URL is first followed. Thus, if your target website only loads content after certain interactions (such as scrolling to the bottom of the page or clicking a button) then Requests isn’t going to be a suitable solution.

For the FPL project that I’m documenting in my ‘On Target’ series, I needed to scrape match data from the Premier League website’s results pages. These presented some challenges to Requests. For example, I wanted data from the ‘Line-ups’ and ‘Stats’ tabs on each match page, however, these do not load new webpages. Rather, they trigger JavaScript events that load new HTML within the same page.

I also wanted to scrape the match commentary, which can be accessed by scrolling down the page…

… but is only fully loaded when a user continues to scroll down (similar to ‘infinite scrolling’ sites such as Facebook and Reddit).

## 01. Scraping With Splinter

Instead of scraping with Requests, we can use a Python package called Splinter. Splinter is an abstraction layer on top of other browser automation tools such as Selenium, which keeps it nice and user friendly. Moreover, once we scrape the HTML with Splinter, BeautifulSoup4 can extract our data from it in exactly the same way that it would if we were using Requests.

To get started, we need to download the appropriate browser ‘driver’ for the browser we want to use. For Firefox, this means using Mozilla’s geckodriver (note — Splinter uses Firefox by default). If you’re using Chrome, then you need chromedriver. You will also need to pip install selenium using your machine’s terminal (full details on why are included in the Splinter documentation):

    $ [sudo] pip install selenium

3『[Chrome WebDriver — Splinter 0.13.0 documentation](https://splinter.readthedocs.io/en/latest/drivers/chrome.html)』

It’s also worth noting that the driver file itself (i.e. geckodriver or chromedriver) needs to be included in the root of your repo (this is not an obvious requirement in either the Splinter or Firefox documentation!)

Splinter works by instantiating a ‘browser’ object (it literally launches a new browser window on your desktop if you want it to). We can then interact with that browser by running methods on it in, say, Jupyter Notebook.

```
from splinter import Browser

#State the location of your driver
executable_path = {"executable_path": "/Users/Callum/Downloads/geckodriver"}
#Instantiate a browser object as follows...
#Pass 'headless=False' to make Firefox launch a visible window
browser = Browser("firefox", **executable_path, headless=False)
```

This launches an empty browser window. Note the orange striped address bar, which tells us that it’s being controlled by our Python file.

We can now control this browser with some Python commands. Firstly, let’s make it visit a webpage…

```
match_url = 'https://www.premierleague.com/match/46862'
browser.visit(match_url)
```

Looking at the browser window on our desktop, we can see that this has worked!

## 02. Interacting With Elements

Now we have the website loaded, let’s solve the two issues that Requests couldn’t handle. First, we wanted to click on the ‘Line-ups’ and ‘Stats’ tabs. To do this, we first need to see how these elements are referred to in the HTML. Right-click on the button, and select ‘Inspect Element’. We can find the appropriate HTML in the inspector.

So the button is an ordered list element \<li> with class “matchCentreSquadLabelContainer”.

Splinter can find this element with the .find_by_tag() method. We can then make it ‘click’ on this button with the .click() method.

```
target = ‘li[class="matchCentreSquadLabelContainer"]’
browser.find_by_tag(target).click()
```

Note — there are six different things that Splinter can use to find an element. These are fully documented here, but include the option to find by element ID, by CSS, or by value.

3『[Finding elements — Splinter 0.13.0 documentation](https://splinter.readthedocs.io/en/latest/finding.html)』

Now that the browser has ‘clicked’ on the tab that we wanted, we can use BeautifulSoup4 to get and store the HTML.

```
from bs4 import BeautifulSoup
html = BeautifulSoup(browser.html, 'html.parser')
```

We can then extract the text information that we want using the same techniques documented in my previous webscraping blog. Of course, if we also wanted to click on the ‘Stats’ tab, we do the same process — check how the tab is called using the Inspect Element tool, then pass this in a .find_by_tag() method, before using BeautifulSoup to extract the HTML.

## 03. Combating the Infinite Scroll Problem

Although Splinter’s Browser class doesn’t come with an in-built ‘scroll’ method, it has an arguably more powerful feature that lets us do this — namely, we can use the .execute_script() method to run JavaScript.

To make the browser scroll to the bottom of the currently loaded page, we use the JavaScript scrollTo() method. This takes x and y positions as its arguments, so to get to the end of the page we pass ‘document.body.scrollHeight’ as the y position (we don’t need to change the x position since we’re only scrolling in a vertical direction).

Thus, we run:

```
browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
```

It may be the case that we need to keep scrolling before everything we need has loaded. And since different matches will have different numbers of events, we will need to do different amounts of scrolling on each page. We thus need some kind of condition that tells our code to stop scrolling.

Happily, commentary on the Premier League website always starts with the phrase “Lineups are announced and players are warming up”.

Therefore, if the HTML that we scrape includes this phrase, then we know that we’ve got all the commentary we need and we can stop scrolling. This is a task that’s ripe for a ‘while loop’.

```
#Declare the JavaScript that scrolls to the end of the page...
scrollJS = "window.scrollTo(0, document.body.scrollHeight);"

#...and a variable that signifies the loop's end-condition
condition = "Lineups are announced and players are warming up."

#Instantiate a 'first_content' variable (an empty string for now)
first_content = ""

#Create a while loop that runs when 'first content'
#is not equal to our break condition
while first_content != condition:

    #Scroll to the bottom of the page
    browser.execute_script(scrollJS)
    
    #Use BS4 to get the HTML
    soup = BeautifulSoup(browser.html, 'html.parser')
    
    #Store the first line of commentary displayed on the page as-is
    first_content = soup.findAll('div',class_="innerContent")[-1].get_text()
    
    #Scroll down again, and run the loop again if we
    #haven't reached the line "Lineups are announced..."
    browser.execute_script(scrollJS)
    
#Store the soup that, thanks to the while loop, will
#definitely contain all of the commentary
HTML = soup
```

We can then refactor all of the above to create a function that will take in the URL for a match, and return all the HTML from the match commentary, as well as the data from the Line-up and Stats tabs. Thus, we can automate the scraping of all the match pages from the season so far. Of course, how we organise, store, and manipulate this data is another task entirely (and, indeed, the subject of another upcoming blog).

It’s also worth mentioning that this is very much the tip of the iceberg as far as Splinter functionality goes. Other interesting use cases include:

1. Entering text fields([Interacting with elements in the page — Splinter 0.13.0 documentation](https://splinter.readthedocs.io/en/latest/elements-in-the-page.html#interacting-with-forms))

2. Manipulating cookies([Cookies manipulation — Splinter 0.13.0 documentation](https://splinter.readthedocs.io/en/latest/cookies.html))

3. Taking screenshots([Take screenshot — Splinter 0.13.0 documentation](https://splinter.readthedocs.io/en/latest/screenshot.html))

4. Dragging and dropping elements([Mouse interactions — Splinter 0.13.0 documentation](https://splinter.readthedocs.io/en/latest/mouse-interaction.html#drag-and-drop))

5. And, of course, anything that you can do with standard JavaScript.

At any rate, Splinter is a great little Python package that will help you take your webscraping to the next level! Have a play around with it, and see what you think.

This is the latest post in my blog series ‘On Target’, in which I’ll be attempting to build out a model for ‘Moneyballing’ Fantasy Premier League. I’d love to hear any comments about the blog, or any of the concepts that the piece touches on. Feel free to leave a message below, or reach out to me through [(10) Callum Ballard | LinkedIn](https://www.linkedin.com/in/callum-ballard/).

2『LinkedIn 上已关注作者。作者 medium 上的博客地址：[Callum Ballard – Medium](https://medium.com/@callumballard)，尝试爬取里面的文章。』