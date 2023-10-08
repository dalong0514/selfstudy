## 0601. prompt_eng_transforming

Large language models are very good at transforming its input to a different format, such as inputting a piece of text in one language and transforming it or translating it to a different language, or helping with spelling and grammar corrections. 

So taking as input a piece of text that may not be fully grammatical and helping you to fix that up a bit, or even transforming formats, such as inputting HTML and outputting JSON. So there's a bunch of applications that I used to write somewhat painfully with a bunch of regular expressions that would definitely be much more simply implemented now with a large language model and a few prompts. 

Yeah, I use ChatGPT to proofread pretty much everything I write these days, so I'm excited to show you some more examples in the notebook now. So first we'll import OpenAI and also use the same get_completion helper function that we've been using throughout the videos. 

And the first thing we'll do is a translation task. So large language models are trained on a lot of text from kind of many sources, a lot of which is the internet, and this is kind of, of course, in many different languages. So this kind of imbues the model with the ability to do translation. 

And these models know kind of hundreds of languages to varying degrees of proficiency. And so we'll go through some examples of how to use this capability. 

So let's start off with something simple. 

So in this first example, the prompt is translate the following English text to Spanish. "Hi, I would like to order a blender". And the response is "Hola, me gustaría ordenar una licuadora". 

And I'm very sorry to all of you Spanish speakers. I never learned Spanish, unfortunately, as you can definitely tell. 

Okay, let's try another example. So in this example, the prompt is "Tell me what language this is". And then this is in French, "Combien coûte le lampadaire". And so let's run this. 

And the model has identified that "This is French." The model can also do multiple translations at once. 

So in this example, let's say translate the following text to French and Spanish. 

And you know what? Let's add another an English pirate. And the text is "I want to order a basketball". 

So here we have French, Spanish and English pirate. So in some languages, the translation can change depending on the speaker's relationship to the listener. And you can also explain this to the language model. And so it will be able to kind of translate accordingly. 

So in this example, we say, "Translate the following text to Spanish in both the formal and informal forms". "Would you like to order a pillow?" And also notice here we're using a different delimiter than these backticks. It doesn't really matter as long as there's kind of a clear separation. 

So here we have the formal and informal. 

So formal is when you're speaking to someone who's maybe senior to you or you're in a professional situation. That's when you use a formal tone and then informal is when you're speaking to maybe a group of friends. I don't actually speak Spanish but my dad does and he says that this is correct. 

So for the next example, we're going to pretend that we're in charge of a multinational e-commerce company and so the user messages are going to be in all different languages and so users are going to be telling us about their IT issues in a wide variety of languages. 

So we need a universal translator. So first we'll just paste in a list of user messages in a variety of different languages. 

And now we will loop through each of these user messages. So "for issue in user_messages". And then I'm going to copy over this slightly longer code block. 

And so the first thing we'll do is ask the model to tell us what language the issue is in. So here's the prompt. Then we'll print out the original message's language and the issue. And then we'll ask the model to translate it into English and Korean. 

So let's run this. So the original message in French. So we have a variety of languages and then the model translates them into English and then Korean. 

And you can kind of see here, so the model says, "This is French". So that's because the response from this prompt is going to be "This is French". You could try editing this prompt to say something like tell me what language this is, respond with only one word or don't use a sentence, that kind of thing. If you wanted this to just be one word. Or you could ask for it in a JSON format or something like that, which would probably encourage it to not use a whole sentence. 

And so amazing, you've just built a universal translator. And also feel free to pause the video and add kind of any other languages you want to try here. Maybe languages you speak yourself and see how the model does. 

So, the next thing we're going to dive into is tone transformation. Writing can vary based on an intended audience, you know, the way that I would write an email to a colleague or a professor is obviously going to be quite different to the way I text my younger brother. 

And so, ChatGPT can actually also help produce different tones. So, let's look at some examples. So, in this first example, the prompt is "Translate the following from slang to a business letter". "Dude, this is Joe, check out this spec on the standing lamp." 

So, let's execute this. And as you can see, we have a much more formal business letter with a proposal for a standing lamp specification. 

The next thing that we're going to do is to convert between different formats. ChatGPT is very good at translating between different formats such as JSON to HTML, you know, XML, all kinds of things. Markdown. 

And so, in the prompt, we'll describe both the input and the output formats. So, here is an example. So, we have this JSON that contains a list of restaurant employees with their name and email. 

And then in the prompt, we're going to ask the model to translate this from JSON to HTML. So, the prompt is "Translate the following Python dictionary from JSON to an HTML table with column headers and title". And then we'll get the response from the model and print it. 

So, here we have some HTML displaying all of the employee names and emails. And so, now let's see if we can actually view this HTML. 

So, we're going to use this display function from this Python library, "display (HTML(response))". And here you can see that this is a properly formatted HTML table. 

The next transformation task we're going to do is spell check and grammar checking. And this is a really kind of popular use for ChatGPT. I highly recommend doing this, I do this all the time. And it's especially useful when you're working in a non-native language. And so here are some examples of some common grammar and spelling problems and how the language model can help address these. 

So I'm going to paste in a list of sentences that have some grammatical or spelling errors. 

And then we're going to loop through each of these sentences and ask the model to proofread these. Proofread and correct. 

And then we'll use some delimiters. And then we will get the response and print it as usual. And so the model is able to correct all of these grammatical errors. 

We could use some of the techniques that we've discussed before. So we could, to improve the prompt, we could say proofread and correct the following text. 

And rewrite. 

And rewrite the whole. 

And rewrite it. 

Corrected version. If you don't find any errors, just say no errors found. 

Let's try this. 

So this way we were able to, oh, they're still using quotes here. But you can imagine you'd be able to find a way with a little bit of iterative prompt development. To kind of find a prompt that works more reliably every single time. 

And so now we'll do another example. It's always useful to check your text before you post it in a public forum. And so we'll go through an example of checking a review. And so here is a review about a stuffed panda. And so we're going to ask the model to proofread and correct the review. 

Great. So we have this corrected version. 

And one cool thing we can do is find the kind of differences between our original review and the model's output. So we're going to use this redlines Python package to do this. And we're going to get the diff between the original text of our review and the model output and then display this. 

And so here you can see the diff between the original review and the model output and the kind of things that have been corrected. So, the prompt that we used was, "proofread and correct this review". But you can also make kind of more dramatic changes, changes to tone, and that kind of thing. 

So, let's try one more thing. So, in this prompt, we're going to ask the model to proofread and correct this same review, but also make it more compelling and ensure that it follows APA style and targets an advanced reader. And we're also going to ask for the output in markdown format. 

And so we're using the same text from the original review up here. So, let's execute this. And here we have an expanded APA style review of the softpanda. So, this is it for the transforming video. 

Next up, we have "Expanding", where we'll take a shorter prompt and kind of generate a longer, more freeform response from a language model.

大型语言模型非常擅长将其输入转换为不同的格式，例如输入一种语言的文本并将其转换或翻译为另一种语言，或帮助进行拼写和语法修正。

因此，输入的文本可能不完全符合语法规范，但它可以帮助您稍微修改一下，甚至可以转换格式，例如输入 HTML 并输出 JSON。有很多应用程序，我过去常常使用大量的正则表达式来编写，现在使用大型语言模型和一些提示会更简单。

是的，我现在几乎用 ChatGPT 校对我写的所有东西，所以我很兴奋地向您展示笔记本中的更多示例。首先，我们将导入 OpenAI，并使用我们在整个视频中一直使用的 get_completion 助手函数。

我们要做的第一件事是翻译任务。因此，大型语言模型在许多来源的大量文本上进行了训练，其中很多是互联网，这当然是用许多不同的语言。这使模型具有翻译能力。

这些模型知道有几百种语言，熟练程度各不相同。因此，我们将通过一些示例来说明如何使用此功能。

让我们从简单的东西开始。

因此，在这个例子中，提示是将以下英文文本翻译成西班牙文。"Hi, I would like to order a blender"。答复是「Hola, me gustaría ordenar una licuadora」。

很抱歉所有说西班牙语的人。不幸的是，我从未学过西班牙语，你肯定能知道。

好的，让我们再试一个例子。在这个例子中，提示是「告诉我这是什么语言」。然后这是法语，「Combien coûte le lampadaire」。让我们运行一下。

模型已确定「这是法语」。模型还可以一次执行多个翻译。

在这个例子中，让我们说将以下文本翻译成法文和西班牙文。

你知道吗？让我们再添加一个英语海盗。文本是「I want to order a basketball」。

因此，我们在这里有法语、西班牙语和英语海盗。在某些语言中，翻译可能会根据说话者与听众的关系而改变。您还可以向语言模型解释这一点。因此，它将能够相应地进行翻译。

所以在这个例子中，我们说：「将以下文本翻译成西班牙文的正式和非正式形式」。"Would you like to order a pillow?" 还要注意，我们在这里使用的分隔符与这些反引号不同。只要有明确的分隔就没关系。

因此，我们有正式和非正式的。

正式是当你与比你地位高的人或者在专业场合交谈时使用的。那时你使用正式语气，非正式则是当你与一群朋友交谈时。我实际上不会说西班牙语，但我的父亲会，他说这是正确的。

所以对于下一个例子，我们要假装我们负责一个跨国电商公司，所以用户消息将是用所有不同的语言，所以用户将用各种语言告诉我们他们的 IT 问题。

所以我们需要一个通用翻译器。首先，我们只是将各种不同语言的用户消息粘贴到一个列表中。

现在我们将遍历这些用户消息。所以 "for issue in user_messages"。然后我要复制这个稍微长一点的代码块。

所以我们首先要做的是请模型告诉我们问题是用什么语言的。所以这里是提示。然后我们会打印出原始消息的语言和问题。然后我们会要求模型将其翻译成英语和韩语。

让我们运行这个。所以原始消息是法语。所以我们有各种语言，然后模型将它们翻译成英语和韩语。

你可以看到，模型说：「这是法语」。这是因为这个提示的回应将是「这是法语」。你可以尝试编辑这个提示，比如告诉我这是什么语言，只用一个词回答，或者不用一个句子，那种事情。如果你想要这只是一个词。或者你可以要求以 JSON 格式提供，这可能会鼓励它不使用整个句子。

所以太棒了，你刚刚构建了一个通用翻译器。也请随时暂停视频，添加你想尝试的任何其他语言。也许是你自己说的语言，看看模型的表现如何。

所以，接下来我们要深入探讨的是语调转换。写作风格可能会根据预期的受众而有所不同，你知道，我写给同事或教授的电子邮件的方式显然与我发给我弟弟的短信的方式完全不同。

因此，ChatGPT 实际上也可以帮助产生不同的语调。那么，让我们来看一些例子。所以，在这第一个例子中，提示是「将以下的俚语翻译成商业信」。"Dude, this is Joe, check out this spec on the standing lamp."

那么，让我们执行这个。如你所见，我们有一个关于立式灯规格的更正式的商业信。

我们接下来要做的是在不同的格式之间转换。ChatGPT 非常擅长在不同的格式之间进行翻译，如 JSON 到 HTML，你知道，XML，各种东西。Markdown。

因此，在提示中，我们将描述输入和输出格式。所以，这里有一个例子。我们有这个 JSON，其中包含有关餐厅员工及其姓名和电子邮件的列表。

然后在提示中，我们将要求模型将此从 JSON 翻译为 HTML。所以，提示是「将以下 Python 字典从 JSON 翻译为带有列标题和标题的 HTML 表格」。然后我们会从模型中得到响应并打印出来。

所以，这里我们有一些显示所有员工姓名和电子邮件的 HTML。所以，现在让我们看看我们是否实际上可以查看这个 HTML。

所以，我们要使用这个 Python 库中的这个显示函数，"display (HTML (response))"。在这里你可以看到这是一个正确格式化的 HTML 表格。

接下来我们要做的转换任务是拼写检查和语法检查。这真的是 ChatGPT 的一个非常受欢迎的用途。我非常推荐这样做，我一直都在这样做。尤其是当你在一个非母语环境中工作时。所以这里有一些常见的语法和拼写问题的例子，以及语言模型如何帮助解决这些问题。

所以我要粘贴一系列句子，这些句子中有一些语法或拼写错误。

然后我们要遍历这些句子，并要求模型对这些进行校对。校对并纠正。

然后我们会使用一些分隔符。然后我们会像往常一样得到响应并打印出来。所以模型能够纠正所有这些语法错误。

我们可以使用之前讨论过的一些技术。所以，为了改进提示，我们可以说：校对并纠正以下文本。

然后重写。

整体重写。

对它进行重写。

更正后的版本。如果你没有发现任何错误，就说没有发现错误。

我们试试看。

这样我们就能够，哦，他们这里还在用引号。但你可以想象，经过一些迭代的提示开发，你会找到一种方法，使得提示每次都更可靠。

现在我们再来一个例子。在公开论坛发布之前检查你的文本总是很有用的。所以我们将通过检查一篇评论的例子。这里有一篇关于填充的熊猫的评论。所以我们要求模型校对并纠正评论。

很好。所以我们有这个更正后的版本。

一个很酷的事情是，我们可以找到我们原始评论和模型输出之间的差异。所以我们要用这个 redlines Python 包来做这个。我们会得到我们评论的原始文本和模型输出之间的差异，然后展示出来。

所以，你可以看到原始评论和模型输出之间的差异，以及已经被纠正的东西。我们使用的提示是：「校对并纠正这篇评论」。但你也可以做更戏剧性的变化，改变语气，之类的。

那么，我们再试一件事。在这个提示中，我们要求模型校对并纠正这篇相同的评论，但同时使其更有吸引力，确保它遵循 APA 风格，并针对高级读者。我们还要求以 markdown 格式输出。

所以我们使用了上面原始评论的相同文本。那么，我们执行这个。这里我们有一个关于 softpanda 的扩展 APA 风格的评论。所以，这就是变形视频的内容。

接下来，我们有「扩展」，在那里我们会从一个较短的提示开始，然后从语言模型中生成一个更长、更自由形式的回应。
