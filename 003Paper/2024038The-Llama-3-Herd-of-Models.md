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

- **Data.** Compared to prior versions of Llama (Touvron et al., 2023a,b), we improved both the quantity and quality of the data we use for pre-training and post-training. These improvements include the development of more careful pre-processing and curation pipelines for pre-training data and the development of more rigorous quality assurance and filtering approaches for post-training data. We pre-train Llama 3 on a corpus of about 157 multilingual tokens, compared to 1.8T tokens for Llama 2.

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

数据。与 Llama 的先前版本（Touvron et al., 2023a,b）相比，我们在预训练和微调阶段都显著提升了数据的数量和质量。这些改进包括为预训练数据开发更为严谨的预处理和数据整理流程，同时为微调数据制定了更加严格的质量保证和筛选方法。Llama 3 的预训练语料库包含约 157 万亿个多语言标记（token），相较于 Llama 2 使用的 1.8 万亿个标记，规模有了显著提升。

规模。我们这次训练的模型规模远超以往的 Llama 模型：我们的旗舰语言模型在预训练阶段使用了 3.8 x $10^{25}$ 次浮点运算（FLOPs），几乎是 Llama 2 最大版本的 50 倍。具体来说，我们预训练了一个拥有 4050 亿个可训练参数的旗舰模型，使用了 15.6 万亿个文本标记。正如基础模型的缩放定律所预测的那样，我们的旗舰模型的性能优于使用相同方法训练的较小模型。虽然根据我们的缩放定律，旗舰模型的规模对于我们的训练预算来说已接近计算效率的最优点，但我们仍然大幅延长了较小模型的训练时间，远超计算效率最优的时长。这样做的结果是，在相同的推理预算下，这些模型的表现优于计算效率最优的模型。在微调阶段，我们还利用旗舰模型来进一步提升这些较小模型的质量。

管理复杂性。我们在设计时致力于最大化模型开发过程的可扩展性。例如，为了提高训练的稳定性，我们选择了标准的密集 Transformer（变换器）模型架构（Vaswani et al., 2017），并对其进行了微小调整，而非采用混合专家模型（mixture-of-experts model）(Shazeer et al., 2017）。同样，我们采用了相对简单的训练后处理方法，包括监督微调（Supervised Fine-Tuning，SFT)、拒绝采样（Rejection Sampling，RS）和直接偏好优化（Direct Preference Optimization，DPO; Rafailov et al.（2023)），而不是使用更复杂的强化学习算法（Ouyang et al., 2022; Schulman et al., 2017）。这是因为强化学习算法通常不太稳定，且更难以扩展。

表 1：Llama 3 模型族概览。本文中的所有结果均基于 Llama 3.1 模型。

我们的研究成果是 Llama 3：一个由三个多语言大语言模型（Large Language Model）组成的系列，这些模型分别拥有 80 亿、700 亿和 4050 亿个参数。为了评估 Llama 3 的性能，我们使用了涵盖广泛语言理解任务的众多基准测试数据集。不仅如此，我们还进行了大规模的人工评估，将 Llama 3 与其他竞争模型进行了比较。表 2 展示了 Llama 3 系列中最强大模型在关键基准测试上的表现概览。

我们的实验结果表明，我们的顶级模型在各种任务中的表现可以与 GPT-4（OpenAI，2023a）等领先的语言模型相媲美，几乎达到了当前的最高水平。而我们的较小规模模型在同等参数量的模型中表现最为出色，超越了其他类似规模的模型（Bai et al., 2023; Jiang et al., 2023）。与此同时，相比于其前代产品，Llama 3 在实用性和安全性之间取得了更好的平衡（Touvron et al., 2023b）。关于 Llama 3 的安全性，我们在第 5.4 节中进行了详细的分析。

### 02 General Overview

The model architecture of Llama 3 is illustrated in Figure 1. The development of our Llama 3 language models comprises two main stages:

Figure 1  Illustration of the overall architecture and training of Llama 3. Llama 3 is a Transformer language model trained to predict the next token of a textual sequence. See text for details.

- **Language model pre-training.** We start by converting a large, multilingual text corpus to discrete tokens and pre-training a large language model (LLM) on the resulting data to perform next-token prediction. In the language model pre-training stage, the model learns the structure of language and obtains large amounts of knowledge about the world from the text it is “reading”. To do this effectively, pre-training is performed at massive scale: we pre-train a model with 405B parameters on 15.6T tokens using a context window of 8K tokens. This standard pre-training stage is followed by a continued pre-training stage that increases the supported context window to 128K tokens. See Section 3 for details.

- **Language model post-training.** The pre-trained language model has a rich understanding of language but it does not yet follow instructions or behave in the way we would expect an assistant to. We align the model with human feedback in several rounds, each of which involves supervised finetuning (SFT) on instruction tuning data and Direct Preference Optimization (DPO; Rafailov et al., 2024). At this post-training stage, we also integrate new capabilities, such as tool-use, and observe strong improvements in other areas, such as coding and reasoning. See Section 4 for details. Finally, safety mitigations are also incorporated into the model at the post-training stage, the details of which are described in Section 5.4.

The resulting models have a rich set of capabilities. They can answer questions in at least eight languages, write high-quality code, solve complex reasoning problems, and use tools out-of-the-box or in a zero-shot way.

We also perform experiments in which we add image, video, and speech capabilities to Llama 3 using a compositional approach. The approach we study comprises the three additional stages illustrated in Figure 28:

- **Multi-modal encoder pre-training.** We train separate encoders for images and speech. We train our image encoder on large amounts of image-text pairs. This teaches the model the relation between visual content and the description of that content in natural language. Our speech encoder is trained using a self-supervised approach that masks out parts of the speech inputs and tries to reconstruct the masked output parts via a discrete-token representation. As a result, the model learns the structure of speech signals. See Section 7 for details on the image encoder and Section 8 for details on the speech encoder.

- Vision adapter training. We train an adapter that integrates the pre-trained image encoder into the pre-trained language model. The adapter consists of a series of cross-attention layers that feed image-encoder representations into the language model. The adapter is trained on text-image pairs. This aligns the image representations with the language representations. During adapter training, we also update the parameters of the image encoder but we intentionally do not update the language-model parameters. We also train a video adapter on top of the image adapter on paired video-text data. This enables the model to aggregate information across frames. See Section 7 for details.
  
- Speech adapter training. Finally, we integrate the speech encoder into the model via an adapter that converts speech encodings into text representations that can be fed directly into the finetuned language model. The parameters of the adapter and encoder are jointly updated in a supervised finetuning stage to enable high-quality speech understanding. We do not change the language model during speech adapter training. We also integrate a text-to-speech system. See Section 8 for details.

Our multimodal experiments lead to models that can recognize the content of images and videos, and support interaction via a speech interface. These models are still under development and not yet ready for release.

图 1：Llama 3 的整体架构和训练流程示意图。Llama 3 本质上是一个 Transformer 语言模型，它的主要任务是预测文本序列中的下一个 token。图中展示了模型的基本结构和训练过程，具体细节请参考正文描述。

语言模型预训练。我们首先将大规模的多语言文本数据转换为离散的标记（token），然后在这些数据上预训练一个大语言模型（Large Language Model，LLM），使其能够预测序列中的下一个单词或片段。在预训练阶段，模型不仅学习语言的结构，还从「阅读」的文本中获取大量关于世界的知识。为了达到最佳效果，我们进行了超大规模的预训练：使用一个包含 405B（4050 亿）参数的模型，在 15.6T（15.6 万亿）个标记上进行训练，每次处理 8K（8000）个标记的上下文信息。在这个标准预训练阶段之后，我们还进行了持续预训练，将模型能够处理的上下文信息量提升到 128K（12.8 万）个标记。详细内容请参见第 3 节。

语言模型后训练。预训练后的语言模型虽然对语言有了深刻的理解，但还不能按照指令行事，也不能像我们期望的助手那样工作。因此，我们通过多轮人类反馈来调整模型，每一轮都包括对指令数据集进行监督式微调（Supervised Fine-tuning，SFT）和直接偏好优化（Direct Preference Optimization，DPO；参见 Rafailov 等人 2024 年的研究）。在这个后训练阶段，我们还为模型增加了新的功能，比如使用外部工具的能力，同时我们也观察到模型在编程和逻辑推理等其他方面有了显著提升。详细内容请参见第 4 节。最后，我们还在后训练阶段加入了一些安全防护措施，以降低模型可能带来的风险，这部分内容将在第 5.4 节详细介绍。

这些模型展现出了多方面的卓越能力。它们不仅能够用至少八种语言回答问题，还能编写高质量的代码，解决复杂的推理问题，并且能够直接使用各种工具，甚至在没有经过专门训练的情况下也能应用自如。

我们还进行了一系列实验，旨在通过一种模块化的方法为 Llama 3 增添处理图像、视频和语音的能力。我们研究的这种方法包括如图所示的三个额外阶段：

多模态编码器预训练（Multi-modal encoder pre-training）。我们为图像和语音分别训练了独立的编码器。图像编码器的训练使用了大量的图像-文本对，这使得模型能够学习视觉内容与其自然语言描述之间的关系。语音编码器则采用了一种自监督学习的方法进行训练：它会遮蔽部分语音输入，然后尝试通过一种离散化的表示方式来重建这些被遮蔽的部分。通过这个过程，模型逐步掌握了语音信号的结构。关于图像编码器的详细信息可以参考第 7 节，而语音编码器的细节则在第 8 节中有所描述。

视觉适配器的训练过程。我们训练了一个适配器，用于将预先训练好的图像编码器整合到预训练的语言模型中。这个适配器由一系列交叉注意力层（cross-attention layers）组成，它们的作用是将图像编码器的表示输入到语言模型中。适配器在成对的文本和图像数据上进行训练，目的是让图像表示与语言表示相互对齐。在训练适配器的过程中，我们会更新图像编码器的参数，但有意保持语言模型的参数不变。此外，我们还在图像适配器的基础上，使用配对的视频和文本数据训练了一个视频适配器。这使得模型能够整合和理解视频中多个帧之间的信息。详细内容请参见第 7 节。

语音适配器的训练过程。最后，我们通过一个适配器将语音编码器整合到模型中。这个适配器的作用是将语音编码转换为文本表示，然后直接输入到经过微调的语言模型中。在有监督的微调阶段，适配器和编码器的参数会一起更新，以实现高质量的语音理解。在训练语音适配器的过程中，我们不会改变语言模型的参数。我们还集成了一个文字转语音系统。详细内容请参见第 8 节。

通过这些多模态实验，我们开发出了能够识别图像和视频内容，并支持语音交互界面的模型。不过，这些模型目前还处于开发阶段，尚未准备好对外发布。

### 03 Pre-Training

Language model pre-training involves: (1) the curation and filtering of a large-scale training corpus, (2) the development of a model architecture and corresponding scaling laws for determining model size, (3) the development of techniques for efficient pre-training at large scale, and (4) the development of a pre-training recipe. We present each of these components separately below.

大语言模型 (Large Language Model, LLM) 的预训练过程包括以下几个关键步骤：1）收集和筛选大规模的训练数据集。2）设计模型架构，并制定相应的规模调整规则，以确定模型的适当大小。3）开发能够进行大规模高效预训练的技术。4）制定详细的预训练流程和参数设置。接下来，我们将逐一介绍这些重要组成部分。

#### 3.1 Pre-Training Data

We create our dataset for language model pre-training from a variety of data sources containing knowledge until the end of 2023. We apply several de-duplication methods and data cleaning mechanisms on each data source to obtain high-quality tokens. We remove domains that contain large amounts of personally identifiable information (PII), and domains with known adult content.

3.1 预训练数据

为了创建语言模型的预训练数据集，我们汇集了包含直到 2023 年末各类知识的多种数据源。我们对每个数据源应用了多种去重方法和数据清理机制，以获得高质量的标记（tokens）。在此过程中，我们移除了包含大量个人身份信息（Personally Identifiable Information，PII）的域名，以及已知包含成人内容的域名。

##### 3.1.1 Web Data Curation

Much of the data we utilize is obtained from the web and we describe our cleaning process below.

3.1.1 网络数据整理

我们使用的大部分数据来自网络，下面我们将描述我们的数据清理过程。

**PII and safety filtering.** 

Among other mitigations, we implement filters designed to remove data from websites that are likely to contain unsafe content or high volumes of PII, domains that have been ranked as harmful according to a variety of Meta safety standards, and domains that are known to contain adult content.

个人信息和安全过滤。

除采取其他缓解措施外，我们还实施了一系列过滤器。这些过滤器旨在移除以下数据：可能包含不安全内容或大量个人身份信息的网站数据、根据 Meta（原 Facebook 公司）各种安全标准被评为有害的域名，以及已知包含成人内容的域名。

**Text extraction and cleaning**

We process the raw HTML content for non-truncated web documents to extract high-quality diverse text. To do so, we build a custom parser that extracts the HTML content and optimizes for precision in boilerplate removal and content recall. We evaluate our parser's quality in human evaluations, comparing it with popular third-party HTML parsers that optimize for article-like content, and found it to perform favorably. We carefully process HTML pages with mathematics and code content to preserve the structure of that content. We maintain the image alt attribute text since mathematical content is often represented as pre-rendered images where the math is also provided in the alt attribute. We experimentally evaluate different cleaning configurations. We find markdown is harmful to the performance of a model that is primarily trained on web data compared to plain text, so we remove all markdown markers.

文本抽取与净化

我们对完整的网页文档的原始 HTML 内容进行处理，以提取高质量、多样化的文本。为此，我们开发了一个自定义解析器，用于提取 HTML 内容，并优化了去除网页模板和保留核心内容的能力。我们通过人工评估来比较我们的解析器与专注于提取文章类内容的主流第三方 HTML 解析器的质量，结果表明我们的解析器表现更为出色。对于包含数学公式和代码的 HTML 页面，我们进行了特别处理以保留其结构。我们还保留了图片的 alt 属性文本，因为数学内容通常以图片形式呈现，而具体的数学表达式则包含在 alt 属性中。我们还测试了不同的数据清理方法。研究发现，对于主要使用网络数据训练的模型来说，保留 markdown 格式会降低模型性能，因此我们删除了所有 markdown 标记。

**De-duplication**

We apply several rounds of de-duplication at the URL, document, and line level:

- **URL-level de-duplication.** We perform URL-level de-duplication across the entire dataset. We keep the most recent version for pages corresponding to each URL.

- **Document-level de-duplication.** We perform global MinHash (Broder, 1997) de-duplication across the entire dataset to remove near duplicate documents.

- **Line-level de-duplication.** We perform aggressive line-level de-duplication similar to ccNet (Wenzek et al., 2019). We remove lines that appeared more than 6 times in each bucket of 30M documents. Although our manual qualitative analysis showed that the line-level de-duplication removes not only leftover boilerplate from various websites such as navigation menus, cookie warnings, but also frequent high-quality text, our empirical evaluations showed strong improvements.

数据去重

我们在 URL、文档和行级别进行了多轮去重处理：

- URL 级别去重：我们对整个数据集进行了基于 URL 的去重。对于每个 URL 对应的网页，我们只保留最新版本。

- 文档级别去重：我们使用全局 MinHash 算法（Broder，1997）对整个数据集进行处理，删除内容几乎相同的文档。

- 逐行去除重复内容。我们采用了类似于 ccNet（Wenzek et al., 2019）研究中的激进逐行去重方法。具体来说，我们在每 3000 万个文档的集合中，删除了出现超过 6 次的相同行。虽然我们的人工质量分析显示，这种逐行去重不仅删除了各种网站上残留的模板文本（如导航菜单、cookie 提醒等），也删除了一些经常出现的高质量文本，但我们的实际评估结果表明，这种方法带来了显著的改进。

**Heuristic filtering**

We develop heuristics to remove additional low-quality documents, outliers, and documents with excessive repetitions. Some examples of heuristics include:

- We use duplicated n-gram coverage ratio (Rae et al., 2021) to remove lines that consist of repeated content such as loggin or error messages. Those lines could be very long and unique, hence cannot be detected by line dedup.

- We use "dirty word" counting (Raffel et al., 2020) to filter out adult websites that are not covered by common block lists.

- We use a token-distribution Kullback-Leibler divergence to filter out documents containing excessive numbers of outlier tokens compared to the training corpus distribution.

基于经验的筛选方法

我们开发了一些基于经验的方法，用于去除额外的低质量文档、异常数据和含有过度重复内容的文档。以下是一些具体例子：

- 我们使用重复词组（n-gram）覆盖率（Rae et al., 2021）来删除由重复内容组成的行，比如日志或错误消息。这些行可能很长且看似独特，因此无法通过简单的行级去重检测到。

- 我们使用「脏词」计数方法（Raffel et al., 2020）来过滤掉一些常见屏蔽列表未能覆盖的成人网站。

- 我们使用词元（token）分布的 Kullback-Leibler 散度（一种衡量两个概率分布差异的方法）来过滤掉那些与训练语料库分布相比，包含过多异常词元的文档。

**Model-based quality filtering**

Further, we experiment with applying various model-based quality classifiers to sub-select high-quality tokens. These include using fast classifiers such as fasttext (Joulin et al., 2017) trained to recognize if a given text would be referenced by Wikipedia (Touvron et al., 2023a), as well as more compute-intensive Roberta-based classifiers (Liu et al., 2019a) trained on Llama 2 predictions. To train a quality classifier based on Llama 2, we create a training set of cleaned web documents, describe the quality requirements, and instruct Llama 2's chat model to determine if the documents meets these requirements. We use DistilRoberta (Sanh et al., 2019) to generate quality scores for each document for efficiency reasons. We experimentally evaluate the efficacy of various quality filtering configurations.

基于模型的质量筛选

此外，我们还尝试应用各种基于模型的质量分类器来筛选高质量的文本片段（token）。这些方法包括使用快速分类器，如 fasttext（快速文本，Joulin et al., 2017），该分类器经过训练可以识别给定文本是否会被维基百科引用（Touvron et al., 2023a）。我们还使用了更加耗费计算资源的基于 Roberta 的分类器（Liu et al., 2019a），这些分类器是在 Llama 2 的预测结果上训练的。

为了训练基于 Llama 2 的质量分类器，我们创建了一个经过清理的网络文档训练集。我们描述了质量要求，并指示 Llama 2 的聊天模型来判断文档是否满足这些要求。出于效率考虑，我们使用 DistilRoberta（精馏 Roberta，Sanh et al., 2019）为每个文档生成质量分数。我们通过实验评估了各种质量过滤配置的效果。

**Code and reasoning data**

Similar to DeepSeek-AI et al. (2024), we build domain-specific pipelines that extract code and math-relevant web pages. Specifically, both the code and reasoning classifiers are DistilledRoberta models trained on web data annotated by Llama 2. Unlike the general quality classifier mentioned above, we conduct prompt tuning to target web pages containing math deduction, reasoning in STEM areas and code interleaved with natural language. Since the token distribution of code and math is substantially different than that of natural language, these pipelines implement domain-specific HTML extraction, customized text features and heuristics for filtering.

代码和推理数据

与 DeepSeek-AI et al. (2024) 类似，我们构建了针对特定领域的处理流程，用于提取代码和与数学相关的网页。具体而言，代码和推理分类器都是 DistilledRoberta 模型，这些模型是在由 Llama 2 标注的网络数据上训练的。

与上述通用质量分类器不同，我们进行了提示词优化（prompt tuning），以针对包含数学推导、STEM（科学、技术、工程和数学）领域推理以及与自然语言交织的代码的网页。由于代码和数学的文本结构与自然语言有很大不同，这些处理流程实现了针对特定领域的 HTML 提取、定制的文本特征和过滤启发式方法。

**Multilingual data**

Similar to our processing pipelines for English described above, we implement filters to remove data from websites that are likely to contain PII or unsafe content. Our multilingual text processing pipeline has several unique features:

- We use a fasttext-based language identification model to categorize documents into 176 languages.

- We perform document-level and line-level de-duplication within data for each language.

- We apply language-specific heuristics and model-based filters to remove low-quality documents.

In addition, we perform quality ranking of multilingual documents using a multilingual Llama 2-based classifier to ensure that high-quality content is prioritized. We determine the amount of multilingual tokens used in pre-training experimentally, balancing model performance on English and multilingual benchmarks.

多语言数据

与前面描述的英语处理流程类似，我们也为多语言数据实施了过滤器，以移除可能包含 PII（个人身份信息）或不安全内容的网站数据。我们的多语言文本处理流程有几个独特之处：

- 我们使用基于 fasttext（一种高效的文本分类和表示学习库）的语言识别模型，将文档分类为 176 种不同的语言。

- 对每种语言的数据，我们都进行文档级和行级的去重处理。

- 我们应用针对特定语言的启发式方法和基于模型的过滤器，以删除低质量的文档。

此外，我们使用基于多语言 Llama 2（一种先进的大语言模型）的分类器对多语言文档进行质量排序，确保优质内容得到优先处理。我们通过实验来确定预训练中使用的多语言 token（标记）数量，以平衡模型在英语和多语言基准测试上的性能表现。

##### 3.1.2 Determining the Data Mix

To obtain a high-quality language model, it is essential to carefully determine the proportion of different data sources in the pre-training data mix. Our main tools in determining this data mix are knowledge classification and scaling law experiments.

**Knowledge classification.** We develop a classifier to categorize the types of information contained in our web data to more effectively determine a data mix. We use this classifier to downsample data categories that are over-represented on the web, for example, arts and entertainment.

**Scaling laws for data mix.** To determine the best data mix, we perform scaling law experiments in which we train several small models on a data mix and use that to predict the performance of a large model on that mix (see Section 3.2.1). We repeat this process multiple times for different data mixes to select a new data mix candidate. Subsequently, we train a larger model on this candidate data mix and evaluate the performance of that model on several key benchmarks.

**Data mix summary.** Our final data mix contains roughly 50% of tokens corresponding to general knowledge, 25% of mathematical and reasoning tokens, 17% code tokens, and 8% multilingual tokens.

3.1.2 确定数据混合比例

要获得高质量的语言模型，仔细确定预训练数据中不同数据源的比例至关重要。我们主要通过知识分类和缩放法则实验这两种方法来确定数据的混合比例。

知识分类： 我们开发了一个分类器，用于对网络数据中包含的信息类型进行分类，从而更有效地确定数据混合比例。我们使用这个分类器对网络上过度代表的数据类别进行下采样（即减少采样比例），例如艺术和娱乐类内容。这样做的目的是平衡不同类型信息在训练数据中的分布，避免模型对某些领域产生偏见。

数据混合的优化规律。为了找出最佳的数据混合方案，我们进行了一系列优化实验。在这些实验中，我们首先用某种数据混合方案训练几个小型模型，然后用这些结果来预测大型模型在同样混合方案下的表现（详见 3.2.1 节）。我们反复尝试不同的数据混合方案，以此选出新的候选方案。之后，我们用这个候选方案训练一个更大的模型，并在几个关键基准测试上评估其性能。

数据混合概览。我们最终确定的数据混合方案中，约 50% 的标记（token）属于通用知识类别，25% 属于数学和推理类别，17% 属于编程代码类别，8% 属于多语言类别。

##### 3.1.3 Annealing Data

Empirically, we find that annealing (see Section 3.4.3) on small amounts of high-quality code and mathematical data can boost the performance of pre-trained models on key benchmarks. Akin to Li et al. (2024b), we perform annealing with a data mix that upsamples high-quality data in select domains. We do not include any training sets from commonly used benchmarks in our annealing data. This enables us to assess the true few-shot learning capabilities and out-of-domain generalization of Llama 3.

Following OpenAI (2023a), we evaluate the efficacy of annealing on the GSM8k (Cobbe et al., 2021) and MATH (Hendrycks et al., 2021b) training sets in annealing. We find that annealing improved the performance of a pre-trained Llama 3 8B model on the GSM8k and MATH validation sets by 24.0% and 4.6%, respectively. However, the improvements on the 405B model are negligible, suggesting that our flagship model has strong in-context learning and reasoning capabilities and does not require specific in-domain training samples to attain strong performance.

**Using annealing to assess data quality.** Similar to Blakeney et al. (2024), we find that annealing enables us to judge the value of small domain-specific datasets. We measure the value of such datasets by annealing the learning rate of a 50% trained Llama 3 8B model linearly to 0 on 40B tokens. In those experiments, we assign 30% weight to the new dataset and the remaining 70% weight to the default data mix. Using annealing to evaluate new data sources is more efficient than performing scaling law experiments for every small dataset.

3.1.3 数据微调

实践表明，在少量高质量的编程和数学数据上进行微调（annealing，详见 3.4.3 节）可以显著提升预训练模型在关键基准测试上的表现。类似于 Li 等人（2024b）的研究，我们在微调过程中使用了一种特殊的数据混合方案，这种方案增加了特定领域高质量数据的比例。值得注意的是，我们的微调数据中不包含任何常用基准测试的训练集。这样做的目的是为了能够真实评估 Llama 3 在少样本学习和跨领域泛化方面的能力。

参考 OpenAI 在 2023 年的研究，我们评估了一种叫做「退火」的技术在改善模型性能方面的效果。我们选择了两个数学问题解决能力测试数据集：GSM8k（一个小学数学问题集）和 MATH（一个高中和大学水平的数学问题集）。结果显示，对于 Llama 3 的 8B 参数版本，使用退火技术后，模型在 GSM8k 和 MATH 测试集上的表现分别提升了 24.0% 和 4.6%。有趣的是，对于更大的 405B 参数版本，退火带来的改进几乎可以忽略不计。这说明我们的顶级模型已经具备了强大的学习和推理能力，即使不进行特定领域的训练，也能表现出色。

利用退火技术评估数据质量。我们的发现与 Blakeney 等人在 2024 年的研究结果类似，退火技术能帮助我们判断小型专业数据集的价值。具体做法是，我们先将 Llama 3 的 8B 参数版本训练到一半，然后在接下来处理 400 亿个文本单位（token）的过程中，逐步将学习率降低到零。在这个过程中，我们给新数据集分配 30% 的权重，其余 70% 仍使用原有的数据混合。相比为每个小数据集都进行大规模的实验，这种方法更加高效。

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

3.2 模型架构

Llama 3 采用了标准的 Transformer 架构，这是一种在自然语言处理领域广泛使用的神经网络结构。与之前的 Llama 和 Llama 2 版本相比，模型架构并没有太大变化。我们的性能提升主要来自于三个方面：提高了训练数据的质量，增加了数据的多样性，以及扩大了训练规模。

与 Llama 3 相比，我们确实做了一些较小的改进：

- 我们采用了分组查询注意力机制（Grouped Query Attention，GQA; Ainslie et al. (2023)），使用 8 个键值注意力头。这种方法可以提高模型的推理速度，并在解码过程中减少键值缓存的大小。

- 我们引入了一种特殊的注意力屏蔽机制，用于防止同一序列内不同文档之间的自注意力计算。虽然这个改变在标准预训练过程中影响不大，但我们发现它在对超长序列进行持续预训练时非常重要。

表 3：Llama 3 模型的主要参数设置。下表展示了 8B（80 亿参数）、70B（700 亿参数）和 405B（4050 亿参数）三种规模语言模型的具体配置。

注：

SwiGLU：一种高效的激活函数，用于提升模型性能。

RoPE：旋转位置编码（Rotary Position Embedding），一种用于处理序列位置信息的技术。

- 我们使用了一个包含 128K 个 token 的词汇表。这个词汇表由两部分组成：100K 个来自 titoktoten 分词器（tokenizer）的 token，以及 28K 个额外的 token，后者主要用于更好地支持非英语语言。与 Llama 2 的分词器相比，我们的新分词器在英语数据样本上的压缩效率有了显著提升：平均每个 token 可以表示的字符数从 3.17 个增加到了 3.94 个。这意味着在相同的训练计算量下，模型能够处理更多的文本内容。此外，我们还发现，从特定的非英语语言中增加 28K 个 token 不仅改善了压缩比和下游任务的性能，而且对英语的分词效果没有产生负面影响。

- 我们将旋转位置编码（RoPE，Rotary Position Embedding）的基频超参数提高到了 500,000。这一调整使得我们的模型能够更好地处理更长的上下文信息。Xiong 等人（2023）的研究表明，这个参数值对于处理长达 32,768 个 token 的上下文都是有效的。

Llama 3 405B 模型采用了一个包含 126 层的架构，token 表示的维度为 16,384，并使用了 128 个注意力头；详细信息可以参见表 3。根据我们在数据集上观察到的缩放规律，这个模型的规模在计算效率上是接近最优的。我们为这个模型分配了约 3.8 × 10^25 次浮点运算（FLOPs）的训练计算预算。

##### 3.2.1 Scaling Laws

We develop scaling laws (Hoffmann et al., 2022; Kaplan et al., 2020) to determine the optimal model size for our flagship model given our pre-training compute budget. In addition to determining the optimal model size, a major challenge is to forecast the flagship model’s performance on downstream benchmark tasks, due to a couple of issues: (1) Existing scaling laws typically predict only next-token prediction loss rather than specific benchmark performance. (2) Scaling laws can be noisy and unreliable because they are developed based on pre-training runs conducted with small compute budgets (Wei et al., 2022b).

To address these challenges, we implement a two-stage methodology to develop scaling laws that accurately predict downstream benchmark performance:

1. We first establish a correlation between the compute-optimal model’s negative log-likelihood on downstream tasks and the training FLOPs.

2. Next, we correlate the negative log-likelihood on downstream tasks with task accuracy, utilizing both the scaling law models and older models trained with higher compute FLOPs. In this step, we specifically leverage the Llama 2 family of models.

This approach enables us to predict downstream task performance given a specific number of training FLOPs for compute-optimal models. We use a similar method to select our pre-training data mix (see Section 3.4).

3.2.1 缩放规律

我们利用「规模效应法则」（Scaling laws）(Hoffmann et al., 2022; Kaplan et al., 2020）来确定我们主力模型在给定预训练计算资源下的最佳规模。这种方法可以帮助我们预测：随着模型规模的增加，其性能会如何提升。然而，除了确定最佳模型规模外，我们还面临着一个重大挑战：如何准确预测模型在各种实际应用任务上的表现。这个挑战主要源于两个问题：(1）现有的规模效应法则通常只能预测模型在预训练任务（如预测下一个词）上的表现，而不能直接预测模型在特定应用任务上的性能。(2）由于这些法则通常是基于小规模计算资源得出的，它们可能会存在误差，不够可靠（Wei et al., 2022b）。

为了克服这些挑战，我们采用了一个两步走的方法来开发更准确的规模效应法则，以预测模型在实际应用任务上的表现：

1. 首先，我们建立了模型在应用任务上的表现（用一个叫做「负对数似然」的指标来衡量）与训练所需计算量（用 FLOPs，即浮点运算次数来衡量）之间的关系。

2. 然后，我们将这个「负对数似然」指标与任务的实际准确率联系起来。在这一步中，我们不仅使用了基于规模效应法则训练的模型，还利用了一些使用更多计算资源训练的 older 模型，特别是 Llama 2 系列模型（这是 Meta 公司开发的一系列大型语言模型）。

通过这种方法，我们能够根据给定的计算资源，准确预测模型在实际应用任务上的表现。我们还使用了类似的方法来选择预训练数据的最佳组合（具体内容请参见第 3.4 节）。

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

规模效应实验

具体来说，我们通过预训练计算预算在 $6 \times 10^{18}$ FLOP 到 $10^{22}$ FLOP 之间的模型来构建我们的缩放定律。在每个计算预算下，我们预训练的模型规模从 4000 万到 160 亿参数不等，并在每个计算预算下使用一部分模型大小。在这些训练过程中，我们采用余弦学习率调度，并在前 2,000 个训练步骤内进行线性预热。峰值学习率根据模型大小设定在 $2 \times 10^{-4}$ 到 $4 \times 10^{-4}$ 之间。我们将余弦衰减设置为峰值的 0.1。每个步骤的权重衰减设为该步骤学习率的 0.1 倍。我们对每个计算规模使用固定的批次大小，范围在 25 万到 400 万之间。

图 2：$6 \times 10^{18}$ 到 $10^{22}$ FLOP 之间的缩放定律等 FLOP 曲线。损失函数为在保留的验证集上的负对数似然（negative log-likelihood）。我们使用二次多项式来近似每个计算规模的测量值。

图 3：识别出的计算最优模型中训练词元（token）数量与预训练计算预算的关系。图中还包括了拟合的缩放定律预测。这些计算最优模型对应于图 2 中抛物线的最小值点。

这些实验产生了图 2 中的等计算量（IsoFLOPs）曲线。这些曲线中的损失值（即模型预测错误的程度）是在一个单独的验证数据集上测量的。我们使用二次多项式拟合这些测量得到的损失值，并找出每条曲线的最低点。我们将曲线的最低点称为在相应预训练计算资源下的最优模型。

我们使用这种方法确定的最优模型来预测特定计算资源下的最佳训练数据量（以 token 为单位，token 是文本的基本单位，可以是单词或字符）。为此，我们假设计算资源 C 和最佳训练数据量 $N^{*}(C)$ 之间存在幂律关系：

$$N^{*}(C）= AC^{\alpha}$$

我们使用图 2 中的数据拟合参数 $\alpha$ 和 A。结果发现（$\alpha$，A）=（0.53，0.29)；相应的拟合曲线如图 3 所示。将得到的缩放规律推广到 $3.8 \times 10^{25}$ 次浮点运算（FLOPs），结果表明应该训练一个拥有 4020 亿参数的模型，使用 16.55 万亿个 token 的训练数据。

一个重要的发现是，随着计算资源的增加，等计算量曲线在最低点附近变得更加平坦。这意味着大型模型（即「旗舰模型「）的性能对模型大小和训练数据量之间的微小变化相对不敏感。基于这一发现，我们最终决定训练一个拥有 4050 亿参数的大型模型。

预测下游任务的性能。我们使用计算最优模型来预测旗舰版 Llama 3 模型在各种测试数据集上的表现。这里的下游任务指的是使用预训练模型来完成特定的应用任务。首先，我们建立了基准测试中正确答案的归一化负对数似然与训练浮点运算次数（FLOPs）之间的线性关系。在这项分析中，我们仅使用了在前述数据混合集上训练至 $10^{22}$ FLOPs 的缩放模型。接着，我们利用缩放模型和 Llama 2 模型（后者使用 Llama 2 的数据混合集和分词器进行训练）建立了对数似然和准确率之间的 sigmoid 关系。图 4 展示了这个实验在 ARC Challenge 测试集上的结果。我们发现，这种跨越四个数量级的两步缩放预测方法相当准确：它仅略微低估了旗舰版 Llama 3 模型的最终性能。

#### 3.3 Infrastructure, Scaling, and Efficiency

We describe our hardware and infrastructure that powered Llama 3 405B pre-training at scale and discuss several optimizations that lead to improvements in training efficiency.

3.3 基础设施、规模扩展和效率

在这一节中，我们将介绍支持 Llama 3 405B 模型大规模预训练的硬件和基础设施，并讨论几项提升训练效率的优化策略。

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

3.3.1 训练基础设施

Llama 1 和 Llama 2 模型是在 Meta 公司的 AI 研究超级计算集群上训练的 [(Lee and Sengupta，2022)](https://scholar.google.com/scholar?q=Lee%20and%20Sengupta%2C%202022）。随着我们进一步扩大模型规模，Llama 3 的训练被转移到了 Meta 的生产环境计算集群上 [(Lee et al., 2024)](https://scholar.google.com/scholar?q=Lee%20et%20al.%2C%202024）。这种转变优化了生产级别的可靠性，这在我们扩大训练规模时至关重要。

图 4 ARC Challenge 测试的性能预测。左图 ：横轴表示预训练所用的浮点运算次数（FLOPs），纵轴表示 ARC Challenge 基准测试中正确答案的标准化负对数似然值。右图 ：横轴为左图中的纵轴值，纵轴为 ARC Challenge 基准测试的准确率。这种分析方法使我们能够在开始预训练之前就预测模型在 ARC Challenge 基准测试上的表现。详细解释请参见正文。

计算资源 ：Llama 3 405B 模型的训练使用了多达 16,000 个 H100 GPU（一种高性能图形处理器）。每个 GPU 的最大功耗（TDP）为 700 瓦，配备 80GB HBM3 高带宽内存，这些 GPU 安装在 Meta 公司的 Grand Teton AI 服务器平台上（[Matt Bowman，2022](#)）。每台服务器配备了 8 个 GPU 和 2 个 CPU。在同一服务器内，8 个 GPU 通过 NVIDIA 的高速互联技术 NVLink 相连。训练任务的调度由 Meta 公司的全球规模训练调度系统 MAST 负责（[Choudhury et al., 2024](#)）。

存储系统 。Tectonic（[Pan et al., 2021](#)），Meta 公司开发的通用分布式文件系统，被用于为 Llama 3 预训练构建存储架构（[Battey and Gupta，2024](#)）。该系统由 7,500 台配备固态硬盘（SSD）的服务器组成，提供了高达 240 PB 的存储容量，并能够支持 2 TB/s 的持续吞吐量和 7 TB/s 的峰值吞吐量。在这个系统中，一个主要的挑战是如何处理高度突发的检查点写入操作，这种操作会在短时间内使存储系统达到饱和状态。所谓检查点，是指保存每个 GPU 上的模型状态，范围从每个 GPU 1 MB 到 4 GB 不等，用于系统恢复和调试。我们的目标是在进行检查点操作时尽量减少 GPU 的暂停时间，并增加检查点的频率，以减少系统恢复后丢失的工作量。

网络系统 。在训练 Llama 3 405B 模型时，我们使用了基于 Arista 7800 和 Minipack2 开放计算项目（Open Compute Project，OCP)[^4] 机架交换机的融合以太网远程直接内存访问（RDMA overConverged Ethernet，RoCE）网络架构。对于 Llama 3 系列中规模较小的模型，我们则采用了 Nvidia Quantum2 InfiniBand（一种高性能计算互连技术）网络架构进行训练。无论是 RoCE 还是 InfiniBand 集群，都采用了 400 Gbps 的高速互连来连接 GPU。尽管这些集群使用的底层网络技术不同，我们通过调整使它们在处理大规模训练任务时能够提供相当的性能。接下来，我们将重点介绍 RoCE 网络的设计，因为这是我们自主设计的系统。

- 网络拓扑结构 。我们的 AI 集群基于 RDMA over Converged Ethernet（RoCE）技术，包含了由三层 Clos 网络（一种常用于数据中心的多层级网络架构）连接的 24,000 个 GPU [^5]（[Lee et al., 2024](#)）。在最底层，每个机架上有 16 个 GPU，分布在两台服务器上，通过一个 Minipack2 机架顶部交换机（ToR switch）相连。在中间层，192 个这样的机架通过集群交换机相连，形成一个包含 3,072 个 GPU 的单元（pod），具有全双工带宽，确保网络不会出现拥堵。在最顶层，同一数据中心建筑内的 8 个这样的单元通过汇聚交换机相连，组成一个拥有 24,000 个 GPU 的大集群。然而，在汇聚层的网络连接并不保持全双工带宽，而是有 1:7 的带宽超额认购比。我们的模型并行方法（详见 3.3.2 节）和训练作业调度器（[Choudhury et al., 2024](#)）都经过优化，能够感知网络拓扑结构，旨在最小化跨单元的网络通信。

- 负载均衡 。大语言模型（LLM）训练会产生大量的网络流量，难以使用传统方法（如等成本多路径（ECMP）路由）在所有可用网络路径上进行均衡分配。为了应对这一挑战，我们采用了两种技术。首先，我们的集合通信库在两个 GPU 之间创建 16 个网络流，而不是仅创建一个，从而减少每个流的流量并产生更多的网络流。

[^4]：开放计算项目：<https://www.opencompute.org/>

[^5]：请注意，在 Llama 3 的预训练中，我们最多只使用了这 24,000 个 GPU 中的 16,000 个。

表 4：Llama 3 405B 预训练各阶段的扩展配置和模型吞吐效率（MFU)

关于表中各种并行类型的详细解释，请参阅正文和图 5。

为了实现负载均衡，我们采取了以下措施：首先，我们的增强型等价多路径（Enhanced Equal-Cost Multi-Path，E-ECMP）协议通过对 RDMA over Converged Ethernet（RoCE）数据包头中的额外字段进行哈希处理，有效地将这 16 个数据流均衡分配到不同的网络路径上。

- 拥塞控制： 我们在网络骨干层使用深缓冲交换机（Gangidi et al., 2024），以应对集体通信模式导致的瞬时拥塞和缓冲需求。这种设置有助于减轻训练过程中常见的持续拥塞和由慢速服务器引起的网络反压影响。此外，通过 E-ECMP 实现的更好的负载均衡显著降低了网络拥塞的可能性。借助这些优化措施，我们成功运行了一个包含 24,000 个 GPU 的大规模集群，而无需使用传统的拥塞控制方法，如数据中心量化拥塞通知（Data Center Quantized Congestion Notification，DCQCN）。

#### 3.3.2 Parallelism for Model Scaling

To scale training for our largest models, we use 4D parallelism—a combination of four different types of parallelism methods—to shared the model. This approach efficiently distributes computation across many GPUs and ensures each GPU’s model parameters, optimizer states, gradients, and activations fit in its HBM. Our implementation of 4D parallelism is illustrated in Figure 5. It combines tensor parallelism (TP; Krizhevsky et al. (2012); Shoeybi et al. (2019); Korthikanti et al. (2023)), pipeline parallelism (PP; Huang et al. (2019); Narayanan et al. (2021); Lamy-Poirier (2023)), context parallelism (CP; Liu et al. (2023a)), and data parallelism (DP; Rajbhandari et al. (2020); Ren et al. (2021); Zhao et al. (2023b)).

Tensor parallelism splits individual weight tensors into multiple chunks on different devices. Pipeline parallelism partitions the model vertically into stages by layers, so that different devices can process in parallel different stages of the full model pipeline. Context parallelism divides the input context into segments, reducing memory bottleneck for very long sequence length inputs. We use fully shared data parallelism (FSDP; Rajbhandari et al. (2020); Ren et al., 2021; Zhao et al., 2023b), which shards the model, optimizer, and gradients when implementing data parallelism which processes data in parallel on multiple GPUs and synchronizes after each training step. Our use of FSDP for Llama 3 shards optimizer states and gradients, but for model shards we do not reshard after forward computation to avoid an extra all-gather communication during backward passes.

3.3.2 模型扩展的并行策略

为了扩展我们最大规模模型的训练能力，我们采用了 4D 并行技术 —— 这是一种结合了四种不同并行方法的技术 —— 来分割和分布式处理模型。这种方法能够有效地将计算任务分散到多个 GPU 上，同时确保每个 GPU 的高带宽内存（HBM）能够容纳其负责的那部分模型参数、优化器状态、梯度和激活值。

图 5 展示了我们实现的 4D 并行技术。这种技术融合了以下四种并行方法：

1. 张量并行（Tensor Parallelism，TP）[Krizhevsky et al.（2012); Shoeybi et al.（2019); Korthikanti et al.（2023)]

2. 流水线并行（Pipeline Parallelism，PP）[Huang et al.（2019); Narayanan et al.（2021); Lamy-Poirier（2023)]

3. 上下文并行（Context Parallelism，CP）[Liu et al.（2023a)]

4. 数据并行（Data Parallelism，DP）[Rajbhandari et al.（2020); Ren et al.（2021); Zhao et al.（2023b)]

这些并行技术各有特点，通过组合使用，可以最大化利用可用的计算资源，提高大规模模型训练的效率。

在大规模 AI 模型训练中，我们采用了多种并行技术来提高计算效率：

1. 张量并行（Tensor parallelism)：将单个权重张量分割成多个块，分布在不同设备上。

2. 流水线并行（Pipeline parallelism)：按层将模型垂直划分为多个阶段，让不同设备并行处理模型流水线的各个阶段。

3. 上下文并行（Context parallelism)：将输入的上下文信息分成多个段，有效减少了处理超长序列时的内存瓶颈。

我们还使用了完全共享数据并行（Fully Shared Data Parallelism，FSDP; Rajbhandari et al.（2020); Ren et al., 2021; Zhao et al., 2023b）技术。这种方法在实现数据并行时，将模型、优化器和梯度分散到多个 GPU 上，实现并行数据处理，并在每个训练步骤后同步结果。对于 Llama 3 模型，我们使用 FSDP 来分散优化器状态和梯度，但为了避免在反向传播过程中进行额外的全局数据汇总通信，我们不会在前向计算后重新分散模型部分。

**GPU utilization.** Through careful tuning of the parallelism configuration, hardware, and software, we achieve an overall BF16 Model FLOPs Utilization (MFU; Chowdhery et al. (2023)) of 38-43% for the configurations shown in Table 4. The slight drop in MFU to 41% on 16K GPUs with DP=128 compared to 43% on 8K GPUs with DP=64 is due to the lower batch size per DP group needed to keep the global tokens per batch constant during training.

GPU 利用率：通过精心调整并行配置、硬件和软件，我们在表 4 所示的配置中实现了 38-43% 的整体 BF16 模型浮点运算利用率（Model FLOPs Utilization，MFU; Chowdhery et al.（2023)）。这个指标反映了 GPU 计算资源的有效利用程度。值得注意的是，当我们从 8000 个 GPU（数据并行度为 64）扩展到 16000 个 GPU（数据并行度为 128）时，MFU 从 43% 略微下降到 41%。这是因为为了在训练过程中保持全局批次的 token 数量不变，我们需要减少每个数据并行组的批次大小。

**Pipeline parallelism improvements.**

We encountered several challenges with existing implementations:

- **Batch size constraint.** Current implementations have constraints on supported batch size per GPU, requiring it to be divisible by the number of pipeline stages. For the example in Figure 6, the depth-first schedule (DFS) of pipeline parallelism (Narayanan et al., 2021) requires N = PP ≠ 4, while the breadth-first schedule (BFS; Lamy-Poirier (2023)) requires N = M, where M is the total number of micro-batches and N is the number of contiguous micro-batches for the same stage’s forward or backward. However, pre-training often needs flexibility to adjust batch size.

- **Memory imbalance.** Existing pipeline parallelism implementations lead to imbalanced resource consumption. The first stage consumes more memory due to the embedding and the warm-up micro-batches.

- **Computation imbalance.** After the last layer of the model, we need to calculate output and loss, making this stage the execution latency bottleneck.

Figure 5 Illustration of 4D parallelism. GPUs are divided into parallelism groups in the order of \[TP, CP, PP, DP\], where DP stands for FSDP. In this example, 16 GPUs are configured with a group size of \[TP\]=2, \[CP\]=2, \[PP\]=2, and \[DP\]=2. A GPU’s position in 4D parallelism is represented as a vector, \[D1, D2, D3, D4\], where Di is the index on the i-th parallelism dimension. In this example, GPU0\[TP0, CP0, PP0, DP0\] and GPU1\[TP1, CP0, PP0, DP0\] are in the same TP group, GPU0 and GPU2 are in the same CP group, GPU0 and GPU4 are in the same PP group, and GPU0 and GPU8 are in the same DP group.

To address these issues, we modify our pipeline schedule as shown in Figure 6, which allows setting N flexibly---in this case N = 5, which can run an arbitrary number of micro-batches in each batch. This allows us to run: (1) fewer micro-batches than the number of stages when we have batch size limit at large scale; or (2) more micro-batches to hide point-to-point communication, finding a sweet spot between DFS and breadth first schedule (BFS) for the best communication and memory efficiency. To balance the pipeline, we reduce one Transformer layer each from the first and the last stages, respectively. This means that the first model chunk on the first stage has only the embedding, and the last model chunk on the last stage has only output projection and loss calculation. To reduce pipeline bubbles, we use an interleaved schedule (Narayanan et al., 2021) with V pipeline stages on one pipeline rank. Overall pipeline bubble ratio is $p=\frac{PP-1}{N}$ . Further, we adopt asynchronous point-to-point communication in PP, which considerably speeds up training, especially in cases when the document mask introduces extra computation imbalance. We enable TORCH_NCCL_AVOID_RECORD_STREAMS to reduce memory usage from asynchronous point-to-point communication. Finally, to reduce memory cost, based on detailed memory allocation profiling, we proactively deallocate tensors that will not be used for future computation, including the input and output tensors of each pipeline stage, that will not be used for future computation. With these optimizations, we could pre-train Llama 3 on sequences of 8K tokens without activation checkpointing.

流水线并行的改进：

在实施现有的流水线并行方案时，我们遇到了几个挑战：

- 批处理大小限制。目前的实现方式对每个 GPU 支持的批处理（batch）大小有一定限制，要求它必须能被流水线（pipeline）并行阶段的数量整除。以图 6 为例，流水线并行的深度优先调度（DFS，Depth-First Schedule）(Narayanan et al., 2021）要求 N = PP ≠ 4，而广度优先调度（BFS，Breadth-First Schedule; Lamy-Poirier（2023)）则要求 N = M。这里的 M 是微批次（micro-batch）的总数，N 是同一阶段连续进行正向或反向传播的微批次数量。然而，在预训练（pre-training）过程中，我们通常需要能够灵活调整批处理大小。

- 内存使用不均衡。现有的流水线并行实现会导致资源消耗不均衡。由于需要处理嵌入（embedding）层和预热微批次，第一个阶段会消耗更多的内存。

- 计算负载不均衡。在模型的最后一层之后，我们还需要计算输出和损失，这使得该阶段成为整个执行过程中的速度瓶颈。

图 5：4D 并行示意图这张图展示了一种名为「4D 并行」的 GPU 分组方法。在这种方法中，GPU 被分成四个维度的并行组：张量并行（Tensor Parallelism，TP)、序列并行（Sequence Parallelism，SP)、流水线并行（Pipeline Parallelism，PP）和全分片数据并行（Fully Sharded Data Parallelism，FSDP）。这些并行维度按照 [TP，SP，PP，FSDP] 的顺序排列。

在这个例子中，我们有 16 个 GPU，它们被配置为以下组大小：

- [TP] = 2

- [SP] = 2

- [PP] = 2

- [FSDP] = 2

每个 GPU 在这个 4D 并行系统中的位置可以用一个四维向量 [D1，D2，D3，D4] 来表示，其中 Di 表示该 GPU 在第 i 个并行维度上的索引。

举例来说：

- GPU0 [TP0，SP0，PP0，FSDP0] 和 GPU1 [TP1，SP0，PP0，FSDP0] 属于同一个张量并行（TP）组。

- GPU0 和 GPU2 属于同一个序列并行（SP）组。

- GPU0 和 GPU4 属于同一个流水线并行（PP）组。

- GPU0 和 GPU8 属于同一个全分片数据并行（FSDP）组。

这种 4D 并行方法允许在多个维度上同时进行并行计算，potentially 提高了大规模 AI 模型训练的效率和灵活性。

为了解决这些问题，我们对流水线调度（一种并行处理数据的方法）进行了改进，如图 6 所示。这种改进允许我们灵活地设置 N 的值 —— 在这个例子中，N = 5，这意味着我们可以在每个批次中处理任意数量的小批量数据（微批次）。这种灵活性带来了两个主要好处：

1. 当我们在大规模训练时面临批量大小限制，我们可以运行少于处理阶段数量的微批次。

2. 我们可以运行更多的微批次来掩盖点对点通信的时间消耗，在深度优先调度（DFS）和广度优先调度（BFS）之间找到最佳平衡点，从而实现最佳的通信和内存效率。

为了平衡流水线，我们分别从第一个和最后一个处理阶段各减少了一个 Transformer 层（神经网络中的一种结构单元）。这意味着第一阶段的模型部分只负责词嵌入（将词转化为向量），而最后阶段的模型部分只负责输出投影和损失计算。

为了减少流水线中的空闲时间（称为「气泡「），我们在一个流水线等级上使用了具有 V 个流水线阶段的交错调度方法（Narayanan et al., 2021）。整体流水线气泡比率可以用公式 $p=\frac {PP-1}{N}$ 表示。

此外，我们在并行处理（PP）中采用了异步点对点通信，这显著加速了训练过程，特别是在文档掩码引入额外计算不平衡的情况下。我们还启用了一个名为 TORCH_NCCL_AVOID_RECORD_STREAMS 的技术选项，以减少异步点对点通信的内存使用。

最后，为了进一步减少内存消耗，我们基于详细的内存分配分析，主动释放了那些在未来计算中不会再被使用的数据张量，包括每个流水线阶段的输入和输出张量。

通过这些优化措施，我们成功地在不使用激活检查点（一种用于节省内存的技术，但会增加计算时间）的情况下，对包含 8000 个标记（token）的长序列进行了 Llama 3 模型的预训练。这一成果大大提高了我们处理长文本的能力。

**Context parallelism for long sequences.**

We utilize context parallelism (CP) to improve memory efficiency when scaling the context length of Llama 3 and enable training on extremely long sequences up to 128K in length. In CP, we partition across the sequence dimension, and specifically we partition the input sequence into 2 × CP chunks so each CP rank receives two chunks for better load balancing. The i-th CP rank received both the i-th and the (2 × CP − 1 − i)-th chunks.

Different from existing CP implementations that overlap communication and computation in a ring-like structure (Liu et al., 2023a), our CP implementation adopts an all-gather based method where we first all-gather the key (K) and value (V) tensors, and then compute attention output for the local query (Q) tensor chunk. Although the all-gather communication latency is exposed in the critical path, we still adopt this approach for two main reasons: (1) it is easier and more flexible to support different types of attention masks in all-gather based CP attention, such as the document mask; and (2) the exposed all-gather latency is small as the communicated K and V tensors are much smaller than Q tensor due to the use of GQA (Ainslie et al., 2023). Hence, the time complexity of attention computation is an order of magnitude larger than all-gather ($O(S^2)$ versus $O(S)$, where $S$ represents the sequence length in the full causal mask), making the all-gather overhead negligible. 

Figure 6 Illustration of pipeline parallelism in Llama 3. Pipeline parallelism partitions eight pipeline stages (0 to 7) across four pipeline ranks (PP ranks 0 to 3), where the GPUs with rank 0 run stages 0 and 4, the GPUs with P rank 1 run stages 1 and 5, etc. The colored blocks (0 to 9) represent a sequence of micro-batches, where M is the total number of micro-batches and N is the number of continuous micro-batches for the same stage's forward or backward. Our key insight is to make N tunable.

Network-aware parallelism configuration. The order of parallelism dimensions, [TP, CP, PP, DP], is optimized for network communication. The innermost parallelism requires the highest network bandwidth and lowest latency, and hence is usually constrained to within the same server. The outermost parallelism may spread across a multi-hop network and should tolerate higher network latency. Therefore, based on the requirements for network bandwidth and latency, we place parallelism dimensions in the order of [TP, CP, PP, DP]. DP (i.e., FSDP) is the outermost parallelism because it can tolerate longer network latency by asynchronously prefetching shared model weights and reducing gradients. Identifying the optimal parallelism configuration with minimal communication overhead while avoiding GPU memory overflow is challenging. We develop a memory consumption estimator and a performance-projection tool which helped us explore various parallelism configurations and project overall training performance and identify memory gaps effectively.

Numerical stability. By comparing training loss between different parallelism setups, we fixed several numerical issues that impact training stability. To ensure training convergence, we use FP32 gradients accumulation during backward computation over multiple micro-batches and also reduce-scatter gradients in FP32 across data parallel workers in FSDP. For intermediate tensors, e.g., vision encoder outputs, that are used multiple times in the forward computation, the backward gradients are also accumulated in FP32.

长序列的上下文并行（Context Parallelism)

我们利用上下文并行（Context Parallelism，CP）技术来提高内存效率，从而在扩展 Llama 3 的上下文长度时实现性能改进，并支持训练长达 128K 的超长序列。在 CP 中，我们沿着序列维度进行分区。具体来说，我们将输入序列分成 2 × CP 个块，每个 CP rank（并行计算单元）接收两个块，这样可以实现更好的负载均衡（即计算资源的均匀分配）。第 i 个 CP rank 同时接收第 i 个和第（2 × CP − 1 − i）个块。

与现有的 CP 实现不同，后者在类似环形的结构中重叠通信和计算 [Liu et al., 2023a]，我们的 CP 实现采用了基于 all-gather（全局收集）的方法。我们首先对键（Key，K）和值（Value，V）张量进行 all-gather 操作，然后为本地查询（Query，Q）张量块计算注意力输出。尽管 all-gather 通信延迟暴露在关键路径中，我们仍采用这种方法，主要有两个原因：

1. 在基于 all-gather 的 CP 注意力机制中，更容易且更灵活地支持不同类型的注意力掩码（用于控制模型关注输入的哪些部分），如文档掩码。

2. 由于使用了分组查询注意力（Grouped-Query Attention，GQA）[Ainslie et al., 2023]，所通信的 K 和 V 张量比 Q 张量小得多，因此 all-gather 操作的延迟很小。

因此，注意力计算的时间复杂度比 all-gather 高一个数量级（在完全因果掩码中，前者为 $O（S^2)$，后者为 $O（S)$，其中 $S$ 表示序列长度）。这使得 all-gather 的额外开销可以忽略不计。

图 6：Llama 3 中流水线并行（pipeline parallelism）的示意图这张图展示了 Llama 3 如何利用流水线并行技术来提高计算效率。在这个例子中，整个模型被分为 8 个处理阶段（编号为 0 到 7），这些阶段被分配到 4 个并行处理单元（编号为 PP 0 到 PP 3）上。每个处理单元负责两个非连续的阶段，例如：PP 0 负责处理阶段 0 和 4，PP 1 负责处理阶段 1 和 5，依此类推。

图中的彩色方块（编号为 0 到 9）代表了一系列的微批次（micro-batches）。这里的 M 表示微批次的总数，而 N 表示在同一处理阶段中连续执行的微批次数量，无论是在前向传播还是反向传播过程中。

我们的创新之处在于使 N 值可调整。这种灵活性允许我们根据不同的硬件配置和任务需求来优化模型的并行处理效率。

网络感知的并行化配置。并行化维度的顺序 [张量并行（TP)、通信并行（CP)、流水线并行（PP)、数据并行（DP)] 是为了优化网络通信而设计的。最内层的并行化需要最高的网络带宽和最低的延迟，因此通常被限制在同一服务器内。最外层的并行化可能会跨越多个网络节点，因此应该能够容忍较高的网络延迟。基于这些网络带宽和延迟的要求，我们按照 [TP，CP，PP，DP] 的顺序安排并行化维度。数据并行（DP)（也就是全分片数据并行，FSDP）被安排在最外层，因为它可以通过异步预取共享模型权重和汇总梯度来承受较长的网络延迟。

然而，要在最小化通信开销的同时避免 GPU 内存溢出，并找到最佳的并行化配置，这是一个具有挑战性的任务。为了解决这个问题，我们开发了两个工具：一个内存消耗估算器和一个性能预测工具。这些工具帮助我们探索了各种并行化配置，预测整体训练性能，并有效地识别了潜在的内存瓶颈。

数值稳定性为了解决影响训练稳定性的数值问题，我们比较了不同并行计算设置下的训练损失。通过这种比较，我们成功修复了几个关键问题。为了确保训练能够顺利收敛，我们采取了以下措施：

1. 在多个小批量（micro-batches）的反向传播计算过程中，使用 32 位浮点数（FP32）进行梯度累积。

2. 在完全分片数据并行（FSDP，Fully Sharded Data Parallel）中，使用 32 位浮点数在不同的并行计算单元之间进行梯度的归约散播（reduce-scatter）操作。

3. 对于在前向计算中多次使用的中间结果（例如视觉编码器的输出），其反向传播的梯度也使用 32 位浮点数进行累积。

这些措施有效地提高了训练过程的数值稳定性，从而保证了模型训练的可靠性。

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

3.3.3 集体通信

我们为 Llama 3 开发的集体通信库是基于 Nvidia 的 NCCL（NVIDIA Collective Communications Library）库的一个分支，称为 NCCLX。NCCLX 大幅提升了 NCCL 的性能，尤其是在高延迟网络环境下。

在介绍具体改进之前，让我们先了解一下并行维度的顺序：[TP，CP，PP，DP]。其中 TP 代表张量并行（Tensor Parallelism），CP 代表通信并行（Communication Parallelism），PP 代表流水线并行（Pipeline Parallelism），而 DP 对应全分片数据并行（Fully Sharded Data Parallelism，FSDP）。最外层的并行维度 PP 和 DP 可能需要通过多跳网络进行通信，这可能导致高达数十微秒的延迟。

原始的 NCCL 集合操作 —— 包括 FSDP 中的全聚合（all-gather）和规约分散（reduce-scatter），以及 PP 中的点对点通信 —— 需要进行数据分块和分阶段数据复制。这种方法存在几个效率问题：

1. 需要在网络上交换大量小型控制消息以促进数据传输

2. 需要额外的内存复制操作

3. 占用额外的 GPU 计算资源进行通信为了提高 Llama 3 的训练效率，我们针对这些问题采取了一些措施。首先，我们调整了数据分块和传输策略，以适应我们的网络延迟特性。在大型计算集群中，这些延迟可能高达数十微秒。其次，我们允许小型控制消息以更高的优先级通过网络，特别是避免它们在深缓冲核心交换机中被队首阻塞（即被排在队列前面的大数据包延迟）。

我们目前正在为未来的 Llama 版本进行更深入的研究，计划在 NCCLX 中进行更全面的改进，以全面解决上述所有问题。这些优化将进一步提升 Llama 模型的训练效率和性能。

表 5 展示了在 Llama 3 40SB 模型 54 天预训练期间发生意外中断的根本原因分类。研究发现，约 78% 的意外中断可以追溯到已确认或疑似的硬件问题。

#### 3.3.4 Reliability and Operational Challenges

The complexity and potential failure scenarios of 16K GPU training surpass those of much larger CPU clusters that we have operated. Moreover, the synchronous nature of training makes it less fault-tolerant—a single GPU failure may require a restart of the entire job. Despite these challenges, for Llama 3, we achieved higher than 90% effective training time while supporting automated cluster maintenance, such as firmware and Linux kernel upgrades (Virajman and Leonhardt, 2024), which resulted in at least one day training interruption daily. The effective training time measures the time spent on useful training over the elapsed time.

During a 54-day snapshot period of pre-training, we experienced a total of 466 job interruptions. Of these, 47 were planned interruptions due to automated maintenance operations such as firmware upgrades or operator-initiated operations like configuration or dataset updates. The remaining 419 were unexpected interruptions, which are classified in Table 5. Approximately 78% of the unexpected interruptions are attributed to confirmed hardware issues, such as GPU or host component failures, or suspected hardware-related issues like silent data corruption and unplanned individual host maintenance events. GPU issues are the largest category, accounting for 58.7% of all unexpected issues. Despite the large number of failures, significant manual intervention was required only three times during this period, with the rest of issues handled by automation.

To increase the effective training time, we reduced job startup and checkpointing time, and developed tools for fast diagnosis and problem resolution. We extensively use PyTorch's built-in NCCL flight recorder (Ansel et al., 2024), a feature that captures collective metadata and stack traces into a ring buffer, and hence allowing us to diagnose hangs and performance issues quickly at scale, particularly with regard to NCCL. Using this, we efficiently record every communication event and the duration of each collective operation, and also automatically dump tracing data on NCCL watchdog or heartbeat timeout. We enable more computationally intensive tracing operations and metadata collection selectively as needed live in production through online configuration changes (Tang et al., 2015) without needing a code release or job restart.

Debugging issues in large-scale training is complicated by the mixed use of NVLink and RoCE in our network. Data transfer over NVLink typically occurs through load/store operations issued by CUDA kernels, and failures in either the remote GPU or NVLink connectivity often manifest as stalled load/store operations within CUDA kernels without returning a clear error code. NCCL-X enhances the speed and accuracy of failure detection and localization through a tight co-design with PyTorch, allowing PyTorch to access NCCL X’s internal state and track relevant information. While stalls due to NVLink failures cannot be completely prevented, our system monitors the state of the communication library and automatically times out when such a stall is detected. Additionally, NCCL X traces the kernel and network activities of each NCCL X communication and provides a snapshot of the failing NCCL X collective’s internal state, including finished and pending data transfers between all ranks. We analyze this data to debug NCCL X scaling issues.

Sometimes, hardware issues may cause still-functioning but slow stragglers that are hard to detect. Even a single straggler can slow down thousands of other GPUs, often appearing as functioning but slow communications. We developed tools to prioritize potentially problematic communications from selected process groups. By investigating just a few top suspects, we were usually able to effectively identify the stragglers.

One interesting observation is the impact of environmental factors on training performance at scale. For Llama 3 405B , we noted a diurnal 1-2% throughput variation based on time-of-day. This fluctuation is the result of higher mid-day temperatures impacting GPU dynamic voltage and frequency scaling. 

During training, tens of thousands of GPUs may increase or decrease power consumption at the same time, for example, due to all GPUs waiting for checkpointing or collective communications to finish, or the startup or shutdown of the entire training job. When this happens, it can result in instant fluctuations of power consumption across the data center on the order of tens of megawatts, stretching the limits of the power grid. This is an ongoing challenge for us as we scale training for future, even larger Llama models.

3.3.4 可靠性和操作挑战

使用 16,000 个 GPU（图形处理单元）进行训练的复杂性和潜在故障情况，远远超过了我们过去运营的大型 CPU（中央处理器）集群。更重要的是，训练过程的同步特性使得系统对错误的容忍度较低 —— 哪怕只有一个 GPU 出现故障，可能就需要重新启动整个训练任务。尽管面临这些挑战，在 Llama 3 的训练过程中，我们仍然实现了超过 90% 的有效训练时间。这个成果是在支持自动化集群维护的同时取得的，包括固件和 Linux 内核升级 [Virajman 和 Leonhardt，2024]，这些维护工作每天至少会导致一天的训练中断。这里的「有效训练时间」是指在总体时间中，实际用于有效训练的时间比例。

在为期 54 天的预训练观察期内，我们总共遇到了 466 次任务中断。其中 47 次是计划内中断，这些中断是由自动维护操作（如固件升级）或操作员主动进行的操作（如配置或数据集更新）引起的。剩下的 419 次是意外中断，我们在表 5 中对这些中断进行了分类。

大约 78% 的意外中断可以归因于已确认的硬件问题（如 GPU 或主机组件故障），或疑似与硬件相关的问题（如静默数据损坏（silent data corruption）和计划外的单个主机维护事件）。其中，GPU 问题是最大的类别，占所有意外问题的 58.7%。

尽管故障次数很多，但在整个观察期内只有三次需要人工进行重大干预，其余问题都由自动化系统处理。

为了提高 AI 模型的实际训练效率，我们采取了一系列措施来优化训练过程。首先，我们缩短了任务启动和数据保存的时间。其次，我们开发了一套工具，用于快速诊断和解决训练过程中出现的问题。

我们广泛使用了 PyTorch（一个流行的深度学习框架）内置的 NCCL 飞行记录器（NCCL flight recorder）(Ansel et al., 2024）。这个功能就像飞机的黑匣子，能够持续记录训练过程中的重要信息和运行轨迹。这些信息被存储在一个循环使用的内存空间中，使我们能够在大规模训练环境下快速发现并诊断系统卡顿和性能问题，特别是与 NCCL（一个用于集群间通信的库）相关的问题。

利用这个工具，我们可以高效地记录每一次设备间的通信事件，以及每次协同操作的持续时间。此外，当 NCCL 的监控程序检测到异常或者系统心跳超时时，它会自动保存详细的跟踪数据，便于我们后续分析。

更重要的是，我们开发了一种在线配置更新的机制（Tang et al., 2015）。这使我们能够在生产环境中根据需要灵活地开启一些高强度的跟踪操作和数据收集功能，而无需重新发布代码或重启整个训练任务。这大大提高了我们调试和优化系统的灵活性和效率。

在大规模训练中，由于我们的网络同时使用了 NVLink 和 RoCE（RDMA over Converged Ethernet）两种技术，调试问题变得更加复杂。通过 NVLink 进行的数据传输通常是由 CUDA 内核发起的读写操作完成的。当远程 GPU 或 NVLink 连接出现故障时，通常表现为 CUDA 内核中的读写操作卡住，而不会返回明确的错误代码。

为了提高故障检测和定位的速度和准确性，NCCL-X（NVIDIA Collective Communications Library eXtended）与 PyTorch 进行了深度的协同设计。这使得 PyTorch 能够访问 NCCL X 的内部状态并跟踪相关信息。虽然我们无法完全避免由 NVLink 故障引起的停滞，但我们的系统会监控通信库的状态，并在检测到此类停滞时自动超时。

此外，NCCL X 会跟踪每次通信的内核和网络活动，并提供失败的 NCCL X 集体操作的内部状态快照，包括所有计算节点之间已完成和待处理的数据传输。我们通过分析这些数据来调试 NCCL X 的扩展问题。

有时，硬件问题可能导致某些节点虽然仍在运行，但速度变慢，这种情况很难被检测到。即使只有一个节点变慢，也可能拖慢数千个其他 GPU 的速度，通常表现为通信正常但速度缓慢。为了解决这个问题，我们开发了一些工具，可以优先关注来自特定进程组的潜在问题通信。通过重点调查几个最可疑的对象，我们通常能够有效地识别出这些变慢的节点。

研究人员发现，环境因素对大规模训练性能有显著影响。以 Llama 3 405B 模型（一个拥有 4050 亿参数的大语言模型）为例，我们观察到其吞吐量会随一天中的时间变化而出现 1-2% 的波动。这种波动主要是由于中午较高的温度影响了 GPU（图形处理器）的动态电压和频率调节（一种根据工作负载自动调整 GPU 性能的技术）。

在训练过程中，成千上万的 GPU 可能会同时增加或减少功耗。这种情况可能发生在所有 GPU 等待检查点保存（即定期保存模型训练状态）或集体通信（GPU 之间的数据交换）完成时，或者在整个训练任务启动或关闭时。当这种情况发生时，可能导致数据中心的瞬时功耗波动高达数十兆瓦，这对电力供应系统造成了巨大压力。随着我们为未来更大规模的 Llama 模型扩大训练规模，如何应对这一挑战将是我们持续面临的问题。

#### 3.4 Training Recipe

The recipe used to pre-train Llama 3 405B consists of three main stages: (1) initial pre-training, (2) long-context pre-training, and (3) annealing. The three stages are described separately below. We use similar recipes to pre-train the 8B and 70B models.

3.4 训练方案

Llama 3 405B 模型的预训练方案包含三个主要阶段：(1）初始预训练，(2）长上下文预训练，以及（3）退火（在机器学习中，指逐步降低学习率的过程）。下面将分别介绍这三个阶段。我们也使用了类似的方案来预训练 8B 和 70B 参数的模型。

##### 3.4.1 Initial Pre-Training

We pre-train Llama 3 405B using a cosine learning rate schedule, with a peak learning rate of $8 \times 10^{-5}$, a linear warm up of 8,000 steps, and a decay to $8 \times 10^{-7}$ over 1,200,000 training steps. We use a lower batch size early in training to improve training stability, and increase it subsequently to improve efficiency. Specifically, we use an initial batch size of 4M tokens and sequences of length 4,096, and double these values to a batch size of 8M sequences of 8,192 tokens after pre-training 252M tokens. We double the batch size again to 16M after pre-training on 2.87T tokens. We found this training recipe to be very stable: we observed few loss spikes and did not require interventions to correct for model training divergence.

Adjusting the data mix. We made a several adjustments to the pre-training data mix during training to improve model performance on particular downstream tasks. In particular, we increased the percentage of non-English data during pre-training to improve the multilingual performance of Llama 3. We also upsample mathematical data to improve the model’s mathematical reasoning performance, we added more recent web data in the later stages of pre-training to advance the model’s knowledge cut-off, and we downsampled subsets of the pre-training data that were later identified as being lower quality.

3.4.1 初始预训练

我们使用一种特殊的学习率调整策略（称为余弦学习率计划）来预训练 Llama 3 405B 模型。这个策略的特点是学习率先上升后下降，就像余弦曲线一样。具体来说，学习率从一个较低的值开始，在 8,000 步的预热阶段内逐渐上升到峰值 $8 \times 10^{-5}$，然后在接下来的 1,200,000 步训练中缓慢下降到 $8 \times 10^{-7}$。

为了提高训练的稳定性和效率，我们采用了动态调整批量大小（batch size）的方法。在训练初期，我们使用较小的批量大小，具体为 4M 个 token（标记），每个序列长度为 4,096。当预训练达到 252M 个 token 后，我们将批量大小和序列长度都翻倍，变成 8M 个 token，每个序列长度为 8,192。在预训练量达到 2.87T 个 token 后，我们再次将批量大小翻倍到 16M。

这种训练方案 proved 非常稳定：我们很少观察到模型性能突然变差（即损失值突然增大）的情况，也不需要人为干预来防止模型训练出现异常。

在训练过程中，我们还对预训练数据的组成进行了多次调整，以提升模型在特定任务上的表现：

1. 增加了非英语数据的比例，以提高 Llama 3 在多语言任务上的能力。

2. 增加了数学相关数据的比重，以提升模型的数学推理能力。

3. 在预训练后期加入了更多最新的网络数据，使模型能够获取更新的知识。

4. 减少了一些后来被发现质量较低的数据集的使用比例。

##### 3.4.2 Long Context Pre-Training

In the final stages of pre-training, we train on long sequences to support context windows of up to 128K tokens. We do not train on long sequences earlier because the compute in self-attention layers grows quadratically in the sequence length. We increase the supported context length in increments, pre-training until the model has successfully adapted to the increased context length. We assess successful adaptation by measuring whether (1) model performance on short-context evaluations has recovered completely and (2) the model perfectly solves “needle in a haystack” tasks up to that length. In Llama 3 405B pre-training, we increased context length gradually in six stages, starting from the original 8K context window and ending in the final 128K context window. This long-context pre-training stage was performed using approximately 800B training tokens.

Figure 7 Illustration of the overall post-training approach for Llama 3. Our post-training strategy involves rejection sampling, supervised finetuning, and direct preference optimization. See text for details.

3.4.2 长上下文预训练

在预训练的最后阶段，我们对长序列进行训练，以支持最多 128K 个标记（token）的上下文窗口。我们之所以不在早期阶段训练长序列，是因为自注意力层的计算量随序列长度呈二次方增长。我们采取逐步增加支持的上下文长度的策略，持续预训练直到模型成功适应新的上下文长度。我们通过两个指标来评估适应是否成功：(1）模型在短上下文评估中的性能是否完全恢复到之前的水平，以及（2）模型是否能在增加的长度范围内完美解决「信息检索」类任务（即在大量无关文本中准确找到特定信息）。在 Llama 3 405B 的预训练过程中，我们从最初的 8K 上下文窗口开始，分六个阶段逐步增加上下文长度，最终达到 128K 的上下文窗口。这个长上下文预训练阶段总共使用了约 8000 亿个训练标记。

图 7：Llama 3 整体后处理训练方法的示意图。我们的后处理训练策略包括拒绝采样、有监督微调和直接偏好优化。详细内容请参见正文。

##### 3.4.3 Annealing

During pre-training on the final 40M tokens, we linearly annealed the learning rate to 0, maintaining a context length of 128K tokens. During this annealing phase, we also adjusted the data mix to upsample data sources of very high quality; see Section 3.1.3. Finally, we compute the average of model checkpoints (Polyak (1991) averaging) during annealing to produce the final pre-trained model.

3.4.3 学习率退火

在最后 4000 万个标记的预训练过程中，我们将学习率线性降低至 0，同时保持 128K 个标记的上下文长度。在这个学习率退火阶段，我们还调整了数据混合比例，增加了高质量数据源的采样比例；具体细节请参见 3.1.3 节。最后，我们在退火期间采用 Polyak（1991）提出的模型参数平均方法，即计算多个模型检查点的参数平均值，以生成最终的预训练模型。这种方法有助于提高模型的泛化能力和稳定性。




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
