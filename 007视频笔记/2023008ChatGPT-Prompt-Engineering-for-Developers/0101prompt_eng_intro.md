## 0101. prompt_eng_intro

Welcome to this course on ChatGPT Prompt Engineering for Developers.

I'm thrilled to have with me Isa Fulford to teach this along with me. She is a member of the technical staff of OpenAI and had built the popular ChatGPT Retrieval plugin and a large part of her work has been teaching people how to use LLM or Large Language Model technology in products. She's also contributed to the OpenAI Cookbook that teaches people prompting. So thrilled to have you with me. 

And I'm thrilled to be here and share some prompting best practices with you all. 

So, there's been a lot of material on the internet for prompting with articles like 30 prompts everyone has to know. A lot of that has been focused on the chatGPT web user interface, which many people are using to do specific and often one-off tasks. But, I think the power of LLMs, large language models, as a developer tool, that is using API calls to LLMs to quickly build software applications, I think that is still very underappreciated. 
 
In fact, my team at AI Fund, which is a sister company to DeepLearning.ai, has been working with many startups on applying these technologies to many different applications, and it's been exciting to see what LLM APIs can enable developers to very quickly build. So, in this course, we'll share with you some of the possibilities for what you can do, as well as 
best practices for how you can do them. 

There's a lot of material to cover. First, you'll learn some prompting best practices for software development, then we'll cover some common use cases, summarizing, inferring, transforming, expanding, and then you'll build a chatbot using an LLM. We hope that this will spark your imagination about new applications that you can build. 

So in the development of large language models or LLMs, there have been broadly two types of LLMs, which I'm going to refer to as base LLMs and instruction-tuned LLMs. 

So, base LLM has been trained to predict the next word based on text training data, often trained on a large amount of data from the internet and other sources to figure out what's the next most likely word to follow. So, for example, if you were to prompt us once upon a time there was a unicorn, it may complete this, that is it may predict the next several words are that live in a magical forest with all unicorn friends. 

But if you were to prompt us with what is the capital of France, 
then based on what articles on the internet might have, it's 
quite possible that the base LLM will complete 
this with what is France's largest city, what is France's population and 
so on, because articles on the internet could 
quite plausibly be lists of quiz questions about the 
country of France. 
In contrast, an instruction-tuned LLM, which is where a lot of 
momentum of LLM research and practice has been going, an 
instruction-tuned LLM has been trained to follow instructions. So, if you 
were to ask it what is the capital of France, it's much more 
likely to output something like, the capital of 
France is Paris. So the way that instruction-tuned LLMs are typically 
trained is you start off with a base 
LLM that's been trained on a huge amount of text data and further train 
it, further fine-tune it with inputs and outputs that are instructions 
and good attempts to follow those 
instructions, and then often further refine using a technique called 
RLHF, reinforcement learning from human feedback, to 
make the system better able to be helpful and 
follow instructions. Because instruction-tuned LLMs have been trained 
to be helpful, honest, and harmless, 
so for example, they are less likely to output problematic 
text such as toxic outputs compared to base 
LLM, a lot of the practical usage scenarios have been shifting toward 
instruction-tuned LLMs. Some of the best practices you 
find on the internet may be more suited for a 
base LLM, but for most practical applications today, we would 
recommend most people instead focus on 
instruction-tuned LLMs which are easier to 
use and also, because of the work 
of OpenAI and other LLM companies becoming safer and more aligned. 
 
 
So, this course will focus on best practices for instruction-tuned 
LLMs, which is what we recommend you use for most 
of your applications. Before moving on, I just want to 
acknowledge the team from OpenAI and DeepLearning.ai that 
had contributed to the materials that Isa and 
I will be presenting. I'm very grateful to Andrew Mayne, Joe Palermo, Boris 
Power, Ted Sanders, and Lillian Weng from OpenAI that 
were very involved with us brainstorming materials, vetting the materials 
to put together the curriculum for this short 
course, and I'm also grateful on the DeepLearning side for 
the work of Geoff Lodwig, Eddy Shyu and Tommy 
Nelson. So, when you use an instruction-tuned LLM, think of giving 
instructions to another person, say someone that's smart but 
doesn't know the specifics of your task. So, when an LLM doesn't work, sometimes 
it's because the instructions weren't clear enough. For example, 
if you were to say, please write me something about 
Alan Turing. Well, in addition to that, it can be helpful to be 
clear about whether you want the text to focus on his scientific 
work or his personal life or his role 
in history or something else. And if you 
specify what you want the tone of 
the text to be, should it take on the tone like a 
professional journalist would write. Or is it more of a 
casual note that you dash off to a friend? 
That helps the LLM generate what you want. And of 
course, if you picture yourself asking, say, a 
fresh college graduate to carry out this task for 
you, if you can even specify what snippets of text, they 
should read in advance to write this text about 
Alan Turing, then that even better sets up 
that fresh college grad for success to carry 
out this task for you. So, in the 
next video, you see examples of how to be clear and specific, 
which is an important principle of prompting LLMs. And you 
also learn from Isa a second principle of 
prompting that is giving the LLM time to 
think. So with that, let's go on to the next video. 