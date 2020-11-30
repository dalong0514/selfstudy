# Turn your EBook to Text with Python In seconds

Zaza Zakaria

Oct 13, 2019·4 min read

[Turn your EBook to Text with Python In seconds | by Zaza Zakaria | Medium](https://medium.com/@zazazakaria18/turn-your-ebook-to-text-with-python-in-seconds-2a1e42804913)

[EbookLib · PyPI](https://pypi.org/project/EbookLib/)

First, let me tell you why would I upload an article to explain how to turn an Ebook to text. I mean when you think about a task like that in 2019, It should be a piece of cake, a matter of minutes. unfortunately, that wasn't the case for me, I was stuck on this basic task for hours trying to choose the best frameworks on the web. After a lot of confusing documentation & many Hours past;

“I wasted a whole week trying to convert an Epub file onto text, but you should not”

## First, let’s make it readable

I will be working with my EBook, you can get yours and get its path if you’re running locally If your working on Collab it will be easier just upload it and get its path. I will be working with the following packages, you better pip install them before starting.

```
!pip install ebooklib
!pip install BeautifulSoup4
```

## Getting the HTML out

I will be getting a path of the epub file, then I will turn it to a list of HTML, each HTML is a chapter (I believe). I believe it’s XHTML, but I’ve put its content in a file.txt, and I was able to open it in the browser and view the content, therefore I will keep calling it HTML during this project to simplify, “but it is NOT”. I used the ebooklib library to extract the HTML out of the epub file using the `item.get_content()`.

```py
import ebooklib
from ebooklib import epub
def epub2thtml(epub_path):
    book = epub.read_epub(epub_path)
    chapters = []
    for item in book.get_items():
        if item.get_type() == ebooklib.ITEM_DOCUMENT:
            chapters.append(item.get_content())
    return chapters
```

We got the HTML, now where is my text? Ok if you visualise the output, it is full of HTML bracket, It looks this:

```
[b’<?xml version=\’1.0\’ encoding=\’utf …
… <span class=”calibre5"><span class=”calibre6">The foreword by John Updike was originally published in</span></span>\n<span class=”calibre5"><span class=”italic”><span class=”calibre6">The New Yorker.</span></span></span></p>\n <p class=”calibre4">\n
/body>\n</html>\n']
```

my text is to be fed to a machine to learn from it, I don’t want it to get confused by these brackets, “I, myself was confused with these HTML brackets”.

So I will be using a very friendly framework, BeautifullSoup that is basically used to get content from the web and scrap it. I don’t have content on the web, but I do have its format! therefore, It should be just good.

```py
from bs4 import BeautifulSoup
```

To understand furthermore the use of beautiful soup check this article: [Extract text from a webpage using BeautifulSoup and Python | matix.io](https://matix.io/extract-text-from-webpage-using-beautifulsoup-and-python/).

Now first I should get the noise bracket out and choose the type of content I want, then I will scrape it all, put it in a text variable, apply it on every HTML of a chapter, an I will have a list of texts of each chapter.

First I define a blacklist of the type of brackets I don’t want in:

```py
blacklist = [   '[document]',   'noscript', 'header',   'html', 'meta', 'head','input', 'script',   ]
# there may be more elements you don't want, such as "style", etc.
```

Then I will define a function that turns a single HTML into a single text that is clean of the unwanted elements:

```py
def chap2text(chap):
    output = ''
    soup = BeautifulSoup(chap, 'html.parser')
    text = soup.find_all(text=True)
    for t in text:
        if t.parent.name not in blacklist:
            output += '{} '.format(t)
    return output
```

Now I will utilise the previous function to create another one that turns a list of HTML into a list of clean text

```py
def thtml2ttext(thtml):
    Output = []
    for html in thtml:
        text =  chap2text(html)
        Output.append(text)
    return Output
```

Finally, the function that takes the path to our Epub file, and gives as an output Its text :

```py
def epub2text(epub_path):
    chapters = epub2thtml(epub_path)
    ttext = thtml2ttext(chapters)
    return ttext
```

Done!

now the process finished let us see the result

```py
out=epub2text('/content/[Franz_Kafka,_John_Updike]_The_Complete_Stories(z-lib.org).epub')
```

Ok I have some “\n” noise but I need it to separate content, the first 2 lines mean nothing basically, but the rest is rich of content. so I might call it a Day.

feel free to ask me if you didn't understand a line, and feel free to contribute to my Github repository, that contains all the base code. Thank you for your time, leave a couple of claps if you liked it, comment if you think it can be improved.

This was my first article on medium so I hope you liked it.