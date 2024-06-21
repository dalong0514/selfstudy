## 2024023Navigating-the-Path-of-Writing

Navigating the Path of Writing: Outline-guided Text Generation with Large Language Models

Yukyung Lee, Soonwon Ka, Bokyung Son, Pilsung Kang, Jaewook Kang
Korea University, Naver AX Center

### Abstract

Large Language Models (LLMs) have significantly impacted the writing process, enabling collaborative content creation and enhancing productivity. However, generating high-quality, user-aligned text remains challenging. In this paper, we propose Writing Path, a framework that uses explicit outlines to guide LLMs in generating goal-oriented, high-quality pieces of writing. Our approach draws inspiration from structured writing planning and reasoning paths, focusing on capturing and reflecting user intentions throughout the writing process. We construct a diverse dataset from unstructured blog posts to benchmark writing performance and introduce a comprehensive evaluation framework assessing the quality of outlines and generated texts. Our evaluations with GPT-3.5-turbo, GPT-4, and HyperCLOVA X demonstrate that the Writing Path approach significantly enhances text quality according to both LLMs and human evaluations. This study highlights the potential of integrating writing-specific techniques into LLMs to enhance their ability to meet the diverse writing needs of users.

写作之路：大纲指导下的大语言模型文本生成

摘要

大语言模型（LLMs）已经极大地改变了写作过程，使得协同创作和提升生产力成为可能。然而，生成高质量且符合用户需求的文本依然存在挑战。本文提出了一个名为 Writing Path 的框架，通过使用明确的大纲来指导 LLMs 生成目标明确的高质量文本。我们的方法借鉴了结构化写作规划和推理路径的理念，重点在于整个写作过程中捕捉和反映用户的意图。我们从非结构化的博客文章中构建了一个多样化数据集，作为写作性能的基准，并引入了一个全面的评估框架来评估大纲和生成文本的质量。通过对 GPT-3.5-turbo、GPT-4 和 HyperCLOVA X 的评估，结果显示 Writing Path 方法显著提升了文本质量，无论是 LLMs 还是人类评测结果均表明如此。本研究强调了将写作特定技术整合到 LLMs 中，以更好地满足用户多样化写作需求的潜力。

### 01. Introduction

Writing is a fundamental means of structuring thoughts and conveying knowledge and personal opinions. This process requires systematic planning and reviewing in detail. Hayes describes writing as a complex problem-solving process and explores how planning and execution interact in writing. That is, writing involves more than merely generating text; it encompasses developing a proper understanding of the topic, gathering relevant subject matter, and implementing thorough structuring.

Recent advancements in Large Language Models (LLMs) have significantly impacted the writing workflow, enhancing both its efficiency and productivity. One significant area of exploration is the collaborative use of LLMs in writing processes, which typically involves the establishment of a writing plan and iterative improvement of interim outputs through revision, as illustrated in Figure 1 (b). Here, the focus is on leveraging the remarkable generative capabilities of LLMs to gain advantages in terms of fluency, consistency, and grammatical accuracy. Productivity tools like Notion AI, Jasper, Writesonic, sudoWrite, and Cohesive are practical examples of leveraging LLMs to support users in creating content more efficiently. However, generating high-quality content that accurately aligns with specific user intentions and requirements still holds room for improvement.

To address this, we propose Writing Path, a methodology designed to incorporate user requirements such as desired topic, textual flow, keyword inclusion, and search result integration into the writing process. Writing Path emphasizes the importance of systematic planning and a clear outline from the early stages of writing. Inspired by the structured writing plan of Hayes and the reasoning path of Wei et al., the Writing Path collects ideas and creates outlines that encapsulate the user's intentions prior to producing the specific content rather than directly outputting the final text. Furthermore, the initial outlines are further augmented with additional information through information browsing. Such a structured approach offers enhanced control over the text generation process and improves the quality of the content produced by LLMs.

We also utilize a multi-aspect writing evaluation framework to assess the intermediate and final productions from the Writing Path, offering a way to evaluate the quality of free-form text without relying on reference texts. Taking into account that conventional Likert scales (1-5 point ratings) are inappropriate for evaluating creative tasks, particularly those related to writing, our evaluation framework aims to provide more precise and reliable assessments for the outlines and final texts.

For evaluation purposes, we construct a free-form blog text dataset incorporating a wide range of writing styles and topics from real users, including Beauty, Travel, Gardening, Cooking, and IT. Using this dataset, we evaluate how well the LLM outputs reflect the user's intentions. Applying the Writing Path to various LLMs, including GPT-3.5-turbo, GPT-4, and HyperCLOVA X, shows significant performance gains across all evaluated models. These results validate that our approach enables the models to maintain a stronger focus on the given topic and purpose, ultimately generating higher-quality text that more accurately reflects user intentions.

The main contributions of this study can be summarized as follows:

- We propose Writing Path, a novel framework that enhances the ability of LLMs to generate high-quality and goal-oriented pieces of writing by using explicit outlines.
- We customize a comprehensive evaluation framework that measures the quality of both the intermediate outlines and the final texts.
- We construct a diverse writing dataset from unstructured blog posts across multiple domains, providing useful information such as aligned human evaluation scores, such as metadata that can be used as input for LLM-based writing tasks, and aligned human evaluation scores for the generated texts.
- Our evaluation results indicate that the Writing Path markedly improves the quality of LLM-generated texts compared to methods that do not use intermediate outlines.

01 引言

写作是组织思想、传递知识和表达个人意见的基本方式。这一过程需要系统的规划和详细的审查。Hayes 将写作描述为一个复杂的问题解决过程，探索了规划与执行在写作中的相互作用。这意味着，写作不仅仅是生成文本；它还包括对主题的深入理解、收集相关材料以及实施详细的结构化安排。

近年来，大语言模型（LLMs）的进步显著提升了写作流程的效率和生产力。一个重要的研究方向是 LLMs 在写作过程中的协作使用，这通常包括制定写作计划和通过反复修订改进中间成果，如图 1（b）所示。重点在于利用 LLMs 的强大生成能力，提高文章的流畅性、一致性和语法准确性。Notion AI、Jasper、Writesonic、sudoWrite 和 Cohesive 等生产力工具就是利用 LLMs 帮助用户更高效创作内容的实际例子。然而，如何生成与用户特定意图和需求完全匹配的高质量内容仍需进一步改进。

为了解决这个问题，我们提出了 Writing Path 方法，它将用户的需求（如期望的主题、文本流、关键词包含和搜索结果整合）融入写作过程中。Writing Path 强调从写作初期阶段进行系统规划和明确大纲的重要性。受到 Hayes 的结构化写作计划和 Wei 等人提出的推理路径的启发，Writing Path 在生成具体内容之前，会收集想法并创建反映用户意图的大纲。此外，通过信息浏览进一步丰富初始大纲。这种结构化的方法增强了对文本生成过程的控制，提高了 LLMs 生成内容的质量。

我们还利用了一个多方面的写作评估框架来评估「写作路径」生成的中间和最终作品。这种方法无需依赖参考文本即可评估自由形式文本的质量。传统的李克特量表（1-5 分评分）并不适合评估创造性任务，特别是写作任务。因此，我们的评估框架旨在对大纲和最终文本进行更精确和可靠的评估。

为了评估效果，我们构建了一个包含广泛写作风格和主题的自由形式博客文本数据集。这些主题包括美容、旅行、园艺、烹饪和 IT。利用该数据集，我们评估了大语言模型（LLM）输出的文本在反映用户意图方面的表现。将「写作路径」应用于不同的 LLM，比如 GPT-3.5-turbo、GPT-4 和 HyperCLOVA X，结果显示所有模型的性能都有显著提升。我们的研究结果表明，这种方法能使模型更好地聚焦于给定的主题和目的，从而生成更高质量的文本，更准确地反映用户的意图。

本研究的主要贡献如下：

1、我们提出了一种新颖的框架「写作路径」，通过使用明确的大纲，提升了 LLM 生成高质量和目标导向写作的能力。

2、我们定制了一个全面的评估框架，用于衡量中间大纲和最终文本的质量。

3、我们构建了一个多样化的写作数据集，来源于多个领域的非结构化博客文章。该数据集提供了有用的信息，如对齐的人类评估分数和元数据，可用于 LLM 写作任务的输入。

4、我们的评估结果表明，「写作路径」显著提高了 LLM 生成文本的质量，与不使用中间大纲的方法相比，效果更好。

### 02. Related Work

2.1 Collaborative Writing with Language Models

Recent works that explore collaboration with LLMs during the writing process can be categorized into two aspects: 1) Outline Planning and Draft Generation, and 2) Recursive Re-prompting and Revision.

Outline Planning and Draft Generation involves incorporating the writer's intents and contextual information into LLM prompts to create intermediate drafts. Dramatron is a system for collaborative scriptwriting that automatically generates outlines with themes, characters, settings, flows, and dialogues. DOC improves the coherence of generating long stories by offering detailed control of their outlines, including analyses of generated outlines and suggestions for revisions to maintain consistent plot and style.

Building on these works, our Writing Path mimics the human writing process by structuring it into controllable outlines. While our approach shares similarities with DOC in terms of utilizing outlines, we diverge from focusing solely on story generation and propose a novel outline generation process that incorporates external knowledge through browsing. Our aim is to sophisticatedly control machine-generated text across a wide range of writing tasks.

Recursive Reprompting and Revision technique extends the potential of LMs to assist not only with draft generation but also with editing and revision processes. This approach employs LLM prompt chains such as planning - drafting - reviewing - suggesting revisions in an iterative fashion to enhance the quality of written content. Re3 (Yang et al., 2022) introduces a framework for maintaining the long-range coherence of draft generation. It operates separate rewriter and edit modules in its prompt chain to check and refine plot relevance and long-term factual consistency. PEER proposes a recursive revision framework based on the concept of self-training, where the model autonomously selects the editing operations for revision and provides explanations for the modifications it makes. RECURRENTGPT utilizes a recursive, language-based mechanism to simulate LSTM, enabling the generation of coherent and extended texts.

Our Writing Path differs from previous works in its goals for utilizing LLMs in the writing process. Instead of relying on an ad-hoc recursive writing structure that may be inefficient, we establish a systematic writing plan that guides the generation process from the very beginning. Furthermore, we focus on free-form text generation rather than story generation and do not require separate training for writing, planning, or editing.

02 相关工作

2.1 使用大语言模型进行协作写作

最近在写作过程中探索利用大语言模型（LLM）进行协作写作的研究可以分为两个方面：1）大纲规划和草稿生成，2）递归提示和修订。

大纲规划和草稿生成是指将作者的意图和上下文信息融入 LLM 的提示中，以创建中间草稿。Dramatron 是一个用于协作剧本写作的系统，可以自动生成包含主题、角色、设置、流程和对话的大纲。DOC 通过提供对大纲的详细控制，包括对生成大纲的分析和修订建议，从而保持一致的情节和风格，提高生成长篇故事的连贯性。

在这些工作的基础上，我们的 Writing Path 模仿了人类的写作过程，将其结构化为可控的大纲。虽然我们的方法在利用大纲方面与 DOC 类似，但我们不仅限于故事生成，还提出了一种新的大纲生成过程，通过浏览引入外部知识。我们的目标是在各种写作任务中精确控制机器生成的文本。

递归重提示和修订技术不仅能帮助生成草稿，还能改进编辑和修订过程，从而进一步扩展了大语言模型（LLM）的潜力。这种方法使用 LLM 提示链，包括规划、草拟、审查和建议修订等步骤，通过迭代方式提升书面内容的质量。Re3 引入了一种框架，保持生成草稿的长程连贯性。它在提示链中使用单独的重写和编辑模块，以确保情节相关性和长期事实的一致性。PEER 基于自我训练概念，提出了递归修订框架，模型可以自主选择修订操作，并解释其修改原因。RECURRENTGPT 采用递归的语言机制来模拟 LSTM，实现连贯且延展的文本生成。

我们的写作路径在利用 LLM 进行写作的目标上与之前的工作有所不同。我们不依赖可能低效的临时递归写作结构，而是从一开始就制定系统的写作计划来指导生成过程。此外，我们专注于自由形式的文本生成，而不是故事生成，也不需要单独培训写作、规划或编辑。

2.2 Integrating External Information

Existing approaches have explored various methods to inject external knowledge into LLMs to improve their performance on text-generation tasks. For instance, Retrieval-Augmented Generation (RAG), and Toolformer have developed techniques to connect LLMs with external search tools, enabling them to gather relevant information and generate more informative and accurate responses. However, despite these contributions to improving LLMs' access to information, they inherently fall short of fully reflecting the diversity and complexity of the writing process.

Our work distinguishes itself from previous approaches by focusing on emulating the modern writing planning process. With this structured approach, an LLM can efficiently produce high-quality text, significantly contributing to improving the control and quality of the generated text.

2.2 整合外部信息

现有的方法已经探索了多种将外部知识注入 LLM 的方法，以提升其在文本生成任务中的表现。例如，检索增强生成（RAG）和 Toolformer 开发了将 LLM 与外部搜索工具连接的技术，使其能够收集相关信息并生成更具信息性和准确性的响应。然而，尽管这些方法改善了 LLM 获取信息的能力，但它们仍无法完全反映写作过程的多样性和复杂性。

我们的工作与之前的方法不同，专注于模拟现代写作的规划过程。通过这种结构化的方法，大语言模型（LLM）可以高效地产生高质量的文本，大大提高了生成文本的控制和质量。

2.3 Writing Evaluation

It is well-known that supervised metrics such as ROUGE and BLEU are ill-suited for evaluating natural language generation output, especially for open-ended writing tasks. Traditionally, such evaluation has depended on rubric-based human evaluation, which is a costly and time-consuming task. Recent advancements in LLMs have led to the exploration of new paradigms that utilize LMs for evaluating LM-generated text. However, to effectively assess free-form text, a more customized and interactive evaluation framework is needed.

We utilize CheckEval, a fine-grained and explainable evaluation framework, to assess free-form text writing. By customizing a checklist with specific sub-questions for each writing aspect, we provide a more reliable and accurate means of evaluating writing quality.

2.3 写作评估

众所周知，像 ROUGE 和 BLEU 这样的监督指标不适合评估自然语言生成的输出，尤其是开放式写作任务。传统上，这类评估依赖于基于评分标准的人类评估，而这通常成本高且耗时。最近，大语言模型（LLM）的进展促使人们探索利用语言模型（LM）来评估由其生成的文本。然而，要有效评估自由形式的文本，需要一个更为定制和互动的评估框架。

我们使用 CheckEval，这是一个细粒度且可解释的评估框架，用于评估自由形式的写作。通过为每个写作方面设计具体的子问题检查表，我们提供了一种更可靠和准确的方法来评估写作质量。

### 03. Design of Writing Path

We propose Writing Path, a systematic writing process to produce consistent, rich, and well-organized text with LLMs. Our method is inspired by how humans write; as humans typically collect materials and write an outline before writing the full text, Writing Path consists of five steps (Figure 2): (1) prepare metadata, (2) generate title and initial outline, (3) browse for information, (4) generate augmented outline, and (5) write the text. Each step is guided by a specific prompt configuration that aligns LLM output with specific step requirements. We also utilize information browsing to gather relevant content and keywords tailored to the writing stage.

The key steps of Writing Path are those that generate outlines as they establish a structured writing plan. Research suggests that a well-structured outline significantly impacts the quality of the written text. The initial sketch is transformed into a detailed outline, including the flow, style, keywords, and relevant information from search results. This outline provides a clearer view of the final text to the LLMs, enabling them to generate a draft that better aligns with the intent of the user. The specific steps are described as follows:

Step 1: Prepare Meta Data

The first step establishes the writing direction and target reader using metadata m, which includes (i) purpose, (ii) type, (iii) style, and (iv) keywords. To simulate this process, we converted human-written texts into metadata (see Section 4 for details of the dataset).

Step 2: Generate Title and Initial Outline

The second step generates the title t and initial outline O_init based on the metadata m from step 1, using the LLM function f_llm with a prompt configuration function φ_s. Here, s indicates the step index, and for step 2, the prompt configuration is φ_2:

t, O_init = f_llm(φ_2(m)),

The initial outline O_init consists of main headers h_{i,0}, where i denotes the header sequence. This outline serves as the scaffolding of the text, organizing the main ideas and laying out the key points.

Step 3: Browse for Information

The third step enriches the text by collecting additional information and keywords to reinforce the initial outline. We use the search function f_search with the generated title t as the query to retrieve the top-1 blog document, D_sim:

D_sim = f_search(t)

In our implementation, we employ the NAVER search API to retrieve the top-1 document among similar blog posts. From the blog document, we extract keywords K using the f_llm with a prompt configuration φ_3:

K = f_llm(φ_3(D_sim)),

The extracted keywords and additional information from the search results lead to a more specific writing plan, improving the quality of the generated text.

Step 4: Generate Augmented Outline

The fourth step refines the initial outline by adding subheadings and specific details to each section based on incorporating the keywords collected from the previous step. The augmented outline O_aug is generated using the LLM function f_llm with a prompt configuration φ_4 that takes the title t, keywords K, and initial outline O_init as inputs:

O_aug = f_llm(φ_4(t, k, O_init))
      = { (h_{1,0}, {h_{1,1}, h_{1,2}, ...}),
          (h_{2,0}, {h_{2,1}, h_{2,2}, ...}),
          ... }

The resulting augmented outline, O_aug, comprises headers (h_{i,0}) and their corresponding subheaders (h_{i,j}), where i denotes the header index, and j indexes the subheaders. This outline with detailed structure serves as a comprehensive writing plan, breaking down the text into manageable parts and providing clear direction for the content.

Step 5: Write the Text

Finally, the text for each section d^i is generated using the LLM function with a prompt configuration φ_5 that takes the title t and the corresponding section of the augmented outline O_aug^i as inputs:

d^i = f_llm(φ_5(t, O_aug^i))

The final blog document D is then compiled by concatenating all sections:

D = {d^1, d^2, ..., d^n}

Writing Path organically connects each step of the writing process, employing an outline to aggregate and manage complex and diverse information, and assists users in producing high-quality writing. The prompts utilized for the Writing Path are detailed in the Appendix.

03 写作路径的设计

我们提出了 Writing Path，这是一种系统的写作过程，旨在使用大语言模型生成一致、丰富且组织良好的文本。我们的方法受人类写作方式的启发；人类通常在写完整文之前会收集材料并写大纲，Writing Path 包含五个步骤（图 2）：1）准备元数据。2）生成标题和初始大纲。3）浏览信息。4）生成增强大纲。5）撰写文本。每个步骤都有特定的提示配置，引导大语言模型的输出符合步骤要求。我们还利用信息浏览来收集与写作阶段相关的内容和关键词。

Writing Path 的关键步骤是生成大纲，因为它们建立了结构化的写作计划。研究表明，一个结构良好的大纲能显著提高书面文本的质量。初步提纲会被转化为详细的大纲，包括逻辑流畅性、风格、关键词和搜索结果中的相关信息。这个大纲为大语言模型（LLMs）提供了一个更清晰的最终文本视图，使其生成的草稿更符合用户的意图。具体步骤如下：

步骤 1：准备元数据。

第一步会使用元数据 m 确定写作方向和目标读者，这些元数据包括（i）目的，(ii）类型，(iii）风格，和（iv）关键词。为了模拟这个过程，我们将人工撰写的文本转换成元数据（数据集的详细信息见第 4 节)。

步骤 2：生成标题和初步大纲。

第二步根据步骤 1 中的元数据 m 使用大语言模型函数 f_llm 和提示配置函数 φ_s 生成标题 t 和初步大纲 O_init。这里，s 表示步骤索引，对于步骤 2，提示配置是 φ_2：

t, O_init = f_llm（φ_2（m)),

初步大纲 O_init 包含主要标题 h_{i,0}，其中 i 表示标题的顺序。这个大纲作为文本的框架，组织主要思想并列出关键点。

步骤 3：浏览信息。

第三步通过收集附加信息和关键词来丰富初步大纲。我们使用搜索函数 f_search 以生成的标题 t 作为查询来检索最相似的博客文档 D_sim：

D_sim = f_search（t)

在我们的实现中，我们使用 NAVER 搜索 API 来检索最相似的博客文档。然后，我们使用带有提示配置 φ_3 的大语言模型从该博客文档中提取关键词 K：

K = f_llm（φ_3（D_sim)),

提取的关键词及搜索结果中的额外信息，使写作计划更加具体，从而提高了生成文本的质量。

第 4 步：生成增强大纲。

在第四步中，我们通过添加小标题和具体细节来完善初步大纲，这些细节基于前一步中收集的关键词。增强大纲 O_aug 由 LLM 函数 f_llm 和提示配置 φ_4 生成，输入包括标题 t、关键词 K 和初步大纲 O_init：

O_aug = f_llm（φ_4（t, k, O_init))
   = {(h_{1,0}, {h_{1,1}, h_{1,2}, ...}),
     （h_{2,0}, {h_{2,1}, h_{2,2}, ...}),
     ... }

生成的增强大纲 O_aug 包括标题（h_{i,0}）及其相应的小标题（h_{i,j})，其中 i 表示标题索引，j 表示小标题索引。这个详细结构的大纲作为一个全面的写作计划，将文本分解为可管理的部分，并为内容提供清晰的方向。

第 5 步：撰写文本。

最后，使用 LLM 函数和提示配置 φ_5 为每个部分生成文本 d^i，提示配置 φ_5 的输入为标题 t 和增强大纲 O_aug^i 的对应部分：

d^i = f_llm（φ_5（t, O_aug^i))

最终的博客文档 D 是通过连接所有部分编译而成的：

D = {d^1, d^2, ..., d^n}

「写作路径」有机地连接了写作过程的每一步，使用大纲来聚合和管理复杂和多样的信息，帮助用户生产高质量的写作。写作路径使用的提示在附录中详细说明。

### 04. Evaluation of Writing Path

Evaluating the effectiveness of Writing Path compared to existing writing support systems is challenging. Most previous studies do not directly utilize outlines in the writing process and, therefore, lack systematic methods to assess outline quality. Even when outlines are used, evaluation relies only on human evaluation. Moreover, the heavy reliance on human evaluation in current approaches is also problematic when assessing full texts, as it requires evaluating various aspects of the written work.

To address these limitations, we propose a novel evaluation framework for Writing Path that combines human and automatic evaluation to assess the quality of generated outlines and final texts from multiple perspectives. The proposed method establishes criteria for evaluating outline quality and sets standards for assessing the quality of final texts, enabling objective and reproducible validation of Writing Path's effectiveness as a writing support system.

04 写作路径的评估

评估 Writing Path 的效果相对于现有的写作支持系统是件难事。大多数过去的研究并没有在写作过程中直接使用大纲，因此缺乏系统的方法来评估大纲的质量。即使使用了大纲，评估也主要依赖人工判断。此外，目前的方法在评估完整文本时高度依赖人工评估，这也是一个问题，因为它需要评估文本的各个方面。

为了解决这些问题，我们提出了一种新的 Writing Path 评估框架，结合人工和自动评估，从多个角度评估生成的大纲和最终文本的质量。该方法建立了评估大纲质量的标准，并设定了评估最终文本质量的标准，使 Writing Path 的有效性评估更加客观和可重复。

4.1 Outline Evaluation

4.1.1 Automatic Evaluation

We adapt various metrics to evaluate the logical alignment, coherence, diversity, and repetition in outlines, following criteria established in linguistic literature.

- Logical alignment: Based on Chen and Eger, we utilize Natural Language Inference (NLI) which examines whether the headers and subheaders within an outline logically connect, ensuring the structural integrity necessary for coherent argumentation.
- Coherence: Through Topic Coherency metrics such as NPMI and UCI, this aspect assesses the thematic uniformity across the sections of outline, verifying a consistent narrative.
- Diversity: We measure the breadth of topics addressed by applying Topic Diversity metrics, aiming to ensure that the content of outline is comprehensive and varied.
- Repetition: Self-BLEU is used to gauge the degree of redundancy within the outline, prioritizing efficiency in information presentation by minimizing repetition.

Note that coherency and diversity exhibit a trade-off relationship; maintaining coherence while covering a wide range of topics is essential to ensure the effectiveness of the outline in guiding the writing process.

4.1 大纲评估

4.1.1 自动评估我们使用多种指标来评估大纲的逻辑一致性、连贯性、多样性和重复性，这些指标基于语言学文献中的标准。

- 逻辑一致性：根据 Chen 和 Eger 的研究，我们使用自然语言推理（NLI）来检查大纲的标题和子标题之间是否存在逻辑连接，以确保结构完整性和连贯性。
- 连贯性：通过 NPMI 和 UCI 等主题连贯性指标，我们评估大纲各部分的主题统一性，确保叙述的一致性。
- 多样性：我们应用主题多样性指标来衡量大纲中涉及主题的广度，确保内容丰富多样。
- 重复性：使用自我 BLEU 来测量大纲中信息的冗余程度，优先减少重复，提高信息呈现的效率。

注意到连贯性和多样性之间存在权衡；在涵盖广泛主题的同时保持连贯性对于确保大纲在指导写作过程中的有效性非常重要。

4.1.2 Human Evaluation

In addition to automatic evaluation metrics, we conduct a human evaluation to assess aspects of the generated outlines that are difficult to capture solely with automatic measures. The human evaluation criteria are based on aspects considered in previous studies on text coherence, relevance, and quality assessment. For both initial and augmented outlines, the human evaluation is performed on the following five aspects, using a 1-4 point scale:

- Cohesion: Evaluates whether the title and outline are semantically consistent.
- Natural Flow: Assesses whether the outline flows in a natural order.
- Diversity: Evaluates whether the outline consists of diverse topics.
- Redundancy: Assesses whether the outline avoids semantically redundant content.

Furthermore, we use two additional aspects for evaluating the augmented outline:

- Usefulness of Information: Assesses whether the augmented outline provides useful information beyond the initial outline.
- Improvement: Evaluates whether significant improvements have been made in the augmented outline compared to the initial outline, using a binary scale.


4.1.2 人工评估除了自动评估指标外，我们还进行人工评估，以评估生成大纲中一些自动方法难以捕捉的方面。人工评估标准参考了先前研究中的文本连贯性、相关性和质量评估标准。我们对初始大纲和增强大纲进行以下五个方面的评估，使用 1 到 4 分的评分标准：

- 连贯性：评估标题和大纲在语义上是否一致。
- 自然流畅性：评估大纲是否按自然顺序展开。
- 多样性：评估大纲是否包含多样化的主题。
- 冗余性：评估大纲是否避免重复内容。

此外，我们还通过两个额外方面来评估增强大纲：

- 信息的有用性：评估增强大纲是否提供了比初始大纲更多的有用信息。
- 改进：使用二元评分标准评估增强大纲是否比初始大纲有显著改进。

4.2 Writing Evaluation

Traditional evaluation metrics such as Likert scales (1-5 point ratings) are not well-suited for assessing creative tasks like long story generation. Acknowledging the need for more specific writing evaluation methods, we employ CheckEval to assess writing quality.

The Lee et al. reports an average Kendall Tau correlation of 0.4925 between human and LLM evaluations for the summarization task, exhibiting a higher level of agreement compared to other evaluation methods. This suggests that CheckEval effectively captures writing quality, establishing it as an appropriate tool for assessing the quality of model-generated texts.

CheckEval decomposes the evaluation aspects into more granular sub-questions, forming a detailed checklist. These aspect-based checklists can make performance evaluations by either humans or LLMs more fine-grained. Moreover, by explicitly capturing the evaluator's reasoning behind each rating, this approach enhances the explainability of the evaluation process. The CheckEval paper reports an average Kendall Tau correlation of 0.4925 between human and LLM evaluations for the summarization task, exhibiting a higher level of agreement compared to other evaluation methods. This suggests that CheckEval effectively captures writing quality, establishing it as an appropriate tool for assessing the quality of model-generated texts. To adapt CheckEval, we identified 7 aspects and selected relevant sub-aspects for each. We formulated them as binary(Yes/No) questions. This resulted in a checklist-style evaluation sheet for each sub-aspect, enabling an intuitive and structured assessment of the generated texts. The prompts utilized for the writing evaluation are detailed in the Appendix.

The evaluation criteria were selected based on prior linguistics research and finalized through a review and refinement process involving 6 writing experts. Details of the evaluation criteria are in Figure 3, and the instructions and checklist used during the evaluation process are presented in the Appendix.

4.2 写作评估

传统的评估指标，如李克特量表（Likert scales, 1 到 5 分评分），不适合评估长篇故事生成等创造性任务。因此，我们采用 CheckEval 来评估写作质量。

Lee 等人的研究显示，在摘要任务中，人类评估和大语言模型（LLM）评估之间的 Kendall Tau 相关系数平均值是 0.4925，这比其他评估方法的一致性更高。这表明，CheckEval 在捕捉写作质量方面非常有效，是评估模型生成文本质量的合适工具。

CheckEval 将评估内容细分为更具体的子问题，形成了详细的检查清单。这些基于不同方面的检查清单可以让人类或 LLM 的评估更加精细。此外，通过明确记录评估者对每个评分的理由，这种方法增强了评估过程的可解释性。为了适应 CheckEval，我们确定了 7 个方面，并为每个方面选择了相关的子方面，将这些子方面表述为是 / 否问题。这样，我们为每个子方面创建了检查清单式的评估表，使得生成文本的评估更加直观和有条理。评估所用的提示在附录中有详细说明。

评估标准是基于之前的语言学研究选择的，并在 6 位写作专家的审查和改进后最终确定。评估标准的详细信息见图 3，评估过程中使用的说明和检查清单在附录中展示。

### 05. Experimental Setting

5.1 Dataset

In this study, we constructed a Korean dataset based on real user-generated blog posts to assess the effects of the Writing Path framework. The dataset covers five common blog domains: travel, beauty, gardening, IT, and cooking. We selected 20 blog posts for each domain, resulting in a total of 100 seed data points.

For seed data construction, we generated metadata, including purpose, topic, keywords, and expected reader, based on the title and content of the selected blog posts. This metadata is the input to the Writing Path, helping the model understand the context of the post and generate relevant outlines and text. 

Using the seed data, we created a test dataset of 1,100 instances per model under evaluation. Each data point includes the outputs of each Writing Path step: an outline, additional information, an augmented outline, and the final text. With analysis experiments as well, we generated a total of 1,500 posts for each model, resulting in 4,500 instances in total. Each data point includes all the intermediate outputs of the Writing Path: metadata, outline, browsing output, augmented outline, and text. For human evaluation, we randomly sampled 10% of the outlines and texts and assessed their scores. The final texts were evaluated by human experts, and the dataset aligns the generated outputs from three models with the human scores.

This dataset is significant in two ways. First, it provides the materials to validate the impact of applying the Writing Path framework to LLMs. Second, by aligning model outputs with human evaluation scores, our dataset provides a valuable resource for studying writing evaluation methods. To the best of our knowledge, there is currently no Korean dataset that maps human scores to writing task outputs, making our contribution particularly valuable for advancing research in this area.

05 实验设置

5.1 数据集

在本研究中，我们基于真实用户生成的博客文章，构建了一个韩语数据集来评估 Writing Path 框架的效果。数据集覆盖了五个常见的博客领域：旅游、美容、园艺、IT 和烹饪。每个领域选取了 20 篇博客文章，共 100 个种子数据点。

在构建种子数据时，我们根据博客文章的标题和内容生成了元数据，包括目的、主题、关键词和预期读者。这些元数据输入到 Writing Path，帮助模型理解文章的上下文，并生成相关的大纲和文本。

利用这些种子数据，我们为每个评估模型创建了一个包含 1,100 个实例的测试数据集。每个数据点包括 Writing Path 每个步骤的输出：大纲、附加信息、增强大纲和最终文本。通过分析实验，我们为每个模型生成了 1,500 篇文章，总共 4,500 个实例。每个数据点包含 Writing Path 的所有中间输出：元数据、大纲、浏览输出、增强大纲和文本。

在人工评估部分，我们随机抽取了 10% 的大纲和文本进行打分。最终文本由专家评估，数据集将三个模型的生成输出与人工评分对齐。

这个数据集有两大重要意义。首先，它提供了验证 Writing Path 框架对大语言模型（LLM）影响的材料。其次，通过将模型输出与人工评估分数对齐，我们的数据集为研究写作评估方法提供了宝贵资源。据我们了解，目前还没有一个将人工评分与写作任务输出映射的韩语数据集，这使我们的贡献在推动该领域研究方面尤为重要。

5.2 Model

In our experiments, we used three models: GPT-3.5-turbo, GPT-4, and HyperCLOVA X. For evaluation, we used GPT-4-turbo model.

5.2 模型

在实验中，我们使用了三种模型：GPT-3.5-turbo、GPT-4 和 HyperCLOVA X。在评估中，我们使用了 GPT-4-turbo 模型。

5.3 Human Evaluation

To evaluate the outlines and writings, we hired 12 crowd workers in total. Since the outlines are relatively simple and short, we employed 6 native Korean speakers to assess them. For the more detailed and rigorous writing evaluation, we recruited 6 professional writers and teachers as writing experts.

5.3 人类评估

为了评估大纲和写作质量，我们总共雇佣了 12 名评估者。由于大纲相对简单和简短，我们聘请了 6 名以韩语为母语的评估者来进行评估。对于更详细和严格的写作评估，我们则招聘了 6 名专业作家和教师作为写作专家。

### 06. Experimental Results

6.1 Effectiveness of Writing Path

To verify that going through the Writing Path improves the final writing quality, we designed an analysis incorporating three cases (Figure 4): (1) writing from metadata, (2) writing from the initial outline, (3) writing from the augmented outline, where this final case corresponds to the complete Writing Path pipeline.

Figure 5 presents the results from both (a) LLM and (b) human evaluation using CheckEval. Both consistently show progressive improvement as more components of the Writing Path are incorporated, while the model rankings are in different order between the two evaluation methods.

Specifically, The results show that using the augmented outline (aug) leads to better writing quality compared to using only metadata (meta), indicating that the quality of writing improves significantly when the full Writing Path pipeline is employed. Moreover, the results demonstrate that using the augmented outline (aug) yields better writing quality than using the initial outline (init), suggesting that the content enrichment process in the Writing Path further enhances writing quality.

We consider seven key aspects (Section 4.2) for evaluating the quality of writing. CheckEval's binary responses for each aspect allow for identifying the specific factors contributing to the assessments. We found that logical fluency, coherence, consistency, and specificity significantly contribute to the improvement of text quality through the Writing Path (Figure 6).

During the evaluation of the writing quality, writing experts assigned binary overall quality ratings (1 for high quality, 0 for low quality) to the texts. We employed the Kendall tau correlation to examine the relationship between the overall binary ratings and the scores for each evaluation aspect. The analysis (Figure 7) revealed a significant correlation for all the aspects we designed. Interestingly, logical fluency, specificity, and coherence, which were found to be particularly important in determining the perceived quality of written content, are among the aspects that showed the most significant improvement through the Writing Path (Figure 6). The progressive improvement in these aspects can be attributed to the effectiveness of using outlines. The initial outline (init) helps organize information more logically and coherently compared to using only metadata (meta), while the augmented outline (aug) further enhances the consistency and richness of the content. These findings highlight the importance of using outlines in the writing process and demonstrate how their gradual enhancement leads to better-structured, more coherent, and content-rich texts, ultimately improving the overall quality of the written output.

To further analyze the quality of the text generated through the complete Writing Path pipeline, we conducted a human evaluation based on the CheckEval framework. The results are presented in Table 1. The analysis by six writing experts showed that GPT-4 and HyperCLOVA X generally performed better than GPT-3.5 in terms of writing quality. HyperCLOVA X exhibited higher scores in specificity compared to other models, which is consistent with the findings reported in KMMLU regarding the advantages of language-specific models. Detailed performance metrics across various domains and further LLM evaluations can be found in Appendix.

06 实验结果

6.1 写作路径的有效性

为了验证写作路径对最终写作质量的提升效果，我们设计了包含三种情况的分析 （图 4）：（1）从元数据写作，（2）从初始大纲写作，（3）从增强大纲写作，其中最后一种情况对应于完整的写作路径。

图 5 展示了来自（a）大语言模型和（b）使用 CheckEval 的人类评估结果。两种评估方法一致表明，随着写作路径中的组件逐渐增加，写作质量也逐步提升，但模型在两种评估方法中的排名顺序有所不同。

具体来说，结果显示，使用增强大纲（aug）比仅使用元数据（meta）能带来更高的写作质量，这说明当采用完整的写作路径时，写作质量会显著提高。此外，结果还显示，使用增强大纲（aug）比使用初始大纲（init）能够带来更高的写作质量，表明写作路径中的内容丰富过程进一步提升了写作质量。

我们从七个关键方面（第 4.2 节）评估写作质量。CheckEval 对每个方面的二元响应使我们能够识别出具体的评估因素。我们发现，逻辑流畅性、连贯性、一致性和特异性是通过写作路径提升文本质量的关键因素（图 6）。

在评估写作质量时，写作专家对文本进行了整体质量的二元评分（高质量为 1，低质量为 0）。我们使用 Kendall tau 相关性分析方法，来研究整体评分与各个评估方面得分之间的关系。分析结果（图 7）显示，我们设计的所有评估方面都存在显著相关性。值得注意的是，逻辑流畅性、具体性和连贯性在决定文本感知质量方面尤为重要，并且这些方面在 Writing Path（写作路径）中显示出显著的改进（图 6）。这些方面的逐步提升归功于大纲的有效使用。初始大纲（init）相比于仅使用元数据（meta），更有助于逻辑和连贯地组织信息，而增强大纲（aug）进一步提高了内容的一致性和丰富性。这些发现强调了在写作过程中使用大纲的重要性，并展示了大纲的逐步改进如何导致更结构化、更连贯和内容更丰富的文本，最终提高整体写作质量。

为了进一步分析通过完整 Writing Path 流水线生成的文本质量，我们基于 CheckEval 框架进行了人工评估。结果如表 1 所示。六位写作专家的分析表明，在写作质量方面，GPT-4 和 HyperCLOVA X 通常比 GPT-3.5 表现更好。HyperCLOVA X 在具体性方面的得分高于其他模型，这与 KMMLU 报告的语言特定模型的优势一致。跨各种领域的详细性能指标和进一步的大语言模型评估可以在附录中找到。

6.2 Outline Evaluation

Section 6.1 showed that using the augmented outline in the Writing Path pipeline led to better performance compared to using only the initial outline or metadata. To assess not only the impact of initial and augmented outlines on the quality of the final writing but also any differences in quality at the outline stage itself, we evaluated the initial and augmented outlines independently.

Automatic Evaluation
To see the effects of the outline augmentation module, we conducted automatic evaluations on the initial and augmented outlines using criteria described in Section 4.1.1. The results in Table 2 show significant improvements in Coherence and Repetition aspects for the augmented outlines compared to the initial ones, indicating that the outline augmentation process enhances content consistency and reduces unnecessary repetition. Notably, although Diversity and Coherence are often considered trade-offs, the augmented outlines in our study maintained Diversity while improving Coherence. This suggests that the outline expansion module can increase consistency without compromising content diversity. Detailed performance across various text domains is in Appendix.

Human Evaluation
As described in Section 4.1.2, we conducted human evaluations to assess the cohesion, natural flow, diversity, and redundancy of initial and augmented outlines. The augmented outlines demonstrated significant improvements in all aspects except cohesion, which slightly declined or remained stable. Nevertheless, the overall performance of the augmented outlines surpassed that of the initial outlines. Further evaluations of the augmented outlines were conducted on usefulness and improvement, which indicated the extent of useful information added and overall quality enhancement compared to the initial outlines. As shown in Figure 8, all models demonstrated improvements in both metrics, validating the power of the browsing step. Detailed performance across various text domains is in Appendix.

6.2 大纲评估

第 6.1 节显示，在 Writing Path 流程中使用增强版大纲比仅使用初始大纲或元数据的效果更好。为了评估初始和增强大纲对最终写作质量的影响，以及在大纲阶段本身的质量差异，我们分别对初始大纲和增强大纲进行了评估。

自动评估为了了解大纲增强模块的效果，我们根据第 4.1.1 节描述的标准，对初始大纲和增强大纲进行了自动评估。表 2 的结果显示，增强大纲在连贯性（Coherence）和重复性（Repetition）方面有显著改进，表明大纲增强过程提高了内容一致性并减少了不必要的重复。值得注意的是，尽管多样性（Diversity）和连贯性通常被认为是相互冲突的，但在我们的研究中，增强大纲在提高连贯性的同时保持了多样性。这表明，大纲扩展模块能够在不影响内容多样性的情况下增加一致性。不同文本领域的详细表现见附录。

人工评估如第 4.1.2 节所述，我们进行了人工评估，以评估初始大纲和增强大纲的凝聚力（Cohesion)、自然流畅性（Natural Flow)、多样性和冗余性（Redundancy)。增强大纲在除凝聚力外的所有方面都有显著改善，凝聚力则略有下降或保持稳定。尽管如此，增强大纲的整体表现仍然优于初始大纲。我们还对增强大纲的实用性和改进进行了进一步评估，结果显示，增强大纲在增加有用信息和提高整体质量方面表现优异。图 8 显示，所有模型在这两个指标上都有所改善，验证了浏览步骤的效果。不同文本领域的详细表现见附录。

### 07. Conclusion

We introduced Writing Path, a novel framework that enhances the ability of LLMs to generate high-quality and goal-oriented writing by employing explicit outlines. Our approach emphasizes the importance of providing structured guidelines to control the quality of the generated text from the early stages of the writing process. The Writing Path framework consists of five stages: prepare metadata, generate title and initial outline, browse for information, generate augmented outline, then write the text.

We verified the impact of Writing Path by conducting a comprehensive evaluation that incorporates automatic and human evaluations covering a wide range of aspects. Our experimental results demonstrate that texts generated following the full Writing Path approach, which includes the use of augmented outlines, exhibit superior performance compared to texts produced using only initial outlines or without any intermediate outlines. We also proposed a framework for assessing the Writing Path's intermediate outlines, which found that augmented outlines have better inherent quality than initial outlines, demonstrating the importance of outline augmentation steps.

07 结论

我们介绍了 Writing Path，这是一种新颖的框架，通过使用明确的大纲提升大语言模型（LLM）生成高质量、目标明确的写作能力。我们的方法强调在写作初期提供结构化指南，以确保生成文本的质量。Writing Path 框架包括五个阶段：准备元数据、生成标题和初始大纲、浏览信息、生成增强大纲以及撰写文本。

我们通过全面评估验证了 Writing Path 的效果，评估方法包括自动评估和人工评估，涵盖了多个方面。实验结果表明，采用完整 Writing Path 方法生成的文本，特别是使用增强大纲的文本，其表现优于仅使用初始大纲或无中间大纲的文本。我们还提出了一个评估 Writing Path 中间大纲的框架，发现增强大纲的内在质量优于初始大纲，凸显了大纲增强步骤的重要性。

### Acknowledgments

This research project was conducted as part of the NAVER HyperCLOVA-X and CLOVA for Writing projects. We express our gratitude to Nako Sung for his thoughtful advice on writer LLMs and to the NAVER AX-SmartEditor team. Additionally, we would like to thank the NAVER Cloud Conversational Experience team for their practical assistance and valuable advice in creating the blog dataset. We appreciate Jaehee Kim, Hyowon Cho, Keonwoo Kim, Joonwon Jang, Hyojin Lee, Joonghoon Kim, Sangmin Lee, and Jaewon Cheon for their invaluable feedback and evaluation. We also thank DSBA NLP Group members for their comments on the paper.

致谢

本研究项目是 NAVER 的 HyperCLOVA-X 和 CLOVA for Writing 项目的一部分。我们感谢 Nako Sung 对编写大语言模型的宝贵建议，以及 NAVER AX-SmartEditor 团队的大力支持。此外，我们还要感谢 NAVER Cloud Conversational Experience 团队在创建博客数据集方面的实际帮助和建议。我们特别感谢 Jaehee Kim、Hyowon Cho、Keonwoo Kim、Joonwon Jang、Hyojin Lee、Joonghoon Kim、Sangmin Lee 和 Jaewon Cheon 的宝贵反馈和评估。我们也感谢 DSBA NLP Group 成员对本文的意见。

### A Prompts

Writing Evaluation Prompt

You will be given one text written for a blog post.

Your task is to rate the written text on one metric.

Please read and understand these instructions carefully.

Keep this document open while reviewing and refer to it as needed.

You are a writing expert! it is crucial to apply a robust evaluation.

Evaluation Criteria:

{aspect} - {definition}

\###Guidelines###

1. Read these guidelines completely.

2. Read the Written Text attentively.

3. Comprehend the questions and the meaning of the {aspect).

4. Answer each question with 'yes' or 'no', without any explanations.

5. Use the prescribed answer format.

\### Output Format###

Q: [Question] A: [Answer]
Q: [Question] A: [Answer]
...

\### Questions###

Q. {question}

Blog text: {writing}

Your Answers:

Table 8: Writing Evaluation Prompt for Checklist-based Assessment.

---

Prompt for Metadata construction (step #1)

We aim to systematically organize blog posts by dividing them into four categories:

1. the purpose of the post, 2. the type of post, 3. the style of the post, and 4. keywords.

An example of the expected format is provided below.

{examples}

Similar to the example provided, please categorize the blog post below in detail according to: 1. purpose, 2. type, 3. style, and 4. keywords, where keywords are composed of words.

\==Blog post==

{original blog text}

Prompt for Generation of Title and Initial Outline(step #2)

Based on the metadata, I plan to create the title and a simple table of contents for the article.

Below is an example of the desired format.

{example}

Following the example above, based on the post information provided below,

only create "==Title==" and a brief "==Initial Outline==".

Do not generate an excessively long table of contents.

The table of contents should not be a simple list;

The table of contents must be numbered in sequence.

do not write it in paragraph form. Do not create subheadings.

Only the title and table of contents should be generated.

You must strictly follow the format for the title and table of contents below.

{meta data}

==Meta data==

Prompt for Generation of Augmented Outline (step #4)

Map the necessary additional information below to create an augmented outline. Here is an example.

{example}

Following the method above, create an ==Augmented Outline==.

Specifically, incorporate new information as subheadings under the existing headings,

ensuring that each heading and its subheadings are themed consistently.

--Additional Information==

{additional information from browsing)

==Initial Outline==

{initial outline}

Prompt for Generation of Text (step #5)

Based on the title and current table of contents below,

I plan to write the i + 1th paragraph suitable for a blog post.

Writing should naturally follow the flow of the post information and the augmented outline.

Write in a friendly and attractive tone like bloggers, making it interesting for the reader.

The written content should be engaging and captivating for the reader.

==Augmented Outline==

{augmented outline}

==Meta Data==

{meta data)

Below are the title and current table of contents for writing the blog post.

{title}

==Title==

==Current Outline==

{current section}

Table 9: Writig Path Prompt for Each Stage.