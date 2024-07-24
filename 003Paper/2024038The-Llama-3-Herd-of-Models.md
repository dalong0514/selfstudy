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
