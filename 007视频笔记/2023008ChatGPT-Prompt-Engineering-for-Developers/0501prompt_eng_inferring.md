## 0501. prompt_eng_inferring

This next video is on inferring. I like to think of these tasks where the model takes a text as input and performs some kind of analysis. So this could be extracting labels, extracting names, kind of understanding the sentiment of a text, that kind of thing. 

So if you want to extract a sentiment, positive or negative, of a piece of text, in the traditional machine learning workflow, you'd have to collect the label data set, train a model, figure out how to deploy the model somewhere in the cloud and make inferences. 

And that could work pretty well, but it was, you know, just a lot of work to go through that process. And also for every task, such as sentiment versus extracting names versus something else, you have to train and deploy a separate model. One of the really nice things about large language model is that for many tasks like these, you can just write a prompt and have it start generating results pretty much right away. 

And that gives tremendous speed in terms of application development. And you can also just use one model, one API to do many different tasks rather than needing to figure out how to train and deploy a lot of different models. And so with that, let's jump into the code to see how you can take advantage of this. 

So here's our usual starter code. I'll just run that. 

And the most fitting example I'm going to use is a review for a lamp. So, "Needed a nice lamp for the bedroom and this 
one had additional storage" and so on. 

So, let me write a prompt to classify the sentiment of this. And if I want the system to tell me, you know, what is the sentiment. 

I can just write, "What is the sentiment of the following product review" with the usual delimiter and the review text and so on and let's run that. 

And this says, "The sentiment of the product review is positive.", which is actually, seems pretty right. This lamp isn't perfect, but this customer seems pretty happy. Seems to be a great company that cares about the customers and products. I think positive sentiment seems to be the right answer. 

Now this prints out the entire sentence, "The sentiment of the product review is positive." 

If you wanted to give a more concise response to make it easier for post-processing, I can take this prompt and add another instruction to give you answers to a single word, either positive or negative. So it just prints out positive like this, which makes it easier for a piece of text to take this output and process it and do something with it. 

Let's look at another prompt, again still using the lamp review. Here, I have ,it "Identify a list of emotions that the writer of the following review is expressing. Include no more than five items in this list." 

So, large language models are pretty good at extracting specific things out of a piece of text. In this case, we're expressing the emotions and this could be useful for understanding how your customers think about a particular product. For a lot of customer support organizations, it's important to understand if a particular user is extremely upset. 

So, you might have a different classification problem like this, "Is the writer of the following review expressing anger?". Because if someone is really angry, it might merit paying extra attention to have a customer review, to have customer support or customer success, reach out to figure what's going on and make things right for the customer. 

In this case, the customer is not angry. And notice that with supervised learning, if I had wanted to build all of these classifiers, there's no way I would have been able to do this with supervised learning in the just a few minutes that you saw me do so in this video. I'd encourage you to pause this video and try changing some of these prompts. 

Maybe ask if the customer is expressing delight or ask if there are any missing parts and see if you can a prompt to make different inferences about this lamp review. 

Let me show some more things that you can do with this system, specifically extracting richer information from a customer review. 

So, information extraction is the part of NLP, of Natural Language Processing, that relates to taking a piece of text and extracting certain things that you want to know from the text. So in this prompt, I'm asking it to identify the following items, the item purchase, and the name of the company that made the item. 

Again, if you are trying to summarize many reviews from an online shopping e-commerce website, it might be useful for your large collection of reviews to figure out what were the items, who made the item, figure out positive and negative sentiment, to track trends about positive or negative sentiment for specific items or for specific manufacturers. And in this example, I'm going to ask it to format your response as a JSON object with "Item" and "Brand" as the keys. 

And so if I do that, it says the item is a lamp, the brand is Lumina, and you can easily load this into the Python dictionary to then do additional processing on this output. In the examples we've gone through, you saw how to write a prompt to recognize the sentiment, figure out if someone is angry, and then also extract the item and the brand. 

One way to extract all of this information would be to use three or four prompts and call "get_completion", you know, three times or four times to extract these different views one at a time. But it turns out you can actually write a single prompt to extract all of this information at the same time. So let's say "identify the following items, extract sentiment, is the reviewer expressing anger, item purchased, company that made it". 

And then here I'm also going to tell it to format the anger value as a boolean value, and let me run that. And this outputs a JSON where sentiment is positive, anger, and then no quotes around false because it asked it to just output it as a boolean value. Extracted the item as "lamp with additional storage" instead of lamp, seems okay. 

But this way you can extract multiple fields out of a piece of text with just a single prompt. 

And, as usual, please feel free to pause the video and play with different variations on this yourself. Or maybe even try typing in a totally different review to see if you can still extract these things accurately. Now, one of the cool applications I've seen of large language models is inferring topics. 

Given a long piece of text, you know, what is this piece of text about? What are the topics? Here's a fictitious newspaper article about how government workers feel about the agency they work for. So, the recent survey conducted by government, you know, and so on. "Results revealed that NASA was a popular department with a high satisfaction rating." I am a fan of NASA, I love the work they do, but this is a fictitious article. 

And so, given an article like this, we can ask it, with this prompt, to determine five topics that are being discussed in the following text. 

Let's make each item one or two words long, for my response, in a comma-separated list. And so, if we run that, you know, we get this article. It's about a government survey, it's about job satisfaction, it's about NASA, and so on. So, overall, I think, pretty nice extraction of a list of topics. And, of course, you can also, you know, split it so you get a Python list with the five topics that this article was about. 

And if you have a collection of articles and extract topics, you can then also use a large language model to help you index into different topics. So, let me use a slightly different topic list. Let's say that we're a news website or something, and, you know, these are the topics we track. "NASA, local government, engineering, employee satisfaction, federal government". 

And let's say you want to figure out, given a news article, which of these topics are covered in that news article. 

So, here's a prompt that I can use. I'm going to say, determine whether each item in the final list of topics is a topic in the text below. 

Give your answer as a list of 0 or 1 for each topic. And so, great. So, this is the same story text as before. So, this thing is a story. It is about NASA. It's not about local government. It's not about engineering. It is about employee satisfaction, and it is about federal government. So, with this, in machine learning, this is sometimes called a "Zero-Shot Learning Algorithm", because we didn't give it any training data that was labeled, so that's Zero-Shot. And with just a prompt, it was able to determine which of these topics are covered in that news article. 

And so, if you want to generate a news alert, say, so that process news, and I really like a lot of work that NASA does. So, if you want to build a system that can take this, put this information into a dictionary, and whenever NASA news pops up, print "ALERT: New NASA story!", they can use this to very quickly take any article, figure out what topics it is about, and if the topic includes NASA, have it print out "ALERT: New NASA story!". Oh, just one thing. I use this topic dictionary down here. 

This prompt that I use up here isn't very robust. If I wanted a production system, I would probably have it output the answer in JSON format, rather than as a list, because the output of the large language model can be a little bit inconsistent. 

So, this is actually a pretty brittle piece of code. But if you want, when you're done watching this video, feel free to see if you can figure out how to modify this prompt, to have it output JSON instead of a list like this, and then have a more robust way to tell if a particular article is a story about NASA. 

So, that's it for inferring. And in just a few minutes, you can build multiple systems for making inferences about text that previously just would have taken days or even weeks for a skilled machine learning developer. And so, I find this very exciting that both for skilled machine learning developers, as well as for people that are newer to machine learning, you can now use prompting to very quickly build and start making inferences on pretty complicated natural language processing tasks like these. 

In the next video, we'll continue to talk about exciting things you could do with large language models, and we'll go on to "Transforming". How can you take one piece of text and transform it into a different piece of text, such as translate it to a different language. Let's go on to the next video. 

这个下一个视频是关于推断的。我喜欢把这些任务想象成模型接收文本作为输入并执行某种分析的任务。所以这可能是提取标签、提取名称、理解文本的情感之类的事情。

所以，如果你想提取文本的情感，正面或负面，在传统的机器学习工作流中，你需要收集标签数据集，训练一个模型，弄清楚如何在云中部署模型并进行推断。

这可能效果很好，但是，你知道，经历这个过程真的需要很多工作。而且对于每一个任务，比如情感与提取名称相对于其他东西，你必须训练并部署一个单独的模型。关于大型语言模型的一个非常好的事情是，对于许多这样的任务，你只需写一个提示，然后它就可以开始生成结果。

这在应用程序开发方面提供了巨大的速度。你还可以只使用一个模型、一个 API 来完成许多不同的任务，而不需要弄清楚如何训练和部署很多不同的模型。所以，让我们跳入代码，看看你如何利用这一点。

所以这是我们通常的启动代码。我会运行它。

我要使用的最合适的例子是一个关于灯的评论。所以，「需要一个适合卧室的好灯，而这个灯还有额外的存储空间」等等。

所以，让我写一个提示来分类这个评论的情感。如果我想让系统告诉我，你知道，情感是什么。

我只需写下，「以下产品评论的情感是什么」加上通常的分隔符和评论文本等等，然后运行它。

这说，「产品评论的情感是积极的」，这实际上，似乎是正确的。这个灯不是完美的，但这个客户似乎很满意。似乎是一个非常关心客户和产品的好公司。我认为正面的情感似乎是正确的答案。

现在，这打印出整个句子：「该产品评论的情感是积极的。」

如果您希望得到更简洁的回应以便于后处理，我可以采取这个提示并加上另一个指示，以给出单个词的答案，要么是积极的，要么是消极的。这样它就只会打印出「积极的」，这使得对文本的输出和处理更加容易。

再看一个提示，仍然使用灯的评论。这里，我让它「识别以下评论的作者所表达的情感列表。这个列表中最多不超过五项。」

大型语言模型非常擅长从文本中提取特定的内容。在这种情况下，我们正在表示情感，这可以帮助理解您的客户对特定产品的看法。对于许多客户支持组织，了解特定用户是否非常沮丧是很重要的。

因此，您可能会有一个不同的分类问题，如：「以下评论的作者是否在表达愤怒？」。因为如果有人真的很生气，这可能值得额外关注，让客户评论，让客户支持或客户成功团队了解情况并为客户纠正。

在这种情况下，客户并不生气。注意，使用监督学习，如果我想建立所有这些分类器，我不可能在你看到我的这个视频的短短几分钟内使用监督学习来做到这一点。我鼓励你暂停这个视频并尝试更改一些这些提示。

也许问客户是否在表达喜悦或询问是否有任何缺失的部分，看看您是否可以提示对这个灯评论进行不同的推断。

让我展示您可以使用此系统进行的更多操作，特别是从客户评论中提取更丰富的信息。

所以，信息提取是自然语言处理（NLP）的一部分，它与从文本中提取您想知道的某些事情有关。所以在这个提示中，我要求它识别以下项目，购买的物品和制造该物品的公司的名称。

再次，如果你试图从一个在线购物电商网站总结很多评论，对于你的大量评论来说，找出哪些是物品，谁制造的物品，确定正面和负面的情感，跟踪关于特定物品或特定制造商的正面或负面情感的趋势，这可能是有用的。在这个例子中，我要求它将响应格式化为带有「Item」和「Brand」作为关键字的 JSON 对象。

所以，如果我这样做，它说该物品是一个灯，品牌是 Lumina，您可以轻松地将其加载到 Python 字典中，然后对此输出进行额外的处理。在我们经历的例子中，你看到了如何编写一个提示来识别情感，找出某人是否生气，然后还提取物品和品牌。

提取所有这些信息的一种方法是使用三或四个提示并调用「get_completion」，你知道，三次或四次，一次一次地提取这些不同的视图。但事实证明，您实际上可以编写一个提示来同时提取所有这些信息。所以让我们说「识别以下项目，提取情感，评论者是否在表达愤怒，购买的物品，制造它的公司」。

然后这里我还要告诉它将 anger 值格式化为布尔值，让我运行它。这会输出一个 JSON，其中情感是正面的，愤怒，然后在 false 周围没有引号，因为它要求它只将其输出为布尔值。将物品提取为「带有额外存储的灯」而不是灯，似乎可以。

但这样你可以只用一个提示从文本中提取多个字段。

而且，像往常一样，请随时暂停视频并自己尝试这上面的不同变体。或者甚至尝试输入完全不同的评论，看看您是否仍然可以准确地提取这些东西。现在，我所看到的大型语言模型的一个很酷的应用是推断话题。

给定一长段文字，你知道，这段文字是关于什么的？这是什么话题？这里是一篇关于政府工作人员对其所在机构的感受的虚构报纸文章。所以，政府最近进行的一项调查，你知道，等等。「结果显示，NASA 是一个受欢迎的部门，满意度评分很高。」我是 NASA 的粉丝，我喜欢他们所做的工作，但这是一篇虚构的文章。

所以，给定这样的文章，我们可以用这个提示问它，确定下面的文本中正在讨论的五个话题。

让我的回答中的每个项目都是一到两个词长，用逗号分隔的列表。所以，如果我们运行那个，你知道，我们得到这篇文章。它是关于一个政府调查的，它是关于工作满意度的，它是关于 NASA 的，等等。所以，总的来说，我认为，这是一个相当不错的话题列表的提取。当然，你也可以，你知道，分割它，所以你得到一个带有这篇文章所涉及的五个话题的 Python 列表。

如果你有一组文章并提取话题，你还可以使用大型语言模型帮助你索引不同的话题。所以，让我使用一个稍微不同的话题列表。假设我们是一个新闻网站或者类似的东西，你知道，这些是我们关注的话题。「NASA, 本地政府，工程学，员工满意度，联邦政府」。

假设你想弄清楚，给定一篇新闻文章，这些话题中的哪些被涉及到了。

所以，这是一个我可以使用的提示。我会说，确定下面的文本中的最后一个话题列表中的每一项是否是一个话题。

为每个话题给出一个 0 或 1 的答案列表。所以，很好。所以，这是和之前相同的故事文本。所以，这是一个故事。它是关于 NASA 的。它不是关于本地政府的。它不是关于工程学的。它是关于员工满意度的，它是关于联邦政府的。所以，有了这个，在机器学习中，这有时被称为「零次学习算法」，因为我们没有给它任何标记的训练数据，所以那是零次。并且只需一个提示，它就能确定哪些话题被涉及到了那篇新闻文章。

所以，如果你想生成一个新闻提醒，比如说，那样处理新闻，我真的很喜欢 NASA 所做的很多工作。所以，如果你想建立一个系统，可以把这个信息放入一个字典中，每当出现 NASA 的新闻时，打印「警告：新的 NASA 报道！」，它们可以使用这个非常快速地获取任何文章，弄清楚它是关于什么话题的，如果话题包括 NASA，让它打印出「警告：新的 NASA 报道！」。哦，还有一件事。我在这里使用了这个话题字典。

我在这里使用的这个提示并不是很稳健。如果我想要一个生产系统，我可能会让它以 JSON 格式输出答案，而不是作为一个列表，因为大语言模型的输出可能会有一点不一致。

所以，这实际上是一个相当脆弱的代码片段。但如果你愿意，在你看完这个视频后，试试看你是否能够弄清楚如何修改这个提示，让它输出 JSON 而不是像这样的列表，然后有一个更稳健的方法来判断一个特定的文章是否是关于 NASA 的报道。

所以，这就是关于推断的内容。而且，仅仅用了几分钟，你就可以构建多个关于文本的推断系统，之前这可能需要经验丰富的机器学习开发者花费数天甚至数周的时间。所以，我觉得这很令人兴奋，对于经验丰富的机器学习开发者，以及对于那些对机器学习较为陌生的人，你现在可以使用提示非常快速地构建并开始对这些相当复杂的自然语言处理任务进行推断。

在下一个视频中，我们将继续讨论你可以用大型语言模型做什么令人兴奋的事情，我们将继续讨论「转换」。你如何将一段文本转换成另一段文本，比如将其翻译成另一种语言。让我们继续下一个视频。