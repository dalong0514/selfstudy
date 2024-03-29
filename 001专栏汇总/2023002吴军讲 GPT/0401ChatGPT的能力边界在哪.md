## 0401. ChatGPT 的能力边界在哪

上一讲，我们详细说了语言模型的进化历史。

ChatGPT 在今天被热炒，主要的原因不是因为它能和人聊天，或者能帮助人做作业。其实做作业这件事它做得并不好，虽然有些中学和大学的问题它能够解决，但是对于绝大部分问题，它给出的答案都是车轱辘话。

那 ChatGPT 被热炒的原因是什么呢？其实，ChatGPT 真正可怕的地方在于，按照当前的速度发展下去，不断扩大应用领域，它可能可以解决很多原本需要人类才能解决的问题。

现在问题来了，都有哪些问题是 ChatGPT 能解决的？哪些是它不能解决的呢？

前面说了，ChatGPT 的基础是语言模型，因此，它的极限也被语言模型的极限所限制。这一讲，我们就看看语言模型都能做什么事情。理解了这个问题，你也就知道了 ChatGPT 的能力边界。

我把语言模型能做的事情分为三类：

### 4.1 第一类：信息形式转换

第一类是将信息从一种形式转换为另一种形式，无论是语音识别还是机器翻译，都属于这一类。

在语音识别中，输入的信息是语音声波，输出的信息是文字，它们是一一对应的，因此是信息在形式上的转化。机器翻译也是如此，是从一种语言的编码，转换成另一种语言的编码。

不过值得指出的是，任何形式的信息转换通常都会损失一些信息。比如，在机器翻译中，语言中所蕴含的文化常常就损失掉了。这倒不是机器的问题，在用人进行的翻译的时候，也经常会出现这种现象。比如，唐诗翻译成英语往往就显得乏味，英文的诗歌翻译成中文，也常常显得平淡无奇。有些贯通中西的翻译家，会试图把文化的元素加回去，但是计算机做不到这一点。

在这一类事情中，一个通常不被人们注意的应用是在医学领域，比如基因测序。

任何物种的 DNA 都是四种碱基 ATCG 的组合，当然，它们不是随意排列的，并非所有的组合都是合理的。比如，不同物种同一功能的碱基片段其实是差不多的，每一个基本的单元就有点像文本中的文字。因此，根据一段碱基，有时候就能识别下一段碱基。

当我们进行基因测序时，要把缠绕在一起的 DNA 序列剪开，一段段地识别。而剪开的时候，就有可能剪坏，因此，通常都是把 DNA 复制很多份，剪开以后做对比，以免每一份都没有剪好，识别错了。

当然，对于没有剪好，或者识别得不是很清楚的片段，就可以通过语言模型识别、纠正错误。只不过这项工作所使用的语言模型是基于碱基对的，不是基于文字的。

此外，还有一件事也属于这个范畴，就是让计算机写简单的程序。

2014 年，著名的机器翻译专家奥科在离开 Google 之前领导过这样一个项目，就是让人把要做的事情描述清楚，然后让计算机写 Python 程序。

奥科的想法很简单，既然能够让计算机将一种人类语言的文本翻译成另一种人类语言的文本，就应该能将自然语言描述的文本翻译成机器语言的脚本，也就是程序。

在 2014 年的时候，奥科的团队已经能把功能描述清楚的简单任务书变成 Python 程序。不过，当时的困难是，人其实也无法把自己的想法非常准确地用自然语言写清楚。

从信息论的角度看，如果有了完美的算法，这一大类问题都可以得到完美的解决。对于这些事情，最终人是做不过机器的。

### 4.2 第二类：根据要求产生文本

语言模型能做的第二类事情是根据要求产生文本。今天 ChatGPT 做的主要工作，像回答问题、回复邮件、书写简单的段落，都属于这一类。

这一类工作，输入的信息量明显少于输出的信息量。从信息论的角度看，这会产生很大的不确定性，需要额外补充信息。而补充的信息的来源，其实就是语言模型中所包含的信息。因此，如果语言模型中包含了某个话题的很多相关信息，它就可以产生高质量的文本；否则，它给出的答案或者所写的内容就不着边际。

这一类应用对于语言模型来讲是最难的。这倒不是因为语言模型做得不够好，而是因为站在信息论的角度看，不可能通过少量信息得出更多的信息。因此，这类工作其实或多或少都需要人工干预。

今天，除了 ChatGPT，还有很多类似的写作软件，它们写出来的内容看上去都不错。但是，在这些软件背后，其实有一个由人组成的编辑团队，他们会从几十篇候选文章中挑出一篇提供给用户。今天，在硅谷地区还有一些评估内容质量的外包公司，他们有专人评估计算机产生的文本质量，然后反馈给计算机继续学习、改进。

我就 ChatGPT 的写作水平，专门询问了两位 ChatGPT 的深度用户。他们本身就是研究机器学习的博士，出于工作的需要，天天都在分析 ChatGPT 的写作水平。

他们告诉我，一种最大化的发挥 ChatGPT 写作能力的做法，就是你和它反复迭代。他们是这样做的：

先给 ChatGPT 提要求，让它写一篇文章。绝大部分人到此为止了，但是他们会对机器写的文章提出新的修改要求，然后它就会重新给你写，然后你再提要求。这样一来二去，几次迭代下来，文章质量就大有提高了。

这两个人一个是美国人，一个是中国人，他们对 ChatGPT 最终写出来的文章评价差异还是很大的：美国人认为，质量一般，可以作为邮件发出，但不精彩，不能作为自己的写作，否则别人会觉得自己水平太低；而中国人因为母语不是英语，觉得它写得不错，省了自己很多时间，虽然同样水平的文章他也能写出，但是可能要花更多的时间选择用词和语法。

当然，有人可能会觉得，ChatGPT 对于一些专业问题给出的答案，甚至比专家还好。这种现象是存在的，正如我们前面所讲，它学过的知识可能是我们的成千上万倍。但那是因为其他专家已经就所提出的问题进行过了研究，有现成的知识可以提供给它。

比如，你如果问计算机「天为什么是蓝色的」，能得到完美的答案，那是因为之前有物理学家进行了研究，并且他们的解释得到了更多物理学家的认可。也就是说，还是有人工干预在先。甚至于很多问题，其实在互联网上就有比较好的问题答案配对。ChatGPT 这一类软件只是把它们整理出来。

相反，硅谷几家大公司的研究发现：ChatGPT 做小学算术应用题，甚至参加一些语文考试，比它参加高中的 AP 课考试，以及研究生入学考试，比如医学院的 MCAT 考试，成绩要差得多。原因就是，那些小学生的题它没见过，而 AP 课和 MCAT 考试都是标准化的，有很多过去的考试题可以找到。

不过，虽然 ChatGPT 不能自己创造答案，但它还是很有价值的，它可以减少人的工作量。这就如同你在参加物理考试时，计算器可以节省时间一样。但是如果你不懂物理学的内容，即便有了趁手的工具，也照样考不出来。

### 4.3 第三类：信息精简

语言模型能做的第三类事情是把更多的信息精简为较少的信息。

比如，为一篇长文撰写摘要，按照要求进行数据分析，分析上市公司的财报，都属于这方面的工作。

这一类工作，输入的信息多，输出的信息少，因此只要算法做得好，就不会出现信息不够用的问题。

将信息由多变少，就会面临一个选择，选择保留哪些信息，删除哪些信息。

比如，为一本书写摘要，不同的人会写出不同的摘要，他们对于书中哪些是重点内容、哪些是次要内容会有不同的看法。类似的，对于某个上市公司的季度财报，不同的分析师会有不同的看法，他们会按照自己的想法挑选数据作为证据。

同样的，把更多的信息进行精简，也会得出不同的结果，这就要看算法是如何设计的，它所依赖的语言模型之前都统计过什么样的信息等等。

对于这一类工作，最终计算机会做得比大部分人更好。这不仅是因为计算机阅读和处理数据快，语言模型强大，更是因为它在做摘要、做分析或者剪辑视频时，能够做到比人客观。

比如，今天很多人分析财报，会有先入为主的看法，然后根据自己的看法选择数据，有意无意忽略那些重要但不合自己想法的数据。还有很多人在做摘要时，喜欢断章取义。这些问题，计算机通常都能够避免。

但是，计算机的算法也有一个问题，就是缺乏个性化。

我们人类，通常不同的人对于同一本书会有不同的看法。同样是阅读《红楼梦》，有的人把它当作宝黛爱情故事来读，有的人把它当作官僚家庭的生活来读，也有人将它当作中国农耕社会的缩影来读。类似地，同样是将一部电影剪辑成短片，不同人挑选的片段也会不同。

但是，机器做这种事情，结果都是千篇一律的。

这就如同生产线出现之前，手工制作的产品，每一件都有自己的特点；而大机器生产之后，所有的产品都是标准化的。

但是总的来讲，在这方面，人是做不过机器的。这就如同绝大部分手工产品的质量都不如大机器生产的好那样。

### 4.4 前景展望

ChatGPT 和同类的产品，目前已经能完成上面说的大部分工作，虽然有时候做得还不是很好。不过，由于它进步的速度非常快，所以在未来，肯定可以完成更多的工作，对现有能做的工作也会做得更好。

2019 年的时候，著名的人工智能专家（也是我的师兄）郭毅可院士做过这样的估计：

2024 年，计算机能够对描述非常清晰的任务进行编程；

2026 年，完成中学生水平的作文；

2028 年，编辑视频；

2049 年，创作最畅销的小说。

郭毅可院士自己还做了一个项目，就是让计算机根据歌曲《东方之珠》生成了一部几分钟的电视片，并且在香港表演了。

这个电视片的内容和画面，实际上是对《东方之珠》歌词的理解和视频化翻译。很多视频画面超出了人的想象，但也有些地方理解得还很肤浅，停留在字面上。比如，它把东方之珠的「珠」字理解为大水滴，因此在唱到「东方之珠」时，画面是一个不断变化的水滴。

了解了 ChatGPT 能做什么事情，擅长做什么事情，我们就知道如何取长补短了。比如，今天有很多从别人文章中摘出几句话，做一个短视频到抖音上挣流量的人，今后这些内容就不用人来做了，机器可以做得更好。

下节预告

下一讲，我们就来具体看看，ChatGPT 和类似的产品是如何回答大家的问题的。