# Web scraping in 5 minutes

How to build a basic web scraper from scratch

Gonzalo Ferreiro Volpi

[Web scraping in 5 minutes :) - Towards Data Science](https://towardsdatascience.com/web-scraping-in-5-minutes-1caceca13b6c)

## 01. Introduction

To naive people like me, doing some web scraping it’s the most similar thing we’re going to find to feel world-level hackers, extracting some secret information from the government system.

Laugh about it if you want, but web scraping can give you a dataset when you had nothing at all to work with. And of course, for most of the cases - we are going to talk about exceptions later…surprisingly, not everybody wants us sneaking around their webpage-, we can face the web-scraping-challenge by using just a few Python public libraries:

1. ‘requests’ calling ‘import requests’

2. ‘BeautifulSoup’ calling ‘from bs4 import BeautifulSoup’

3. We may also want to use also ‘tqdm\_notebook’ tool calling ‘from tqdm import tqdm\_notebook’ in case we need to iterate through a site with several pages. For example, suppose we’re trying to extract some information from all the job posts in https://indeed.co.uk after searching ‘data scientist’. We’ll probably have several result pages. The ‘bs4’ library will allow us to go all over them in a very simple way. We could do this also using just a simple for loop, but the ‘tqdm_notebook’ tool provides visualization about the evolution of the process, what meshes quite nicely if we’re scraping hundreds or thousands of pages from a site in one run.

But anyway, let’s go step by step. For this article, we’ll be scraping Penguin’s list of the 100 must-read classic books ([100 Must-Read Classic Books, As Chosen By Our Readers | Fiction, Novels & More](https://www.penguin.co.uk/articles/2018/100-must-read-classic-books/)). And we’ll try to get only the title and the author for each one of them. This simple notebook and others are available in my [gonzaferreiro/Simple_web_scraper](https://github.com/gonzaferreiro/Simple_web_scraper) (including the entire project about scraping indeed and running a classification model).

2『已经 forked 作者的源码「2020010Simple_web_scraper」。』

1『

因为网页刷不出来，试着输出内容，放到自己的服务器里看。

```
import requests 
from bs4 import BeautifulSoup
import re

url = 'https://www.penguin.co.uk/articles/2018/100-must-read-classic-books/'
r = requests.get(url)
soup = BeautifulSoup(r.text, 'html.parser')

## 试着输出内容，放到自己的服务器里看
with open('result.txt', 'w') as f:
    f.write(r.text)
```

』

## 02. Hands-on application

When we’re scraping a website, basically we’re making a request from Python and parsing through the HTML that is returned from each page. If you are wondering: what the hell is HTML? Or if you’re thinking: crap, I’m none web designer, I cannot deal with this! Don’t worry, you don’t need to know anything more than how to get the webpage HTML code and find whatever you are looking for. Remember, for the sake of this example, we’ll be looking for the title and author of each book:

We can access the webpage HTML code by doing:

Right-click > Inspect

Or either in Mac pressing Command+shift+c

A window should be opened to the right of your screen. Be sure to be standing on the ‘Elements’ tab in the upper tab of the window:

Just after opening this window, if you stand over any element of the webpage, the HTML code will move by its own until that specific section of the code. Look how if I move my pointer above the first book title (‘1. The Great Gatsby by F. Scott Fitzgerald’), the HTML highlights the elements belonging to that part of the webpage:

In this case, the text seems to be contained inside ‘\<div class=”cmp-text text”>’. The \<div> tag is nothing more than a container unit that encapsulates other page elements and divides the HTML document into sections. We may find our data under this or another tag. For example, the \<li> tag is used to represent an item in a list, and the \<h2> tag represents a level 2 heading in an HTML document (HTML includes 6 levels of headings, which are ranked by importance).

This is important to be understood because we’ll have to specify the tag under which our data is in order to be scrapped. But first, we’ll have to instantiate a ‘requests’ object. This will be a get, with the URL and optional parameters you’d like passed through the request.

```
url = ‘https://www.penguin.co.uk/articles/2018/100-must-read-classic-books/'
r = requests.get(url)
```

Now we made the request, we’ll have to create the BeautifulSoup object to pass our request text through its HTML parser:

    soup = BeautifulSoup(r.text,’html.parser’)

In this case, we didn’t have any special parameter in our URL. But let’s go back to our previous example of scraping Indeed.co.uk. In that scenario, as we mentioned before, we’d have to use tqdm_notebook. This tool works as a for loop iterating through the different pages:

```
for start in tqdm_notebook(range(0, 1000 10)):
    url = “https://www.indeed.co.uk/jobs?q=datascientist&start{}".format(start)
    r = requests.get(url)
    soup = BeautifulSoup(r.text,’html.parser’)
```

Pay attention to how we’re specifying to go from page 0 to 100, jumping from 10 to 10, and then inserting the ‘start’ parameter into the url by using start={}”.format(start). Amazing! We already have our HTML code in a nice format. Now let’s obtain our data! There are several ways of doing this, but for me, the neatest way is to write a simple function to be executed just after creating our BeautifulSoup object.

Previously we saw that our data (the title + author info) was in the following location: ‘\<div class=”cmp-text text”>’ . So what we’ll have to do is dismantle that code sequence, in order to find all the ‘cmp-text text’ elements in the code. For that, we’ll use our BeautifulSoup object:

    for book in soup.find_all('div', attrs={'class':'cmp-text text'})

In this way, our soup object will go through all the code, finding all the ‘cmp-text text’ elements and giving us the content of each one of them. A good idea to understand what we’re getting on each iteration is to print the text calling ‘book.text’. In this case, we’d see the following:

```
1. The Great Gatsby by F. Scott Fitzgerald

The greatest, most scathing dissection of the hollowness at the heart of the American dream. Hypnotic, tragic, both of its time and completely relevant.

Joe T, Twitter
```

What we can see here, is that the text under our ‘cmp-text text’ element contains the title + author, but also the brief description of the book. We can solve this in several ways. For the sake of this example, I used regex calling ‘import re’. Regex is a vast topic by its own, but in this case, I used a very simple tool that always comes in handy and you can learn easily.

    pattern = re.compile(r'(?<=. ).+(?=\n)')

Using our ‘re’ object, we can create a pattern using the regex lookahead and lookbehind tools. Specifying (?<=behind_text) we can look for whatever follows our ‘match\_text’. And with (?=ahead_text) we are indicating for anything followed by ‘match_text’, ’. Once regex found our code, we can tell it to give us anything that’s a number, only letters, special characters, some specific words or letter, or even a combination of all this. In our example, the ‘.+’ expression in the middle basically means ‘bring me anything’. So we’ll find everything in between ‘. ‘ (the point and the space after the book’s position in the list) and a ‘\n’, that’s a jump to the next line. Now we only have to pass our ‘re’ object the pattern, and the text:

    appender = re.findall(pattern,text)

This will give us a list, for example, with the following content:

    [‘The Great Gatsby by F. Scott Fitzgerald’]

Easy peasy to solve calling the text in the list and splitting it at ‘ by ‘, to after store title and author in different lists. Let’s put everything together now in a function as we said before:

```
def extract_books_from_result(soup):
    returner = {'books': [], 'authors': []}
    for book in soup.find_all('div', attrs={'class':'cmp-text text'}):
        try:
            text = book.text
            pattern = re.compile(r'(?<=. ).+(?=\n)')
            appender = re.findall(pattern,text)[0].split(' by')
            # Including a condition just to avoid anything that’s not a book Each book should consist in a list with two elements: 
            # [0] = title and [1] = author
            if len(appender) > 1:
                returner['books'].append(appender[0])
                returner['authors'].append(appender[1])
                
        except:
            None
            
    returner_df = pd.DataFrame(returner, columns=['books','authors']) 
    
    return returner_df
```
And finally, let’s run all together:

```
url = 'https://www.penguin.co.uk/articles/2018/100-must-read-classic-books/'
r = requests.get(url)
soup = BeautifulSoup(r.text,'html.parser')
results = extract_books_from_result(soup)
```

Congratulations! You’ve done your first scraping and you have all the data in a DataFrame. Now its up to you what you’ll we do with that ;).

Unfortunately, web scraping is not always that easy, since there are several web sites that don’t want us sneaking around. In some cases, they will have a very intricated HTML to avoid rookies, but in many, they will be blocking good people like us trying to obtain some decent data. There are several ways of not being detected, but sadly, this article has gone away from me and my promise of learning web scraping in five minutes. But don’t worry, I’ll be writing more about this in the near future.

Finally, remember: this simple notebook and others are available in my GitHub profile (including the entire project about scraping indeed and running a classification model). Also, don’t forget to check out my last article about 6 amateur mistakes I’ve made working with train-test splits and more in my writer profile in Towards Data Science. And if you liked this article, don’t forget to follow me, and if you want to receive my latest articles directly on your email, just subscribe to my newsletter :)

```
def extract_books_from_result(soup):
    returner = {'books': [], 'authors': []}
    for book in soup.find_all('div', attrs={'class':'cmp-text text'}):
        try:
            text = book.text
            pattern = re.compile(r'(?<=. ).+(?=\n)')
            appender = re.findall(pattern,text)[0].split(' by')
            
            if len(appender) > 1:
                returner['books'].append(appender[0])
                returner['authors'].append(appender[1])
                
        except:
            None
            
    returner_df = pd.DataFrame(returner, columns=['books','authors']) 
    
    return returner_df
    
url = 'https://www.penguin.co.uk/articles/2018/100-must-read-classic-books/'
r = requests.get(url)
soup = BeautifulSoup(r.text,'html.parser')
results = extract_books_from_result(soup)
```

1『直接把采集的数据写入 pandas 里的 DataFrame，这个思路值得借鉴。』