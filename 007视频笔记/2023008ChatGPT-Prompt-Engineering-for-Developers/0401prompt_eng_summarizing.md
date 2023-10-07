## 0401. prompt_eng_summarizing

There's so much text in today's world, pretty much none of us have enough time to read all the things we wish we had time to. So, one of the most exciting applications I've seen of large language models is to use it to summarize text, and this is something that I'm seeing multiple teams build into multiple software applications. 

You can do this in the chatGPT web interface. I do this all the time to summarize articles so I can just kind of read the content of many more articles than I previously could, and if you want to do this more programmatically you'll see how to in this lesson. 

So with that, let's dig into the code to see how you could use this yourself to summarize text. So, let's start off with the same starter code as you saw before of import OpenAI, load the API key, and here's that get completion helper function. 

I'm going to use as the running example the task of summarizing this product review. Got this panda plush toy for my daughter's birthday, who loves it and takes it everywhere, and so on and so on. 

If you're building an e-commerce website, and there's just a large volume of reviews, having a tool to summarize the lengthy reviews could give you a way to very quickly glance over more reviews to get a better sense of what all your customers are thinking. 

So, here's a prompt for generating a summary. Your task is to generate a short summary of a product review from e-commerce website, summarize review below, and so on, in at most 30 words.

And so, this is soft and cute, panda plush toy loved by daughter, bit small for the price, arrived early. Not bad, it's a pretty good summary. And as you saw in the previous video, you can also play with things like controlling the character count or the number of sentences to affect the length of this summary. 

Now, sometimes when creating a summary, if you have a very specific purpose in mind for the summary, for example, if you want to give feedback to the shipping department, you can also modify the prompt to reflect that, so that they can generate a summary that is more applicable to one particular group in your business. 

So, for example, if I add to give feedback to the shipping department, let's say I change this to, start to focus on any aspects that mention shipping and delivery of the product. And if I run this, then, again you get a summary, but instead of starting off with Soft and Cute Panda Plush Toy, it now focuses on the fact that it arrived a day earlier than expected. 

And then it still has, you know, other details then. Or as another example, if we aren't trying to give feedback to their shipping department, but let's say we want to give feedback to the pricing department. 

So the pricing department is responsible to determine the price of the product, and I'm going to tell it to focus on any aspects that are relevant to the price and perceived value. 

Then, this generates a different summary that it says, maybe the price may be too high for a size. 

Now in the summaries that I've generated for the shipping department or the pricing department, it focus a bit more on information relevant to those specific departments. 

And in fact, feel free to pause the video now and maybe ask it to generate information for the product department responsible for the customer experience of the product, or for something else that you think might be interesting to an e-commerce site. 

But in these summaries, even though it generated the information relevant to shipping, it had some other information too, which you could decide may or may not be helpful. 

So, depending on how you want to summarize it, you can also ask it to extract information rather than summarize it. So here's a prompt that says you're tasked to extract relevant information to give feedback to the shipping department. And now it just says, product arrived a day earlier than expected without all of the other information, which was also helpful in a general summary, but less specific to the shipping department if all it wants to know is what happened with the shipping. 

Lastly, let me just share with you a concrete example for how to use this in a workflow to help summarize multiple reviews to make them easier to read. 

So, here are a few reviews. This is kind of long, but you know, here's the second review for a standing lamp, need a lamp on the bedroom. Here's a third review for an electric toothbrush. My dental hygienist recommended kind of a long review about the electric toothbrush. 

This is a review for a blender when they said, so said 17p system on seasonal sale, and so on and so on. This is actually a lot of text. If you want, feel free to pause the video and read through all this text. But what if you want to know what these reviewers wrote without having to stop and read all this in detail? So, I'm going to set review one to be just the product review that we had up there. 

And I'm going to put all of these reviews into a list. And now, if I implement or loop over the reviews, so, here's my prompt. And here I've asked it to summarize it in at most 20 words. Then let's have it get the response and print it out. And let's run that. 

And it prints out the first review is that panda toy review, summary review of the lamp, summary review of the toothbrush, and then the blender. 

And so, if you have a website where you have hundreds of reviews, you can imagine how you might use this to build a dashboard to take huge numbers of reviews, generate short summaries of them so that you or someone else can browse the reviews much more quickly. And then, if they wish, maybe click in to see the original longer review. 

And this can help you efficiently get a better sense of what all of your customers are thinking. 
 
Right? So, that's it for summarizing. And I hope that you can picture, if you have any applications with many pieces of text, how you can use prompts like these to summarize them to help people quickly get a sense of what's in the text, the many pieces of text, and perhaps optionally dig in more if they wish. 

In the next video, we'll look at another capability of large language models, which is to make inferences using text. For example, what if you had, again, product reviews and you wanted to very quickly get a sense of which product reviews have a positive or a negative sentiment? Let's take a look at how to do that in the next video. 

在今天的世界里，文字内容很多，几乎没有人有足够的时间读完所有他们希望阅读的内容。所以，我看到的最令人兴奋的大型语言模型应用之一就是用它来总结文本，这是我看到多个团队在多个软件应用中集成的功能。

你可以在 chatGPT 网页界面上这样做。我经常这样做来总结文章，这样我可以阅读比我之前能阅读的更多文章的内容，如果你想更系统地这样做，你可以在这节课中看到如何操作。

那么，让我们深入代码，看看你如何使用这个功能来为自己总结文本。首先，我们从之前看到的导入 OpenAI、加载 API 密钥的启动代码开始，下面是 get completion 助手函数。

我将以总结这个产品评价为例：我为女儿的生日买了这只熊猫毛绒玩具，她非常喜欢，并带着它到处走。

如果你正在建一个电商网站，并且有大量的评论，有一个工具可以总结冗长的评论，这样你可以快速浏览更多的评论，更好地了解所有客户的想法。

所以，这是一个生成总结的提示。你的任务是从电商网站生成一个产品评价的简短总结，最多 30 个字。

因此，这是柔软可爱的熊猫毛绒玩具，女儿喜欢，价格略高，提前到货。不错，这是一个相当好的总结。正如你在之前的视频中看到的，你还可以控制字符数或句子数量来影响这个总结的长度。

现在，有时当创建一个总结时，如果你有一个非常特定的总结目的，比如，如果你想给运输部门提供反馈，你也可以修改提示以反映这一点，这样它们可以生成一个更适用于你业务中的某个特定群体的总结。

例如，如果我加上给运输部门提供反馈，我改为关注提及产品的运输和交付的任何方面。如果我运行这个，你会得到一个总结，但它现在关注的是产品比预期早到了一天。

接下来它仍然有其他的细节。或者举另一个例子，如果我们不是想给他们的运输部门提供反馈，而是想给定价部门提供反馈。

所以，定价部门负责确定产品的价格，我会告诉它关注与价格和感知价值相关的任何方面。

然后，这生成了一个不同的总结，它说，价格对于大小来说可能过高。

现在，在我为运输部门或定价部门生成的总结中，它更多地关注了与这些特定部门相关的信息。

实际上，现在可以暂停视频，也许要求它为负责产品的客户体验的产品部门或你认为可能对电商网站有趣的其他事情生成信息。

但在这些总结中，尽管它生成了与运输相关的信息，但也有一些其他信息，你可以决定这些信息可能有或没有帮助。

所以，根据你想要如何总结，你也可以要求它提取信息而不是总结。这里有一个提示说你的任务是提取相关信息以向运输部门提供反馈。现在它只说，产品比预期早到了一天，没有所有其他信息，这在一般总结中也是有帮助的，但对于运输部门来说，如果它只想知道运输发生了什么，就不太具体。

最后，让我与你分享一个如何在工作流中使用此功能来帮助总结多个评论，使其更容易阅读的具体示例。

所以，这里有几条评论。这有点长，但你知道，这是站立灯的第二条评论，卧室里需要一个灯。这是电动牙刷的第三条评论。我的牙齿清洁师推荐了一个关于电动牙刷的长评论。

这是一篇关于搅拌机的评论，他们说，所谓的 17p 系统在季节性促销上，等等等等。这实际上是很多文字。如果你愿意，可以暂停视频并阅读所有这些文字。但是，如果你想知道这些评论者写了什么，而不必停下来仔细阅读所有内容怎么办？所以，我将设置评论一只是我们之前有的产品评论。

我将把所有这些评论放入一个列表中。现在，如果我实施或循环评论，所以，这是我的提示。在这里我要求它最多总结 20 个词。然后让它获得响应并打印出来。然后运行它。

它打印出的第一条评论是那个熊猫玩具的评论，灯的总结评论，牙刷的总结评论，然后是搅拌机。

所以，如果你有一个网站上有数百条评论，你可以想象你如何使用这个功能构建一个仪表板，处理大量的评论，生成它们的简短总结，这样你或其他人可以更快地浏览评论。然后，如果他们愿意，也许可以点击查看原始的更长的评论。

这可以帮助你有效地更好地了解所有客户的想法。

对吧？所以，这就是总结的内容。我希望你可以想象，如果你有任何与多段文字相关的应用，如何使用这样的提示来总结它们，帮助人们快速了解文本中的内容，许多段文本，也许还可以选择性地深入研究，如果他们愿意的话。

在下一个视频中，我们将看一下大型语言模型的另一种能力，即使用文本进行推断。例如，如果你再次有产品评论，你想很快了解哪些产品评论是积极的或消极的怎么办？我们来看看在下一个视频中如何做到这一点。