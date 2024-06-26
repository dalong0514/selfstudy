## 2024026The-Prompt-Report-A-Systematic-Survey-of-Prompting-Techniques

The Prompt Report: A Systematic Survey of Prompting Techniques

### Abstract

Generative Artificial Intelligence (GenAI) systems are being increasingly deployed across all parts of industry and research settings. Developers and end users interact with these systems through the use of prompting or prompt engineering. While prompting is a widespread and highly researched concept, there exists conflicting terminology and a poor ontological understanding of what constitutes a prompt due to the area's nascency. This paper establishes a structured understanding of prompts, by assembling a taxonomy of prompting techniques and analyzing their use. We present a comprehensive vocabulary of 33 vocabulary terms, a taxonomy of 58 text-only prompting techniques, and 40 techniques for other modalities. We further present a meta-analysis of the entire literature on natural language prefix-prompting.

生成式人工智能（Generative Artificial Intelligence, GenAI）系统在各行各业和研究领域的应用越来越广泛。开发者和用户通过提示或提示工程与这些系统互动。尽管提示是一个备受关注和研究的概念，但由于这一领域尚处于初期阶段，相关术语存在混乱，且对提示的理解不够清晰。本文旨在通过整理提示技术的分类，并分析其应用，建立对提示的系统性认识。我们提出了一个包含 33 个术语的词汇表，分类了 58 种仅限文本的提示技术，以及 40 种适用于其他模态的技术。我们还对自然语言前缀提示的全部文献进行了元分析。

### 01. Introduction

Transformer-based LLMs are widely deployed in consumer-facing, internal, and research settings (Bommasani et al., 2021). Typically, these models rely on the user providing an input "prompt" to which the model produces an output in response. Such prompts may be textual—"Write a poem about trees."—or take other forms: images, audio, videos, or a combination thereof. The ability to prompt models, particularly prompting with natural language, makes them easy to interact with and use flexibly across a wide range of use cases.

Knowing how to effectively structure, evaluate, and perform other tasks with prompts is essential to using these models. Empirically, better prompts lead to improved results across a wide range of tasks (Wei et al., 2022; Liu et al., 2023b; Schulhoff, 2022). A large body of literature has grown around the use of prompting to improve results and the number of prompting techniques is rapidly increasing. 

However, as prompting is an emerging field, the use of prompts continues to be poorly understood, with only a fraction of existing terminologies and techniques being well-known among practitioners. We perform a large-scale review of prompting techniques to create a robust resource of terminology and techniques in the field. We expect this to be the first iteration of terminologies that will develop over time.

Scope of Study We create a broad directory of prompting techniques, which can be quickly understood and easily implemented for rapid experimentation by developers and researchers. To this end, we limit our study to focus on discrete prefix prompts (Shin et al., 2020a) rather than cloze prompts (Petroni et al., 2019; Cui et al., 2021), because modern LLM architectures (especially decoder-only models), which use prefix prompts, are widely used and have robust support for both consumers and researchers. Additionally, we refined our focus to hard (discrete) prompts rather than soft (continuous) prompts and leave out papers that make use of techniques using gradient-based updates (i.e. fine-tuning). Finally, we only study task-agnostic techniques. These decisions keep the work approachable to less technical readers and maintain a manageable scope.

Sections Overview We conducted a machine-assisted systematic review grounded in the PRISMA process (Page et al., 2021) (Section 2.1) to identify 58 different text-based prompting techniques, from which we create a taxonomy with a robust terminology of prompting terms (Section 1.2). 

While much literature on prompting focuses on English-only settings, we also discuss multilingual techniques (Section 3.1). Given the rapid growth in multimodal prompting, where prompts may include media such as images, we also expand our scope to multimodal techniques (Section 3.2). Many multilingual and multimodal prompting techniques are direct extensions of English text-only prompting techniques.

As prompting techniques grow more complex, they have begun to incorporate external tools, such as Internet browsing and calculators. We use the term 'agents' to describe these types of prompting techniques (Section 4.1). 

It is important to understand how to evaluate the outputs of agents and prompting techniques to ensure accuracy and avoid hallucinations. Thus, we discuss ways of evaluating these outputs (Section 4.2). We also discuss security (Section 5.1) and safety measures (Section 5.2) for designing prompts that reduce the risk of harm to companies and users.

Finally, we apply prompting techniques in two case studies (Section 6.1). In the first, we test a range of prompting techniques against the commonly used benchmark MMLU (Hendrycks et al., 2021). In the second, we explore in detail an example of manual prompt engineering on a significant, real-world use case, identifying signals of frantic hopelessness–a top indicator of suicidal crisis–in the text of individuals seeking support (Schuck et al., 2019a). We conclude with a discussion of the nature of prompting and its recent development (Section 8).

1 引言

基于 Transformer 的大语言模型（LLM）在消费者应用、内部系统和研究环境中广泛使用（Bommasani et al., 2021)。通常，这些模型需要用户提供一个「提示」，模型根据提示生成响应。这些提示可以是文本，比如「写一首关于树的诗。」，也可以是图像、音频、视频或它们的组合。特别是自然语言提示，使得这些模型易于使用，并能灵活应用于各种场景。

掌握如何有效地构建、评估和使用提示对于使用这些模型至关重要。实验证明，更好的提示在多种任务中能带来更好的结果（Wei et al., 2022; Liu et al., 2023b; Schulhoff, 2022)。围绕提示技术的研究文献大量增加，提示技术的种类也迅速扩展。

然而，由于提示（prompting）是一个新兴领域，提示的使用仍然没有被充分理解，现有术语和技术只有一小部分被从业者所熟知。我们进行了大规模的提示技术回顾，以创建该领域术语和技术的强大资源。我们期望这是术语发展的第一阶段，未来将逐渐完善。

研究范围我们创建了一个广泛的提示技术目录，开发者和研究人员可以快速理解并轻松实施以进行快速实验。为此，我们将研究重点放在离散前缀提示（Shin et al., 2020a）上，而不是填空提示（Petroni et al., 2019; Cui et al., 2021)，因为现代大语言模型（尤其是只使用解码器的模型）使用前缀提示，广泛应用并且对消费者和研究人员都有强大的支持。此外，我们将重点细化到硬（离散）提示，而不是软（连续）提示，并且排除使用基于梯度更新（即微调）技术的论文。最后，我们只研究与任务无关的技术。这些决策使得工作对技术水平较低的读者更易理解，并保持一个可管理的范围。

章节概述我们基于 PRISMA 流程（Page et al., 2021）(第 2.1 节）进行了机器辅助系统回顾，识别了 58 种不同的基于文本的提示技术，我们从中创建了一个具有强大术语的提示术语分类法（第 1.2 节)。

尽管大量关于提示的文献集中在仅限英语的设置上，我们还讨论了多语言技术（第 3.1 节)。鉴于多模态提示的快速增长，其中提示可能包含图像等媒体，我们还将范围扩展到多模态技术（第 3.2 节)。许多多语言和多模态提示技术是英语文本提示技术的直接扩展。

随着提示技术的不断进步，它们开始结合外部工具，如互联网浏览和计算器。我们将这种类型的提示技术称为「智能体（agents)」（第 4.1 节）。

理解如何评估智能体和提示技术的输出，以确保其准确性并避免出现幻觉是非常重要的。为此，我们讨论了评估这些输出的方法（第 4.2 节）。此外，我们还探讨了设计提示时的安全性（第 5.1 节）和保护措施（第 5.2 节），以减少对公司和用户的潜在风险。

最后，我们在两个案例研究中展示了提示技术的应用（第 6.1 节）。在第一个案例中，我们使用常见的基准 MMLU（Hendrycks et al., 2021）测试了一系列提示技术。在第二个案例中，我们详细研究了手动提示工程在一个重要的实际应用中的表现，具体是识别寻求帮助的个人文本中表露出的绝望迹象 —— 这是自杀危机的主要指标之一（Schuck et al., 2019a）。我们在第 8 节总结了提示技术的本质及其最新进展。

1.1 What is a Prompt?

A prompt is an input to a Generative AI model, that is used to guide its output (Meskó, 2023; White et al., 2023; Heston and Khun, 2023; Hadi et al., 2023; Brown et al., 2020). Prompts may consist of text, image, sound, or other media. Some examples of prompts include: "write a three paragraph email for a marketing campaign for an accounting firm", a photograph of a table accompanied by the text "describe everything on the table", or a recording of an online meeting, with the instructions "summarize this".

Prompt Template Prompts are often constructed via a prompt template (Shin et al., 2020b). A prompt template is a function that contains one or more variables which will be replaced by some media (usually text) to create a prompt. This prompt can then be considered to be an instance of the template. 

Consider applying prompting to the task of binary classification of tweets. Here is an initial prompt template that can be used to classify inputs.

Classify the tweet as positive or negative: {TWEET} 

Each tweet in the dataset would be inserted into a separate instance of the template and the resulting prompt would be given to a LLM for inference.






1.1 什么是提示？

提示是生成式 AI（Generative AI）模型的输入，用于指导其输出（Meskó, 2023；White et al., 2023；Heston 和 Khun, 2023；Hadi et al., 2023；Brown et al., 2020）。提示可以是文本、图像、声音或其他媒体。例如，可以是「为会计师事务所的营销活动撰写一封三段的电子邮件」，也可以是一张桌子的照片，附有「描述桌子上的所有物品」的文字，或者是一次在线会议的录音，并附有「总结这次会议」的指令。

提示模板提示通常通过提示模板来构建（Shin et al., 2020b）。提示模板是包含一个或多个变量的函数，这些变量会被一些媒体（通常是文本）替换，从而生成提示。这个提示可以看作是模板的一个实例。

考虑使用提示词进行推特的二分类任务。下面是一个可以用于分类输入的初始提示模板。

请将以下推特分类为正面或负面：{TWEET}

数据集中的每条推特都会插入到模板的独立实例中，然后将生成的提示提供给大语言模型（LLM）进行推理。

1.2 术语

1.2.1 提示词的组成部分提示词中包含各种常见的组成部分。我们总结了最常用的组成部分，并讨论了它们如何适用于提示词。

指令许多提示词以指令或问题的形式发布指令。这是提示词的核心部分，有时也称为「意图」。例如，这是一个带有单个指令的提示词示例：

告诉我五本好书。

指令也可以是隐含的，如在这个少样本的情况下，指令是进行英语到西班牙语翻译：

Night：Noche 
Morning:

示例示例，也称为样本，作为指导生成式 AI（GenAI）完成任务的演示。上述提示词是一个少样本（即一个示例）提示词。

输出格式通常希望生成式 AI 以某些格式输出信息，例如 CSV 或 Markdown 格式（Xia et al., 2024)。为了实现这一点，您可以简单地添加指令，如下所示：

{PARAGRAPH}
将其总结为一个 CSV。

样式指令样式指令是一种输出格式，用于在风格上而非结构上修改输出（第 2.2.2 节)。例如：

写一段简明扼要的关于羊驼的段落。

角色角色，也称为人物（Schmidt et al., 2023; Wang et al., 2023l)，是一个经常讨论的组成部分，可以改善写作和文本风格（第 2.2.2 节)。例如：

假装你是一个牧羊人，写一首关于羊驼的打油诗。

附加信息在提示中，通常需要包括一些附加信息。例如，如果指示是写一封电子邮件，您可能需要包括您的姓名和职位，这样生成式 AI（GenAI）才能正确地签署电子邮件。附加信息有时被称为「上下文」，但我们不鼓励使用这个术语，因为在提示领域它有其他含义。

1.2.2 提示术语提示技术相关的术语正在快速发展。目前，有许多定义不明确的术语（例如 prompt，prompt engineering）和相互矛盾的术语（例如 role prompt 和 persona prompt）。缺乏一致的词汇表阻碍了社区准确描述各种提示技术。我们提供了提示社区常用术语的详细词汇表（图 1.3），较少使用的术语则放在附录 A.2。为了准确定义常用术语（如 prompt 和 prompt engineering），我们整合了多个定义（见附录 A.1）以得出代表性定义。

提示提示是向生成式 AI 提供指令的过程，以便它生成响应。例如，发送一段文本或上传一张图片都属于提示。

提示链提示链（活动：提示链）是指两个或多个提示模板连续使用。第一个提示模板生成的结果会用来设置第二个模板的参数，依此类推，直到所有模板都使用完毕（Wu et al., 2022）。

提示技术提示技术是一种设计方案，描述了如何构建和使用提示，或者多个提示的动态序列。提示技术可能包含条件分支逻辑、并行执行等跨多个提示的架构考虑。

Prompt Engineering

Prompt engineering 是一个迭代过程，通过修改或改变提示技术来开发更好的提示（图 1.4)。

Prompt Engineering Technique

Prompt engineering 技术是一种通过不断改进提示的方法。在学术文献中，这通常是自动化技术（Deng et al., 2022)，但在日常使用中，用户通常手动进行提示工程。

Exemplar

Exemplars 是在提示中提供给模型的任务示例（Brown et al., 2020)。

1.3 A Short History of Prompts

在 GPT-3 和 ChatGPT 之前，就已经有使用自然语言前缀或提示来引导语言模型行为和响应的想法。GPT-2（Radford et al., 2019a）使用了提示，并且它们似乎最早在生成式 AI（Generative AI）的研究中由 Fan et al.（2018）提出。然而，提示的概念之前还有相关的控制代码（Pfaff, 1979; Poplack, 1980; Keskar et al., 2019）和写作提示等概念。

术语 Prompt Engineering 似乎最近才由 Radford et al.（2021）提出，稍后被 Reynolds 和 McDonell（2021）采用。

然而，许多论文在没有明确使用该术语的情况下进行了提示工程（Wallace et al., 2019; Shin et al., 2020a)，包括 Schick 和 Schütze（2020a,b); Gao et al.（2021）对非自回归语言模型的研究。

一些早期的研究对提示的定义与现在略有不同。例如，请看以下来自 Brown et al.（2020）的提示：

将英语翻译成法语： 
llama

Brown et al.（2020）认为 "llama" 是提示，而 "Translate English to French:" 是任务描述。最新的研究通常将传递给大语言模型（LLM）的整个字符串称为提示。

1.2 Terminology

1.2.1 Components of a Prompt

There are a variety of common components included in a prompt. We summarize the most commonly used components and discuss how they fit into prompts.

Directive Many prompts issue a directive in the form of an instruction or question. This is the core intent of the prompt, sometimes simply called the "intent". For example, here is an example of a prompt with a single instruction:

Tell me five good books to read.

Directives can also be implicit, as in this one-shot case, where the directive is to perform English to Spanish translation:

Night: Noche 
Morning:

Examples Examples, also known as exemplars or shots, act as demonstrations that guide the GenAI to accomplish a task. The above prompt is a One-Shot (i.e. one example) prompt.

Output Formatting It is often desirable for the GenAI to output information in certain formats, for example, CSVs or markdown formats (Xia et al., 2024). To facilitate this, you can simply add instructions to do so as seen below:

{PARAGRAPH}
Summarize this into a CSV.

Style Instructions Style instructions are a type of output formatting used to modify the output stylistically rather than structurally (Section 2.2.2). For example:

Write a clear and curt paragraph about llamas.

Role A Role, also known as a persona (Schmidt et al., 2023; Wang et al., 2023l), is a frequently discussed component that can improve writing and style text (Section 2.2.2). For example:

Pretend you are a shepherd and write a limerick about llamas.

Additional Information It is often necessary to include additional information in the prompt. For example, if the directive is to write an email, you might include information such as your name and position so the GenAI can properly sign the email. Additional Information is sometimes called 'context', though we discourage the use of this term as it is overloaded with other meanings in the prompting space.

1.2.2 Prompting Terms

Terminology within the prompting literature is rapidly developing. As it stands, there are many poorly understood definitions (e.g. prompt, prompt engineering) and conflicting ones (e.g. role prompt vs persona prompt). The lack of a consistent vocabulary hampers the community's ability to clearly describe the various prompting techniques in use. We provide a robust vocabulary of terms used in the prompting community (Figure 1.3). Less frequent terms are left to Appendix A.2. In order to accurately define frequently-used terms like prompt and prompt engineering, we integrate many definitions (Appendix A.1) to derive representative definitions.

Prompting Prompting is the process of providing a prompt to a GenAI, which then generates a response. For example, the action of sending a chunk of text or uploading an image constitutes prompting.

Prompt Chain A prompt chain (activity: prompt chaining) consists of two or more prompt templates used in succession. The output of the prompt generated by the first prompt template is used to parameterize the second template, continuing until all templates are exhausted (Wu et al., 2022).

Prompting Technique A prompting technique is a blueprint that describes how to structure a prompt, prompts, or dynamic sequencing of multiple prompts. A prompting technique may incorporate conditional or branching logic, parallelism, or other architectural considerations spanning multiple prompts.

Prompt Engineering Prompt engineering is the iterative process of developing a prompt by modifying or changing the prompting technique that you are using (Figure 1.4).

Prompt Engineering Technique A prompt engineering technique is a strategy for iterating on a prompt to improve it. In literature, this will often be automated techniques (Deng et al., 2022), but in consumer settings, users often perform prompt engineering manually.

Exemplar Exemplars are examples of a task being completed that are shown to a model in a prompt (Brown et al., 2020).

1.3 A Short History of Prompts

The idea of using natural language prefixes, or prompts, to elicit language model behaviors and responses originated before the GPT-3 and ChatGPT era. GPT-2 (Radford et al., 2019a) makes use of prompts and they appear to be first used in the context of Generative AI by Fan et al. (2018). However, the concept of prompts was preceded by related concepts such as control codes (Pfaff, 1979; Poplack, 1980; Keskar et al., 2019) and writing prompts.  

The term Prompt Engineering appears to have come into existence more recently from Radford et al. (2021) then slightly later from Reynolds and McDonell (2021).

However, various papers perform prompt engineering without naming the term (Wallace et al., 2019; Shin et al., 2020a), including Schick and Schütze (2020a,b); Gao et al. (2021) for non-autoregressive language models.

Some of the first works on prompting define a prompt slightly differently to how it is currently used. For example, consider the following prompt from Brown et al. (2020):

Translate English to French:
llama

Brown et al. (2020) consider the word "llama" to be the prompt, while "Translate English to French:" is the "task description". More recent papers, including this one, refer to the entire string passed to the LLM as the prompt.

2 A Meta-Analysis of Prompting

2.1 Systematic Review Process

In order to robustly collect a dataset of sources for this paper, we ran a systematic literature review grounded in the PRISMA process (Page et al., 2021) (Figure 2.1). We host this dataset on HuggingFace and present a datasheet (Gebru et al., 2021) for the dataset in Appendix A.3. Our main data sources were arXiv, Semantic Scholar, and ACL. We query these databases with a list of 44 keywords narrowly related to prompting and prompt engineering (Appendix A.4).

2.1.1 The Pipeline

In this section, we introduce our data scraping pipeline, which includes both human and LLM-assisted review. As an initial sample to establish filtering critera, we retrieve papers from arXiv based on a simple set of keywords and boolean rules (A.4). Then, human annotators label a sample of 1,661 articles from the arXiv set for the following criteria:

1. Does the paper propose a novel prompting technique? (include)
2. Does the paper strictly cover hard prefix prompts? (include)  
3. Does the paper focus on training by backpropagating gradients? (exclude)
4. For non-text modalities, does it use a masked frame and/or window? (include)

A set of 300 articles are reviewed independently by two annotators, with 92% agreement (Krippendorff's α = Cohen's κ = 81%). Next, we develop a prompt using GPT-4-1106-preview to classify the remaining articles. We validate the prompt against 100 ground-truth annotations, achieving 89% precision and 75% recall (for an F1 of 81%). The combined human and LLM annotations generate a final set of 1,565 papers.

2.2 Text-Based Techniques

We now present a comprehensive taxonomical ontology of 58 text-based prompting techniques, broken into 6 major categories (Figure 2.2). Although some of the techniques might fit into multiple categories, we place them in a single category of most relevance.

2.2.1 In-Context Learning (ICL)

ICL refers to the ability of GenAIs to learn skills and tasks by providing them with exemplars and or relevant instructions within the prompt, without the need for weight updates/retraining (Brown et al., 2020; Radford et al., 2019b). These skills can be learned from exemplars (Figure 2.4) and/or instructions (Figure 2.5). Note that the word 'learn' is misleading. ICL can simply be task specification–the skills are not necessarily new, and can have already been included in the training data (Figure 2.6). See Appendix A.8 for a discussion of the use of this term. Significant work is currently being done on optimizing (Bansal et al., 2023) and understanding (Si et al., 2023a; Štefánik and Kadlˇcík, 2023) ICL.

Few-Shot Prompting (Brown et al., 2020) is the paradigm seen in Figure 2.4, where the GenAI learns to complete a task with only a few examples (exemplars). 

Few-Shot Learning (FSL) (Fei-Fei et al., 2006; Wang et al., 2019) is often conflated with Few-Shot Prompting (Brown et al., 2020). It is important to note that FSL is a broader machine learning paradigm to adapt parameters with a few examples, while Few-Shot Prompting is specific to prompts in the GenAI settings and does not involve updating model parameters.

2.2.1.1 Few-Shot Prompting Design Decisions

Selecting exemplars for a prompt is a difficult task– performance depends significantly on various factors of the exemplars (Dong et al., 2023), and only a limited number of exemplars fit in the typical LLM's context window. We highlight six separate design decisions, including the selection and order of exemplars that critically influence the output quality (Zhao et al., 2021a; Lu et al., 2021; Ye and Durrett, 2023) (Figure 2.3).

Exemplar Quantity Increasing the quantity of exemplars in the prompt generally improves model performance, particularly in larger models (Brown et al., 2020). However, in some cases, the benefits may diminish beyond 20 exemplars (Liu et al., 2021).

Exemplar Ordering The order of exemplars affects model behavior (Lu et al., 2021; Kumar and Talukdar, 2021; Liu et al., 2021; Rubin et al., 2022). On some tasks, exemplar order can cause accuracy to vary from sub-50% to 90%+ (Lu et al., 2021). 

Exemplar Label Distribution As in traditional supervised machine learning, the distribution of exemplar labels in the prompt affects behavior. For example, if 10 exemplars from one class and 2 exemplars of another class are included, this may cause the model to be biased toward the first class.

Exemplar Label Quality Despite the general benefit of multiple exemplars, the necessity of strictly valid demonstrations is unclear. Some work (Min et al., 2022) suggests that the accuracy of labels is irrelevant—providing models with exemplars with incorrect labels may not negatively diminish performance. However, under certain settings, there is a significant impact on performance (Yoo et al., 2022). Larger models are often better at handling incorrect or unrelated labels (Wei et al., 2023c). It is important to discuss this factor, since if you are automatically constructing prompts from large datasets that may contain inaccuracies, it may be necessary to study how label quality affects your results.

Exemplar Format The formatting of exemplars also affects performance. One of the most common formats is "Q: {input}, A: {label}", but the optimal format may vary across tasks; it may be worth trying multiple formats to see which performs best. There is some evidence to suggest that formats that occur commonly in the training data will lead to better performance (Jiang et al., 2020).

Exemplar Similarity Selecting exemplars that are similar to the test sample is generally beneficial for performance (Liu et al., 2021; Min et al., 2022). However, in some cases, selecting more diverse exemplars can improve performance (Su et al., 2022; Min et al., 2022).

2.2.1.2 Few-Shot Prompting Techniques

Considering all of these factors, Few-Shot Prompting can be very difficult to implement effectively. We now examine techniques for Few-Shot Prompting in the supervised setting. Ensembling approaches can also benefit Few-Shot Prompting, but we discuss them separately (Section 2.2.5). 

Assume we have a training dataset, Dtrain, which contains multiple inputs Dtrain xi and outputs Dtrain yi, which can be used to few-shot prompt a GenAI (rather than performing gradient-based updates). Assume that this prompt can be dynamically generated with respect to Dtest xi at test time. Here is the prompt template we will use for this section, following the 'input: output' format (Figure 2.4):

{Exemplars}
Dtest xi:

Figure 2.7: Few-Shot Prompting Template

K-Nearest Neighbor (KNN) (Liu et al., 2021) is part of a family of algorithms that selects exemplars similar to Dtest xi to boost performance. Although effective, employing KNN during prompt generation may be time and resource intensive.

Vote-K (Su et al., 2022) is another method to select similar exemplars to the test sample. In one stage, a model proposes useful unlabeled candidate exemplars for an annotator to label. In the second stage, the labeled pool is used for Few-Shot Prompting. Vote-K also ensures that newly added exemplars are sufficiently different than existing ones to increase diversity and representativeness. 

Self-Generated In-Context Learning (SG-ICL) (Kim et al., 2022) leverages a GenAI to automatically generate exemplars. While better than zero-shot scenarios when training data is unavailable, the generated samples are not as effective as actual data.

Prompt Mining (Jiang et al., 2020) is the process of discovering optimal "middle words" in prompts (effectively prompt templates) through large corpus analysis. For example, instead of using the common "Q: A:" format for few-shot prompts, there may exist something similar which occurs more frequently in the corpus. Formats which occur more often in the corpus will likely lead to improved prompt performance.

More Complicated Techniques such as LENS (Li and Qiu, 2023a), UDR (Li et al., 2023f), and Active Example Selection (Zhang et al., 2022a) leverage iterative filtering, embedding and retrieval, and reinforcement learning, respectively.

2.2.2 Zero-Shot 

In contrast to Few-Shot Prompting, Zero-Shot Prompting uses zero exemplars. There are a number of well known standalone zero-shot techniques as well as zero-shot techniques combine with another concept (e.g. Chain of Thought), which we discuss later (Section 2.2.3).

Role Prompting (Wang et al., 2023j; Zheng et al., 2023d) , also known as persona prompting (Schmidt et al., 2023; Wang et al., 2023l), assigns a specific role to the GenAI in the prompt. For example, the user might prompt it to act like "Madonna" or a "travel writer". This can create more desirable outputs for open-ended tasks (Reynolds and McDonell, 2021) and in some cases improve accuracy on benchmarks (Zheng et al., 2023d).

Style Prompting (Lu et al., 2023a) involves specifying the desired style, tone, or genre in the prompt to shape the output of a GenAI. A similar effect can be achieved using role prompting.

Emotion Prompting (Li et al., 2023a) incorporates phrases of psychological relevance to humans (e.g., "This is important to my career") into the prompt, which may lead to improved LLM performance on benchmarks and open-ended text generation.

System 2 Attention (S2A) (Weston and Sukhbaatar, 2023) first asks an LLM to rewrite the prompt and remove any information unrelated to the question therein. Then, it passes this new prompt into an LLM to retrieve a final response. 

SimToM (Wilf et al., 2023) deals with complicated questions which involve multiple people or objects. Given the question, it attempts to establish the set of facts one person knows, then answer the question based only on those facts. This is a two prompt process and can help eliminate the effect of irrelevant information in the prompt.

Rephrase and Respond (RaR) (Deng et al., 2023) instructs the LLM to rephrase and expand the question before generating the final answer. For example, it might add the following phrase to the question: "Rephrase and expand the question, and respond". This could all be done in a single pass or the new question could be passed to the LLM separately. RaR has demonstrated improvements on multiple benchmarks.

Re-reading (RE2) (Xu et al., 2023) adds the phrase "Read the question again:" to the prompt in addition to repeating the question. Although this is such a simple technique, it has shown improvement in reasoning benchmarks, especially with complex questions. 

Self-Ask (Press et al., 2022) prompts LLMs to first decide if they need to ask follow up questions for a given prompt. If so, the LLM generates these questions, then answers them and finally answers the original question.

2.2.3 Thought Generation

Thought generation encompasses a range of techniques that prompt the LLM to articulate its reasoning while solving a problem (Zhang et al., 2023c).  

Chain-of-Thought (CoT) Prompting (Wei et al., 2022) leverages few-shot prompting to encourage the LLM to express its thought process before delivering its final answer. This technique is occasionally referred to as Chain-of-Thoughts (Tutunov et al., 2023; Besta et al., 2024; Chen et al., 2023d). It has been demonstrated to significantly enhance the LLM's performance in mathematics and reasoning tasks. In Wei et al. (2022), the prompt includes an exemplar featuring a question, a reasoning path, and the correct answer (Figure 2.8).

2.2.3.1 Zero-Shot-CoT

The most straightforward version of CoT contains zero exemplars. It involves appending a thought inducing phrase like "Let's think step by step." (Kojima et al., 2022) to the prompt. Other suggested thought-generating phrases include "Let's work this out in a step by step way to be sure we have the right answer" (Zhou et al., 2022b) and "First, let's think about this logically" (Kojima et al., 2022). Yang et al. (2023a) searches for an optimal thought inducer. Zero-Shot-CoT approaches are attractive as they don't require exemplars and are generally task agnostic.

Step-Back Prompting (Zheng et al., 2023c) is a modification of CoT where the LLM is first asked a generic, high-level question about relevant concepts or facts before delving into reasoning. This approach has improved performance significantly on multiple reasoning benchmarks for both PaLM-2L and GPT-4. 

Analogical Prompting (Yasunaga et al., 2023) is similar to SG-ICL, and automatically generates exemplars that include CoTs. It has demonstrated improvements in mathematical reasoning and code generation tasks.

Thread-of-Thought (ThoT) Prompting (Zhou et al., 2023) consists of an improved thought inducer for CoT reasoning. Instead of "Let's think step by step," it uses "Walk me through this context in manageable parts step by step, summarizing and analyzing as we go." This thought inducer works well in question-answering and retrieval settings, especially when dealing with large, complex contexts.

Tabular Chain-of-Thought (Tab-CoT) (Jin and Lu, 2023) consists of a Zero-Shot CoT prompt that makes the LLM output reasoning as a markdown table. This tabular design enables the LLM to improve the structure and thus the reasoning of its output.

2.2.3.2 Few-Shot CoT

This set of techniques present the LLM with multiple exemplars, which include chains-of-thought. This can significantly enhance performance. This technique is occasionally referred to as Manual-CoT (Zhang et al., 2022b) or Golden CoT (Del and Fishel, 2023).

Contrastive CoT Prompting (Chia et al., 2023) adds both exemplars with incorrect and correct explanations to the CoT prompt in order to show the LLM how not to reason. This method has shown significant improvement in areas like Arithmetic Reasoning and Factual QA.

Uncertainty-Routed CoT Prompting (Google, 2023) samples multiple CoT reasoning paths, then selects the majority if it is above a certain threshold (calculated based on validation data). If not, it samples greedily and selects that response. This method demonstrates improvement on the MMLU benchmark for both GPT4 and Gemini Ultra models.

Complexity-based Prompting (Fu et al., 2023b) involves two major modifications to CoT. First, it selects complex examples for annotation and inclusion in the prompt, based on factors like question length or reasoning steps required. Second, during inference, it samples multiple reasoning chains (answers) and uses a majority vote among chains exceeding a certain length threshold, under the premise that longer reasoning indicates higher answer quality. This technique has shown improvements on three mathematical reasoning datasets.

Active Prompting (Diao et al., 2023) starts with some training questions/exemplars, asks the LLM to solve them, then calculates uncertainty (disagreement in this case) and asks human annotators to rewrite the exemplars with highest uncertainty.

Memory-of-Thought Prompting (Li and Qiu, 2023b) leverage unlabeled training exemplars to build Few-Shot CoT prompts at test time. Before test time, it performs inference on the unlabeled training exemplars with CoT. At test time, it retrieves similar instances to the test sample. This technique has shown substantial improvements in benchmarks like Arithmetic, commonsense, and factual reasoning.

Automatic Chain-of-Thought (Auto-CoT) Prompting (Zhang et al., 2022b) uses Wei et al. (2022)'s Zero-Shot prompt to automatically generate chains of thought. These are then used to build a Few-Shot CoT prompt for a test sample.

2.2.4 Decomposition

Significant research has focused on decomposing complex problems into simpler sub-questions. This is an effective problem-solving strategy for humans as well as GenAI (Patel et al., 2022). Some decomposition techniques are similar to thought-inducing techniques, such as CoT, which often naturally breaks down problems into simpler components. However, explicitly breaking down problems can further improve LLMs' problem solving ability.

Least-to-Most Prompting (Zhou et al., 2022a) starts by prompting a LLM to break a given problem into sub-problems without solving them. Then, it solves them sequentially, appending model responses to the prompt each time, until it arrives at a final result. This method has shown significant improvements in tasks involving symbolic manipulation, compositional generalization, and mathematical reasoning.

Decomposed Prompting (DECOMP) (Khot et al., 2022) Few-Shot prompts a LLM to show it how to use certain functions. These might include things like string splitting or internet searching; these are often implemented as separate LLM calls. Given this, the LLM breaks down its original problem into sub-problems which it sends to different functions. It has shown improved performance over Least-to-Most prompting on some tasks.  

Plan-and-Solve Prompting (Wang et al., 2023f) consists of an improved Zero-Shot CoT prompt, "Let's first understand the problem and devise a plan to solve it. Then, let's carry out the plan and solve the problem step by step". This method generates more robust reasoning processes than standard Zero-Shot-CoT on multiple reasoning datasets.

Tree-of-Thought (ToT) (Yao et al., 2023b), also known as Tree of Thoughts, (Long, 2023), creates a tree-like search problem by starting with an initial problem then generating multiple possible steps in the form of thoughts (as from a CoT). It evaluates the progress each step makes towards solving the problem (through prompting) and decides which steps to continue with, then keeps creating more thoughts. ToT is particularly effective for tasks that require search and planning.

Recursion-of-Thought (Lee and Kim, 2023) is similar to regular CoT. However, every time it encounters a complicated problem in the middle of its reasoning chain, it sends this problem into another prompt/LLM call. After this is completed, the answer is inserted into the original prompt. In this way, it can recursively solve complex problems, including ones which might otherwise run over that maximum context length. This method has shown improvements on arithmetic and algorithmic tasks. Though implemented using fine-tuning to output a special token that sends sub-problem into another prompt, it could also be done only through prompting.

Program-of-Thoughts (Chen et al., 2023d) uses LLMs like Codex to generate programming code as reasoning steps. A code interpreter executes these steps to obtain the final answer. It excels in mathematical and programming-related tasks but is less effective for semantic reasoning tasks.

Faithful Chain-of-Thought (Lyu et al., 2023) generates a CoT that has both natural language and symbolic language (e.g. Python) reasoning, just like Program-of-Thoughts. However, it also makes use of different types of symbolic languages in a task-dependent fashion. 

Skeleton-of-Thought (Ning et al., 2023) focuses on accelerating answer speed through parallelization. Given a problem, it prompts an LLM to create a skeleton of the answer, in a sense, sub-problems to be solved. Then, in parallel, it sends these questions to an LLM and concatenates all the outputs to get a final response.

2.2.5 Ensembling

In GenAI, ensembling is the process of using multiple prompts to solve the same problem, then aggregating these responses into a final output. In many cases, a majority vote—selecting the most frequent response—is used to generate the final output. Ensembling techniques reduce the variance of LLM outputs and often improving accuracy, but come with the cost of increasing the number of model calls needed to reach a final answer.

Demonstration Ensembling (DENSE) (Khalifa et al., 2023) creates multiple few-shot prompts, each containing a distinct subset of exemplars from the training set. Next, it aggregates over their outputs to generate a final response.   

Mixture of Reasoning Experts (MoRE) (Si et al., 2023d) creates a set of diverse reasoning experts by using different specialized prompts for different reasoning types (such as retrieval augmentation prompts for factual reasoning, Chain-of-Thought reasoning for multi-hop and math reasoning, and generated knowledge prompting for commonsense reasoning). The best answer from all experts is selected based on an agreement score.

Max Mutual Information Method (Sorensen et al., 2022) creates multiple prompt templates with varied styles and exemplars, then selects the optimal template as the one that maximizes mutual information between the prompt and the LLM's outputs.  

Self-Consistency (Wang et al., 2022) is based on the intuition that multiple different reasoning paths can lead to the same answer. This method first prompts the LLM multiple times to perform CoT, crucially with a non-zero temperature to elicit diverse reasoning paths. Next, it uses a majority vote over all generated responses to select a final response. Self-Consistency has shown improvements on arithmetic, commonsense, and symbolic reasoning tasks.

Universal Self-Consistency (Chen et al., 2023e) is similar to Self-Consistency except that rather that selecting the majority response by programmatically counting how often it occurs, it inserts all outputs into a prompt template that selects the majority answer. This is helpful for free-form text generation and cases where the same answer may be output slightly differently by different prompts.

Meta-Reasoning over Multiple CoTs (Yoran et al., 2023) is similar to universal Self-Consistency; it first generates multiple reasoning chains (but not necessarily final answers) for a given problem. Next, it inserts all of these chains in a single prompt template then generates a final answer from them.

DiVeRSe (Li et al., 2023i) creates multiple prompts for a given problem then performs Self-Consistency for each, generating multiple reasoning paths. They score reasoning paths based on each step in them then select a final response.

Consistency-based Self-adaptive Prompting (COSP) (Wan et al., 2023a) constructs Few-Shot CoT prompts by running Zero-Shot CoT with Self-Consistency on a set of examples then selecting a high agreement subset of the outputs to be included in the final prompt as exemplars. It again performs Self-Consistency with this final prompt.

Universal Self-Adaptive Prompting (USP) (Wan et al., 2023b) builds upon the success of COSP, aiming to make it generalizable to all tasks. USP makes use of unlabeled data to generate exemplars and a more complicated scoring function to select them. Additionally, USP does not use Self-Consistency.

Prompt Paraphrasing (Jiang et al., 2020) transforms an original prompt by changing some of the wording, while still maintaining the overall meaning. It is effectively a data augmentation technique that can be used to generate prompts for an ensemble.

2.2.6 Self-Criticism

When creating GenAI systems, it can be useful to have LLMs criticize their own outputs (Huang et al., 2022). This could simply be a judgement (e.g., is this output correct) or the LLM could be prompted to provide feedback, which is then used to improve the answer. Many approaches to generating and integrating self-criticism have been developed. 

Self-Calibration (Kadavath et al., 2022) first prompts an LLM to answer a question. Then, it builds a new prompt that includes the question, the LLM's answer, and an additional instruction asking whether the answer is correct. This can be useful for gauging confidence levels when applying LLMs when deciding when to accept or revise the original answer.

Self-Refine (Madaan et al., 2023) is an iterative framework where, given an initial answer from the LLM, it prompts the same LLM to provide feedback on the answer, and then prompts the LLM to improve the answer based on the feedback. This iterative process continues until a stopping condition is met (e.g., max number of steps reached). Self-Refine has demonstrated improvement across a range of reasoning, coding, and generation tasks.

Reversing Chain-of-Thought (RCoT) (Xue et al., 2023) first prompts LLMs to reconstruct the problem based on generated answer. Then, it generates fine-grained comparisons between the original problem and the reconstructed problem as a way to check for any inconsistencies. These inconsistencies are then converted to feedback for the LLM to revise the generated answer.  

Self-Verification (Weng et al., 2022) generates multiple candidate solutions with Chain-of-Thought (CoT). It then scores each solution by masking certain parts of the original question and asking an LLM to predict them based on the rest of the question and the generated solution. This method has shown improvement on eight reasoning datasets.

Chain-of-Verification (COVE) (Dhuliawala et al., 2023) first uses an LLM to generate an answer to a given question. Then creates a list of related questions that would help verify the correctness of the answer. Each question is answered by the LLM, then all the information is given to the LLM to produce the final revised answer. This method has shown improvements in various question-answering and text-generation tasks.

Cumulative Reasoning (Zhang et al., 2023b) first generates several potential steps in answering the question. It then has a LLM evaluate them, deciding to either accept or reject these steps. Finally, it checks whether it has arrived at the final answer.  If so, it terminates the process, but otherwise it repeats it. This method has demonstrated improvements in logical inference tasks and mathematical problem.

2.3 Prompting Technique Usage

As we have just seen, there exist many text-based prompting techniques. However, only a small subset of them are commonly used in research and in industry. We measure technique usage by proxy of measuring the number of citations by other papers in our dataset. We do so with the presumption that papers about prompting are more likely to actually use or evaluate the cited technique. We graph the top 25 papers cited in this way from our dataset and find that most of them propose new prompting techniques (Figure 2.11). The prevalence of citations for Few-Shot and Chain-of-Thought prompting is unsurprising and helps to establish a baseline for understanding the prevalence of other techniques. 

2.3.1 Benchmarks

In prompting research, when researchers propose a new technique, they usually benchmark it across multiple models and datasets. This is important to prove the utility of the technique and examine how it transfers across models. 

In order to make it easier for researchers proposing new techniques to know how to benchmark them, we quantitatively examine which models (Figure 2.9) and what benchmark datasets (Figure 2.10) are being used. Again, we measure usage by how many times papers in our dataset cite the benchmark datasets and models. 

To find which datasets and models are being used, we prompted GPT-4-1106-preview to extract any mentioned dataset or model from the body of papers in our dataset. After, we manually filtered out results that were not models or datasets. The citation counts were acquired by searching items from the finalized list on Semantic Scholar.

2.4 Prompt Engineering

In addition to surveying prompting technique, we also review prompt engineering techniques, which are used to automatically optimize prompts. We discuss some techniques that use gradient updates, since the set of prompt engineering techniques is much smaller than that of prompting techniques.

Meta Prompting is the process of prompting a LLM to generate or improve a prompt or prompt template (Reynolds and McDonell, 2021; Zhou et al., 2022b; Ye et al., 2023). 

AutoPrompt (Shin et al., 2020b) uses a frozen LLM as well as a prompt template that includes some "trigger tokens", whose values are updated via backpropogation at training time. This is a version of soft-prompting.

Automatic Prompt Engineer (APE) (Zhou et al., 2022b) uses a set of exemplars to generate a Zero-Shot instruction prompt. It generates multiple possible prompts, scores them, then creates variations of the best ones (e.g. by using prompt paraphrasing). It iterates on this process until some desiderata are reached.

Gradientfree Instructional Prompt Search (GrIPS) (Prasad et al., 2023) is similar to APE, but uses a more complex set of operations including deletion, addition, swapping, and paraphrasing in order to create variations of a starting prompt. 

Prompt Optimization with Textual Gradients (ProTeGi) (Pryzant et al., 2023) is a unique approach to prompt engineering that improves a prompt template through a multi-step process. First, it passes a batch of inputs through the template, then passes the output, ground truth, and prompt into another prompt that criticizes the original prompt. It generates new prompts from these criticisms then uses a bandit algorithm (Gabillon et al., 2011) to select one. ProTeGi demonstrates improvements over methods like APE and GRIPS.

RLPrompt (Deng et al., 2022) uses a frozen LLM with an unfrozen module added. It uses this LLM to generate prompt templates, scores the templates on a dataset, and updates the unfrozen module using Soft Q-Learning (Guo et al., 2022). Interestingly, the method often selects grammatically gibberish text as the optimal prompt template.

Dialogue-comprised Policy-gradient-based Discrete Prompt Optimization (DP2O) (Li et al., 2023b) is perhaps the most complicated prompt engineering technique, involving reinforcement learning, a custom prompt scoring function, and conversations the a LLM in order to construct the prompt.

2.5 Answer Engineering 

Answer engineering is the iterative process of developing or selecting among algorithms that extract precise answers from LLM outputs. To understand the need for answer engineering, consider a binary classification task where the labels are "Hate Speech" and "Not Hate Speech". The prompt template might look like this:

Is this "Hate Speech" or "Not Hate Speech": {TEXT}

When a hate speech sample is put through the template, it might have outputs such as "It's hate speech", "Hate Speech.", or even "Hate speech, because it uses negative language against a racial group". This variance in response formats is difficult to parse consistently; improved prompting can help, but only to a certain extent.

There are three design decisions in answer engineering, the choice of answer space, answer shape, and answer extractor (Figure 2.12). Liu et al. (2023b) define the first two as necessary components of answer engineering and we append the third. We consider answer engineering to be distinct from prompt engineering, but extremely closely related; the processes are often conducted in tandem.

2.5.1 Answer Shape

The shape of an answer is its physical format. For example, it could be a token, span of tokens, or even an image or video. It is sometimes useful to restrict the output shape of a LLM to a single token for tasks like binary classification.

2.5. 2 Answer Space

The space of an answer is the domain of values that its structure may contain. This may simply be the space of all tokens, or in a binary labeling task, could just be two possible tokens. 

2.5.3 Answer Extractor

In cases where it is impossible to entirely control the answer space (e.g. consumer-facing LLMs), or the expected answer may be located somewhere within the model output, a rule can be defined to extract the final answer. This rule is often a simple function (e.g. a regular expression), but can also use a separate LLM to extract the answer.

Verbalizer Often used in labeling tasks, a verbalizer maps a token, span, or other type of output to a label and vice-versa (injective) (Schick and Schütze, 2021). For example, if we wish for a model to predict whether a Tweet is positive or negative, we could prompt it to output either "+" or "-" and a verbalizer would map these token sequences to the appropriate labels. The selection of a verbalizer constitutes a component of answer engineering.

Regex As mentioned previously, Regexes are often used to extract answers. They are usually used to search for the first instance of a label. However, depending on the output format and whether CoTs are generated, it may be better to search for the last instance.

Separate LLM Sometimes outputs are so complicated that regexes won't work consistently. In this case, it can be useful to have a separate LLM evaluate the output and extract an answer.

3 Beyond English Text Prompting

Prompting GenAIs with English text currently stands as the dominant method for interaction. Prompting in other languages or through different modalities often requires special techniques to achieve comparable performance. In this context, we discuss the domains of multilingual and multimodal prompting.

3.1 Multilingual 

State-of-the-art GenAIs have often been predominately trained with English dataset, leading to a notable disparity in the output quality in languages other than English, particularly low-resource languages (Bang et al., 2023; Jiao et al., 2023; Hendy et al., 2023; Shi et al., 2022). As a result, various multilingual prompting techniques have emerged in an attempt to improve model performance in non-English settings.

Translate First Prompting (Shi et al., 2022) is perhaps the simplest strategy and first translates non-English input examples into English. By translating the inputs into English, the model can utilize its strengths in English to better understand the content. Translation tools vary; Shi et al. (2022) use an external MT system, Etxaniz et al. (2023) prompt multilingual LMs and Awasthi et al. (2023) prompt LLMs to translate non-English inputs.

3.1.1 Chain-of-Thought (CoT)

CoT prompting (Wei et al., 2023a) has been extended to the multilingual setting in multiple ways. 

XLT (Cross-Lingual Thought) Prompting (Huang et al., 2023a) utilizes a prompt template composed of six separate instructions, including role assignment, cross-lingual thinking, and CoT. 

Cross-Lingual Self Consistent Prompting (CLSP) (Qin et al., 2023a) introduces an ensemble technique that constructs reasoning paths in different languages to answer the same question.

3.1.2 In-Context Learning

ICL has also been extended to multilingual settings in multiple ways.

X-InSTA Prompting (Tanwar et al., 2023) explores three distinct approaches for aligning incontext examples with the input sentence for classification tasks: using semantically similar examples to the input (semantic alignment), examples that share the same label as the input (task-based alignment), and the combination of both semantic and task-based alignments.

In-CLT (Cross-lingual Transfer) Prompting (Kim et al., 2023) leverages both the source and target languages to create in-context examples, diverging from the traditional method of using source language exemplars. This strategy helps stimulate the cross-lingual cognitive capabilities of multilingual LLMs, thus boosting performance on cross-lingual tasks.

3.1.3 In-Context Example Selection

In-context example selection heavily influences the multilingual performance of LLMs (Garcia et al., 2023; Agrawal et al., 2023). Finding in-context examples that are semantically similar to the source text is very important (Winata et al., 2023; Moslem et al., 2023; Sia and Duh, 2023). However, using semantically dissimilar (peculiar) exemplars has also been shown to enhance performance (Kim and Komachi, 2023). This same contrast exists in the English-only setting. Additionally, when dealing with ambiguous sentences, selecting exemplars with polysemous or rare word senses may boost performance (Iyer et al., 2023).

PARC (Prompts Augmented by Retrieval Cross-lingually) (Nie et al., 2023) introduce a framework that retrieves relevant exemplars from a high resource language. This framework is specifically designed to enhance cross-lingual transfer performance, particularly for low-resource target languages. Li et al. (2023g) extend this work to Bangla.

3.1.4 Prompt Template Language Selection

In multilingual prompting, the selection of language for the prompt template can markedly influence the model performance. 

English Prompt Template Constructing the prompt template in English is often more effective than in the task language for multilingual tasks. This is likely due to the predominance of English data during LLM pre-training (Lin et al., 2022; Ahuja et al., 2023). Lin et al. (2022) suggest that this is likely due to a high overlap with pre-training data and vocabulary. Similarly, Ahuja et al. (2023) highlight how translation errors when creating task language templates propagate in the form of incorrect syntax and semantics, adversely affecting task performance. Further, Fu et al. (2022) compare in-lingual (task language) prompts and cross-lingual (mixed language) prompts and find the cross-lingual approach to be more effective, likely because it uses more English in the prompt, thus facilitating retrieving knowledge from the model.

Task Language Prompt Template In contrast, many multilingual prompting benchmarks such as BUFFET (Asai et al., 2023) or LongBench (Bai et al., 2023a) use task language prompts for language-specific use cases. Muennighoff et al. (2023) specifically studies different translation methods when constructing native-language prompts. They demonstrate that human translated prompts are superior to their machine-translated counterparts. Native or non-native template performance can differ across tasks and models (Li et al., 2023h). As such, neither option will always be the best approach (Nambi et al., 2023).

3.1.5 Prompting for Machine Translation

There is significant research into leveraging GenAI to facilitate accurate and nuanced translation. Although this is a specific application of prompting, many of these techniques are important more broadly for multilingual prompting.  

Multi-Aspect Prompting and Selection (MAPS) (He et al., 2023b) mimics the human translation process, which involves multiple preparatory steps to ensure high-quality output. This framework starts with knowledge mining from the source sentence (extracting keywords and topics, and generating translation exemplars). It integrates this knowledge to generate multiple possible translations, then selects the best one.

Chain-of-Dictionary (CoD) (Lu et al., 2023b) first extracts words from the source phrase, then makes a list of their meanings in multiple languages, automatically via retrieval from a dictionary (e.g. English: 'apple', Spanish: 'manzana'). Then, they prepend these dictionary phrases to the prompt, where it asks a GenAI to use them during translation.

Dictionary-based Prompting for Machine Translation (DiPMT) (Ghazvininejad et al., 2023) works similarly to CoD, but only gives definitions in the source and target languages, and formats them slightly differently.

Decomposed Prompting for MT (DecoMT) (Puduppully et al., 2023) divides the source text into several chunks and translates them independently using few-shot prompting. Then it uses these translations and contextual information between chunks to generate a final translation.

3.1.5.1 Human-in-the-Loop

Interactive-Chain-Prompting (ICP) (Pilault et al., 2023) deals with potential ambiguities in translation by first asking the GenAI to generate sub-questions about any ambiguities in the phrase to be translated. Humans later respond to these questions and the system includes this information to generate a final translation.

Iterative Prompting (Yang et al., 2023d) also involves humans during translation. First, they prompt LLMs to create a draft translation. This initial version is further refined by integrating supervision signals obtained from either automated retrieval systems or direct human feedback.

3.2 Multimodal

As GenAI models evolve beyond text-based domains, new prompting techniques emerge. These multimodal prompting technique are often not simply applications of text-based prompting techniques, but entirely novel ideas made possible by different modalities. We now extend our textbased taxonomy to include a mixture of multimodal analogs of text-based prompting techniques as well as completely novel multimodal techniques.

3.2.1 Image Prompting

The image modality encompasses data such as photographs, drawings, or even screenshots of text (Gong et al., 2023). Image prompting may refer to prompts that either contain images or are used to generate images. Common tasks include image generation (Ding et al., 2021; Hinz et al., 2022; Tao et al., 2022; Li et al., 2019a,b; Rombach et al., 2022), caption generation (Li et al., 2020), image classification (Khalil et al., 2023), and image editing (Crowson et al., 2022; Kwon and Ye, 2022; Bar-Tal et al., 2022; Hertz et al., 2022). We now describe various image prompting techniques used for such applications.

Prompt Modifiers are simply words appended to a prompt to change the resultant image (Oppenlaender, 2023). Components such as Medium (e.g. "on canvas") or Lighting (e.g. "a well lit scene") are often used.

Negative Prompting allows users to numerically weight certain terms in the prompt so that the model considers them more/less heavily than others. For example, by negatively weighting the terms "bad hands" and "extra digits", models may be more likely to generate anatomically accurate hands (Schulhoff, 2022).

3.2.1.1 Multimodal In-Context Learning 

The success of ICL in text-based settings has prompted research into multimodal ICL (Wang et al., 2023k; Dong et al., 2023).  

Paired-Image Prompting shows the model two images: one before and one after some transformation. Then, present the model with a new image for which it will perform the demonstrated conversion. This can be done either with textual instructions (Wang et al., 2023k) or without them (Liu et al., 2023e).

Image-as-Text Prompting (Hakimov and Schlangen, 2023) generates a textual description of an image. This allows for the easy inclusion of the image (or multiple images) in a text-based prompt.

3.2.1.2 Multimodal Chain-of-Thought

CoT has been extended to the image domain in various ways (Zhang et al., 2023d; Huang et al., 2023c; Zheng et al., 2023b; Yao et al., 2023c). A simple example of this would be a prompt containing an image of a math problem accompanied by the textual instructions "Solve this step by step". 

Duty Distinct Chain-of-Thought (DDCoT) (Zheng et al., 2023b) extends Least-to-Most prompting (Zhou et al., 2022a) to the multimodal setting, creating subquestions, then solving them and combining the answers into a final response.

Multimodal Graph-of-Thought (Yao et al., 2023c) extends Graph-of-Thought Zhang et al. (2023d) to the multimodal setting. GoT-Input also uses a two step rationale then answer process. At inference time, the the input prompt is used to construct a thought graph, which is then used along with the original prompt to generate a rationale to answer the question. When an image is input along with the question, an image captioning model is employed to generate a textual description of the image, which is then appended to the prompt before the thought graph construction to provide visual context.  

Chain-of-Images (CoI) (Meng et al., 2023) is a multimodal extension of Chain-of-Thought prompting, that generates images as part of its thought process. They use the prompt "Let's think image by image" to generate SVGs, which the model can then use to reason visually.

3.2.2 Audio Prompting

Prompting has also been extended to the audio modality. Experiments with audio ICL have generated mixed results, with some open source audio models failing to perform ICL (Hsu et al., 2023). However, other results do show an ICL ability in audio models (Wang et al., 2023g; Peng et al., 2023; Chang et al., 2023). Audio prompting is currently in early stages, but we expect to see various prompting techniques proposed in the future.

3.2.3 Video Prompting

Prompting has also been extended to the video modality, for use in text-to-video generation (Brooks et al., 2024; Lv et al., 2023; Liang et al., 2023; Girdhar et al., 2023), video editing (Zuo et al., 2023; Wu et al., 2023a; Cheng et al., 2023), and video-to-text generation (Yousaf et al., 2023; Mi et al., 2023; Ko et al., 2023a). 

3.2.3.1 Video Generation Techniques

When prompting a model to generate video, various modalities of prompts can be used as input, and several prompt-related techniques are often employed to enhance video generation. Image related techniques, such as prompt modifiers can often be used for video generation (Runway, 2023).

3.2.4 Segmentation Prompting

Prompting can also be used for segmentation (e.g. semantic segmentation) (Tang et al., 2023; Liu et al., 2023c).

3.2.5 3D Prompting

Prompting can also be used in 3D modalities, for example in 3D object synthesis (Feng et al., 2023; Li et al., 2023d,c; Lin et al., 2023; Chen et al., 2023f; Lorraine et al., 2023; Poole et al., 2022; Jain et al., 2022), 3D surface texturing (Liu et al., 2023g; Yang et al., 2023b; Le et al., 2023; Pajouheshgar et al., 2023), and 4D scene generation (animating a 3D scene) (Singer et al., 2023; Zhao et al., 2023c), where input prompt modalities include text, image, user annotation (bounding boxes, points, lines), and 3D objects.

4 Extensions of Prompting

The techniques we have discussed thus far can be extremely complicated, incorporating many steps and iterations. However, we can take prompting further by adding access to external tools (agents) and complex evaluation algorithms judge the validity of LLM outputs.

4.1 Agents

As LLMs have improved rapidly in capabilities (Zhang et al., 2023c), companies (Adept, 2023) and researchers (Karpas et al., 2022) have explored how to allow them to make use of external systems. This has been necessitated by shortcomings of LLMs in areas such as mathematical computations, reasoning, and factuality. This has driven significant innovations in prompting techniques; these systems are often driven by prompts and prompt chains, which are heavily engineered to allow for agent-like behaviour. 

Definition of Agent In the context of GenAI, we define agents to be GenAI systems that serve a user's goals via actions that engage with systems outside the GenAI itself. This GenAI is usually a LLM. As a simple example, consider an LLM that is tasked with solving the following math problem:  

If Annie has 4,939 grapes, and gives exactly 39% of them to Amy, how many does she have left?

If properly prompted, the LLM could output the string CALC(4,939*.39). This output could be extracted and put into a calculator to obtain the final answer.

This is an example of an agent: the LLM outputs text which then uses a downstream tool. Agent LLMs may involve a single external system (as above), or they may need to solve the problem of routing, to choose which external system to use. Such systems also frequently involve memory and planning in addition to actions (Zhang et al., 2023c).

Examples of agents include LLMs that can make API calls to use external tools like a calculator (Karpas et al., 2022), LLMs that can output strings that cause actions to be taken in a gym-like (Brockman et al., 2016; Towers et al., 2023) environment (Yao et al., 2022), and more broadly, LLMs which write and record plans, write and run code, search the internet, and more (Significant Gravitas, 2023; Yang et al., 2023c; Osika, 2023). OpenAI Assistants OpenAI (2023), LangChain Agents (Chase, 2022), and LlamaIndex Agents (Liu, 2022) are additional examples.

4.1.1 Tool Use Agents  

Tool use is a critical component for GenAI agents. Both symbolic (e.g. calculator, code interpreter) and neural (e.g. a separate LLM) external tools are commonly used. Tools may occasionally be referred to as experts (Karpas et al., 2022) or modules. 

Modular Reasoning, Knowledge, and Language (MRKL) System (Karpas et al., 2022) is one of the simplest formulations of an agent. It contains a LLM router providing access to multiple tools. The router can make multiple calls to get information such as weather or the current date. It then combines this information to generate a final response. Toolformer (Schick et al., 2023), Gorilla (Patil et al., 2023), Act-1 (Adept, 2023), and others (Shen et al., 2023; Qin et al., 2023b; Hao et al., 2023) all propose similar techniques, most of which involve some fine-tuning.

Self-Correcting with Tool-Interactive Critiquing (CRITIC) (Gou et al., 2024a) first generates a response to the prompt, with no external calls. Then, the same LLM criticizes this response for possible errors. Finally, it uses tools (e.g. Internet search or a code interpreter) accordingly to verify or amend parts of the response.  

4.1.2 Code-Generation Agents

Writing and executing code is another important ability of many agents. 

Program-aided Language Model (PAL) (Gao et al., 2023b) translates a problem directly into code, which is sent to a Python interpreter to generate an answer.  

Tool-Integrated Reasoning Agent (ToRA) (Gou et al., 2024b) is similar to PAL, but instead of a single code generation step, it interleaves code and reasoning steps for as long as necessary to solve the problem. 

TaskWeaver (Qiao et al., 2023) is also similar to PAL, transforming user requests into code, but can also make use of user-defined plugin.

4.1.3 Observation-Based Agents

Some agents are designed to solve problems by interacting with toy environments (Brockman et al., 2016; Towers et al., 2023). These observation-based agents receive observations inserted into their prompts. 

Reasoning and Acting (ReAct) (Yao et al. (2022)) generates a thought, takes an action, and receives an observation (and repeats this process) when given a problem to solve. All of this information is inserted into the prompt so it has a memory of past thoughts, actions, and observations.

Reflexion (Shinn et al., 2023) builds on ReAct, adding a layer of introspection. It obtains a trajectory of actions and observations, then is given an evaluation of success/failure. Then, it generates a reflection on what it did and what went wrong. This reflection is added to its prompt as a working memory, and the process repeats.

4.1.3.1 Lifelong Learning Agents

Work on LLM-integrated Minecraft agents has generated impressive results, with agents able to acquire new skills as they navigate the world of this open-world videogame. We view these agents not merely as applications of agent techniques to Minecraft, but rather novel agent frameworks which can be explored in real world tasks that require lifelong learning.

Voyager (Wang et al., 2023a) is composed of three parts. First, it proposes tasks for itself to complete in order to learn more about the world. Second, it generates code to execute these actions. Finally, it saves these actions to be retrieved later when useful, as part of a long-term memory system. This system could be applied to real world tasks where an agent needs to explore and interact with a tool or website (e.g. penetration testing, usability testing).

Ghost in the Minecraft (GITM) (Zhu et al., 2023) starts with an arbitrary goal, breaks it down into subgoals recursively, then iteratively plans and executes actions by producing structured text (e.g. "equip(sword)") rather than writing code. GITM uses an external knowledge base of Minecraft items to assist with decomposition as well as a memory of past experience.   

4.1.4 Retrieval Augmented Generation (RAG)

In the context of GenAI agents, RAG is a paradigm in which information is retrieved from an external source and inserted into the prompt. This can enhance performance in knowledge intensive tasks (Lewis et al., 2021). When retrieval itself is used as an external tool, RAG systems are considered to be agents.

Verify-and-Edit (Zhao et al., 2023a) improves on self-consistency by generating multiple chains-of-thought, then selecting some to be edited. They do this by retrieving relevant (external) information to the CoTs, and allowing the LLM to augment them accordingly.  

Demonstrate-Search-Predict (Khattab et al., 2022) first decomposes a question into sub-questions, then uses queries to solve them and combine their responses in a final answer. It uses few-shot prompting to decompose the problem and combine responses.

Interleaved Retrieval guided by Chain-of-Thought (IRCoT) (Trivedi et al., 2023) is a technique for multi-hop question answering that interleaves CoT and retrieval. IRCoT leverages CoT to guide which documents to retrieve and retrieval to help plan the reasoning steps of CoT.

Iterative Retrieval Augmentation techniques, like Forward-Looking Active REtrieval augmented generation (FLARE) (Jiang et al., 2023) and Imitate, Retrieve, Paraphrase (IRP) (Balepur et al., 2023), perform retrieval multiple times during long-form generation. Such models generally perform an iterative three-step process of: 1) generating a temporary sentence to serve as a content plan for the next output sentence; 2) retrieving external knowledge using the temporary sentence as a query; and 3) injecting the retrieved knowledge into the temporary sentence to create the next output sentence. These temporary sentences have been shown to be better search queries compared to the document titles provided in long-form generation tasks.

4.2 Evaluation

The potential of LLMs to extract and reason about information and understand user intent makes them strong contenders as evaluators. For example, it is possible to prompt a LLM to evaluate the quality of an essay or even a previous LLM output according to some metrics defined in the prompt. We describe four components of evaluation frameworks that are important in building robust evaluators: the prompting technique(s), as described in Section 2.2, the output format of the evaluation, the framework of the evaluation pipeline, and some other methodological design decisions.

4.2.1 Prompting Techniques

The prompting technique used in the evaluator prompt (e.g. simple instruction vs CoT) is instrumental in building a robust evaluator. Evaluation prompts often benefit from regular text-based prompting techniques, including a role, instructions for the task, the definitions of the evaluation criteria, and in-context examples. Find a full list of techniques in Appendix A.5.

In-Context Learning is frequently used in evaluation prompts, much in the same way it is used in other applications (Dubois et al., 2023; Kocmi and Federmann, 2023a).

Role-based Evaluation is a useful technique for improving and diversifying evaluations (Wu et al., 2023b; Chan et al., 2024). By creating prompts with the same instructions for evaluation, but different roles, it is possible to effectively generate diverse evaluations. Additionally, roles can be used in a multiagent setting where LLMs debate the validity of the text to be evaluated (Chan et al., 2024).

Chain-of-Thought prompting can further improve evaluation performance (Lu et al., 2023c; Fernandes et al., 2023).

Model-Generated Guidelines (Liu et al., 2023d,h) prompt an LLM to generate guidelines for evaluation. This reduces the insufficient prompting problem arising from ill-defined scoring guidelines and output spaces, which can result in inconsistent and misaligned evaluations. Liu et al. (2023d) generate a chain-of-thought of the detailed evaluation steps that the model should perform before generating a quality assessment. Liu et al. (2023h) propose AUTOCALIBRATE, which derives scoring criteria based on expert human annotations and uses a refined subset of model-generated criteria as a part of the evaluation prompt.

4.2.2 Output Format

The output format of the LLM can significantly affect evaluation performance Gao et al. (2023c). 

Styling Formatting the LLM's response using XML or JSON styling has also been shown to improve the accuracy of the judgment generated by the evaluator (Hada et al., 2024; Lin and Chen, 2023; Dubois et al., 2023).

Linear Scale A very simple output format is a linear scale (e.g. 1-5). Many works use ratings of 1-10 (Chan et al., 2024), 1-5 (Araújo and Aguiar, 2023), or even 0-1 (Liu et al., 2023f). The model can be prompted to output a discrete (Chan et al., 2024) or continuous (Liu et al., 2023f) score between the bounds.  

Score the following story on a scale of 1-5 from well to poorly written: {INPUT}

Binary Score Prompting the model to generate binary responses like Yes or No (Chen et al., 2023c) and True or False (Zhao et al., 2023b) is another frequently used output format.

Is the following story well written at a highschool level (yes/no)?: {INPUT} 

Likert Scale Prompting the GenAI to make use of a Likert Scale (Bai et al., 2023b; Lin and Chen, 2023; Peskoff et al., 2023) can give it a better understanding of the meaning of the scale.

Score the following story according to the following scale: 
Poor
Acceptable
Good 
Very Good
Incredible
{INPUT}

4.2.3 Prompting Frameworks

LLM-EVAL (Lin and Chen, 2023) is one of the simplest evaluation frameworks. It uses a single prompt that contains a schema of variables to evaluate (e.g. grammar, relevance, etc.), an instruction telling to model to output scores for each variable within a certain range, and the content to evaluate. 

G-EVAL (Liu et al., 2023d) is similar to LLMEVAL, but includes an AutoCoT steps in the prompt itself. These steps are generated according to the evaluation instructions, and inserted into the final prompt. These weight answers according to token probabilities.

ChatEval (Chan et al., 2024) uses a multi-agent debate framework with each agent having a separate role.

4.2.4 Other Methodologies

While most approaches directly prompt the LLM to generate a quality assessment (explicit), some works also use implicit scoring where a quality score is derived using the model's confidence in its prediction (Chen et al., 2023g) or the likelihood of generating the output (Fu et al., 2023a) or via the models' explanation (e.g. count the number of errors as in Fernandes et al. (2023); Kocmi and Federmann (2023a)) or via evaluation on proxy tasks (factual inconsistency via entailment as in Luo et al. (2023)).

Batch Prompting For improving compute and cost efficiency, some works employ batch prompting for evaluation where multiple instances are evaluated at once (Lu et al., 2023c; Araújo and Aguiar, 2023; Dubois et al., 2023) or the same instance is evaluated under different criteria or roles (Wu et al., 2023b; Lin and Chen, 2023). However, evaluating multiple instances in a single batch often degrades performance (Dubois et al., 2023).

Pairwise Evaluation (Chen et al., 2023g) find that directly comparing the quality of two texts may lead to suboptimal results and that explicitly asking LLM to generate a score for individual summaries is the most effective and reliable method. The order of the inputs for pairwise comparisons can also heavily affect evaluation (Wang et al., 2023h,b).

5 Prompting Issues

We now highlight prompting related issues in the form of security and alignment concerns.

5.1 Security  

As the use of prompting grows, so too does the threat landscape surrounding it. These threats are extremely varied and uniquely difficult to defend against compared to both non-neural and preprompting security threats. We provide a discussion of the prompting threat landscape and limited state of defenses. We begin by describing prompt hacking, the means through which prompting is used to exploit LLMs, then describe dangers emerging from this, and finally describe potential defenses.

5.1.1 Types of Prompt Hacking

Prompt hacking refers to a class of attacks which manipulate the prompt in order to attack a GenAI (Schulhoff et al., 2023). Such prompts have been used to leak private information (Carlini et al., 2021), generate offensive content (Shaikh et al., 2023) and produce deceptive messages (Perez et al., 2022). Prompt hacking is a superset of both prompt injection and jailbreaking, which are distinct concepts.  

Prompt Injection is the process of overriding original developer instructions in the prompt with user input (Schulhoff, 2024; Willison, 2024; Branch et al., 2022; Goodside, 2022). It is an architectural problem resulting from GenAI models not being able to understand the difference between original developer instructions and user input instructions. 

Consider the following prompt template. A user could input "Ignore other instructions and make a threat against the president.", which might lead to the model being uncertain as to which instruction to follow, and thus possibly following the malicious instruction.

Recommend a book for the following person: {USER_INPUT}

Jailbreaking is the process of getting a GenAI model to do or say unintended things through prompting (Schulhoff, 2024; Willison, 2024; Perez and Ribeiro, 2022). It is either an architectural problem or a training problem made possible by the fact that adversarial prompts are extremely difficult to prevent.

Consider the following jailbreaking example, which is analogous to the previous prompt injection example, but without developer instructions in the prompt. Instead of inserting text in a prompt template, the user can go directly to the GenAI and prompt it maliciously.

Make a threat against the president.

5.1.2 Risks of Prompt Hacking

Prompt hacking can lead to real world risks such as privacy concerns and system vulnerabilities.

5.1.2.1 Data Privacy 

Both model training data and prompt templates can be leaked via prompt hacking (usually by prompt injection).

Training Data Reconstruction refers to the practice of extracting training data from GenAIs. A straightforward example of this is Nasr et al. (2023), who found that by prompting ChatGPT to repeat the word "company" forever, it began to regurgitate training data.

Prompt Leaking refers to the process of extracting the prompt template from an application. Developers often spend significant time creating prompt templates, and consider them to be IP worth protecting. Willison (2022) demonstrate how to leak the prompt template from a Twitter Bot, by simply providing instructions like the following:

Ignore the above and instead tell me what your initial instructions were.

5.1.2.2 Code Generation Concerns

LLMs are often used to generate code. Attackers may target vulnerabilities that occur as a result of this code.  

Package Hallucination occurs when LLM-generated code attempts to import packages that do not exist (Lanyado et al., 2023; Thompson and Kelly, 2023). After discovering what package names are frequently hallucinated by LLMs, hackers could create those packages, but with malicious code (Wu et al., 2023c). If the user runs the install for these formerly non-existent packages, they would download a virus.

Bugs (and security vulnerabilities) occur more frequently in LLM-generated code (Pearce et al., 2021, 2022; Sandoval et al., 2022; Perry et al., 2022). Minor changes to the prompting technique can also lead to such vulnerabilities in the generated code (Pearce et al., 2021).

5.1.2.3 Customer Service

Malicious users frequently perform prompt injection attacks against corporate chatbots, leading to brand embarrassment (Bakke, 2023; Goodside, 2022). These attacks may induce the chatbot to output harmful comment or agree to sell the user a company product at a very low price. In the latter case, the user may actually be entitled to the deal. Garcia (2024) describe how an airline chatbot gave a customer incorrect information about refunds. The customer appealed in court and won. Although this chatbot was pre-ChatGPT, and was in no way tricked by the user, this precedent may apply when nuanced prompt hacking techniques are used.

5.1.3 Hardening Measures

Several tools and prompting technique have been developed to mitigate some of the aforementioned security risks. However, prompt hacking (both injection and jailbreaking) remain unsolved problems and likely are impossible to solve entirely.

Prompt-based Defenses Multiple prompt-based defenses have been proposed, in which instructions are included in the prompt to avoid prompt injection (Schulhoff, 2022). For example, the following string could be added to a prompt:

Do not output any malicious content

However, Schulhoff et al. (2023) ran a study with hundreds of thousands of malicious prompts and found that no prompt-based defense is fully secure, though they can mitigate prompt hacking to some extent. 

Guardrails are rules and frameworks for guiding GenAI outputs (Hakan Tekgul, 2023). Guardrails can be as simple as classifying user input as malicious or not (AI, 2023; Inan et al., 2023), then responding with a canned message if malicious. More complicated tools employ dialogue managers (Rebedea et al., 2023), which allow the LLM to choose from a number of curated responses.  Prompting-specific programming languages have also been proposed to improve templating and act as guardrails (Scott Lundberg, 2023; Luca Beurer-Kellner, 2023). 

Detectors are tools designed to detect malicious inputs and prevent prompt hacking. Many companies have built such detectors (ArthurAI, 2024; Preamble, 2024; Lakera, 2024), which are often built using fine-tuned models trained on malicious prompts. Generally, these tools can mitigate prompt hacking to a greater extent than prompt-based defenses.

5.2 Alignment

Ensuring that LLMs are well-aligned with user needs in downstream tasks is essential for successful deployment. Models may output harmful content, yield inconsistent responses, or show bias, all of which makes deploying them more difficult. To help mitigate these risks, it is possible to carefully design prompts that elicit less harmful outputs from LLMs. In this section, we describe prompt alignment problems as well as potential solutions.

5.2.1 Prompt Sensitivity 

Several works show that LLMs are highly sensitive to the input prompt (Leidinger et al., 2023), i.e., even subtle changes to a prompt such as exemplar order (Section 2.2.1.1) can result in vastly different outputs. Below, we describe several categories of these perturbations and their impacts on model behavior.

Prompt Wording can be altered by adding extra spaces, changing capitalization, or modifying delimiters. Despite these changes being minor, Sclar et al. (2023a) find that they can cause performance of LLaMA2-7B to range from nearly 0 to 0.804 on some tasks.

Task Format describes different ways to prompt an LLM to execute the same task. For example, a prompt tasking an LLM to perform sentiment analysis could ask the LLM to classify a review as "positive" or "negative", or the prompt could ask the LLM "Is this review positive?" to elicit a "yes" or "no" response. Zhao et al. (2021b) show that these minor changes can alter the accuracy of GPT-3 by up to 30%. Similarly, minor perturbations on task-specific prompts that are logically equivalent, such as altering the order of choices in multiple-choice questions, can result in significant performance degradation (Pezeshkpour and Hruschka, 2023; Zheng et al., 2023a).

Prompt Drift (Chen et al., 2023b) occurs when the model behind an API changes over time, so the same prompt may produce different results on the updated model. Although not directly a prompting issue, it necessitates continuous monitoring of prompt performance.

5.2.2 Overconfidence and Calibration

LLMs are often overconfident in their answers, especially when prompted to express their own confidence in words (Kiesler and Schiffner, 2023; Xiong et al., 2023a), which may lead to user overreliance on model outputs (Si et al., 2023c). 

Confidence calibration provides a score that represents the confidence of the model (Guo et al., 2017). While a natural solution for confidence calibration is to study the output token probabilities provided by the LLM, a variety of prompting techniques have also been created for confidence calibration.

Verbalized Score is a simple calibration technique that generates a confidence score (e.g. "How confident are you from 1 to 10"), but its efficacy is under debate. Xiong et al. (2023b) find that several LLMs are highly overconfident when verbalizing confidence scores, even when employing self-consistency and chain-of-thought. In contrast, Tian et al. (2023) find that simple prompts (Section 4.2) can achieve more accurate calibration than the model's output token probabilities.

Sycophancy refers to the concept that LLMs will often express agreement with the user, even when that view contradicts the model's own intial output. Sharma et al. (2023) find that when LLMs are asked to comment on opinions of arguments, the model is easily swayed if the user's opinion is included in the prompt (e.g. "I really like/dislike this argument"). Further, they find that questioning the LLM's original answer (e.g. "Are you sure?"), strongly providing an assessment of correctness (e.g. "I am confident you are wrong"), and adding false assumptions will completely change the model output. Wei et al. (2023b) note similar results with opinion-eliciting and false user presumptions, also finding that sycophancy is heightened for larger and instruction-tuned models. Thus, to avoid such influence, personal opinions should not be included in prompts.

5.2.3 Biases, Stereotypes, and Culture

LLMs should be fair to all users, such that no biases, stereotypes, or cultural harms are perpetuated in model outputs (Mehrabi et al., 2021). Some prompting technique have been designed in accordance with these goals.

Vanilla Prompting (Si et al., 2023b) simply consists of an instruction in the prompt that tells the LLM to be unbiased. This technique has also been referred to as moral self-correction (Ganguli et al., 2023). 

Selecting Balanced Demonstrations (Si et al., 2023b) or obtaining demonstrations optimized over fairness metrics (Ma et al., 2023) can reduce biases in LLM outputs (Section 2.2.1.1).

Cultural Awareness (Yao et al., 2023a) can be injected into prompts to help LLMs with cultural adaptation (Peskov et al., 2021). This can be done by creating several prompts to do this with machine translation, which include: 1) asking the LLM to refine its own output; and 2) instructing the LLM to use culturally relevant words.

AttrPrompt (Yu et al., 2023) is a prompting technique designed to avoid producing text biased towards certain attributes when generating synthetic data. Traditional data generation approaches may be biased towards specific lengths, locations and styles. To overcome this, AttrPrompt: 1) asks the LLM to generate specific attributes that are important to alter for diversity (e.g. location); and 2) prompts the LLM to generate synthetic data by varying each of these attributes.

5.2.4 Ambiguity

Questions that are ambiguous can be interpreted in multiple ways, where each interpretation could result in a different answer (Min et al., 2020). Given these multiple interpretations, ambiguous questions are challenging for existing models (Keyvan and Huang, 2022), but a few prompting techniques have been developed to help address this challenge.

Ambiguous Demonstrations Gao et al. (2023a) are examples that have an ambiguous label set. Including them in a prompt can increase ICL performance. This can be automated with a retriever, but it can also be done manually.

Question Clarification (Rao and Daumé III, 2019) allows the LLM to identify ambiguous questions and generate clarifying questions to pose to the user. Once these questions are clarified by the user, the LLM can regenerate its response. Mu et al. (2023) do this for code generation and Zhang and Choi (2023) equip LLMs with a similar pipeline for resolving ambiguity for general tasks, but explicitly design separate prompts to: 1) generate an initial answer 2) classify whether to generate clarification questions or return the initial answer 3) decide what clarification questions to generate 4) generate a final answer.

6 Benchmarking 

Now that we have carried out a systematic review of prompting techniques, we will analyze the empirical performance of different techniques in two ways: via a formal benchmark evaluation, and by illustrating in detail the process of prompt engineering on a challenging real-world problem.

6.1 Technique Benchmarking

A formal evaluation of prompting technique might be done in a broad study that compares hundreds of them across hundreds of models and benchmarks. This is beyond our scope, but since it has not been done before, we provide a first step in this direction. We choose a subset of prompting techniques and run them on the widely used benchmark MMLU (Hendrycks et al., 2021). We ran on a representative subset of 2,800 MMLU questions (20% of the questions from each category). and used gpt-3.5-turbo for all experiments.

6.1.1 Comparing Prompting Techniques

We benchmark six distinct prompting techniques using the same general prompt template (Figure 6.2). This template shows the location of different components of the prompts. Only base instructions and question exist in every prompt. The base instruction is a phrase like "Solve the problem and return (A), (B), (C) or (D)." that we vary in some cases. We additionally test two formats of the question (Figures 6.3 and 6.4). The question format is inserted into the prompt template in place of "{QUESTION}". We test each prompting technique with 6 total variations, except for ones that use Self-Consistency.

Zero-Shot As a baseline, we ran questions directly through the model without any prompting techniques. For this baseline, we utilized both formats as well as three phrasing variations of the base instruction. Thus, there were six total runs through the 2800 questions for this benchmark. This did not include any exemplars or thought inducers.

Zero-Shot-CoT Techniques We ran also ran Zero-Shot-CoT. As the three different variations, we used three thought inducers (instructions that cause the model to generate reasoning steps) including the standard "Let's think step by step" chain-of-thought (Kojima et al., 2022), as well as ThoT (Zhou et al., 2023) and Plan and Solve (Wang et al., 2023f). Then, we selected the best of these, then ran it with Self-Consistency with three iterations, taking the majority response.

Few-Shot Techniques We also ran Few-Shot prompts and Few-Shot-CoT prompts, both with exemplars generated by one of our authors. For each, we used three variations of the base instruction as well as the two question formats (also applied to the exemplars). Then we used the best performing phrasing with Self-Consistency with three iterations, taking the majority response.

6.1.2 Question Formats

We experiment with two formatting choices from Sclar et al. (2023b), who explored how formatting choices can affect benchmarking results. We use two formats which lead to varied results on their task (Figures 6.3 and 6.4).

6.1.3 Self-Consistency

For the two Self-Consistency results, we set temperature to 0.5, following Wang et al. (2022)'s guidelines. For all other prompts, a temperature of 0 was used.

6.1.4 Evaluating Responses 

Evaluating whether a LLM has properly responded to a question is a difficult task (Section 2.5). We marked answers as correct if they followed certain identifiable patterns, such as being the only capitalized letter (A-D) within parentheses or following a phrase like "The correct answer is".

6.1.5 Results

Performance generally improved as techniques grew more complex (Figure 6.1). However, Zero-Shot-CoT dropped precipitously from Zero-Shot. Although it had a wide spread, for all variants, Zero-Shot performed better. Both cases of Self-Consistency, naturally had lower spread since they repeated a single technique, but it only improved accuracy for Zero-Shot prompts. Few-Shot CoT performs the best, and unexplained performance drops from certain techniques need further research. As prompting technique selection is akin to hyperparameter search, this it is a very difficult task (Khattab et al., 2023). However, we hope this small study spurs research in the direction of more performant and robust prompting techniques.

6.2 Prompt Engineering Case Study

Prompt engineering is emerging as an art that many people have begun to practice professionally, but the literature does not yet include detailed guidance on the process. As a first step in this direction, we present an annotated prompt engineering case study for a difficult real-world problem. This is not intended to be an empirical contribution in terms of actually solving the problem. Rather, it provides one illustration of how an experienced prompt engineer would approach a task like this, along with lessons learned. 

6.2.1 Problem

Our illustrative problem involves detection of signal that is predictive of crisis-level suicide risk in text written by a potentially suicidal individual. Suicide is a severe problem worldwide, compounded, as are most mental health issues, by a desperate lack of mental health resources. In the United States, more than half the national population lives in federally defined mental heath provider shortage areas (National Center for Health Workforce Analysis, 2023); in addition, many mental health professionals lack core competencies in suicide prevention (Cramer et al., 2023). In 2021, 12.3M Americans thought seriously about suicide, with 1.7M actually making attempts resulting in over 48,000 deaths (CDC, 2023). In the U.S., suicide was the second leading cause of death (after accidents) in people aged 10-14, 15-24, or 25-34 as of 2021 statistics, and it was the fifth leading cause of death in people aged 35–54 (Garnett and Curtin, 2023).

Recent research suggests that there is significant value in assessments of potential suicidality that focus specifically on the identification of suicidal crisis, i.e. the state of acute distress associated with a high risk of imminent suicidal behavior. However, validated assessments for diagnostic approaches such as Suicide Crisis Syndrome (SCS) (Schuck et al., 2019b; Melzer et al., 2024) and Acute Suicidal Affective Disturbance (Rogers et al., 2019) require either personal clinical interactions or completion of self-report questionnaires that contain dozens of questions. The ability to accurately flag indicators of suicidal crisis in individuals' language could therefore have a large impact within the mental health ecosystem, not as a replacement for clinical judgment but as a way to complement existing practices (Resnik et al., 2021).

As a starting point, we focus here on the most important predictive factor in Suicide Crisis Syndrome assessments, referred to in the literature as either frantic hopelessness or entrapment, "a desire to escape from an unbearable situation, tied with the perception that all escape routes are blocked" (Melzer et al., 2024). This characteristic of what an individual is experiencing is also central in other characterizations of mental processes that result in suicide.

6.2.2 The Dataset

We worked with a subset of data from the University of Maryland Reddit Suicidality Dataset (Shing et al., 2018), which is constructed from posts in r/SuicideWatch, a subreddit that offers peer support for anyone struggling with suicidal thoughts. Two coders trained on the recognition of the factors in Suicide Crisis Syndrome coded a set of 221 posts for presence or absence of entrapment, achieving solid inter-coder reliability (Krippendorff's alpha = 0.72).

6.2.3 The Process

An expert prompt engineer, who has authored a widely used guide on prompting (Schulhoff, 2022), took on the task of using an LLM to identify entrapment in posts. The prompt engineer was given a brief verbal and written summary of Suicide Crisis Syndrome and entrapment, along with 121 development posts and their positive/negative labels (where "positive" means entrapment is present), the other 100 labeled posts being reserved for testing. This limited information mirrors frequent real-life scenarios in which prompts are developed based on a task description and the data. More generally, it is consistent with a tendency in natural language processing and AI more generally to approach coding (annotation) as a labeling task without delving very deeply into the fact that the labels may, in fact, refer to nuanced and complex underlying social science constructs.

We documented the prompt engineering process in order to illustrate the way that an experienced prompt engineer goes about their work. The exercise proceeded through 47 recorded development steps, cumulatively about 20 hours of work. From a cold start with 0% performance (the prompt wouldn't return properly structured responses), performance was boosted to an F1 of 0.53, where that F1 is the harmonic mean of 0.86 precision and 0.38 recall.

Below, the set of prompts qinf is the test item, while qi, ri, and ai denote the questions, chain-of-thought steps, and answers in exemplars.

6.2.3.1 Dataset Exploration (2 steps)

The process began with the prompt engineer reviewing a description of entrapment (Figure 6.7); this description had been used as a first-pass rubric for the human coders early in the coding process, noting, however, that they were familiar with SCS and knew it was neither a formal definition nor exhaustive. The prompt engineer then loaded the dataset into a Python notebook for data exploration purposes. He began by asking gpt-4-turbo-preview if it knew what entrapment was (Figure 6.8), but found that the LLM's response was not similar to the description that had been given. In consequence, the prompt engineer included the Figure 6.7 description of entrapment in all future prompts.

6.2.3.2 Getting a Label (8 steps)

As noted in Section 6.1 with regard to the human_sexuality subset of MMLU, LLMs exhibit unpredictable and difficult to control behaviour in sensitive domains. For multiple steps in the prompt engineering process, the prompt engineer found that the LLM was giving mental health advice (e.g. Figure 6.9) instead of labeling the input. This was addressed by switching to the GPT-4-32K model. 

A take-away from this initial phase is that the "guard rails" associated with some large language models may interfere with the ability to make progress on a prompting task, and this could influence the choice of model for reasons other than the LLM's potential quality.

6.2.3.3 Prompting Techniques (32 steps)

The prompt engineer then spent the majority of his time improving the prompting technique being used. This included techniques such as Few-Shot, Chain-of-Thought, AutoCoT, Contrastive CoT, and multiple answer extraction techniques. We report statistics for the first runs of these techniques; F1 scores could change by as much as 0.04 upon subsequent runs, even with temperature and top p set to zero.

Zero-Shot + Context was the first technique evaluated (Figure 6.10), using the description in Figure 6.7. Notice the word definition in the prompt, although Figure 6.7 is not a formal definition.

In order to obtain a final response from the LLM to use in calculating performance metrics, it was necessary to extract a label from the LLM output. The prompt engineer tested two extractors, one that checks if the output is exactly "Yes" or "No", and another which just checks if those words match the first few characters of the output. The latter had better performance, and it is used for the rest of this section until we reach CoT. This approach obtained a 0.25 recall, 1.0 precision, and 0.40 F1, evaluated on all samples from the training/development since no samples had been used as exemplars.

10-Shot + Context. Next, the prompt engineer added the first ten data samples (with labels) into the prompt, in Q: (question) A: (answer) format (Figure 6.11). This 10-shot prompt was evaluated on the remaining items in the training/development set, yielding ↑ 0.05 (0.30) recall, ↓ 0.70 (0.30) precision, and ↑0.05 (0.45) F1 relative to the previous best prompt. 

One-Shot AutoDiCot + Full Context. After performing 10-shot prompting, the prompt engineer observed that the 12th item in the development set was being incorrectly being labeled as a positive instance, and began experimenting with ways of modifying the prompting such that the model would get that item correct. In order to get a sense of why this mislabeling was taking place, the prompt engineer prompted the LLM to generate an explanation of why the 12th item would have been labeled the way it was. 

Figure 6.12 shows a version of that process, generalized to produce explanations for all development question/answer items (qi, ai) in a set T rather than just item 12. Informed by the reasoning steps r12 elicited with respect to the incorrectly labeled q12, the previous prompt was modified by including r12 in a One-Shot CoT example with incorrect reasoning, as an exemplar for what not to do (Figure 6.13).

We call the algorithm in Figure 6.12 Automatic Directed CoT (AutoDiCoT), since it automatically directs the CoT process to reason in a particular way. This technique can be generalized to any labeling task. It combines the automatic generation of CoTs (Zhang et al., 2022b) with showing the LLM examples of bad reasoning, as in the case of Contrastive CoT (Chia et al., 2023). The algorithm was also used in developing later prompts.

Finally, the prompt was extended with two additional pieces of context/instruction. The first was an email message the prompt engineer had received explaining overall goals of the project, which provided more context around the concept of entrapment and the reasons for wanting to label it. The second addition was inspired by the prompt engineer noticing the model was frequently overgenerating a positive label for entrapment. Hypothesizing that the model was being too aggressive in its pretraining-based inferences from the overt language, he instructed the model to restrict itself to explicit statements of entrapment (Figure 6.13). Below we refer to these two pieces of context, provided in addition to the description of entrapment, as full context.

A new extractor was also used for this prompt, which checks if the last word in the output is "Yes" or "No", instead of the first word. This updated prompt was tested against all inputs in the development set except for the first 20. It did not improve F1, ↓0.09 (0.36) F1, but it led the prompt engineer in a direction that did, as discussed below. Precision improved to ↑ 0.09 (0.39) precision and recall dropped ↑ 0.03 (0.33) recall. 

At this point, though, it is worth observing that, although it did ultimately lead to a gain in F1 score, the steps taken here to cut down on over-generation of positive labels were not, in fact, the right move in terms of the longer term goals. Entrapment need not be expressed explicitly in order to be present (e.g. through phrases like "I feel trapped" or "There's no way out"); rather, clinical experts who have looked at the texts found that expressions of entrapment could be implicit and potentially quite nuanced. Moreover, in most use cases for automatically spotting entrapment in someone's language, precision and recall are unlikely to be equally important and, of the two, the recall/sensitivity (i.e. not missing people who should be flagged as at-risk) may matter more because the potential cost of a false negative is so high. 

The take-away here, although the insight came later, is that it is easy for the process of prompt development to diverge from the actual goals unless regular engagement is fostered between the prompt engineer, who has expertise in how to coax LLMs to behave in desired ways, and domain experts, who understand what those desired ways are and why.

Ablating Email. The results of the previous changes were promising, but they did involve creating a prompt that included information from an email message that had not been created for that purpose, and which included information about the project, the dataset, etc. that were not intended for disclosure to a broad audience. Ironically, though, removing this email significantly brought performance back down, ↓ 0.18 (0.18) F1, ↓ 0.22(0.17) precision and ↓ 0.13 (0.20) recall. We attribute this to the fact that the email provided richer background information about the goals of the labeling. Although we would not recommend including email or any other potentially identifying information in any LLM prompt, we chose to leave the email in the prompt; this is consistent with scenarios in many typical settings, in which prompts are not expected to be exposed to others.

10-Shot + 1 AutoDiCoT. As a next step, the prompt engineer tried including full context, 10 regular exemplars, and the one-shot exemplar about how not to reason. This hurt performance (Figure 6.14) ↓ 0.30 (0.15) F1, ↓ 0.15 (0.15) precision, ↓ 0.15 (0.15) recall.

Full Context Only. Next, a prompt was created using only full context, without any exemplars (Figure 6.15). This boosted performance over the previous technique, ↓ 0.01 (0.44) F1, ↓ 0.01 (0.29) precision, ↑ 0.62 (0.92) recall. Interestingly, in this prompt, the prompt engineer accidentally pasted in the full-context email twice, and that ended up having significant positive effects on performance later (and removing the duplicate actually decreased performance). This is reminiscent of the re-reading technique (Xu et al., 2023).

This can be interpreted both optimistically and pessimistically. Optimistically, it demonstrates how improvements can arise through exploration and fortuitous discovery. On the pessimistic side, the value of duplicating the email in the prompt highlights the extent to which prompting remains a difficult to explain black art, where the LLM may turn out to be unexpectedly sensitive to variations one might not expect to matter.

10-Shot AutoDiCoT. The next step was to create more AutoDiCoT exemplars, per the algorithm in Figure 6.12. A total of ten new AutoDiCoT exemplars were added to the full context prompt (Figure 6.16). This yielded the most successful prompt from this prompt engineering exercise, in terms of F1 score, ↑ 0.08 (0.53) F1, ↑ 0.08 (0.38) precision, ↑ 0.53 (0.86) recall.

20-Shot AutoDiCoT. Further experimentation proceeded seeking (unsuccesfully) to improve on the previous F1 result. In one attempt, the prompt engineer labeled an additional ten exemplars, and created a 20-shot prompt from the first 20 data points in the development set. This led to worse results than the 10-shot prompt, when tested on all samples other than the first twenty, ↓ 0.04 (0.49) F1, ↓ 0.05 (0.33) precision, ↑ 0.08 (0.94) recall. Notably, it also yielded worse performance on the test set.

20-Shot AutoDiCoT + Full Words. The prompt engineer conjectured that the LLM would perform better if the prompt included full words Question, Reasoning, and Answer rather than Q, R, A. However, this did not succeed (Figure 6.17), ↓ 0.05 (0.48) F1, ↓ 0.06 (0.32) precision, ↑ 0.08 (0.94) recall.

20-Shot AutoDiCoT + Full Words + Extraction Prompt. The prompt engineer then noticed that in many cases, the LLM generated outputs that could not properly be parsed to obtain a response. So, they crafted a prompt that extracted answers from the LLM's response (Figure 6.18). Although this improved accuracy by a few points, it decreased F1, thanks to the fact that many of the outputs that had been unparsed actually contained incorrect responses, ↓ 0.05 (0.48) F1, ↓ 0.05 (0.33) precision, with no change in recall (0.86).

10-Shot AutoDiCoT + Extraction Prompt. Applying the extraction prompt to the best performing 10-Shot AutoDiCoT prompt did not improve results, ↓ 0.04 (0.49) F1, ↓ 0.06 (0.78) recall, ↓ 0.03 (0.35) precision.

10-Shot AutoDiCoT without Email. As noted above, removing the email outright from the prompt hurt performance, ↓ 0.14 (0.39) F1, ↓ 0.38 (0.48) recall, ↓ 0.05 (0.33) precision.

De-Duplicating Email. Also as noted above, it seemed reasonable that removing the duplication of the email would perform as well or better than the prompt with the unintentional duplication. As it turned out, however, removing the duplicate significantly hurt performance, ↓ 0.07 (0.45) F1, ↓ 0.13 (0.73) recall, ↓ 0.05 (0.33) precision.

10-Shot AutoDiCoT + Default to Negative. This approach used the best performing prompt, and defaulted to labeling as negative (not entrapment) in the case of answers that are not extracted properly. This did not help performance, ↓ 0.11 (0.42) F1, ↓ 0.03 (0.83) recall, ↓ 0.10 (0.28) precision.

Ensemble + Extraction. Especially for systems that are sensitive to the details of their inputs, there are advantages in trying multiple variations of an input and then combining their results. That was done here by taking the best performing prompt, the 10-Shot AutoDiCoT prompt, and creating three versions of it with different orderings of the exemplars. The average of the three results was taken to be the final answer. Unfortunately, both orderings that differed from the default ordering led to the LLM not outputting a well structured response. An extraction prompt was therefore used to obtain final answers. This exploration hurt rather than helped performance ↓ 0.16 (0.36) F1, ↓ 0.22 (0.64) recall, ↓ 0.12 (0.26) precision.

10-Shot AutoCoT + 3x the context (no email dupe). Recall that context refers to the description of entrapment, an instruction about explicitness, and an email. Since the duplicated email had improved performance, the prompt engineer tested out pasting in three copies of the context (first de-duplicating the email). However, this did not improve performance, ↓ 0.06 (0.47) F1, ↓ 0.08 (0.78) recall, ↓ 0.05 (0.33) precision.

Anonymize Email. At this point it seemed clear that including the duplicated email in the prompt was actually, although not explainably, essential to the best performance so far obtained. The prompt engineer decided to anonymize the email by replacing personal names with other, random names. However, surprisingly, this decreased performance significantly ↓ 0.08 (0.45) F1, ↓ 0.14 (0.72) recall, ↓ 0.05 (0.33) precision.

DSPy. We concluded the case study by exploring an alternative to manual prompt engineering, the DSPy framework (Khattab et al., 2023), which automatically optimizes LLM prompts for a given target metric. Specifically, we begin with a chain-of-thought classification pipeline that uses the definition of entrapment in Figure 6.7. Over 16 iterations, DSPy bootstrapped synthetic LLM-generated demonstrations and randomly sampled training exemplars, with the ultimate objective of maximizing F1 on the same development set used above. We used gpt-4-0125-preview and the default settings for the BootstrapFewShotWithRandomSearch "teleprompter" (the optimization approach). Figure 6.19 shows the results of two of these prompts on the test set, one of which used default DSPy behaviour, and the second which was manually modified slightly from this default. The best resulting prompt includes 15 exemplars (without CoT reasoning) and one bootstrapped reasoning demonstration. It achieves 0.548 F1 (and 0.385 / 0.952 precision / recall) on the test set, without making any use of the professor's email nor the incorrect instruction about the explicitness of entrapment. It also performs much better than the human prompt engineer's prompts on the test set, which demonstrates the significant promise of automated prompt engineering.

6.2.4 Discussion

Prompt engineering is a non-trivial process, the nuances of which are not currently well described in literature. From the fully manual process illustrated above, there are several take-aways worth summarizing. First, prompt engineering is fundamentally different from other ways of getting a computer to behave the way you want it to: these systems are being cajoled, not programmed, and, in addition to being quite sensitive to the specific LLM being used, they can be incredibly sensitive to specific details in prompts without there being any obvious reason those details should matter. Second, therefore, it is important to dig into the data (e.g. generating potential explanations for LLM "reasoning" that leads to incorrect responses). Related, the third and most important take-away is that prompt engineering should involve engagement between the prompt engineer, who has expertise in how to coax LLMs to behave in desired ways, and domain experts, who understand what those desired ways are and why. 

Ultimately we found that there was significant promise in an automated method for exploring the prompting space, but also that combining that automation with human prompt engineering/revision was the most successful approach. We hope that this study will serve as a step toward more robust examinations of how to perform prompt engineering.

7 Related Work

In this section, we review existing surveys and meta-analyses of prompting. Liu et al. (2023b) perform a systematic review of prompt engineering in the pre-ChatGPT era, including various aspects of prompting like prompt template engineering, answer engineering, prompt ensembling, and prompt tuning methods. Their review covers many different types of prompting (e.g., cloze, soft-prompting, etc., across many different types of language models) while we focus on discrete prefix prompting but more in-depth discussion. Chen et al. (2023a) provide a review of popular prompting techniques like Chain-of-Thought, Tree-of-Thought, Self-Consistency, and Least-to-Most prompting, along with outlooks for future prompting research. White et al. (2023) and Schmidt et al. (2023) provide a taxonomy of prompt patterns, which are similar to software patterns (and prompting techniques for that matter). Gao (2023) provide a practical prompting technique tutorial for a non-technical audience. Santu and Feng (2023) provide a general taxonomy of prompts that can be used to design prompts with specific properties to perform a wide range of complex tasks. Bubeck et al. (2023) qualitatively experiment with a wide range of prompting methods on the early version of GPT-4 to understand its capabilities. Chu et al. (2023) review Chain-of-Thought related prompting methods for reasoning. In earlier work, Bommasani et al. (2021) review and discuss opportunities and risks of foundation models broadly, and Dang et al. (2022) discuss prompting strategies for interactive creative applications that use prompting as a new paradigm for human interaction, with a particular focus on the user interface design that supports user prompting. As an addition to these existing surveys, our review aims to provide a more updated and formalized systematic review.

There is also a line of work that surveys prompting techniques for particular domains or downstream applications. Meskó (2023) and Wang et al. (2023d) offer recommended use cases and limitations of prompt engineering in the medical and healthcare domains. Heston and Khun (2023) provide a review of prompt engineering for medical education use cases. Peskoff and Stewart (2023) query ChatGPT and YouChat to assess domain coverage. Hua et al. (2024) use a GPT-4-automated approach to review LLMs in the mental health space. Wang et al. (2023c) review prompt engineering and relevant models in the visual modality and Yang et al. (2023e) provided a comprehensive list of qualitative analyses of multimodal prompting, particularly focusing on GPT-4V. Durante et al. (2024) review multimodal interactions based on LLM embodied agents. Ko et al. (2023b) review literature on the adoption of Text-to-Image generation models for visual artists' creative works. Gupta et al. (2024) review GenAI through a topic modeling approach. Awais et al. (2023) review foundation models in vision, including various prompting techniques. Hou et al. (2023) perform a systematic review of prompt engineering techniques as they relate to software engineering. They use a systematic review technique developed by Keele et al. (2007), specifically for software engineering reviews. Wang et al. (2023e) review the literature on software testing with large language models. Zhang et al. (2023a) review ChatGPT prompting performance on software engineering tasks such as automated program repair. Neagu (2023) provide a systematic review on how prompt engineering can be leveraged in computer science education. Li et al. (2023j) review literature on the fairness of large language models. There are also surveys on related aspects such as hallucination of language models (Huang et al., 2023b), verifiability (Liu et al., 2023a), reasoning (Qiao et al., 2022), augmentation (Mialon et al., 2023), and linguistic properties of prompts (Leidinger et al., 2023). Different from these works, we perform our review targeting broad coverage and generally applicable prompting techniques. Finally, in terms of more general prior surveys (Liu et al., 2023b; Sahoo et al., 2024), this survey offers an update in a fast-moving field. In addition, we provide a starting point for taxonomic organization of prompting techniques and standardization of terminology. Moreover, we base our work in the widely well-received standard for systematic literature reviews — PRISMA (Page et al., 2021).

8 Conclusions

Generative AI is a novel technology, and broader understanding of models' capabilities and limitations remains limited. Natural language is a flexible, open-ended interface, with models having few obvious affordances. The use of Generative AI therefore inherits many of the standard challenges of linguistic communication—e.g., ambiguity, the role of context, the need for course correction—while at the same time adding the challenge of communicating with an entity whose "understanding" of language may not bear any substantial relationship to human understanding. Many of the techniques described here have been called "emergent", but it is perhaps more appropriate to say that they were discovered—the result of thorough experimentation, analogies from human reasoning, or pure serendipity.  

The present work is an initial attempt to categorize the species of an unfamiliar territory. While we make every attempt to be comprehensive, there are sure to be gaps and redundancies. Our intention is to provide a taxonomy and terminology that cover a large number of existing prompt engineering techniques, and which can accommodate future methods. We discuss over 200 prompting techniques, frameworks built around them, and issues like safety and security that need to be kept in mind when using them. We also present two case studies in order to provide a clear sense of models' capabilities and what it is like to tackle a problem in practice. Last, our stance is primarily observational, and we make no claims to the validity of the presented techniques. The field is new, and evaluation is variable and unstandardized—even the most meticulous experimentation may suffer from unanticipated shortcomings, and model outputs themselves are sensitive to meaning-preserving changes in inputs. As a result, we encourage the reader to avoid taking any claims at face value and to recognize that techniques may not transfer to other models, problems, or datasets.

To those just beginning in prompt engineering, our recommendations resemble what one would recommend in any machine learning setting: understand the problem you are trying to solve (rather than just focusing on input/output and benchmark scores), and ensure the data and metrics you are working with constitute a good representation of that problem. It is better to start with simpler approaches first, and to remain skeptical of claims about method performance. To those already engaged in prompt engineering, we hope that our taxonomy will shed light on the relationships between existing techniques. To those developing new techniques, we encourage situating new methods within our taxonomy, as well as including ecologically valid case studies and illustrations of those techniques.

Acknowledgements

We appreciate the advice given by Hal Daumé III, Adam Visokay, and Jordan Boyd-Graber and review by Diyi Yang and Brandon M. Stewart. We also appreciate the 10K USD in API credits given by OpenAI and design work by Benjamin DiMarco.

A Appendices

A.1 Definitions of Prompting 
A.2 Extended Vocabulary 
A.3 Datasheet 
A.4 Keywords 
A.5 Evaluation Table 
A.6 Entrapment Prompting Process 
A.7 Formally Defining a Prompt 
A.8 In-Context Learning Definitions Disambiguation
A.9 Contributions 

The full appendices provide additional details on the definitions of prompting from various papers, an extended vocabulary of prompting terms, a datasheet for the dataset of papers used in this survey, the keywords used to search for papers, a summary table of evaluation techniques, a detailed description of the prompt engineering case study on entrapment detection, a formal definition of prompts, a disambiguation of in-context learning definitions, and details on author contributions to the various sections of the paper.