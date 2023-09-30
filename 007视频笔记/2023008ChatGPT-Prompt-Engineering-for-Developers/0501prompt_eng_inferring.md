This next video is on inferring. I like to think 
of these tasks where the model takes a text as input and 
performs some kind of analysis. So this could be extracting labels, 
extracting names, kind of understanding the 
sentiment of a text, that kind of thing. 
So if you want to extract a sentiment, positive or negative, 
of a piece of text, in the traditional 
machine learning workflow, you'd have to collect the label data set, train 
a model, figure out how to deploy the model somewhere in 
the cloud and make inferences. And that could work pretty well, but 
it was, you know, just a lot of work to 
go through that process. And also for every task, such 
as sentiment versus extracting names versus 
something else, you have to train and 
deploy a separate model. One of the really nice 
things about large language model is that for 
many tasks like these, you can just write a 
prompt and have it start generating results pretty 
much right away. And that gives tremendous speed in terms 
of application development. And you can also just use one model, one 
API to do many different tasks rather than 
needing to figure out how to train and deploy a lot of 
different models. And so with that, let's jump 
into the code to see how you can take advantage of this. So here's 
our usual starter code. I'll just run that. 
And the most fitting example I'm going to use is a review for a lamp. So, 
"Needed a nice lamp for the bedroom and this 
one had additional storage" and so on. 
So, let me write a prompt to classify the sentiment of this. 
And if I want the system to tell me, you know, what is the sentiment. 
I can just write, "What is the sentiment 
of the following product review" with the usual delimiter 
and the review text and so on and let's run that. 
And this says, "The sentiment of the 
product review is positive.", which is actually, 
seems pretty right. This lamp isn't perfect, but 
this customer seems pretty happy. Seems to be a great 
company that cares about the customers and products. I 
think positive sentiment seems to be the right answer. Now 
this prints out the entire sentence, "The sentiment of the product 
review is positive." 
If you wanted to give a more concise response to 
make it easier for post-processing, I can take this prompt 
and add another instruction to give you answers 
to a single word, either positive or negative. So 
it just prints out positive like this, which 
makes it easier for a piece of text to take this output 
and process it and do something with it. 
Let's look at another prompt, again still using the lamp review. 
Here, I have ,it "Identify a list of emotions that the writer of 
the following review is expressing. Include no more than 
five items in this list." 
So, large language models are pretty good at extracting 
specific things out of a piece of text. In this case, we're 
expressing the emotions and this could be useful for 
understanding how your customers think about 
a particular product. For a lot of customer support organizations, 
it's important to understand if a particular user is extremely upset. 
So, you might have a different classification problem like 
this, "Is the writer of the following 
review expressing anger?". Because if 
someone is really angry, it might merit paying extra 
attention to have a customer review, to have customer support or 
customer success, reach out to figure what's going on 
and make things right for the customer. In this case, 
the customer is not angry. And notice that 
with supervised learning, if I had 
wanted to build all of these classifiers, there's no way 
I would have been able to do this with 
supervised learning in the just a few minutes 
that you saw me do so in this video. I'd encourage you to pause 
this video and try changing some of these 
prompts. Maybe ask if the customer is expressing delight or ask if 
there are any missing parts and see if you can a prompt 
to make different inferences about this lamp review. 
 
Let me show some more things that you 
can do with this system, specifically extracting 
richer information from a customer review. 
So, information extraction is the part of NLP, 
of Natural Language Processing, that relates to taking 
a piece of text and extracting certain things 
that you want to know from the text. So in this prompt, I'm 
asking it to identify the following items, the 
item purchase, and the name of the company 
that made the item. Again, if you are trying to 
summarize many reviews from an online shopping e-commerce website, 
it might be useful for your large collection of reviews 
to figure out what were the items, who made 
the item, figure out positive and negative 
sentiment, to track trends about positive or negative sentiment 
for specific items or for specific 
manufacturers. And in this example, I'm going to 
ask it to format your response as a JSON object with "Item" and "Brand" as 
the keys. And so if I do that, it says the 
item is a lamp, the brand is Lumina, and you can easily load this 
into the Python dictionary to then do additional processing 
on this output. In the examples we've gone through, you 
saw how to write a prompt to recognize 
the sentiment, figure out if someone is angry, and then also extract 
the item and the brand. 
One way to extract all of this information 
would be to use three or four prompts and call "get_completion", 
you know, three times or four times 
to extract these different views one at a time. But 
it turns out you can actually write a 
single prompt to extract all of this information 
at the same time. So let's say "identify the 
following items, extract sentiment, is the 
reviewer expressing anger, item purchased, company that 
made it". And then here I'm also going 
to tell it to format the anger value as a 
boolean value, and let me run that. And this outputs 
a JSON where sentiment is positive, anger, and then 
no quotes around false because it asked it to 
just output it as a boolean value. Extracted the item as "lamp with additional 
storage" instead of lamp, seems okay. 
But this way you can extract multiple fields 
out of a piece of text with just a single prompt. 
And, as usual, please feel free to pause the video and play 
with different variations on this yourself. 
Or maybe even try typing in a totally 
different review to see if you can still 
extract these things accurately. Now, one of the cool applications I've 
seen of large language models is inferring topics. Given 
a long piece of text, you know, what 
is this piece of text about? What are the topics? Here's a 
fictitious newspaper article about how government workers feel 
about the agency they work for. So, the recent 
survey conducted by government, you know, and so 
on. "Results revealed that NASA was a popular department with a high 
satisfaction rating." I am a fan of NASA, I love 
the work they do, but this is a fictitious article. And so, 
given an article like this, we can ask it, with this prompt, to determine 
five topics that are being discussed in the 
following text. 
Let's make each item one or two words long, for 
my response, in a comma-separated list. And so, if we 
run that, you know, we get this article. It's about a 
government survey, it's about job satisfaction, it's about NASA, and so 
on. So, overall, I think, pretty nice extraction of a 
list of topics. And, of course, you can also, you know, 
split it so you get a Python list with the five topics that 
this article was about. 
And if you have a collection of articles and extract 
topics, you can then also use a large language 
model to help you index into different topics. So, 
let me use a slightly different topic list. Let's 
say that we're a news website or something, and, you know, 
these are the topics we track. "NASA, local 
government, engineering, employee satisfaction, federal government". 
And let's say you want to figure out, given a news 
article, which of these topics are covered in that 
news article. 
So, here's a prompt that I can use. 
I'm going to say, determine whether each item in 
the final list of topics is a topic in the text below. 
Give your answer as a list of 0 or 1 for each topic. 
And so, great. So, this is the same story text as before. 
So, this thing is a story. It is about NASA. It's 
not about local government. It's not about engineering. It is 
about employee satisfaction, and it is about federal government. So, with 
this, in machine learning, this is sometimes called a "Zero-Shot Learning Algorithm", 
because we didn't give it any training data that was 
labeled, so that's Zero-Shot. And with just a prompt, it 
was able to determine which of these topics are covered in that news article. 
And so, if you want to generate a 
news alert, say, so that process news, and I really like a lot 
of work that NASA does. So, if you want to build a 
system that can take this, put this information into a dictionary, 
and whenever NASA news pops up, print "ALERT: New NASA story!", they 
can use this to very quickly take any article, figure 
out what topics it is about, and if the topic includes NASA, 
have it print out "ALERT: New NASA story!". Oh, just one 
thing. I use this topic dictionary down here. This prompt that I use up 
here isn't very robust. If I wanted a production system, I 
would probably have it output the answer in JSON format, rather 
than as a list, because the output of the large language 
model can be a little bit inconsistent. So, this is actually a 
pretty brittle piece of code. But if 
you want, when you're done watching this video, feel free to 
see if you can figure out how to modify this prompt, to have 
it output JSON instead of a list like this, and then 
have a more robust way to tell if a particular article is a story 
about NASA. 
So, that's it for inferring. And in just a few minutes, you 
can build multiple systems for making inferences about text 
that previously just would have taken days or even 
weeks for a skilled machine learning developer. And so, I 
find this very exciting that both for skilled 
machine learning developers, as well as for people that 
are newer to machine learning, you can now use prompting to very 
quickly build and start making inferences on pretty complicated 
natural language processing tasks like these. In 
the next video, we'll continue to talk about exciting things you 
could do with large language models, and we'll go on 
to "Transforming". How can you take one piece of text and transform it 
into a different piece of text, such as translate 
it to a different language. Let's go on to 
the next video. 
