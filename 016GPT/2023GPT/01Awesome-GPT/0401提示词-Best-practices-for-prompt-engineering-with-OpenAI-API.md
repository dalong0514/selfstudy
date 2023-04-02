## Best practices for prompt engineering with OpenAI API

2023-03-28

[Best practices for prompt engineering with OpenAI API | OpenAI Help Center](https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-openai-api)

How to give clear and effective instructions to GPT-3 and Codex

Written by Jessica Shieh. Updated over a week ago

If you're just getting started with OpenAI API, we recommend reading the Introduction and Quickstart tutorials first.

### How prompt engineering works

Due to the way the instruction-following models are trained or the data they are trained on, there are specific prompt formats that work particularly well and align better with the tasks at hand. Below we present a number of prompt formats we find work reliably well, but feel free to explore different formats, which may fit your task best.

『

问：Due to the way the instruction-following models are trained or the data they are trained on, there are specific prompt formats that work particularly well and align better with the tasks at hand. Below we present a number of prompt formats we find work reliably well, but feel free to explore different formats, which may fit your task best.

GPT-4：

您提到了关于指令跟踪模型的训练和数据，以及某些特定提示格式如何在执行任务时更好地与任务保持一致。以下是一些建议，这些提示格式通常在执行任务时表现出较好的效果。当然，您可以自由探索其他格式，以找到最适合您任务的方式。

1、问题-答案格式：通过提问来引导模型生成所需的答案。例如：“什么是光合作用？”或“请解释电磁感应的原理。”

2、填空式提示：提供一个句子，并在需要模型填写的部分留空。例如：“光合作用是植物通过________将阳光能量转化为化学能的过程。”

3、步骤式指导：将任务分解为几个步骤，逐步引导模型完成任务。例如：“请简述光合作用的三个主要阶段。”

4、设定场景：为模型创建一个背景或场景，以便引导其生成与场景相关的回答。例如：“假设你是一个生物学老师，正在向学生解释光合作用的过程。”

5、明确指示：在提示中提供明确的指示，告诉模型您希望得到什么样的回答。例如：“简要介绍光合作用的过程，并用通俗易懂的语言解释。”

请记住，不同的任务可能需要不同的提示格式。您可以尝试使用这些建议作为起点，根据需要调整并优化提示。通过实验，您可以找到与您的任务最匹配的提示格式。

』

Rules of Thumb and Examples

Note: the "{text input here}" is a placeholder for actual text/context

1 Use the latest model

For best results, we generally recommend using the latest, most capable models. As of November 2022, the best options are the「text-davinci-003」model for text generation, and the「code-davinci-002」model for code generation.

2 Put instructions at the beginning of the prompt and use ### or """ to separate the instruction and context

Less effective ❌:

Summarize the text below as a bullet point list of the most important points.

{text input here}

Better ✅:

Summarize the text below as a bullet point list of the most important points.

Text: """

{text input here}

"""

『

问：Put instructions at the beginning of the prompt and use ### or """ to separate the instruction and context

GPT-4：

在提示的开头放置指令并使用 ### 或 """ 分隔指令和上下文的方法，可以帮助模型更清晰地理解您的要求，并在上下文中生成更合适的回答。以下是一个示例：

Please summarize the following text in one sentence.
"""
Climate change is a long-term shift in global or regional climate patterns, often characterized by a significant increase in average global temperatures, leading to more frequent extreme weather events, melting ice caps, and rising sea levels. These changes can have profound impacts on ecosystems, agriculture, and human societies, making it a critical issue that needs to be addressed by policymakers and individuals alike.
"""

补充：上面的提示用 ### 替换 """ 是一样的，测试过。（2023-03-28）
』

3 Be specific, descriptive and as detailed as possible about the desired context, outcome, length, format, style, etc

Be specific about the context, outcome, length, format, style, etc

Less effective ❌:

Write a poem about OpenAI.

Better ✅:

Write a short inspiring poem about OpenAI, focusing on the recent DALL-E product launch (DALL-E is a text to image ML model) in the style of a {famous poet}

『

问：Be specific, descriptive and as detailed as possible about the desired context, outcome, length, format, style, etc

GPT-4：

当您与AI进行交互时，提供明确、具体、详细的指示和信息可以帮助您获得更精确和满意的结果。以下是一些建议，以确保您在与AI交流时提供尽可能详细的上下文和要求：

1、上下文：提供与任务相关的背景信息和上下文。这可以帮助AI更好地理解您的需求，并在回答中考虑到这些信息。

2、预期结果：明确说明您希望获得的结果类型，例如概括、解释、评估或比较等。

3、长度：指定您希望获得的回答或输出的长度。例如，要求生成一段摘要或一篇详细的论文。

4、格式：指导AI以特定的格式生成输出，例如列表、段落、问题-答案格式等。

5、风格：描述您期望的输出风格，如正式、非正式、幽默、学术等。

6、具体要求：提供特殊要求或限制，例如避免使用某些词汇或仅使用特定的资源。

示例：

假设您需要AI为您撰写一篇关于太阳能的优缺点的短文。以下是一个明确、详细的提示：

请为我撰写一篇关于太阳能优缺点的短文，长度约300字。请使用正式、学术的写作风格，分别列出至少三个优点和三个缺点。优点部分请关注环境、经济和可持续性方面的益处，缺点部分请关注成本、天气依赖性和地理限制等方面。请将文章结构分为简短的引言、优点、缺点和结论四部分。

』

4 Articulate the desired output format through examples (example 1, example 2).

Less effective ❌:

Extract the entities mentioned in the text below. Extract the following 4 entity types: company names, people names, specific topics and themes.

Text: {text}

Show, and tell - the models respond better when shown specific format requirements. This also makes it easier to programmatically parse out multiple outputs reliably.

Better ✅:

Extract the important entities mentioned in the text below. First extract all company names, then extract all people names, then extract specific topics which fit the content and finally extract general overarching themes

Desired format:

Company names: <comma_separated_list_of_company_names>

People names: -||-

Specific topics: -||-

General themes: -||-

Text: {text}

『

问：Articulate the desired output format through examples (example 1, example 2).

GPT-4：

为了帮助AI更好地理解您的需求，您可以提供示例来明确您期望的输出格式。通过给出一两个示例，您可以向AI展示正确的结构、风格和内容。以下是两个示例：

假设您需要 AI 为您生成一段关于太阳能优缺点的摘要，您可以提供如下提示：

请为我生成一段关于太阳能优缺点的摘要，格式参考以下示例：

示例 1：太阳能是一种环保、可持续的能源，其优点包括减少污染、降低能源成本和长期投资回报。然而，太阳能的缺点包括昂贵的初始安装成本、对阳光的依赖以及地理位置限制。

示例 2：太阳能作为一种清洁能源具有诸多优势，如对环境友好、降低电费和可持续性。然而，缺点也不容忽视，如高昂的初始投资、对晴天的依赖以及对适宜地区的要求。

问：让 GPT 写一篇实用新型专利的提示词。

GPT-4：

实用新型专利通常涉及一种新型的、具有实际应用价值的技术解决方案。以下是一些建议的提示词，可以用于引导GPT撰写一篇实用新型专利：

1、专利名称：请为此实用新型专利提供一个简洁明了的名称，反映其核心功能或创新点。

2、技术领域：说明此实用新型专利涉及的技术领域，例如机械工程、通信技术、生物技术等。

3、背景技术：简要描述当前技术状况，特别是与实用新型专利相关的问题和挑战。

4、技术问题：明确提出此实用新型专利试图解决的具体技术问题。

5、技术方案：详细介绍实用新型专利的技术解决方案，包括核心组件、工作原理和操作步骤等。

6、创新点：强调此实用新型专利的创新之处，即与现有技术相比的优势和改进。

7、实施例：提供至少一个实施例，以证明实用新型专利的技术方案是可行的。

8、工业适用性：说明此实用新型专利的技术方案在实际工业生产中的应用价值。

您可以根据这些建议的提示词组织您的问题，引导GPT撰写实用新型专利。当然，在实际操作中，请确保遵循您所在国家/地区的专利法规和要求。

』

5 Start with zero-shot, then few-shot (example), neither of them worked, then fine-tune

✅ Zero-shot

Extract keywords from the below text.

Text: {text}

Keywords:

✅ Few-shot - provide a couple of examples

Extract keywords from the corresponding texts below.

Text 1: Stripe provides APIs that web developers can use to integrate payment processing into their websites and mobile applications.

Keywords 1: Stripe, payment processing, APIs, web developers, websites, mobile applications

`##`

Text 2: OpenAI has trained cutting-edge language models that are very good at understanding and generating text. Our API provides access to these models and can be used to solve virtually any task that involves processing language.

Keywords 2: OpenAI, language models, text processing, API.

`##`

Text 3: {text}

Keywords 3:

『

问：Start with zero-shot, then few-shot (example), neither of them worked, then fine-tune

GPT-4：

在使用GPT进行任务时，可以先尝试零样本（zero-shot）和少样本（few-shot）方法。如果这些方法效果不佳，可以考虑对模型进行微调（fine-tuning）以提高性能。

1、零样本（Zero-shot）：首先，尝试使用零样本方法让 GPT 完成任务。这意味着在不提供任何示例的情况下，仅通过指示性问题来引导模型生成期望的输出。

2、少样本（Few-shot）：如果零样本方法效果不佳，可以尝试使用少样本方法。这意味着您需要提供一个或多个示例，以帮助模型理解期望的任务和输出格式。例如：

提示：

以下是两个关于自然保护区的描述，请为我编写一个类似的描述关于海洋保护区的内容：

示例 1：自然保护区是指为了保护和恢复生态系统、野生动植物及其栖息地而设立的特殊区域。这些区域有助于维持生物多样性、保护濒危物种以及研究和监测生态系统的变化。

示例 2：自然保护区旨在保护特定区域内的生态系统和生物多样性。它们为濒危物种提供了庇护所，同时也为科学家提供了观察和研究自然环境的机会。

3、微调（Fine-tuning）：如果零样本和少样本方法都不能满足要求，可以考虑对模型进行微调。微调需要一个具有标签的数据集，其中包含任务相关的输入和期望输出。通过在此数据集上训练模型，您可以使模型更好地适应特定任务。请注意，微调需要一定的机器学习和深度学习知识，以及计算资源。

总之，从零样本和少样本方法开始尝试，如果效果不佳，再考虑对模型进行微调以提高任务性能。

』

✅Fine-tune: see fine-tune best practices here.

[Classification best practices (Access: Open to All) - Google 文档](https://docs.google.com/document/d/1h-GTjNDDKPKU_Rsd0t1lXCAnHltaXTAzQ8K2HRhQf9U/edit#)

6 Reduce「fluffy」and imprecise descriptions

Less effective ❌:

The description for this product should be fairly short, a few sentences only, and not too much more.

Better ✅:

Use a 3 to 5 sentence paragraph to describe this product.

『

问：Reduce「fluffy」and imprecise descriptions

GPT-4：

在执行任务时，尽量避免使用过于宽泛（fluffy）和不精确的描述。为了提高描述的准确性和清晰度，请遵循以下建议：

1、具体化：明确描述所需内容或功能，避免使用模糊或笼统的词汇。

2、详细化：尽可能提供更多的细节，以帮助模型准确理解任务要求。

3、使用示例：提供一个或多个示例，以便模型更好地理解期望的输出格式、结构和风格。

4、指导性语言：使用指导性的问题或指令来明确任务目标和预期结果。

5、指定格式和长度：在任务描述中明确输出的格式和期望的长度，以便模型生成符合要求的内容。

通过遵循这些建议，您可以提高任务描述的准确性和清晰度，从而帮助模型生成更符合您预期的结果。

』

7 Instead of just saying what not to do, say what to do instead

Less effective ❌:

The following is a conversation between an Agent and a Customer. DO NOT ASK USERNAME OR PASSWORD. DO NOT REPEAT.

Customer: I can't log in to my account.

Agent:

Better ✅:

The following is a conversation between an Agent and a Customer. The agent will attempt to diagnose the problem and suggest a solution, whilst refraining from asking any questions related to PII. Instead of asking for PII, such as username or password, refer the user to the help article www.samplewebsite.com/help/faq

Customer: I can't log in to my account.

Agent:

8 Code Generation Specific - Use「leading words」to nudge the model toward a particular pattern

Less effective ❌:

`#` Write a simple python function that

`#` 1. Ask me for a number in mile

`#` 2. It converts miles to kilometers

In this code example below, adding「import」hints to the model that it should start writing in Python. (Similarly「SELECT」is a good hint for the start of a SQL statement.)

Better ✅:

`#` Write a simple python function that

`#` 1. Ask me for a number in mile

`#` 2. It converts miles to kilometers

import

### Parameters

Generally, we find that model and temperature are the most commonly used parameters to alter the model output.

model - Higher performance models are more expensive and have higher latency.

temperature - A measure of how often the model outputs a less likely token. The higher the temperature, the more random (and usually creative) the output. This, however, is not the same as「truthfulness」. For most factual use cases such as data extraction, and truthful Q&A, the temperature of 0 is best.

max_tokens (maximum length) - Does not control the length of the output, but a hard cutoff limit for token generation. Ideally you won't hit this limit often, as your model will stop either when it thinks it's finished, or when it hits a stop sequence you defined.

stop (stop sequences) - A set of characters (tokens) that, when generated, will cause the text generation to stop.

For other parameter descriptions see the API reference.

[Models - OpenAI API](https://platform.openai.com/docs/models/gpt-4)

[API Reference - OpenAI API](https://platform.openai.com/docs/api-reference/models/list)

### Additional Resources

If you're interested in additional resources, we recommend:

Guides

[Text completion - OpenAI API](https://platform.openai.com/docs/guides/completion/introduction) - learn how to generate or edit text using our models

[Code completion - OpenAI API](https://platform.openai.com/docs/guides/code/code-completion-private-beta) - explore prompt engineering for Codex

[Fine-tuning - OpenAI API](https://platform.openai.com/docs/guides/fine-tuning) - Learn how to train a custom model for your use case

[Embeddings - OpenAI API](https://platform.openai.com/docs/guides/embeddings/what-are-embeddings) - learn how to search, classify, and compare text

[Moderation - OpenAI API](https://platform.openai.com/docs/guides/moderation/overview)

OpenAI cookbook repo - contains example code and prompts for accomplishing common tasks with the API, including Question-answering with Embeddings

[OpenAI API Community Forum](https://community.openai.com/)