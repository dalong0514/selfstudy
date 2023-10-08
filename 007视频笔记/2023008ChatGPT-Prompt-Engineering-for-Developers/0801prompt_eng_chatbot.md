## 0801. prompt_eng_chatbot

One of the exciting things about a large language model is you could use it to build a custom chatbot with only a modest amount of effort. 

ChatGPT, the web interface, is a way for you to have a conversational interface, a conversation via a large language model. But one of the cool things is you can also use a large language model to build your custom chatbot to maybe play the role of an AI customer service agent or an AI order taker for a restaurant. And in this video, you'll learn how to do that by yourself. 

I'm going to describe the components of the OpenAI chat completions format in more detail and then you're going to build a chatbot yourself. So let's get into it. So first we'll set up the OpenAI Python package as usual. 

So chat models like ChatGPT are actually trained to take a series of messages as input and return a model generated message as output. 

And so although the chat format is designed to make multi-turn conversations like this easy, we've kind of seen through the previous videos that it's also just as useful for single-turn tasks without any conversation. And so next we're going to define two helper functions. So this is the one that we've been using throughout all the videos and it's the "get_completion" function. But if you kind of look at it, we give a prompt but then inside the function what we're actually doing is putting this prompt into what looks like some kind of user message. 

And this is because the ChatGPT model is a chat model which means it's trained to take a series of messages as input and then return a model generated message as output. So the user message is the input and then the assistant message is the output. 

So in this video we're going to actually use a different helper function and instead of kind of putting a single prompt as input and getting a single completion, we're going to pass in a list of messages and these messages can be kind of from a variety of different roles. So I'll describe those. 

So here's an example of a list of messages and so the first message is a system message which kind of gives an overall instruction and then after this message we have turns between the user and the assistant and this will kind of continue to go on. 

And if you've ever used ChatGPT, the web interface, then your messages are the user messages and then ChatGPT's messages are the assistant messages. So the system message helps to kind of set the behavior and persona of the assistant and it acts as kind of a high-level instruction for the conversation. 

So you can kind of think of it as whispering in the assistant's ear and kind of guiding its responses without the user being aware of the system message. So as the user, if you've ever used ChatGPT, you probably don't know what's in ChatGPT's system message. 

The benefit of the system message is that it provides you, the developer, with a way to kind of frame the conversation without making the request itself part of the conversation. So you can kind of guide the assistant and kind of whisper in its ear and guide its responses without making the user aware. 
 
So now let's try to use these messages in a conversation. So we'll use our new helper function to get the completion from the messages. 

And we're also using a higher temperature. So the system message says, "You are an assistant that speaks like Shakespeare". So this is us kind of describing to the assistant how it should behave. And then the first user message is, "Tell me a joke". The next is, "Why did the chicken cross the road?" And then the final user message is, "I don't know." So if we run this, the response is "To get to the other side". Let's try again. 

"To get to the other side, fair sir or madam". It is an old and classic that never fails. So there's our Shakespearean response. 

And let's actually try one more thing. Because I want to make it even clearer that this is the assistant message. So here, let's just go and print the entire message response. 

So just to make this even clearer. This response is an assistant message. So the role is assistant and then the content is the message itself. So that's what's happening in this helper function. We're just kind of passing out the content of the message. 

So now let's do another example. So here our messages are, the system message is "You are a friendly chatbot", and the first user message is, "Hi, my name is Isa". And we want to get the first user message. So let's execute this for the first 
assistant message. 

And so the first message is, "Hello Isa! It's nice to meet you. How can I assist you today?" 

Now let's try another example. 

So here our messages are system message, "You are a friendly chatbot" and the first user message is, "Yes, can you remind me what is my "name? 

And let's get the response. And as you can see, the model doesn't actually know my name. 

So each conversation with a language model is a standalone interaction, which means that you must provide all relevant messages for the model to draw from in the current conversation. 

If you want the model to draw from, or quote unquote remember earlier parts of a conversation, you must provide the earlier exchanges in the input to the model. And so we'll refer to this as context. So let's try this. 

So now we've kind of given the context that the model needs, which is my name, in the previous messages, and we'll ask the same question, so we'll ask what my name is. 

And the model is able to respond because it has all of the context it needs in this kind of list of messages that we input to it. So now you're going to build your own chatbot. 

This chatbot is going to be called "OrderBot", and we're going to automate the collection of user prompts and assistant responses in order to build this "OrderBot". And it's going to take orders at a pizza restaurant, so first we're going to define this helper function, and what this is doing is it's going to kind of collect our user messages so we can avoid typing them in by hand in the same, in the way that we did above, and this is going to kind of collect prompts from a user interface that we'll build below, and then append it to a list called "context", and then it will call the model with that context every time. And the model response is then also added to the context, so the kind of model message is added to the context, the user message is added to the context, so on, so it just kind of grows longer and longer. 

This way the model has the information it needs to determine what to do next. And so now we'll set up and run this kind of UI to display the Autobot. And so here's the context, and it contains the system message that contains the menu. 

And note that every time we call the language model, we're going to use the same context, and the context is building 
up over time. And then let's execute this. 

Okay, I'm going to say, "Hi, I would like to order a pizza". And the assistant says, "Great, what pizza would you like to order? We have pepperoni, cheese, and eggplant pizza." Hmm. "How much are they?", Great, okay, we have the prices. I think I'm feeling a medium eggplant pizza. So as you can imagine, we could continue this conversation. And let's kind of look at what we put in the system message. 

So, "You are Autobot, an automated service to collect orders for a pizza restaurant. 

You first greet the customer, then collect the order, and then ask if it's a pick-up or delivery. You wait to collect the entire order, then summarize it and check for a final time if the customer wants to add anything else. If it's a delivery, you can ask for an address. 

Finally, you collect the payment. Make sure to clarify all options, extras and sizes to uniquely identify the item from the menu. You respond in a short, very conversational, friendly style. The menu includes.", and then, here we have the menu. 

So, let's go back to our conversation, and let's see if the assistant kind of has been following the instructions. 

Okay, great, the assistant asks if we want any toppings, which we kind of specified in the system message. 

So, I think we want no extra toppings. 

Sure thing. "Is there anything else you would like to order?" Let's get some water. Actually,fries. Small or large? This is great because we kind of asked the assistant in the system message to kind of clarify extras and sides. 

And so, you get the idea, and please feel free to play with this yourself. You can pause the video and just go ahead and run this in your own notebook on the left. 

And so, now we can ask the model to create a JSON summary that we could send to the order system based on the conversation. So, we're now appending another system message, which is an instruction, and we're saying, "Create a JSON summary of the previous food order. Itemize the price for each item. The fields should be 1) pizza, include side, 2) list of toppings, 3) list of drinks, and 4) list of sides", and finally, the total price. And you could also use a user message here. This does not have to be a system message. 
 
So, let's execute this. And notice, in this case, we're using a lower temperature because for these kinds of tasks, we want the output to be fairly predictable. For a conversational agent, you might want to use a higher temperature. However, in this case, I would maybe use a lower temperature as well because for a customer's assistant chatbot, you might want the output to be a bit more predictable as well. 

And so, here we have the summary of our order. And so, we could submit this to the order system if we wanted to. 

So there we have it, you've built your very own order chatbot. Feel free to kind of customise it yourself and play around with the system message to change the behaviour of the chatbot and kind of get it to act as different personas with different knowledge. 

关于大型语言模型的令人兴奋之处是，您只需付出少量努力就可以使用它构建自定义聊天机器人。

ChatGPT，这个网络界面，是您通过大型语言模型进行对话的方式。但其中一个酷炫的事情是，您还可以使用大型语言模型来构建自己的定制聊天机器人，也许扮演的是 AI 客户服务代理或餐厅的 AI 接单员的角色。在这个视频中，您将学习如何自己做到这一点。

我将更详细地描述 OpenAI 聊天完成格式的组件，然后您将自己构建一个聊天机器人。那么，让我们开始吧。首先，我们将像往常一样设置 OpenAI Python 包。

像 ChatGPT 这样的聊天模型实际上经过训练，可以作为输入接受一系列消息，并返回一个由模型生成的消息作为输出。

尽管聊天格式旨在使这样的多回合对话变得简单，但我们已经从之前的视频中看到，它对于没有任何对话的单回合任务同样有用。接下来，我们将定义两个辅助函数。这是我们在所有视频中一直使用的，它是「get_completion」函数。但如果您看一下，我们给出了一个提示，但在函数内部，我们实际上正在将此提示放入看起来像某种用户消息的东西中。

这是因为 ChatGPT 模型是一个聊天模型，这意味着它经过训练，可以将一系列消息作为输入，并返回一个由模型生成的消息作为输出。因此，用户消息是输入，然后助手消息是输出。

所以在这个视频中，我们实际上将使用一个不同的辅助函数，而不是作为输入放入单个提示并获得单个完成，我们将传入一系列消息，这些消息可以来自各种不同的角色。我将描述它们。

所以这里是一组消息的例子，首先是一个系统消息，它给出了整体的指示，然后在这条消息之后，我们有用户和助手之间的交互，这将继续进行。

如果你曾经使用过 ChatGPT 的网页界面，那么你的消息就是用户消息，而 ChatGPT 的消息是助手消息。系统消息帮助设置助手的行为和人格，并作为对话的高级指示。

所以你可以把它看作是在助手的耳边低声说话，指导它的回应，而用户并不知道系统消息的内容。所以作为用户，如果你曾经使用过 ChatGPT，你可能不知道 ChatGPT 的系统消息中有什么。

系统消息的好处是，它为你，作为开发者，提供了一种方式来框定对话，而不需要将请求本身作为对话的一部分。所以你可以指导助手，低声在它的耳边说话，指导它的回应，而不让用户知道。

现在，让我们尝试在对话中使用这些消息。我们将使用我们的新辅助函数从消息中获取完成。

我们还使用了较高的温度。所以系统消息说，「你是一个说话像莎士比亚的助手」。这是我们描述助手应该如何行为的方式。然后，第一条用户消息是，「给我讲个笑话」。下一条是，「为什么鸡要过马路？」然后最后一条用户消息是，「我不知道。」所以如果我们运行这个，回应是「为了到达另一边」。我们再试一次。

「为了到达另一边，公子或夫人」。这是一则古老而经典的笑话，永不过时。所以这是我们的莎士比亚式的回应。

让我们实际再尝试一件事。因为我想让这个助手消息更加明确。所以，在这里，我们就直接打印整个消息回应。

为了更清楚地解释，这个回应是一个助手消息。所以角色是助手，内容则是消息本身。这就是这个辅助函数发生的事情。我们只是提取出消息的内容。

现在，让我们再来一个例子。我们的消息是，系统消息是「你是一个友好的聊天机器人」，第一条用户消息是，「嗨，我叫 Isa」。我们想要得到第一条用户消息。所以让我们执行这个，得到第一条助手消息。

那么第一条消息是，「你好 Isa！很高兴认识你。我今天能帮你什么？」

现在，让我们尝试另一个例子。

这里我们的消息是系统消息：「你是一个友好的聊天机器人」，第一条用户消息是，「是的，你能提醒我我的名字是什么吗？」

然后我们得到回应。正如你所看到的，模型实际上不知道我的名字。

与语言模型的每次对话都是一个独立的交互，这意味着你必须为模型提供所有相关的消息，以便在当前对话中提取。

如果你想要模型从中提取，或引用前面部分的对话，你必须在输入给模型时提供前面的交流内容。我们称之为「上下文」。现在，让我们尝试这个。

所以现在我们已经给出了模型需要的上下文，即我之前的消息中的名字，我们会问同样的问题，所以我们会问我的名字是什么。

模型能够回应，因为它在我们输入的这些消息中有了所有需要的上下文。现在，你将建立自己的聊天机器人。

这个聊天机器人将被称为「OrderBot」，我们将自动化收集用户提示和助手回应，以建立这个「OrderBot」。它将在一个比萨餐厅接受订单，所以首先我们要定义这个辅助函数，它将收集我们的用户消息，这样我们就可以避免手工输入，就像我们上面所做的那样，它将从我们下面将建立的用户界面中收集提示，然后追加到一个名为「上下文」的列表中，然后每次都用那个上下文调用模型。模型的回应然后也被添加到上下文中，所以模型的消息被添加到上下文中，用户的消息被添加到上下文中，依此类推，它就变得越来越长。

这样，模型就有了它需要的信息来决定下一步做什么。现在，我们将设置并运行这种用户界面来显示 Autobot。这里是上下文，它包含了包含菜单的系统消息。

请注意，每次我们调用语言模型时，我们都会使用相同的上下文，并且上下文随着时间的推移在建立。然后，让我们执行这个。

好的，我会说，「嗨，我想要点一个比萨」。助手说，「太好了，你想要点什么比萨？我们有意大利辣香肠、奶酪和茄子比萨。」「它们多少钱？」好的，我们有价格。我想我想要一个中等的茄子比萨。如你所想，我们可以继续这个对话。现在，让我们看看我们在系统消息中放了什么。

所以，「你是 Autobot，一个自动服务，为一个比萨餐厅收集订单。

你首先问候客户，然后收集订单，然后询问是自取还是外送。你等待收集整个订单，然后总结它，最后确认客户是否想要再添加其他东西。如果是外送，你可以询问地址。

最后，你收集付款。确保明确所有选择、附加项和尺寸，以从菜单中唯一识别该项。你以简短、非常对话式、友好的风格回应。菜单包括……」，然后，这里我们有菜单。

那么，让我们回到我们的对话，看看助手是否一直在遵循指令。

好的，助手询问我们是否需要任何额外的配料，这是我们在系统消息中指定的。

所以，我认为我们不需要额外的配料。

没问题。「你还想要点别的吗？」让我们来点水。实际上，是薯条。小的还是大的？这很好，因为我们在系统消息中要求助手明确额外的和边菜。

所以，你明白了这个想法，请随意自己尝试。你可以暂停视频，然后直接在左侧的笔记本上运行这个。

接下来，我们可以要求模型根据对话创建一个 JSON 摘要，我们可以将其发送给订单系统。所以，我们现在正在追加另一个系统消息，这是一个指令，我们说，「创建之前食物订单的 JSON 摘要。为每个项目列出价格。字段应该是 1) 披萨，包括小食，2) 一系列的配料，3) 一系列的饮料，和 4) 一系列的小食」，最后是总价格。你也可以在这里使用用户消息。这不必是一个系统消息。

所以，让我们执行这个。注意，在这种情况下，我们使用的温度较低，因为对于这些类型的任务，我们希望输出是相当可预测的。对于一个会话代理，你可能想使用更高的温度。但是，在这种情况下，我可能也会使用较低的温度，因为对于客户助手聊天机器人，你可能希望输出更为可预测。

所以，这里我们有了我们订单的摘要。所以，我们可以提交给订单系统。

所以我们就有了，你已经建立了你自己的订单聊天机器人。请随意自己定制它，并玩弄系统消息以更改聊天机器人的行为，并使其以不同的知识扮演不同的角色。
