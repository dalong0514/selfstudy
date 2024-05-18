## 2023077Retrieval-Augmented-Generation-for-Large-Language-Models-A-Survey

[[2312.10997] Retrieval-Augmented Generation for Large Language Models: A Survey](https://arxiv.org/abs/2312.10997)

[面向大语言模型的检索增强生成技术：调查 [译] | 宝玉的分享](https://baoyu.io/translations/ai-paper/2312.10997-retrieval-augmented-generation-for-large-language-models-a-survey)

Translated on December 22, 2023

Published on December 18, 2023

主要作者：Yunfan Gao、Yun Xiong、Xinyu Gao、Kangxiang Jia、Jinliu Pan、Yuxi Bi、Yi Dai，特别鸣谢 Jiawei Sun 和 Haofen Wang 所属机构：1. 同济大学上海智能自主系统研究院；2. 复旦大学计算机科学学院，数据科学上海重点实验室；3. 同济大学设计与创新学院联系邮箱：gaoyunfan1602@gmail.com

在这篇调查中，我们关注的是面向大语言模型（Large Language Model）的检索增强生成技术。这项技术通过结合检索机制，增强了大语言模型在处理复杂查询和生成更准确信息方面的能力。我们从同济大学和复旦大学的相关研究团队出发，综合分析了该领域的最新进展和未来趋势。

### Abstract

Large language models (LLMs) demonstrate powerful capabilities, but they still face challenges in practical applications, such as hallucinations, slow knowledge updates, and lack of transparency in answers. Retrieval-Augmented Generation (RAG) refers to the retrieval of relevant information from external knowledge bases before answering questions with LLMs. RAG has been demonstrated to significantly enhance answer accuracy, reduce model hallucination, particularly for knowledgeintensive tasks. By citing sources, users can verify the accuracy of answers and increase trust in model outputs. It also facilitates knowledge updates and the introduction of domain-specific knowledge. RAG effectively combines the parameterized knowledge of LLMs with non-parameterized external knowledge bases, making it one of the most important methods for implementing large language models. This paper outlines the development paradigms of RAG in the era of LLMs, summarizing three paradigms: Naive RAG, Advanced RAG, and Modular RAG. It then provides a summary and organization of the three main components of RAG: retriever, generator, and augmentation methods, along with key technologies in each component. Furthermore, it discusses how to evaluate the effectiveness of RAG models, introducing two evaluation methods for RAG, emphasizing key metrics and abilities for evaluation, and presenting the latest automatic evaluation framework. Finally, potential future research directions are introduced from three aspects: vertical optimization, horizontal scalability, and the technical stack and ecosystem of RAG.1

摘要

大型语言模型 (大语言模型，LLMs) 虽展现出强大能力，但在实际应用中，例如在准确性、知识更新速度和答案透明度方面，仍存在挑战。检索增强生成 (Retrieval-Augmented Generation, RAG) 是指在利用大型语言模型回答问题之前，先从外部知识库检索相关信息。

RAG 被证明能显著提升答案的准确性，并特别是在知识密集型任务上减少模型的错误输出。通过引用信息来源，用户可以核实答案的准确性，从而增强对模型输出的信任。

此外，RAG 有助于快速更新知识并引入特定领域的专业知识。

RAG 有效结合了大型语言模型的参数化知识和非参数化的外部知识库，成为实施大型语言模型的关键方法之一。本文概述了 RAG 在大型语言模型时代的发展模式，总结了三种模式：初级 RAG、高级 RAG 和模块化 RAG。接着，本文梳理了 RAG 的三个主要组成部分：检索器、生成器和增强方法，以及每个部分的关键技术。同时，本文讨论了如何评估 RAG 模型的有效性，介绍了两种评估方法，强调了关键的评估指标和能力，并展示了最新的自动评估框架。最后，文章从垂直优化、水平扩展性和 RAG 的技术堆栈及生态系统三个方面，介绍了未来可能的研究方向。

### 01. Introduction

The large language models (LLMs) are than anything we have seen in Processing (NLP) before. The more Natural GPT series models [ Brown et al., 2020, OpenAI, 2023 ] , the LLama series models [ Touvron et al., 2023 ] , Gemini [ Google, 2023 ] , and other large language models demonstrate impressive language and knowledge mastery, surpassing human benchmark levels in multiple evaluation benchmarks [ Wang et al., 2019, Hendrycks et al., 2020, Srivastava et al., 2022 ].

However, large language models also exhibit numerous shortcomings. They often fabricate facts [ Zhang et al., 2023b ] and lack knowledge when dealing with specific domains or highly specialized queries [ Kandpal et al., 2023 ] . For instance, when the information sought extends beyond the model's training data or requires the latest data, LLM may fail to provide accurate answers. This limitation poses challenges when deploying generative artificial intelligence in real-world production environments, as blindly using a black-box LLM may not suffice.

Traditionally, neural networks adapt to specific domains or proprietary information by fine-tuning models to parameterize knowledge. While this technique yields significant results, it demands substantial computational resources, incurs high costs, and requires specialized technical expertise, making it less adaptable to the evolving information landscape. Parametric knowledge and non-parametric knowledge play distinct roles. Parametric knowledge is acquired through training LLMs and stored in the neural network weights, representing the model's understanding and generalization of the training data, forming the foundation for generated responses. Non-parametric knowledge, on the other hand, resides in external knowledge sources such as vector databases, not encoded directly into the model but treated as updatable supplementary information. Non-parametric knowledge empowers LLMs to access and leverage the latest or domainspecific information, enhancing the accuracy and relevance of responses.

Purely parameterized language models (LLMs) store their world knowledge, which is acquired from vast corpora, in the parameters of the model. Nevertheless, such models have their limitations. Firstly, it is difficult to retain all the knowledge from the training corpus, especially for less common and more specific knowledge. Secondly, since the model parameters cannot be updated dynamically, the parametric knowledge is susceptible to becoming outdated over time. Lastly, an expansion in parameters leads to increased computational expenses for both training and inference. To address the limitations of purely parameterized models, language models can adopt a semi-parameterized approach by integrating a non-parameterized corpus database with parameterized models. This approach is known as RetrievalAugmented Generation (RAG).

The term Retrieval-Augmented Generation (RAG) was first introduced by [ Lewis et al., 2020 ] . It combines a pretrained retriever with a pre-trained seq2seq model (generator) and undergoes end-to-end fine-tuning to capture knowledge in a more interpretable and modular way. Before the advent of large models, RAG primarily focused on direct optimization of end-to-end models. Dense retrievals on the retrieval side, such as the use of vector-based Dense Passage Retrieval (DPR) [ Karpukhin et al., 2020 ] , and training smaller models on the generation side are common practices. Due to the overall smaller parameter size, both the retriever and generator often undergo synchronized end-to-end training or finetuning [ Izacard et al., 2022 ] .

After the emergence of LLM like ChatGPT, generative language models became predominant, showcasing impressive performance across various language tasks [ Bai et al., 2022, OpenAI, 2023, Touvron et al., 2023, Google, 2023 ] . However, LLMs still face challenges such as hallucinations [ Yao et al., 2023, Bang et al., 2023 ] , knowledge updates, and data-related issues. This affects the reliability of LLMs, making them struggle in certain serious task scenarios, especially in knowledge-intensive tasks requiring access to a vast amount of knowledge, such as open-domain question answering [ Chen and Yih, 2020, Reddy et al., 2019, Kwiatkowski et al., 2019 ] and commonsense reasoning [ Clark et al., 2019, Bisk et al., 2020 ] . Implicit knowledge within parameters may be incomplete and insufficient.

Subsequent research found that introducing RAG into large models' In-Context Learning (ICL) can alleviate the aforementioned issues, with significant and easily implementable effects. During the inference process, RAG dynamically retrieves information from external knowledge sources, using the retrieved data as references to organize answers. This substantially improves the accuracy and relevance of responses, effectively addressing the hallucination issues present in LLMs. This technique quickly gained traction after the advent of LLM and has become one of the hottest technologies for improving chatbots and making LLM more practical. By separating factual knowledge from the training parameters of LLMs, RAG cleverly combines the powerful capabilities of generative models with the flexibility of retrieval modules, providing an effective solution to the incomplete and insufficient knowledge problem inherent in purely parameterized models.

The paper systematically reviews and analyzes the current research approaches and future development paths of RAG, summarizing them into three main paradigms: Naive RAG, Advanced RAG, and Modular RAG. Subsequently, the paper provides a consolidated summary of the three core components: Retrieval, Augmented, and Generation, highlighting the improvement directions and current technological characteristics of RAG. In the section on augmentation methods, the current work is organized into three aspects: the augmentation stages of RAG, augmentation data sources, and augmentation process. Furthermore, the paper summarizes the evaluation system, applicable scenarios, and other relevant content related to RAG. Through this article, readers gain a more comprehensive and systematic understanding of large models and retrieval-Augmented generation. They become familiar with the evolutionary path and key technologies of knowledge retrieval augment, enabling them to discern the advantages and disadvantages of different techniques, identify applicable scenarios, and explore current typical application cases in practice.It is noteworthy that in previous work, Feng el al. [ 2023b ] systematically reviewed the methods, applications, and future trends of combining large models with knowledge, with a primary focus on knowledge editing and retrieval augmentation methods. Zhu et al. [ 2023 ] introduced

the latest advancements in augmenting retrieval systems for Large Language Models, with a specific focus on the retrieval system. Meanwhile, Asai et al. [ 2023a ] focusing on questions such as "What", "When", "How", analyzed and elucidated the key processes in Retrieval-based Language Models. In comparison with them, this paper aims to systematically outline the entire process of Retrieval-Augmented Generation (RAG) and focuses specifically on research related to augmenting the generation of large language models through knowledge retrieval.

The development of RAG algorithms and models is illustrated in Fig 1. On a timeline, most of the research related to RAG emerged after 2020, with a significant turning point in December 2022 when ChatGPT was released. Since the release of ChatGPT, research in the field of natural language processing has entered the era of large models. Naive RAG techniques quickly gained prominence, leading to a rapid increase in the number of related studies.In terms of enhancement strategies, research on reinforcement during the pre-training and supervised fine-tuning stages has been ongoing since the concept of RAG was introduced. However, most of the research on reinforcement during the inference stage emerged during the era of LLMs. This is primarily due to the high training costs associated with high-performance large models. Researchers have attempted to enhance model generation by incorporating external knowledge in a cost-effective manner through the inclusion of RAG modules during the inference stage. Regarding the use of augmented data, early RAG primarily focused on the application of unstructured data, particularly in the context of open-domain question answering. Subsequently, the range of knowledge sources for retrieval expanded, with the use of high-quality data as knowledge sources effectively addressing issues such as internalization of incorrect knowledge and hallucinations in large models. This includes structured knowledge, with knowledge graphs being a representative example. Recently, there has been increased attention on self-retrieval, which involves mining the knowledge of LLMs themselves to enhance their performance.

The subsequent chapters of this paper are structured as follows: Chapter 2 provides an introduction to the background of RAG.Chapter 3 introduces the mainstream paradigms of RAG.Chapter 4 analyzes the retriever in RAG.Chapter 5 focuses on introducing the generator in RAG.Chapter 6 emphasizes the introduction of the augmentation methods in RAG.Chapter 7 introduces the evaluation system of RAG. Chapter 8 provides an outlook on the future development trends of RAG. Finally, in Chapter 9, we summarize the main contents of the survey.

大型语言模型 (LLMs) 在自然语言处理 (NLP) 领域的表现远超以往任何模型。

GPT 系列模型 [Brown et al., 2020, OpenAI, 2023]、LLama 系列模型 [Touvron et al., 2023]、Gemini [Google, 2023] 等大型语言模型，在多个评估基准上展现了卓越的语言掌握和知识理解能力，甚至超越了多项人类评估基准 [Wang et al., 2019, Hendrycks et al., 2020, Srivastava et al., 2022]。

然而，大型语言模型也存在许多不足。

例如，它们可能产生不准确的信息 [Zhang et al., 2023b]，并在处理特定领域或高度专业化的查询时表现出知识缺失 [Kandpal et al., 2023]。当所需信息超出模型训练数据范围或需要最新数据时，大型语言模型可能无法提供准确答案。这一限制在将生成式人工智能部署到真实世界生产环境中尤其成为挑战，因为仅依赖于黑盒式的大型语言模型可能不够。

神经网络通常通过对模型进行微调来适应特定领域或专有信息，从而将知识参数化。尽管这种方法取得了显著成效，但它需要消耗大量计算资源，成本高昂，且需要专业技术知识，因此难以适应不断变化的信息环境。在这个过程中，参数化知识和非参数化知识各司其职。参数化知识是通过训练大语言模型（LLM）获得的，存储在神经网络的权重中，代表模型对训练数据的理解和泛化能力，是生成回应的基础。而非参数化知识则存储在外部的知识源，如向量数据库中，不直接编入模型，而是作为一种可更新的补充信息。非参数化知识使大语言模型能够访问和利用最新或特定领域的信息，提高回应的准确性和相关性。

纯参数化的语言模型（LLM）将其从大量语料库中学习到的世界知识储存在模型参数中。但这种模型存在局限性。首先，它难以保留训练语料库中的所有知识，特别是对于那些不太常见且具体的知识。其次，由于模型参数无法动态更新，参数化知识可能会随时间过时。最后，参数的增加会导致训练和推理的计算成本增加。为了解决纯参数化模型的局限，语言模型可以采取半参数化方法，将非参数化的语料库数据库与参数化模型相结合。这种方法被称为检索增强生成（Retrieval-Augmented Generation, RAG）。

「检索增强生成」（Retrieval-Augmented Generation, RAG）一词最早由 [Lewis et al., 2020] 提出。它结合了一个预训练的检索器和一个预训练的序列到序列模型（生成器），通过端到端微调来以更可解释和模块化的方式捕获知识。在大型模型出现之前，RAG 主要专注于直接优化端到端模型。例如，在检索方面使用基于向量的密集通道检索（Dense Passage Retrieval, DPR）[Karpukhin et al., 2020]，以及在生成方面训练较小的模型是常见的做法。

由于总体参数较少，检索器和生成器通常会进行同步的端到端训练或微调 [Izacard et al., 2022]。

随着像 ChatGPT 这样的大语言模型的出现，生成式语言模型在各种语言任务中展现出卓越的性能，得到了越来越多的关注和应用 [Bai et al., 2022, OpenAI, 2023, Touvron et al., 2023, Google, 2023]。

然而，大语言模型 (LLMs) 仍面临诸如幻觉式错误 [Yao et al., 2023, Bang et al., 2023]、知识更新以及数据相关问题的挑战。

这些问题影响了大语言模型的可靠性，在一些严肃的任务场景中，尤其是在需要广泛知识的知识密集型任务，例如开放领域问题回答 [Chen and Yih, 2020, Reddy et al., 2019, Kwiatkowski et al., 2019] 和常识推理 [Clark et al., 2019, Bisk et al., 2020]，它们表现出了挑战。

模型参数中的隐含知识可能不够完整或不足。

后续研究发现，将 RAG 引入大模型的上下文学习 (In-Context Learning, ICL) 中，可以有效减轻上述问题，这种方法具有明显且易于实施的效果。在推理过程中，RAG 动态地从外部知识源中检索信息，并利用这些检索到的数据作为组织答案的参考。这极大地提高了答案的准确性和相关性，有效地解决了大语言模型中的幻觉式错误问题。这项技术自大语言模型出现以来迅速受到关注，已成为提升聊天机器人效能和增强大语言模型实用性的前沿技术之一。RAG 通过将事实知识与大语言模型的训练参数分离，巧妙地结合了生成模型的强大功能和检索模块的灵活性，为纯参数化模型中固有的知识不完整和不充分问题提供了有效的解决方案。

本论文系统地审视并分析了检索增强生成（RAG）的现有研究方法和未来发展道路，把它们归纳为三大范式：初级 RAG、高级 RAG 和模块化 RAG。接着，论文提供了关于三个核心组成部分的综合概述：检索（Retrieval）、增强（Augmented）、生成（Generation），强调了 RAG 的改进方向和目前的技术特色。在论述增强方法的章节中，将现有工作分为三个方面：RAG 的增强阶段、增强数据源以及增强过程。此外，论文还概述了与 RAG 相关的评估体系、适用场景等内容。通过阅读这篇文章，读者可以更全面、系统地理解大语言模型和检索增强生成的概念，深入了解知识检索增强的发展历程和关键技术，从而能够辨析不同技术的优缺点，找出适用的场景，并在实际中探索典型的应用案例。值得一提的是，Feng 等人 [2023b] 在他们的研究中系统回顾了结合大语言模型与知识的方法、应用和未来趋势，特别关注了知识编辑和检索增强方法。Zhu 等人 [2023] 则介绍了针对大语言模型的检索系统增强方面的最新进展，尤其关注检索系统本身。

同时，Asai 等人 [2023a] 针对「什么」、「何时」、「如何」等问题，分析并阐释了基于检索的语言模型的关键步骤。与之相比，本文的目的是系统性地概述检索增强生成（RAG）的整个流程，并特别关注通过知识检索来增强大语言模型生成的研究。

图 1：现有 RAG 研究的时间表。时间表主要根据发布日期确定。

图 1 展示了 RAG 算法和模型的发展。在时间线上，大部分与 RAG 相关的研究出现在 2020 年之后，尤其是在 2022 年 12 月 ChatGPT 发布之后，这一事件成为了一个重要的转折点。ChatGPT 发布后，自然语言处理领域的研究进入了大模型时代。初级 RAG 技术迅速受到重视，相关研究的数量也随之激增。在增强策略方面，自 RAG 概念提出以来，预训练和监督微调阶段的强化研究一直在进行。然而，在大语言模型时代，推理阶段的强化研究开始增多。这主要是因为高性能大模型的训练成本很高。研究者们试图在推理阶段通过加入 RAG 模块，以成本效益的方式将外部知识整合进模型生成中。

在探讨增强数据的使用方面，早期的 RAG 主要致力于非结构化数据的应用，特别是在开放域问答环境中。随着时间的推移，RAG 检索的知识来源变得更加广泛，其中包括高质量数据。这些数据作为知识源，有效避免了如大模型误采纳错误信息和产生错误假设（即「幻觉」）的问题。值得一提的是，RAG 也开始利用结构化知识，如知识图谱。近期，自我检索成为热点，这指的是利用大语言模型自身的知识库来提升其性能。

本论文的接下来章节安排如下：第 2 章介绍 RAG 的背景知识。第 3 章探讨 RAG 的主流模式。第 4 章分析 RAG 中的检索器功能。第 5 章着重讲述 RAG 中的生成器如何工作。第 6 章强调介绍 RAG 中的数据增强方法。第 7 章讲解 RAG 的评估体系。第 8 章展望了 RAG 未来的发展方向。最后，在第 9 章中，我们总结了本次调研的主要内容。

### 02. Background

In this chapter, we will introduce the definition of RAG, as well as the comparison between RAG and other model optimization techniques, such as fine-tuning.

Figure 1: A timeline of existing RAG research. The timeline was established mainly according to the release date.

#### 2.1 Definition

The meaning of RAG has expanded in tandem with technological developments. In the era of Large Language Models, the specific definition of RAG refers to the model, when answering questions or generating text, first retrieving relevant information from a vast corpus of documents. Subsequently, it utilizes this retrieved information to generate responses or text, thereby enhancing the quality of predictions. The RAG method allows developers to avoid the need for retraining the entire large model for each specific task. Instead, they can attach a knowledge base, providing additional information input to the model and improving the accuracy of its responses. RAG methods are particularly well-suited for knowledge-intensive tasks. In summary, the RAG system consists of two key stages:

1. Utilizing encoding models to retrieve relevant documents based on questions, such as BM25, DPR, ColBERT, and similar approaches [ Robertson et al., 2009, Karpukhin et al., 2020, Khattab and Zaharia, 2020 ] .

2. Generation Phase: Using the retrieved context as a condition, the system generates text.

本章节我们将介绍 RAG（一种模型优化技术）的定义，并将其与其他优化技术，如微调，进行对比。

2.1 定义

在技术进步的背景下，RAG 的概念也随之拓展。在大语言模型 (Large Language Models) 的领域中，RAG 特指一种模式：模型在回答问题或生成文本时，首先从广阔的文档库中寻找相关信息。然后，模型使用这些找到的信息来生成回答或文本，从而提高其预测的准确度。RAG 的方法使得开发人员无需为每一个特定任务重新训练整个庞大的模型。他们可以简单地给模型加上一个知识库，通过这种方式增加模型的信息输入，从而提高回答的精确性。RAG 特别适用于那些需要大量知识的任务。简而言之，RAG 系统包括两个主要阶段：

使用编码模型（如 BM25、DPR、ColBERT 等）根据问题找到相关的文档 [Robertson et al., 2009, Karpukhin et al., 2020, Khattab and Zaharia, 2020]。

生成阶段：以找到的上下文作为基础，系统生成文本。

图 2：RAG 与其他模型优化方法的比较

#### 2.2 RAG vs Fine-tuning

In the optimization of Large Language Models (LLMs), in addition to RAG, another important optimization technique is fine-tuning.

RAG is akin to providing a textbook to the model, allowing it to retrieve information based on specific queries. This approach is suitable for scenarios where the model needs to answer specific inquiries or address particular information retrieval tasks. However, RAG is not suitable for teaching the model to understand broad domains or learn new languages, formats, or styles.

Fine-tuning is similar to enabling students to internalize knowledge through extensive learning. This approach is useful when the model needs to replicate specific structures, styles, or formats. Fine-tuning can enhance the performance of non-fine-tuned models and make interactions more efficient. It is particularly suitable for emphasizing existing knowledge in the base model, modifying or customizing the model's output, and providing complex directives to the model. However, fine-tuning is not suitable for incorporating new knowledge into the model or for situations that demand quick iteration for new use cases.

Fine-tuning is similar to having students internalize knowledge through prolonged learning. This method is applicable when the model needs to replicate specific structures, styles, or formats. Fine-tuning can achieve performance superior to non-fine-tuned models, and interactions are more efficient. Fine-tuning is particularly suitable for emphasizing existing knowledge in the base model, modifying or customizing the model's output, and instructing the model with complex directives. However, fine-tuning is not suitable for adding new knowledge to the model or for scenarios that require rapid iteration for new use cases. The specific comparison between RAG and Fine-tuning (FT) can be elucidated in Table 1.

RAG and fine-tuning are not mutually exclusive but can complement each other, enhancing the model's capabilities at different levels. In certain situations, combining these two techniques can achieve optimal model performance. The entire process of optimizing with RAG and fine-tuning may require multiple iterations to achieve satisfactory results.

Existing research has demonstrated significant advantages of Retrieval-Augmented Generation (RAG) compared to other methods for optimizing large language models [ Shuster et al., 2021, Yasunaga et al., 2022, Wang et al., 2023c, Borgeaud et al., 2022 ] :

• RAG improves accuracy by associating answers with external knowledge, reducing hallucination issues in language models and making generated responses more accurate and reliable.

• The use of retrieval techniques allows the identification of the latest information. Compared to traditional language models relying solely on training data, RAG maintains the timeliness and accuracy of responses.

• Transparency is an advantage of RAG. By citing sources, users can verify the accuracy of the answers, increasing trust in the model's output.

• RAG has customization capabilities. Models can be tailored to different domains by indexing relevant textual corpora, providing knowledge support for specific fields.

• In terms of security and privacy management, RAG, with its built-in roles and security controls in the database, can better control data usage. In contrast, finetuned models may lack clear management of who can access which data.

• RAG is more scalable. It can handle large-scale datasets without the need to update all parameters and create training sets, making it more economically efficient.

• Lastly, results produced by RAG are more trustworthy. RAG selects deterministic results from the latest data, while fine-tuned models may exhibit hallucinations and inaccuracies when dealing with dynamic data, lacking transparency and credibility.

2.2 RAG 与微调

在大语言模型的优化过程中，除了 RAG，微调也是一种重要的技术。

可以把 RAG 想象成给模型提供一本教科书，让它根据特定的问题去查找信息。这种方法适用于模型需要解答具体问题或执行特定信息检索任务的情况。但 RAG 并不适合于教会模型理解广泛的领域或学习新的语言、格式或风格。

而微调更像是让学生通过广泛学习来吸收知识。

当模型需要模仿特定的结构、风格或格式时，微调就显得非常有用。它可以提高未经微调的模型的表现，使交互更加高效。

微调特别适用于强化模型已有的知识、调整或定制模型的输出，以及给模型下达复杂的指令。然而，微调并不适合于向模型中添加新的知识，或者在需要快速迭代新场景的情况下使用。

微调 (Fine-tuning) 的过程就像是让学生通过深入持久的学习来吸收知识。这种方法适用于在模型需要精确模仿特殊的结构、艺术风格或者格式时。微调能够使模型的表现超越未经微调的模型，并提升交互效率。它尤其适合于突出模型基础知识库中已有的知识，调整或定制模型输出，并以复杂的指引来训练模型。然而，微调并不适合于向模型中增加全新的知识，或应对那些需要快速迭代新场景的情况。RAG (Retrieval-Augmented Generation) 和微调 (Fine-tuning) 的具体比较可以参见表 1。

RAG 和微调可以相互补充，而非相互排斥，从而在不同层次上增强模型的能力。在特定情况下，结合这两种方法可以达到模型性能的最佳状态。整个利用 RAG 和微调进行优化的过程可能需要多轮迭代才能获得满意的成果。

目前的研究已经表明，检索增强生成 (Retrieval-Augmented Generation, RAG) 在优化大语言模型 (Large Language Model) 方面，相较于其他方法具有显著的优势【Shuster et al., 2021; Yasunaga et al., 2022; Wang et al., 2023c; Borgeaud et al., 2022】：

RAG 通过关联外部知识来提高答案的准确性，有效减少了语言模型中出现的虚假信息，使得生成的回答更加准确可信。

使用检索技术能够识别到最新的信息，这使得 RAG 在保持回答的及时性和准确性方面，相较于只依赖训练数据的传统语言模型有明显优势。

RAG 的透明度是其一大优点。通过引用信息来源，用户可以核实答案的准确性，这增强了人们对模型输出结果的信任。

RAG 具备高度的定制化能力。通过索引与特定领域相关的文本语料库，RAG 能够为不同领域提供专业的知识支持。

在安全性和隐私管理方面，RAG 通过数据库中设置的角色和安全控制，实现了对数据使用的更好控制。相比之下，经过微调的模型在管理数据访问权限方面可能不够明确。

RAG 在处理大规模数据集方面更具有扩展性。它无需更新所有参数和创建新的训练集，因此在经济效率方面更具优势。

最后，RAG 提供的结果更加值得信赖。RAG 从最新数据中提取确定性的结果，而经过微调的模型在处理动态数据时可能会产生错误信息和不准确之处，缺乏透明度和可信度。

表 1: RAG 与微调之间的对比

| 技能 | RAG | 微调 (Fine-tuning) |
| --- | --- | --- |
| 知识更新 | 目前主更新方式和认识库，确保信息最持续更新，无需频繁重新训练，非常适合动态变化的数据环境。 | 存储概率数据，需要重新训练才可知识数据更新的更新。 |
| 外部知识和识 | 理长利用外部资源，特别适合外理文档或其他结构化/非结构化数据库。 | 可用于将预训练模型的潜学习到的知识与大型语言模型保持一致，但对于频率变化的数据源可能不太实用。 |
| 数据使用效果 | 对数据的处理和操作要求较低。 | 依赖于构建高质量的数据集，有限的数据集可能无法覆盖提问的全部。 |
| 模型定制 | 依重于信息检索和知合外部知识，但可能无法完全定制模型行为或写作风格。 | 允许根据特定风格或不语调整LLM行为，写作风格或特定领域知识。 |
| 可解释性 | 答案能够通过规则体的数据来显示，提供更高的可解释性和可追踪性。 | 尽管一个置信分，并不总是清楚模型为什么会做出某种反应，可能解释性较对较低。 |
| 计算资源 | 需要计算资源来支持检索答案和数据库生成大大。外部数据源的整合和更新需保持维护。 | 有必要准备和整理高质量的训练数据集，确定训练目标，并提供相应的计算资源。 |
| 连贯性要求 | 因为及数据相识，可能带来较高的延迟。 | 经过训练的大语言模型（LLM）可以不通过过格索引器回应，降低延迟。 |
| 隐私和安全 | 由于每个回答都基于检索到的实际证据，因此本质上更不容易产生误导性的内容。 | 根据特定领域的数据训练模型，有助于减少幻觉，但回对来源过分的相依时可能出现幻觉。 |
| 性能和响应时间 | 从外部数据库存储和检索答案本可以能引起性能问题有所面的挑战。 | 训练数据中的高效率可能会引起性能理和降低响应的问题。 |

### 03. RAG Framework

The research paradigm of RAG is constantly evolving. This chapter primarily introduces the evolution of the RAG research paradigm. We categorize it into three types: Naive RAG, Advanced RAG, and Modular RAG. Although the early RAG was cost-effective and performed better than the native LLM, it still faced many shortcomings. The emergence of Advanced RAG and Modular RAG were aimed at addressing specific deficiencies in the Naive RAG.

RAG 研究范式在不断演变。本章重点介绍 RAG 研究范式的发展历程。我们将其分为三种类型：初级 RAG、高级 RAG 和模块化 RAG。虽然早期的 RAG 在成本效益上表现良好，并且性能优于传统的大语言模型 (LLM)，但它仍面临着诸多挑战。高级 RAG 和模块化 RAG 的设计是为了解决原始 RAG (Naive RAG) 的特定不足。

#### 3.1 Naive RAG

The Naive RAG research paradigm represents the earliest methodology gained prominence shortly after the widespread adoption of ChatGPT. The naive RAG involves traditional process: indexing, retrieval, and generation. Naive RAG is also summarized as a "Retrieve"-"Read" framework [ Ma et al., 2023a ] .

原始 RAG (Naive RAG) 代表了早期研究方法，在 ChatGPT 广泛应用后迅速崭露头角。原始 RAG 的流程包括传统的索引、检索和生成步骤。原始 RAG 也被概括为一个「检索」-「阅读」框架 [Ma et al., 2023a]。

##### 01. Indexing

The pipeline for obtaining data from the source and building an index for it generally occurs in an offline state. Specifically, the construction of a data index involves the following steps:

1.Data Indexing:This involves cleaning and extracting the original data, converting different file formats such as PDF, HTML, Word, Markdown, etc., into plain text.

2.Chunking: This involves dividing the loaded text into smaller chunks. This is necessary because language models typically have a limit on the amount of context they can handle, so it is necessary to create as small text chunks as possible.

3.Embedding and Creating Index: This is the process of encoding text into vectors through a language model. The resulting vectors will be used in the subsequent retrieval process to calculate the similarity between the vector and the problem vector.The embedding models require a high inference speed. Since it is necessary to encode a large amount of corpus and encode the problem in real time when the user asks a question, the parameter size of the model should not be too large.After generating the embedding, the next step is to create an index, storing the original corpus chunks and embedding in the form of key-value pairs for quick and frequent searches in the future.

索引

指的是在离线状态下，从数据来源处获取数据并建立索引的过程。具体而言，构建数据索引包括以下步骤：

数据索引：包括清理和提取原始数据，将 PDF、HTML、Word、Markdown 等不同格式的文件转换成纯文本。

分块：将加载的文本分割成更小的片段。由于语言模型处理上下文的能力有限，因此需要将文本划分为尽可能小的块。

嵌入和创建索引：这一阶段涉及通过语言模型将文本编码为向量的过程。所产生的向量将在后续的检索过程中用来计算其与问题向量之间的相似度。由于需要对大量文本进行编码，并在用户提问时实时编码问题，因此嵌入模型要求具有高速的推理能力，同时模型的参数规模不宜过大。完成嵌入之后，下一步是创建索引，将原始语料块和嵌入以键值对形式存储，以便于未来进行快速且频繁的搜索。

##### 02. Retrieve

Given a user's input, the same encoding model as in the first stage is used to convert the query into a vector. The similarity between the question embedding and the embedding of the document blocks in the corpus is calculated. The top K document blocks are chosen as the augmented context information for the current question based on the level of similarity.

检索：

根据用户的输入，采用与第一阶段相同的编码模型将查询内容转换为向量。系统会计算问题向量与语料库中文档块向量之间的相似性，并根据相似度水平选出最相关的前 K 个文档块作为当前问题的补充背景信息。

##### 03. Generation

The given question and related documents are combined into a new prompt. The large language model is then tasked with answering the question based on the provided information. It may be decided whether to allow the large model to use its knowledge or only to answer based on the given information, depending on the needs of different tasks. If there is historical dialogue information, it can also be merged into the prompt for multi-round dialogues.

生成：

将给定的问题与相关文档合并为一个新的提示信息。随后，大语言模型（LLM）被赋予根据提供的信息来回答问题的任务。根据不同任务的需求，可以选择让模型依赖自身的知识库或仅基于给定信息来回答问题。如果存在历史对话信息，也可以将其融入提示信息中，以支持多轮对话。

Drawbacks in Naive RAG

The Naive RAG confronts principal challenges in three areas: retrieval quality, response generation quality, and the augmentation process.

Regarding retrieval quality, the issues are multifaceted. The primary concern is low precision, where not all blocks within the retrieval set correlate with the query, leading to potential hallucination and mid-air drop issues. A secondary issue is low recall, which arises when not all relevant blocks are retrieved, thereby preventing the LLM from obtaining sufficient context to synthesize an answer. Additionally, outdated information presents another challenge, where data redundancy or out-of-date data can result in inaccurate retrieval outcomes.

In terms of response generation quality, the issues are equally diverse. Hallucination is a prominent issue where the model fabricates an answer that doesn't exist in the context. Irrelevance is another concern where the model generates an answer that fails to address the query. Further, toxicity or bias, where the model generates a harmful or offensive response, is another problem.

Finally, the augmentation process also faces several challenges. Crucially, the effective integration of the context from retrieved passages with the current generation task is of utmost importance. If mishandled, the output might appear incoherent or disjointed. Redundancy and repetition are another issue, particularly when multiple retrieved passages contain similar information, leading to content repetition in the generation step. Moreover, determining the importance or relevance of multiple retrieved passages to the generation task is challenging, and the augmentation process needs to balance the value of each passage appropriately. The retrieved content may also come from different writing styles or tones, and the augmentation process needs to reconcile these differences to ensure output consistency. Lastly, generation models may overly rely on augmented information, resulting in output that merely repeats the retrieved content, without providing new value or synthesized information.

朴素 RAG 的挑战：

朴素 RAG 主要在三个方面面临挑战：检索质量、回应生成质量和增强过程。

检索质量：该方面的问题多方面。最主要的问题是低精度，即检索集中的文档块并不都与查询内容相关，这可能导致信息错误或不连贯。其次是低召回率问题，即未能检索到所有相关的文档块，使得大语言模型无法获取足够的背景信息来合成答案。此外，过时信息也是一个挑战，因为数据冗余或过时可能导致检索结果不准确。

回应生成质量：这方面的问题同样多样。最突出的问题是制造错误信息，即模型在缺乏足够上下文的情况下虚构答案。另一个问题是回答不相关，即模型生成的答案未能针对查询问题。进一步来说，生成有害或偏见性回应也是一个问题。

增强过程：最终，增强过程面临几个重要挑战。特别重要的是，如何将检索到的文段的上下文有效融入当前的生成任务。如果处理不得当，生成的内容可能显得杂乱无章。当多个检索到的文段包含相似信息时，冗余和重复成为问题，这可能导致生成内容的重复。此外，如何判断多个检索到的文段对生成任务的重要性或相关性非常有挑战性，增强过程需要恰当地评估每个文段的价值。检索到的内容可能具有不同的写作风格或语调，增强过程需调和这些差异，以确保最终输出的一致性。最后，生成模型可能会过度依赖于增强信息，导致生成的内容仅是重复检索到的信息，而缺乏新的价值或综合信息。

#### 3.2 Advanced RAG

Advanced RAG has made targeted improvements to overcome the deficiencies of Naive RAG. In terms of the quality of retrieval generation, Advanced RAG has incorporated preretrieval and post-retrieval methods. To address the indexing issues encountered by Naive RAG, Advanced RAG has optimized indexing through methods such as sliding window, fine-grained segmentation, and metadata. Concurrently, it has put forward various methods to optimize the retrieval process. In terms of specific implementation, Advanced RAG can be adjusted either through a pipeline or in an end-to-end manner.

为了克服 Naive RAG 的局限性，高级 RAG 进行了针对性的改进。在检索生成质量方面，高级 RAG 引入了预检索和后检索的方法。它还通过滑动窗口、细粒度分割和元数据等手段优化了索引，以解决 Naive RAG 所遇到的索引问题。同时，高级 RAG 也提出了多种优化检索流程的方法。在具体实施上，高级 RAG 可以通过流水线方式或端到端的方式进行调整。

##### 01. Pre-Retrieval Process

• Optimizing Data Indexing The purpose of optimizing data indexing is to enhance the quality of indexed content. Currently, there are five main strategies employed for this purpose: increasing the granularity of indexed data, optimizing index structures, adding metadata, alignment optimization, and mixed retrieval.

1.Enhancing Data Granularity: The objective of pre-index optimization is to improve text standardization, consistency, and ensure factual accuracy and contextual richness to guarantee the performance of the RAG system. Text standardization involves removing irrelevant information and special characters to enhance the efficiency of the retriever. In terms of consistency, the primary task is to eliminate ambiguity in entities and terms, along with eliminating duplicate or redundant information to simplify the retriever's focus. Ensuring factual accuracy is crucial, and whenever possible, the accuracy of each piece of data should be verified. Context retention, to adapt to the system's interaction context in the real world, can be achieved by adding another layer of context with domain-specific annotations, coupled with continuous updates through user feedback loops. Time sensitivity is essential contextual information, and mechanisms should be designed to refresh outdated documents. In summary, the focus of optimizing indexed data should be on clarity, context, and correctness to make the system efficient and reliable. The following introduces best practices.

2.Optimizing Index Structures: This can be achieved by adjusting the size of the chunks, altering the index paths, and incorporating graph structure information. The method of adjusting chunks (Small to Big) involves collecting as much relevant context as possible and minimizing noise. When constructing a RAG system, the chunk size is a key parameter. There are different evaluation frameworks comparing the size of individual chunks. LlamaIndex 2 uses GPT4 to assess fidelity and relevance, and the LLaMA [ Touvron et al., 2023 ] index has an automatic evaluation feature for different chunking methods. The method of querying across multiple index paths is closely related to previous metadata filtering and chunking methods, and may involve querying across different indexes simultaneously. A standard index can be used to query specific queries, or a standalone index can be used to search or filter based on metadata keywords, such as a specific "date" index.

Introducing a graph structure involves transforming entities into nodes and their relationships into relations. This can improve accuracy by leveraging the relationships between nodes, especially for multi-hop questions. Using a graph data index can increase the relevance of the retrieval.

3.Adding Metadata Information: The focus here is to embed referenced metadata into chunks, such as dates and purposes used for filtering. Adding metadata like chapters and subsections of references could also be beneficial for improving retrieval. When we divide the index into numerous chunks, retrieval efficiency becomes a concern. Filtering through metadata first can enhance efficiency and relevance.

4.Alignment Optimization: This strategy primarily addresses alignment issues and differences between documents. The alignment concept involves introducing hypothetical questions, creating questions which are suitable to answer with each document, and embedding (or replacing) these questions with the documents. This helps address alignment problems and discrepancies between documents.

5.Mixed Retrieval: The advantage of this strategy lies in leveraging the strengths of different retrieval technologies. Intelligently combining various techniques, including keyword-based search, semantic search, and vector search, adapts to different query types and information needs, ensuring consistent retrieval of the most relevant and context-rich information. Mixed retrieval can serve as a robust complement to retrieval strategies, enhancing the overall performance of the RAG pipeline.

预检索处理

优化数据索引旨在提高索引内容的质量。目前主要采用五种策略：提升索引数据粒度、优化索引结构、增加元数据、对齐优化以及混合检索。

提升数据粒度：在索引前的优化是为了改进文本的标准化和一致性，确保事实准确和上下文丰富，从而保障 RAG 系统的表现。文本标准化意在剔除无关信息和特殊字符，提升检索效率。在确保一致性方面，主要是消除术语和实体的歧义，剔除重复或冗余信息，简化检索过程。事实的准确性至关重要，应尽可能验证每项数据。在保持上下文方面，通过添加特定领域的注释和用户反馈循环不断更新，使系统适应现实世界的交互上下文。考虑时间敏感性，应更新过时文档。总的来说，优化索引数据的重点在于清晰度、上下文和正确性，以提高系统的效率和可靠性。以下是一些最佳实践。

优化索引结构：通过调整数据块大小、改变索引路径和加入图结构信息可以实现这一目标。调整数据块大小的方法是尽可能多地收集相关上下文，同时尽量减少干扰。在构建 RAG 系统时，块大小是关键参数。不同的评估框架用于比较不同块的大小。LlamaIndex 利用 GPT4 评估数据的保真度和相关性，LLaMA [Touvron et al., 2023] 索引能自动评估不同块化方法的效果。跨多个索引路径查询与之前的元数据过滤和块化方法紧密相关，可能涉及同时在不同索引中进行查询。标准索引可用于特定查询，或使用独立索引基于元数据关键词（如「日期」索引）进行搜索或过滤。引入图结构是将实体转化为节点，将它们之间的关系转化为关联，这可以通过利用节点间的关系来提高对多跳问题的准确性。使用图数据索引能提高检索的相关性。

添加元数据信息：这一策略的核心是将引用的元数据，如日期和用途（用于筛选）等，嵌入到数据块中。添加如章节和引用小节等元数据，对于提升检索效率是有益的。当索引被分割成多个块时，如何高效检索便成为关键。通过元数据进行初步筛选可以提高检索的效率和准确性。

对齐优化：该策略主要针对不同文档之间的对齐问题和差异。对齐的核心思想是引入「假设性问题」，即创建适合用每篇文档回答的问题，并将这些问题与文档结合起来。这种做法有助于解决文档间的对齐问题和不一致性。

混合检索：混合检索的优势在于它结合了不同检索技术的长处。它智能地融合了关键词搜索、语义搜索和向量搜索等多种技术，适应不同类型的查询需求，确保能够一致地检索到最相关和内容丰富的信息。混合检索作为检索策略的重要补充，能够显著提升 RAG 流程的整体性能。

Embedding

• Fine-turning Embedding: Fine-tuning embedding models directly impacts the effectiveness of RAG. The purpose of fine-tuning is to enhance the relevance between retrieved content and query. The role of finetuning embedding is akin to adjusting ears before generating speech, optimizing the influence of retrieval content on the generated output. Generally, methods for fine-tuning embedding fall into the categories of adjusting embedding in domain-specific contexts and optimizing retrieval steps. Especially in professional domains dealing with evolving or rare terms, these customized embedding methods can improve retrieval relevance. The BGE [ BAAI, 2023 ] embedding model is a fine-tunning and high-performance embedding model, such as BGE-large-EN developed by the BAAI 3 . To create training data for fine-tuning the BGE model, start by using LLMs like gpt-3.5-turbo to formulate questions based on document chunks, where questions and answers (document chunks) form fine-tuning pairs for the fine-tuning process.

• Dynamic Embedding: Dynamic embedding adjust based on the context in which words appear, differing from static embedding that use a single vector for each word. For instance, in transformer models like BERT, the same word can have varied embeddings depending on surrounding words. Evidence indicates unexpected high cosine similarity results, especially with text lengths less than 5 tokens, in OpenAI's text-embeddingada-002 model 4 . Ideally, embedding should encompass as much context as possible to ensure "healthy" outcomes.Built upon the principles of large language models like GPT, OpenAI's embeddings-ada-02 is more sophisticated than static embedding models, capturing a certain level of context. While it excels in contextual understanding, it may not exhibit the same sensitivity to context as the latest full-size language models like GPT4.

嵌入 (Embedding)

微调嵌入：微调嵌入模型的调整直接影响到 RAG 的有效性。微调的目的是让检索到的内容与查询之间的相关性更加紧密。微调嵌入的作用可以比作在语音生成前对「听觉」进行调整，优化检索内容对最终输出的影响。通常，微调嵌入的方法可以分为针对特定领域上下文的嵌入调整和检索步骤的优化。特别是在处理不断变化或罕见术语的专业领域，这些定制化的嵌入方法能够显著提高检索的相关性。BGE [BAAI, 2023] 嵌入模型是一个经过微调的高性能嵌入模型，例如由 BAAI 3 开发的 BGE-large-EN。为了对 BGE 模型进行微调，首先使用诸如 gpt-3.5-turbo 这样的大语言模型（LLM）根据文档块制定问题，其中问题和答案（文档块）构成了微调过程中的训练对。

动态嵌入（Dynamic Embedding）：不同于静态嵌入（static embedding），动态嵌入根据单词出现的上下文进行调整，为每个单词提供不同的向量表示。例如，在 Transformer 模型（如 BERT）中，同一单词根据周围词汇的不同，其嵌入也会有所变化。研究发现，在 OpenAI 的 text-embeddingada-002 模型中，文本长度小于 5 个 Token 时，常出现意外高的余弦相似度。理想的嵌入应该包含足够的上下文，以保证良好的结果。OpenAI 的 embeddings-ada-02 是基于大语言模型（如 GPT）原理开发的，比传统静态嵌入模型更复杂，能够捕捉一定程度的上下文。尽管它在上下文理解方面表现出色，但可能不如最新的大型语言模型（如 GPT-4）那样对上下文敏感。

##### 02. Post-Retrieval Process

After retrieving valuable context from the database, merging it with the query for input into LLM poses challenges. Presenting all relevant documents to the LLM at once may exceed the context window limit. Concatenating numerous documents to form a lengthy retrieval prompt is ineffective, introducing noise and hindering the LLM's focus on crucial information. Additional processing of the retrieved content is necessary to address these issues.

• ReRank: Re-ranking to relocate the most relevant information to the edges of the prompt is a straightforward idea. This concept has been implemented in frameworks such as LlamaIndex, LangChain, and HayStack [ Blagojevi, 2023 ] . For instance, Diversity Ranker prioritizes reordering based on document diversity, while LostInTheMiddleRanker alternates placing the best document at the beginning and end of the context window. Simultaneously, addressing the challenge of interpreting vector-based simulated searches for semantic similarity, approaches like cohereAI rerank [ Cohere, 2023 ] , bgererank 5 , or LongLLMLingua [ Jiang et al., 2023a ] recalculate the semantic similarity between relevant text and query.

• Prompt Compression Research indicates that noise in retrieved documents adversely affects RAG performance. In post-processing, the emphasis lies in compressing irrelevant context, highlighting pivotal paragraphs, and reducing the overall context length. Approaches such as Selective Context [ Litman et al., 2020 ] and LLMLingua [ Anderson et al., 2022 ] utilize small language models to calculate prompt mutual information or perplexity, estimating element importance. However, these methods may lose key information in RAG or long-context scenarios. Recomp [ Xu et al., 2023a ] addresses this by training compressors at different granularities. Long Context [ Xu et al., 2023b ] , in dealing with extensive contexts, decomposes and compresses, while "Walking in the Memory Maze" [ Chen et al., 2023a ] designs a hierarchical summarization tree to enhance LLM's key information perception.

检索后处理流程

在从数据库中检索出有价值的上下文后，将其与查询内容合并输入到大语言模型（LLM）会遇到挑战。一次性向大语言模型展示所有相关文档可能会超出其处理的上下文窗口限制。将多个文档拼接成一个冗长的检索提示不仅效率低，还会引入噪声，影响大语言模型聚焦关键信息。因此，需要对检索到的内容进行额外处理，以解决这些问题。

1、ReRank（重新排序）：重新排序，将最相关的信息置于提示的前后边缘，是一个简单直接的方法。这一思路已在如 LlamaIndex、LangChain 和 HayStack 等框架中得到应用 [Blagojevi, 2023]。例如，Diversity Ranker 会根据文档的多样性进行重新排序，而 LostInTheMiddleRanker 则会交替地将最佳文档放在上下文窗口的开始和结束位置。同时，为了应对基于向量的语义相似度模拟搜索的挑战，方法如 cohereAI rerank [Cohere, 2023]、bgererank5 或 LongLLMLingua [Jiang et al., 2023a]，会重新计算相关文本与查询之间的语义相似度。

2、Prompt 压缩：研究显示，检索文档中的噪音会对 RAG 性能产生不利影响。在处理的后期阶段，我们主要关注于压缩无关紧要的上下文，凸显关键段落，并缩短整体的上下文长度。例如 Selective Context [Litman et al., 2020] 和 LLMLingua [Anderson et al., 2022] 等方法，它们运用小型语言模型来计算提示之间的互信息或困惑度，以此估算各个元素的重要性。

不过，在 RAG 或者长篇上下文的情境中，这些方法可能会遗失关键信息。Recomp [Xu et al., 2023a] 通过训练不同精细程度的压缩器来应对这一问题。

在处理长篇上下文 [Xu et al., 2023b] 时，这种方法通过分解和压缩来处理大量的上下文内容，而「在记忆迷宫中漫步」[Chen et al., 2023a] 则设计了一个分层次的总结树来增强大语言模型（LLM）对关键信息的感知能力。

##### 03. RAG Pipeline Optimization

The optimization of the retrieval process aims to enhance the efficiency and information quality of RAG systems, Current research primarily focuses on intelligently combining various search technologies, optimizing retrieval steps, introducing the concept of cognitive backtracking, flexibly applying diverse query strategies, and leveraging embedding similarity. These efforts collectively strive to achieve a balance between efficiency and the richness of contextual information in RAG retrieval.

• Exploring Hybrid Search: By intelligently blending various techniques such as keyword-based search, semantic search, and vector search, the RAG system can leverage the strengths of each method. This approach enables the RAG system to adapt to different query types and information needs, ensuring consistent retrieval of the most relevant and context-rich information. Hybrid search serves as a robust complement to retrieval strategies, enhancing the overall performance of the RAG pipeline.

• Recursive Retrieval and Query Engine:Another powerful method to optimize retrieval in the RAG system involves implementing recursive retrieval and a sophisticated query engine. Recursive retrieval entails acquiring smaller document blocks during the initial retrieval phase to capture key semantic meanings. In the later stages of this process, larger blocks with more contextual information are provided to the language model (LM). This two-step retrieval method helps strike a balance between efficiency and contextually rich responses.

• StepBack-prompt: Integrated into the RAG process, the StepBack-prompt approach [ Zheng et al., 2023 ] encourages LLM to step back from specific instances and engage in reasoning about the underlying general concepts or principles. Experimental findings indicate a significant performance improvement in various challenging, inference-intensive tasks with the incorporation of backward prompts, showcasing its natural adaptability to RAG. The retrieval-enhancing steps can be applied in both the generation of answers to backward prompts and the final question-answering process.

• Subqueries:Various query strategies can be employed in different scenarios, including using query engines provided by frameworks like LlamaIndex, employing tree queries, utilizing vector queries, or employing the most basic sequential querying of chunks.

• HyDE: This approach is grounded on the assumption that the generated answers may be closer in the embedding space than a direct query. Utilizing LLM, HyDE generates a hypothetical document (answer) in response to a query, embeds the document, and employs this embedding to retrieve real documents similar to the hypothetical one. In contrast to seeking embedding similarity based on the query, this method emphasizes the embedding similarity from answer to answer. However, it may not consistently yield favorable results, particularly in instances where the language model is unfamiliar with the discussed topic, potentially leading to an increased generation of error-prone instances.

RAG 管道优化

检索过程的优化旨在提升 RAG 系统的效率和信息质量。当前的研究主要集中在智能结合不同的搜索技术，优化检索步骤，引入认知回溯概念，灵活运用多样化的查询策略，并利用嵌入式相似度。这些努力共同追求在 RAG 检索中达到效率与上下文信息丰富度的平衡。

1、混合搜索的探索：RAG 系统巧妙结合了基于关键词、语义以及向量的多种搜索技术。这种综合方法让 RAG 系统能够应对不同的查询类型和信息需求，有效地获取最相关且内容丰富的信息。混合搜索作为一种强大的补充手段，显著提升了 RAG 流程的整体表现。

2、递归检索与查询引擎：在 RAG 系统中，采用递归检索和高级查询引擎是提高检索效果的另一有效手段。递归检索的首要步骤是在初始阶段获取小型文档块，以便抓住关键语义。随后，该过程会提供更大的文档块，为大语言模型 (LM) 提供更丰富的上下文信息。这种双重检索策略既保证了效率，又能提供深入的上下文回应。

3、StepBack-prompt 方法：集成到 RAG 流程中的 StepBack-prompt 方法 [Zheng et al., 2023] 促使大语言模型 (LLM) 在处理具体案例时能够退一步，转而思考背后的普遍概念或原则。研究发现，这种结合后向提示的方法在处理各种复杂、推理密集的任务时表现卓越，充分展现了其与 RAG 的良好兼容性。这种方法既能用于后向提示的答案生成，也能用于最终的问答环节。

4、子查询：根据不同场景，我们可以采取多种查询策略，如使用 LlamaIndex 等框架提供的查询引擎、树状查询、向量查询或基本的块序列查询。

5、HyDE 方法：这种方法基于一个假设：相较于直接查询，通过大语言模型 (LLM) 生成的答案在嵌入空间中可能更为接近。HyDE 首先响应查询生成一个假设性文档（答案），然后将其嵌入，并利用此嵌入去检索与假设文档类似的真实文档。这种方法强调答案之间的嵌入相似性，而非单纯依赖于查询的嵌入相似性。但在某些情况下，特别是当语言模型对话题不够熟悉时，它可能导致错误实例的增加。

##### 04. Modular RAG

The modular RAG structure breaks away from the traditional Naive RAG framework of indexing, retrieval, and generation, offering greater diversity and flexibility in the overall process. On one hand, it integrates various methods to expand functional modules, such as incorporating a search module in similarity retrieval and applying a fine-tuning approach in the retriever [ Lin et al., 2023 ] . Additionally, specific problems have led to the emergence of restructured RAG modules [ Yu et al., 2022 ] and iterative approaches like [ Shao et al., 2023 ] . The modular RAG paradigm is becoming the mainstream in the RAG domain, allowing for either a serialized pipeline or an end-to-end training approach across multiple modules.The comparison between three RAG paradigms is illustrated in Fig 3.

模块化 RAG

模块化 RAG 结构打破了传统的「原始 RAG」框架，这个框架原本涉及索引、检索和生成，现在提供了更广泛的多样性和更高的灵活性。它不仅集成了各种方法来丰富功能模块，比如在相似性检索中加入了搜索模块，并且在检索器中采用了微调 (fine-tuning) 策略 [Lin et al., 2023]。特别的问题也催生了重构后的 RAG 模块 [Yu et al., 2022]，以及类似 [Shao et al., 2023] 的迭代方法。这种模块化的 RAG 范式正逐渐成为 RAG 领域的趋势，它支持从序列化流程到跨多个模块的端到端训练方法。三种 RAG 范式的对比在图 3 中进行了详细展示。

图 3：三种 RAG 范式的比较

New Modules

• Search Module: Diverging from the similarity retrieval between queries and corpora in Naive/Advanced RAG, the search module, tailored to specific scenarios, incorporates direct searches on (additional) corpora in the process using LLM-generated code, query languages (e.g., SQL, Cypher), or other custom tools. The data sources for searching can include search engines, text data, tabular data, or knowledge graphs [ Wang et al., 2023c ] .

• Memory Module: Leveraging the memory capabilities of LLM itself to guide retrieval, the principle involves finding memories most similar to the current input. Self-mem [ Cheng et al., 2023b ] iteratively employs a retrieval-enhanced generator to create an unbounded memory pool, combining the "original question" and "dual question." A retrieval-enhanced generative model can use its own outputs to enhance itself, making the text closer to the data distribution in the reasoning process, with the model's own outputs rather than training data [ Wang et al., 2022a ] .

• Extra Generation Module: In retrieved content, redundancy and noise are common issues. Instead of directly retrieving from a data source, the Extra Generation Module leverages LLM to generate the required context [ Yu et al., 2022 ] . Content generated by LLM is more likely to contain relevant information compared to direct retrieval.

• Task Adaptable Module: Focused on transforming RAG to adapt to various downstream tasks, UPRISE [ Cheng et al., 2023a ] automatically retrieves prompts for given zero-shot task inputs from a pre-constructed data pool, enhancing universality across tasks and models. PROMPTAGATOR [ Dai et al., 2022 ] utilizes LLM as a few-shot query generator and, based on the generated data, creates task-specific retrievers. Leveraging the generalization capability of LLM, PROMPTAGATOR enables the creation of task-specific end-to-end retrievers with just a few examples.

• Alignment Module: The alignment between queries and texts has consistently been a critical issue influencing the effectiveness of RAG. In the era of Modular RAG, researchers have discovered that adding a trainable Adapter module to the retriever can effectively mitigate alignment issues. PRCA [ Yang et al., 2023b ] leveraged reinforcement learning to train a context adapter driven by LLM rewards, positioned between the retriever and generator. It optimizes the retrieved information by maximizing rewards in the reinforcement learning phase within the labeled autoregressive policy. AAR [ Yu et al., 2023b ] proposed a universal plugin that learns LM preferences from known-source LLMs to assist unknown or non-co-finetuned LLMs. RRR [ Ma et al., 2023a ] designed a module for rewriting queries based on reinforcement learning to align queries with documents in the corpus.

• Validation Module: In real-world scenarios, it is not always guaranteed that the retrieved information is reliable. Retrieving irrelevant data may lead to the occurrence of illusions in LLM. Therefore, an additional validation module can be introduced after retrieving documents to assess the relevance between the retrieved documents and the query. This enhances the robustness of RAG [ Yu et al., 2023a ] .

新模块

1、搜索模块：与简单/高级 RAG 的查询和语料间的常规相似性检索不同，这个特定场景下的搜索模块融合了直接在（附加的）语料库中进行搜索的方法。这些方法包括利用大语言模型（LLM）生成的代码、SQL、Cypher 等查询语言，或是其他定制工具。其搜索数据源多样，涵盖搜索引擎、文本数据、表格数据或知识图等 [Wang et al., 2023c]。

2、记忆模块：本模块充分利用大语言模型本身的记忆功能来引导信息检索。其核心原则是寻找与当前输入最为匹配的记忆。例如，Self-mem [Cheng et al., 2023b] 通过迭代使用增强检索的生成模型，创建了一个结合了「原始问题」和「双重问题」的无限记忆池。这种增强检索的生成模型能够利用其自身的输出来自我提升，在推理过程中使文本更加贴近数据分布，而非仅依赖训练数据 [Wang et al., 2022a]。

3、额外生成模块：面对检索内容中的冗余和噪声问题，这个模块通过大语言模型生成必要的上下文，而非直接从数据源进行检索 [Yu et al., 2022]。通过这种方式，由大语言模型生成的内容更可能包含与检索任务相关的信息。

4、任务适应模块：该模块致力于将 RAG 调整以适应各种下游任务。例如，UPRISE [Cheng et al., 2023a] 能够自动从预先构建的数据池中为给定的零样本任务输入检索出适当的提示，从而提升任务和模型间的通用性。PROMPTAGATOR [Dai et al., 2022] 则利用大语言模型作为少样本查询生成器，基于生成的数据创建针对特定任务的检索器。利用大语言模型的泛化能力，PROMPTAGATOR 使得仅凭几个示例就可以创建专门针对特定任务的端到端检索器。

5、对齐模块：在 RAG 的应用中，查询与文本之间的对齐一直是影响效果的关键因素。在模块化 RAG 的发展中，研究者们发现，在检索器中添加一个可训练的 Adapter 模块能有效解决对齐问题。例如，PRCA [Yang et al., 2023b] 通过强化学习训练了一个由大语言模型奖励驱动的上下文适配器，该适配器位于检索器和生成器之间。通过在标注的自回归策略中的强化学习阶段，它能够优化检索到的信息，实现在强化学习过程中最大化奖励。

AAR [Yu et al., 2023b] 提出了一种通用插件，这种插件能从已知来源的大语言模型 (LLM) 学习到语言模型的偏好，并用这些知识来辅助那些未知或尚未共同微调的大语言模型。

RRR [Ma et al., 2023a] 设计了一个基于强化学习的模块，该模块能够重写查询，使得这些查询更好地与语料库中的文档相匹配。

6、验证模块：在现实世界中，我们无法总是保证检索到的信息的可靠性。检索到不相关的数据可能会导致大语言模型产生错误信息。因此，可以在检索文档后加入一个额外的验证模块，以评估检索到的文档与查询之间的相关性，这样做可以提升 RAG [Yu et al., 2023a] 的鲁棒性。

##### 05. New Pattern

The organizational approach of Modular RAG is flexible, allowing for the substitution or reconfiguration of modules within the RAG process based on specific problem contexts. For Naive RAG, which consists of the two modules of retrieval and generation ( referred as read or sythesis in some literature), this framework offers adaptability and abundance. Present research primarily explores two organizational paradigms, involving the addition or replacement of modules, as well as the adjustment of the organizational flow between modules.

• Adding or Replacing Modules The strategy of adding or replacing modules entails maintaining the structure of Retrieval-Read while introducing additional modules to enhance specific functionalities. RRR [ Ma et al., 2023a ] proposes the RewriteRetrieve-Read process, utilizing LLM performance as a reward in reinforcement learning for a rewritter module. This allows the rewritter to adjust retrieval queries, improving the downstream task performance of the reader. Similarly, modules can be selectively replaced in approaches like Generate-Read [ Yu et al., 2022 ] , where the LLM generation module replaces the retrieval module.

Recite-Read [ Sun et al., 2022 ] transforms external retrieval into retrieval from model weights, initially having LLM memorize task-relevant information and generate output for handling knowledge-intensive natural language processing tasks.

• Adjusting the Flow between Modules In the realm of adjusting the flow between modules, there is an emphasis on enhancing interaction between language models and retrieval models. DSP [ Khattab et al., 2022 ] introduces the Demonstrate-Search-predict framework, treating the context learning system as an explicit program rather than a terminal task prompt to address knowledgeintensive tasks. ITER-RETGEN [ Shao et al., 2023 ] utilizes generated content to guide retrieval, iteratively performing "retrieval-enhanced generation" and "generation-enhanced retrieval" in a Retrieve-ReadRetrieve-Read flow. Self-RAG [ Asai et al., 2023b ] follows the decide-retrieve-reflect-read process, introducing a module for active judgment. This adaptive and diverse approach allows for the dynamic organization of modules within the Modular RAG framework.

新模式 Modular

RAG 的组织方法具有高度灵活性，能够根据特定问题的上下文，对 RAG 流程中的模块进行替换或重新配置。在基础的 Naive RAG 中，包含了检索和生成这两个核心模块（有些文献中称之为阅读或合成模块），这个框架因而具备了高度的适应性和多样性。目前的研究主要围绕两种组织模式：一是增加或替换模块，二是调整模块间的工作流程。

增加或替换模块

在增加或替换模块的策略中，我们保留了原有的检索-阅读结构，同时加入新模块以增强特定功能。RRR [Ma et al., 2023a] 提出了一种重写-检索-阅读的流程，其中利用大语言模型（LLM）的性能作为强化学习中重写模块的奖励机制。这样，重写模块可以调整检索查询，从而提高阅读器在后续任务中的表现。同样地，我们也可以在其他方法中选择性地替换模块，例如在生成-阅读 [Yu et al., 2022] 中，大语言模型的生成模块取代了检索模块。背诵-阅读 [Sun et al., 2022] 则是将传统的外部检索转变为从模型权重中检索，首先由大语言模型记忆与任务相关的信息，然后生成处理知识密集型自然语言处理任务所需的输出。

调整模块间的工作流程

在调整模块间流程的领域，重点在于加强语言模型与检索模型之间的互动。DSP [Khattab et al., 2022] 引入了展示-搜索-预测的框架，将上下文学习系统视为一个明确的程序，而不是简单的终端任务提示，以此来应对知识密集型的任务。ITER-RETGEN [Shao et al., 2023] 则是使用生成内容来指导检索，通过迭代执行「检索增强生成」和「生成增强检索」，形成一种检索-阅读-检索-阅读的工作流。Self-RAG [Asai et al., 2023b] 则采用决策-检索-反思-阅读的流程，引入了一个用于主动判断的模块。这种适应性和多样性的方法使得在 Modular RAG 框架中可以动态地组织各种模块。

### 04. Retriever

In the context of RAG, the "R" stands for retrieval, serving the role in the RAG pipeline of retrieving the top-k relevant documents from a vast knowledge base. However, crafting a high-quality retriever is a non-trivial task. In this chapter, we organize our discussions around three key questions: 1) How to acquire accurate semantic representations? 2) How to match the semantic spaces of queries and documents? 3) How to align the output of the retriever with the preferences of the Large Language Model ?

04 检索器

在 RAG（检索增强生成）技术中，「R」代表检索，其作用是从大量知识库中检索出最相关的前 k 个文档。然而，构建一个高质量的检索器是一项挑战。在本章，我们将探讨三个关键问题：1）如何获得准确的语义表示？2）如何匹配查询和文档的语义空间？3）如何让检索器的输出与大语言模型（LLM）的偏好相协调？

#### 4.1 How to acquire accurate semantic representations?

In RAG, semantic space is the multidimensional space where query and Document are mapped. When we perform retrieval, it is measured within the semantic space. If the semantic expression is not accurate, then its effect on RAG is fatal, this section will introduce two methods to help us build a accurate semantic space.

Chunk optimization When processing external documents, the first step is chunking to obtain fine-grained features. Then the chunks are Embedded. However, Embedding too large or too small text chunks may not achieve good results. Therefore, finding the optimal chunk size for the documents in the corpus is crucial to ensure the accuracy and relevance of the search results.

When choosing a chunking strategy, important considerations include: the characteristics of the content being indexed, the embedding model used and its optimal block size, the expected length and complexity of user queries, and how the retrieval results are used in a specific application. For example, different chunking models should be selected for longer or shorter content. Additionally, different embedding models perform differently at different block sizes; for example, sentence-transformer is more suitable for single sentences, while text-embedding-ada-002 is better for blocks containing 256 or 512 tokens. Furthermore, the length and complexity of the user's input question text, as well as the specific needs of your application such as semantic search or Q&A, will all affect the choice of chunking strategy. This might directly correlate with the token limits of your chosen LLM, and may require you to adjust the block size. In fact, accurate query results are achieved by adaptively applying several chunking strategies; there is no best, only most suitable.

Current research in RAG employs diverse block optimization methods to improve retrieval efficiency and accuracy. Techniques such as sliding window technology implement layered retrieval by aggregating globally related information through multiple retrievals. The Small2big technique utilizes small text blocks during the search process and provides larger affiliated text blocks to the language model for processing. The Abstract embedding technique performs Top K retrieval on document abstracts, offering full document context. The Metadata Filtering technique leverages document metadata for filtering. The Graph Indexing technique converts entities and relationships into nodes and connections, significantly enhancing relevance in the context of multi-hop issues. The amalgamation of these methods has resulted in improved retrieval outcomes and enhanced performance for RAG.

Fine-tuning Embedding Models After getting the proper size of Chunks, we need to Embedding the chunks and query in the semantic space by an Embedding model, so it is crucial whether Embedding can represent the corpus effectively. Nowadays, excellent Embedding models have appeared, such as [UAE [ AngIE, 2023 ] , Voyage [ VoyageAI, 2023 ] , BGE [ BAAI, 2023 ] , etc.], they have been pre-trained on large-scale corpus, but they may not accurately represent domain-specific corpus information when applied to specific domains. Furthermore, task-specific fine-tuning of Embedding models is critical to ensure that the model understands the user query in relation to the content relevance, whereas an un-fine-tuned model may not be able to fulfill the needs of a specific task. Thus, fine-tuning an Embedding model is essential for downstream applications. There are two basic paradigms in Embedding finetuning methods

Domain Knowledge Fine-tuning In order for an Embedding model to correctly understand domain-specific information, we need to construct domain-specific datasets to finetune the Embedding model. However fine-tuning an Embedding model is different from an ordinary language model, mainly in that the datasets used are different. In the current main method of fine-tuning Embedding models, the dataset used consists of three parts, including Queries, Corpus and Relevant Docs. The Embedding model looks up relevant documents in Corpus based on the Query, and then whether the Relevant Docs of the query hit or not is used as a metric for the model.

In the construction of datasets, fine-tuning models, and evaluation, numerous challenges may arise in each of these three components. In the LlamaIndex [ Liu, 2023 ] , a series of key classes and functions have been introduced specifically for the fine-tuning process of embedding models, significantly streamlining this procedure. By preparing a corpus of domain knowledge and utilizing the methods it provides, we can easily obtain the specialized embedding model tailored to our desired domain.

Fine-tuning of downstream tasks It is equally important to adapt Embedding models to downstream tasks. When using RAG in downstream tasks, some works have fine-tuned Embedding models by using the capabilities of LLMs.PROMPTAGATOR [ Dai et al., 2022 ] utilizes the Large Language Model (LLM) as a few-shot query generator and creates task-specific retrievers based on the generated data, and alleviates the problem of supervised finetuning, which is difficult in some domains due to data scarcity.LLM-Embedder [ Zhang et al., 2023a ] uses the Large Language Model to output reward values for data from multiple downstream tasks, fine-tuning the retriever with two different supervised signals via hard labeling of the dataset and the soft reward derived from LLM.

This somewhat improves the semantic representation through both domain knowledge injection and downstream task fine-tuning. However, the retrievers trained by this approach are not intuitively helpful for large language models, so some work has been done to supervise the fine-tuning of Embedding models directly through feedback signals from the LLM. (This section will be presented in 4.4)

4.1 如何获得准确的语义表示？

在 RAG 中，语义空间指的是查询和文档被映射的多维空间。

进行检索时，我们是在这个语义空间内进行评估的。如果语义表达不准确，对 RAG 的影响将是灾难性的。本节将介绍两种构建准确语义空间的方法。

块优化

处理外部文档的第一步是分块，以获得更细致的特征。接着，这些文档块被嵌入（Embedded）。

嵌入太大或太小的文本块可能无法取得最佳效果。因此，找到适合语料库文档的最佳块大小至关重要，以确保搜索结果的准确性和相关性。

选择分块策略时，需要考虑的要素包括：被索引内容的特点、使用的嵌入模型及其最适块大小、用户查询的预期长度和复杂度、以及检索结果在特定应用中的使用方式。例如，对于不同长度的内容，应选用不同的分块模型。不同的嵌入模型，如 Sentence-Transformer 和 text-embedding-ada-002，在处理不同大小的文本块时效果各异；例如，Sentence-Transformer 更适合单句处理，而 text-embedding-ada-002 更适合处理包含 256 或 512 Token 的文本块。用户问题文本的长度和复杂性，以及应用程序的特定需求（如语义搜索或问答），也会影响分块策略的选择。这可能与选用的大语言模型的 Token 限制直接相关，因此可能需要调整块大小。实际上，准确的查询结果是通过灵活应用多种分块策略来实现的，并没有最佳策略，只有最适合的策略。

当前的 RAG 研究采用了多种块优化方法，以提高检索的效率和准确性。其中，技术如滑动窗口技术通过多次检索，聚合全局相关信息，实现分层检索。

Small2big 技术在搜索过程中使用小文本块，并为语言模型提供更大的相关文本块进行处理。摘要嵌入（Abstract embedding）技术对文档摘要执行 Top K 检索，以提供完整的文档上下文。元数据过滤（Metadata Filtering）技术通过文档的元数据进行过滤。图索引（Graph Indexing）技术把实体和关系转化为节点和连接，这在处理多跳问题时显著提升了相关性。这些方法的结合显著提升了 RAG 的检索效果和性能。

微调嵌入模型

在确定了 Chunk 的适当大小之后，我们需要通过一个嵌入模型（Embedding model）将 Chunk 和查询嵌入到语义空间中。因此，嵌入模型是否能有效代表整个语料库变得极其重要。如今，一些出色的嵌入模型已经问世，例如 UAE [AngIE, 2023]、Voyage [VoyageAI, 2023]、BGE [BAAI, 2023] 等，它们在大规模语料库上预训练过。但在特定领域中应用时，这些模型可能无法准确地反映领域特定的语料信息。此外，为了确保模型能够理解用户查询与内容的相关性，对嵌入模型进行任务特定的微调至关重要，否则未经微调的模型可能无法满足特定任务的需求。因此，对嵌入模型进行微调对于其下游应用是必不可少的。

领域知识微调

嵌入模型微调的两个基本范式包括领域知识微调。为了让嵌入模型准确理解领域特定信息，我们需要构建专门的领域数据集来对嵌入模型进行微调。

然而，嵌入模型的微调与常规语言模型的微调不同，主要区别在于所使用的数据集。当前微调嵌入模型的主流方法使用的数据集包括查询（Queries）、语料库（Corpus）和相关文档（Relevant Docs）。嵌入模型基于查询在语料库中检索相关文档，然后根据查询的相关文档是否命中作为衡量模型的标准。

在构建数据集、微调模型和评估过程中，每个部分都可能遇到各种挑战。LlamaIndex [Liu, 2023] 专门为嵌入模型的微调过程引入了一系列关键类别和功能，大大简化了这一过程。通过准备领域知识的语料库并利用其提供的方法，我们可以轻松获得适合特定领域需求的专业嵌入模型。

对下游任务的微调

根据下游任务微调嵌入模型同样重要。使用 RAG 处理特定任务时，已有研究通过大语言模型（LLM）的功能来微调嵌入模型。例如，PROMPTAGATOR [Dai et al., 2022] 将大语言模型用作少样本查询生成器，基于此生成的数据创建了针对特定任务的检索器，这样做可以解决一些领域由于数据不足而难以进行常规监督微调的问题。LLM-Embedder [Zhang et al., 2023a] 则利用大语言模型为多个特定任务中的数据输出奖励值，并通过硬性标记数据集和来自 LLM 的软性奖励对检索器进行了双重微调。

这种做法在一定程度上通过引入领域知识和针对特定任务的微调，改善了语义表达。但是，这种训练方式得到的检索器并不总是直接有益于大语言模型，因此有研究通过从 LLM 获取反馈信号，直接对嵌入模型进行了监督微调。（更多细节将在第 4.4 节介绍）

#### 4.2 How to Match the Semantic Space of Queries and Documents

In the RAG application, some retrievers use the same embedding model to encode the query and doc, while others use two models to separately encode the query and doc. Moreover, the original query of the user may have problems of poor expression and lack of semantic information. Therefore, aligning the semantic space of the user's query and documents is very necessary. This section introduces two key technologies to achieve this goal.

Query Rewrite The most intuitive way to align the semantics of query and document is to rewrite the query. As mentioned in Query2Doc [ Wang et al., 2023b ] and ITERRETGEN [ Shao et al., 2023 ] , the inherent capabilities of large language models are utilized to generate a pseudodocument by guiding it, and then the original query is merged with this pseudo-document to form a new query. In HyDE [ Gao et al., 2022 ] , query vectors are established through the use of text indicators, using these indicators to generate a 'hypothetical' document that is relevant, yet may not truly exist, it only needs to capture the relevant pattern. RRR [ Ma et al., 2023a ] introduced a new framework that inverts the order of retrieval and reading, focusing on query rewriting. This method generates a query using a large language model, then uses a web search engine to retrieve context, and finally uses a small language model as a training rewriter to serve the frozen large language model. The STEP-BACKPROMPTING [ Zheng et al., 2023 ] method can make large language models carry out abstract reasoning, extract high-level concepts and principles, and conduct retrieval based on this. Lastly, the method in Multi Query Retrieval involves using large language models to generate multiple search queries, these queries can be executed in parallel, and the retrieval results are input together, which is very useful for single problems that rely on multiple sub-problems

Embedding Transformation If there is a coarse-grained method like rewriting queries, there should also be a finer-grained implementation specific for embedding operations. In LlamaIndex [ Liu, 2023 ] , it is possible to connect an adapter after the query encoder, and fine-tune the adapter to optimize the representation of query embeddings, mapping it to a latent space that is better suited for specific tasks.When the data structure of a query and an external document are different, such as an unstructured query and a structured external document, it is very important to enable the query to align with the document.SANTA [ Li et al., 2023d ] proposes two pretraining methods to make the retriever aware of structured information 1) Using the natural alignment relationship between structured data and unstructured data for contrastive learning for structured-aware pre-training. 2) Masked Entity Prediction, which designs an entity-oriented mask strategy and asks language models to fill in the masked entities.

4.2 如何协调查询和文档的语义空间

在 RAG 应用中，有些检索器用同一个嵌入模型来处理查询和文档，而有些则使用两个不同的模型。此外，用户的原始查询可能表达不清晰或缺少必要的语义信息。因此，协调用户的查询与文档的语义空间显得尤为重要。本节将介绍两种关键技术，帮助实现这一目标。

查询重写

一种直接的方式是对查询进行重写。

如 Query2Doc [Wang et al., 2023b] 和 ITER-RETGEN [Shao et al., 2023] 所指出的，可以利用大语言模型的能力生成一个指导性的伪文档，然后将原始查询与这个伪文档结合，形成一个新的查询。

而在 HyDE [Gao et al., 2022] 中，则是通过文本标识符来建立查询向量，利用这些标识符生成一个相关但可能并不存在的「假想」文档，它的目的是捕捉到相关的模式。

Ma 团队于 2023 年提出的 RRR 框架，开创了一种新的方法，将检索和阅读的顺序进行了反转，专注于如何重新编写查询。在这个方法中，首先利用大语言模型来生成搜索查询，然后通过网络搜索引擎找到相关信息，最后用一个小型的语言模型来帮助这个大模型进行所谓的「训练重写」，以提高其效果。Zheng 团队在 2023 年提出的 STEP-BACKPROMPTING 方法，能够使大语言模型进行更深层次的抽象思考，抽取出关键的概念和原则，并基于这些进行信息检索。

此外，多查询检索方法让大语言模型能够同时产生多个搜索查询。这些查询可以同时运行，它们的结果一起被处理，特别适用于那些需要多个小问题共同解决的复杂问题。

嵌入变换

对于嵌入变换，除了像查询重写这样的宏观方法，还有一些更微观的技术。在 Liu 于 2023 年提出的 LlamaIndex 中，研究者们通过在查询编码器后加入一个特殊的适配器，并对其进行微调，从而优化查询的嵌入表示，使之更适合特定的任务。

在处理结构不同的查询和文档时，例如非结构化的查询和结构化的文档，使两者对齐变得至关重要。Li 团队在 2023 年提出的 SANTA 方法，就是为了让检索系统能够理解并处理结构化的信息。他们提出了两种预训练方法：一是利用结构化与非结构化数据之间的自然对应关系进行对比学习；二是采用了一种围绕实体设计的掩码策略，让语言模型来预测和填补这些被掩盖的实体信息。

#### 4.3 How to Aligning Retriever's Output and LLM's Preference

In the RAG pipeline, even if we employ the above techniques to enhance the retrieval hit rate, it may still not improve the final effect of RAG, because the retrieved documents may not be what LLM needs. Thus, this section introduces two methods to align the outputs of the retriever and the preferences of the LLM.

LLM supervised training Many works leverage various feedback signals from large language models to fine-tune embedding models. AAR [ Yu et al., 2023b ] provides supervisory signals for a pre-trained retriever through an encoderdecoder architecture LM. By determining the LM's preferred documents through FiD cross-attention scores, the retriever is then fine-tuned with hard negative sampling and standard cross-entropy loss. Ultimately, the fine-tuned retriever can directly be used to enhance unseen target LMs, thereby performing better in the target task. The training loss of retriever as:

where D a + is the documents preferred by the LLM in the retrieved set and D a − is not preferred. l is the standard cross entropy loss. In the end,it is suggested that LLMs may have a preference for focusing on readable rather than informationrich documents REPLUG [ Shi et al., 2023 ] uses a retriever and an LLM to calculate the probability distributions of the retrieved documents, and then performs supervised training by calculating the KL divergence. This simple and effective training method enhances the performance of the retrieval model by using an LM as the supervisory signal, eliminating the need for any specific cross-attention mechanisms. The training loss of the retriever is as follows:

where D is a set of input contexts, P R is the retrieval likelihood, Q LM is the LM likelihood of each document.

UPRISE [ Cheng et al., 2023a ] also employs frozen large language models to fine-tune the Prompt Retriever. But both the language model and the retriever take Prompt-Input Pairs as inputs, then uses the scores given by the large language model to supervise the training of the retriever, equivalent to using the large language model to label the dataset. Atlas [ Izacard et al., 2022 ] proposes four methods of finetuning supervised embedding models, among them, Attention Distillation distills using the cross-attention scores that the language model generates during the output. EMDR2 employs the Expectation-Maximization algorithm to train with the retrieved documents as latent variables. Perplexity Distillation directly trains using the perplexity of the modelgenerated tokens as an indicator.LOOP introduces a new loss function based on the effect of document deletion on LM prediction, providing an effective training strategy for better adapting the model to specific tasks.

Plug in an adapter However, fine-tuning an embedding model can be challenging due to factors such as utilizing an API to implement embedding functionality or insufficient local computational resources. Therefore, some works choose to externally attach an adapter for alignment.PRCA [ Yang et al., 2023b ] trains the Adapter through the Contextual Extraction Stage and the RewardDriven Stage, and optimizes the output of the retriever based on a token-based autoregressive strategy. TokenFiltering [ Berchansky et al., 2023 ] method calculates cross-attention scores, selecting the highest scoring input tokens to effectively filter tokens. RECOMP [ Xu et al., 2023a ] proposes extractive and generative compressors, which generate summaries by selecting relevant sentences or synthesizing document information to achieve multi-document query focus summaries.In addition to that, a novel approach, PKG [ Luo et al., 2023 ] , infuses knowledge into a white-box model through directive fine-tuning, and directly replaces the retriever module, used to directly output relevant documents based on the query.

4.3 调整检索器结果以适应大语言模型的需求

在 RAG（Retrieval-Augmented Generation）流程中，即便我们采用各种技术提升检索效果，最终对 RAG 的整体性能可能仍无明显提升。原因在于检索到的文档可能并不符合大语言模型（LLM）的需求。本节将介绍两种方法，以使检索器的输出更好地符合 LLM 的偏好。

LLM 监督下的训练众多研究通过从大语言模型获取的反馈信号来调整嵌入模型。AAR [20] 通过一种基于编解码器架构的语言模型（LM），为预训练的检索器提供监督信号。检索器通过分析 LM 偏好的文档（基于 FiD 的交叉注意力分数），进行微调，使用了「硬负样本采样」和传统的交叉熵损失方法。经过这样的训练，检索器能直接用于提升新的目标 LLM，在相关任务中取得更好的成绩。检索器的训练损失公式如下：

其中 Da+ 是 LLM 偏好的文档集，Da- 则是不受偏好的文档集。l 代表传统的交叉熵损失函数。研究最后指出，LLM 可能更倾向于关注易于阅读而非信息量丰富的文档。

REPLUG [14] 则通过结合检索器和 LLM 计算出的文档概率分布，采用监督训练方式。训练过程中，通过计算 KL 散度来调整检索模型，使其性能得到提升。这种方法简单有效，利用 LM 作为监督信号，无需依赖特定的交叉注意力机制。检索器的训练损失公式如下：

这里，D 表示输入上下文集合，PR 是文档的检索可能性，QLM 则是每份文档基于 LM 的概率。

UPRISE [Cheng et al., 2023a] 同样采用了冻结的大语言模型来对 Prompt Retriever 进行微调。

在这些研究中，无论是语言模型还是检索器，它们都以提示输入对作为输入。这些模型使用大语言模型（Large Language Model）提供的分数来指导检索器的训练，这相当于用大语言模型来对数据集进行标注。

Atlas [Izacard et al., 2022] 提出了四种微调监督嵌入模型的方法。其中之一，注意力蒸馏（Attention Distillation)，通过语言模型在生成输出时产生的跨注意力分数来进行学习。而 EMDR2 则运用期望最大化（Expectation-Maximization）算法，将检索到的文档作为隐藏变量，进行模型训练。困惑度蒸馏（Perplexity Distillation）直接利用模型生成的 Token 的困惑度（perplexity）作为训练指标。LOOP 则引入了一种新的基于文档删除对大语言模型预测影响的损失函数，这为模型更好地适应特定任务提供了有效的训练方法。

插入适配器

然而，微调嵌入模型可能会遇到一些挑战，例如使用 API 实现嵌入功能或本地计算资源不足。因此，一些研究选择外接适配器来进行模型对齐。PRCA [Yang et al., 2023b] 在上下文提取阶段和奖励驱动阶段训练适配器，并通过基于 Token 的自回归（autoregressive）策略来优化检索器的输出。

TokenFiltering [Berchansky et al., 2023] 的方法通过计算跨注意力分数，挑选出得分最高的输入 Token，有效地进行 Token 过滤。RECOMP [Xu et al., 2023a] 提出了提取和生成压缩器的概念，这些压缩器通过选择相关的句子或合成文档信息来生成摘要，实现多文档查询聚焦摘要。此外，PKG [Luo et al., 2023] 这一新颖方法，通过指令性微调将知识注入到一个白盒模型中，并直接替换了检索器模块，以便直接根据查询输出相关文档。

### 05. Generator

Another core component in RAG is the generator, responsible for transforming retrieved information into natural and fluent text. Its design is inspired by traditional language models, but in comparison to conventional generative models, RAG's generator enhances accuracy and relevance by leveraging the retrieved information. In RAG, the generator's input includes not only traditional contextual information but also relevant text segments obtained through the retriever. This allows the generator to better comprehend the context behind the question and produce responses that are more information-rich. Furthermore, the generator is guided by the retrieved text to ensure consistency between the generated content and the retrieved information. It is the diversity of input data that has led to a series of targeted efforts during the generation phase, all aimed at better adapting the large model to the input data from queries and documents. We will delve into the introduction of the generator through aspects of post-retrieval processing and fine-tuning.

05 生成组件

在 RAG 系统中，生成组件是核心部分之一，它的职责是将检索到的信息转化为自然流畅的文本。这一设计灵感源自于传统语言模型，但不同于一般的生成式模型，RAG 的生成组件通过利用检索到的信息来提高文本的准确性和相关性。在 RAG 中，生成组件的输入不仅包括传统的上下文信息，还有通过检索器得到的相关文本片段。这使得生成组件能够更深入地理解问题背后的上下文，并产生更加信息丰富的回答。此外，生成组件还会根据检索到的文本来指导内容的生成，确保生成的内容与检索到的信息保持一致。正是因为输入数据的多样性，我们针对生成阶段进行了一系列的有针对性工作，以便更好地适应来自查询和文档的输入数据。

#### 5.1 How Can Retrieval Results be Enhanced via Post-retrieval Processing?

In terms of untuned large language models, most studies rely on well-recognized large language models like GPT4 [ OpenAI, 2023 ] to leverage their robust internal knowledge for the comprehensive retrieval of document knowledge. However, inherent issues of these large models, such as context length restrictions and vulnerability to redundant information, persist. To mitigate these issues, some research has made efforts in post-retrieval processing. Post-retrieval processing refers to the process of further treating, filtering, or optimizing the relevant information retrieved by the retriever from a large document database. Its primary purpose is to enhance the quality of retrieval results to better meet user needs or for subsequent tasks. It can be understood as a process of reprocessing the documents obtained in the retrieval phase. The operations of post-retrieval processing usually involve information compression and result rerank.

Information Compression Even though the retriever can fetch relevant information from a vast knowledge base, we are still confronted with the challenge of dealing with a substantial amount of information in retrieval documents. Some existing research attempts to solve this problem by increasing the context length of large language models, but current large models still confront context limitations. Thus, in certain situations, information condensation is necessary. In short, the importance of information condensation mainly embodies in the following aspects: reduction of noise, coping with context length restrictions, and enhancing generation effects.

PRCA [ Yang et al., 2023b ] addressed this issue by training an information extractor. In the context extraction stage, given an input text S input , it can generate an output sequence C extracted , which represents the condensed context from the input document. The objective of the training process is to minimize the discrepancy between C extracted and the actual context C truth as much as possible. The loss function they adopted is as follows:

where f . is the information extractor and θ is the parameter of the extractor. RECOMP [ Xu et al., 2023a ] similarly trains an information condenser by leveraging contrastive learning. For each training data point, there exists one positive sample and five negative samples. The encoder is trained using contrastive loss [ Karpukhin et al., 2020 ] during this process.The specific optimization goals are as follows:

where x i is the training data, p i is the positive sample, and n j is the negative sample,sim(x,y) is to calculate the similarity between x and y. Another study has chosen to further streamline the quantity of documents, aiming to enhance the model's answer accuracy by reducing the number of retrieved documents. [ Ma et al., 2023b ] proposed the "Filter-Ranker"

paradigm, which integrates the strengths of Large Language Models (LLMs) and Small Language Models (SLMs). In this paradigm, SLMs serve as filters, while LLMs function as reordering agents. By prompting LLMs to rearrange portions of difficult samples identified by SLMs, the research results indicate significant improvements across various Information Extraction (IE) tasks.

Rerank The pivotal role of the reordering model lies in optimizing the set of documents retrieved from retriever. LLMs experience performance degradation with retrospective performance when additional context is added, and reordering provides an effective solution to address this issue. The core idea involves rearranging document records to place the most relevant items at the top, thereby reducing the total number of documents to a fixed quantity. This not only resolves the issue of context window expansion that may be encountered during retrieval but also contributes to improving retrieval efficiency and responsiveness [ Zhuang et al., 2023 ] . Introducing context compression as part of the reordering aims to return relevant information solely based on the given query context. The dual significance of this approach lies in concentrating the display of the most relevant information in the retrieval results by reducing the content of individual documents and filtering entire documents. Thus, the reordering model plays an optimizing and refining role throughout the information retrieval process, providing more effective and accurate inputs for subsequent LLM processing.

5.1 如何通过后检索处理提升检索结果？

对于未经微调的大型语言模型，多数研究依靠像 GPT-4 [OpenAI, 2023] 这样的知名大型语言模型，借助它们强大的内部知识库来全面检索文档信息。然而，这些大型模型仍然存在一些固有问题，比如上下文长度限制和对冗余信息的敏感性。为了解决这些问题，一些研究开始关注后检索处理。后检索处理指的是，在通过检索器从大型文档数据库中检索到相关信息后，对这些信息进行进一步的处理、过滤或优化。其主要目的是提高检索结果的质量，更好地满足用户需求或为后续任务做准备。可以将其理解为对检索阶段获得的文档进行二次处理。后检索处理通常包括信息压缩和结果的重新排序。

信息压缩

信息压缩方面，即使检索器能够从庞大的知识库中提取相关信息，我们仍然面临处理大量检索文档信息的挑战。一些研究试图通过扩大大型语言模型的上下文长度来解决这个问题，但当前的大模型还是受到上下文限制。在这种情况下，进行信息浓缩变得必要。总体来说，信息浓缩的重要性主要体现在减少信息噪音、解决上下文长度限制和提升生成效果等方面。

PRCA [Yang et al., 2023b] 解决这一问题的方法是训练了一个信息提取器。在提取上下文的阶段，这个提取器能够根据给定的输入文本 Sinput，生成一个输出序列 Cextracted，这个序列代表了输入文档中的精简上下文。训练的目标是让 Cextracted 尽可能接近实际的上下文 Ctruth。他们使用的损失函数定义如下：

​这里，𝑓 表示信息提取器的功能，而 θ 是其参数。另一个项目 RECOMP [11] 采用了对比学习法来训练一个信息浓缩器。在每个训练样本中，会有一个正样本和五个负样本。该项目在此过程中采用了对比损失方法 [13] 来训练编码器。具体的优化目标表达如下：

其中 xi 代表训练数据，pi 是正样本，ni 是负样本，sim（x,y）用于计算 x 和 y 之间的相似度。还有一项研究则是致力于进一步减少文档的数量，以此提高模型回答问题的准确度。[Ma et al., 2023b] 提出了一种新的「Filter-Ranker」模式，它结合了大语言模型（LLMs）和小语言模型（SLMs）的优点。在这种模式下，SLMs 充当过滤器，LLMs 则作为排序器。通过激励 LLMs 对 SLMs 筛选出的难点样本进行重新排序，研究表明，这在各类信息提取（IE）任务中都取得了显著的提升。

文档重排

在文档重排过程中，重排模型的主要作用是优化由检索器检索出的文档集合。

当大语言模型（LLM）面临额外上下文的添加时，其性能往往会下降。为了应对这一挑战，重排序被提出作为一种行之有效的策略。其核心在于对文档记录进行重新组织，优先安排最相关的内容位于前列，同时将文档总量控制在一定数量之内。这种做法不仅有效缓解了检索时可能出现的上下文窗口扩大问题，也显著提升了检索的效率和响应速度 [Zhuang et al., 2023]。

重排序过程中引入的上下文压缩功能，目的是基于特定查询上下文直接筛选出相关信息。这一策略的独特之处在于，通过减少每个文档的内容量和筛选掉不相关的文档，它能更加集中地展示检索结果中的关键信息。因此，重排序模型在整个信息检索过程中起到了优化和精化的作用，为后续大语言模型的处理提供了更加有效和精准的输入。

#### 5.2 How to Optimize a Generator to Adapt Input Data?

In the RAG model, the optimization of the generator is a crucial component of the architecture. The generator's task is to take the retrieved information and generate relevant text, thereby providing the final output of the model. The goal of optimizing the generator is to ensure that the generated text is both natural and effectively utilizes the retrieved documents, in order to better satisfy the user's query needs.

In typical Large Language Model (LLM) generation tasks, the input is usually a query. In RAG, the main difference lies in the fact that the input includes not only a query but also various documents retrieved by the retriever (structured/unstructured). The introduction of additional information may have a significant impact on the model's understanding, especially for smaller models. In such scenarios, finetuning the model to adapt to the input of query + retrieved documents becomes particularly important. Specifically, before providing the input to the fine-tuned model, there is usually post-retrieval processing of the documents retrieved by the retriever. It is essential to note that the method of finetuning the generator in RAG is essentially similar to the general fine-tuning approach for LLMs. Here, we will briefly introduce some representative works, including data (formatted/unformatted) and optimization functions.

General Optimization Process Refers to the training data containing pairs of (input, output), aiming to train the model's ability to generate output y given input x. In the work of Self-mem [ Cheng et al., 2023b ] , a relatively classical training process is employed. Given input x, relevant documents z are retrieved (selecting Top-1 in the paper), and after integrating (x, z), the model generates output y. The paper utilizes two common paradigms for fine-tuning, namely Joint-Encoder [ Arora et al., 2023, Wang et al., 2022b, Lewis et al., 2020 ] and Dual-Encoder [ Xia et al., 2019, Cai et al., 2021, Cheng et al., 2022 ] . For Joint-Encoder, a standard model based on encoder-decoder is used, where the encoder initially encodes the input, and the decoder, through attention mechanisms, combines the encoded results to generate tokens in an autoregressive manner:

H = Encoder(x[SEP]m) (5)

h i = Decoder(CrossAttn(H), y < i) (6)

P G ξ (. | x, y < i) = Softmax(h i ) (7)

For the Dual-Encoder, the system establishes two independent encoders, each responsible for encoding the input (query, context) and the document, respectively. The output is then subject to bidirectional cross-attention processing by the decoder in sequence. The authors choose to use the Transformer [ Vaswani et al., 2017 ] as the building block for both architectures and optimize G ξ Negative Log-Likelihood (NLL) loss.

H x = SourceEncoder(x)H m = MemoryEncoder(x) (8)

h i = Decoder(CrossAttn(H x , H m ), y < i) (9)

| y | L nll = − ∑ logP G ξ (y t | x, m, y < t) t=1 (10)

Utilizing Contrastive Learning In the phase of preparing training data, usually generated are pairs of interactions between inputs and outputs. Under this circumstance, the model can only access a unique real output which might induce the "exposure bias" problem [ Ranzato et al., 2015 ] : during the training phase, the model only exposes to a single true feedback without accessing any other generated tokens. This can impair the model's performance in application as it might excessively fit to specific feedback in the training data without effectively generalizing to other scenarios. Therefore, a graph-text contrastive learning method has been proposed by SURGE [ Kang et al., 2023 ] . For any given pair of interactions between inputs and outputs, the objective of this contrastive learning approach can be defined as follows:

Where ζ , ξ are learnable linear projection layers.z is the average representations of the graph from Encoder,h is the mean of decoder representations.z ′ ,h ′ represent the corresponding negative samples respectively. In the given text, 'h" and 'z" represent negative samples. By introducing a contrastive learning objective, the model can learn to generate diverse and reasonable replies better, rather than just the one seen in the training data. This helps to mitigate the risk of overfitting and improves the model's generalization ability in real-world scenarios.

When dealing with retrieval tasks that involve structured data, the work of SANTA [ Li et al., 2023d ] utilized a threestage training process to fully understand the structural and semantic information. Specifically, in the training phase of the retriever, contrastive learning was adopted, with the main goal of optimizing the embedding representations of the queries and documents. The specific optimization objectives are as follows:

esim(q,d + ) L DR = −log ef(q,d + ) + ∑ d − ∈ D − esim(q,d − ) (12)

where q and d are the query and document encoded by the encoder.d − ,d + represent negative samples and positive samples respectively. In the initial training stage of the generator, we utilize contrastive learning to align structured data and the corresponding document description of unstructured data. The optimization objective is as above.

Moreover, in the later training stage of the generator, inspired by references [ Sciavolino et al., 2021, Zhang et al., 2019 ] , we recognized the remarkable effectiveness of entity semantics in learning textual data representations in retrieval. Thus, we first perform entity identification in the structured data, subsequently applying a mask to the entities in the input section of the generator's training data, enabling the generator to predict these masks. The optimization objective hereafter is:

k L MEP = ∑ −logP(Y d (t j ) | X d mask , Y d (t 1 , ..., j − 1)) j=1

(13) where Y d (y j denotes the j-th token in the sequence Y d . And Y d = < mask > 1 , ent 1 , ..., < mask > n , ent n denotes the ground truth sequence that contains masked entities. Throughout the training process, we recover the masked entities by acquiring necessary information from the context, understand the structural semantics of textual data, and align the relevant entities in the structured data. We optimize the language model to fill the concealed spans and to better comprehend the entity semantics [ Ye et al., 2020 ].

5.2 如何优化生成器应对输入数据？

在 RAG 模型中，优化生成器是至关重要的。生成器负责将检索到的信息转化为相关文本，形成模型的最终输出。其优化目的在于确保生成文本既流畅又能有效利用检索文档，更好地回应用户的查询。

在一般的大语言模型（LLM）生成任务中，输入通常是个查询。而 RAG 的不同之处在于，输入不仅包括查询，还涵盖了检索器找到的多种文档（无论是结构化还是非结构化）。额外信息的加入对模型理解尤其是小型模型造成显著影响，因此，针对查询和检索文档的输入进行模型微调变得尤为重要。一般在将输入提供给微调过的模型之前，需要对检索器找到的文档进行后续处理。值得注意的是，RAG 中对生成器的微调方式与大语言模型的普通微调方法大体相同。本文将简要介绍包括格式化和非格式化数据及其优化函数的一些代表性研究。

通用优化过程

通用优化过程涉及训练数据中的输入输出对，目的是让模型学会根据输入 x 生成输出 y。

在 Self-mem [Cheng et al., 2023b] 的研究中，采用了一种传统训练方法。给定输入 x 后，检索出相关文档 z（文中选取最相关的一个），然后结合（x, z)，模型便生成输出 y。

论文探讨了两种主流微调方法，分别是联合编码器（Joint-Encoder）[Arora et al., 2023, Wang et al., 2022b, Lewis et al., 2020] 和双编码器（Dual-Encoder）[Xia et al., 2019, Cai et al., 2021, Cheng et al., 2022]。

在联合编码器模式下，使用的是标准的编解码器模型，编码器首先处理输入，然后解码器通过注意力机制将编码结果结合起来，自回归地生成 Token。

H=Encoder(x[SEP]m)

在双编码器系统中，构建了两个独立的编码器，各自负责输入（查询、上下文）和文档的编码。接着，这些输出将依次经由解码器处理，进行双向交叉注意力处理。作者采用了 Transformer [Vaswani 等人，2017] 作为两种架构的基础，并对 Gξ 负对数似然（NLL）损失进行了优化。

运用对比学习

在训练数据准备阶段，通常会生成输入和输出之间的交互对，以此进行对比学习。

在这种情境下，模型仅能接触到一个实际的输出，可能会导致「暴露偏差」问题 [Ranzato 等人，2015]：即在训练阶段，模型仅接触到单一的正确反馈，无法了解其他可能的生成 Token。

这可能影响模型在实际应用中的表现，因为它可能过度适应训练数据中的特定反馈，而不是有效泛化到其他情境。因此，SURGE [Kang 等人，2023] 提出了一种基于图文的对比学习方法。对于输入和输出之间的任何一对交互，这种对比学习方法的目标可以这样定义：

其中 ξ 是可学习的线性投影层。z 代表编码器中图形的平均表征，h 是解码器中的平均表征。

分别代表相应的负面样本。

在这段文本中，符号 'h' 和 'z' 代表负样本。模型通过采用对比学习（contrastive learning）的方法，可以更有效地学习生成各种合理的回复，而不局限于训练数据中的示例。这种方法有助于降低过拟合的风险，从而在真实世界的场景中提高模型的泛化能力。

在处理涉及结构化数据的检索任务时，SANTA [Li et al., 2023d] 的研究采用了三个阶段的训练过程，旨在深入理解数据的结构和语义信息。

具体地，在检索器的训练阶段，使用了对比学习来优化查询和文档的嵌入表示，其优化目标如下：

在这里，q 和 d 分别是编码器处理后的查询和文档。

分别代表负样本和正样本。在生成器的初期训练阶段，我们通过对比学习来对齐结构化数据和非结构化数据的相关文档描述。其优化目标与上述相同。

在生成器的后期训练阶段，我们受到参考文献 [16, 17] 的启发，认识到在检索任务中，实体语义对于学习文本数据表示的重要性。因此，我们首先对结构化数据进行实体识别，然后在生成器训练数据的输入部分对这些实体应用掩码，使得生成器能够预测这些被掩盖的部分。此阶段的优化目标为：

在序列 Yd 中，Ydyi 表示第 j 个 Token。这里，xxxx 表示一个包含了部分被掩盖的实体信息的序列。训练过程中，我们通过分析上下文中的信息来揭示这些被掩盖的实体，理解文本的结构性语义，并将其与结构化数据中的相关实体对应起来。我们的目标是让语言模型能够有效填补这些缺失的信息，并更深入地理解实体的含义 [21]。

### 06. Augmentation in RAG

This chapter is primarily organized into three dimensions: the stage of augmentation, augmentation data sources, and the process of augmentation, to elaborate on the key technologies in the development of RAG.Taxonomy of RAG's Core Components is illustrated in Fig 4.

06 RAG 技术的增强手段

本章主要从三个方面来介绍 RAG 技术的进展：增强阶段、数据源和增强过程。

图 4：RAG 核心技术的分类。

#### 6.1 RAG in Augmentation Stages

As a knowledge-intensive task, RAG employs different technical approaches during the language model training's pretraining, fine-tuning, and inference stages.

Pre-training Stage Since the emergence of pre-trained models, researchers have delved into enhancing the performance of Pre-trained Language Models (PTMs) in open-domain Question Answering (QA) through retrieval methods at the pre-training stage. Recognizing and expanding implicit knowledge in pre-trained models can be challenging. REALM [ Arora et al., 2023 ] introduces a more modular and interpretable knowledge embedding approach. Following the Masked Language Model (MLM) paradigm, REALM models both pre-training and fine-tuning as a retrieve-then-predict process, where the language model pre-trains by predicting masked tokens y based on masked sentences x, modeling P(x | y).

RETRO [ Borgeaud et al., 2022 ] leverages retrieval augmentation for pre-training a self-regressive language model, enabling large-scale pre-training from scratch by retrieving from a massive set of labeled data and significantly reducing model parameters. RETRO shares the backbone structure with GPT models and introduces an additional RETRO encoder to encode features of neighboring entities retrieved from an external knowledge base. Additionally, RETRO incorporates block-wise cross-attention layers in its decoder transformer structure to effectively integrate retrieval information from the RETRO encoder. RETRO achieves lower perplexity than standard GPT models. Moreover, it provides flexibility in updating knowledge stored in the language models by updating the retrieval database without the need for retraining the language models [ Petroni et al., 2019 ] .

Atla [ Izacard et al., 2022 ] employs a similar approach, incorporating a retrieval mechanism using the T5 architecture [ Raffel et al., 2020 ] in both the pre-training and fine-tuning stages. Prior to pre-training, it initializes the encoder-decoder LM backbone with a pre-trained T5, and initializes the dense retriever with a pre-trained Contriever. During the pretraining process, it refreshes the asynchronous index every 1000 steps.

COG [ Vaze et al., 2021 ] is a text generation model that formalizes its generation process by gradually copying text fragments (such as words or phrases) from an existing collection of text. Unlike traditional text generation models that select words sequentially, COG utilizes efficient vector search tools to calculate meaningful context representations of text fragments and index them. Consequently, the text generation task is decomposed into a series of copy and paste operations, where at each time step, relevant text fragments are sought from the text collection instead of selecting from an independent vocabulary. COG demonstrates superior performance to RETRO in various aspects, including question-answering, domain adaptation, and expanded phrase indexing.

On the other hand, following the discovery of the scaling law, there has been a rapid increase in model parameters, making autoregressive models the mainstream. Researchers are also exploring whether larger models can be pretrained using the RAG approach. RETRO++ [ Wang et al., 2023a ] , an extension of RETRO, increased the model's parameter scale. Studies have found consistent improvements in text generation quality, factual accuracy, low toxicity, and downstream task accuracy, particularly in knowledge-intensive tasks such as open-domain question answering. These research findings highlight the promising direction of pretraining autoregressive language models in conjunction with retrieval for future foundational models.

Figure 4: Taxonomy of RAG's Core Components

In summary, the advantages and limitations of augmented pre-training are evident. On the positive side, this approach offers a more powerful foundational model, outperforming standard GPT models in perplexity, text generation quality, and downstream task performance. Moreover, it achieves higher efficiency by utilizing fewer parameters compared to purely pre-trained models. It particularly excels in handling knowledge-intensive tasks, allowing the creation of domainspecific models through training on domain-specific corpora. However, there are drawbacks, including the requirement for a substantial amount of pre-training data and larger training resources, as well as the issue of slower update speeds. Especially as model size increases, the cost of retrieval-enhanced training becomes relatively higher. Despite these limitations, this method demonstrates notable characteristics in terms of model robustness. Once trained, retrieval-enhanced models based on pure pre-training eliminate the need for external library dependencies, enhancing both generation speed and operational efficiency.

Fine-tuning Stage During the downstream fine-tuning phase, researchers have employed various methods to fine-tune retrievers and generators for improved information retrieval, primarily in opendomain question-answering tasks. Concerning retriever finetuning, REPlUG [ Shi et al., 2023 ] treats the language model (LM) as a black box and enhances it through an adjustable retrieval model. By obtaining feedback from the black-box language model through supervised signals, REPLUG improves the initial retrieval model. UPRISE [ Cheng et al., 2023a ] , on the other hand, fine-tunes retrievers by creating a lightweight and versatile retriever through fine-tuning on diverse task sets. This retriever can automatically provide retrieval prompts for zero-shot tasks, showcasing its universality and improved performance across tasks and models.

Simultaneously, methods for fine-tuning generators include Self-Mem [ Cheng et al., 2023b ] , which fine-tunes the generator through a memory pool of examples, and Self-RAG [ Asai et al., 2023b ] , which satisfies active retrieval needs by generating reflection tokens. The RADIT [ Lin et al., 2023 ] method fine-tunes both the generator and retriever by maximizing the probability of correct answers given a retrieval-enhanced directive. It updates the generator and retriever to minimize the semantic similarity between documents and queries, effectively leveraging relevant background knowledge.

Additionally, SUGRE [ Kang et al., 2023 ] introduces the concept of contrastive learning. It conducts end-to-end finetuning of both retriever and generator, ensuring highly detailed text generation and retrieved subgraphs. Using a context-aware subgraph retriever based on Graph Neural Networks (GNN), SURGE extracts relevant knowledge from a knowledge graph corresponding to an ongoing conversation. This ensures the generated responses faithfully reflect the retrieved knowledge. SURGE employs an invariant yet efficient graph encoder and a graph-text contrastive learning objective for this purpose.

In summary, the enhancement methods during the finetuning phase exhibit several characteristics. Firstly, finetuning both LLM and retriever allows better adaptation to specific tasks, offering the flexibility to fine-tune either one or both simultaneously, as seen in methods like RePlug [ Shi et al., 2023 ] and RA-DIT [ Lin et al., 2023 ] . Secondly, the benefits of this fine-tuning extend to adapting to diverse downstream tasks, as demonstrated by UPRISE [ Cheng et al., 2023a ] , making the model more versatile. Additionally, fine-tuning enables models to better accommodate different data structures in various corpora, particularly advantageous for graph-structured corpora, as highlighted by the SUGRE method.

However, fine-tuning during this phase comes with limitations, such as the need for datasets specifically prepared for RAG fine-tuning and the requirement for substantial computational resources compared to the RAG during the inference phase. Overall, during fine-tuning, researchers have the flexibility to tailor models according to specific requirements and data formats, reducing the resource consumption compared to the pre-training phase while retaining the ability to adjust the model's output style.

Inference Stage The integration of RAG methods with LLM has become a prevalent research direction in the inference phase. Notably, the research paradigm of Naive RAG relies on incorporating retrieval content during the inference stage.

To overcome the limitations of Naive RAG, researchers have introduced richer context in the RAG during the inference phase. The DSP [ Khattab et al., 2022 ] framework relies on a complex pipeline that involves passing natural language text between a frozen Language Model (LM) and a Retrieval Model (RM), providing the model with more informative context to enhance generation quality. PKG equips LLMs with a knowledge-guided module that allows access to relevant knowledge without altering the parameters of LLMs, enabling the model to perform more sophisticated tasks. Additionally, CREA-ICL [ Li et al., 2023b ] leverages synchronous retrieval of cross-lingual knowledge to assist in acquiring additional information, while RECITE forms context by sampling one or more paragraphs from LLMs.

During the inference phase, optimizing the process of RAG can benefit adaptation to more challenging tasks. For example, ITRG [ Feng et al., 2023a ] enhances adaptability for tasks requiring multiple-step reasoning by iteratively retrieving and searching for the correct reasoning path. ITERRETGEN [ Shao et al., 2023 ] employs an iterative approach to coalesce retrieval and generation, achieving an alternating process of "retrieval-enhanced generation" and "generationenhanced retrieval."

On the other hand, IRCOT [ Trivedi et al., 2022 ] merges the concepts of RAG and CoT [ Wei et al., 2022 ] , employing alternate CoT-guided retrievals and using retrieval results to improve CoT. This method significantly improves the performance of GPT-3 across various QA tasks, highlighting the potential advantages of integrating retrieval and generation.

In summary, inference-stage enhancement methods offer the advantages of being lightweight, cost-effective, requiring no additional training, and utilizing powerful pre-trained models. The main strength lies in freezing the parameters of the LLMs during fine-tuning, focusing on providing context that better suits the requirements, with the characteristics of being fast and low-cost. However, this approach also has some limitations, including the need for additional data processing and process optimization, while being constrained by the foundation model's capabilities. Typically, this method is often combined with process optimization techniques such as step-wise reasoning , iterative reasoning, and adaptive retrieval to better meet the requirements of different tasks.

6.1 RAG 在各个增强阶段的应用

RAG 作为一项知识密集型任务，在语言模型训练的预训练、微调和推理阶段采用了多种技术手段。

预训练阶段

在预训练阶段，研究人员努力通过检索方法来提升预训练语言模型在开放领域问答中的表现。预训练模型中隐含知识的识别和扩充是一项挑战。2023 年，Arora et al. 提出了 REALM，一种更为模块化且易于理解的知识嵌入方法。REALM 采用掩蔽语言模型（MLM）的方式，将预训练和微调视为一种先检索再预测的过程，即语言模型根据掩蔽的句子 x 预测掩蔽的 Token y，建模 P（x|y)。

2022 年，Borgeaud et al. 提出的 RETRO 则是利用检索增强来预训练自回归语言模型，它通过从大量标记数据集中检索信息，实现了从零开始的大规模预训练，并显著减少了模型的参数量。

RETRO 不仅与 GPT 模型共享主体结构，还增加了一个 RETRO 编码器，用于编码从外部知识库检索得到的相关实体的特征。

更进一步，RETRO 在其解码器的 Transformer 结构中加入了分块交叉注意力层，有效地融合了来自 RETRO 编码器的检索信息。这使 RETRO 在处理复杂问题时，比标准的 GPT 模型表现出更低的困惑度。此外，RETRO 在更新语言模型存储的知识时更加灵活，可以通过更新检索数据库来实现，无需重新训练整个模型 [Petroni et al.，2019]。

Atla [Izacard et al., 2022] 采用了与 T5 架构 [Raffel et al., 2020] 相似的方法，在预训练和微调阶段都融入了检索机制。在开始预训练之前，Atla 会先用已经预训练好的 T5 初始化其编解码器的大语言模型基础，并用预训练好的 Contriever 初始化密集检索器。

在预训练的过程中，相较于传统的预训练模型，这种方法通过减少参数的使用，提高了效率。它特别擅长处理需要大量知识的任务，并可以通过在特定领域的语料库上训练来构建专门的模型。但这种方法也有其不足之处，如需要大量预训练数据、更多的训练资源，以及更新速度较慢。特别是当模型尺寸增大时，基于检索的训练成本会相对增高。尽管存在这些限制，这种方法在增强模型的鲁棒性方面表现出色。一旦训练完成，基于纯预训练的检索增强模型就不再需要外部库的依赖，从而提高了生成速度和操作效率。

微调阶段

在下游微调阶段，研究人员采用了多种方法来提高检索器和生成器在开放域问答任务中的信息检索能力。例如，REPlUG [Shi et al., 2023] 把语言模型（LM）当作黑盒来处理，并通过一个可调节的检索模型进行优化。REPLUG 通过监督信号从黑盒语言模型中获取反馈，进而改善初始的检索模型。而 UPRISE [Cheng et al., 2023a] 通过在多样化的任务集上进行微调，创建了一个轻量且灵活的检索器。

这种检索器能够为零样本任务自动生成检索提示，展现了其在不同任务和模型上的通用性和优越性能。

同时，研究人员也在微调生成器方面做出了努力。例如，Self-Mem [Cheng et al., 2023b] 通过利用示例池对生成器进行微调，而 Self-RAG [Asai et al., 2023b] 则通过生成反射 Token（reflection tokens）来满足主动检索的需求。

RA-DIT [Lin et al., 2023] 方法则是通过提高在检索增强指令下正确答案出现的概率来同时微调生成器和检索器。它通过最小化文档与查询之间的语义相似度，有效地利用了相关的背景知识。

此外，SUGRE [Kang et al., 2023] 引入了对比学习（contrastive learning）的概念，实现了检索器和生成器的端到端微调，从而保证了文本生成的高度精确性和检索的子图的详细性。

SURGE 则利用基于图神经网络（Graph Neural Networks）的上下文感知子图检索器，从知识图谱中提取与进行中对话相关的知识，确保生成的回应忠实地反映了检索到的知识。为了达到这个目的，SURGE 使用了一个高效且不变的图编码器，以及一个图文对比学习目标。

总的来说，微调阶段的增强方法有几个显著特征。

首先，对大语言模型（LLM）和检索器进行微调可以更好地适应特定任务，这提供了同时或单独微调任一者的灵活性。例如，RePlug [Shi et al., 2023] 和 RA-DIT [Lin et al., 2023] 方法展示了这一点。其次，微调有助于模型适应多样化的下游任务，如 UPRISE [Cheng et al., 2023a] 所示，使模型更加多功能。此外，微调还使模型能更好地处理不同数据结构的多种语料库，尤其是在处理图结构语料库方面有明显优势，SUGRE 方法就是一个例证。

然而，微调阶段也存在局限性，比如需要特别为 RAG 微调准备的数据集，以及与推理阶段相比需要更多的计算资源。总体来说，在微调阶段，研究人员可以根据特定需求和数据格式定制模型，在减少资源消耗的同时，仍能调整模型的输出风格。

推理阶段

在推理阶段，RAG 方法与大语言模型的结合成为了研究的热点。例如，Naive RAG 就是在推理阶段融入检索内容的一个研究模式。

为了弥补 Naive RAG 的不足，研究者在推理阶段的 RAG 中引入了更多上下文。DSP [Khattab et al., 2022] 框架通过一个复杂的流程，在冻结的语言模型（LM）和检索模型（RM）间传递自然语言文本，为模型提供更丰富的上下文，从而提升生成质量。PKG 则为大语言模型装备了一个知识引导模块，允许模型在不更改参数的情况下访问相关知识，使其能够执行更复杂的任务。同时，CREA-ICL [Li et al., 2023b] 利用同步检索跨语言知识来获取额外信息，而 RECITE 则通过从大语言模型中抽取一个或多个段落来构建上下文。

在推理阶段，对 RAG 进程的优化有助于模型适应更复杂的任务。

例如，ITRG [Feng et al., 2023a] 通过迭代检索和寻找正确的推理路径，提高了模型处理多步推理任务的适应能力。

ITER-RETGEN [Shao et al., 2023] 采用了一种创新的迭代方式，将信息检索和内容生成紧密结合。这种方法轮流进行「以检索助力生成」的过程和「以生成反哺检索」的过程，从而有效地提升了信息的准确性和相关性。而 IRCOT [Trivedi et al., 2022] 则是一种结合了 RAG 和 CoT [Wei et al., 2022] 理念的方法。它通过交替使用 CoT 引导的检索和利用检索结果来强化 CoT，有效地提升了 GPT-3 在各类问答任务中的表现，这突出了融合检索与生成技术的巨大潜力。

总结来说，推理阶段的增强技术因其轻量、高效、无需额外训练以及能够有效利用已有的强大预训练模型而备受推崇。其最大的特点是在模型微调时保持大语言模型（LLM）的参数不变，重点在于根据不同需求提供更加贴切的上下文信息，同时具有快速和成本低的优势。然而，这种方法也存在一些局限，比如需要额外的数据处理和流程优化，以及受限于基础模型的性能。为了更好地适应不同的任务需求，这种方法通常会与诸如逐步推理、迭代推理和自适应检索等优化技术结合使用。

#### 6.2 Augmentation Data Source

Data source is crucial factors for RAG effectiveness. Various data sources offer distinct granularities and dimensions of knowledge, requiring different processing methods. They primarily fall into three categories: unstructured data, structured data, and content generated by LLMs.

Augmented with Unstructured Data Unstructured data mainly encompasses textual data , typically derived from pure text corpora. Additionally, other text data can serve as retrieval sources, such as Prompt data used for large model fine-tuning [ Cheng et al., 2023a ] and crosslanguage data [ Li et al., 2023b ] .

In terms of text granularity, beyond the common chunks (including sentences), the retrieval unit can be tokens (e.g., kNN-LM [ Khandelwal et al., 2019 ] ), phrases (e.g., NPM [ Lee et al., 2020 ] , COG [ Vaze et al., 2021 ] ), and document paragraphs. Finer-grained retrieval units can often better handle rare patterns and out-of-domain scenarios but come with an increase in retrieval costs.

At the word level, FLARE employs an active retrieval strategy, conducting retrieval only when the LM generates lowprobability words. The method involves generating a temporary next sentence for retrieval of relevant documents, then re-generating the next sentence under the condition of the retrieved documents to predict subsequent sentences.

At the chunk level, RETRO uses the previous chunk to retrieve the nearest neighboring chunk and integrates this information with the contextual information of the previous chunk to guide the generation of the next chunk. RETRO achieves this by retrieving the nearest neighboring block N(C i−1 ) from the retrieval database, then fusing the contextual information of the preceding blocks (C 1 , . . . , C i−1 ) and the retrieval information of N(C i−1 ) through cross-attention to guide the generation of the next block C i . To maintain causality, the autoregressive generation of the i-th block C i can only use the nearest neighbor of the previous block N(C i−1 ) and not N(C i ).

Augmented with Structured Data Structured data sources like Knowledge Graphs (KG) are gradually integrated into the paradigm of RAG. Verified KGs can offer higher-quality context, reducing the likelihood of model hallucinations.

RET-LLM [ Modarressi et al., 2023 ] constructs a personalized knowledge graph memory by extracting relation triples from past dialogues for future use. SUGRE [ Kang et al., 2023 ] embeds relevant subgraphs retrieved from the knowledge graph using Graph Neural Networks (GNN) to prevent the model from generating contextually irrelevant replies. SUGRE [ Kang et al., 2023 ] employs a graph encoding method that reflects the graph structure into PTMs' representation space and utilizes a multi-modal contrastive learning objective between graphtext modes to ensure consistency between retrieved facts and generated text. KnowledgeGPT [ Wang et al., 2023c ] generates search queries for Knowledge Bases (KB) in code format and includes predefined KB operation functions. Apart from retrieval, KnowledgeGPT also offers the capability to store knowledge in a personalized knowledge base to meet individual user needs. These structured data sources provide RAG with richer knowledge and context, contributing to improved model performance.

LLM Generated Content RAG Observing that the auxiliary information recalled by RAG is not always effective and may even have negative effects, some studies have expanded the paradigm of RAG by delving deeper into the internal knowledge of LLM. This approach utilizes the content generated by LLM itself for retrieval, aiming to enhance performance in downstream tasks. The following outlines notable studies within this category:

SKR [ Wang et al., 2023d ] employs a labeled training set, categorizing questions that the model can directly answer as known and those requiring retrieval enhancement as unknown. The model is trained to discern whether a question is known, applying retrieval enhancement only to inputs identified as unknown, while directly answering the rest.

GenRead [ Yu et al., 2022 ] substitutes the LLM generator for the retriever. Experimental results indicate that situations where the generated context document contains correct answers are more prevalent than those retrieved by Naive RAG. The generated answers also demonstrate superior quality. The authors attribute this to the alignment between the task of generating document-level context and the pre-training objective of causal language modeling, allowing for better utilization of world knowledge stored in the model parameters.

Selfmem [ Cheng et al., 2023b ] iteratively uses a retrievalenhanced generator to create an unbounded memory pool. A memory selector is employed to choose an output as the memory for subsequent generations. This output serves as the dual problem to the original question. By combining the original and dual problems, a retrieval-enhanced generative model can leverage its own output to enhance itself.

These diverse approaches showcase innovative strategies in RAG retrieval enhancement, aiming to elevate model performance and effectiveness.

6.2 数据增强来源

数据来源对 RAG（Retrieval-Augmented Generation）的效果至关重要。不同的数据来源提供不同粒度和维度的知识，因此需要采取不同的处理方式。主要分为三类：非结构化数据、结构化数据以及大语言模型生成的内容。

非结构化数据增强

在非结构化数据方面，这类数据主要是文本型的，通常源自纯文本的语料库。除此之外，还有其他文本数据可用于检索，例如用于大模型微调的 Prompt 数据 [Cheng et al., 2023a] 和跨语言数据 [Li et al., 2023b]。

在处理文本的粒度上，除了常见的句子块之外，检索的单元还可以是 Token（例如 kNN-LM [Khandelwal et al., 2019]）、短语（如 NPM [Lee et al., 2020]，COG [Vaze et al., 2021]）以及文档段落。更细致的检索单元能更好地应对罕见模式和领域外的场景，但相应地，检索成本也会上升。

在词汇层面，FLARE 实行一种主动检索策略，仅在大语言模型生成低概率词时启动检索。这种方法涉及先生成一个临时的下一句话用于检索相关文档，然后根据检索到的文档再次生成下一句话，以预测接下来的句子。

在文本块的层面，RETRO 则使用前一个块来检索与之最接近的块，并将这些信息融合进前一个块的上下文中，用以指导下一个块的生成。具体来说，RETRO 通过从检索数据库中提取前一个块的最近邻块 N（Ci−1)，并将之前块的上下文信息（C1*，...，C*i−1）与 N（Ci−1）的检索信息结合，通过交叉关注机制，来指导下一个块 Ci 的生成。为了保持因果逻辑的连贯性，生成第 i 个块 Ci 时，只能参考前一个块的最近邻 N（Ci−1)，而不能使用 N（Ci)。

结构化数据增强

在结构化数据的增强方面，像知识图谱（Knowledge Graph, KG）这类数据源正逐步融入到 RAG 的框架中。经验证的知识图谱能提供更高品质的上下文信息，从而减少模型产生错觉的可能性。

例如，RET-LLM [Modarressi et al., 2023] 构建了一个个性化的知识图谱记忆，它通过从过往对话中提取关系三元组，用于未来的对话处理。

SUGRE [Kang et al., 2023] 使用图神经网络（GNN）嵌入从知识图谱中检索到的相关子图，这样做可以避免模型生成与话题无关的回复。

SUGRE [Kang et al., 2023] 采用一种图编码方法，该方法将图结构融入到预训练模型（PTMs）的表征空间，并利用图文模式之间的多模态对比学习目标来确保检索到的事实与生成文本的一致性。

KnowledgeGPT [Wang et al., 2023c] 生成的代码格式搜索查询适用于知识库（KB)，并包括预定义的 KB 操作函数。除了检索功能，KnowledgeGPT 还能够在个性化知识库中存储知识，以满足用户的个性化需求。这些结构化数据源为 RAG 提供了更加丰富的知识和上下文，从而提升模型性能。

LLM 生成的内容 RAG

鉴于 RAG 回忆的辅助信息有时效果不佳，甚至可能适得其反，部分研究对 RAG 的应用范式进行了拓展，深入探讨了大语言模型（LLM）的内部知识。这种方法通过利用 LLM 自身生成的内容来进行检索，目的是提高下游任务的性能。以下是该领域一些重要的研究： SKR [Wang et al., 2023d] 使用了一个标记好的训练集，将模型能够直接回答的问题归类为「已知」，而需要额外检索增强的问题归类为「未知」。该模型训练用于区分问题是否为「已知」，仅对「未知」的问题应用检索增强，而对其他问题直接给出答案。

GenRead [Yu et al., 2022] 将检索器替换为 LLM 生成器。实验结果显示，由 LLM 生成的上下文文档中包含正确答案的情况比传统 RAG 检索的更常见，并且生成的答案质量更高。作者认为，这是因为生成文档级上下文的任务与因果性语言建模的预训练目标相匹配，使得模型能更有效地利用存储在参数中的世界知识。

Selfmem [Cheng et al., 2023b] 通过迭代使用检索增强的生成器，建立了一个无限的记忆池。系统中包含一个记忆选择器，用于选择一个生成输出作为后续生成过程的记忆。这个输出对应于原始问题的另一面。通过结合原始问题和其对立面，检索增强的生成模型能够利用自身的输出来自我提升。

这些不同的方法展示了 RAG 检索增强领域的创新策略，目的是提高模型的性能和有效性。

#### 6.3 Augmentation Process

Most RAG research typically only performs a single retrieval and generation process. However, single retrievals may contain redundant information, leading to a "lost in the middle" phenomenon [ Liu et al., 2023 ] . This redundant information can obscure key information or contain information contrary to the real answer, negatively impacting the generation effect [ Yoran et al., 2023 ] . Additionally, the information obtained from a single retrieval is limited in problems requiring multi-step reasoning.

Current methods to optimize the retrieval process mainly include iterative retrieval and adaptive retrieval. These allow the model to iterate multiple times during the retrieval process or adaptively adjust the retrieval process to better accommodate different tasks and scenarios.

Iterative Retrieval Regularly collecting documents based on the original query and generated text can provide additional materials for LLMs [ Borgeaud et al., 2022, Arora et al., 2023 ] . Providing additional references in multiple iterative retrievals has improved the robustness of subsequent answer generation. However, this method may be semantically discontinuous and potentially lead to the collection of noisy and useless information, as it primarily relies on a sequence of n tokens to separate the generated and retrieved documents.

Recursive retrieval and multi-hop retrieval are used for specific data scenarios. Recursive retrieval can first process data through a structured index, then retrieve it level by level. When retrieving hierarchically rich documents, a summary can be made for each section in an entire document or long PDF. A retrieval is then performed based on the summary. After determining the document, a second retrieval is conducted for the internal chunks, thus realizing recursive retrieval. Multi-hop retrieval is often used to further mine information in graph-structured data sources [ Li et al., 2023c ] .

Some methods iterate the steps of retrieval and generation. ITER-RETGEN [ Shao et al., 2023 ] collaboratively utilizes "retrieval-enhanced generation" and "generation-enhanced retrieval" for tasks requiring reproduction of information. That is, the model uses the content needed to complete the task to respond to the input task, and these target contents serve as the information context for retrieving more relevant knowledge. This helps to generate better responses in another iteration.

IRCoT [ Trivedi et al., 2022 ] also explores retrieving documents for each generated sentence, introducing retrieval at every step of the thought chain. It uses CoT to guide the retrieval and uses the retrieval results to improve CoT, ensuring semantic completeness.

Adaptive Retrieval Indeed, the RAG methods described in the previous two sections follow a passive approach where retrieval is prioritized. This method, which involves querying related documents and inputting into a LLM based on context, may lead to efficiency issues. Adaptive retrieval methods such as those introduced by Flare [ Jiang et al., 2023b ] and SelfRAG [ Asai et al., 2023b ] , optimize the RAG retrieval process, enabling the LLM to actively judge the timing and content of retrieval. This helps to improve the efficiency and relevance of the information retrieved.

In fact, the way in which LLM actively uses tools and makes judgments is not originated from RAG but has been widely used in the agents of large models [ Yang et al., 2023c, Schick et al., 2023, Zhang, 2023 ] . The retrieval steps of Graph-Toolformer [ Zhang, 2023 ] are roughly divided into: LLMs actively use the retriever, Self-Ask and DSP [ Khattab et al., 2022 ] try to use few-shot prompts to trigger LLM search queries. When LLMs think it is necessary, they can decide to search for a relevant query to collect the necessary materials, similar to the tool call of the agent.

WebGPT [ Nakano et al., 2021 ] employs a reinforcement learning framework to automatically train the GPT-3 model to use a search engine for text generation. It uses special tokens to perform actions, including querying on a search engine, scrolling rankings, and citing references. This allows GPT-3 to leverage a search engine for text generation.

Flare [ Jiang et al., 2023b ] , on the other hand, automates the timing of retrieval and addresses the cost of periodic document retrieval based on the probability of the generated text. It uses probability as an indicator of LLMs' confidence during the generation process. When the probability of a term falls below a predefined threshold, the information retrieval system would retrieve references and removes terms with lower probabilities. This approach is designed to handle situations where LLMs might need additional knowledge.

Self-RAG [ Asai et al., 2023b ] introduces an important innovation called Reflection tokens. These special tokens are generated to review the output and come in two types: Retrieve and Critic. The model can autonomously decide when to retrieve paragraphs or use a set threshold to trigger retrieval. When retrieval is needed, the generator processes multiple paragraphs simultaneously, performing fragmentlevel beam search to obtain the best sequence. The scores for each subdivision are updated using Critic scores, and these weights can be adjusted during the inference process to customize the model's behavior. The Self-RAG framework also allows the LLM to autonomously determine whether recall is necessary, avoiding training additional classifiers or relying on NLI models. This enhances the model's ability to autonomously judge inputs and generate accurate answers.

6.3 增强过程

在大部分 RAG（检索与生成）研究中，通常仅执行单次检索和生成操作。然而，单次检索可能携带重复信息，导致生成内容「失焦」[Liu et al., 2023]。这类重复信息可能掩盖关键信息或包含与正确答案相悖的内容，从而负面影响生成质量 [Yoran et al., 2023]。此外，单次检索所获取的信息在需要多步骤推理的问题上表现有限。

目前优化检索过程的主要方法包括迭代检索和自适应检索。这些方法使模型能够在检索过程中进行多次迭代或根据不同的任务和场景自适应地调整检索方式。

迭代检索

通过定期收集基于原始查询和生成文本的文档，可以为大语言模型（LLM）提供更多参考资料 [Borgeaud et al., 2022, Arora et al., 2023]。多次迭代检索中增加的参考资料已经提升了后续答案生成的稳健性。然而，这种方法可能在语义上存在断裂，有时还可能收集到杂乱无用的信息，因为它主要依靠一连串 Token 来区分生成和检索的文档。

递归检索和多跳检索应用于特定的数据场景。递归检索首先通过结构化索引处理数据，再逐层进行检索。在检索层次丰富的文档时，可以为每个部分制作摘要，无论是整篇文档还是长篇 PDF。在基于摘要进行检索后，一旦确定了文档，就对其内部的各个部分进行二次检索，实现递归检索。多跳检索则常用于深入挖掘图结构数据源中的信息 [Li et al., 2023c]。

一些方法结合了检索和生成步骤的迭代。

ITER-RETGEN [Shao et al., 2023] 结合了「检索增强生成」和「生成增强检索」，适用于需要复现信息的任务。即模型利用完成任务所需的内容来回应输入的任务，这些内容随后成为检索更多相关知识的信息背景。这有助于在下一次迭代中生成更优的回应。

IRCoT [Trivedi et al., 2022] 探索了在思维链的每个步骤中检索文档的方法，为每生成一句话就进行一次检索。它利用 CoT（连续任务）来指导检索，并用检索结果来优化 CoT，从而确保语义的完整性。

适应性检索

在适应性检索的领域，Flare [Jiang et al., 2023b] 和 Self-RAG [Asai et al., 2023b] 等方法对常规的 RAG 方法进行了改进。传统的 RAG 方法在检索信息时采取被动方式，而这些新方法则让大语言模型（LLM）能主动决定何时以及检索什么内容，从而提高信息检索的效率和准确性。

事实上，大语言模型（LLM）主动利用工具并进行判断的做法，并非始于 RAG，而是已在许多大型模型的 AI 智能体中得到广泛应用 [Yang et al., 2023c, Schick et al., 2023, Zhang, 2023]。

以 Graph-Toolformer [Zhang, 2023] 为例，它的检索步骤分为几个阶段：LLM 主动利用检索器，通过少样本提示激发搜索查询。当 LLM 认为有必要时，会主动搜索相关问题，以收集必需信息，类似于 AI 智能体调用工具的过程。

WebGPT [Nakano et al., 2021] 则利用强化学习训练 GPT-3 模型，使其通过特殊 Token 在搜索引擎上进行查询、浏览和引用，从而在文本生成中有效利用搜索引擎。

Flare [Jiang et al., 2023b] 则通过自动判断信息检索的最佳时机，有效减少了文档检索的成本。该方法通过监测文本生成过程中的概率变化，一旦生成术语的概率降到一定阈值以下，就会触发信息检索系统，补充所需的知识。

Self-RAG [Asai et al., 2023b] 则引入了一种新颖的「反思 Token」，分为「检索」和「批评」两种。这使得模型能够根据设定的标准自主决定检索信息的时机，从而有效地获取所需段落。

在需要进行信息检索时，生成器会同时处理多个段落，并采用一种称为「片段级 beam search」的技术来确定最优的内容组合。这个过程中，各个部分的重要性通过一种叫做「评审分数（Critic scores)」的方法来评估并更新，而且这些分数在生成答案的过程中可以根据需要调整，以此来定制模型的响应方式。Self-RAG 框架的一个创新之处在于，它允许大语言模型（LLM）自己决定是否需要回顾过去的信息，这样就避免了额外训练分类器或依赖于自然语言推理（NLI）模型。这大大提升了模型自主判断信息并生成准确回答的能力。

### 07. RAG Evaluation

In exploring the development and optimization of RAG, effectively evaluating its performance has emerged as a central issue. This chapter primarily discusses the methods of evaluation, key metrics for RAG, the abilities it should possess, and some mainstream evaluation frameworks.

07 RAG 评估

在探索和优化 RAG（检索增强生成器）的过程中，如何有效评估其性能已经成为关键问题。本章节主要围绕评估方法、RAG 应具备的关键指标、它的核心能力，以及一些常用的评估框架进行讨论。

#### 7.1 Evaluation Methods

There are primarily two approaches to evaluating the effectiveness of RAG: independent evaluation and end-to-end evaluation [ Liu, 2023 ] .

Independent Evaluation Independent evaluation includes assessing the retrieval module and the generation (read/synthesis) module.

1. Retrieval Module A suite of metrics that measure the effectiveness of systems (like search engines, recommendation systems, or information retrieval systems) in ranking items according to queries or tasks are commonly used to evaluate the performance of the RAG retrieval module. Examples include Hit Rate, MRR, NDCG, Precision, etc.

2. Generation Module The generation module here refers to the enhanced or synthesized input formed by supplementing the retrieved documents into the query, distinct from the final answer/response generation, which is typically evaluated end-to-end. The evaluation metrics for the generation module mainly focus on context relevance, measuring the relatedness of retrieved documents to the query question.

End-to-End Evaluation End-to-end evaluation assesses the final response generated by the RAG model for a given input, involving the relevance and alignment of the model-generated answers with the input query. From the perspective of content generation goals, evaluation can be divided into unlabeled and labeled content. Unlabeled content evaluation metrics include answer fidelity, answer relevance, harmlessness, etc., while labeled content evaluation metrics include Accuracy and EM. Additionally, from the perspective of evaluation methods, end-to-end evaluation can be divided into manual evaluation and automated evaluation using LLMs. The above summarizes the general case of end-to-end evaluation for RAG. Furthermore, specific evaluation metrics are adopted based on the application of RAG in particular domains, such as EM for question-answering tasks [ Borgeaud et al., 2022, Izacard et al., 2022 ] , UniEval and E-F1 for summarization tasks [ Jiang et al., 2023b ] , and BLEU for machine translation [ Zhong et al., 2022 ] . These metrics help in understanding the performance of RAG in various specific application scenarios.

7.1 评估方法

主要有两种方法来评估 RAG 的有效性：独立评估和端到端评估 [Liu, 2023]。

独立评估

独立评估涉及对检索模块和生成模块（即阅读和合成信息）的评估。

检索模块：评估 RAG 检索模块的性能通常使用一系列指标，这些指标用于衡量系统（如搜索引擎、推荐系统或信息检索系统）在根据查询或任务排名项目的有效性。这些指标包括命中率（Hit Rate)、平均排名倒数（MRR)、归一化折扣累积增益（NDCG)、精确度（Precision）等。

生成模块：生成模块指的是将检索到的文档与查询相结合，形成增强或合成的输入。这与最终答案或响应的生成不同，后者通常采用端到端的评估方式。生成模块的评估主要关注上下文相关性，即检索到的文档与查询问题的关联度。

端到端评估

端到端评估是对 RAG 模型对特定输入生成的最终响应进行评估，涉及模型生成的答案与输入查询的相关性和一致性。

从内容生成的目标来看，评估可分为无标签和有标签的内容评估。无标签内容的评估指标包括答案的准确性、相关性和无害性，而有标签内容的评估指标则包括准确率（Accuracy）和精确匹配（EM)。此外，根据评估方法的不同，端到端评估可分为人工评估和使用大语言模型（LLM）的自动评估。总的来说，这些是 RAG 端到端评估的常规方法。特定领域的 RAG 应用还会采用特定的评估指标，如问答任务的精确匹配（EM)[Borgeaud et al., 2022, Izacard et al., 2022]，摘要任务的 UniEval 和 E-F1 [Jiang et al., 2023b]，以及机器翻译的 BLEU [Zhong et al., 2022]。

这些指标有助于理解 RAG 在各种特定应用场景中的表现。

#### 7.2 Key Metrics and Abilities

Existing research often lacks rigorous evaluation of the impact of retrieval-augmented generation on different LLMs. In most cases, the evaluaion of RAG's application in various downstream tasks and with different retrievers may yield divergent results. However, some academic and engineering practices have focused on general evaluation metrics for RAG and the abilities required for its effective use. This section primarily introduces key metrics for evaluating RAG's effectiveness and essential abilities for assessing its performance.

Key Metrics Recent OpenAI mentioned various language models

report [ Jarvis and Allard, 2023 ] techniques for optimizing (LLMs), including RAG and

have large its

evaluation metrics. Additionally, the latest evaluation frameworks like RAGAS [ Es et al., 2023 ] and ARES [ Saad-Falcon et al., 2023 ] also involve RAG evaluation metrics. Summarizing these works, three core metrics are primarily focused on: Faithfulness of the answer, Answer Relevance, and Context Relevance.

1. Faithfulness

This metric emphasizes that the answers generated by the model must remain true to the given context, ensuring that the answers are consistent with the context information and do not deviate or contradict it. This aspect of evaluation is vital for addressing illusions in large models.

2. Answer Relevance This metric stresses that the generated answers need to be directly related to the posed question.

3. Context Relevance This metric demands that the retrieved contextual information be as accurate and targeted as possible, avoiding irrelevant content. After all, processing long texts is costly for LLMs, and too much irrelevant information can reduce the efficiency of LLMs in utilizing context.

The OpenAI report also mentioned "Context Recall" as a supplementary metric, measuring the model's ability to retrieve all relevant information needed to answer a question. This metric reflects the search optimization level of the RAG retrieval module. A low recall rate indicates a potential need for optimization of the search functionality, such as introducing re-ranking mechanisms or fine-tuning embeddings, to ensure more relevant content retrieval.

Key abilities The work of RGB [ Chen et al., 2023b ] analyzed the performance of different large language models in terms of four basic abilities required for RAG, including Noise Robustness, Negative Rejection, Information Integration, and Counterfactual Robustness, establishing a benchmark for retrievalaugmented generation.RGB focuses on the following four abilities:

1. Noise Robustness This capability measures the model's efficiency in handling noisy documents, which are those related to the question but do not contain useful information.

2. Negative Rejection When documents retrieved by the model lack the knowledge required to answer a question, the model should correctly refuse to respond. In the test setting for negative rejection, external documents contain only noise. Ideally, the LLM should issue a "lack of information" or similar refusal signal.

3. Information Integration This ability assesses whether the model can integrate information from multiple documents to answer more complex questions.

4. Counterfactual Robustness This test aims to evaluate whether the model can identify and deal with known erroneous information in documents when receiving instructions about potential risks in retrieved information. Counterfactual robustness tests include questions that the LLM can answer directly, but the related external documents contain factual errors.

7.2 关键指标和能力

现有研究往往缺乏对检索增强的大语言模型（LLM）生成效果的严格评估。通常情况下，评估 RAG 在不同下游任务和不同检索器中的应用可能会得到不同的结果。然而，一些学术和工程实践已经开始关注 RAG 的通用评估指标和有效运用所需的能力。本节主要介绍评估 RAG 有效性的关键指标和评估其性能所需的基本能力。

关键指标

最近的 OpenAI 报告 [Jarvis and Allard, 2023] 讨论了优化大语言模型（大语言模型）的多种技术，其中包括 RAG 及其评估标准。

此外，像 RAGAS [Es et al., 2023] 和 ARES [Saad-Falcon et al., 2023] 这样的最新评估框架也应用了 RAG 的评估标准。梳理这些研究，主要集中于三个关键指标：答案的准确性、答案的相关性和上下文的相关性。

答案准确性：这个指标着重保证模型生成的答案与给定上下文的真实性一致，确保答案不会与上下文信息发生冲突或偏离。这一评价标准对于避免大型模型中的误导至关重要。

答案相关性：此指标强调生成的答案需要紧密联系问题本身。

上下文相关性：此指标要求提取的上下文信息必须尽可能精确和具有针对性，以避免无关内容。毕竟，长文本的处理对大语言模型来说成本很高，过多无关信息会降低模型利用上下文的效率。OpenAI 的报告还特别提及了「上下文提取」作为一项补充指标，用于衡量模型回答问题所需的相关信息检索能力。这个指标反映了 RAG 检索模块的搜索优化程度。低回忆率可能暗示需要优化搜索功能，例如引入重新排序机制或调整嵌入，以确保检索到更相关的内容。

关键能力

RGB [Chen et al., 2023b] 的研究分析了不同大语言模型在处理 RAG 所需的四项基本能力方面的表现，包括抗噪声能力、拒绝无效回答能力、信息综合能力和反事实稳健性，从而为检索增强型生成设立了标准。RGB 关注以下四个能力：

抗噪声能力： 这项能力评估模型处理与问题相关但无效信息的噪声文档的效率。

拒绝无效回答能力： 当模型检索到的文档缺乏解决问题所需的信息时，模型应正确地拒绝回答。在测试拒绝无效回答时，外部文档仅包含无效信息。理想状态下，大语言模型应发出「信息不足」或类似的拒绝信号。

信息综合能力： 这项能力评价模型是否能整合多个文档中的信息，以回答更复杂的问题。

反事实鲁棒性测试： 此项测试旨在评估模型在被告知检索信息可能存在风险时，是否能识别并纠正文档中的错误信息。反事实鲁棒性测试包括一些大语言模型能直接回答的问题，但相关外部文档却含有错误事实。

#### 7.3 Evaluation Frameworks

Recently, the LLM community has been exploring the use of "LLMs as judge" for automatic assessment, with many utilizing powerful LLMs (such as GPT-4) to evaluate their own LLM applications outputs. Practices by Databricks using GPT-3.5 and GPT-4 as LLM judges to assess their chatbot applications suggest that using LLMs as automatic evaluation tools is effective [ Leng et al., 2023 ] . They believe this method can also efficiently and cost-effectively evaluate RAG-based applications.

In the field of RAG evaluation frameworks, RAGAS and ARES are relatively new. The core focus of these evaluations is on three main metrics: Faithfulness of the answer, answer relevance, and context relevance. Additionally, TruLens, an open-source library proposed by the industry, also offers a similar evaluation mode. These frameworks all use LLMs as judges for evaluation. As TruLens is similar to RAGAS, this chapter will specifically introduce RAGAS and ARES.

RAGAS This framework considers the retrieval system's ability to identify relevant and key context paragraphs, the LLM's ability to use these paragraphs faithfully, and the quality of the generation itself. RAGAS is an evaluation framework based on simple handwritten prompts, using these prompts to measure the three aspects of quality - answer faithfulness, answer relevance, and context relevance - in a fully automated manner. In the implementation and experimentation of this framework, all prompts are evaluated using the gpt3.5-turbo-16k model, which is available through the OpenAI API [ Es et al., 2023 ] . Algorithm Principles

1. Assessing Answer Faithfulness: Decompose the answer into individual statements using an LLM and verify whether each statement is consistent with the context. Ultimately, a "Faithfulness Score" is calculated by comparing the number of supported statements to the total number of statements.

2. Assessing Answer Relevance: Generate potential questions using an LLM and calculate the similarity between these questions and the original question. The Answer Relevance Score is derived by calculating the average similarity of all generated questions to the original question.

3. Assessing Context Relevance: Extract sentences directly relevant to the question using an LLM, and use the ratio of these sentences to the total number of sentences in the context as the Context Relevance Score.

ARES ARES aims to automatically evaluate the performance of RAG systems in three aspects: Context Relevance, Answer Faithfulness, and Answer Relevance. These evaluation metrics are similar to those in RAGAS. However, RAGAS, being a newer evaluation framework based on simple handwritten prompts, has limited adaptability to new RAG evaluation settings, which is one of the significances of the ARES work. Furthermore, as demonstrated in its assessments, ARES performs significantly lower than RAGAS.

ARES reduces the cost of evaluation by using a small amount of manually annotated data and synthetic data, and utilizes Predictive-Driven Reasoning (PDR) to provide statistical confidence intervals, enhancing the accuracy of evaluation [ Saad-Falcon et al., 2023 ] . Algorithm Principles

1. Generating Synthetic Dataset: ARES initially generates synthetic questions and answers from documents in the target corpus using a language model to create positive and negative samples.

2. Preparing LLM Judges: Next, ARES fine-tunes lightweight language models using the synthetic dataset to train them to evaluate Context Relevance, Answer Faithfulness, and Answer Relevance.

3. Ranking RAG Systems Using Confidence Intervals: Finally, ARES applies these judge models to score RAG systems and combines them with a manually annotated validation set using the PPI method to generate confidence intervals, reliably estimating the performance of RAG systems.

7.3 评估框架

近来，大语言模型社群开始探索将大语言模型用作评估者的自动评估方法，许多研究使用如 GPT-4 这样的先进模型来评估他们的大语言模型应用效果。Databricks 就曾使用 GPT-3.5 和 GPT-4 作为评估者，来审视他们的聊天机器人应用，结果显示这种自动评估方式颇为有效 [Leng et al., 2023]。他们还认为，这种方法对于基于检索-生成（RAG）应用的评估既高效又节约成本。在 RAG 评估框架领域，RAGAS 和 ARES 是较新的方法。这些评估主要关注三个核心指标：答案的准确性、相关性和上下文相关性。此外，业界提出的开源库 TruLens 也采用了类似的评估方式。所有这些框架都将大语言模型作为评估者。由于 TruLens 与 RAGAS 相似，本节将重点介绍 RAGAS 和 ARES。

RAGAS

这个框架关注于检索系统挑选关键上下文段落的能力、大语言模型准确利用这些段落的能力以及生成内容的整体质量。RAGAS 是一个基于简单手写提示的评估框架，通过这些提示全自动地衡量答案的准确性、相关性和上下文相关性。在此框架的实施和试验中，所有提示都通过 OpenAI API 中的 gpt-3.5-turbo-16k 模型进行评估 [Es et al., 2023]。

算法原理

答案忠实度评估：利用大语言模型（LLM）分解答案为多个陈述，检验每个陈述与上下文的一致性。最终，根据支持的陈述数量与总陈述数量的比例，计算出一个「忠实度得分」。

答案相关性评估：使用大语言模型（LLM）创造可能的问题，并分析这些问题与原始问题的相似度。答案相关性得分是通过计算所有生成问题与原始问题相似度的平均值来得出的。

上下文相关性评估：运用大语言模型（LLM）筛选出直接与问题相关的句子，以这些句子占上下文总句子数量的比例来确定上下文相关性得分。

ARES

ARES 的目标是自动化评价 RAG 系统在上下文相关性、答案忠实度和答案相关性三个方面的性能。这些评价指标与 RAGAS 中的相似。但是，RAGAS 作为一个基于简单手写提示的较新评估框架，在适应新 RAG 评估场景方面有一定局限性，这正是 ARES 项目的显著意义。此外，ARES 在评估中的表现明显不如 RAGAS。ARES 减少了评估成本，通过使用少量的手动标注数据和合成数据，并应用预测驱动推理（PDR）提供统计置信区间，提高了评估的准确性 [Saad-Falcon 等人，2023]。

算法原理

生成合成数据集：ARES 首先使用语言模型从目标语料库中的文档生成合成问题和答案，创建正负两种样本。

训练大语言模型（LLM）裁判：然后，ARES 对轻量级语言模型进行微调，利用合成数据集训练它们以评估上下文相关性、答案忠实度和答案相关性。

基于置信区间对 RAG 系统排名：最后，ARES 使用这些裁判模型为 RAG 系统打分，并结合手动标注的验证集，采用 PPI 方法生成置信区间，从而可靠地评估 RAG 系统的性能。

### 08. Future Prospects

In this chapter, we delve into three future prospects for RAG, namely vertical optimization, horizontal expansion and ecosystem of RAG.

08 未来展望

在本章中，我们讨论了 RAG 的三大未来发展方向：垂直优化、横向扩展以及 RAG 生态系统的构建。

#### 8.1 Vertical Optimization of RAG

Despite the rapid advancements in RAG technology over the past year, there are still several areas in its vertical domain that require further investigation.

Firstly, the issue of long context in RAG is a significant challenge. As mentioned in the literature [ Xu et al., 2023c ] , RAG's generation phase is constrained by the context window of LLMs. If the window is too short, it may not contain enough relevant information; if it's too long, it might lead to information loss. Currently, expanding the context window of LLMs, even to the extent of limitless context, is a critical direction in LLM development. However, once the context window constraint is removed, how RAG should adapt remains a noteworthy question.

Secondly, the robustness of RAG is another important research focus. If irrelevant noise appears during retrieval, or if the retrieved content contradicts facts, it can significantly impact RAG's effectiveness. This situation is figuratively referred to as "opening a book to a poisonous mushroom". Therefore, enhancing the robustness of RAG has increasingly gained researchers' attention, as represented in studies such as [ Yu et al., 2023a, Glass et al., 2021, Baek et al., 2023 ] .

Thirdly, the issue of RAG and Fine-tuning's synergy is also a primary research point. Hybrid has gradually become one of the mainstream methods in RAG, exemplified by RADIT [ Lin et al., 2023 ] . How to coordinate the relationship between the two to simultaneously obtain the advantages of parameterization and non-parameterization is a problem that needs addressing.

Lastly, the engineering practice of RAG is a significant area of interest. The ease of implementation and alignment with corporate engineering needs have contributed to RAG's rise. However, in engineering practice, questions like how to improve retrieval efficiency and document recall rate in large-scale knowledge base scenarios, and how to ensure enterprise data security, such as preventing LLMs from being induced to disclose the source, metadata, or other information of documents, are crucial issues that need resolution [ Alon et al., 2022 ] .

Horizontal expansion of RAG Research on RAG has rapidly expanded in the horizontal field. Starting from the initial text question answering domain, RAG's ideas have gradually been applied to more modal data, such as images, code, structured knowledge, audio and video, and so on. There are already many works in this regard.

In the image field, the propozhiyosal of BLIP2 [ Li et al., 2023a ] , which uses frozen image encoders and large-scale language models for visual language pre-training, has lowered the cost of model training. Additionally, the model can generate image-to-text conversions from zero samples. In the field of text generation, the VBR [ Zhu et al., 2022 ] method is used to generate images to guide the text generation of the language model, which has significant effects in open text generation tasks.

In the code field, RBPS [ Nashid et al., 2023 ] is used for small-scale learning related to code. By encoding or frequency analysis, similar code examples to the developers' tasks are automatically retrieved. This technique has proven its effectiveness in test assertion generation and program repair tasks. In the field of structured knowledge, methods like CoK [ Li et al., 2023c ] hints first retrieve facts related to the input question from the knowledge graph and then add these facts to the input in the form of hints. This method has performed well in knowledge graph question answering tasks.

For the field of audio and video, the GSS [ Zhao et al., 2022 ] method retrieves and concatenates audio clips from the spoken vocabulary bank, immediately transforming MT data into ST data. UEOP [ Chan et al., 2023 ] introduces a new breakthrough in end-to-end automatic speech recognition by introducing external offline strategies for voice-to-text mapping. Audio embeddings and semantic text embeddings generated by text-to-speech methods can bias ASR through KNN-based attention fusion, effectively shortening domain adaptation time. The Vid2Seq [ Yang et al., 2023a ] architecture enhances the language model by introducing special time markings, enabling it to seamlessly predict event boundaries and text descriptions within the same output sequence.

8.1 Rag 的垂直优化

尽管 RAG 技术在过去一年里取得了显著进展，但其垂直领域仍有几个重点问题有待深入探究。

首先是 RAG 中长上下文的处理问题。正如文献 [Xu et al., 2023c] 所指出的，RAG 在生成内容时受限于大语言模型（LLM）的上下文窗口大小。窗口过小可能导致相关信息不足，而窗口过大又可能引发信息丢失。目前，不断扩大 LLM 上下文窗口的尺度，甚至实现无限上下文，已成为大语言模型研发的关键方向。然而，一旦上下文窗口的限制被移除，RAG 如何适应这一变化，成为了值得关注的问题。

其次，RAG 的鲁棒性研究也是一个重要焦点。在检索过程中，如果出现无关噪声或与事实矛盾的内容，会显著影响 RAG 的效果。这种情况就像「打开一本书偶遇毒蘑菇」，因此，如何增强 RAG 的鲁棒性，已成为研究者们关注的热点，相关研究有 [Yu et al., 2023a, Glass et al., 2021, Baek et al., 2023] 等。

第三，RAG 与微调（Fine-tuning）的协同作用也是研究的重点之一。例如 RA-DIT [Lin et al., 2023] 等研究表明，混合方法已成为 RAG 的主流趋势。如何在保持参数化和非参数化优势的同时，有效协调这两者之间的关系，是一个待解决的问题。

最后，RAG 的工程应用也备受关注。RAG 之所以兴起，部分原因在于其实施简易且符合企业工程需求。

然而，在工程实践中，诸如如何在大规模知识库场景中提高检索效率和文档召回率，以及如何保障企业数据安全 —— 例如防止 LLM 被诱导泄露文档的来源、元数据或其他敏感信息 —— 都是亟待解决的关键问题 [Alon et al., 2022]。

RAG 的水平扩展

在水平领域，RAG 的研究也在迅速扩展。从最初的文本问答领域出发，RAG 的应用逐渐拓展到更多模态数据，包括图像、代码、结构化知识、音视频等。在这些领域，已经涌现出许多相关研究成果。

在图像领域，BLIP-2 [Li et al., 2023a] 的提案采用了冻结的图像编码器和大型语言模型（Large Language Model）来进行视觉语言的预训练，这大大降低了模型训练的成本。更为重要的是，该模型能够基于零样本（Zero-shot）实现从图像到文本的转换。

在文本生成领域，VBR [Zhu et al., 2022] 方法通过生成图像来引导语言模型进行文本创作，这在开放式文本生成任务中显示出显著的效果。

在编码领域，RBPS [Nashid et al., 2023] 被应用于与编码相关的小规模学习过程。该方法通过编码或频率分析，能够自动寻找与开发者当前任务相似的代码示例，这在测试断言的生成和程序修复方面已被证明是非常有效的。

在结构化知识领域，如 CoK [Li et al., 2023c] 所示的方法，首先从知识图谱中提取与提问内容相关的事实，然后以提示的形式将这些事实融入到输入中。这种方法在知识图谱问答任务中表现出色。

对于音频和视频领域，GSS [Zhao et al., 2022] 方法通过从口语词库中检索和串联音频剪辑，能够迅速将机器翻译（MT）数据转换为语音翻译（ST）数据。UEOP [Chan et al., 2023] 在端到端自动语音识别中带来了新的突破，引入了用于将声音转换为文本的外部离线策略。

利用文本到语音方法产生的音频嵌入和语义文本嵌入，可以通过基于 KNN 的注意力融合策略优化自动语音识别（ASR），有效地缩短了领域适应的时间。

Vid2Seq [Yang et al., 2023a] 架构通过引入特殊的时间标记，增强了语言模型，使其能够在同一输出序列中无缝地预测事件边界和文本描述。

#### 8.2 Ecosystem of RAG

8.2 RAG 生态系统

Downstream Tasks and Evaluation By integrating relevant information from a broad knowledge base, RAG has demonstrated significant potential in enhancing language models' ability to process complex queries and generate information-rich responses. Numerous studies have shown that RAG performs well in various downstream tasks, such as open-ended question answering and fact verification. RAG models not only improve the accuracy and relevance of information in downstream applications but also increase the diversity and depth of responses.

Given the success of RAG, exploring the model's adaptability and universality in multi-domain applications will be part of future work. This includes its use in professional domain knowledge question-answering, such as in medicine, law, and education. In the application of downstream tasks such as professional domain knowledge question-answering, RAG might offer lower training costs and better performance benefits than fine-tuning.

Simultaneously, improving the evaluation system of RAG for assessing and optimizing its application in different downstream tasks is crucial for the model's efficiency and benefits in specific tasks. This includes developing more accurate evaluation metrics and frameworks for different downstream tasks, such as context relevance, content creativity, and harmlessness, among others.

Furthermore, enhancing the interpretability of models through RAG, allowing users to better understand how and why the model makes specific responses, is also a meaningful task.

下游任务和评估

通过整合来自广泛知识库的相关信息，RAG 展示了在处理复杂查询和生成信息丰富回应方面的巨大潜力。众多研究表明，RAG 在开放式问题回答、事实验证等多种下游任务中表现优异。RAG 模型不仅提升了下游应用中信息的准确性和相关性，还增加了回应的多样性和深度。

RAG 的成功为其在多领域应用的适用性和普适性的探索铺平了道路，未来的工作将围绕此进行。特别是在医学、法律和教育等专业领域的知识问答中，RAG 的应用可能会相比微调 (fine-tuning) 提供更低的训练成本和更优的性能表现。

同时，完善 RAG 的评估体系，以更好地评估和优化它在不同下游任务中的应用，对提高模型在特定任务中的效率和效益至关重要。这涉及为各种下游任务开发更精准的评估指标和框架，如上下文相关性、内容创新性和无害性等。

此外，增强 RAG 模型的可解释性，让用户更清楚地理解模型如何以及为何作出特定反应，也是一项重要任务。

Technical Stack In the ecosystem of RAG, the development of the related technical stack has played a driving role. For instance, LangChain and LLamaIndex have become widely known quickly with the popularity of ChatGPT. They both offer a rich set of RAG-related APIs, gradually becoming one of the indispensable technologies in the era of large models. Meanwhile, new types of technical stacks are constantly being developed. Although they do not offer as many features as LangChain and LLamaIndex, they focus more on their unique characteristics. For example, Flowise AI 6 emphasizes low-code, allowing users to implement various AI applications represented by RAG without writing code, simply by dragging and dropping. Other emerging technologies include HayStack, Meltno, and Cohere Coral.

In addition to AI-native frameworks, traditional software or cloud service providers have also expanded their service range. For instance, Verba 7 , provided by the vector database company Weaviate, focuses on personal assistants. Amazon offers its users the intelligent enterprise search service tool Kendra, based on RAG thinking. Users can search in different content repositories through built-in connectors.

The development of the technical stack and RAG are mutually reinforcing. New technologies pose higher demands on the existing technical stack, while the optimization of the technical stack's functions further promotes the development of RAG technology. Overall, the technical stack of RAG's toolchain has initially formed, and many enterprise-level applications have gradually emerged, but an all-in-one platform still needs to be refined.

技术栈

在 RAG 的技术生态系统中，相关技术栈的发展起着推动作用。例如，随着 ChatGPT 的流行，LangChain 和 LLamaIndex 迅速成为知名技术，它们提供丰富的 RAG 相关 API，成为大模型时代的关键技术之一。与此同时，新型技术栈也在不断涌现。尽管这些新技术并不像 LangChain 和 LLamaIndex 那样功能众多，但它们更注重自身的独特特性。例如，Flowise AI6 着重于低代码操作，使用户能够通过简单的拖拽实现 RAG 代表的各类 AI 应用。其他新兴技术如 HayStack、Meltno 和 Cohere Coral 也在不断发展。

除了 AI 原生框架，传统软件或云服务供应商也在拓展服务范围。比如，向量数据库公司 Weaviate 推出的 Verba7 专注于个人助理领域，而亚马逊则通过其智能企业搜索服务 Kendra，基于 RAG 思想为用户提供服务，使他们可以在不同的内容仓库中进行搜索。

技术栈的发展与 RAG 的进步相互促进。新技术对现有技术栈提出了更高的要求，而技术栈功能的优化又进一步推动了 RAG 技术的发展。综合来看，RAG 工具链的技术栈已经初步建立，许多企业级应用逐步出现。然而，一个全面的一体化平台仍在完善中。

### 09. Conclusion

This paper thoroughly explores Retrieval-Augmented Generation (RAG), a technique that uses an external knowledge base to supplement the context of Large Language Models (LLMs) and generate responses. Notably, RAG combines parameterized knowledge from LLMs and non-parameterized external knowledge, alleviates hallucination issues, identifies timely information via retrieval technology, and enhances response accuracy. Additionally, by citing sources, RAG increases transparency and user trust in model outputs. RAG can also be customized based on specific domains by indexing relevant text corpora. RAG's development and characteristics are summarized into three paradigms: Naive RAG, Advanced RAG, and Modular RAG, each with its models, methods, and shortcomings. Naive RAG primarily involves the 'retrieval-reading' process. Advanced RAG uses more refined data processing, optimizes the knowledge base indexing, and introduces multiple or iterative retrievals. As exploration deepens, RAG integrates other techniques like fine-tuning, leading to the emergence of the Modular RAG paradigm, which enriches the RAG process with new modules and offers more flexibility.

In the subsequent chapters, we further analyze three key parts of RAG in detail. Chapter 4 introduces the retriever of RAG, how to process corpora to obtain better semantic representations, how to mitigate the semantic gap between Query and documents, and how to adjust the retriever to fit the generator. Chapter 5 explains how the generator obtains better generation results by post-processing retrieved documents, avoiding the "Lost in the middle" issue, as well as methods to adjust the generator to fit the retriever. Subsequently, in Chapter 6, we review the current retrieval enhancement methods from the aspects of the retrieval stage, retrieval data sources, and retrieval process.

Chapter 7 explains how to evaluate current RAG methods, including evaluation, key indicators, and current evaluation frameworks Finally, we provided an outlook on the potential future research directions for RAG. As a method that combines retrieval and generation, RAG has numerous potential development directions in future research. By continuously improving the technology and expanding its applications, the performance and practicality of RAG can be further enhanced.

09 结论

本篇论文深入探讨了检索增强型生成（Retrieval-Augmented Generation, RAG）技术。这种技术利用外部知识库来丰富大语言模型（LLMs）的上下文并生成答案。RAG 的特点在于，它结合了大语言模型中的参数化知识和外部的非参数化知识，有效减少生成信息的误差和虚假内容，利用检索技术获取及时信息，从而提升了答案的准确度。此外，RAG 通过引用资料来源，提高了模型输出的透明度和用户对结果的信任度。RAG 还可以根据特定的领域需要，通过整合相关的文本数据来进行定制。

RAG 的发展可以归纳为三种模式：基础型 RAG、高级型 RAG 和模块化 RAG。这三种模式各自拥有不同的模型、方法及其局限性。基础型 RAG 主要进行简单的「检索-阅读」操作。高级型 RAG 则在数据处理上更为精细，优化了知识库索引，并采用了多次或迭代式的检索方法。

随着技术的深入探索，RAG 开始融入微调等其他技术，形成了模块化 RAG。这一新模式通过引入新模块，使得 RAG 过程更加丰富和灵活。

在论文的后续部分，我们将深入分析 RAG 的三个核心组成部分。第四部分介绍了 RAG 的检索机制，包括如何处理文本数据以获得更准确的语义表示，缩小查询与文档间的语义差距，以及如何调整检索器以更好地配合生成器。第五部分阐述了生成器如何通过后处理检索到的文档来提升生成质量，避免信息处理过程中的缺失，并探讨了如何调整生成器以更好地适应检索器。第六部分回顾了目前提升检索效果的各种方法，从检索阶段、数据来源和检索过程等方面进行了探讨。

第七部分讲述了如何评估现有的 RAG 方法，包括评估标准、关键指标和目前的评估框架。最后，我们对 RAG 的未来研究方向进行了展望。作为结合了检索和生成的技术，RAG 在未来的研究中拥有广阔的发展空间。随着技术的不断完善和应用范围的扩大，RAG 的性能和实用性将得到进一步的提升。

### References

[ Alon et al., 2022 ] Uri Alon, Frank Xu, Junxian He, Sudipta Sengupta, Dan Roth, and Graham Neubig. Neurosymbolic language modeling with automaton-augmented retrieval. In International Conference on Machine Learning, pages 468–485. PMLR, 2022.

[ Anderson et al., 2022 ] Nathan Anderson, Caleb Wilson, and Stephen D. Richardson. Lingua: Addressing scenarios for live interpretation and automatic dubbing. In Janice Campbell, Stephen Larocca, Jay Marciano, Konstantin Savenkov, and Alex Yanishevsky, editors, Proceedings of the 15th Biennial Conference of the Association for Machine Translation in the Americas (Volume 2: Users and Providers Track and Government Track), pages 202–209, Orlando, USA, September 2022. Association for Machine Translation in the Americas.

[ AngIE, 2023 ] AngIE. Angle-optimized text embeddings.

https://github.com/SeanLee97/AnglE, 2023.

[ Arora et al., 2023 ] Daman Arora, Anush Kini, Sayak Ray Chowdhury, Nagarajan Natarajan, Gaurav Sinha, and Amit Sharma. Gar-meets-rag paradigm for zero-shot information retrieval. arXiv preprint arXiv:2310.20158, 2023.

[ Asai et al., 2023a ] Akari Asai, Sewon Min, Zexuan Zhong, and Danqi Chen. Retrieval-based language models and applications. In Proceedings of the 61st Annual Meeting of the Association for Computational Linguistics (Volume 6: Tutorial Abstracts), pages 41–46, 2023.

[ Asai et al., 2023b ] Akari Asai, Zeqiu Wu, Yizhong Wang, Avirup Sil, and Hannaneh Hajishirzi. Self-rag: Learning to retrieve, generate, and critique through self-reflection. arXiv preprint arXiv:2310.11511, 2023.

[ BAAI, 2023 ] BAAI. Flagembedding.

https://github.com/

FlagOpen/FlagEmbedding, 2023.

[ Baek et al., 2023 ] Jinheon Baek, Soyeong Jeong, Minki Kang, Jong C Park, and Sung Ju Hwang. Knowledgeaugmented language model verification. arXiv preprint arXiv:2310.12836, 2023.

[ Bai et al., 2022 ] Yuntao Bai, Saurav Kadavath, Sandipan Kundu, Amanda Askell, Jackson Kernion, Andy Jones, Anna Chen, Anna Goldie, Azalia Mirhoseini, Cameron McKinnon, et al. Constitutional ai: Harmlessness from ai feedback. arXiv preprint arXiv:2212.08073, 2022.

[ Bang et al., 2023 ] Yejin Bang, Samuel Cahyawijaya, Nayeon Lee, Wenliang Dai, Dan Su, Bryan Wilie, Holy Lovenia, Ziwei Ji, Tiezheng Yu, Willy Chung, et al. A multitask, multilingual, multimodal evaluation of chatgpt on reasoning, hallucination, and interactivity. arXiv preprint arXiv:2302.04023, 2023.

[ Berchansky et al., 2023 ] Moshe Berchansky, Peter Izsak, Avi Caciularu, Ido Dagan, and Moshe Wasserblat. Optimizing retrieval-augmented reader models via token elimination. arXiv preprint arXiv:2310.13682, 2023.

[ Bisk et al., 2020 ] Yonatan Bisk, Rowan Zellers, Jianfeng Gao, Yejin Choi, et al. Piqa: Reasoning about physical commonsense in natural language. In Proceedings of the AAAI conference on artificial intelligence, volume 34, pages 7432–7439, 2020.

[ Blagojevi, 2023 ] Vladimir Blagojevi. Enhancing rag

pipelines in haystack: Introducing diversityranker and lostinthemiddleranker. https://towardsdatascience.com/ enhancing-rag-pipelines-in-haystack-45f14e2bc9f5, 2023.

[ Borgeaud et al., 2022 ] Sebastian Borgeaud, Arthur Mensch, Jordan Hoffmann, Trevor Cai, Eliza Rutherford, Katie Millican, George Bm Van Den Driessche, Jean-Baptiste Lespiau, Bogdan Damoc, Aidan Clark, et al. Improving language models by retrieving from trillions of tokens. In International conference on machine learning, pages 2206–2240. PMLR, 2022.

[ Brown et al., 2020 ] Tom Brown, Benjamin Mann, Nick Ryder, Melanie Subbiah, Jared D Kaplan, Prafulla Dhariwal, Arvind Neelakantan, Pranav Shyam, Girish Sastry, Amanda Askell, et al. Language models are few-shot learners. Advances in neural information processing systems, 33:1877–1901, 2020.

[ Cai et al., 2021 ] Deng Cai, Yan Wang, Huayang Li, Wai Lam, and Lemao Liu. Neural machine translation with monolingual translation memory. arXiv preprint arXiv:2105.11269, 2021.

[ Chan et al., 2023 ] David M Chan, Shalini Ghosh, Ariya Rastrow, and Bj¨orn Hoffmeister. Using external offpolicy speech-to-text mappings in contextual end-to-end automated speech recognition. arXiv preprint arXiv:2301.02736, 2023.

[ Chen and Yih, 2020 ] Danqi Chen and Wen-tau Yih. Opendomain question answering. In Proceedings of the 58th annual meeting of the association for computational linguistics: tutorial abstracts, pages 34–37, 2020.

[ Chen et al., 2023a ] Howard Chen, Ramakanth Pasunuru, Jason Weston, and Asli Celikyilmaz. Walking down the memory maze: Beyond context limit through interactive reading. arXiv preprint arXiv:2310.05029, 2023.

[ Chen et al., 2023b ] Jiawei Chen, Hongyu Lin, Xianpei Han, and Le Sun. Benchmarking large language models in retrieval-augmented generation. arXiv preprint arXiv:2309.01431, 2023.

[ Cheng et al., 2022 ] Xin Cheng, Shen Gao, Lemao Liu, Dongyan Zhao, and Rui Yan. Neural machine translation with contrastive translation memories. arXiv preprint arXiv:2212.03140, 2022.

[ Cheng et al., 2023a ] Daixuan Cheng, Shaohan Huang, Junyu Bi, Yuefeng Zhan, Jianfeng Liu, Yujing Wang, Hao Sun, Furu Wei, Denvy Deng, and Qi Zhang. Uprise: Universal prompt retrieval for improving zero-shot evaluation. arXiv preprint arXiv:2303.08518, 2023.

[ Cheng et al., 2023b ] Xin Cheng, Di Luo, Xiuying Chen, Lemao Liu, Dongyan Zhao, and Rui Yan. Lift yourself up: Retrieval-augmented text generation with self memory. arXiv preprint arXiv:2305.02437, 2023.

[ Clark et al., 2019 ] Christopher Clark, Kenton Lee, MingWei Chang, Tom Kwiatkowski, Michael Collins, and Kristina Toutanova. Boolq: Exploring the surprising difficulty of natural yes/no questions. arXiv preprint arXiv:1905.10044, 2019.

[ Cohere, 2023 ] Cohere. Say goodbye to irrelevant search results: Cohere rerank is here. https://txt.cohere.com/ rerank/, 2023.

[ Dai et al., 2022 ] Zhuyun Dai, Vincent Y Zhao, Ji Ma, Yi Luan, Jianmo Ni, Jing Lu, Anton Bakalov, Kelvin Guu, Keith B Hall, and Ming-Wei Chang. Promptagator: Few-shot dense retrieval from 8 examples. arXiv preprint arXiv:2209.11755, 2022.

[ Es et al., 2023 ] Shahul Es, Jithin James, Luis EspinosaAnke, and Steven Schockaert. Ragas: Automated evaluation of retrieval augmented generation. arXiv preprint arXiv:2309.15217, 2023.

[ Feng et al., 2023a ] Zhangyin Feng, Xiaocheng Feng, Dezhi Zhao, Maojin Yang, and Bing Qin. Retrieval-generation synergy augmented large language models. arXiv preprint arXiv:2310.05149, 2023.

[ Feng et al., 2023b ] Zhangyin Feng, Weitao Ma, Weijiang Yu, Lei Huang, Haotian Wang, Qianglong Chen, Weihua Peng, Xiaocheng Feng, Bing Qin, et al. Trends in integration of knowledge and large language models: A survey and taxonomy of methods, benchmarks, and applications. arXiv preprint arXiv:2311.05876, 2023.

[ Gao et al., 2022 ] Luyu Gao, Xueguang Ma, Jimmy Lin, and Jamie Callan. Precise zero-shot dense retrieval without relevance labels. arXiv preprint arXiv:2212.10496, 2022.

[ Glass et al., 2021 ] Michael Glass, Gaetano Rossiello, Md Faisal Mahbub Chowdhury, and Alfio Gliozzo. Robust retrieval augmented generation for zero-shot slot filling. arXiv preprint arXiv:2108.13934, 2021.

[ Google, 2023 ] Google. Gemini: A family of highly capable multimodal models. https://goo.gle/GeminiPaper, 2023.

[ Hendrycks et al., 2020 ] Dan Hendrycks, Collin Burns, Steven Basart, Andy Zou, Mantas Mazeika, Dawn Song, and Jacob Steinhardt. Measuring massive multitask language understanding. arXiv preprint arXiv:2009.03300, 2020.

[ Izacard et al., 2022 ] Gautier Izacard, Patrick Lewis, Maria Lomeli, Lucas Hosseini, Fabio Petroni, Timo Schick, Jane Dwivedi-Yu, Armand Joulin, Sebastian Riedel, and Edouard Grave. Few-shot learning with retrieval augmented language models. arXiv preprint arXiv:2208.03299, 2022.

[ Jarvis and Allard, 2023 ] Colin Jarvis and John Allard. A survey of techniques for maximizing llm performance. https://community.openai.com/ t/openai-dev-day-2023-breakout-sessions/505213# a-survey-of-techniques-for-maximizing-llm-performance-2, 2023.

[ Jiang et al., 2023a ] Huiqiang Jiang, Qianhui Wu, Chin-Yew Lin, Yuqing Yang, and Lili Qiu. Llmlingua: Compressing prompts for accelerated inference of large language models. arXiv preprint arXiv:2310.05736, 2023.

[ Jiang et al., 2023b ] Zhengbao Jiang, Frank F Xu, Luyu Gao, Zhiqing Sun, Qian Liu, Jane Dwivedi-Yu, Yiming Yang, Jamie Callan, and Graham Neubig. Active retrieval augmented generation. arXiv preprint arXiv:2305.06983, 2023.

[ Kandpal et al., 2023 ] Nikhil Kandpal, Haikang Deng, Adam Roberts, Eric Wallace, and Colin Raffel. Large language models struggle to learn long-tail knowledge. In International Conference on Machine Learning, pages 15696–15707. PMLR, 2023.

[ Kang et al., 2023 ] Minki Kang, Jin Myung Kwak, Jinheon Baek, and Sung Ju Hwang. Knowledge graph-augmented language models for knowledge-grounded dialogue generation. arXiv preprint arXiv:2305.18846, 2023.

[ Karpukhin et al., 2020 ] Vladimir Karpukhin, Barlas O˘guz, Sewon Min, Patrick Lewis, Ledell Wu, Sergey Edunov, Danqi Chen, and Wen-tau Yih. Dense passage retrieval for open-domain question answering. arXiv preprint arXiv:2004.04906, 2020.

[ Khandelwal et al., 2019 ] Urvashi Khandelwal, Omer Levy, Dan Jurafsky, Luke Zettlemoyer, and Mike Lewis. Generalization through memorization: Nearest neighbor language models. arXiv preprint arXiv:1911.00172, 2019.

[ Khattab and Zaharia, 2020 ] Omar Khattab and Matei Zaharia. Colbert: Efficient and effective passage search via contextualized late interaction over bert. In Proceedings of the 43rd International ACM SIGIR conference on research and development in Information Retrieval, pages 39–48, 2020.

[ Khattab et al., 2022 ] Omar Khattab, Keshav Santhanam, Xiang Lisa Li, David Hall, Percy Liang, Christopher Potts, and Matei Zaharia. Demonstrate-search-predict: Composing retrieval and language models for knowledge-intensive nlp. arXiv preprint arXiv:2212.14024, 2022.

[ Kwiatkowski et al., 2019 ] Tom Kwiatkowski, Jennimaria Palomaki, Olivia Redfield, Michael Collins, Ankur Parikh, Chris Alberti, Danielle Epstein, Illia Polosukhin, Jacob Devlin, Kenton Lee, et al. Natural questions: a benchmark for question answering research. Transactions of the Association for Computational Linguistics, 7:453–466, 2019.

[ Lee et al., 2020 ] Jinhyuk Lee, Mujeen Sung, Jaewoo Kang, and Danqi Chen. Learning dense representations of phrases at scale. arXiv preprint arXiv:2012.12624, 2020.

[ Leng et al., 2023 ] Quinn Leng, Kasey Uhlenhuth, and Alkis Polyzotis. Best practices for llm evaluation of rag applications. https://www.databricks.com/blog/ LLM-auto-eval-best-practices-RAG, 2023.

[ Lewis et al., 2020 ] Patrick Lewis, Ethan Perez, Aleksandra Piktus, Fabio Petroni, Vladimir Karpukhin, Naman Goyal, Heinrich K¨uttler, Mike Lewis, Wen-tau Yih, Tim Rockt¨aschel, et al. Retrieval-augmented generation for knowledge-intensive nlp tasks. Advances in Neural Information Processing Systems, 33:9459–9474, 2020.

[ Li et al., 2023a ] Junnan Li, Dongxu Li, Silvio Savarese, and Steven Hoi. Blip-2: Bootstrapping language-image pretraining with frozen image encoders and large language models. arXiv preprint arXiv:2301.12597, 2023.

[ Li et al., 2023b ] Xiaoqian Li, Ercong Nie, and Sheng Liang. From classification to generation: Insights into crosslingual retrieval augmented icl. arXiv preprint arXiv:2311.06595, 2023.

[ Li et al., 2023c ] Xingxuan Li, Ruochen Zhao, Yew Ken Chia, Bosheng Ding, Lidong Bing, Shafiq Joty, and Soujanya Poria. Chain of knowledge: A framework for grounding large language models with structured knowledge bases. arXiv preprint arXiv:2305.13269, 2023.

[ Li et al., 2023d ] Xinze Li, Zhenghao Liu, Chenyan Xiong, Shi Yu, Yu Gu, Zhiyuan Liu, and Ge Yu. Structure-aware language model pretraining improves dense retrieval on structured data. arXiv preprint arXiv:2305.19912, 2023.

[ Lin et al., 2023 ] Xi Victoria Lin, Xilun Chen, Mingda Chen, Weijia Shi, Maria Lomeli, Rich James, Pedro Rodriguez, Jacob Kahn, Gergely Szilvasy, Mike Lewis, et al. Ra-dit: Retrieval-augmented dual instruction tuning. arXiv preprint arXiv:2310.01352, 2023.

[ Litman et al., 2020 ] Ron Litman, Oron Anschel, Shahar Tsiper, Roee Litman, Shai Mazor, and R Manmatha. Scatter: selective context attentional scene text recognizer. In proceedings of the IEEE/CVF conference on computer vision and pattern recognition, pages 11962–11972, 2020.

[ Liu et al., 2023 ] Nelson F Liu, Kevin Lin, John Hewitt, Ashwin Paranjape, Michele Bevilacqua, Fabio Petroni, and Percy Liang. Lost in the middle: How language models use long contexts. arXiv preprint arXiv:2307.03172, 2023.

[ Liu, 2023 ] Jerry Liu. Building production-ready rag

applications. https://www.ai.engineer/summit/schedule/ building-production-ready-rag-applications, 2023.

[ Luo et al., 2023 ] Ziyang Luo, Can Xu, Pu Zhao, Xiubo Geng, Chongyang Tao, Jing Ma, Qingwei Lin, and Daxin Jiang. Augmented large language models with parametric knowledge guiding. arXiv preprint arXiv:2305.04757, 2023.

[ Ma et al., 2023a ] Xinbei Ma, Yeyun Gong, Pengcheng He, Hai Zhao, and Nan Duan. Query rewriting for retrieval-augmented large language models. arXiv preprint arXiv:2305.14283, 2023.

[ Ma et al., 2023b ] Yubo Ma, Yixin Cao, YongChing Hong, and Aixin Sun. Large language model is not a good fewshot information extractor, but a good reranker for hard samples! ArXiv, abs/2303.08559, 2023.

[ Modarressi et al., 2023 ] Ali Modarressi, Ayyoob Imani, Mohsen Fayyaz, and Hinrich Sch¨utze. Ret-llm: Towards a general read-write memory for large language models. arXiv preprint arXiv:2305.14322, 2023.

[ Nakano et al., 2021 ] Reiichiro Nakano, Jacob Hilton, Suchir Balaji, Jeff Wu, Long Ouyang, Christina Kim, Christopher Hesse, Shantanu Jain, Vineet Kosaraju, William Saunders, et al. Webgpt: Browser-assisted question-answering with human feedback. arXiv preprint arXiv:2112.09332, 2021.

[ Nashid et al., 2023 ] Noor Nashid, Mifta Sintaha, and Ali Mesbah. Retrieval-based prompt selection for code-related few-shot learning. In 2023 IEEE/ACM 45th International Conference on Software Engineering (ICSE), pages 24502462, 2023.

[ OpenAI, 2023 ] OpenAI. Gpt-4 technical report. https://cdn.

openai.com/papers/gpt-4.pdf, 2023.

[ Petroni et al., 2019 ] Fabio Petroni, Tim Rockt¨aschel, Patrick Lewis, Anton Bakhtin, Yuxiang Wu, Alexander H Miller, and Sebastian Riedel. Language models as knowledge bases? arXiv preprint arXiv:1909.01066, 2019.

[ Raffel et al., 2020 ] Colin Raffel, Noam Shazeer, Adam Roberts, Katherine Lee, Sharan Narang, Michael Matena, Yanqi Zhou, Wei Li, and Peter J Liu. Exploring the limits of transfer learning with a unified text-to-text transformer. The Journal of Machine Learning Research, 21(1):54855551, 2020.

[ Ranzato et al., 2015 ] Marc'Aurelio Ranzato, Sumit Chopra, Michael Auli, and Wojciech Zaremba. Sequence level training with recurrent neural networks. arXiv preprint arXiv:1511.06732, 2015.

[ Reddy et al., 2019 ] Siva Reddy, Danqi Chen, and Christopher D Manning. Coqa: A conversational question answering challenge. Transactions of the Association for Computational Linguistics, 7:249–266, 2019.

[ Robertson et al., 2009 ] Stephen Robertson, Hugo Zaragoza, et al. The probabilistic relevance framework: Bm25 and beyond. Foundations and Trends® in Information Retrieval, 3(4):333–389, 2009.

[ Saad-Falcon et al., 2023 ] Jon Saad-Falcon, Omar Khattab, Christopher Potts, and Matei Zaharia. Ares: An automated evaluation framework for retrieval-augmented generation systems. arXiv preprint arXiv:2311.09476, 2023.

[ Schick et al., 2023 ] Timo Schick, Jane Dwivedi-Yu, Roberto Dess`ı, Roberta Raileanu, Maria Lomeli, Luke Zettlemoyer, Nicola Cancedda, and Thomas Scialom. Toolformer: Language models can teach themselves to use tools. arXiv preprint arXiv:2302.04761, 2023.

[ Sciavolino et al., 2021 ] Christopher Sciavolino, Zexuan Zhong, Jinhyuk Lee, and Danqi Chen. Simple entitycentric questions challenge dense retrievers. arXiv preprint arXiv:2109.08535, 2021.

[ Shao et al., 2023 ] Zhihong Shao, Yeyun Gong, Yelong Shen, Minlie Huang, Nan Duan, and Weizhu Chen. Enhancing retrieval-augmented large language models with iterative retrieval-generation synergy. arXiv preprint arXiv:2305.15294, 2023.

[ Shi et al., 2023 ] Weijia Shi, Sewon Min, Michihiro Yasunaga, Minjoon Seo, Rich James, Mike Lewis, Luke Zettlemoyer, and Wen-tau Yih. Replug: Retrievalaugmented black-box language models. arXiv preprint arXiv:2301.12652, 2023.

[ Shuster et al., 2021 ] Kurt Shuster, Spencer Poff, Moya Chen, Douwe Kiela, and Jason Weston. Retrieval augmentation reduces hallucination in conversation. arXiv preprint arXiv:2104.07567, 2021.

[ Srivastava et al., 2022 ] Aarohi Srivastava, Abhinav Rastogi, Abhishek Rao, Abu Awal Md Shoeb, Abubakar Abid, Adam Fisch, Adam R Brown, Adam Santoro, Aditya Gupta, Adri`a Garriga-Alonso, et al. Beyond the imitation game: Quantifying and extrapolating the capabilities of language models. arXiv preprint arXiv:2206.04615, 2022.

[ Sun et al., 2022 ] Zhiqing Sun, Xuezhi Wang, Yi Tay, Yiming Yang, and Denny Zhou. Recitation-augmented language models. arXiv preprint arXiv:2210.01296, 2022.

[ Touvron et al., 2023 ] Hugo Touvron, Louis Martin, Kevin Stone, Peter Albert, Amjad Almahairi, Yasmine Babaei, Nikolay Bashlykov, Soumya Batra, Prajjwal Bhargava, Shruti Bhosale, et al. Llama 2: Open foundation and fine-tuned chat models. arXiv preprint arXiv:2307.09288, 2023.

[ Trivedi et al., 2022 ] Harsh Trivedi, Niranjan Balasubramanian, Tushar Khot, and Ashish Sabharwal. Interleaving retrieval with chain-of-thought reasoning for knowledge-intensive multi-step questions. arXiv preprint arXiv:2212.10509, 2022.

[ Vaswani et al., 2017 ] Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N Gomez, Łukasz Kaiser, and Illia Polosukhin. Attention is all you need. Advances in neural information processing systems, 30, 2017.

[ Vaze et al., 2021 ] Sagar Vaze, Kai Han, Andrea Vedaldi, and Andrew Zisserman. Open-set recognition: A good closed-set classifier is all you need? arXiv preprint arXiv:2110.06207, 2021.

[ VoyageAI, 2023 ] VoyageAI. Voyage's embedding models.

https://docs.voyageai.com/embeddings/, 2023.

[ Wang et al., 2019 ] Alex Wang, Yada Pruksachatkun, Nikita Nangia, Amanpreet Singh, Julian Michael, Felix Hill, Omer Levy, and Samuel Bowman. Superglue: A stickier benchmark for general-purpose language understanding systems. Advances in neural information processing systems, 32, 2019.

[ Wang et al., 2022a ] Shuohang Wang, Yichong Xu, Yuwei Fang, Yang Liu, Siqi Sun, Ruochen Xu, Chenguang Zhu, and Michael Zeng. Training data is more valuable than you think: A simple and effective method by retrieving from training data. arXiv preprint arXiv:2203.08773, 2022.

[ Wang et al., 2022b ] Shuohang Wang, Yichong Xu, Yuwei Fang, Yang Liu, Siqi Sun, Ruochen Xu, Chenguang Zhu, and Michael Zeng. Training data is more valuable than you think: A simple and effective method by retrieving from training data. In Smaranda Muresan, Preslav Nakov, and Aline Villavicencio, editors, Proceedings of the 60th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), pages 31703179, Dublin, Ireland, May 2022. Association for Computational Linguistics.

[ Wang et al., 2023a ] Boxin Wang, Wei Ping, Peng Xu, Lawrence McAfee, Zihan Liu, Mohammad Shoeybi, Yi Dong, Oleksii Kuchaiev, Bo Li, Chaowei Xiao, et al. Shall we pretrain autoregressive language models with retrieval? a comprehensive study. arXiv preprint arXiv:2304.06762, 2023.

[ Wang et al., 2023b ] Liang Wang, Nan Yang, and Furu Wei.

Query2doc: Query expansion with large language models. arXiv preprint arXiv:2303.07678, 2023.

[ Wang et al., 2023c ] Xintao Wang, Qianwen Yang, Yongting Qiu, Jiaqing Liang, Qianyu He, Zhouhong Gu, Yanghua Xiao, and Wei Wang. Knowledgpt: Enhancing large language models with retrieval and storage access on knowledge bases. arXiv preprint arXiv:2308.11761, 2023.

[ Wang et al., 2023d ] Yile Wang, Peng Li, Maosong Sun, and Yang Liu. Self-knowledge guided retrieval augmentation for large language models. arXiv preprint arXiv:2310.05002, 2023.

[ Wei et al., 2022 ] Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten Bosma, Fei Xia, Ed Chi, Quoc V Le, Denny Zhou, et al. Chain-of-thought prompting elicits reasoning in large language models. Advances in Neural Information Processing Systems, 35:24824–24837, 2022.

[ Xia et al., 2019 ] Mengzhou Xia, Guoping Huang, Lemao Liu, and Shuming Shi. Graph based translation memory for neural machine translation. In Proceedings of the AAAI conference on artificial intelligence, volume 33, pages 7297–7304, 2019.

[ Xu et al., 2023a ] Fangyuan Xu, Weijia Shi, and Eunsol Choi. Recomp: Improving retrieval-augmented lms with compression and selective augmentation. arXiv preprint arXiv:2310.04408, 2023.

[ Xu et al., 2023b ] Peng Xu, Wei Ping, Xianchao Wu, Lawrence McAfee, Chen Zhu, Zihan Liu, Sandeep Subramanian, Evelina Bakhturina, Mohammad Shoeybi, and Bryan Catanzaro. Retrieval meets long context large language models. arXiv preprint arXiv:2310.03025, 2023.

[ Xu et al., 2023c ] Peng Xu, Wei Ping, Xianchao Wu, Lawrence McAfee, Chen Zhu, Zihan Liu, Sandeep Subramanian, Evelina Bakhturina, Mohammad Shoeybi, and Bryan Catanzaro. Retrieval meets long context large language models. arXiv preprint arXiv:2310.03025, 2023.

[ Yang et al., 2023a ] Antoine Yang, Arsha Nagrani, Paul Hongsuck Seo, Antoine Miech, Jordi Pont-Tuset, Ivan Laptev, Josef Sivic, and Cordelia Schmid. Vid2seq: Large-scale pretraining of a visual language model for dense video captioning. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition, pages 10714–10726, 2023.

[ Yang et al., 2023b ] Haoyan Yang, Zhitao Li, Yong Zhang, Jianzong Wang, Ning Cheng, Ming Li, and Jing Xiao. Prca: Fitting black-box large language models for retrieval question answering via pluggable reward-driven contextual adapter. arXiv preprint arXiv:2310.18347, 2023.

[ Yang et al., 2023c ] Hui Yang, Sifu Yue, and Yunzhong He. Auto-gpt for online decision making: Benchmarks and additional opinions. arXiv preprint arXiv:2306.02224, 2023.

[ Yao et al., 2023 ] Jia-Yu Yao, Kun-Peng Ning, Zhen-Hui Liu, Mu-Nan Ning, and Li Yuan. Llm lies: Hallucinations are not bugs, but features as adversarial examples. arXiv preprint arXiv:2310.01469, 2023.

[ Yasunaga et al., 2022 ] Michihiro Yasunaga, Armen Aghajanyan, Weijia Shi, Rich James, Jure Leskovec, Percy Liang, Mike Lewis, Luke Zettlemoyer, and Wen-tau Yih. Retrieval-augmented multimodal language modeling. arXiv preprint arXiv:2211.12561, 2022.

[ Ye et al., 2020 ] Deming Ye, Yankai Lin, Jiaju Du, Zhenghao Liu, Peng Li, Maosong Sun, and Zhiyuan Liu. Coreferential reasoning learning for language representation. arXiv preprint arXiv:2004.06870, 2020.

[ Yoran et al., 2023 ] Ori Yoran, Tomer Wolfson, Ori Ram, and Jonathan Berant. Making retrieval-augmented language models robust to irrelevant context. arXiv preprint arXiv:2310.01558, 2023.

[ Yu et al., 2022 ] Wenhao Yu, Dan Iter, Shuohang Wang, Yichong Xu, Mingxuan Ju, Soumya Sanyal, Chenguang Zhu, Michael Zeng, and Meng Jiang. Generate rather than retrieve: Large language models are strong context generators. arXiv preprint arXiv:2209.10063, 2022.

[ Yu et al., 2023a ] Wenhao Yu, Hongming Zhang, Xiaoman Pan, Kaixin Ma, Hongwei Wang, and Dong Yu. Chainof-note: Enhancing robustness in retrieval-augmented language models. arXiv preprint arXiv:2311.09210, 2023.

[ Yu et al., 2023b ] Zichun Yu, Chenyan Xiong, Shi Yu, and Zhiyuan Liu. Augmentation-adapted retriever improves generalization of language models as generic plug-in. arXiv preprint arXiv:2305.17331, 2023.

[ Zhang et al., 2019 ] Zhengyan Zhang, Xu Han, Zhiyuan Liu, Xin Jiang, Maosong Sun, and Qun Liu. Ernie: Enhanced language representation with informative entities. arXiv preprint arXiv:1905.07129, 2019.

[ Zhang et al., 2023a ] Peitian Zhang, Shitao Xiao, Zheng Liu, Zhicheng Dou, and Jian-Yun Nie. Retrieve anything to augment large language models. arXiv preprint arXiv:2310.07554, 2023.

[ Zhang et al., 2023b ] Yue Zhang, Yafu Li, Leyang Cui, Deng Cai, Lemao Liu, Tingchen Fu, Xinting Huang, Enbo Zhao, Yu Zhang, Yulong Chen, et al. Siren's song in the ai ocean: A survey on hallucination in large language models. arXiv preprint arXiv:2309.01219, 2023.

[ Zhang, 2023 ] Jiawei Zhang. Graph-toolformer: To em-

power llms with graph reasoning ability via prompt augmented by chatgpt. arXiv preprint arXiv:2304.11116, 2023.

[ Zhao et al., 2022 ] Jinming Zhao, Gholamreza Haffar, and Ehsan Shareghi. Generating synthetic speech from spokenvocab for speech translation. arXiv preprint arXiv:2210.08174, 2022.

[ Zheng et al., 2023 ] Huaixiu Steven Zheng, Swaroop Mishra, Xinyun Chen, Heng-Tze Cheng, Ed H Chi, Quoc V Le, and Denny Zhou. Take a step back: Evoking reasoning via abstraction in large language models. arXiv preprint arXiv:2310.06117, 2023.

[ Zhong et al., 2022 ] Zexuan Zhong, Tao Lei, and Danqi Chen. Training language models with memory augmentation. arXiv preprint arXiv:2205.12674, 2022.

[ Zhu et al., 2022 ] Wanrong Zhu, An Yan, Yujie Lu, Wenda Xu, Xin Eric Wang, Miguel Eckstein, and William Yang Wang. Visualize before you write: Imaginationguided open-ended text generation. arXiv preprint arXiv:2210.03765, 2022.

[ Zhu et al., 2023 ] Yutao Zhu, Huaying Yuan, Shuting Wang, Jiongnan Liu, Wenhan Liu, Chenlong Deng, Zhicheng Dou, and Ji-Rong Wen. Large language models for information retrieval: A survey. arXiv preprint arXiv:2308.07107, 2023.

[ Zhuang et al., 2023 ] Shengyao Zhuang, Bing Liu, Bevan Koopman, and Guido Zuccon. Open-source large language models are strong zero-shot query likelihood models for document ranking. arXiv preprint arXiv:2310.13243, 2023.
