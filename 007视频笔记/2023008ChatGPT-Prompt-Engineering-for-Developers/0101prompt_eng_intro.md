## 0101. prompt_eng_intro

Welcome to this course on ChatGPT Prompt Engineering for Developers.

I'm thrilled to have with me Isa Fulford to teach this along with me. She is a member of the technical staff of OpenAI and had built the popular ChatGPT Retrieval plugin and a large part of her work has been teaching people how to use LLM or Large Language Model technology in products. She's also contributed to the OpenAI Cookbook that teaches people prompting. So thrilled to have you with me. 

And I'm thrilled to be here and share some prompting best practices with you all. 

So, there's been a lot of material on the internet for prompting with articles like 30 prompts everyone has to know. A lot of that has been focused on the chatGPT web user interface, which many people are using to do specific and often one-off tasks. But, I think the power of LLMs, large language models, as a developer tool, that is using API calls to LLMs to quickly build software applications, I think that is still very underappreciated. 
 
In fact, my team at AI Fund, which is a sister company to DeepLearning.ai, has been working with many startups on applying these technologies to many different applications, and it's been exciting to see what LLM APIs can enable developers to very quickly build. So, in this course, we'll share with you some of the possibilities for what you can do, as well as 
best practices for how you can do them. 

There's a lot of material to cover. First, you'll learn some prompting best practices for software development, then we'll cover some common use cases, summarizing, inferring, transforming, expanding, and then you'll build a chatbot using an LLM. We hope that this will spark your imagination about new applications that you can build. 

So in the development of large language models or LLMs, there have been broadly two types of LLMs, which I'm going to refer to as base LLMs and instruction-tuned LLMs. 

So, base LLM has been trained to predict the next word based on text training data, often trained on a large amount of data from the internet and other sources to figure out what's the next most likely word to follow. So, for example, if you were to prompt us once upon a time there was a unicorn, it may complete this, that is it may predict the next several words are that live in a magical forest with all unicorn friends. 

But if you were to prompt us with what is the capital of France, then based on what articles on the internet might have, it's quite possible that the base LLM will complete this with what is France's largest city, what is France's population and 
so on, because articles on the internet could quite plausibly be lists of quiz questions about the country of France. 

In contrast, an instruction-tuned LLM, which is where a lot of momentum of LLM research and practice has been going, an 
instruction-tuned LLM has been trained to follow instructions. So, if you were to ask it what is the capital of France, it's much more likely to output something like, the capital of France is Paris. So the way that instruction-tuned LLMs are typically trained is you start off with a base LLM that's been trained on a huge amount of text data and further train 
it, further fine-tune it with inputs and outputs that are instructions and good attempts to follow those instructions, and then often further refine using a technique called RLHF, reinforcement learning from human feedback, to make the system better able to be helpful and follow instructions. 

Because instruction-tuned LLMs have been trained to be helpful, honest, and harmless, so for example, they are less likely to output problematic text such as toxic outputs compared to base LLM, a lot of the practical usage scenarios have been shifting toward instruction-tuned LLMs. Some of the best practices you find on the internet may be more suited for a 
base LLM, but for most practical applications today, we would recommend most people instead focus on instruction-tuned LLMs which are easier to use and also, because of the work of OpenAI and other LLM companies becoming safer and more aligned. 

So, this course will focus on best practices for instruction-tuned LLMs, which is what we recommend you use for most of your applications. Before moving on, I just want to acknowledge the team from OpenAI and DeepLearning.ai that had contributed to the materials that Isa and I will be presenting. 

I'm very grateful to Andrew Mayne, Joe Palermo, Boris Power, Ted Sanders, and Lillian Weng from OpenAI that were very involved with us brainstorming materials, vetting the materials to put together the curriculum for this short course, and I'm also grateful on the DeepLearning side for the work of Geoff Lodwig, Eddy Shyu and Tommy Nelson. So, when you use an instruction-tuned LLM, think of giving instructions to another person, say someone that's smart but doesn't know the specifics of your task. 

So, when an LLM doesn't work, sometimes it's because the instructions weren't clear enough. For example, if you were to say, please write me something about Alan Turing. Well, in addition to that, it can be helpful to be clear about whether you want the text to focus on his scientific work or his personal life or his role in history or something else. And if you specify what you want the tone of the text to be, should it take on the tone like a professional journalist would write. Or is it more of a casual note that you dash off to a friend? 

That helps the LLM generate what you want. And of course, if you picture yourself asking, say, a fresh college graduate to carry out this task for you, if you can even specify what snippets of text, they should read in advance to write this text about Alan Turing, then that even better sets up that fresh college grad for success to carry out this task for you. So, in the next video, you see examples of how to be clear and specific, which is an important principle of prompting LLMs. And you 
also learn from Isa a second principle of prompting that is giving the LLM time to think. So with that, let's go on to the next video. 

欢迎参加面向开发者的 ChatGPT 提示工程课程。

我很高兴能与 Isa Fulford 一起教授这门课程。她是 OpenAI 的技术员工，并且构建了受欢迎的 ChatGPT 检索插件，她的大部分工作都是教人们如何在产品中使用 LLM 或大型语言模型技术。她还为教人们进行提示的 OpenAI Cookbook 做出了贡献。很高兴你能和我一起。

我也很高兴能在这里与大家分享一些提示的最佳实践。

因此，互联网上有很多关于提示的资料，比如每个人都应该知道的 30 个提示。其中很多都集中在 ChatGPT 网络用户界面上，许多人使用它来执行特定的、经常是一次性的任务。但是，我认为 LLMs，即大型语言模型，作为一种开发工具，即使用 LLM 的 API 调用快速构建软件应用，这仍然被严重低估。

事实上，我的团队在 AI Fund（它是 DeepLearning.ai 的姐妹公司）已经与许多初创公司合作，将这些技术应用于许多不同的应用程序，看到 LLM API 能使开发者很快地建立什么真的很令人兴奋。因此，在这门课程中，我们将与您分享您可以做什么的一些可能性，以及您如何做的最佳实践。

有很多材料要涵盖。首先，你将学习一些针对软件开发的提示最佳实践，然后我们将介绍一些常见的用例，总结、推断、转化、扩展，然后你将使用 LLM 构建一个聊天机器人。我们希望这会激发你对你可以构建的新应用程序的想象力。

所以在大型语言模型或 LLMs 的开发中，大致上有两种类型的 LLMs，我将其称为基础 LLMs 和指令调谐 LLMs。

所以，基础 LLM 已经被训练来根据文本训练数据预测下一个单词，通常是基于从互联网和其他来源的大量数据来推断接下来最可能的单词。所以，例如，如果你提示我们「从前有一次，有一只独角兽」，它可能会完成这个，也就是说，它可能预测接下来的几个词是「它住在一个与所有独角兽朋友一起的魔法森林里」。

但是，如果你提示我们「法国的首都是什么」，那么根据互联网上的文章，基础 LLM 很可能会完成这个，答案是「法国的最大城市是什么，法国的人口是多少」等等，因为互联网上的文章很可能是关于法国的测验问题列表。

相反，一个指令调谐的 LLM，这是 LLM 研究和实践的大部分动力所在，一个指令调谐的 LLM 已经被训练来遵循指令。所以，如果你问它「法国的首都是什么」，它更有可能输出「法国的首都是巴黎」。指令调谐 LLM 通常的训练方式是，你从一个已经在大量的文本数据上训练过的基础 LLM 开始，然后进一步训练它，进一步微调它，输入和输出是指令和遵循这些指令的好尝试，然后经常使用一种称为 RLHF 的技术进一步精炼，即从人类反馈中学习强化学习，使系统更能够提供帮助和遵循指令。

因为指令调谐的 LLM 已经被训练为有帮助、诚实和无害的，所以例如，与基础 LLM 相比，它们不太可能输出有问题的文本，如有毒的输出，很多实际的使用场景已经转向指令调谐的 LLM。你在互联网上找到的一些最佳实践可能更适合基础 LLM，但是对于今天的大多数实际应用，我们建议大多数人更关注指令调谐的 LLM，这些 LLM 更容易使用，而且由于 OpenAI 和其他 LLM 公司的工作，它们变得更安全和更有针对性。

所以，这门课程将重点介绍指令调谐 LLM 的最佳实践，这也是我们推荐您在大多数应用中使用的方法。在继续之前，我想感谢 OpenAI 和 DeepLearning.ai 的团队为 Isa 和我即将呈现的材料做出的贡献。

我非常感谢 OpenAI 的 Andrew Mayne、Joe Palermo、Boris Power、Ted Sanders 和 Lillian Weng 与我们一起集思广益、审查材料，为这个短课程制定课程大纲，我也非常感谢 DeepLearning 方面的 Geoff Lodwig、Eddy Shyu 和 Tommy Nelson 的工作。所以，当你使用一个指令调谐的 LLM 时，想象你正在给另一个人发指令，比如说一个聪明但不知道你任务细节的人。

所以，当一个 LLM 不起作用时，有时是因为指令不够清晰。例如，如果你说：「请为我写一些关于 Alan Turing 的内容。」此外，明确指出你希望文本重点放在他的科学工作、他的个人生活、他在历史中的角色或其他内容上可能会更有帮助。如果你指定你希望文本的语调是什么，它应该采取一个专业记者的语调还是更像你随手写给朋友的随便的便条？

这有助于 LLM 生成你想要的内容。当然，如果你想象自己请一个刚刚毕业的大学生为你完成这个任务，如果你甚至可以指定他们应该事先阅读哪些文本片段，然后为你写这篇关于 Alan Turing 的文本，那么这甚至更好地为那个刚刚毕业的大学生设置了成功完成这个任务的条件。所以，在下一个视频中，你将看到如何清晰和具体，这是提示 LLM 的一个重要原则。而你也会从 Isa 那里学到提示的第二个原则，那就是给 LLM 时间思考。有了这些，让我们继续下一个视频。