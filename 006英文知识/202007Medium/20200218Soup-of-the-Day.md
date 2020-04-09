# Soup of the Day

Webscraping With Beautiful Soup — A Beginner’s Guide

Callum Ballard

Jul 26, 2019 · 10 min read

[Soup of the Day - Towards Data Science](https://towardsdatascience.com/soup-of-the-day-97d71e6c07ec)

Though there are many thousands of lovely clean datasets available out there for a data scientist’s delectation (mostly on Kaggle), you’re always going to have those pesky hypotheses that stay out of their scope. Creating the dataset you do need from scratch is a potentially daunting prospect — even if you are able to see the data on a webpage, actually getting this into a format ready for analysis could involve a lot of manual work.

Happily, webscraping automates the process of retrieving information from webpages, and by using the right tools, we can create reliable stores of this data, which we can then analyse.

Note — this is the first in a series of posts. Here, we will cover the mechanics of webscraping Metacritic with the Beautiful Soup library, step by step. Subsequent blogs will dive into the analysis we conduct off the back of it.

## Step 1. Understanding Just Enough About HTML

HyperText Markup Language (HTML) is the code that tells a web browser what information to display on the page. Importantly, it does not say much about how that information should be displayed (websites typically combine two sets of code, HTML and Cascading Style Sheets (CSS) to render a page, with CSS responsible for its look and feel).

This is important, because it’s the webpage’s information that we are interested in, and we know that this information is going to be stored somewhere in the HTML code.

Helpfully, most browsers provide an easy way to see which bit of the HTML code refers to specific elements on the page.

The HTML code itself might look intimidating, but the structure is simpler than it seems. Content is typically contained within ‘tags’, tags being the things inside the \<> brackets. For example, when declaring a paragraph of text, the HTML code might look like this:

    <p>My text here, inside the paragraph tags</p>

HTML has different types of tags that do different things — the most common ones (as you can see in the screenshots above) tend to be:

Headers: \<h1> \</h1> (note, we can have h1, h2, … , h6, depending on the desired hierarchy of headers).

Ordered Lists: \<li> \</li>

Unordered Lists: \<ul> \</ul> (i.e. bullet point style lists)

Hyperlinks: \<a href= “EXAMPLE_URL”> </a>

Span: \<span> </span> (used to identify substrings within paragraphs — this is useful if you want your companion CSS code to format only certain words in a sentence)

Semantic Elements: \<div> \</div>

Note — Semantic Elements are a bit of a catch-all category, and ‘div’ is a term you’ll see a lot in many blocks of HTML. A typical use of these ‘div’ tags is to create ‘Sub-Elements’, which can contain lists, other headers, and further sub-elements.

It’s like the folder tree structure in your computer’s file explorer — the root ‘My Documents’ folder might contain documents and files, but it might also contain other folders. These folders may contain further folders in turn.

So if we want to isolate the ‘release date’ for a particular album on this Metacritic page, we can see that this is contained within several nested sub-elements. Ultimately, we can find the release date in the code itself.

As we can see, many tags also have other attributes to further differentiate themselves. These are typically labelled as the element’s ‘id’ or ‘class’. These will be crucial later, when we come to extract data from the HTML code.

## Step 2. Extracting HTML Into a Jupyter Notebook

We can see the HTML in the browser — now we need to get it into a Jupyter Notebook (or equivalent), so that we can analyse it. To do this, we use the python ‘Requests’ library. The syntax for Requests is quite straight forward. Let’s say we want to get the HTML from Metacritic that we looked at above. We can use the .get( ) method:

```
import requests
url = https://www.metacritic.com/browse/albums/artist/a?num_items=100
page = requests.get(url)
```

There are a few other useful methods we can now call on the ‘page’ variable. For example, we can check the status code.

    page.status_code

If this returns ‘200’, then we’re all good, though other status codes can indicate that we need to modify the initial ‘request’.

## Step 3. Reading the HTML Soup

Once we have the ‘request’ object (‘page’), we can use the html.parser feature in the Beautiful Soup library to make sense of its contents.

```
from bs4 import BeautifulSoup
soup = BeautifulSoup(page.content, ‘html.parser’)
```

If we actually call the ‘soup’ variable, however, we see that things are still a bit messy (certainly far from beautiful).

This output goes on for quite some time…

This is where the browser’s inspector comes in handy. Since we probably have a good idea as to what information we want to get from the page, we are able to find the corresponding HTML in the inspector.
So if I want to create a list of all the artist names on this page, I can ‘inspect element’ on the first such name, and see how the information is stored in the HTML.

We can see that the artist name ‘A Camp’, is stored in an ‘ordered list’ (denoted by \<li> tags), with the class “stat product_artist”. Given the structure of the site, we can guess that all the artist names are going to be stored in the same way (though we can of course check this by inspecting elements, as we did with ‘A Camp’).

We use Beautiful Soup’s .findAll( ) method to find all instances of ordered lists, with the class “stat product_artist”, specifying these two characteristics as separate arguments.

    artistHTML = soup.findAll(‘li’,class_=”stat product_artist”)

That this gives us an object that is of type ‘bs4.element.ResultSet’. Looking at this object more closely, we can see that this looks a little bit like a python list. In particular, we can index this ResultSet object to isolate the different artist names (we can use the ‘len’ function to check how many we have, in this case 99).

Note that these elements in the ‘bs4.element.ResultSet’ object, are themselves objects with type ‘bs4.element.tag’.

This means that they come with a some new methods, which can help us extract the information that we need.

We should note at this point — this was not the only way to get at the artist name information. We could have also gone a layer deeper in the HTML, and tried soup.findAll(‘span’, class_= “data”). However, this method adds a layer of complexity — it turns out that there are three different types of information about each album stored using such tags; artist name, release date, and metascore. This is manageable, but the approach described will probably turn out to be more straight forward.

## Step 4. Extracting Data From The HTML Tags

Getting at information stored in the tags (and ensuring that it’s returned to us in the right format) is not always the most straight forward task, and can require a bit of trial and error. There are a few different methods I tend to go to first.

.get_text( ) tends to be the most reliable. Sometimes we will need to make edits to the strings that it outputs to get them into the desired form. We should therefore try the method over different elements to ensure that we can make the same edit across all of them. We can see here that we need to get rid of the substrings either side of the artist name. We could use a regex method for this, however, we can be lazy and chain a couple of .replace( ) methods instead:

    artistHTML[0].get_text().replace(‘\n’, ‘’).replace(‘Artist:’, ‘’)

We can now iterate through the different elements in artistHTML, extract the artist names, and put them into a list. We can either do this using a loop:

```
artists = []
for element in artistHTML:
    artist = element.get_text()
    artist_final = artist.replace(‘\n’,’’).replace(‘Artist:’,’’)
    artists.append(artist_final)
```

… or a list comprehension, which I find to be much tidier:

```
artists = [element.get_text().replace(‘\n’,’’).replace(‘Artist:’,’’) for element in artistHTML]
```

These lists can then be stored as they are, or one can, for example, put them into a Pandas dataframe. As mentioned previously, there are many, many different methods for extracting data from the soup. As with most things ‘coding’, there is rarely one right way to do something — the Beautiful Soup documentation is a good place to see the different element methods in action.

## Step 5. Getting All The Data…

Once we have extracted all the data we want from a webpage. The next task, depending on the structure of the site, is to extract data from a new page.

If we wanted all of the artist names from Metacritic, for example, we would need to go to page 2, then page 3, and so on (and that’s just for the artists beginning with ‘A’!). Obviously, we would want such a process to be automated with code. There are a couple of ways of going about this.

### 1. Second Guessing the URL

The URL we just scraped was:

https://www.metacritic.com/browse/albums/artist/a?num_items=100&page=0

The if we follow the link to page 2, then to page 3, we see the URLs are:

https://www.metacritic.com/browse/albums/artist/a?num_items=100&page=1

https://www.metacritic.com/browse/albums/artist/a?num_items=100&page=2

Clearly, we have a pattern — the number at the end of the URL is the page number minus one. This means that we can quite simply loop through the URLs, scraping each in turn.

First, we need to establish how many pages there are for a given letter (there are 11 pages for artists beginning with ‘A’, but clearly there’ll be more or less for artists beginning with other letters).

Given that this number is displayed on the page itself, we can find it in the HTML. We can use the process described in steps 2, 3, and 4 to isolate this number, and assign it to a variable in python (let’s call it ‘pages’).

```
for page_number in range(pages):
    url = f'https://www.metacritic.com/browse/albums/artist/a?num_items=100&page={page_number}'
    page = requests.get(url)
# We then include the scraping code inside the loop, ensuring that data from each new URL is appended to data collected from the previous pages - either in lists, or Pandas dataframes
```

### 2. Finding the next URL in the HTML itself

Second guessing the URL is sufficient on sites that are nicely organised (like Metacritic), however for other less tidy sites this approach may not work. However, given that we have a ‘next’ page button on the page, we can find it, and its corresponding hyperlink, in the HTML.

Given we’re after a hyperlink, we should be on the lookout for \<a> tags. We can use the soup.findAll( ) method as in step 3. Note, even if there is only one such element, the findAll method is still a list-like object, which we need to index. Given that the URL is in the tag itself, it is unlikely that our trusty .get_text( ) method is going to work here. Instead, we can look at at the element’s attributes, using the ‘.attrs’ property.

```
Nexturl[0].attrs

Nexturl[0].attrs['href']

```

Note how the attrs object looks a lot like a dictionary. We can hence look up the desired value by using the ‘href’ key. We can then use an f string to output the full URL.

This URL can be passed into requests (see step 1), and the resulting page can be scraped. By including these lines of code as part of a loop, we can get our scraping code to go automatically through each page in turn.

Webscraping is an incredibly powerful technique, and a great string to any data scientist’s bow. The above guide is written to be a starting point, though there are many other complimentary techniques (and, indeed, other scraping libraries other than Beautiful Soup) out there.

Happy scraping!