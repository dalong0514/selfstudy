## 0301. prompt_eng_terative

When I've been building applications with large language models, I don't think I've ever come to the prompt that I ended up using in the final application on my first attempt. 

And this isn't what matters. As long as you have a good process to iteratively make your prompt better, then you'll be able to come to something that works well for the task you want to achieve. 

You may have heard me say that when I train a machine learning model, it almost never works the first time. In fact, I'm very surprised that the first model I trained works. I think we're prompting, the odds of it working the first time is maybe a little bit higher, but as he's saying, doesn't matter if the first prompt works, what matters most is the process for getting to prompts that works for your application. So with that, let's jump into the code and let me show you some frameworks to think about how to iteratively develop a prompt. 

All right. So, if you've taken a machine learning class with me before, you may have seen me use a diagram saying that with machine learning development, you often have an idea and then implement it. So, write the code, get the data, train your model, and that gives you an experimental result. And you can then look at that output, maybe do error analysis, figure out where it's working or not working, and then maybe even change your idea of exactly what problem you want to solve or how to approach it. 

And then change implementation and run another experiment and so on, and iterate over and over to get to an effective machine learning model. If you're not familiar with machine learning, haven't seen this diagram before, don't worry about it. Not that important for the rest of this presentation. 

But when you are writing prompts to develop an application using an LLM, the process can be quite similar, where you have an idea for what you want to do, the task you want to complete, and you can then take a first attempt at writing a prompt that hopefully is clear and specific, and maybe, if appropriate, gives the system time to think. And then you can run it and see what result you get. 

And if it doesn't work well enough the first time, then the iterative process of figuring out why the instructions, for example, were not clear enough, or why it didn't give the algorithm enough time to think, allows you to refine the idea, refine the prompt, and so on, and to go around this loop multiple times until you end up with a prompt that works for your application. 

This too is why I personally have not paid as much attention to the internet articles that say 30 perfect prompts, because I think, there probably isn't a perfect prompt for everything under the sun. It's more important that you have a process for developing a good prompt for your specific application. 

So, let's look at an example together in code. I have here the starter code that you saw in the previous videos, have import OpenAI, import OS. Here we get the OpenAI API key, and this is the same helper function that you saw as last time. 

And I'm going to use as the running example in this video, the task of summarizing a fact sheet for a chair. So, let me just paste that in here. 

And feel free to pause the video and read this more carefully in the notebook on the left if you want. But here's a fact sheet for a chair with a description saying it's part of a beautiful family of mid-century inspired, and so on. It talks about the construction, has the dimensions, options for the chair, materials, and so on. It comes from Italy. 

So, let's say you want to take this fact sheet and help a marketing team write a description for an online retail website. 

Let me just quickly run these three, and then we'll come up with a prompt as follows, and I'll just... and I'll just paste this in. 

So my prompt here says, your task is to help a marketing team create the description for a retail website with a product based on a techno fact sheet, write a product description, and so on. 

Right? So this is my first attempt to explain the task to the large language model. 

So let me hit shift-enter, and this takes a few seconds to run, and we get this result. It looks like it's done a nice job writing a description, introducing a stunning mid-century inspired office chair, perfect addition, and so on. But when I look at this, I go, boy, this is really long. It's done a nice job doing exactly what I asked it to, which is start from the technical fact sheet and write a product description. 

But when I look at this, I go, this is kind of long. Maybe we want it to be a little bit shorter. So, I have had an idea, I wrote a prompt, got a result. I'm not that happy with it because it's too long. So, I will then clarify my prompt and say, use at most 50 words to try to give better guidance on the desired length of this. And let's run it again. 

Okay. This actually looks like a much nicer short description of the product, introducing a mid-century inspired office chair, and so on. Five of you just, yeah, both stylish and practical. Not bad. And let me double check the length that this is. So, I'm going to take the response, split it according to where the space is, and then, you know, print out the length. So it's 52 words. It's actually not bad. 

Large language models are okay, but not that great at following instructions about a very precise word count. But this is actually not bad. Sometimes it will print out something with 60 or 65 and so on words, but it's kind of within reason. Some of the things you could try to do would be, to say use at most three sentences. 

Let me run that again. But these are different ways to tell the large language model, what's the length of the output that you want. 

So this is 1, 2, 3, I count three sentences, looks like I did a pretty good job. And then I've also seen people sometimes do things like, I don't know, use at most 280 characters. Large language models, because of the way they interpret text, using something called a tokenizer, which I won't talk about. But they tend to be so-so at counting characters. 
But let's see, 281 characters. It's actually surprisingly close. Usually a large language model is, doesn't get it quite this close. But these are different ways that you can play with to try to control the length of the output that you get. But let me just switch it back to use at most 50 words. 

And there's that result that we had just now. As we continue to refine this text for our websites, we might decide that, boy, this website isn't selling direct to consumers, is actually intended to sell furniture to furniture retailers that would be more interested in the technical details of the chair and the materials of the chair. In that case, you can take this prompt and say, I want to modify this prompt to get it to be more precise about the technical details. 

So let me keep on modifying this prompt. And I'm going to say, this description is intended for furniture retailers, so should be technical and focus on materials, products and constructed from, well, let's run that. 

And let's see. 

Not bad, says, you know, coated aluminum base and pneumatic chair, high-quality materials. So by changing the prompt, you can get it to focus more on specific characters, on specific characteristics you wanted to. 

And when I look at this, I might decide at the end of the description, I also wanted to include the product ID. So the two offerings of this chair, SWC 110, SWC 100. So, maybe I can further improve this prompt. 

And to get it to give me the product IDs, I can add this instruction at the end of the description, include every 7-character product ID in the technical specification, and let's run it, and see what happens. 

And so, it says, introduce you to our Miss Agents 5 office chair, shell colors, talks about plastic coating, aluminum base, practical, some options, talks about the two product IDs. So, this looks pretty good. 

And what you've just seen is a short example of the iterative prompt development that many developers will go through. 

And I think, a guideline is, in the last video, you saw Isa share a number of best practices, and so, what I usually do is keep best practices like that in mind, be clear and specific, and if necessary, give the model time to think. With those in mind, it's worthwhile to often take a first attempt at writing a prompt, see what happens, and then go from there to iteratively refine the prompt to get closer and closer to the result that you need. 

And so, a lot of the successful prompts that you may see used in various programs was arrived at at an iterative process like this. Just for fun, let me show you an example of a even more complex prompt that might give you a sense of what chatGPT can do, which is, I've just added a few extra instructions here. After the description, include a table that gives the product dimensions, and then, you know, format everything as HTML. So, let's run that. 

And in practice, you end up with a prompt like this, really only after multiple iterations. I don't think I know anyone that would write this exact prompt the first time they were trying to get the system to process a fact sheet. 

And so, this actually outputs a bunch of HTML. Let's display the HTML to see if this is even valid HTML and see if this works. And I don't actually know it's going to work, but let's see. Oh, cool. All right. Looks like it rendered. 

So, it has this really nice looking description of a chair, construction, materials, product dimensions. 
 
Oh, it looks like I left out the use at most 50 words instruction, so this is a little bit long, but if you want that, you know, you can even feel free to pause the video, tell it to be more succinct and regenerate this and see what results you get. 

So, I hope you take away from this video that prompt development is an iterative process. Try something, see how it does not yet, fulfill exactly what you want, and then think about how to clarify your instructions, or in some cases, think about how to give it more space to think to get it closer to delivering the results that you want. And I think, the key to being an effective prompt engineer isn't so much about knowing the perfect prompt, it's about having a good process to develop prompts that are effective for your application.

And in this video, I illustrated developing a prompt using just one example. For more sophisticated applications, sometimes you will have multiple examples, say a list of 10 or even 50 or 100 fact sheets, and iteratively develop a prompt and evaluate it against a large set of cases. 

But for the early development of most applications, I see many people developing it sort of the way I am, with just one example, but then for more mature applications, sometimes it could be useful to evaluate prompts against a larger set of examples, such as to test different prompts on dozens of fact sheets to see how is average or worst case performances on multiple fact sheets. 

But usually, you end up doing that only when an application is more mature, and you have to have those metrics to drive that incremental last few steps of prompt improvement. 

So with that, please do play with the Jupyter Code notebook examples and try out different variations and see what results you get. And when you're done, let's go on to the next video, where we'll talk about one very common use of large language models in software applications, which is to summarize text. So when you're ready, let's go on to the next video. 

当我使用大型语言模型构建应用程序时，我认为我在第一次尝试时从未使用过我最终在应用程序中使用的提示。而这并不是最重要的。只要你有一个不断完善你的提示的迭代过程，你就能得到一个适合你想完成的任务的东西。

你可能听说过我说，当我训练一个机器学习模型时，它几乎从未在第一次就成功。事实上，我对我训练的第一个模型能工作感到非常惊讶。我认为在提示方面，第一次工作的几率可能会稍微高一些，但正如他所说，第一个提示是否有效并不重要，最重要的是获得适合你的应用程序的提示的过程。所以，让我们进入代码，让我向你展示一些框架，告诉你如何迭代地开发一个提示。

好的。所以，如果你之前上过我的机器学习课程，你可能见过我使用一个图表说，用机器学习开发时，你经常会有一个想法，然后实现它。所以，编写代码、获取数据、训练你的模型，这会给你一个实验结果。然后你可以查看该输出，也许进行错误分析，找出它工作或不工作的地方，然后也许甚至改变你想解决的确切问题或如何解决它的想法。

然后改变实现并运行另一个实验，如此反复，直到得到一个有效的机器学习模型。如果你不熟悉机器学习，以前没看过这个图，不用担心。这对接下来的演示并不重要。

但是，当你写提示来开发一个使用 LLM 的应用程序时，这个过程可能相当相似，你对你想做的事情有一个想法，你想完成的任务，然后你可以首先尝试写一个提示，希望它清晰而具体，并且，如果适当的话，给系统时间思考。然后你可以运行它，看看你得到的结果。

如果第一次的效果不够好，那么迭代的过程，例如确定为什么指示不够清晰，或为什么没有给算法足够的思考时间，允许你完善想法、完善提示等，多次循环，直到你得到一个适合你应用的提示。

这也是为什么我个人没有太关注那些声称有 30 个完美提示的互联网文章，因为我认为，太阳底下可能没有适合所有事物的完美提示。更重要的是你有一个为你特定应用开发好提示的过程。

所以，让我们一起在代码中看一个例子。我在这里有你在前面的视频中看到的起始代码，有 import OpenAI、import OS。这里我们获取 OpenAI API 密钥，这是你上次看到的相同的辅助函数。

我将在这个视频中使用的运行示例是为一把椅子摘要一个事实表。所以，让我在这里粘贴它。

如果你想的话，可以暂停视频并在左边的笔记本上更仔细地阅读。但这里是一把椅子的事实表，描述说它是一个美丽的中世纪灵感家族的一部分，等等。它谈到了构造，有尺寸，椅子的选项，材料等等。它来自意大利。

所以，假设你想拿这个事实表，帮助营销团队为一个在线零售网站写一个描述。

让我快速运行这三个，然后我们将提出如下的提示，我只是... 我只是粘贴这个。

所以我的提示在这里说，你的任务是帮助一个营销团队根据技术事实表为零售网站的产品创建描述，写一个产品描述，等等。

对吧？所以这是我第一次尝试向大型语言模型解释任务。

所以我按 Shift-Enter，这需要几秒钟来运行，然后我们得到这个结果。它看起来做得很好，写了一个描述，介绍了一个令人惊叹的中世纪启示的办公椅，完美的补充等等。但当我看这个时，我觉得，哇，这真的很长。它很好地完成了我要求它做的事情，就是从技术规格表开始写一个产品描述。

但当我看这个时，我觉得，这有点长。也许我们希望它稍微短一点。所以，我有了一个想法，我写了一个提示，得到了一个结果。我对它并不是很满意，因为它太长了。所以，我会再明确我的提示并说，最多使用 50 个词来更好地指导这个的期望长度。然后再运行一次。

好的，这实际上看起来像一个关于产品的更好的短描述，介绍了一个中世纪启示的办公椅等等。其中五个，是的，既时尚又实用。不错。让我再检查一下这个的长度。所以，我将获取响应，根据空格位置拆分它，然后，你知道的，输出长度。所以它是 52 个词。实际上还不错。

大型语言模型可以，但不是很擅长遵循关于非常精确的字数的指示。但这实际上还不错。有时它会输出 60 或 65 之类的词，但这是在合理范围内。你可以尝试做的一些事情是，比如说，最多使用三个句子。

让我再运行一次。但这些是告诉大型语言模型，你希望输出的长度是什么的不同方法。所以这是 1，2，3，我数了三个句子，看起来我做得很好。然后，我也看到有时人们会做这样的事情，比如说，我不知道，最多使用 280 个字符。大型语言模型，因为它们解释文本的方式，使用了一种叫做标记器的东西，我不会谈论。但它们在计算字符方面表现得还可以。

但让我们看看，281 个字符。实际上出奇地接近。通常，一个大型语言模型并不会做得这么接近。但这些是你可以玩的不同方式，尝试控制你得到的输出的长度。但让我只是切换回最多使用 50 个词。

刚才我们得到了那个结果。当我们继续为我们的网站完善这段文本时，我们可能会决定，哇，这个网站并不是直接向消费者销售的，实际上是为了向对椅子的技术细节和材料更感兴趣的家具零售商销售家具。在这种情况下，您可以采取这个提示并说，我想修改这个提示，使其在技术细节上更为准确。

所以让我继续修改这个提示。我要说，这个描述是为家具零售商准备的，所以应该是技术性的，并关注材料、产品和由什么构成，好的，让我们运行它。

看看。

不错，说，你知道，涂层铝基座和气动椅，高质量材料。所以通过更改提示，您可以使其更加关注您想要的特定特性。

当我看这个时，我可能会决定在描述的结尾，我还希望包括产品 ID。所以这把椅子的两个型号是 SWC 110，SWC 100。所以，也许我可以进一步完善这个提示。

为了让它给我产品 ID，我可以在描述的结尾加上这条指示，包括技术规格中的每个 7 个字符的产品 ID，让我们运行它，看看会发生什么。

所以，它说，向您介绍我们的 Miss Agents 5 办公椅，外壳颜色，讲述塑料涂层，铝基座，实用，一些选项，讲述了两个产品 ID。所以，这看起来很好。

你刚刚看到的是许多开发人员会经历的迭代式提示开发的一个简短示例。

我认为，一个指导原则是，在上一个视频中，你看到 Isa 分享了许多最佳实践，所以，我通常做的是记住这样的最佳实践，要清晰和具体，如果有必要，给模型时间去思考。记住这些，经常首先尝试编写一个提示，看看会发生什么，然后从那里迭代地完善提示，越来越接近您需要的结果。

因此，你可能在各种程序中看到的许多成功的提示都是通过这样的迭代过程得到的。纯粹为了好玩，让我向你展示一个更复杂的提示的示例，这可能会给你一个关于 chatGPT 能做什么的感觉，那就是，我在这里添加了一些额外的指示。在描述之后，包括一个提供产品尺寸的表格，然后，你知道，将所有内容格式化为 HTML。所以，让我们运行那个。

实际上，你最终得到这样的提示，真的只是在多次迭代之后。我认为我不知道有谁会在第一次尝试让系统处理事实表时写这个确切的提示。

所以，这实际上输出了一堆 HTML。让我们显示 HTML，看看这是否是有效的 HTML，看看这是否有效。我实际上不知道它会工作，但让我们看看。哦，酷。好的。看起来它渲染了。

所以，它有一个关于椅子的非常好看的描述，构造，材料，产品尺寸。

哦，看起来我遗漏了最多使用 50 个词的指示，所以这有点长，但如果你想要，你知道，你甚至可以随时暂停视频，告诉它更简洁，并重新生成这个，看看你得到什么结果。

所以，我希望你从这个视频中带走的是，提示开发是一个迭代的过程。尝试一些东西，看看它是如何还没有完全满足你想要的，然后想想如何澄清你的指示，或在某些情况下，想想如何给它更多的思考空间，使其更接近于提供你想要的结果。我认为，成为一个有效的提示工程师的关键不太在于知道完美的提示，而在于拥有一个好的过程来开发适用于你的应用的提示。

在这个视频中，我用一个例子演示了如何开发一个提示。对于更复杂的应用，有时你会有多个例子，比如说 10、50 或甚至 100 个事实表，并对其进行迭代开发提示，根据大量的案例进行评估。

但对于大多数应用的早期开发，我看到很多人都是按照我现在这种方式来开发的，只用一个例子。但对于更成熟的应用，有时评估提示对更大的例子集可能会很有用，比如在几十个事实表上测试不同的提示，看看它在多个事实表上的平均或最差表现。

但通常，只有当应用更成熟时，你才会这样做，你必须有这些指标来推动提示改进的最后几步。

因此，请玩玩 Jupyter Code 笔记本示例，尝试不同的变化，看看你得到的结果。当你完成后，让我们继续下一个视频，我们将讨论大型语言模型在软件应用中的一个非常常见的用途，即总结文本。所以当你准备好时，让我们继续下一个视频。