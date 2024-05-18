## 2023053How-to-Build-an-AI-Tutor

[[2311.17696] How to Build an AI Tutor that Can Adapt to Any Course and Provide Accurate Answers Using Large Language Model and Retrieval-Augmented Generation](https://arxiv.org/abs/2311.17696)

https://arxiv.org/abs/2311.17696

Dong Chenxi

Department of Mathematics and Information Technology, The Education University of Hong Kong, Hong Kong Email: cdong@eduhk.hk

ABSTRACT: 

Artificial intelligence is transforming education through data-driven, personalized learning solutions. This paper introduces AI Tutor, an innovative web application that provides personalized tutoring in any subject using state-of-the-art Large Language Model (LLM). AI Tutor ingests course materials to construct an adaptive knowledge base tailored to the course. When students pose questions, it retrieves the most relevant information and generates detailed, conversational responses citing supporting evidence. The system is powered by advanced large language models and Retrieval-Augmented Generation (RAG) techniques for accurate, natural question answering. We present a fully-functional web interface and video demonstration that showcase AI Tutor's versatility across diverse subjects and its ability to produce pedagogically cogent responses. While an initial prototype, this work represents a pioneering step toward AI-enabled tutoring systems that can democratize access to high-quality, customized educational support.

Keywords: Intelligent Tutoring Systems, Large language model, Retrieval-Augmented generation, Adaptive education, Personalized learning

本文探讨了一种名为 AI Tutor 的创新网络应用程序，它利用人工智能通过数据驱动方法实现个性化学习，从而改变教育领域。AI Tutor 采用了最先进的大型语言模型（LLM），为任何学科提供定制化的辅导服务。通过吸收课程资料，它构建了一个适应课程需求的知识库。学生提出问题时，AI Tutor 能够检索到最相关的信息，并提供详细的对话式答案，同时引用支持的证据。这一系统结合了先进的大型语言模型和检索增强生成（RAG）技术，以确保问题回答的准确性和自然性。我们还展示了 AI Tutor 的一个功能完备的网络界面和视频演示，这些演示展示了它在多个学科上的广泛适用性以及其生成教育意义上有力回答的能力。尽管 AI Tutor 目前还是一个初步的原型，但它代表了向能够为广大用户提供高质量、个性化教育支持的 AI 辅导系统迈出的重要一步。

### 01. Introduction

The advent of artificial intelligence (AI) has instigated a transformational wave across various sectors, with education standing as a salient beneficiary. AI's unrivaled capacity to enable personalized and adaptive learning experiences has propelled intelligent tutoring systems to the forefront of modern educational paradigms (Kasneci et al., 2023). These systems, powered by AI, offer individualized feedback and interactive learning modules designed to cater to each student's distinct learning needs. Nonetheless, the challenge of developing AI tutors capable of delivering consistently accurate and dependable responses across diverse academic disciplines persists.

A notable hindrance to the reliability of AI in educational applications is the occurrence of 'information hallucination', a phenomenon where AI-generated responses, while appearing valid, deviate from factual accuracy (Nye et al., 2023). Such inconsistencies can undermine confidence in AI-centric educational systems (Kasneci et al., 2023). Furthermore, the customization of these systems to align with specific course content necessitates access to current and pertinent educational materials, a task often complicated by the multifaceted nature of academic disciplines.

To tackle these challenges, this paper introduces AI Tutor, a web application developed upon the sophisticated infrastructure of large language models (LLMs) and retrieval-augmented generation (RAG). AI Tutor is engineered to deliver accurate, contextually relevant responses by intelligently assimilating information from course-specific materials (Lewis et al., 2020). Our system signifies a substantial leap from traditional rule-based educational methodologies, amplifying the personalization potential of AI tutoring systems. The AI Tutor distinguishes itself with a user-centric web interface that streamlines the process of uploading course materials and submitting queries. It integrates robust vector embedding and storage systems for educational content, employs similarity-based retrieval algorithms to pinpoint relevant information, and leverages the OpenAI Assistants API, combining the strengths of LLMs and RAG for sophisticated answer generation. In addition, AI Tutor provides an option for students to download records of their Q&A sessions, thus enriching their repository of learning resources.

Our project has an ambitious goal: to build an AI tutoring system that gives accurate, personalized help for any school subject. We want to show that the latest AI technologies, known as large language models (LLMs) and retrievalaugmented generation (RAG), are more effective than the old-style tutoring systems that follow strict rules. At the core of our work is creating a smart system that can understand and use the materials from different courses to build a knowledge base tailored to students' needs. This is key to providing precise answers to students' questions and shows the system's strong grasp of the topics. We've also made a website that's easy to use, which shows off the wide range of skills our AI tutor has and how well it fits into the study process. This website proves that our system is adaptable and focused on helping users, marking the AI tutor's role in changing the way we think about education. With this project, we're not just proving that LLMs and RAG work well in education. We're also showing how they can significantly change how we use AI to support learning, pointing towards a future where AI is an essential part of how we learn.

人工智能（AI）的兴起已经在教育等多个领域掀起了一场变革浪潮，其中教育是明显的受益者之一。AI 的个性化和适应性学习经验提供能力无与伦比，使智能辅导系统成为现代教育模式的前沿（Kasneci 等人，2023 年）。这些系统能够为每个学生提供量身定做的反馈和互动学习模块，满足他们各自的学习需求。尽管如此，开发能够跨学科领域提供准确可靠回答的 AI 辅导者仍是一个挑战。

AI 在教育应用中的一个主要障碍是「信息幻觉」现象，即 AI 生成的回答看似合理，却偏离事实（Nye 等人，2023 年）。这种不一致性可能削弱人们对以 AI 为中心的教育系统的信任（Kasneci 等人，2023 年）。此外，这些系统需要访问最新和相关的教育材料，这在不同学科领域的复杂性下往往不易实现。

为了解决这些挑战，本文介绍了一款名为 AI Tutor 的网络应用程序。它基于复杂的大型语言模型（LLMs）和检索增强生成（RAG）技术开发，能够通过智能地整合特定课程材料中的信息，提供准确且与语境相关的回答（Lewis 等人，2020 年）。这一系统突破了传统基于规则的教育方法，极大增强了 AI 辅导系统的个性化潜力。AI Tutor 特别设计了一个用户友好的网络界面，简化了上传课程材料和提交问题的流程。它整合了先进的向量嵌入和教育内容存储系统，使用基于相似度的检索算法寻找相关信息，还利用了 OpenAI 助手 API，结合 LLMs 和 RAG 技术生成复杂的答案。此外，AI Tutor 还允许学生下载他们的问答记录，丰富他们的学习资源。

1『它整合了先进的向量嵌入和教育内容存储系统，使用基于相似度的检索算法寻找相关信息。这个信息跟今晚打通的 fastgpt 知识库很相似，匹配切片相似度高的作为上下文。补充：看了第三节的内容，很明确了。fastgpt 的底层实现原理就是这篇 paper 里提及的：LLM+RAG。哈哈。（2023-12-04）』

我们的项目目标宏伟：建立一个能够为任何学科提供准确、个性化帮助的 AI 辅导系统。我们的目标是证明，作为最新 AI 技术的大型语言模型（LLMs）和检索增强生成（RAG）比传统的遵循严格规则的辅导系统更有效。我们的核心工作是创建一个能够理解并利用不同课程材料的智能系统，以此构建适应学生需求的知识库。这是确保向学生提供精确答案的关键，也体现了系统对相关主题的深入理解。我们还开发了一个易于使用的网站，展示了 AI Tutor 的广泛技能和其在学习过程中的适应性。这个网站证明了我们的系统是用户友好且适应性强的，标志着 AI 辅导在改变我们对教育看法方面的作用。通过这个项目，我们不仅展示了 LLMs 和 RAG 在教育中的有效应用，还展示了它们如何显著改变我们利用 AI 支持学习的方式，，指向一个将 AI 作为我们学习方式的重要部分的未来。

### 02. Related Work

AI's application in education spans a broad spectrum, from augmenting curriculum design to facilitating personalized learning experiences, engaging students, and boosting motivation. Moore, S. et al. (2023) delineate the role of AI as ranging from assistive to autonomous, predicting a shift from AI as a tool in the educator's arsenal to an independent teaching agent. Currently, AI plays a primarily assistive role, but the trend indicates a shift toward more sophisticated, AI-centric educational experiences. Bailey further explores the ethical, pedagogical, and social implications of embedding AI in learning, touching on privacy, bias, and creativity cultivation concerns.

In contrast to earlier systems, such as the PAT2Math developed by Jaques et al. (2013), which employed rule-based algorithms to guide learners through algebraic problem-solving, our AI Tutor system harnesses the latest advancements in AI to deliver a far more sophisticated and nuanced educational interaction. Where PAT2Math's rule-based engine excelled in providing immediate feedback by comparing student inputs to a set of predefined solutions, it was nonetheless constrained by the inherent limitations of its architecture, notably an inability to generate response for the answer that not existed in their database and also lack reasoning ability compare to large language model.

In the landscape of AI-enabled education, Gan et al. (2019) laid a significant groundwork with their proposed framework for an AI-based math tutor. This system uniquely leveraged a modified approach to Item Response Theory (IRT) to first gauge a learner's ability, subsequently supplying custom-tailored question and answer sessions rooted in a pre-stored mathematical database. Despite the system's innovative use of natural language processing to analyze the semantic relationship of questions, it presented certain limitations. Primarily, the system's adherence to a static question database constrained its answering flexibility, often leading to repetitive and predictable responses. Additionally, the system exhibited a low tolerance for linguistic errors, struggling with sentence structures marred by typos or poor grammar. This limited its ability to accurately parse and comprehend questions that were not part of its pre-existing bank, emphasizing a critical shortcoming of the mechanism.

In light of these limitations, our project turns to the latest advancements in large language models (LLMs). This state-of-the-art technology offers superior comprehension of natural language, allowing it to process student queries articulated in various manners effectively. The LLM also ensures the generation of natural, contextually appropriate responses, thus addressing and overcoming the limitations observed in earlier AI tutoring systems.

人工智能（AI）在教育领域的应用十分广泛，它不仅丰富了课程设计，还促进了个性化学习体验，增强了学生的参与度和学习动力。Moore, S. 等人（2023 年）描述了 AI 在教育中的多种角色，从辅助工具到成为独立的教学代理。目前，AI 主要在教育中扮演辅助角色，但未来趋势可能会转向更加以 AI 为中心的复杂教育体验。Bailey 在其研究中进一步探讨了将 AI 融入学习过程中的伦理、教学和社会含义，包括隐私、偏见和创造力培养等方面的问题。

与早期的系统相比，如 Jaques 等人（2013 年）开发的基于规则的代数问题解决系统 PAT2Math，我们的 AI Tutor 系统利用 AI 的最新进展，提供了更复杂、更细腻的教育互动。PAT2Math 虽然擅长提供即时反馈，但由于其架构的限制，例如无法生成数据库中不存在答案的响应，以及与大型语言模型相比较缺乏推理能力，因此存在局限性。

在 AI 驱动教育的发展中，Gan 等人（2019 年）为基于 AI 的数学辅导系统提出了一个框架，为该领域奠定了重要基础。这个系统独特地利用了项目反应理论（IRT）的改进方法，首先评估学习者的能力，然后提供基于预存数学数据库的定制化问题和答案环节。尽管该系统创新地运用自然语言处理分析问题的语义关系，但它仍有限制。主要是由于系统对静态问题数据库的依赖，导致其回答缺乏灵活性，容易重复和可预测。此外，系统对语言错误的容忍度较低，难以处理语法错误的句子结构，这限制了其准确理解和解析非预存问题库中的问题的能力。

鉴于这些限制，我们的项目采用了最新的大型语言模型（LLMs）技术。这项先进技术提供了更好的自然语言理解能力，使其能够有效处理各种表达方式的学生查询。LLM 还能生成自然、符合语境的回答，解决并克服了早期 AI 辅导系统存在的限制。

### 03. Technical Background

This section provides an overview of the main concepts and techniques used in this project, namely Large Language Models (LLMs), Retrieval Augmented Generation (RAG), embedding, vector storage, similarity search, and modified prompts. These concepts and techniques are essential for developing and evaluating an AI-based system that can generate accurate and relevant responses to natural language queries in the domain of education.

3.1 Large Language Models

Recent advancements in natural language processing have been spurred by Large Language Models (LLMs) (Lewis et al., 2020). These are powerful neural networks trained on vast amounts of text, capable of generating coherent and meaningful language. They are versatile, used in various tasks such as translation, summarization, dialogue, and question answering. LLMs employ transformer architectures, which use self-attention mechanisms to understand text better (Shin et al., 2020). To optimize their performance, these models are initially pre-trained on large datasets and then fine-tuned for specific tasks (Brown et al., 2020).

2 Among the notable LLMs are OpenAI's GPT models, Google's PaLM, and Meta's LLaMa. In our AI Tutor system, we use OpenAI's GPT-4-1106-preview model, launched in November 2023 (Devlin et al., 2019). This model's scale and sophisticated training methodology enable it to perform exceptionally well on natural language tasks. Interestingly, GPT-4 even outperforms humans on many academic exams such as SAT and GRE as can be seen in Figure 1 below. For instance, on the SAT Math exam, it scored 710 out of 800, beating 89% of human test takers (OpenAI GPT-4 Technical Report, 2023). This highlights the model's robust reasoning capabilities. By integrating GPT-4, our AI Tutor system can effectively understand course materials, interpret diverse student questions, find relevant information, and provide natural, contextual responses (Chang et al., 2023). This significant upgrade helps overcome the limitations of previous rule-based tutoring systems struggling with open-ended student inputs.

Figure 1. Comparative Performance: GPT-3.5 and GPT-4 Surpass Human Achievement in Academic Examinations

3.2 Retrieval Augmented Generation

Retrieval Augmented Generation (RAG) is a technique for enhancing the accuracy and reliability of LLM-generated responses by grounding the model on external sources of knowledge to supplement the LLM’s internal representation of information (Lewis et al., 2020). RAG allows LLMs to access and incorporate relevant facts from an external knowledge base, such as user uploaded files, into their responses, instead of relying solely on their pre-trained parameters or hallucinating incorrect or misleading information (Cai et al., 2022). RAG consists of two main components: a retriever and a generator. The retriever is responsible for finding and ranking the most relevant documents or passages from the knowledge base given the input query. The generator is an LLM that takes the input query and the retrieved documents or passages as context and produces a response. The generator can also learn to select the best documents or passages from the retriever’s output using an attention mechanism (Moore et al.,2023).

RAG has several benefits for improving the quality and trustworthiness of LLM-generated responses. First, it ensures that the model has access to the most current, reliable, and domain-specific facts, which can improve the accuracy and relevance of the responses. Second, it provides users with the sources of the model’s responses, which can increase the transparency and verifiability of the model’s claims. Third, it reduces the need for fine-tuning the model on new data and updating its parameters, which can lower the computational and financial costs of maintaining the model (Lewis et al., 2020).

本节概述了我们项目中使用的关键概念和技术，包括大型语言模型（LLMs）、检索增强生成（RAG）、嵌入技术、向量存储、相似性搜索和修改提示。这些都是在教育领域开发和评估基于 AI 的系统（该系统能够对自然语言查询生成准确且相关回答）的基本要素。

3.1 大型语言模型（LLMs）

最近自然语言处理领域的进步得益于大型语言模型（LLMs）的发展（Lewis 等人，2020 年）。这些模型是强大的神经网络，它们通过对大量文本的训练，能够生成连贯且有意义的语言。LLMs 在各种任务中都非常实用，包括翻译、总结、对话和问答等。它们采用了变压器架构，该架构利用自注意机制来更好地理解文本（Shin 等人，2020 年）。为了优化性能，这些模型最初在大型数据集上进行预训练，然后针对特定任务进行微调（Brown 等人，2020 年）。

在值得注意的 LLMs 中，OpenAI 的 GPT 模型、谷歌的 PaLM 和 Meta 的 LLaMa 都很出名。在我们的 AI Tutor 系统中，我们使用了 OpenAI 在 2023 年 11 月推出的 GPT-4-1106-preview 模型（Devlin 等人，2019 年）。这个模型的规模和复杂的训练方法使其在自然语言任务上表现卓越。有趣的是，GPT-4 在许多学术考试中甚至超过了人类的表现，例如在 SAT 和 GRE 考试中，如下图 1 所示。例如，在 SAT 数学考试中，它的得分为 800 分中的 710 分，击败了 89% 的考生（OpenAI GPT-4 技术报告，2023 年）。这突出了模型的强大推理能力。通过整合 GPT-4，我们的 AI Tutor 系统能够有效地理解课程材料，解读学生的多样化问题，找到相关信息，并提供自然且符合语境的回答（Chang 等人，2023 年）。这一重要的升级帮助我们克服了之前基于规则的辅导系统在处理开放式学生输入时的限制。

图 1. 比较性能：GPT-3.5 和 GPT-4 在学术考试中超过人类成就。

3.2 检索增强生成（RAG）

检索增强生成（RAG）是一种技术，它通过让模型基于外部知识源来补充大型语言模型（LLM）内部的信息表示，从而提高 LLM 生成回答的准确性和可靠性（Lewis 等人，2020 年）。RAG 使 LLMs 能够访问并整合来自外部知识库（例如用户上传的文件）的相关事实，而不是仅依赖预先训练的参数，或生成错误或误导性的信息（Cai 等人，2022 年）。RAG 包括两个主要部分：检索器和生成器。检索器负责根据输入的查询从知识库中查找和排名最相关的文档或段落。生成器是一个 LLM，它接受输入的查询和检索到的文档或段落作为上下文，并生成响应。生成器还可以使用注意力机制，从检索器输出中选择最佳的文档或段落（Moore 等人，2023 年）。

RAG 在提升 LLM 生成回答的质量和可信度方面具有几个优势。首先，它确保模型能够获取到最新、最可靠和最具领域特性的事实，这有助于提升回答的准确性和相关性。其次，它提供了模型回答的来源，增加了模型声明的透明度和可验证性。最后，它减少了在新数据上对模型进行微调和更新参数的需要，从而降低了维护模型的计算和财务成本（Lewis 等人，2020 年）。

### 04. Methodology

In this section, we describe the technical design and implementation of our AI Tutor system, which aims to provide accurate and intelligent tutoring customized to any course. We also explain how we integrated the OpenAI Assistants API, which provides the core functionality of our system. The overall architecture of our AI Tutor system is illustrated in the following Figure 1.

Figure 2. The AI Tutor Framework

As shown in the Figure 2 above, our system consists of four main components:

• Course Materials: These are the domain-specific documents that provide the knowledge base for the AI Tutor.

The user can upload any course materials in text format, such as lecture notes, slides, textbooks, etc. The system will store the course materials in a vector database and use them for retrieval and generation.

• Student’s Question: This is the natural language query that the user inputs to the AI Tutor. The system will encode the question into a vector representation using a pre-trained embedding model.

• AI Tutor: This is the core component of our system that integrates the OpenAI Assistants API. The API provides the following features: o Embedding: The API uses a pre-trained embedding model to convert the text inputs (question and course materials) into vector representations. The assistants API use the OpenAI embedding o Vector Storage: The API stores the vector representations of the course materials in a vector database, which allows for efficient similarity search and retrieval. o Similarity-Based Retrieval: The API uses a similarity search algorithm to retrieve the most relevant course materials for the given question. o Retrieval-Augmented Generation (RAG): The API uses a large language model (LLM) that is augmented with a retrieval mechanism to generate the intelligent reply. The API supports various LLMs. The retrieval mechanism allows the LLM to access the relevant course materials and use them as context for generation. In this project, the we use the latest gpt-4-1106-preview trillion parameters model to empower the tutor which harness the ai power o Chat History Management: The API maintains a chat history for each user session, which allows the LLM to generate coherent and consistent replies. The API also allows the user to delete the chat history at any time.

The system's operational workflow is characterized by the following sequential steps:

• Material Upload: Users upload course materials, which are then vectorized using the API's embedding function and stored within the vector database.

• Question Submission: The student poses a question to the AI Tutor, which is encoded into a vector via the embedding feature.

• Response Generation: A modified prompt, composed of the student's question and the retrieved materials, is used to generate an intelligent response employing the RAG feature of the API. This response includes citations from the course materials, ensuring transparency and verifiability. Furthermore, the AI Tutor presents the intelligent reply to the student and updates the chat history to maintain the flow of the conversation.

• Session Continuation or Conclusion: Students have the option to continue the dialogue with additional questions, conclude the session, download a record of the chat history in HTML format for review, or delete the chat history for privacy.

The methodology applied in the development of the AI Tutor system is a testament to the integration of advanced AI with user-centric design, aiming to transform the educational landscape through personalized, responsive tutoring.

在这一节中，我们介绍了 AI Tutor 系统的技术设计和实现，该系统的目标是为任何课程提供精确和智能化的辅导。我们还阐述了如何将 OpenAI 助手 API 整合到系统中，这个 API 是我们系统的核心功能。AI Tutor 系统的整体架构如下图 2 所示。

图 2. AI Tutor 框架

如图 2 所示，我们的系统包括四个主要组件：

1、课程材料：这些是提供 AI Tutor 知识基础的特定领域文档。用户可以上传任何文本格式的课程材料，如讲义、幻灯片、教科书等。系统将这些材料存储在向量数据库中，并用于检索和生成。

2、学生问题：这是用户向 AI Tutor 提出的自然语言查询。系统将使用预训练的嵌入模型将这些问题转换为向量表示。

3、AI Tutor：这是我们系统的核心组件，它整合了 OpenAI 助手 API。这个 API 提供了以下功能：

嵌入：API 使用预训练的嵌入模型将文本输入（包括问题和课程材料）转换为向量表示。

向量存储：API 将课程材料的向量表示存储在向量数据库中，这使得进行高效的相似性搜索和检索成为可能。

基于相似性的检索：API 使用相似性搜索算法来检索与给定问题最相关的课程材料。

检索增强生成（RAG）：API 使用增强了检索机制的大型语言模型（LLM）来生成智能回答。API 支持多种 LLMs。这种检索机制允许 LLM 访问相关的课程材料，并将其作为生成回答的上下文。在这个项目中，我们使用了最新的 gpt-4-1106-preview 万亿参数模型来增强导师的 AI 能力。

聊天历史管理：API 为每个用户会话维护一份聊天历史，使 LLM 能够生成连贯且一致的回答。API 还允许用户随时删除他们的聊天历史。

AI Tutor 系统的操作流程包括以下几个连续的步骤：

1、材料上传：用户上传课程材料，这些材料随后通过 API 的嵌入功能被向量化并存储在向量数据库中。

2、提问提交：学生向 AI Tutor 提出问题，该问题通过嵌入功能被转换成向量形式。

3、回答生成：结合学生的问题和检索到的材料，使用修改后的提示通过 API 的 RAG 功能生成智能回答。这个回答包括来自课程材料的引用，确保了回答的透明性和可验证性。此外，AI Tutor 向学生展示智能回答，并更新聊天历史，以保持对话的连续性。

4、会话继续或结束：学生可以选择继续对话并提出更多问题，或者结束会话，并可以下载 HTML 格式的聊天历史记录进行回顾，或者出于隐私考虑删除聊天历史。

AI Tutor 系统的开发采用的方法论体现了将先进的 AI 技术与以用户为中心的设计相结合，旨在通过提供个性化、响应式的辅导来改变教育领域。

### 05. Demonstration

In this section, we present the demonstration of our AI Tutor project, which consists of two parts: the web app view and the Q&A session demo. We show how the AI Tutor works and how it can answer different types of questions based on the course materials. We also evaluate the performance and quality of the AI Tutor, such as the accuracy, relevance, naturalness, and citation of the answers.

5.1 Web App View

We developed a web app using Streamlit to showcase the functionality of our AI Tutor. The web app allows users to input their OpenAI API key, upload course materials in text format, and ask questions related to the course content. The web app also provides two buttons on the sidebar: one to delete all uploaded course materials, and another to generate a downloadable Q&A record in HTML format. The web app interface is shown in Figure 3.

Figure 3. The AI Tutor Web App Screenshot

We created a video demo to illustrate the usage and features of our AI Tutor. The video demo shows how a user can upload course materials, ask questions, and view answers from the AI Tutor. The video demo also highlights the naturalness and citation of the answers, as well as the Q&A record generation. The video demo is available at: https://youtu.be/UH0SjqU5tVI?si=cVuBlwdOADq1q7gx.

5.2 Q&A Session Demo

To exhibit the capabilities of the AI Tutor in delivering precise and pertinent responses anchored in educational content, we initiated a Q&A session utilizing our web application. We uploaded a trio of pdf documents comprising the course materials for "Finance Theory I" sourced from MIT OpenCourseWare (https://ocw.mit.edu/courses/15-401-financetheory-i-fall-2008/). Our inquiries delved into the core topics of the course, prompting the AI Tutor with questions like, "What are the six principles of finance? Use simple examples to explain to me." The AI Tutor's responses were impressively cogent, drawing directly from the uploaded material, and duly referenced the corresponding sources. This interactive dialogue is visually captured in Figure 4.

Figure 4. An Example of AI Tutor Q&A

From the above Figure 4, we can see that our AI tutor performance have following highlights:

• Accuracy: The AI Tutor's responses were scrutinized for correctness and alignment with the posed questions, ensuring they adhered closely to the factual content of the course material

• Relevance: The pertinence of each answer was assessed, with a keen focus on the alignment with the correct answer, substantiated by direct citations from the related source materials.

• Naturalness: We observed the conversational quality of the AI Tutor's responses, gauging their human-like tone and approachability.

• Citation: The system was particularly evaluated on its ability to accurately cite the specific course materials that informed its answers. For instance, as illustrated in the aforementioned Figure 4, the AI Tutor effectively referenced the section titled 'Lecture 1: Intro and Overview’ in relation to the queried concept.

An essential aspect of our AI Tutor is its commitment to sustained learning. Post each Q&A session, the system allows students to download a comprehensive record of the interaction. This feature is significant in the educational context, offering students the opportunity to revisit the discussion and review the responses at their own pace. The Q&A record serves as a personalized study guide, crafted to address the student's specific queries. It forms a valuable addition to the learner's resources, especially in the context of complex subjects that necessitate repeated engagement and a screenshot of the downloaded Q&A record is shown in Figure 5 below. Looking forward, we propose enhancing the AI Tutor's interactive dimension by incorporating visual aids, such as charts, tables, and diagrams, which could significantly bolster the comprehensibility and engagement of the responses.

Figure 5. An example of generated Q&A record downloaded (in html format)

[AI tutor demo - YouTube](https://www.youtube.com/watch?v=UH0SjqU5tVI)

本节中，我们展示了 AI Tutor 项目的演示，包括两部分：网络应用视图和问答会话演示。我们展示了 AI Tutor 的工作方式，以及它如何根据课程材料回答不同类型的问题。同时，我们还对 AI Tutor 的性能和质量进行了评估，包括回答的准确性、相关性、自然性和引用情况。

5.1. 网络应用视图

我们使用 Streamlit 开发了一个网络应用，用以展示 AI Tutor 的功能。这个网络应用允许用户输入他们的 OpenAI API 密钥，上传文本格式的课程材料，并提出与课程内容相关的问题。网络应用还在侧边栏提供了两个按钮：一个用于删除所有上传的课程材料，另一个用于生成可下载的问答记录（HTML 格式）。网络应用的界面如图 3 所示。

图 3. AI Tutor 网络应用截图

为了展示 AI Tutor 的使用和功能，我们制作了一个视频演示。这个视频演示展示了用户如何上传课程材料、提出问题并查看 AI Tutor 的回答。视频还特别强调了答案的自然性和引用，以及问答记录的生成。该视频演示可以在以下链接观看：https://youtu.be/UH0SjqU5tVI?si=cVuBlwdOADq1q7gx。

5.2. 问答会话演示

为了展示 AI Tutor 在提供精确且相关的基于教育内容的回答方面的能力，我们使用我们的网络应用发起了一个问答会话。我们上传了三个 PDF 文档，包含来自 MIT 开放课程「金融理论 I」的课程材料（https://ocw.mit.edu/courses/15-401-financetheory-i-fall-2008/）。我们的问题深入探讨了课程的核心主题，向 AI Tutor 提出了例如「金融的六大原则是什么？用简单的例子向我解释。」这样的问题。AI Tutor 的回答直接引用了上传的材料，并且引用了相应的来源，回答非常有说服力。这种互动对话在图 4 中进行了可视化展示。

图 4. AI Tutor 问答示例

从图 4 中我们可以看到，我们的 AI Tutor 表现出以下亮点：

准确性：AI Tutor 的回答经过严格审查，以确保其与问题的一致性，并且紧密符合课程材料的事实内容。

相关性：每个答案的相关性都进行了评估，重点关注正确答案的对齐，并通过直接引用相关来源材料加以证实。

自然性：我们观察了 AI Tutor 回答的对话质量，评估其人类般的语调和易于接近性。

引用：系统在准确引用形成其回答的特定课程材料方面进行了特别评估。例如，如图 4 所示，AI Tutor 有效地引用了与查询概念相关的「Lecture 1: Intro and Overview」章节。

我们的 AI Tutor 的一个关键特点是其对持续学习的承诺。每次问答会话后，系统允许学生下载交互的完整记录。这一功能在教育背景中非常重要，它提供了学生重新审视讨论和按自己节奏复习回答的机会。问答记录作为针对学生特定查询量身定制的个性化学习指南，是学习者资源中的宝贵补充，尤其是在需要反复参与的复杂主题背景下。图 5 下方展示了下载的问答记录的截图。展望未来，我们计划通过整合诸如图表、表格和图解等视觉辅助工具来增强 AI Tutor 的互动维度，这可以显著提高回答的易理解性和参与度。

图 5. 下载的问答记录示例（HTML 格式）

### 06. Discussion

In this project, we developed an AI tutor that can answer students’ questions based on the course materials uploaded by the instructor. The AI tutor leverages a large language model (LLM) and a retrieval-augmented generation (RAG) technique to generate accurate and natural responses grounded in verified information. We demonstrated the functionality and versatility of our AI tutor through a web app and a video demo. In this section, we will discuss the strengths and weaknesses of our AI tutor, as well as the limitations and challenges of the techniques used in the project. We will also address the potential ethical and societal implications of deploying our AI tutor in educational settings. Finally, we will provide some recommendations for future improvements and extensions to the project.

6.1 Strengths and Weaknesses of the AI Tutor

One of the main strengths of our AI tutor is that it can adapt to any course by using the course-specific materials as the external data source for the RAG technique. This allows the AI tutor to provide tailored responses that are aligned with the course content and objectives. Moreover, the AI tutor can generate high-quality answers in any domain, as long as the domain knowledge documents are available and accessible. Another strength of our AI tutor is that it can produce natural and human-like responses by using the power of the LLM, which is trained on a large corpus of text and can capture the nuances and subtleties of natural language. Furthermore, the AI tutor can handle a variety of questions, such as factual, conceptual, or analytical questions, and provide appropriate citations for the retrieved information.

However, our AI tutor also has some weaknesses that need to be addressed. One of the weaknesses is that the AI tutor is not guaranteed to provide 100% accurate answers, as the LLM may still suffer from information hallucination or inconsistency. Therefore, the AI tutor’s answers should be verified and validated by the instructor or other reliable sources before being accepted as correct. Another weakness is that the AI tutor’s performance depends on the quality and clarity of the student’s question, as well as the availability and relevance of the course materials. If the student’s question is vague, ambiguous, or too broad, the AI tutor may not be able to provide a satisfactory answer. Similarly, if the course materials are incomplete, outdated, or inaccurate, the AI tutor may not be able to retrieve the correct information or may provide misleading or erroneous answers.

6.2. Limitations of the Techniques Used in the Project

The techniques used in the project, namely the LLM and the RAG, also have some limitations and challenges that need to be considered. One of the limitations is that the LLM and the RAG are computationally expensive and require a lot of resources and time to train and run. This may pose a challenge for the scalability and affordability of the AI tutor, especially for low-resource settings or large-scale applications. Another limitation is that the LLM and the RAG are based on statistical models and probabilistic methods, which may not capture the full complexity and diversity of natural language and human knowledge. This may result in some limitations in the expressiveness, interpretability, and explainability of the AI tutor’s answers. Moreover, the LLM and the RAG are still subject to some biases and errors that may affect the quality and reliability of the AI tutor’s answers. For example, the LLM may inherit some social or cultural biases from the training data, or the RAG may retrieve some irrelevant information from the external data source some times.

6.3. Ethical and Societal Implications of Deploying the AI Tutor in Educational Settings

Deploying the AI tutor in educational settings may have some ethical and societal implications that need to be carefully examined and addressed. One of the implications is that the AI tutor may affect the role and relationship of the instructor and the student in the learning process. The AI tutor may complement or supplement the instructor’s teaching, but it may also replace or undermine the instructor’s authority or expertise. Similarly, the AI tutor may enhance or facilitate the student’s learning, but it may also impair or discourage the student’s critical thinking or creativity. Therefore, the AI tutor should be used as a tool or a resource, not as a substitute or a replacement, for the instructor or the student. Another implication is that the AI tutor may raise some privacy and security issues regarding the data collection and usage in the project. The AI tutor may collect and use some personal or sensitive data from the instructor or the student, such as the course materials, the questions, or the answers. This may pose some risks of data leakage, misuse, or abuse, which may violate the privacy or confidentiality of the instructor or the student. Therefore, the AI tutor should follow some ethical principles and guidelines, such as transparency, consent, accountability, and fairness, to ensure the data protection and respect of the instructor or the student.

6.4. Recommendations for Future Improvements

Based on the discussion above, we can provide some recommendations for future improvements and extensions to the project. One of the recommendations is to reduce the cost of the AI tutor by exploring some alternative options for the LLM and the RAG, such as open-source or low-resource models, or by using some third-party frameworks and libraries, such as Langchain or Chroma, to reduce the implementation costs. Another recommendation is to improve the user interface design of the AI tutor to enhance the user engagement and satisfaction, such as by adding some interactive or personalized features, such as feedback and user profile. A third recommendation is to implement more scalable solutions for the AI tutor, such as by using some cloud-based or distributed platforms, such as Google Cloud or Azure, to increase the availability and accessibility of the AI tutor. A fourth recommendation is to investigate the feasibility of automated quiz generation for the AI tutor, such as by using the context of course material to provide some formative assessment for the student’s learning.

在这个项目中，我们开发了一个 AI 辅导系统，能够基于讲师上传的课程材料回答学生的问题。这个 AI 辅导系统利用了大型语言模型（LLM）和检索增强生成（RAG）技术，生成基于经过验证的信息的准确和自然的回答。我们通过网络应用和视频演示展示了 AI 辅导系统的功能和多样性。在本节中，我们将探讨 AI 辅导系统的优点和缺点，以及项目中使用的技术的限制和挑战。我们还将讨论在教育环境中部署 AI 辅导系统可能产生的潜在伦理和社会影响，并为项目的未来发展提供一些建议。

6.1 AI 辅导系统的优点和缺点

AI 辅导系统的一个主要优点是它可以通过使用特定课程的材料作为检索增强生成技术的外部数据源来适应任何课程。这使得 AI 辅导系统能够提供与课程内容和目标一致的定制化回答。此外，只要相关领域的知识文档可用，AI 辅导系统就能在任何领域生成高质量的答案。AI 辅导系统的另一个优点是，它能够利用经过大量文本训练、能够捕捉自然语言细微差别的大型语言模型，生成自然和类似人类的回答。此外，AI 辅导系统可以处理各种问题，如事实性、概念性或分析性问题，并为检索到的信息提供恰当的引用。

然而，AI 辅导系统也存在一些需要解决的弱点。一个问题是 AI 辅导系统无法保证提供 100% 准确的答案，因为大型语言模型可能仍受到信息幻觉或不一致性的影响。因此，在接受为正确之前，AI 辅导系统的答案应由讲师或其他可靠来源进行验证。另一个弱点是 AI 辅导系统的性能取决于学生问题的质量和清晰度以及课程材料的可用性和相关性。如果学生的问题模糊、含糊或过于宽泛，AI 辅导系统可能无法提供满意的答案。同样，如果课程材料不完整、过时或不准确，AI 辅导系统可能无法检索到正确的信息，或可能提供误导性或错误的答案。

6.2 项目中使用的技术的局限性

项目中使用的技术，即 LLM 和 RAG，也存在一些需要考虑的局限性和挑战。一个局限性是 LLM 和 RAG 计算成本高，需要大量资源和时间来训练和运行。这可能对 AI 辅导员的可扩展性和负担能力构成挑战，特别是对于低资源环境或大规模应用。另一个局限性是 LLM 和 RAG 基于统计模型和概率方法，可能无法捕捉自然语言和人类知识的全部复杂性和多样性。这可能导致 AI 辅导员回答的表达性、可解释性和可解释性方面的一些局限性。此外，LLM 和 RAG 仍然受到一些偏见和错误的影响，可能会影响 AI 辅导员回答的质量和可靠性。例如，LLM 可能从训练数据中继承一些社会或文化偏见，或者 RAG 可能有时从外部数据源检索到一些不相关的信息。

6.3 在教育环境中部署 AI 辅导员的伦理和社会影响

在教育环境中部署 AI 辅导员可能会产生一些需要仔细考察和解决的伦理和社会影响。一个影响是 AI 辅导员可能会影响教师和学生在学习过程中的角色和关系。AI 辅导员可能补充或增强教师的教学，但也可能取代或削弱教师的权威或专业知识。类似地，AI 辅导员可能增强或促进学生的学习，但也可能损害或抑制学生的批判性思维或创造力。因此，AI 辅导员应作为工具或资源使用，而不是替代或取代教师或学生。另一个影响是 AI 辅导员可能引发一些关于项目中数据收集和使用的隐私和安全问题。AI 辅导员可能会收集和使用教师或学生的一些个人或敏感数据，如课程材料、问题或答案。这可能带来数据泄露、滥用或滥用的风险，可能违反教师或学生的隐私或保密性。因此，AI 辅导员应遵循一些伦理原则和指导方针，如透明度、同意、问责制和公平性，以确保教师或学生的数据保护和尊重。

6.4 未来改进的建议

基于上述讨论，我们可以为项目的未来改进和扩展提供一些建议。一个建议是通过探索 LLM 和 RAG 的一些替代方案来降低 AI 辅导员的成本，如开源或低资源模型，或使用一些第三方框架和库，如 Langchain 或 Chroma，来降低实现成本。另一个建议是改进 AI 辅导员的用户界面设计，以增强用户参与和满意度，例如添加一些交互或个性化功能，如反馈和用户资料。第三个建议是为 AI 辅导员实现更可扩展的解决方案，例如通过使用一些基于云或分布式平台，如 Google Cloud 或 Azure，来提高 AI 辅导员的可用性和可访问性。第四个建议是研究 AI 辅导员自动生成测验的可行性，例如通过使用课程材料的上下文为学生的学习提供一些形成性评估。

### 07. Conclusion

This paper introduced AI Tutor, a web application at the forefront of educational technology, utilizing the latest advancements in artificial intelligence to provide tailored tutoring for any course. The AI Tutor is underpinned by the most recent OpenAI Assistants API, released in November 2023, and is powered by the most sophisticated iteration of the GPT-4 model, ensuring that our system is both cutting-edge and robust. The innovation of AI Tutor resides in its unique ability to digest and utilize course materials provided by educators, forming an adaptable vector knowledge base. When a student poses a query, the system first employs vector similarity search to identify the most relevant

8 information within this specialized database. It then applies a powerful generative model to articulate responses that are not only accurate and contextually relevant but also enriched with citations from the source material. The evaluations reveal AI Tutor's effectiveness in producing relevant, factually consistent responses, showcasing the promise of integrating sophisticated LLMs with retrieval. This underscores AI Tutor's evolution beyond limitations of prior rule-based tutoring systems.

However, real-world deployment necessitates further enhancements, particularly in scalability. While the current prototype uses Streamlit's community cloud, migration to robust commercial platforms like Microsoft Azure or Google Cloud could strengthen stability for large-scale usage. Additional priorities include boosting interpretability, ethical rigor, and conducting user studies to gauge pedagogical impact. In essence, AI Tutor represents an important milestone in harnessing AI's benefits for education through an accessible, interactive platform. It lays a foundation for a new generation of intelligent tutors that can empower learners with personalized support tailored to their academic journeys. Realizing the full potential of such systems will require sustained research and responsible development. But the possibilities glimpsed by this initial effort highlight the transformative promise of AI in augmenting how we teach and learn.

本文介绍了 AI Tutor，这是一款位于教育技术前沿的网络应用，利用人工智能的最新进展为任何课程提供定制化辅导。AI Tutor 基于 2023 年 11 月发布的最新 OpenAI 助手 API，并由最先进的 GPT-4 模型迭代版本提供动力，确保我们的系统既先进又强大。AI Tutor 的创新之处在于它能够消化并利用教育工作者提供的课程材料，形成一个适应性向量知识库。当学生提出问题时，系统首先使用向量相似性搜索识别专门数据库中最相关的信息，然后应用一个强大的生成模型，不仅准确和与语境相关，而且包含源材料引用的回答。评估显示，AI Tutor 在生成相关、事实一致的回答方面非常有效，展示了将复杂 LLM 与检索技术结合的潜力。这突显了 AI Tutor 超越了以往基于规则的辅导系统的局限性。

然而，AI Tutor 的真实世界部署需要进一步增强，特别是在可扩展性方面。目前的原型使用了 Streamlit 社区云，但迁移到如 Microsoft Azure 或 Google Cloud 这样的强大商业平台可能会提高其在大规模应用中的稳定性。其他优先事项包括提高解释性、伦理严格性，并进行用户研究以评估教育影响。总的来说，AI Tutor 代表了利用 AI 为教育带来好处的一个重要里程碑，通过一个可访问的、互动的平台。它为下一代智能导师奠定了基础，这些导师可以为学习者提供根据其学术旅程量身定制的个性化支持。要充分发挥这类系统的潜力，需要持续的研究和负责任的开发。但这种初步努力所展示的可能性凸显了 AI 在增强我们的教学和学习方式方面的变革性承诺。

### References

Brown, T., Mann, B., Ryder, N., Subbiah, M., Kaplan, J. D., Dhariwal, P., ... & Amodei, D. (2020). Language models are few-shot learners. Advances in neural information processing systems, 33, 1877-1901.

Cai, D., Wang, Y., Liu, L., & Shi, S. (2022, July). Recent advances in retrieval-augmented text generation. In Proceedings of the 45th International ACM SIGIR Conference on Research and Development in Information Retrieval (pp. 3417-3419).

Chang, Y., Wang, X., Wang, J., Wu, Y., Zhu, K., Chen, H., ... & Xie, X. (2023). A survey on evaluation of large language models. arXiv preprint arXiv:2307.03109.

Devlin, J., Chang, M. W., Lee, K., & Toutanova, K. (2018). Bert: Pre-training of deep bidirectional transformers for language understanding. arXiv preprint arXiv:1810.04805.

Gan, W., Sun, Y., Ye, S., Fan, Y., & Sun, Y. (2019, October). AI-tutor: Generating tailored remedial questions and answers based on cognitive diagnostic assessment. In 2019 6Th international conference on behavioral, economic and socio-cultural computing (BESC) (pp. 1-6). IEEE.

Gromyko, V. I., Kazaryan, V. P., Vasilyev, N. S., Simakin, A. G., & Anosov, S. S. (2017, August). Artificial intelligence as tutoring partner for human intellect. In International Conference of Artificial Intelligence, Medical Engineering, Education (pp. 238-247). Cham: Springer International Publishing.

Jaques, P. A., Seffrin, H., Rubi, G., de Morais, F., Ghilardi, C., Bittencourt, I. I., & Isotani, S. (2013). Rule-based expert systems to support step-by-step guidance in algebraic problem solving: The case of the tutor PAT2Math. Expert Systems with Applications, 40(14), 5456-5465. https://doi.org/10.1016/j.eswa.2013.04.008

Kasneci, E., Seßler, K., Küchemann, S., Bannert, M., Dementieva, D., Fischer, F., … & Kasneci, G. (2023). ChatGPT for good? On opportunities and challenges of large language models for education. Learning and individual differences, 103, 102274. https://doi.org/10.1016/j.lindif.2023.102274

Lewis, M., Storks, S., & Zettlemoyer, L. (2020). Hallucination in neural machine translation. In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing: Findings (pp. 3818-3833).

Lewis, P., Perez, E., Piktus, A., Petroni, F., Karpukhin, V., Goyal, N., ... & Kiela, D. (2020). Retrieval-augmented generation for knowledge-intensive nlp tasks. Advances in Neural Information Processing Systems, 33, 9459-9474.

Moore, S., Tong, R., Singh, A., Liu, Z., Hu, X., Lu, Y., … & Stamper, J. (2023, June). Empowering education with llms-the next-gen interface and content generation. In International Conference on Artificial Intelligence in Education (pp. 32-37). Cham: Springer Nature Switzerland. https://doi.org/10.1007/978-3-030-78270-2_6

Nye, B., Mee, D., & Core, M. G. (2023). Generative large language models for dialog-based tutoring: An early consideration of opportunities and concerns. In AIED Workshops.

OpenAI (2023). GPT-4 Technical Report. ArXiv, abs/2303.08774.

Shin, A., Lee, J., & Kang, J. (2020). How to train your GPT-2: A step by step guide to training large language models. arXiv preprint arXiv:2004.10964.