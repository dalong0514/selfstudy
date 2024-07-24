## 2024038The-Llama-3-Herd-of-Models

Llama Team, AI @ Meta$^1$

$^1$A detailed contributor list can be found in the appendix of this paper.

Modern artificial intelligence (AI) systems are powered by foundation models. This paper presents a new set of foundation models, called Llama 3. It is a herd of language models that natively support multilinguality, coding, reasoning, and tool usage. Our largest model is a dense Transformer with 405B parameters and a context window of up to 128K tokens. This paper presents an extensive empirical evaluation of Llama 3. We find that Llama 3 delivers comparable quality to leading language models such as GPT-4 on a plethora of tasks. We publicly release Llama 3, including pre-trained and post-trained versions of the 405B parameter language model and our Llama Guard 3 model for input and output safety. The paper also presents the results of experiments in which we integrate image, video, and speech capabilities into Llama 3 via a compositional approach. We observe this approach performs competitively with the state-of-the-art on image, video, and speech recognition tasks. The resulting models are not yet being broadly released as they are still under development.

**Date:** July 23, 2024

**Website:** [https://llama.meta.com/](https://llama.meta.com/)

现代人工智能（AI）系统的核心是基础模型（Foundation Models）。本文介绍了一套新的基础模型，名为 Llama 3。这是一系列原生支持多语言、编程、推理和工具使用的语言模型。我们最大的模型是一个拥有 4050 亿参数和最多 128K tokens 上下文窗口的高密度 Transformer 模型。本文对 Llama 3 进行了广泛的实证评估。研究发现，Llama 3 在众多任务上的表现可与 GPT-4 等领先的语言模型相媲美。我们公开发布了 Llama 3，包括 4050 亿参数语言模型的预训练和后训练版本，以及用于确保输入输出安全的 Llama Guard 3 模型。本文还介绍了将图像、视频和语音功能整合到 Llama 3 中的实验结果，这些实验采用了模块化的方法。我们观察到，这种方法在图像、视频和语音识别任务上的表现可以与最先进的技术相媲美。由于这些模型仍在开发中，因此尚未广泛发布。

### 01 Introduction

Foundation models are general models of language, vision, speech, and/or other modalities that are designed to support a large variety of AI tasks. They form the basis of many modern AI systems.

The development of modern foundation models consists of two main stages: (1) a pre-training stage in which the model is trained at massive scale using straightforward tasks such as next-word prediction or captioning and (2) a post-training stage in which the model is tuned to follow instructions, align with human preferences, and improve specific capabilities (for example, coding and reasoning).

In this paper, we present a new set of foundation models for language, called Llama 3. The Llama 3 Herd of models natively supports multilinguality, coding, reasoning, and tool usage. Our largest model is dense Transformer with 405B parameters, processing information in a context window of up to 128K tokens. Each member of the herd is listed in Table 1. All the results presented in this paper are for the Llama 3.1 models, which we will refer to as Llama 3 throughout for brevity.

We believe there are three key levers in the development of high-quality foundation models: data, scale, and managing complexity. We seek to optimize for these three levers in our development process:

- **Data.** Compared to prior versions of Llama \[(Touvron et al., 2023a,b)\], we improved both the quantity and quality of the data we use for pre-training and post-training. These improvements include the development of more careful pre-processing and curation pipelines for pre-training data and the development of more rigorous quality assurance and filtering approaches for post-training data. We pre-train Llama 3 on a corpus of about 157 multilingual tokens, compared to 1.8T tokens for Llama 2.

- **Scale.** We train a model at far larger scale than previous Llama models: our flagship language model was pre-trained using 3.8 x $10^{25}$ FLOPs, almost 50× more than the largest version of Llama 2. Specifically, we pre-trained a flagship model with 405B trainable parameters on 15.6T text tokens. As expected per scaling laws for foundation models, our flagship model outperforms smaller models trained using the same procedure. While our scaling laws suggest our flagship model is an approximately compute-optimal size for our training budget, we also train our smaller models for much longer than is compute-optimal. The resulting models perform better than compute-optimal models at the same inference budget. We use the flagship model to further improve the quality of those smaller models during post-training.

- **Managing complexity.** We make design choices that seek to maximize our ability to scale the model development process. For example, we opt for a standard dense Transformer model architecture (Vaswani et al., 2017) with minor adaptations, rather than for a mixture-of-experts model (Shazeer et al., 2017) to maximize training stability. Similarly, we adopt a relatively simple post-training procedure based on supervised finetuning (SFT), rejection sampling (RS), and direct preference optimization (DPO; Rafailov et al. (2023)) as opposed to more complex reinforcement learning algorithms (Ouyang et al., 2022; Schulman et al., 2017) that tend to be less stable and harder to scale.

|                    | Finetuned | Multilingual | Long context | Tool use | Release     |
|--------------------|-----------|--------------|--------------|----------|-------------|
| Llama 3 8B         | ✗         | ✗¹           | ✗            | ✗        | April 2024  |
| Llama 3 8B Instruct| ✓         | ✗            | ✗            | ✗        | April 2024  |
| Llama 3 70B        | ✗         | ✗¹           | ✗            | ✗        | April 2024  |
| Llama 3 70B Instruct| ✓         | ✗            | ✗            | ✗        | April 2024  |
| Llama 3.1 8B       | ✓         | ✓            | ✓            | ✓        | July 2024   |
| Llama 3.1 8B Instruct| ✓         | ✓            | ✓            | ✓        | July 2024   |
| Llama 3.1 70B      | ✓         | ✓            | ✓            | ✓        | July 2024   |
| Llama 3.1 70B Instruct| ✓         | ✓            | ✓            | ✓        | July 2024   |
| Llama 3.1 405B     | ✓         | ✓            | ✓            | ✓        | July 2024   |
| Llama 3.1 405B Instruct| ✓         | ✓            | ✓            | ✓        | July 2024   |

Table 1 Overview of the Llama 3 Herd of models. All results in this paper are for the Llama 3.1 models.

The result of our work is Llama 3: a herd of three multilingual¹ language models with 8B, 70B, and 405B parameters. We evaluate the performance of Llama 3 on a plethora of benchmark datasets that span a wide range of language understanding tasks. In addition, we perform extensive human evaluations that compare Llama 3 with competing models. An overview of the performance of the flagship Llama 3 model on key benchmarks is presented in Table 2. Our experimental evaluation suggests that our flagship model performs on par with leading language models such as GPT-4 (OpenAI, 2023a) across a variety of tasks, and is close to matching the state-of-the-art. Our smaller models are best-in-class, outperforming alternative models with similar numbers of parameters (Bai et al., 2023; Jiang et al., 2023). Llama 3 also delivers a much better balance between helpfulness and harmlessness than its predecessor (Touvron et al., 2023b). We present a detailed analysis of the safety of Llama 3 in Section 5.4.

We are publicly releasing all three Llama 3 models under an updated version of the Llama 3 Community License; see https://llama.meta.com. This includes pre-trained and post-trained versions of our 405B parameter language model and a new version of our Llama Guard model (Inan et al., 2023) for input and output safety. We hope that the open release of a flagship model will spur a wave of innovation in the research community, and accelerate a responsible path towards the development of artificial general intelligence (AGI).

As part of the Llama 3 development process we also develop multimodal extensions to the models, enabling image recognition, video recognition, and speech understanding capabilities. These models are still under active development and not yet ready for release. In addition to our language modeling results, the paper presents results of our initial experiments with those multimodal models.

¹ The Llama 3 8B and 70B were pre-trained on multilingual data but were intended for use in English at the time.

01 引言

基础模型（Foundation Models）是为支持各种 AI 任务而设计的语言、视觉、语音和 / 或其他模态的通用模型。它们构成了许多现代 AI 系统的基础。

现代基础模型（foundation models）的开发主要包括两个阶段：(1）预训练（pre-training）阶段，在这个阶段中，模型使用简单直接的任务（如下一个词预测或图像描述）进行海量规模的训练；(2）后期训练（post-training）阶段，在这个阶段中，模型被调整以遵循指令、与人类偏好保持一致，并提高特定能力（例如，编码和推理）。

在本论文中，我们介绍了一组新的语言基础模型，称为 Llama 3。Llama 3 模型族（Herd）原生支持多语言、编码、推理和工具使用。我们最大的模型是一个拥有 4050 亿参数的密集 Transformer 网络，可以在最多 128K token 的上下文窗口（context window）中处理信息。模型族中的每个成员都列在表 1 中。本文中呈现的所有结果都是针对 Llama 3.1 模型的，为简便起见，我们在整篇文章中将其称为 Llama 3。

我们认为，在开发高质量基础模型时有三个关键因素：数据、规模和复杂性管理。我们在开发过程中寻求优化这三个因素：

**数据。** 与 Llama 的先前版本 [(Touvron et al.，2023a,b)] 相比，我们在预训练和微调阶段都显著提升了数据的数量和质量。这些改进包括为预训练数据开发更为严谨的预处理和数据整理流程，同时为微调数据制定了更加严格的质量保证和筛选方法。Llama 3 的预训练语料库包含约 157 万亿个多语言标记（token），相较于 Llama 2 使用的 1.8 万亿个标记，规模有了显著提升。

**规模。** 我们这次训练的模型规模远超以往的 Llama 模型：我们的旗舰语言模型在预训练阶段使用了 3.8 x $10^{25}$ 次浮点运算（FLOPs），几乎是 Llama 2 最大版本的 50 倍。具体来说，我们预训练了一个拥有 4050 亿个可训练参数的旗舰模型，使用了 15.6 万亿个文本标记。正如基础模型的缩放定律所预测的那样，我们的旗舰模型的性能优于使用相同方法训练的较小模型。虽然根据我们的缩放定律，旗舰模型的规模对于我们的训练预算来说已接近计算效率的最优点，但我们仍然大幅延长了较小模型的训练时间，远超计算效率最优的时长。这样做的结果是，在相同的推理预算下，这些模型的表现优于计算效率最优的模型。在微调阶段，我们还利用旗舰模型来进一步提升这些较小模型的质量。

**简化复杂性管理。** 我们在设计时致力于最大化模型开发过程的可扩展性。例如，为了提高训练的稳定性，我们选择了标准的密集 Transformer（变换器）模型架构（Vaswani et al.，2017），并对其进行了微小调整，而非采用混合专家模型（mixture-of-experts model）(Shazeer et al.，2017）。同样，我们采用了相对简单的训练后处理方法，包括监督微调（Supervised Fine-Tuning，SFT)、拒绝采样（Rejection Sampling，RS）和直接偏好优化（Direct Preference Optimization，DPO; Rafailov et al.（2023)），而不是使用更复杂的强化学习算法（Ouyang et al.，2022; Schulman et al.，2017）。这是因为强化学习算法通常不太稳定，且更难以扩展。

表 1：Llama 3 模型族概览。本文中的所有结果均基于 Llama 3.1 模型。

我们的研究成果是 Llama 3：一个由三个多语言 ¹ 大语言模型（Large Language Model）组成的系列，这些模型分别拥有 80 亿、700 亿和 4050 亿个参数。为了评估 Llama 3 的性能，我们使用了涵盖广泛语言理解任务的众多基准测试数据集。不仅如此，我们还进行了大规模的人工评估，将 Llama 3 与其他竞争模型进行了比较。表 2 展示了 Llama 3 系列中最强大模型在关键基准测试上的表现概览。

我们的实验结果表明，我们的顶级模型在各种任务中的表现可以与 GPT-4（OpenAI，2023a）等领先的语言模型相媲美，几乎达到了当前的最高水平。而我们的较小规模模型在同等参数量的模型中表现最为出色，超越了其他类似规模的模型（Bai et al.，2023; Jiang et al.，2023）。与此同时，相比于其前代产品，Llama 3 在实用性和安全性之间取得了更好的平衡（Touvron et al.，2023b）。关于 Llama 3 的安全性，我们在第 5.4 节中进行了详细的分析。

### 02 General Overview

The model architecture of Llama 3 is illustrated in Figure 1. The development of our Llama 3 language models comprises two main stages:

- **Language model pre-training.** We start by converting a large, multilingual text corpus to discrete tokens and pre-training a large language model (LLM) on the resulting data to perform next-token prediction. In the language model pre-training stage, the model learns the structure of language and obtains large amounts of knowledge about the world from the text it is “reading”. To do this effectively, pre-training is performed at massive scale: we pre-train a model with 405B parameters on 15.6T tokens using a context window of 8K tokens. This standard pre-training stage is followed by a continued pre-training stage that increases the supported context window to 128K tokens. See Section 3 for details.

- **Language model post-training.** The pre-trained language model has a rich understanding of language but it does not yet follow instructions or behave in the way we would expect an assistant to. We align the model with human feedback in several rounds, each of which involves supervised finetuning (SFT) on instruction tuning data and Direct Preference Optimization (DPO; Rafailov et al., 2024). At this post-training stage, we also integrate new capabilities, such as tool-use, and observe strong improvements in other areas, such as coding and reasoning. See Section 4 for details. Finally, safety mitigations are also incorporated into the model at the post-training stage, the details of which are described in Section 5.4.

The resulting models have a rich set of capabilities. They can answer questions in at least eight languages, write high-quality code, solve complex reasoning problems, and use tools out-of-the-box or in a zero-shot way.

We also perform experiments in which we add image, video, and speech capabilities to Llama 3 using a compositional approach. The approach we study comprises the three additional stages illustrated in Figure 28:

- **Multi-modal encoder pre-training.** We train separate encoders for images and speech. We train our image encoder on large amounts of image-text pairs. This teaches the model the relation between visual content and the description of that content in natural language. Our speech encoder is trained using a self-supervised approach that masks out parts of the speech inputs and tries to reconstruct the masked output parts via a discrete-token representation. As a result, the model learns the structure of speech signals. See Section 7 for details on the image encoder and Section 8 for details on the speech encoder.

Figure 1  Illustration of the overall architecture and training of Llama 3. Llama 3 is a Transformer language model trained to predict the next token of a textual sequence. See text for details.

- Vision adapter training. We train an adapter that integrates the pre-trained image encoder into the pre-trained language model. The adapter consists of a series of cross-attention layers that feed image-encoder representations into the language model. The adapter is trained on text-image pairs. This aligns the image representations with the language representations. During adapter training, we also update the parameters of the image encoder but we intentionally do not update the language-model parameters. We also train a video adapter on top of the image adapter on paired video-text data. This enables the model to aggregate information across frames. See Section 7 for details.
  
- Speech adapter training. Finally, we integrate the speech encoder into the model via an adapter that converts speech encodings into text representations that can be fed directly into the finetuned language model. The parameters of the adapter and encoder are jointly updated in a supervised finetuning stage to enable high-quality speech understanding. We do not change the language model during speech adapter training. We also integrate a text-to-speech system. See Section 8 for details.

Our multimodal experiments lead to models that can recognize the content of images and videos, and support interaction via a speech interface. These models are still under development and not yet ready for release.

**语言模型预训练。** 我们首先将大规模的多语言文本数据转换为离散的标记（token），然后在这些数据上预训练一个大语言模型（Large Language Model，LLM），使其能够预测序列中的下一个单词或片段。在预训练阶段，模型不仅学习语言的结构，还从「阅读」的文本中获取大量关于世界的知识。为了达到最佳效果，我们进行了超大规模的预训练：使用一个包含 405B（4050 亿）参数的模型，在 15.6T（15.6 万亿）个标记上进行训练，每次处理 8K（8000）个标记的上下文信息。在这个标准预训练阶段之后，我们还进行了持续预训练，将模型能够处理的上下文信息量提升到 128K（12.8 万）个标记。详细内容请参见第 3 节。

**语言模型后训练。** 预训练后的语言模型虽然对语言有了深刻的理解，但还不能按照指令行事，也不能像我们期望的助手那样工作。因此，我们通过多轮人类反馈来调整模型，每一轮都包括对指令数据集进行监督式微调（Supervised Fine-tuning，SFT）和直接偏好优化（Direct Preference Optimization，DPO；参见 Rafailov 等人 2024 年的研究）。在这个后训练阶段，我们还为模型增加了新的功能，比如使用外部工具的能力，同时我们也观察到模型在编程和逻辑推理等其他方面有了显著提升。详细内容请参见第 4 节。最后，我们还在后训练阶段加入了一些安全防护措施，以降低模型可能带来的风险，这部分内容将在第 5.4 节详细介绍。

这些模型展现出了多方面的卓越能力。它们不仅能够用至少八种语言回答问题，还能编写高质量的代码，解决复杂的推理问题，并且能够直接使用各种工具，甚至在没有经过专门训练的情况下也能应用自如。

我们还进行了一系列实验，旨在通过一种模块化的方法为 Llama 3 增添处理图像、视频和语音的能力。我们研究的这种方法包括如图所示的三个额外阶段：

**多模态编码器预训练（Multi-modal encoder pre-training）。** 我们为图像和语音分别训练了独立的编码器。图像编码器的训练使用了大量的图像-文本对，这使得模型能够学习视觉内容与其自然语言描述之间的关系。语音编码器则采用了一种自监督学习的方法进行训练：它会遮蔽部分语音输入，然后尝试通过一种离散化的表示方式来重建这些被遮蔽的部分。通过这个过程，模型逐步掌握了语音信号的结构。关于图像编码器的详细信息可以参考第 7 节，而语音编码器的细节则在第 8 节中有所描述。

图 1：Llama 3 的整体架构和训练流程示意图。Llama 3 本质上是一个 Transformer 语言模型，它的主要任务是预测文本序列中的下一个 token。图中展示了模型的基本结构和训练过程，具体细节请参考正文描述。

视觉适配器的训练过程。我们训练了一个适配器，用于将预先训练好的图像编码器整合到预训练的语言模型中。这个适配器由一系列交叉注意力层（cross-attention layers）组成，它们的作用是将图像编码器的表示输入到语言模型中。适配器在成对的文本和图像数据上进行训练，目的是让图像表示与语言表示相互对齐。在训练适配器的过程中，我们会更新图像编码器的参数，但有意保持语言模型的参数不变。此外，我们还在图像适配器的基础上，使用配对的视频和文本数据训练了一个视频适配器。这使得模型能够整合和理解视频中多个帧之间的信息。详细内容请参见第 7 节。

语音适配器的训练过程。最后，我们通过一个适配器将语音编码器整合到模型中。这个适配器的作用是将语音编码转换为文本表示，然后直接输入到经过微调的语言模型中。在有监督的微调阶段，适配器和编码器的参数会一起更新，以实现高质量的语音理解。在训练语音适配器的过程中，我们不会改变语言模型的参数。我们还集成了一个文字转语音系统。详细内容请参见第 8 节。

通过这些多模态实验，我们开发出了能够识别图像和视频内容，并支持语音交互界面的模型。不过，这些模型目前还处于开发阶段，尚未准备好对外发布。

### 03 Pre-Training

Language model pre-training involves: (1) the curation and filtering of a large-scale training corpus, (2) the development of a model architecture and corresponding scaling laws for determining model size, (3) the development of techniques for efficient pre-training at large scale, and (4) the development of a pre-training recipe. We present each of these components separately below.

#### 3.1 Pre-Training Data

We create our dataset for language model pre-training from a variety of data sources containing knowledge until the end of 2023. We apply several de-duplication methods and data cleaning mechanisms on each data source to obtain high-quality tokens. We remove domains that contain large amounts of personally identifiable information (PII), and domains with known adult content.

##### 3.1.1 Web Data Curation

Much of the data we utilize is obtained from the web and we describe our cleaning process below.

**PII and safety filtering.** Among other mitigations, we implement filters designed to remove data from websites that are likely to contain unsafe content or high volumes of PII, domains that have been ranked as harmful according to a variety of Meta safety standards, and domains that are known to contain adult content.

**Text extraction and cleaning**

We process the raw HTML content for non-truncated web documents to extract high-quality diverse text. To do so, we build a custom parser that extracts the HTML content and optimizes for precision in boilerplate removal and content recall. We evaluate our parser's quality in human evaluations, comparing it with popular third-party HTML parsers that optimize for article-like content, and found it to perform favorably. We carefully process HTML pages with mathematics and code content to preserve the structure of that content. We maintain the image alt attribute text since mathematical content is often represented as pre-rendered images where the math is also provided in the alt attribute. We experimentally evaluate different cleaning configurations. We find markdown is harmful to the performance of a model that is primarily trained on web data compared to plain text, so we remove all markdown markers.

**De-duplication**

We apply several rounds of de-duplication at the URL, document, and line level:

- **URL-level de-duplication.** We perform URL-level de-duplication across the entire dataset. We keep the most recent version for pages corresponding to each URL.

- **Document-level de-duplication.** We perform global MinHash (Broder, 1997) de-duplication across the entire dataset to remove near duplicate documents.

- **Line-level de-duplication.** We perform aggressive line-level de-duplication similar to ccNet (Wenzek et al., 2019). We remove lines that appeared more than 6 times in each bucket of 30M documents. Although our manual qualitative analysis showed that the line-level de-duplication removes not only leftover boilerplate from various websites such as navigation menus, cookie warnings, but also frequent high-quality text, our empirical evaluations showed strong improvements.

**Heuristic filtering**

We develop heuristics to remove additional low-quality documents, outliers, and documents with excessive repetitions. Some examples of heuristics include:

- We use duplicated n-gram coverage ratio (Rae et al., 2021) to remove lines that consist of repeated content such as loggin or error messages. Those lines could be very long and unique, hence cannot be detected by line dedup.

- We use "dirty word" counting (Raffel et al., 2020) to filter out adult websites that are not covered by common block lists.

- We use a token-distribution Kullback-Leibler divergence to filter out documents containing excessive numbers of outlier tokens compared to the training corpus distribution.

**Model-based quality filtering**

Further, we experiment with applying various model-based quality classifiers to sub-select high-quality tokens. These include using fast classifiers such as fasttext (Joulin et al., 2017) trained to recognize if a given text would be referenced by Wikipedia (Touvron et al., 2023a), as well as more compute-intensive Roberta-based classifiers (Liu et al., 2019a) trained on Llama 2 predictions. To train a quality classifier based on Llama 2, we create a training set of cleaned web documents, describe the quality requirements, and instruct Llama 2's chat model to determine if the documents meets these requirements. We use DistilRoberta (Sanh et al., 2019) to generate quality scores for each document for efficiency reasons. We experimentally evaluate the efficacy of various quality filtering configurations.

**Code and reasoning data**

Similar to DeepSeek-AI et al. (2024), we build domain-specific pipelines that extract code and math-relevant web pages. Specifically, both the code and reasoning classifiers are DistilledRoberta models trained on web data annotated by Llama 2. Unlike the general quality classifier mentioned above, we conduct prompt tuning to target web pages containing math deduction, reasoning in STEM areas and code interleaved with natural language. Since the token distribution of code and math is substantially different than that of natural language, these pipelines implement domain-specific HTML extraction, customized text features and heuristics for filtering.

**Multilingual data**

Similar to our processing pipelines for English described above, we implement filters to remove data from websites that are likely to contain PII or unsafe content. Our multilingual text processing pipeline has several unique features:

- We use a fasttext-based language identification model to categorize documents into 176 languages.

- We perform document-level and line-level de-duplication within data for each language.


- We apply language-specific heuristics and model-based filters to remove low-quality documents.

In addition, we perform quality ranking of multilingual documents using a multilingual Llama 2-based classifier to ensure that high-quality content is prioritized. We determine the amount of multilingual tokens used in pre-training experimentally, balancing model performance on English and multilingual benchmarks.

##### 3.1.2 Determining the Data Mix

To obtain a high-quality language model, it is essential to carefully determine the proportion of different data sources in the pre-training data mix. Our main tools in determining this data mix are knowledge classification and scaling law experiments.

**Knowledge classification.** We develop a classifier to categorize the types of information contained in our web data to more effectively determine a data mix. We use this classifier to downsample data categories that are over-represented on the web, for example, arts and entertainment.

**Scaling laws for data mix.** To determine the best data mix, we perform scaling law experiments in which we train several small models on a data mix and use that to predict the performance of a large model on that mix (see Section 3.2.1). We repeat this process multiple times for different data mixes to select a new data mix candidate. Subsequently, we train a larger model on this candidate data mix and evaluate the performance of that model on several key benchmarks.

**Data mix summary.** Our final data mix contains roughly 50% of tokens corresponding to general knowledge, 25% of mathematical and reasoning tokens, 17% code tokens, and 8% multilingual tokens.

##### 3.1.3 Annealing Data

Empirically, we find that annealing (see Section 3.4.3) on small amounts of high-quality code and mathematical data can boost the performance of pre-trained models on key benchmarks. Akin to Li et al. (2024b), we perform annealing with a data mix that upsamples high-quality data in select domains. We do not include any training sets from commonly used benchmarks in our annealing data. This enables us to assess the true few-shot learning capabilities and out-of-domain generalization of Llama 3.

Following OpenAI (2023a), we evaluate the efficacy of annealing on the GSM8k (Cobbe et al., 2021) and MATH (Hendrycks et al., 2021b) training sets in annealing. We find that annealing improved the performance of a pre-trained Llama 3 8B model on the GSM8k and MATH validation sets by 24.0% and 4.6%, respectively. However, the improvements on the 405B model are negligible, suggesting that our flagship model has strong in-context learning and reasoning capabilities and does not require specific in-domain training samples to attain strong performance.

**Using annealing to assess data quality.** Similar to Blakeney et al. (2024), we find that annealing enables us to judge the value of small domain-specific datasets. We measure the value of such datasets by annealing the learning rate of a 50% trained Llama 3 8B model linearly to 0 on 40B tokens. In those experiments, we assign 30% weight to the new dataset and the remaining 70% weight to the default data mix. Using annealing to evaluate new data sources is more efficient than performing scaling law experiments for every small dataset.

#### 3.2 Model Architecture

Llama 3 uses a standard, dense Transformer architecture (Vaswani et al., 2017). It does not deviate significantly from Llama and Llama 2 (Touvron et al., 2023a,b) in terms of model architecture; our performance gains are primarily driven by improvements in data quality and diversity as well as by increased training scale.

We do make a few smaller modifications compared to Llama 3:

- We use grouped query attention (GQA; Ainslie et al. (2023)) with 8 key-value heads to improve inference speed and to reduce the size of key-value caches during decoding.

- We use an attention mask that prevents self-attention between different documents within the same sequence. We find that this change had limited impact during standard pre-training, but find it to be important in continued pre-training on very long sequences.

|      | 8B           | 70B           | 405B           |
|------|--------------|---------------|----------------|
| Layers               | 32            | 80             | 126            |
| Model Dimension      | 4,096         | 8192           | 16,384         |
| FFN Dimension        | 6,144         | 12,288         | 20,480         |
| Attention Heads      | 32            | 64             | 128            |
| Key/Value Heads      | 8             | 8              | 8              |
| Peak Learning Rate   | $3 \times 10^{-4}$ | $1.5 \times 10^{-4}$ | $8 \times 10^{-5}$ |
| Activation Function  | SwiGLU        | SwiGLU         | SwiGLU         |
| Vocabulary Size      | 128,000       | 128,000        | 128,000        |
| Positional Embeddings | RoPE ($\theta = 500, 000$) | RoPE ($\theta = 500, 000$) | RoPE ($\theta = 500, 000$) |

Table 3: Overview of the key hyperparameters of Llama 3. We display settings for 8B, 70B, and 405B language models.

- We use a vocabulary with 128K tokens. Our token vocabulary combines 100K tokens from the titoktoten tokenizer with 28K additional tokens to better support non-English languages. Compared to the Llama 2 tokenizer, our new tokenizer improves compression rates on a sample of English data from 3.17 to 3.94 characters per token. This enables the model to “read” more text for the same amount of training compute. We also found that adding 28K tokens from select non-English languages improved both compression ratios and downstream performance, with no impact on English tokenization.

- We increase the RoPE base frequency hyperparameter to 500,000. This enables us to better support longer contexts; Xiong et al. (2023) showed this value to be effective for context lengths up to 32,768.

Llama 3 405B uses an architecture with 126 layers, a token representation dimension of 16,384, and 128 attention heads; see Table 3 for details. This leads to a model size that is approximately compute-optimal according to scaling laws on our data for our training budget of $3.8 \times 10^{25}$ FLOPs.

##### 3.2.1 Scaling Laws

We develop scaling laws (Hoffmann et al., 2022; Kaplan et al., 2020) to determine the optimal model size for our flagship model given our pre-training compute budget. In addition to determining the optimal model size, a major challenge is to forecast the flagship model’s performance on downstream benchmark tasks, due to a couple of issues: (1) Existing scaling laws typically predict only next-token prediction loss rather than specific benchmark performance. (2) Scaling laws can be noisy and unreliable because they are developed based on pre-training runs conducted with small compute budgets (Wei et al., 2022b).

To address these challenges, we implement a two-stage methodology to develop scaling laws that accurately predict downstream benchmark performance:
1. We first establish a correlation between the compute-optimal model’s negative log-likelihood on downstream tasks and the training FLOPs.
2. Next, we correlate the negative log-likelihood on downstream tasks with task accuracy, utilizing both the scaling law models and older models trained with higher compute FLOPs. In this step, we specifically leverage the Llama 2 family of models.

This approach enables us to predict downstream task performance given a specific number of training FLOPs for compute-optimal models. We use a similar method to select our pre-training data mix (see Section 3.4).

**Scaling law experiments.**

Concretely, we construct our scaling laws by pre-training models using compute budgets between $6 \times 10^{18}$ FLOPs and $10^{22}$ FLOPs. At each compute budget, we pre-train models ranging in size between 40M and 16B parameters, using a subset of model sizes at each compute budget. In these training runs, we use a cosine learning rate schedule with a linear warmup for 2,000 training steps. The peak learning rate is set between $2 \times 10^{-4}$ and $4 \times 10^{-4}$ depending on the size of the model. We set the cosine decay to 0.1 of the peak value. The weight decay at each step is set to 0.1 times the learning rate at that step. We use a fixed batch size for each compute scale, ranging between 250K and 4M.

Figure 2 Scaling law IsoFLOPs curves between $6 \times 10^{18}$ and $10^{22}$ FLOPs. The loss is the negative log-likelihood on a held-out validation set. We approximate measurements at each compute scale using a second degree polynomial.

Figure 3 Number of training tokens in identified compute-optimal models as a function of pre-training compute budget. We include the fitted scaling-law prediction as well. The compute-optimal models correspond to the parabola minimums in Figure 2.

These experiments give rise to the IsoFLOPs curves in Figure 2. The loss in these curves is measured on a separate validation set. We fit the measured loss values using a second-degree polynomial and identify the minimums of each parabola. We refer to minimum of a parabola as the compute-optimal model at the corresponding pre-training compute budget.

We use the compute-optimal models we identified this way to predict the optimal number of training tokens for a specific compute budget. To do so, we assume a power-law relation between compute budget, C, and the optimal number of training tokens, $N^{*}(C)$ :

$$N^{*}(C) = AC^{\alpha}.$$

We fit $\alpha$ and A using the data from Figure 2. We find that ($\alpha$, A) = (0.53, 0.29); the corresponding fit is shown in Figure 3. Extrapolation of the resulting scaling law to $3.8 \times 10^{25}$ FLOPs suggests training a 402B parameter model on 16.55T tokens.

An important observation is that IsoFLOPs curves become flatter around the minimum as the compute budget increases. This implies that performance of the flagship model is relatively robust to small changes in the trade-off between model size and training tokens. Based on this observation, we ultimately decided to train a flagship model with 405B parameters.

Predicting performance on downstream tasks. We use the resulting compute-optimal models to forecast the performance of the flagship Llama 3 model on benchmark data sets. First, we linearly correlate the (normalized) negative log-likelihood of correct answer in the benchmark and the training FLOPs. In this analysis, we use only the scaling law models trained up to $10^{22}$ FLOPs on the data mix described above. Next, we establish a sigmoidal relation between the log-likelihood and accuracy using both the scaling law models and Llama 2 models, which were trained using the Llama 2 data mix and tokenizer. We show the results of this experiment on the ARC Challenge benchmark in Figure 4. We find this two-step scaling law prediction, which extrapolates over four orders of magnitude, to be quite accurate: it only slightly underestimates the final performance of the flagship Llama 3 model.

#### 3.3 Infrastructure, Scaling, and Efficiency

We describe our hardware and infrastructure that powered Llama 3 405B pre-training at scale and discuss several optimizations that lead to improvements in training efficiency.

##### 3.3.1 Training Infrastructure

The Llama 1 and 2 models were trained on Meta’s AI Research SuperCluster [(Lee and Sengupta, 2022)](https://scholar.google.com/scholar?q=Lee%20and%20Sengupta%2C%202022). As we scaled further, the training for Llama 3 was migrated to Meta’s production clusters [(Lee et al., 2024)](https://scholar.google.com/scholar?q=Lee%20et%20al.%2C%202024). This setup optimizes for production-grade reliability, which is essential as we scale up training.

Figure 4 Scaling law forecast for ARC Challenge. **Left**: Normalized negative log-likelihood of the correct answer on the ARC Challenge benchmark as a function of pre-training FLOPs. **Right**: ARC Challenge benchmark accuracy as a function of the normalized negative log-likelihood of the correct answer. This analysis enables us to predict model performance on the ARC Challenge benchmark before pre-training commences. See text for details.

**Compute**. Llama 3 405B is trained on up to 16K H100 GPUs, each running at 700W TDP with 80GB HBM3, using Meta’s Grand Teton AI server platform ([Matt Bowman, 2022](#)). Each server is equipped with eight GPUs and two CPUs. Within a server, the eight GPUs are connected via NVLink. Training jobs are scheduled using MAST ([Choudhury et al., 2024](#)), Meta’s global-scale training scheduler.

**Storage**. Tectonic ([Pan et al., 2021](#)), Meta’s general-purpose distributed file system, is used to build a storage fabric ([Battey and Gupta, 2024](#)) for Llama 3 pre-training. It offers 240 PB of storage out of 7,500 servers equipped with SSDs, and supports a sustainable throughput of 2 TB/s and a peak throughput of 7 TB/s. A major challenge is supporting the highly bursty checkpoint writes that saturate the storage fabric for short durations. Checkpointing saves each GPU’s model state, ranging from 1 MB to 4 GB per GPU, for recovery and debugging. We aim to minimize GPU pause time during checkpointing and increase checkpoint frequency to reduce the amount of lost work after a recovery.

**Network**. Llama 3 405B used RDMA over Converged Ethernet (RoCE) fabric based on the Arista 7800 and Minipack2 Open Compute Project[^4] OCP rack switches. Smaller models in the Llama 3 family were trained using Nvidia Quantum2 InfiniBand fabric. Both RoCE and InfiniBand clusters leverage 400 Gbps interconnects between GPUs. Despite the underlying network technology differences between these clusters, we tune both of them to provide equivalent performance for these large training workloads. We elaborate further on our RoCE network since we fully own its design.

- **Network topology**. Our RoCE-based AI cluster comprises 24K GPUs[^5] connected by a three-layer Clos network ([Lee et al., 2024](#)). At the bottom layer, each rack hosts 16 GPUs split between two servers and connected by a single Minipack2 top-of-the-rack (ToR) switch. In the middle layer, 192 such racks are connected by Cluster Switches to form a pod of 3,072 GPUs with full bisection bandwidth, ensuring no oversubscription. At the top layer, eight such pods within the same datacenter building are connected via Aggregation Switches to form a cluster of 24K GPUs. However, network connectivity at the aggregation layer does not maintain full bisection bandwidth and instead has an oversubscription ratio of 1:7. Our model parallelism methods (see Section 3.3.2) and training job scheduler ([Choudhury et al., 2024](#)) are all optimized to be aware of network topology, aiming to minimize network communication across pods.

- **Load balancing**. LLM training produces fat network flows that are hard to load balance across all available network paths using traditional methods such as Equal-Cost Multi-Path (ECMP) routing. To address this challenge, we employ two techniques. First, our collective library creates 16 network flows between two GPUs, instead of just one, thereby reducing the traffic per flow and producing more flows.

[^4]: Open Compute Project: <https://www.opencompute.org/>
[^5]: Note that we use only up to 16K of these 24K GPUs for Llama 3 pre-training.

| PP      | DP | Seq. Len. | Batch size/DP | Tokens/Batch | TFLOPs/GPU | BF16 MFU |
|---------|----|-----------|---------------|--------------|------------|----------|
| 8,192   | 8  | 1         | 16            | 64           | 8,192      | 32       | 16M    | 430        | 43%      |
| 16,384  | 8  | 1         | 16            | 128          | 8,192      | 16       | 16M    | 400        | 41%      |
| 16,384  | 8  | 16        | 16            | 1461         | 131,072    | 16       | 16M    | 380        | 38%      |

Table 4 Scaling configurations and MFU for each stage of Llama 3 405B pre-training. See text and Figure 5 for descriptions of each type of parallelism.

for load balancing. Second, our Enhanced-ECMP (E-ECMP) protocol effectively balances these 16 flows across different network paths by hashing on additional fields in the RoCE header of packets.

- **Congestion control.** We use deep-buffer switches in the spine (Gangidi et al., 2024) to accommodate transient congestion and buffering caused by collective communication patterns. This setup helps limit the impact of persistent congestion and network back pressure caused by slow servers, which is common in training. Finally, better load balancing through E-ECMP significantly reduces the chance of congestion. With these optimizations, we successfully run a 24K GPU cluster without traditional congestion control methods such as Data Center Quantized Congestion Notification (DCQCN).

#### 3.3.2 Parallelism for Model Scaling

To scale training for our largest models, we use 4D parallelism—a combination of four different types of parallelism methods—to shared the model. This approach efficiently distributes computation across many GPUs and ensures each GPU’s model parameters, optimizer states, gradients, and activations fit in its HBM. Our implementation of 4D parallelism is illustrated in Figure 5. It combines tensor parallelism (TP; Krizhevsky et al. (2012); Shoeybi et al. (2019); Korthikanti et al. (2023)), pipeline parallelism (PP; Huang et al. (2019); Narayanan et al. (2021); Lamy-Poirier (2023)), context parallelism (CP; Liu et al. (2023a)), and data parallelism (DP; Rajbhandari et al. (2020); Ren et al. (2021); Zhao et al. (2023b)).

Tensor parallelism splits individual weight tensors into multiple chunks on different devices. Pipeline parallelism partitions the model vertically into stages by layers, so that different devices can process in parallel different stages of the full model pipeline. Context parallelism divides the input context into segments, reducing memory bottleneck for very long sequence length inputs. We use fully shared data parallelism (FSDP; Rajbhandari et al. (2020); Ren et al., 2021; Zhao et al., 2023b), which shards the model, optimizer, and gradients when implementing data parallelism which processes data in parallel on multiple GPUs and synchronizes after each training step. Our use of FSDP for Llama 3 shards optimizer states and gradients, but for model shards we do not reshard after forward computation to avoid an extra all-gather communication during backward passes.

**GPU utilization.** Through careful tuning of the parallelism configuration, hardware, and software, we achieve an overall BF16 Model FLOPs Utilization (MFU; Chowdhery et al. (2023)) of 38-43% for the configurations shown in Table 4. The slight drop in MFU to 41% on 16K GPUs with DP=128 compared to 43% on 8K GPUs with DP=64 is due to the lower batch size per DP group needed to keep the global tokens per batch constant during training.

**Pipeline parallelism improvements.**

We encountered several challenges with existing implementations:

- **Batch size constraint.** Current implementations have constraints on supported batch size per GPU, requiring it to be divisible by the number of pipeline stages. For the example in Figure 6, the depth-first schedule (DFS) of pipeline parallelism (Narayanan et al., 2021) requires N = PP ≠ 4, while the breadth-first schedule (BFS; Lamy-Poirier (2023)) requires N = M, where M is the total number of micro-batches and N is the number of contiguous micro-batches for the same stage’s forward or backward. However, pre-training often needs flexibility to adjust batch size.

- **Memory imbalance.** Existing pipeline parallelism implementations lead to imbalanced resource consumption. The first stage consumes more memory due to the embedding and the warm-up micro-batches.

- **Computation imbalance.** After the last layer of the model, we need to calculate output and loss, making this stage the execution latency bottleneck.

Figure 5 Illustration of 4D parallelism. GPUs are divided into parallelism groups in the order of \[TP, CP, PP, DP\], where DP stands for FSDP. In this example, 16 GPUs are configured with a group size of \[TP\]=2, \[CP\]=2, \[PP\]=2, and \[DP\]=2. A GPU’s position in 4D parallelism is represented as a vector, \[D1, D2, D3, D4\], where Di is the index on the i-th parallelism dimension. In this example, GPU0\[TP0, CP0, PP0, DP0\] and GPU1\[TP1, CP0, PP0, DP0\] are in the same TP group, GPU0 and GPU2 are in the same CP group, GPU0 and GPU4 are in the same PP group, and GPU0 and GPU8 are in the same DP group.

To address these issues, we modify our pipeline schedule as shown in Figure 6, which allows setting N flexibly---in this case N = 5, which can run an arbitrary number of micro-batches in each batch. This allows us to run: (1) fewer micro-batches than the number of stages when we have batch size limit at large scale; or (2) more micro-batches to hide point-to-point communication, finding a sweet spot between DFS and breadth first schedule (BFS) for the best communication and memory efficiency. To balance the pipeline, we reduce one Transformer layer each from the first and the last stages, respectively. This means that the first model chunk on the first stage has only the embedding, and the last model chunk on the last stage has only output projection and loss calculation. To reduce pipeline bubbles, we use an interleaved schedule (Narayanan et al., 2021) with V pipeline stages on one pipeline rank. Overall pipeline bubble ratio is $p=\frac{PP-1}{N}$ . Further, we adopt asynchronous point-to-point communication in PP, which considerably speeds up training, especially in cases when the document mask introduces extra computation imbalance. We enable TORCH_NCCL_AVOID_RECORD_STREAMS to reduce memory usage from asynchronous point-to-point communication. Finally, to reduce memory cost, based on detailed memory allocation profiling, we proactively deallocate tensors that will not be used for future computation, including the input and output tensors of each pipeline stage, that will not be used for future computation. With these optimizations, we could pre-train Llama 3 on sequences of 8K tokens without activation checkpointing.

**Context parallelism for long sequences.**

We utilize context parallelism (CP) to improve memory efficiency when scaling the context length of Llama 3 and enable training on extremely long sequences up to 128K in length. In CP, we partition across the sequence dimension, and specifically we partition the input sequence into 2 × CP chunks so each CP rank receives two chunks for better load balancing. The i-th CP rank received both the i-th and the (2 × CP − 1 − i)-th chunks.

Different from existing CP implementations that overlap communication and computation in a ring-like structure (Liu et al., 2023a), our CP implementation adopts an all-gather based method where we first all-gather the key (K) and value (V) tensors, and then compute attention output for the local query (Q) tensor chunk. Although the all-gather communication latency is exposed in the critical path, we still adopt this approach for two main reasons: (1) it is easier and more flexible to support different types of attention masks in all-gather based CP attention, such as the document mask; and (2) the exposed all-gather latency is small as the communicated K and V tensors are much smaller than Q tensor due to the use of GQA (Ainslie et al., 2023). Hence, the time complexity of attention computation is an order of magnitude larger than all-gather ($O(S^2)$ versus $O(S)$, where $S$ represents the sequence length in the full causal mask), making the all-gather overhead negligible. 

Figure 6 Illustration of pipeline parallelism in Llama 3. Pipeline parallelism partitions eight pipeline stages (0 to 7) across four pipeline ranks (PP ranks 0 to 3), where the GPUs with rank 0 run stages 0 and 4, the GPUs with P rank 1 run stages 1 and 5, etc. The colored blocks (0 to 9) represent a sequence of micro-batches, where M is the total number of micro-batches and N is the number of continuous micro-batches for the same stage's forward or backward. Our key insight is to make N tunable.

Network-aware parallelism configuration. The order of parallelism dimensions, [TP, CP, PP, DP], is optimized for network communication. The innermost parallelism requires the highest network bandwidth and lowest latency, and hence is usually constrained to within the same server. The outermost parallelism may spread across a multi-hop network and should tolerate higher network latency. Therefore, based on the requirements for network bandwidth and latency, we place parallelism dimensions in the order of [TP, CP, PP, DP]. DP (i.e., FSDP) is the outermost parallelism because it can tolerate longer network latency by asynchronously prefetching shared model weights and reducing gradients. Identifying the optimal parallelism configuration with minimal communication overhead while avoiding GPU memory overflow is challenging. We develop a memory consumption estimator and a performance-projection tool which helped us explore various parallelism configurations and project overall training performance and identify memory gaps effectively.

Numerical stability. By comparing training loss between different parallelism setups, we fixed several numerical issues that impact training stability. To ensure training convergence, we use FP32 gradients accumulation during backward computation over multiple micro-batches and also reduce-scatter gradients in FP32 across data parallel workers in FSDP. For intermediate tensors, e.g., vision encoder outputs, that are used multiple times in the forward computation, the backward gradients are also accumulated in FP32.

#### 3.3.3 Collective Communication

Our collective communication library for Llama 3 is based on a fork of Nvidia’s NCCL library, called NCCLX. NCCLX significantly improves the performance of NCCL, especially for higher latency networks. Recall that the order of parallelism dimensions is [TP, CP, PP, DP], where DP corresponds to FSDP. The outermost parallelism dimensions, PP and DP, may communicate through a multi-hop network, with latency up to tens of microseconds. The original NCCL collectives—all-gather and reduce-scatter in FSDP, and point-to-point in PP—require data chunking and staged data copy. This approach incurs several inefficiencies, including (1) requiring a large number of small control messages to be exchanged over the network to facilitate data transfer, (2) extra memory-copy operations, and (3) using extra GPU cycles for communication. For Llama 3 training, we address a subset of these inefficiencies by tuning chunking and data transfer to fit our network latencies, which can be as high as tens of microseconds for a large cluster. We also allow small control messages to traverse our network at a higher priority, especially avoiding being head-of-line blocked in deep-buffer core switches. Our ongoing work for future Llama versions involves making deeper changes in NCCLX to holistically address all the aforementioned problems.

| Component                          | Category       | Interruption Count | % of Interruptions |
|------------------------------------|----------------|---------------------|--------------------|
| Faulty GPU                         | GPU            | 148                 | 30.1%              |
| GPU HBM3 Memory                    | GPU            | 72                  | 17.2%              |
| Software Bug                       | Dependency     | 54                  | 12.9%              |
| Network Switch/Cable               | Network        | 35                  | 8.4%               |
| Host Maintenance                   | Unplanned      | 32                  | 7.6%               |
| GPU SRAM Memory                    | GPU            | 19                  | 4.5%               |
| GPU System Processor               | GPU            | 17                  | 4.1%               |
| NIC                                | Host           | 7                   | 1.7%               |
| NCCL Watchdog Timeouts             | Unknown        | 7                   | 1.7%               |
| Silent Data Corruption             | GPU            | 6                   | 1.4%               |
| GPU Thermal Interface + Sensor     | GPU            | 6                   | 1.4%               |
| SSD                                | Host           | 3                   | 0.7%               |
| Power Supply                       | Host           | 3                   | 0.7%               |
| Server Chassis                     | Host           | 2                   | 0.5%               |
| IO Expansion Board                 | Host           | 2                   | 0.5%               |
| Dependency                         | Dependency     | 2                   | 0.5%               |
| CPU                                | Host           | 2                   | 0.5%               |
| System Memory                      | Host           | 2                   | 0.5%               |

**Table 5** Root-cause categorization of unexpected interruptions during a 54-day period of Llama 3 40SB pre-training. About 78% of unexpected interruptions were attributed to confirmed or suspected hardware issues.

#### 3.3.4 Reliability and Operational Challenges

The complexity and potential failure scenarios of 16K GPU training surpass those of much larger CPU clusters that we have operated. Moreover, the synchronous nature of training makes it less fault-tolerant—a single GPU failure may require a restart of the entire job. Despite these challenges, for Llama 3, we achieved higher than 90% effective training time while supporting automated cluster maintenance, such as firmware and Linux kernel upgrades (Virajman and Leonhardt, 2024), which resulted in at least one day training interruption daily. The effective training time measures the time spent on useful training over the elapsed time.

During a 54-day snapshot period of pre-training, we experienced a total of 466 job interruptions. Of these, 47 were planned interruptions due to automated maintenance operations such as firmware upgrades or operator-initiated operations like configuration or dataset updates. The remaining 419 were unexpected interruptions, which are classified in Table 5. Approximately 78% of the unexpected interruptions are attributed to confirmed hardware issues, such as GPU or host component failures, or suspected hardware-related issues like silent data corruption and unplanned individual host maintenance events. GPU issues are the largest category, accounting for 58.7% of all unexpected issues. Despite the large number of failures, significant manual intervention was required only three times during this period, with the rest of issues handled by automation.

To increase the effective training time, we reduced job startup and checkpointing time, and developed tools for fast diagnosis and problem resolution. We extensively use PyTorch's built-in NCCL flight recorder (Ansel et al., 2024), a feature that captures collective metadata and stack traces into a ring buffer, and hence allowing us to diagnose hangs and performance issues quickly at scale, particularly with regard to NCCL. Using this, we efficiently record every communication event and the duration of each collective operation, and also automatically dump tracing data on NCCL watchdog or heartbeat timeout. We enable more computationally intensive tracing operations and metadata collection selectively as needed live in production through online configuration changes (Tang et al., 2015) without needing a code release or job restart.

Debugging issues in large-scale training is complicated by the mixed use of NVLink and RoCE in our network. Data transfer over NVLink typically occurs through load/store operations issued by CUDA kernels, and failures in either the remote GPU or NVLink connectivity often manifest as stalled load/store operations within CUDA kernels without returning a clear error code. NCCL-X enhances the speed and accuracy of failure detection and localization through a tight co-design with PyTorch, allowing PyTorch to access NCCL X’s internal state and track relevant information. While stalls due to NVLink failures cannot be completely prevented, our system monitors the state of the communication library and automatically times out when such a stall is detected. Additionally, NCCL X traces the kernel and network activities of each NCCL X communication and provides a snapshot of the failing NCCL X collective’s internal state, including finished and pending data transfers between all ranks. We analyze this data to debug NCCL X scaling issues.

Sometimes, hardware issues may cause still-functioning but slow stragglers that are hard to detect. Even a single straggler can slow down thousands of other GPUs, often appearing as functioning but slow communications. We developed tools to prioritize potentially problematic communications from selected process groups. By investigating just a few top suspects, we were usually able to effectively identify the stragglers.

One interesting observation is the impact of environmental factors on training performance at scale. For Llama 3 405B , we noted a diurnal 1-2% throughput variation based on time-of-day. This fluctuation is the result of higher mid-day temperatures impacting GPU dynamic voltage and frequency scaling. 

During training, tens of thousands of GPUs may increase or decrease power consumption at the same time, for example, due to all GPUs waiting for checkpointing or collective communications to finish, or the startup or shutdown of the entire training job. When this happens, it can result in instant fluctuations of power consumption across the data center on the order of tens of megawatts, stretching the limits of the power grid. This is an ongoing challenge for us as we scale training for future, even larger Llama models.

#### 3.4 Training Recipe

The recipe used to pre-train Llama 3 405B consists of three main stages: (1) initial pre-training, (2) long-context pre-training, and (3) annealing. The three stages are described separately below. We use similar recipes to pre-train the 8B and 70B models.

##### 3.4.1 Initial Pre-Training

We pre-train Llama 3 405B using a cosine learning rate schedule, with a peak learning rate of $8 \times 10^{-5}$, a linear warm up of 8,000 steps, and a decay to $8 \times 10^{-7}$ over 1,200,000 training steps. We use a lower batch size early in training to improve training stability, and increase it subsequently to improve efficiency. Specifically, we use an initial batch size of 4M tokens and sequences of length 4,096, and double these values to a batch size of 8M sequences of 8,192 tokens after pre-training 252M tokens. We double the batch size again to 16M after pre-training on 2.87T tokens. We found this training recipe to be very stable: we observed few loss spikes and did not require interventions to correct for model training divergence.

Adjusting the data mix. We made a several adjustments to the pre-training data mix during training to improve model performance on particular downstream tasks. In particular, we increased the percentage of non-English data during pre-training to improve the multilingual performance of Llama 3. We also upsample mathematical data to improve the model’s mathematical reasoning performance, we added more recent web data in the later stages of pre-training to advance the model’s knowledge cut-off, and we downsampled subsets of the pre-training data that were later identified as being lower quality.

##### 3.4.2 Long Context Pre-Training

In the final stages of pre-training, we train on long sequences to support context windows of up to 128K tokens. We do not train on long sequences earlier because the compute in self-attention layers grows quadratically in the sequence length. We increase the supported context length in increments, pre-training until the model has successfully adapted to the increased context length. We assess successful adaptation by measuring whether (1) model performance on short-context evaluations has recovered completely and (2) the model perfectly solves “needle in a haystack” tasks up to that length. In Llama 3 405B pre-training, we increased context length gradually in six stages, starting from the original 8K context window and ending in the final 128K context window. This long-context pre-training stage was performed using approximately 800B training tokens.

Figure 7 Illustration of the overall post-training approach for Llama 3. Our post-training strategy involves rejection sampling, supervised finetuning, and direct preference optimization. See text for details.

##### 3.4.3 Annealing

During pre-training on the final 40M tokens, we linearly annealed the learning rate to 0, maintaining a context length of 128K tokens. During this annealing phase, we also adjusted the data mix to upsample data sources of very high quality; see Section 3.1.3. Finally, we compute the average of model checkpoints (Polyak (1991) averaging) during annealing to produce the final pre-trained model.






### 04 Post-Training

We produce the aligned Llama 3 models by applying several rounds of post-training, 6 or aligning the model with human feedback (Ouyang et al., 2022; Rafailov et al., 2024) on top of a pre-trained checkpoint. Each round of post-training involves supervised finetuning (SFT) followed by Direct Preference Optimization (DPO; Rafailov et al., 2024) on examples collected either via human annotations or generated synthetically. Our post-training modeling and data approaches are described in Sections 4.1 and 4.2 respectively. We further detail custom data curation strategies to improve the reasoning, coding, factuality, multilingual, tool use, long context, and precise instruction following in Section 4.3.

4.1 Modeling

The backbone of our post-training strategy is a reward model and a language model. We first train a reward model on top of the pre-trained checkpoint using human-annotated preference data (see Section 4.1.2). We then finetune pre-trained checkpoints with supervised finetuning (SFT; see Section 4.1.3), and further align the checkpoints with Direct Preference Optimization (DPO; see Section 4.1.4). This process is illustrated in Figure 7. Unless otherwise noted, our modeling procedure applies to Llama 3 405B, and we refer to Llama 3 405B as Llama 3 for simplicity.

4.1.1 Chat Dialog Format

To tune LLMs for human-AI interaction, we need to define a chat dialog protocol for the model to understand human instructions and perform conversational tasks. Compared to its predecessor, Llama 3 has new capabilities such as tool use (Section 4.3.5) which may require generating multiple messages and sending


4.1.2 Reward Modeling

We train a reward model (RM) covering different capabilities on top of the pre-trained checkpoint. The training objective is the same as Llama 2 except that we remove the margin term in the loss, as we observe diminishing improvements after data scaling. Following Llama 2, we use all of our preference data for reward modeling after filtering out samples with similar responses. In addition to standard preference pair of (chosen, rejected) responses, annotations also create a third “edited response” for some prompts, where the chosen response from the pair is further edited for improvement (see Section 4.2.1). Hence, each preference ranking sample has two or three responses with clear ranking (edited > chosen > rejected). We concatenate the prompt and multiple responses into a single row during training with responses randomly shuffled. This is an approximation to the standard scenario of putting the responses in separate rows and computing the scores, but in our ablations, this approach improves training efficiency without a loss in accuracy.

4.1.3 Supervised Finetuning

The reward model is then used to perform rejection sampling on our human annotation prompts, the details of which are described in Section 4.2. Together with this rejection-sampled data and other data sources (including synthetic data), we finetune the pre-trained language model using a standard cross entropy loss on the target tokens (while masking loss on prompt tokens). More details about the data mix can be found in Section 4.2. We refer to this stage as supervised finetuning (SFT; Wei et al., 2022a; Sanh et al., 2022; Wang et al., 2022b), even though many of the training targets are model-generated. Our largest models are finetuned with a learning rate of 1e-5 over the course of 8.5K to 9K steps. We tuned these hyperparameter settings to work well across different rounds and data mixes.

4.1.4 Direct Preference Optimization

We further train our SFT models with Direct Preference Optimization (DPO; Rafailov et al., 2024) for human preference alignment. For training, we primarily use the most recent batches of preference data collected using the best performing models from the previous alignment rounds. As a result, our training data conforms better to the distribution of the policy model that is being optimized in each round. We also explored on-policy algorithms such as PPO (Schulman et al., 2017), but found that DPO required less compute for large-scale models and performed better, especially on instruction following benchmarks like IFEval (Zhou et al., 2023). For Llama 3, we use a learning rate of 1e-5 and set the beta hyper-parameter to be 0.1. In addition, we apply the following algorithmic modifications to DPO:

- **Masking out formatting tokens in DPO loss:** We mask out special formatting tokens including header and termination tokens (described in Section 4.1.1) from both chosen and rejected responses in the loss to stabilize DPO training. We observe that having these tokens contribute to the loss may lead to undesired model behaviors such as tail repetition or abruptly generating termination tokens. We hypothesize that this is due to the contrastive nature of the DPO loss – the presence of common tokens in both chosen and rejected responses leads to a conflicting learning objective as the model needs to increase and reduce the likelihood of these tokens simultaneously.
- **Regularization with NLL loss:** We add an additional negative log-likelihood (NLL) loss term with a scaling coefficient of 0.2 on the chosen sequences, similar to Pang et al. (2024). This helps further stabilize DPO training by maintaining desired formatting for generation and preventing the decrease of log probability of chosen responses (Pang et al., 2024; Pal et al., 2024).

4.1.5 Model Averaging

Finally, we average models obtained from experiments using various versions of data or hyperparameters at each RM, SFT, or DPO stage (Izmailov et al., 2019; Wortsman et al., 2022; Li et al., 2022).


| Dataset             | % of comparisons | Avg. # turns per dialog | Avg. # tokens per example | Avg. # tokens in prompt | Avg. # tokens in response |
|---------------------|------------------|-------------------------|---------------------------|------------------------|--------------------------|
| General English     | 81.99%           | 4.1                     | 1,004.4                   | 36.4                   | 271.2                    |
| Coding              | 6.93%            | 3.2                     | 1,621.0                   | 113.8                  | 462.9                    |
| Multilingual        | 5.19%            | 1.8                     | 1,299.4                   | 77.1                   | 420.9                    |
| Reasoning and tools | 5.89%            | 1.6                     | 707.7                     | 46.6                   | 129.9                    |
| **Total**           | **100%**         | **3.8**                 | **1,041.6**               | **44.5**               | **284.0**                |

Table 6 Statistics of human preference data. We list statistics of the internally collected human preference data used for Llama 3 alignment. We ask annotators to perform multi-turn dialogues with the models and make comparisons among responses at each turn. In post-processing, we split each dialogue to multiple examples at a turn level. Each example consists of a prompt (including previous dialog if available) and a response (e.g., chosen or rejected response).

### 4.1.6 Iterative Rounds

Following Llama 2, we apply the above methods in six rounds. In each cycle, we collect new preference annotations and SFT data, sampling synthetic data from the latest models.

### 4.2 Post-training Data

The post-training data composition plays a critical role in the usefulness and behavior of language models. In this section, we discuss our human annotation procedures and preference data collection (Section 4.2.1), the composition of our SFT data (Section 4.2.2), and methods for data quality control and cleaning (Section 4.2.3).

#### 4.2.1 Preference Data

Our preference data annotation process is similar to Llama 2. We deploy multiple models for annotation after each round and sample two responses from two different models for each user prompt. These models can be trained with different data mixes and alignment recipes, allowing for different capability strength (e.g., code expertise) and increased data diversity. We ask annotators to rate the strength of their preference by categorizing it into one of four levels, based on how much more they prefer the chosen response over the rejected one: significantly better, better, slightly better, or marginally better. We also incorporate an editing step after preference ranking to encourage annotators to further improve the preferred response. Annotators edit the chosen response directly or prompt the model with feedback to refine its own response. Consequently, a portion of our preference data has three responses ranked (edited > chosen > rejected). 

In Table 6, we report the statistics of preference annotations that we use for Llama 3 training. General English covers multiple subcategories such as knowledge-based question and answering or precise instruction-following, which fall outside the scope of specific capabilities. Compared to Llama 2, we observe an increase in the average length of prompt and response, suggesting that we train Llama 3 on more complex tasks. In addition, we implement a quality analysis and human evaluation process to rigorously assess the data collected, allowing us to refine our prompts and provide systematic, actionable feedback to annotators. For example, as Llama 3 improves after each round, we increase prompt complexity accordingly to target areas where the model lags.

In each round of post-training, we use all the preference data that is available at the time for reward modeling, while only using the latest batches from various capabilities for DPO training. For both reward modeling and DPO, we use samples that are labeled as the chosen response being significantly better or better than the rejected counterpart for training and discard samples with similar responses.

#### 4.2.2 SFT Data

Our finetuning data is largely comprised of the following sources:

* Prompts from our human annotation collection with rejection-sampled responses
* Synthetic data targeting specific capabilities (see Section 4.3 for more details)


### Table 7
Statistics of SFT data. We list internally collected SFT data used for Llama 3 alignment. Each SFT example consists of a context (i.e., all conversation turns except the last one) and a final response.

| Dataset           | % of examples | Avg. # turns | Avg. # tokens in context | Avg. # tokens in final response |
|-------------------|---------------|--------------|--------------------------|-------------------------------|
| General English   | 52.66%        | 6.3          | 974.0                    | 656.7                         | 317.1                         |
| Code              | 14.89%        | 2.7          | 753.3                    | 378.8                         | 374.5                         |
| Multilingual      | 3.01%         | 2.7          | 520.5                    | 230.8                         | 289.7                         |
| Exam-like         | 8.14%         | 2.3          | 297.8                    | 124.4                         | 173.4                         |
| Reasoning and tools | 21.19%      | 3.1          | 661.6                    | 359.8                         | 301.9                         |
| Long context      | 0.11%         | 6.7          | 38,135.6                 | 37,395.2                      | 740.5                         |
| **Total**         | **100%**      | **4.7**      | **846.1**                | **535.7**                     | **310.4**                     |

---

- Small amounts of human-curated data (see Section 4.3 for more details)

As our post-training rounds progress, we develop stronger Llama 3 variants that we use to collect larger datasets that cover a wide range of complex capabilities. In this section we discuss the details for the rejection-sampling procedure and overall composition of our final SFT datamix.

#### Rejection sampling
During rejection sampling (RS), for each prompt collected during human annotation (Section 4.2.1) we sample K (typically between 10 and 30) outputs from the latest chat model policy (usually the best performing checkpoint from the previous post-training iteration, or the best performing checkpoint for a particular capability) and use our reward model to select the best candidate, consistent with Bai et al. (2022). In later rounds of post-training, we introduce system prompts to steer RS responses to conform with desirable tone, style, or formatting, which might be different for different capabilities.

To increase the efficiency of rejection sampling, we adopt PagedAttention (Kwon et al., 2023). PagedAttention enhances memory efficiency through dynamic key-value cache allocation. It supports arbitrary batch sizes by dynamically scheduling requests based on the current cache capacity. Unfortunately, this carries the risk of swap-out when running out of memory. To eliminate such swap overhead, we define a maximum output length and perform a request only if sufficient memory is available to fit an output with that length. Together, this enables us to share the key-value cache pages for a prompt across all corresponding outputs. Together, this leads to a throughput improvement of over 2× during rejection sampling.

#### Overall data composition
Table 7 shows data statistics for each broad category of our “helpfulness” mix. While SFT and preference data contain overlapping domains, they are curated differently, yielding distinct count statistics. In Section 4.2.3 we describe techniques for categorizing topic, complexity, and quality of our data samples. In each round of post-training, we adjust our overall data mix carefully across these axes to tune performance across a wide range of benchmarks. Our final data mix epochs multiple times on some high quality sources and downsamples others.

### 4.2.3 Data Processing and Quality Control
Given that most of our training data is model-generated, it requires careful cleaning and quality control.

#### Data cleaning
In the early rounds, we observed a number of undesirable patterns common in our data, such as excessive use of emojis or exclamation points. Therefore, we implement a series of rule-based data removal and modification strategies to filter or clean problematic data. For example, to mitigate overly-apologetic tonal issues, we identify overused phrases (such as “I’m sorry” or “I apologize”) and carefully balance the proportion of such samples in our dataset.

#### Data pruning
We also apply a collection of model-based techniques to remove low-quality training samples and improve overall performance:

- **Topic classification**: We first finetune Llama 3 8B into a topic classifier, and perform inference over all data to classify it into both coarsely-grained buckets (“mathematical reasoning”) and fine-grained


- **Quality scoring**: We use both reward model and Llama-based signals to obtain a quality score for each sample. For an RM-based score, we consider data that is in the top quartile of RM scores as high quality. For a Llama-based score, we prompt Llama 3 checkpoint to rate each sample on a three-point scale for general English data (Accuracy, Instruction Following, and Tone/Presentation) and a two-point scale for coding data (Bug Identification and User Intention), and consider samples that obtain the maximum score as high quality. The RM and Llama-based scores have high disagreement rates, and we find that combining these signals yield the best recall on our internal test set. Ultimately, we select examples that are marked as high quality by the RM or the Llama-based filter.

- **Difficulty scoring**: Because we are also interested in prioritizing examples that are more complex for the model, we score data using two measures of difficulty: Instag (Lu et al., 2023) and Llama-based scoring. For Instag, we prompt Llama 3 70B to perform intention tagging of SFT prompts, where more intentions implies more complexity. We also prompt Llama 3 to measure the difficulty (Liu et al., 2024c) of dialogs on a three-point scale.

- **Semantic deduplication**: Finally, we perform semantic deduplication (Abbas et al., 2023; Liu et al., 2024c). We first cluster complete dialogs using RoBERTa (Liu et al., 2019b) and within each cluster sort them by quality score × difficulty score. We then do greedy selection by iterating through all sorted examples, and only keeping the ones that have maximum cosine similarity less than a threshold to the examples seen so far in the cluster.

## 4.3 Capabilities

We highlight special efforts to improve performance for specific capabilities such as code (Section 4.3.1), multilinguality (Section 4.3.2), math and reasoning (Section 4.3.3), long context (Section 4.3.4), tool use (Section 4.3.5), factuality (Section 4.3.6), and steerability (Section 4.3.7).

### 4.3.1 Code

LLMs for code have received significant attention since the release of Copilot and Codex (Chen et al., 2021). Developers are now widely using these models to generate code snippets, debug, automate tasks, and improve code quality. For Llama 3, we target improving and evaluating code generation, documentation, debugging, and review capabilities for the following high priority programming languages: Python, Java, Javascript, C/C++, Typescript, Rust, PHP, HTML/CSS, SQL, bash/shell. Here, we present our work on improving these coding capabilities via training a code expert, generating synthetic data for SFT, improving formatting with system prompt steering, and creating quality filters to remove bad samples from our training data.

**Expert training**. We train a code expert which we use to collect high quality human annotations for code throughout subsequent rounds of post-training. This is accomplished by branching the main pre-training run and continuing pre-training on a IT token mix of mostly (>85%) code data. Continued pre-training on domain-specific data has been shown to be effective for improving performance in a specific domain (Gururangan et al., 2020). We follow a recipe similar to that of CodeLlama (Rozière et al., 2023). For the last several thousand steps of training we perform long-context finetuning (LCFT) to extend the expert’s context length to 16K tokens on a high quality mix of repo-level code data. Finally, we follow the similar post-training modeling recipes described in Section 4.1 to align this model, except with SFT and DPO data mixes primarily targeting code. This model is also used for rejection sampling (Section 4.2.2) for coding prompts.

**Synthetic data generation**. During development, we identified key issues in code generation, difficulty in following instructions, code syntax errors, incorrect code generation, and difficulty in fixing bugs. While intensive human annotation could theoretically resolve these issues, synthetic data generation offers a complementary approach at a lower cost and higher scale, unconstrained by the expertise level of annotators. As such, we use Llama 3 and the code expert to generate a large quantity of synthetic SFT dialogs.

We describe three high-level approaches for generating synthetic code data. In total, we generate over 2.7M synthetic examples which were used during SFT.


1. **Synthetic data generation: execution feedback.** The 8B and 70B models show significant performance improvements when trained on data generated by a larger, more competent model. However, our initial experiments revealed that training Llama 3 405B on its own generated data is not helpful (and can even degrade performance). To address this limitation, we introduced execution feedback as a source of truth, enabling the model to learn from its mistakes and stay on track. In particular, we generate large dataset of approximately one million synthetic coding dialogues using the following process: 

   - **Problem description generation:** First, we generate a large collection of programming problem descriptions that span a diverse range of topics, including those in the long tail distribution. To achieve this diversity, we sample random code snippets from various sources and prompt the model to generate programming problems inspired by these examples. This allowed us to tap into a wide range of topics and create a comprehensive set of problem descriptions (Wei et al., 2024).

   - **Solution generation:** Then, we prompt Llama 3 to solve each problem in a given programming language. We observe that adding general rules of good programming to the prompt improves the generated solution quality. Also, we find it is helpful to require the model to explain its thought process in comments.

   - **Correctness analysis:** After generating a solution, it is crucial to recognize that its correctness is not guaranteed, and including incorrect solutions in the finetuning dataset could harm the model's quality. While we do not ensure complete correctness, we develop methods to approximate it. To achieve this, we extract the source code from the generated solution and applied a combination of static and dynamic analysis techniques to test its correctness, including:

     - **Static analysis:** We run all generated code through a parser and a linter to ensure syntactic correctness, catching errors such as syntax errors, use of uninitialized variables or non-imported functions, code style issues, typing errors, and others.

     - **Unit test generation and execution:** For each problem and solution, we prompt the model to generate unit tests, executed in a containerized environment together with the solution, catching run-time execution errors and some semantic errors.

   - **Error feedback and iterative self-correction:** When a solution fails at any step, we prompt the model to revise it. The prompt included the original problem description, the faulty solution, and feedback from the parser/linter/tester (stdout, stderr/ and return code). After a unit test execution failure, the model could either fix the code to pass the tests or modify its unit tests to accommodate the generated code. Only dialogs that pass all checks are included in the final dataset, used for supervised finetuning (SFT). Notably, we observed that about 20% of solutions were initially incorrect but self-corrected, indicating that the model learned from the execution feedback and improved its performance.

   - **Fine-tuning and iterative improvement:** The finetuning process is conducted over multiple rounds, with each round building on the previous one. After each round, the model is improved, generating higher-quality synthetic data for the next round. This iterative process allows for progressive refinement and enhancement of the model’s performance.

2. **Synthetic data generation: programming language translation.** We observe a performance gap between major programming languages (e.g., Python/C++) and less common ones (e.g., Typescript/PHP). This is not surprising as we have less training data for less common programming languages. To mitigate this, we supplement our existing data by translating data from common programming languages to less common languages (similar to Chen et al. (2023) in the context of reasoning). This is achieved by prompting Llama 3 and ensuring quality via syntax parsing, compilation, and execution. Figure 8 demonstrates an example of synthetic PHP code translated from Python. This improves performance significantly for less common languages as measured by the MultiPL-E (Cassano et al., 2023) benchmark.

3. **Synthetic data generation: backtranslation.** To improve certain coding capabilities (e.g., documentation, explanations) where execution feedback is less informative for determining quality, we employ an alternative multi-step approach. Using this procedure, we generated approximately 1.2M synthetic


![](./10_0.png)

Figure 8  Code translation example. We display an example of using Llama 3 to translate Python code (left) to PHP code (right) to augment our SFT dataset with a wider range of programming languages.

![](./10_1.png)

Figure 9  Improving generated code quality with system prompts. *Left*: without system prompt *Right*: with system prompt.

dialogs related to code explanation, generation, documentation, and debugging. Beginning with code snippets from a variety of languages in our pre-training data:

- **Generate**: We prompt Llama 3 to generate data that represents our target capability (e.g., we add comments and docstrings for the code snippet, or we ask the model to explain a piece of code).

- **Backtranslate**: We then prompt the model to “backtranslate” the synthetically generated data to the original code (e.g., we prompt the model to generate code only from its documentation, or we ask the model to generate code only from its explanation).

- **Filter**: Using the original code as a reference, we prompt Llama 3 to determine the quality of the output (e.g., we ask the model how faithful the backtranslated code is to the original). We then use the generated examples that have the highest self-verification scores in SFT.

**System prompt steering during rejection sampling.** During the rejection sampling process, we used code specific system prompts to improve code readability, documentation, thoroughness, and specificity. Recall, from Section 7 this data is used to finetune the language model. Figure 9 shows an example of how the system prompt helps improve the generated code quality — it adds necessary comments, uses more informative variable names, saves memory, etc.

**Filtering training data with execution and model-as-judge signals.** As described in Section 4.2.3, we occasionally encounter quality issues in our rejection-sampled data, such as code blocks containing bugs. Detecting these issues in our rejection-sampled data is not as straightforward as it is for our synthetic code data, as the rejection-sampled responses typically contain a mix of natural language and code for which the code may not


### 4.3.2 Multilinguality

We describe how we improve Llama 3’s multilingual capabilities, including training an expert specialized on substantially more multilingual data, sourcing and generating high quality multilingual instruction tuning data for German, French, Italian, Portuguese, Hindi, Spanish, and Thai, and tackling specific challenges of multilingual language steering to enhance the overall performance of our model.

**Expert training.** Our Llama 3 pre-training data mix contains significantly more English tokens than non-English tokens. To collect higher quality human annotations in non-English languages, we train a multilingual expert by branching off the pre-training run and continuing to pre-train on a data mix that consists of 90% multilingual tokens. We then perform post-training on this expert following Section 4.1. This expert model is then used to collect higher quality annotations in non-English languages until pre-training was fully complete.

**Multilingual data collection.** Our multilingual SFT data is derived primarily from sources described below. The overall distribution is 2.4% human annotations, 44.2% data from other NLP tasks, 18.8% rejection sampled data, and 34.6% translated reasoning data.

- **Human annotations:** We collect high-quality, manually annotated data from linguists and native speakers. These annotations mostly consist of open-ended prompts that represent real world use cases.

- **Data from other NLP tasks:** To further augment, we use multilingual training data from other tasks and rewrite into dialog format. For example, we use data from exams-qa (Hardalov et al., 2020) and ConiQic (Wu et al., 2023). To improve language alignment, we also use parallel texts from GlobalVoices (Prokopidis et al., 2016) and Wikimedia (Tiedemann, 2012). We use LID based filtering and Blaser2.0 (Seamless Communication et al., 2023) to remove low quality data. For parallel text data, instead of using the bitext pairs directly, we apply a multilingual template inspired by Wei et al. (2022a) to better simulate real-life conversations in translation and language learning scenarios.

- **Rejection sampled data:** We apply rejection sampling on our human annotated prompts to generate high-quality samples for finetuning, with two modifications compared to the process for English data:
    - **Generation:** We explored randomly choosing the temperature hyperparameter from the range 0.2 – 1 for diverse generations in early rounds of post-training. With high temperature, responses for multilingual prompts can get creative and inspiring, but are also susceptible to unnecessary or unnatural code-switching. In the final round of post-training, we use a constant value of 0.6 to balance the trade-off. Additionally, we used specialized system prompts to improve response format, structure and general readability.
    - **Selection:** Prior to reward model based selection, we implement multilingual-specific checks to ensure high language-match ratio between the prompt and response (e.g., a romanized Hindi prompt should not expect a response in Hindi Devanagari script).

- **Translated data:** We try to avoid using machine-translated data to finetune the model in order to prevent translationese (Bizzoni et al., 2020; Muennighoff et al., 2023) or possible meme bias (Wang et al., 2022a), gender bias (Savoldi et al., 2021), or cultural bias (Ji et al., 2023). Moreover, we aim to prevent the model from being exposed only to tasks that are rooted in an English cultural context, which may not be representative of the linguistic and cultural diversity we aim to capture. We made one exception to this and translated our synthetic quantitative reasoning data (see Section 4.3.3 for details) to improve performance in quantitative reasoning in non-English languages. Due to the simpler nature of


### 4.3.3 Math and Reasoning

We define reasoning as the ability to perform multi-step computations and arrive at the correct final answer. Several challenges guide our approach to training models that excel in mathematical reasoning:

- **Lack of prompts:** As the complexity of questions increases, the number of valid prompts or questions for Supervised Fine-Tuning (SFT) decreases. This scarcity makes it difficult to create diverse and representative training datasets for teaching models various mathematical skills (Yu et al., 2023; Yue et al., 2023; Luo et al., 2023; Mitra et al., 2024; Shao et al., 2024; Yue et al., 2024b).

- **Lack of ground truth chain of thought:** Effective reasoning requires a step-by-step solution to facilitate the reasoning process (Wei et al., 2022c). However, there is often a shortage of ground truth chains of thought, which are essential for guiding the model how to break down the problem step-by-step and reach the final answer (Zelikman et al., 2022).

- **Incorrect intermediate steps:** When using model-generated chains of thought, the intermediate steps may not always be correct (Cobbe et al., 2021; Useato et al., 2022; Lightman et al., 2023; Wang et al., 2023a). This inaccuracy can lead to incorrect final answers and needs to be addressed.

- **Teaching models to use external tools:** Enhancing models to utilize external tools, such as code interpreters, allows them to reason by interleaving code and text (Gao et al., 2023; Chen et al., 2022; Gou et al., 2023). This capability can significantly improve their problem-solving abilities.

- **Discrepancy between training and inference:** There is often a discrepancy between how the model is finetuned during training and how it is used during inference. During inference, the finetuned model may interact with humans or other models, requiring it to improve its reasoning using feedback. Ensuring consistency between training and real-world usage is critical for maintaining reasoning performance.

To address these challenges, we apply the following methodologies:

- **Addressing the lack of prompts:** We source relevant pre-training data from mathematical contexts and converted it into a question-answer format which can then be used for supervised finetuning. Additionally, we identify mathematical skills where the model under-performs and actively sourced prompts from humans to teach models such skills. To facilitate this process, we create a taxonomy of mathematical skills (Didolkar et al., 2024) and ask humans to provide relevant prompts/questions accordingly.

- **Augmenting training data with step-wise reasoning traces:** We use Llama 3 to generate step-by-step solutions for a set of prompts. For each prompt, the model produces a variable number of generations. These generations are then filtered based on the correct answer (Li et al., 2024a). We also do self-verification where Llama 3 is used to verify whether a particular step-by-step solution is valid for a given question. This process improves the quality of the finetuning data by eliminating instances where the model does not produce valid reasoning traces.

- **Filtering incorrect reasoning traces:** We train outcome and stepwise reward models (Lightman et al., 2023; Wang et al., 2023a) to filter training data where the intermediate reasoning steps were incorrect. These reward models are used to eliminate data with invalid step-by-step reasoning, ensuring high-quality data for finetuning. For more challenging prompts, we use Monte Carlo Tree Search (MCTS) with learned step-wise reward models to generate valid reasoning traces, further enhancing the collection of high-quality reasoning data (Xie et al., 2024).

- **Interleaving code and text reasoning:** We prompt Llama 3 to solve reasoning problems through a combination of textual reasoning and associated python code (Gou et al., 2023). Code execution is used as a feedback signal to eliminate cases where the reasoning chain was not valid, ensuring the correctness of the reasoning process.

- **Learning from feedback and mistakes:** To simulate human feedback, we utilize incorrect generations (i.e., generations leading to incorrect reasoning traces) and perform error correction by prompting Llama 3 to correct these reasoning traces.


### 4.3.4 Long Context

During the final pre-training stage, we extend the context length of Llama 3 from 8K tokens to 128K tokens (see Section 3.4 for more details). Similar to pre-training, we find that during finetuning we must carefully tune the recipe to balance short and long-context capabilities.

**SFT and synthetic data generation.** Naively applying our existing SFT recipe with only short-context data resulted in significant regressions in long-context capabilities from pre-training, highlighting the need to incorporate long-context data in our SFT data mix. In practice, however, it is largely impractical to get humans to annotate such examples due to the tedious and time-consuming nature of reading lengthy contexts, so we predominantly rely on synthetic data to fill this gap. We use earlier versions of Llama 3 to generate synthetic data based on the key long-context use-cases: (possibly multi-turn) question-answering, summarization for long documents, and reasoning over code repositories, and describe them in greater detail below.

- **Question answering:** We carefully curate a set of long documents from our pre-training mix. We split these documents into chunks of 8K tokens, and prompted an earlier version of the Llama 3 model to generate QA pairs conditional on randomly selected chunks. During training, the whole document is used as context.
  
- **Summarization:** We applied hierarchical summarization of long-context documents by first summarizing the chunks of 8K input length using our strongest Llama 3 8K context model and then summarizing the summaries. During training we provide the full document and prompt the model to summarize the document while preserving all the important details. We also generate QA pairs based on the summaries of the documents and prompt the model with questions that require global understanding of the whole long document.
  
- **Long context code reasoning:** We parse Python files to identify import statements and determine their dependencies. From here, we select the most commonly depended-upon files, specifically those referenced by at least five other files. We remove one of these key files from a repository and prompt the model to identify which files depended on the missing file and to generate the necessary missing code.

We further categorize these synthetically generated samples based on the sequence length (16K, 32K, 64K and 128K) to enable more fine-grained targeting of input lengths.

Through careful ablations, we observe that mixing 0.1% of synthetically generated long-context data with the original short-context data optimizes the performance across both short-context and long-context benchmarks.

**DPO.** We observe that using only short context training data in DPO did not negatively impact long-context performance as long as SFT model is good for long context tasks. We suspect this is due to the fact that our DPO recipe has fewer optimizer steps than SFT. Given this finding, we keep the standard short-context recipe for DPO on top of our long-context SFT checkpoints.

### 4.3.5 Tool Use

Teaching LLMs to use tools such as search engines or code interpreters hugely expands the range of tasks they can solve, transforming them from pure chat models into more general assistants (Nakano et al., 2021; Thoppilan et al., 2022; Parisi et al., 2022; Gao et al., 2023; Mialon et al., 2023a; Schick et al., 2024). We train Llama 3 to interact with the following tools:

- **Search engine.** Llama 3 is trained to use Brave Search\(^7\) to answer questions about recent events that go beyond its knowledge cutoff or that require retrieving a particular piece of information from the web.

- **Python interpreter.** Llama 3 can generate and execute code to perform complex computations, read files uploaded by the user and solve tasks based on them such as question answering, summarization, data analysis or visualization.


- **Mathematical computational engine.** Llama 3 can use the Wolfram Alpha API$^8$ to more accurately solve math, science problems, or retrieve accurate information from Wolfram’s database.

The resulting model is able to use these tools in a chat setup to solve the user’s queries, including in multi-turn dialogs. If a query requires multiple tool calls, the model can write a step-by-step plan, call the tools in sequence, and do reasoning after each tool call.

We also improve Llama 3’s zero-shot tool use capabilities — given in-context, potentially unseen tool definitions and a user query, we train the model to generate the correct tool call.

Implementation. We implement our core tools as Python objects with different methods. Zero-shot tools can be implemented as Python functions with descriptions, documentation (i.e., examples for how to use them), and the model only needs the function’s signature and docstring as context to generate the appropriate call. We also convert function definitions and calls to JSON format, e.g., for web API calls. All tool calls are executed by the Python interpreter, that must be enabled in Llama 3 system prompt. Core tools can be individually enabled or disabled in the system prompt.

Data collection. Different from Schick et al. (2024), we rely on human annotations and preferences to teach Llama 3 to use tools. There are two main differences with the post-training pipeline generally used in Llama 3:

- For tools, dialogs often contain more than a single assistant message (e.g., calling the tool and reasoning about the tool output). Thus, we annotate at the message level to collect granular feedback: annotators provide a preference between two assistant messages with the same context or, if both contain major problems, edit one of the messages. The chosen or edited message is then added to the context and the dialog continues. This provides human feedback for both the assistant’s ability of calling the tools and reasoning about the tool outputs. Annotators cannot rank or edit the tool outputs.

- We do not perform rejection sampling, as we did not observe gains in our tool benchmarks.

To accelerate the annotation process, we start by bootstrapping basic tool use capabilities by finetuning on synthetically generated data from previous Llama 3 checkpoints. Thus, annotators have fewer edits to perform. In a similar spirit, as Llama 3 gradually improves through its development, we progressively complexify our human annotation protocols: we start by single-turn tool use annotations, before moving to tool use in dialogs, and finally annotating for multi-step tool use and data analysis.

Tool datasets. To create data for tool usage applications, we leverage the following procedure:

- **Single-step tool use:** We start by few-shot generation of synthetic user prompts which, by construction, require a call to one of our core tools (for example, questions that exceed our knowledge cutoff date). Then, still relying on few-shot generation, we generate appropriate tool calls for these prompts, execute them, and add the output to the model’s context. Finally, we prompt the model again to generate a final answer to the user’s query based on the tool output. We end up with trajectories of the following form: system prompt, user prompt, tool call, tool output, final answer. We also filter around 30% this dataset to remove tool calls that cannot be executed or other formatting issues.

- **Multi-step tool use:** We follow a similar protocol and first generate synthetic data to teach the model basic multi-step tool use capabilities. To do this, we first prompt Llama 3 to generate user prompts that require at least two tool calls, that can be the same or different tools from our core set. Then, conditioned on these prompts, we few-shot prompt Llama 3 to generate a solution consisting of interleaved reasoning steps and tool calls, similar to ReAct (Yao et al., 2022). See Figure 10 for an example of Llama 3 performing a task involving multi-step tool usage.

- **File uploads:** We annotate for the following filetypes: .TXT, .DOCX, .PDF, .PPTX, .XLSX, .CSV, .TSV, .PY, .JSON, .JSONL, .HTML, .XML. Our prompts are based on a provided file, and ask to summarize the contents of the file, find and fix bugs, optimize a piece of code, perform data analysis or visualization. See Figure 11 for an example of Llama 3 performing a task involving a file upload.

After finetuning on this synthetic data, we gather human annotations in diverse and challenging scenarios including multi-turn interactions, more than three step tool use, and instances where a tool call does not yield

$^8$ https://products.wolframalpha.com/llm-api/documentation


## User prompt
Below is the inflation rate for the US in February 2024, as well as the cost of food for Costco's food court (pizza slice and drink combo) last year. Adjust for inflation by 6% and the number of your properties are 30-day rental apartments. What is the additional total cost at Costco's food court given cookie drink prices, and average month rent on your properties in 2024?

## System Prompt
```
System: N/A
Usersystem: webgpt_user
Browsersystem: webgpt_browser_alpha
Time: November, 29th 2023, December 2023
Today's date: Jul. 01, 2024
```

## Assistant response
To answer your question, I will need to:
1. Look up the inflation rate for the US in February 2024.
2. Look up the Costco food court cookie drink prices.
3. Calculate the estimated total cost of your properties over a 30-day rental period, given the average monthly rent.
4. Adjust the food court cookie drink prices and adjust the rent for inflation percentage.

First, I will look up the inflation rate for the US in February 2024.

### Assistant tool call
```
action: web_search 
query: "US Inflation rate February 2024"
```

## Tool output
```
The inflation rate for the US in February 2024 was 6%. Now, let's find the "Costco food court giant cookie drink price".
```

### Assistant tool call
```
action: web_search
query: "Costco food court pizza cookie drink price"
```

## Tool output
```
Costco Food Court Giant cookie price: $2.99 Whole chart pizza: $9.95 Whole chart cookies: $1.49 ⅙th cookies: $0.29
```

### Assistant response
Given the lists of foods containing my daily groceries, let's calculate the total daily cost at Costco's food court, then find the cost of cookie drink, you want the inflation percentage is fixed at 6%.

### Assistant tool call
```
# Derive the total cost of tuple containing the daily grocery:
daily_total = ${2.99) + ($2.99)}

# Calculate the total cost of cookie drink
# 
# Generate by: is cost(([time("T")) for line in catalog lines

# Calculate the total cost of the cookie containing the drink
total_cookies_grocery = (2.99+( 2.99 ) }
total_cost_grocery = total_cookies_grocery + 0.06 * ( total_cookies_grocery )
inflation = total_cost_grocery 
inflation = inflation * 10
inflation_cost = total_cost_grocery
```

## Tool output
```
The estimated total cost of your properties over a 30-day rental period at the current inflation rate is $40 per month. The cost of renting your properties, given your annual price and adjusting for inflation is fixed at $84.95.
```

## Figure 10 Multi-step tool usage
Example of Llama 3 performing multi-step planning, reasoning, and tool calling to solve a task.

![](15_0.png)

## Single, nested, and parallel function calling
Calls can be simple nested, i.e. we pass a function call as an argument of another function, or parallel, i.e. the method returns a list of independent function calls. Generating a diverse set of functions, queries and ground truths can be challenging (Mekala et al., 2024), and we resort to mining the Stack (Kocetkov et al., 2022) to ground our synthetic user queries in real functions. More precisely, we extract function calls and their definitions, clean and filter them, e.g. for missing docstrings or non-executable functions, and use Llama 3 to generate a natural language query corresponding to the function call.

## Multi-turn function calling
We also generate synthetic data for multi-turn dialogs with function calls, following a protocol similar to the one proposed in Li et al. (2023b).We use multiple agents that generate domains, APIs, user queries, API calls, and responses, while also ensuring that the generated data covers a set of diverse domains and realistic APIs. All agents are variants of Llama 3 prompted in different ways depending on their roles and collaborate in a step-by-step manner.

## 4.3.6 Factuality
Hallucinations remain a major challenge for large language models. Models tend to be overconfident, even in domains where they have little knowledge. Despite these shortcomings, they are often used as knowledge bases, which can lead to risky outcomes such as the spread of misinformation. While we recognize that factuality can go beyond hallucinations, we took a hallucination-first approach here.


![16_0.png](16_0.png)

Figure 11: Processing file uploads. Example of Llama 3 performing analysis and visualization of an uploaded file.

We follow the principle that post-training should align the model to "know what it knows" rather than add knowledge (Gekhman et al., 2024; Mielke et al., 2020). Our primary approach involves generating data that aligns model generations with subsets of factual data present in the pre-training data. To achieve this, we develop a knowledge probing technique that takes advantage of Llama 3’s in-context abilities. This data generation process involves the following procedure:

1. Extract a data snippet from the pre-training data.
2. Generate a factual question about these snippets (context) by prompting Llama 3.
3. Sample responses from Llama 3 to the question.
4. Score the correctness of the generations using the original context as a reference and Llama 3 as a judge.
5. Score the informativeness of the generations using Llama 3 as a judge.
6. Generate a refusal for responses which are consistently informative and incorrect across the generations, using Llama 3.

We use data generated from the knowledge probe to encourage the model to only answer questions which it has knowledge about, and refuse answering those questions that it is unsure about. Further, pre-training data is not always factually consistent or correct. We therefore also collect a limited set of labeled factuality data that deals with sensitive topics where factually contradictory or incorrect statements are prevalent.


#### 4.3.7 Steerability

Steerability is the ability to direct the model’s actions and outcomes to meet developer and user specifications. As Llama 3 is a generic foundational model, it should be maximally steerable to different downstream use cases easily. For Llama 3, we focus on enhancing its steerability through system prompt with natural language instructions, especially around response length, format, tone and character/persona.

**Data collection.** We collect steerability preference samples within the general English category by asking annotators to design different system prompts for Llama 3. Annotators then engage in conversations with the models to evaluate their consistency in following instructions defined in system prompts over the course of the conversation. We show an example customized system prompt used for enhancing steerability below:

![](17_0.png)

**Modeling.** After we collect the preference data, we leverage this data in reward modeling, rejection sampling, SFT, and DPO to enhance Llama 3’s steerability.

## 5 Results

We performed an extensive series of evaluations of Llama 3, investigating the performance of: (1) the pre-trained language model, (2) the post-trained language model, and (3) the safety characteristics of Llama 3. We present the results of these evaluations in separate subsections below.

### 5.1 Pre-trained Language Model

In this section, we report evaluation results for our pre-trained Llama 3 (Section 3), comparing with various other models of comparable sizes. We reproduce results of competitor models whenever possible. For non-Llama models, we report the best score across results that are publicly reported or (where possible) that we reproduced ourselves. The specifics of these evaluations, including configurations such as the number of shots, metrics, and other pertinent hyperparameters and settings, can be accessed on our Github repository here. Additionally, we are releasing the data generated as part of evaluations with publicly available benchmarks which can be found on Huggingface here. We evaluate the quality of our models on standard benchmarks (Section 5.1.1), for robustness to changes in multiple-choice question setups (Section 5.1.2), and on adversarial evaluations (Section 5.1.3). We also conduct a contamination analysis to estimate the extent to which our evaluations are impacted by contamination of training data (Section 5.1.4).

#### 5.1.1 Standard Benchmarks

To compare our models with the current state-of-the-art, we evaluate Llama 3 on a large number of standard benchmark evaluations shown in Table 8. These evaluations cover eight top-level categories: (1) commonsense reasoning; (2) knowledge; (3) reading comprehension; (4) math, reasoning, and problem solving; (5) long context; (6) code; (7) adversarial evaluations; and (8) aggregate evaluations.
