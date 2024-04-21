## 20240419Zuckerberg最新访谈Llama3

[Mark Zuckerberg - Llama 3, $10B Models, Caesar Augustus, & 1 GW Datacenters - YouTube](https://www.youtube.com/watch?v=bc6uFV9CJGg)

“以下是我整理的 Dwarkesh Patel 对 Mark Zuckerberg 的采访文稿，请整理成更适合阅读的对话形式，根据话题形成章节，包含人名，尊照原意的情况下适当润色，从头开始，不要遗漏任何内容！”

如果没有输出完整需要不停的输入 continue 直到结束。

The following is a transcript of an interview I organized between Dwarkesh Patel and Mark Zuckerberg. Please format it into a more readable dialogue style, organize it by topics into sections, include names, and embellish appropriately while respecting the original meaning. Start from the beginning and make sure not to omit any content!

If the output is not complete, keep entering 'continue' until it ends.

### 原文转录

Here is the full transcript of the interview between Dwarkesh Patel and Mark Zuckerberg, formatted into a dialogue style and organized by topic:

#### Introduction

Dwarkesh Patel: Mark, welcome to the podcast.

Mark Zuckerberg: Hey, thanks for having me. Big fan of your podcast.

Dwarkesh: Oh, thank you. That's very nice of you to say. Let's start by talking about the releases that will go out when this interview goes out. Tell me about the models. Tell me about Meta AI. What's new? What's exciting about them?

#### Meta AI & Llama Models

Mark: I think the main thing that most people in the world are going to see is the new version of Meta AI. The most important thing about what we're doing is the upgrade to the model. We're rolling out Llama 3, doing it both as open source for the dev community and it is now going to be powering Meta AI.

With Llama 3, we now think that Meta AI is the most intelligent AI assistant that people can use that's freely available. We're also integrating Google and Bing for real-time knowledge. We're going to make it a lot more prominent across our apps - at the top of WhatsApp, Instagram, Facebook, Messenger. You'll just be able to use the search box right there to ask any question.

There's a bunch of new creation features that we added that I think are pretty cool, that people will enjoy. Animations is a good one - you can basically just take any image and animate it. But I think one that people are going to find pretty wild is it now generates high quality images so quickly. It actually generates it as you're typing and updates it in real time. So you're typing your query and it's honing in... showing you a picture of a cow in a field with mountains, eating macadamia nuts, drinking beer. It's updating the image in real time as you type. It's pretty wild. I think people are going to enjoy that.

So that's what most people are going to see in the world. We're rolling that out, starting in a handful of countries, and we'll do more over the coming weeks and months. It's a big step forward for Meta AI.

But if you want to get under the hood a bit, the Llama 3 stuff is obviously the most technically interesting. For the first version, we're training three versions - an 8 billion, a 70 billion which we're releasing today, and a 405 billion dense model which is still training.

The 8 and 70 billion models - I'm pretty excited about how they turned out. They're leading for their scale. We'll release a blog post with all the benchmarks so people can check it out themselves. And it's open source, so people get a chance to play with it.

We have a roadmap of new releases coming that are going to bring multimodality, more multilinguality, bigger context windows to those as well. Then hopefully sometime later in the year, we'll get to roll out the 405 billion model. For where it is right now in training, it is around 85 MMLU and we expect it's going to have leading benchmarks.

The 70 billion model is great too. We're releasing that today - it's around 82 MMLU and has leading scores on math and reasoning. So just getting these models in people's hands is going to be pretty wild.

And the 8 billion model is nearly as powerful as the biggest version of Llama 2 that we released. So the smallest Llama 3 is basically as powerful as the biggest Llama 2.

Dwarkesh: Wow, that's super impressive.

#### Investing in AI Infrastructure

Dwarkesh: I want to go back in time to 2022, when you started acquiring these H100s. Your stock price was getting hammered, people were questioning the CapEx spending and the Metaverse investment. Presumably, you were spending that CapEx to get these H100s. Back then, how did you know to get the H100s and that you'd need the GPUs?

Mark: I think it was because we were working on Reels. We got into a situation where we always want to have enough capacity to build something that we can't quite see on the horizon yet.

With Reels, we needed more GPUs to train the models. It was a big evolution for our services. Instead of just ranking content from people who you follow, we made a big push to start recommending unconnected content - basically content from people or pages that you're not following.

So the corpus of content candidates that we could potentially show you expanded from on the order of thousands to on the order of hundreds of millions. Completely different infrastructure. And we were constrained on the infrastructure that we had to catch up to what TikTok was doing as quickly as we wanted to.

So I looked at that and was like, hey, we have to make sure we're never in this situation again. Let's order enough GPUs to do what we need for Reels and feed ranking. But let's also double that, because our normal principle is there's going to be something on the horizon that we can't see.

Dwarkesh: Did you know it would be AI?

Mark: Well, we thought it was going to be something that had to do with training large models. At the time, I thought it was probably going to be more something related to content. But it's almost just pattern matching in running the company - there's always another thing.

I'm not even sure I had that specific insight at the time. I was so deep in just trying to get the recommendations working for Reels and other content. That's such a big unlock for Instagram and Facebook - to be able to show people interesting content from those they're not even following. But that ended up being a very good decision in retrospect.

And it came from being behind. Most of the times where we make some decision that ends up seeming good is because we messed something up before and just didn't want to repeat the mistake.

#### Why Mark Didn't Sell Facebook Early On

Dwarkesh: This is a total detour, but I actually want to ask about this while we're on this. You didn't sell for $1 billion, but presumably there's some amount you would have sold for, right? Did you write down in your head what you thought the actual valuation of Facebook was at the time, and that they weren't actually getting the valuation right?

Mark: Yeah, I don't know. I mean, look, I think some of these things are just personal. I don't know that at the time I was sophisticated enough to do that analysis. But I had all these people around me making arguments for how a billion dollars was so far in the future - here's the revenue we need to make, here's how big we need to be, it's clearly so many years away. It was very far ahead of where we were at the time.

I didn't really have the financial sophistication to engage with that kind of debate. I just sort of deep down believed in what we were doing. And I did some analysis - okay, what would I go do if I wasn't doing this? Well, I really like building things. I like helping people communicate. I like understanding what's going on with people and the dynamics between people. So I think if I sold this company, I'd just go build another company like this. And I kind of like the one I have!

So I don't know. I think a lot of the biggest bets that people make are often just based on conviction and values. It's actually usually very hard to do the analyses, trying to connect the dots forward.

#### AI Becoming Central to Meta

Dwarkesh: You've had Facebook AI Research for a long time. At what point did making AGI, or however you consider that mission, become a key priority of what Meta is doing?

Mark: It's been a big deal for a while. We started FAIR about 10 years ago. The idea was that along the way to general intelligence or full AI, there can be all these different innovations that are going to improve everything that we do.

We didn't conceive it as a product, it was more a research group. And over the last 10 years, it has created a lot of different things that have improved all of our products and advanced the field. It's allowed other people in the field to create things that have improved our products too. So that's been great.

But there's obviously been a big change in the last few years when ChatGPT comes out, the diffusion models around image creation come out. This is some pretty wild stuff that is pretty clearly going to affect how people interact with every app.

So at that point, we started a second group, the GenAI group, with the goal of bringing that stuff into our products. Building leading foundation models that would power all these different products.

Initially, when we started doing that, the theory was a lot of the stuff we're doing is pretty social - helping people interact with creators, helping people interact with businesses so they can sell things or do customer support, or basic assistant functionality for apps, smart glasses, VR, all these different things.

So initially, it wasn't completely clear that you were going to need full AGI to support those use cases. But then through working on them, I think it's actually become clear that you do. It's in all these subtle ways.

For example, for Llama 2, when we were working on it, we didn't prioritize coding. The reason why is we thought people aren't going to ask Meta AI a lot of coding questions in WhatsApp.

But a somewhat surprising result over the last 18 months is that coding is important for a lot of domains, not just coding. Even if people aren't asking coding questions to the models, training the models on coding helps them be more rigorous, answer questions better, and help reason across a lot of different domains.

So for Llama 3, we really focused on training it with a lot of coding, because that's going to make it better on all these things, even if people aren't primarily asking coding questions.

Reasoning is another example. You might want to chat with a creator, or you're a business trying to interact with a customer. That interaction is not just the person sending a message and you replying. It's a multi-step interaction where you're trying to think through how to accomplish the person's goals.

A lot of times when a customer comes, they don't necessarily know exactly what they're looking for or how to ask their questions. So it's not really the job of the AI to just respond to the question. You need to think about it more holistically. It really becomes a reasoning problem.

So if someone else solves reasoning or makes good advances on it, and we're sitting here with a basic chatbot, then our product is lame compared to what other people are building.

So at the end of the day, we realized we've got to solve general intelligence. We upped the ante and the investment to make sure we could do that. The version of Llama that's going to solve all these use cases for users - is that the version that will be powerful enough to replace a programmer you might have in this building?

I just think all this stuff is going to be progressive over time. There's a lot baked into that question. I'm not sure we're replacing people as much as giving people tools to do more. Is the programmer in this building 10X more productive after? I would lean towards yes.

But I don't believe there's a single threshold of intelligence for humanity. People have different skills. At some point, AI is probably going to surpass people at most of those things, depending on how powerful the models are. But I think it's progressive.

And I don't think AGI is one thing. You're basically adding different capabilities. Multimodality is a key one we're focused on now, initially with photos, images and text, but eventually with videos. And then because we're so focused on the metaverse, 3D type stuff is important.

One modality that I'm pretty focused on that I haven't seen as many other people in the industry focus on is emotional understanding. So much of the human brain is dedicated to understanding people, understanding your expressions and emotions. I think that's its own whole modality. You could say maybe it's just video or image, but it's clearly a very specialized version of those two.

So there's all these different capabilities that I think you want to train the models to focus on, as well as getting a lot better at reasoning, getting a lot better at memory, which I think is its own whole thing.

I don't think we're going to be primarily shoving context into a query context window in the future to ask more complicated questions. I think there will be different stores of memory or custom models that are maybe more personalized to people.

But I think these are all just different capabilities. And then obviously making them big and small, we care about both. If you're running something like Meta AI, then we have the ability for it to be pretty server-based. But we also want it running on smart glasses where there's not a lot of space. So you want to have something that's very efficient for that.

Future Use Cases & Scaling Challenges

Dwarkesh: What is the use case where you're doing tens or even hundreds of billions of dollars worth of inference, using intelligence at an industrial scale? Is it simulations? The AIs in the metaverse? What will we be using the data centers for?

Mark: My bet is that this is going to change all of the products. I think there's going to be a Meta AI general assistant product. That will shift from something that feels more like a chatbot, where you just ask a question that formulates an answer, to things where you're increasingly giving it more complicated tasks that it goes away and does. So that's going to take a lot of inference, a lot of compute.

Then I think a big part of what we're going to do is interacting with other agents for other people, whether it's businesses or creators. I guess a big part of my theory on this is that there's not just going to be one singular AI that you interact with. I think every business is going to want an AI that represents their interests. They're not going to want to primarily interact with you through an AI that is going to sell their competitors' products.

So I think creators is going to be a big one. There are about 200 million creators on our platforms. They all have the pattern where they want to engage their community, but they're limited by hours in the day. And their community generally wants to engage them, but they're also limited by hours in the day.

So if you could create something where an AI could basically allow that creator to own the AI, train it in the way they want, and engage their community, I think that's going to be super powerful too. I think there's going to be a ton of engagement across all these things.

But these are just the consumer use cases. I think when you think about stuff like the Chan Zuckerberg Initiative that my wife and I run, we're doing a bunch of stuff on science. There's obviously a lot of AI work that I think is going to advance science, healthcare, and all these things too.

So I think it ended up affecting basically every area of the products and the economy.

Dwarkesh: The thing you mentioned about an AI that can just go out and do something multi-step for you, is that a bigger model? Is that you'll make Llama 4 where there will be a version that's still 70B, but you'll just train it on the right data and that will be super powerful? What does the progression look like? Is it scaling? Same size but different data sets like you were talking about?

Mark: I don't know that we know the answer to that. I think one pattern that seems to emerge is that you have the base Llama model, and then you build some other application specific code around it. Some of it is fine-tuning for the use case, but some of it is logic for how Meta AI should integrate with tools like Google or Bing to bring in real-time knowledge. That's not part of the base Llama model, that's like part of the application.

So for Llama 2, we had some of that and it was a little more hand-engineered. Part of our goal for Llama 3 was to bring more of that into the model itself. But for Llama 3, as we start getting into more of these agent-like behaviors, I think some of that is going to be more hand engineered. Then I think our goal for Llama 4 will be to bring more of that into the model.

So I think at each step along the way, you kind of have a sense of what's going to be possible on the horizon. You start messing with it and hacking around it. And then I think that helps you hone your intuition for what you want to try to train into the next version of the model itself. Which makes it more general, because anything you're hand coding is inherently brittle and non-general.

Dwarkesh: What is the community fine-tune of Llama 3 you're most excited by? Maybe not the one that will be most useful to you, but just one you will enjoy playing with the most? Like fine-tune it on antiquity and you'll just be talking to Virgil or something. What are you excited about?

Mark: I don't know. I mean, I think the nature of the stuff is that you get surprised. So I think any specific thing that I thought would be valuable, we'd probably be building.

But I think you'll get distilled versions, smaller versions. One thing is eight billion - I don't think that's quite small enough for a bunch of use cases. Over time, I'd love to get a billion parameter model, or a two billion parameter model, or even a 500 million parameter model and see what you can do with that.

Because as they start getting smaller, if with eight billion parameters we're basically nearly as powerful as the largest Llama 2 model, then with a billion parameters, you should be able to do something that's interesting. And faster, good for classification, or a lot of basic things that people do before understanding the intent of a user query and feeding it to the most powerful model to hone what the prompt should be

---

Scaling & Energy Constraints

Dwarkesh: So you have all these GPUs - I think you said 350,000 by the end of the year. That's the whole fleet?

Mark: I mean, we built two clusters, I think it's like 22,000-24,000 clusters that are the single clusters we have for training the big models. Obviously across a lot of the stuff that we do, a lot of our stuff goes towards training Reels models, Facebook news feed, Instagram feed.

And then inference is a huge thing for us because we serve a ton of people. So our ratio of inference compute required to training is probably much higher than most other companies doing this stuff, just because of the sheer volume of the community we're serving.

Dwarkesh: That was really interesting in the material they shared with me before - you trained it on more data than is compute optimal just for training, because the inference is such a big deal for you guys and also for the community. It makes sense to just have this thing and have trillions of tokens in there.

Mark: Yeah, although one interesting thing we saw even with the 70 billion model - we thought it would get more saturated. We trained it on around 15 trillion tokens. Our prediction going in was that it was going to asymptote more, but even by the end it was still learning.

We probably could have fed it more tokens and it would have gotten somewhat better. But at some point, you're running a company, you need to do these meta-reasoning questions of how to spend our GPUs. Do we want to train this 70 billion model further or get on with it so we can start testing hypotheses for Llama 4?

We needed to make that call and I think we got to a reasonable balance for this version of the 70 billion. There will be others in the future where the 70 billion multimodal one will come over the next period. But yeah, it was fascinating that the architectures at this point can just take so much data.

Dwarkesh: So what does this imply about future models? You mentioned the Llama 3 8B is nearly as good as the Llama 2 70B. Does that mean the Llama 4 70B will be as good as the Llama 3 405B? What is the future? This is one of the great questions that I think no one knows.

Mark: It's one of the trickiest things in the world to plan around - when you have an exponential curve, how long does it keep going for?

I think it's likely enough that it will keep going, that it is worth investing the tens or hundred billion plus in building the infrastructure. To assume that if it keeps going, you're going to get some really amazing things that are just going to make amazing products. But I don't think anyone in the industry can really tell you that it will continue scaling at that rate for sure.

In general, in history, you hit bottlenecks at certain points. Now there's so much energy on this that maybe those bottlenecks get knocked over pretty quickly. But I don't know. That's an interesting question - what does the world look like where there aren't these bottlenecks?

Suppose progress just continues at this pace, which seems plausible. Zooming out, there are going to be different bottlenecks. If not training, then energy.

Over the last few years, there's been this issue of GPU production. Even companies that had the money to pay for the GPUs couldn't necessarily get as many as they wanted because there were all these supply constraints.

Now I think that's getting less. So now, you're seeing a bunch of companies think about just really investing a lot of money in building out these things. And I think that will go for some period of time.

I think there is a capital question of at what point does it stop being worth it to put the capital in? But I actually think before we hit that, you're going to run into energy constraints. Because getting energy permitted is a very heavily regulated government function.

You're going from software, which is somewhat regulated - I'd argue that it is more regulated than a lot of people in the tech community feel, although it's obviously different. If you're starting a small company maybe you feel that less. If you're a big company, we interact with different governments and regulators, we have lots of rules we need to follow and make sure we do a good job with around the world.

But I think there's no doubt that energy, if you're talking about building large new power plants or large buildouts and then building transmission lines that cross other private or public land, that is just a heavily regulated thing. You're talking about many years of lead time.

So if we wanted to stand up some massive facility to power that, I think that's a very long-term project. I think people will do it. But I don't think this is something that can be quite as magical as just - okay, you get a level of AI, you get a bunch of capital, you put it in and then all of a sudden the models are just going to... I think you do hit different bottlenecks along the way.

Dwarkesh: Is there something, a project maybe related maybe not, that even a company like Meta doesn't have the resources for? Like if your R&D budget or CapEx budget was 10X what it is now, then you could pursue it. It's in the back of your mind, but Meta today can't even issue a stock or bond for it because it's just 10X bigger than your budget?

Mark: Well, I think energy is one piece. I think we would probably build out bigger clusters than we currently can if we could get the energy to do it. So I think that's fundamentally money bottlenecked in the limit.

If you look at it in terms of how far the exponential curves go - I think a number of companies are working on data centers on the order of 50 megawatts or 100 megawatts. A big one might be 150 megawatts.

So you take a whole data center and fill it up with just all the stuff you need for training and build the biggest cluster you can. I think a bunch of companies are running at stuff like that.

But then when you start getting into building a data center that's 300 megawatts or 500 megawatts or a gigawatt - just no one has built a single gigawatt data center yet. So I think it will happen, this is only a matter of time, but it's not going to be next year. I think some of these things will take some number of years to build out.

And then the question is, if you put this in perspective, I think a gigawatt is around the size of a meaningful nuclear power plant only going towards training a model.

Dwarkesh: Didn't Amazon do this? They have a 950 gigawatt data center.

Mark: Yeah, I'm not exactly sure what they did. You'd have to ask them. But it doesn't have to be in the same place, right? If distributed training works, it can be distributed. I think that's a big question - basically how that's going to work.

I do think in the future, it seems quite possible that more of what we call training for these big models is actually more along the lines of inference generating synthetic data to then go feed into the model.

So I don't know what that ratio is going to be, but I consider the generation of synthetic data to be more inference than training today. But obviously, if you're doing it in order to train a model, it's part of the broader training process. So I don't know, that's an open question as to where the balance of that is and how it plays out.

Potential Impacts of Open Sourcing

Dwarkesh: If that's the case, would that potentially also be the case with Llama 3? And maybe Llama 4 onwards, where you put this out and if somebody has a ton of compute, then using the models that you've put out, you can just keep making these things arbitrarily smarter. Like some country with a ton of compute can just use Llama to make something much smarter.

Mark: I do think there are going to be dynamics like that. But I also think there is a fundamental limitation on the network architecture or the model architecture.

So I think a 70 billion model that we trained with the Llama 3 architecture can get better. It can keep going. We felt like if we kept on feeding it more data or rotated the high value tokens through again, it would continue getting better.

And we've seen a bunch of other people around the world, different companies, basically take the Llama 2 70 billion base, take that model architecture and then build a new model.

It's still the case that when you make a generational improvement to the Llama 3 70 billion or the Llama 3 405 billion, there's nothing open source anything like that today. I think that's a big step function in what people are going to be able to build on top of that. I don't think it can go infinitely from there. I think there can be some optimization in that until you get to the next step function.

Potential Impacts of AI

Dwarkesh: Okay, so let's zoom out a little bit from specific models and even the many years lead times you would need to get energy approvals and so on. Big picture, these next couple of decades - what's happening with AI? Does it feel like another technology like the metaverse or social media? Or does it feel like a fundamentally different thing in the course of human history?

Mark: I think it's going to be pretty fundamental. I think it's going to be more like the creation of computing in the first place. You'll get all these new apps in the same way that when you got the web or mobile phones, people rethought all these experiences and a lot of things that weren't possible before now became possible.

So I think that will happen, but I think it's a much lower level innovation. It's going to be more like going from people not having computers to people having computers, is my sense.

But it's also very hard to reason about exactly how this goes. I tend to think that on the cosmic scale, obviously it will happen quickly over a couple of decades or something. But I do think that there is some set of people who are afraid of it really just spinning and going from being somewhat intelligent to extremely intelligent overnight.

And I just think that there's all these physical constraints that make that unlikely to happen. I just don't really see that playing out. So I think we'll have time to kind of acclimate a bit, but it will really change the way that we work and give people all these creative tools to do different things.

I think it's going to really enable people to do the things that they want a lot more, is my view.

Dwarkesh: Okay, so maybe not overnight. But is it your view that on a cosmic scale, if you think humans evolved and then AI happened, then they went out through the galaxy - maybe it takes many decades, maybe it takes a century. But is that the grand scheme of what's happening right now in history?

Mark: I think that's tricky. I think the history of humanity has been people thinking that certain aspects of humanity are really unique in different ways. And then coming to grips with the fact that that's not true, but humanity is actually still super special.

So it's like we thought that the Earth was the center of the universe. And it's not, but humans are still pretty awesome and pretty unique.

I think another bias that people tend to have is thinking that intelligence is somehow fundamentally connected to life. And it's not actually clear that it is. I mean, I don't know that we have a clear enough definition of consciousness or life to fully interrogate this.

But I know there's all the science fiction about - okay, you create intelligence and now it starts taking on all these human-like behaviors and things like that. But I actually think that the current incarnation of all this stuff, at least, kind of feels like it's going in a direction where intelligence can be pretty separated from consciousness and agency and things like that. I think that just makes it a super valuable tool.

So I don't know. I mean, obviously it's very difficult to predict what direction the stuff goes in over time, which is why I don't think anyone should be dogmatic about how they plan to develop it or what they plan to do.

I think you want to look at each release. We're obviously very pro open source, but I haven't committed that we're going to release every single thing that we do. It's basically that I'm just generally very inclined to thinking that open sourcing it is going to be good for the community and also good for us, because we'll benefit from the innovations.

But if at some point there's some qualitative change in what the thing is capable of and we feel like it's just not responsible to open source it, then we won't. So I don't know, it's all very difficult to predict.

Dwarkesh: What is a kind of qualitative change? Like a specific thing you're training Llama 5 and you've seen this and you're like, you know what, I'm not sure about open sourcing it.

Mark: I think it's a little hard to answer that in the abstract because there are negative behaviors that any product can exhibit that as long as you can mitigate, it's okay.

So, there's bad things about social media that we work to mitigate. There's bad things about Llama 2 that we spend a lot of time trying to make sure it's not helping people commit violent acts or things like that.

I mean, that doesn't mean that it's like an autonomous or intelligent agent. It just means that it's learned a lot about the world and it can answer a set of questions that we think it would be unhelpful for it to answer.

So I don't know. I think the question isn't really what behaviors would it show? It's what things would we not be able to mitigate after it shows that?

And I don't know. I think there's so many ways in which something can be good or bad that it's hard to actually enumerate them all up front.

If you even look at what we've had to deal with in social media and the different types of harms we've gotten to - there's like 18 or 19 categories of harmful things that people do. And we've basically built AI systems to try to go identify what those things are that people are doing and try to make sure that doesn't happen on our network as much as possible.

So yeah, I think over time, you'll be able to break this down into more of a taxonomy too. And I think this is a thing that we spend time researching too, because we want to make sure that we understand that.

Dwarkesh: One of the things I asked Mark is what industrial scale use of LLMs would look like. You see this in previous technological revolutions where at first they're thinking in a very small scale way about what's enabled. And I think that's what chatbots might be for LLMs.

And I think the large scale use case might look something like what V7go is. By the way, it's made by V7 Labs who's sponsoring this episode.

So it's like a spreadsheet. You put in raw information like documents, images, whatever, and they become rows and the columns are populated by an LLM of your choice.

And in fact, I used it to prepare for Mark. So I fed in a bunch of blog posts and papers from Meta's AI research. And as you can see, if you're on YouTube, it summarizes and extracts exactly the information I want as columns. And obviously mine is a small use case.

But you can imagine, for example, a company like FedEx has to process half a million documents a day. Obviously a chatbot can't do that. A spreadsheet can because this is just like a firehose of intelligence in there, right?

Anyways, you can learn more about them at v7labs.com/go or the link in the description.

Open Source Tradeoffs

Dwarkesh: It seems to me it would be a good idea - I would be disappointed in a future where AI systems aren't broadly deployed and everybody doesn't have access to them. At the same time, I want to better understand the mitigations.

Because if the mitigation is the fine-tuning, well, the whole thing about open weights is that you can then remove the fine-tuning which is often superficial on top of these capabilities.

Like if it's talking on Slack with a biology researcher - and again I think models are very far from this, they're like Google search right now. But it's like I can show them my petri dish and they can explain here's why your smallpox sample didn't grow, here's what to change. How do you mitigate that? Because somebody can just fine-tune that in there, right?

Mark: Yeah, I mean, that's true. I think a lot of people will basically use the off-the-shelf model. And some people who have bad faith are going to try to strip out all the safeguards. So I do think that's an issue.

The flip side of this is that, and this is one of the reasons why I'm philosophically so pro open source, is I do think that a concentration of AI in the future has the potential to be as dangerous as it being widespread.

So I think a lot of people think about the questions of - okay, well, if we can do this stuff, is it bad for it to be out in the wild, just widely available?

I think another version of this is - okay, well, it's probably also pretty bad for one institution to have an AI that is way more powerful than everyone else's AI.

So if you look at it, I guess one security analogy that I think of is - it doesn't take AI to basically say there's security holes in so many different things. And if you could travel back in time a year or two years, that's not AI. It's like you just have one or two years more knowledge of the security holes, you could pretty much hack into any system.

So it's not that far-fetched to believe that a very intelligent AI would probably be able to identify some holes and basically be like a human who could potentially go back in time a year or two and compromise all these systems.

Okay, so how have we dealt with that as a society? Well, one big part is open source software that makes it so that when improvements are made to the software, it doesn't just get stuck in one company's products, but it can be broadly deployed to a lot of different systems, whether it's banks or hospitals or government stuff.

As the software gets hardened, which happens because more people can see it and more people can bang on it, and there are standards on how this stuff works - the world can kind of get upgraded together pretty quickly.

And I kind of think that a world where AI is very widely deployed in a way where it's gotten hardened progressively over time, and is one where all the different systems will be in check, seems like it is fundamentally more healthy to me than one where this is more concentrated.

So there are risks on all sides, but I think that's one risk that people don't talk about quite as much. I think there's the risk of - okay, what if the AI system does something bad?

I stay up at night more worrying - what if some actor that you don't trust, whether it's some other government that is an opponent of our country, or some company that you don't trust, or whatever it is - if they're the ones who have the super strong AI, I think that's potentially a much bigger risk.

They could overthrow our government because they have a weapon that nobody else has, cause a lot of mayhem. I think the intuition is that this stuff ends up being pretty important and invaluable for both economic and security and other things.

And I just think, if someone who you don't trust, or is an adversary of you, gets something that is more powerful, then that could be an issue. And I think probably the best way to mitigate that is to have good open source AI that basically becomes the standard, and in a lot of ways can become the leader.

And in that way, it just ensures that it's a much more even and balanced playing field.

Dwarkesh: Yeah, that seems plausible to me. And if that works out, that would be the future I prefer. I guess I want to understand mechanistically how, if somebody was going to cause mayhem with AI systems, how the fact that there are other open source systems in the world prevents that?

Like the specific example of somebody coming with a bioweapon. Is it just that we'll do a bunch of R&D in the rest of the world to figure out vaccines really fast? Like what's happening?

Mark: If you take the computer security one that I was talking about, I think someone with a weaker AI trying to hack into a system that is protected by a stronger AI will succeed less. So I think that's in terms of how do you know everything in the world is like that.

Like what if bioweapons aren't like that? No, I mean, I don't know that everything in the world is like that. I think bioweapons are one of the areas where the people who are most worried about this stuff are focused. And I think it makes a lot of sense to think about that.

And I think there are certain mitigations, you can try to not train certain knowledge into the model. There's different things. But yeah, I mean, at some level, if you get a sufficiently bad actor, and you don't have other AI that can sort of balance them, and understand what's going on and what the threats are, then that could be a risk. So I think that's one of the things that we need to watch out for.

Deceptive Behaviors in AI

Dwarkesh: Is there something you could see in the deployment of these systems where you observe you're training a Llama 4 and it lied to you because it thought you weren't noticing or something. And you're like, whoa, what's going on here? This is probably not likely with the Llama 4 type system, but is there something you can imagine like that where you'd be really concerned about deceptiveness and if billions of copies of things are out in the wild?

Mark: Yeah, I mean, I think that's not necessarily - right now we see a lot of hallucinations. So I think it's more that. I think it's an interesting question how you would tell the difference between a hallucination and deception.

But yeah, I mean, look, I think there's a lot of risks and things to think about. The flip side of all this is that there are also a lot of - I try in running our company, at least balance what I think of as these longer term theoretical risks with what I actually think are quite real risks that exist today.

So when you talk about deception, the form of that that I worry about most is people using this to generate misinformation, and then pump that through whether it's our networks or others.

So the way that we've basically combated a lot of this type of harmful content is by building AI systems that are smarter than the adversarial ones. And I guess this kind of informs part of my theory on this.

If you look at the different types of harm that people do or try to do through social networks - there are ones that are not very adversarial. So for example, hate speech, I would say is not super adversarial in the sense that people aren't getting better at being racist. It's just like, okay, if you kind of - that's one where I think the AIs are generally just getting way more sophisticated, faster than people are at those issues.

So we have issues both ways. It's like people do bad things, whether they're trying to incite violence or something. But we also have a lot of false positives, where we basically censor stuff that we shouldn't and I think understandably make a lot of people annoyed.

So I think having an AI that just gets increasingly precise on that, that's going to be good over time.

But let me give you another example, which is nation states trying to interfere in elections. That's an example where they absolutely have cutting edge technology and get better each year. So we block some technique, they learn what we did, they come at us with a different technique.

It's not like a person trying to say mean things. It's basically they have a goal, they're sophisticated, they have a lot of technology.

In those cases, I still think the ability to have our AI systems grow in sophistication at a faster rate than theirs - it's an arms race, but I think we're at least currently winning that arms race.

So I don't know. I think that's a lot of the stuff that I spend time thinking about. Yes, it is possible that whether it's Llama 4 or Llama 5 or Llama 6, we need to think about what behaviors we're observing. And it's not just us. I think part of the reason why you make this open source is that there are a lot of other people who study this too.

So we want to see what other people are observing, what we're observing, what we can mitigate, and then we'll make our assessment on whether we can make it open source. But I think for the foreseeable future, I'm optimistic we will be able to.

And in the near term, I don't want to take our eye off the ball of what are actual bad things that people are trying to use the models for today, even if they're not existential. They're pretty bad day-to-day harms that we're familiar with in running our services.

That's actually a lot of what we have to spend our time on as well.

Dwarkesh: I found the synthetic data thing really curious. I'm actually interested in why you don't think current models - it makes sense why there might be an asymptote with just doing the synthetic data again and again if they get smarter.

You use the kind of techniques you talk about in the blog post that's coming out on the day this will be released, where it goes to the thought chain that is the most correct. Why this wouldn't lead to a loop that, of course, it wouldn't be overnight, but over many months or years of training potentially with a smarter model, it gets smarter, makes better output, gets smarter, and so forth.

Mark: Well, I think it could within the parameter of whatever the model architecture is. It's just that at some level, I don't know. I think today's 8 billion parameter models - I just don't think you're going to be able to get to be as good as the state-of-the-art multi-hundred billion parameter models that are incorporating new research into the architecture itself.

Dwarkesh: But those will be open source as well, right?

Mark: Well, yeah, but I think that's if - subject to all the questions that we just talked about. Yes, I mean, we would hope that that'll be the case. But I think at each point, I don't know.

It's like when you're building software, there's a ton of stuff that you can do with software. But then at some level, you're constrained by the chips that it's running on.

So there are always going to be different physical constraints. And how big the models are is going to be constrained by how much energy you can get and use for inference.

So I guess I'm simultaneously very optimistic that this stuff will continue to improve quickly and also a little more measured than I think some people are about - I just don't think the runaway case is a particularly likely one.

I think it makes sense to keep your options open. There's so much we don't know. There's a case in which it's really important to keep the balance of power so nobody becomes a totalitarian dictator.

There's a case in which you don't want to open source the architecture because China could use it to catch up to America's AIs and there is an intelligence explosion and they win that.

A lot of things are possible. Just keeping your options open, considering all of them seems reasonable.

Other Topics - Metaverse & Open Source Impact

Dwarkesh: Let's talk about some other things. Metaverse - what time period in human history would you be most interested in going into, from 100,000 BCE to now? You just want to see what it was like for the past?

Mark: It has to be the past. I don't know. I mean, I have the periods of time that I'm interested in. I'm really interested in American history and classical history. I'm really interested in the history of science, too. So I actually think seeing and trying to understand more about how some of the big advances came about.

I mean, all we have are somewhat limited writings about some of that stuff. I'm not sure the metaverse is going to let you do that, because we can't really go back in time for things that we don't have records of.

But I'm actually not sure that going back in time is going to be that important of a thing for the metaverse. I mean, I think it's going to be cool for history classes and stuff. But that's probably not the use case that I'm most excited about for the metaverse overall.

I think the main thing is just the ability to feel present with people no matter where you are. I think that's going to be killer.

I mean, in the AI conversation that we're having, so much of it is about physical constraints that kind of underlie all of this. And you want to move - I think one lesson of technology is you want to move things from the physical constraint realm into software as much as possible, because software is so much easier to build and evolve.

And you can democratize it more because not everyone is going to have a data center, but a lot of people can kind of write code and take open source code and modify it.

The metaverse version of this is I think enabling realistic digital presence is going to be just an absolutely huge difference for making it so that people don't feel like they have to physically be together for as many things.

Now, I mean, I think there are going to be things that are better about being physically together. So it's not - these things aren't binary. It's not going to be like, okay, now you don't need to do that anymore.

But overall, I think it's just going to be really powerful for socializing, for feeling connected with people, for working, for parts of industry, for medicine, for so many things.

Dwarkesh: I want to go back to something you said at the beginning of the conversation where you didn't sell the company for a billion dollars. And like the metaverse, you knew we were going to do this, even though the market was hammering you for it. And then I'm actually curious, what is the source of that edge?

And you said like, oh, values, I have this intuition. But like everybody says that, right? Like what if you had to say something that's specific to you? How would you express what that is? Why were you so convinced about the metaverse?

Mark: Well, I think those are different questions. So what are the things that kind of power me? I think we've talked about a bunch of the themes.

I just really like building things. I specifically like building things around how people communicate and sort of understanding how people express themselves and how people work.

When I was in college, I studied computer science and psychology. I think a lot of other people in the industry studied computer science. So it's always been sort of the intersection of those two things for me.

But I think it's also sort of this really deep drive. I don't know how to explain it. But I just feel like constitutionally, I'm doing something wrong if I'm not building something new.

And so I think even when we're putting together the business case for investing 100 billion dollars in AI or some huge amount in the metaverse, yeah, I mean, we have plans that I think make it pretty clear that if our stuff works, it'll be a good investment.

But you can't know for certain from the outset. And there's all these arguments that people have, whether it's with advisors or different folks, it's like, well, how could you - how are you confident enough to do this?

And it's like, well, the day I stop trying to build new things, I'm just done. I'm gonna go build new things somewhere else. It is - I'm fundamentally incapable of running something or in my own life and not trying to build new things that I think are interesting.

That's not even a question for me. Whether we're going to go take a swing at building the next thing - I'm just incapable of not doing that.

And I don't know, I'm kind of like this in all the different aspects of my life. It's like, we built this ranch in Kauai and I just worked to design all these buildings. I'm kind of trying to - we started raising cattle and I'm like, all right, well, I want to make the best cattle in the world. So how do we architect this so that we can figure this out and build and call the stuff up that we need to try to do that.

So I don't know, that's me.

Dwarkesh: What was the other part of the question?

Mark: Look, Meta is just a really amazing tech company. They have all these great software engineers and even they work with Stripe to handle payments. I think that's just a really notable fact that Stripe's ability to engineer these checkout experiences is so good that big companies like Ford, Zoom, Meta, even OpenAI, they work with Stripe to handle payments.

Because just think about how many different possibilities you have to handle. If you're in a different country, you'll pay a different way. And if you're buying a certain kind of item, that might affect how you decide to pay.

And Stripe is able to test these fine-grained optimizations across tens of billions of transactions a day to figure out what will convert people. And obviously conversion means more revenue for you.

And look, I'm not a big company like Meta or anything, but I've been using Stripe since long before they were advertisers. Stripe Atlas was just the easiest way for me to set up an LLC and they have these payments and invoicing features that make it super convenient for me to get money from advertisers.

And obviously, without that, it would have been much harder for me to earn money from the podcast. And so it's been great for me. Go to Stripe.com to learn more. Thanks to them for sponsoring the episode.

Learning from the Classics

Dwarkesh: I'm actually curious about something else, which is - so a 19-year-old Mark reads a bunch of antiquity and classics in high school and college. What important lesson did you learn from it? Not just interesting things you found, but like - there aren't that many tokens you consume by the time you're 19. A bunch of them were about the classics. Clearly that was important in some way.

Mark: I don't know, that's a good question. I mean, one of the things I thought was really fascinating is when Augustus first became emperor and he was trying to establish peace - there was no real conception of peace at the time.

People's understanding of peace was it is the temporary time between when your enemies will inevitably attack you again. So you get like a short rest.

And he had this view which is like - look, we want to change the economy from instead of being so mercenary and militaristic to actually this positive something. It's like a very novel idea at the time.

I don't know, I think there's something that's just really fundamental about that. It's in terms of the bounds on what people can conceive at the time of what are rational ways to work.

And I'm going back to - I mean, this applies to both the metaverse and the AI stuff - but like a lot of investors and just different people just can't wrap their head around why we would open source this.

And it's like - are you like - I don't understand. It's like open source, that must just be the temporary time between which you're making things proprietary, right?

But I actually think it's this very profound thing in tech

---

that has actually created a lot of winners. And so I don't know, I don't want to strain the analogy too much. But I do think that there's a lot of times ways where you can - that are just models for building things that people can't even wrap their head around how that would be a valuable thing for people to go do or a reasonable state of the world.

I mean, I think there's more reasonable things than people think.

Dwarkesh: That's super fascinating. Can I give you my answer of what I was thinking you might have gotten from it?

Mark: Sure. You might have gotten from it. This is probably totally off, but just how young some of these people are who have very important roles in the empire. Like Caesar Augustus, by the time he's 19, he's actually incredibly one of the most prominent people in Roman politics. And he's leading battles and forming the second triumvirate.

I wonder if you're like - 19-year-olds can actually do this. Because I think that's an interesting example both from a lot of history and American history.

Mark: Yeah, I mean, one of my favorite quotes is this Picasso quote that "all children are artists and the challenge is how do you remain an artist when you grow up".

And it's like, basically, I think, because when you're younger, I think it's just easier to have kind of wild ideas. And you're not - you have no - there are all these analogies to the innovator's dilemma that exist in your life, as well as your company or whatever you've built.

So, you know, you're kind of earlier on your trajectory, it's easier to pivot and take in new ideas without disrupting other commitments that you've made to different things.

And so I don't know. I think that's an interesting part of running a company is like, how do you kind of stay dynamic?

Open Sourcing Future Models

Dwarkesh: Let's say you have the 10 billion dollar model - suppose it's totally safe, you've done these evaluations, and unlike in this case, the evaluators can also fine-tune the model, which hopefully will be the case in future models. Would you open source that, the 10 billion dollar model?

Mark: Well, I mean, as long as it's helping us, then yeah.

Dwarkesh: But would it? Like the 10 billion dollars of R&D and then now it's like open source?

Mark: Here's, I think, a question which we'll have to evaluate as time goes on too. But we have a long history of open sourcing software. We don't tend to open source our product. So it's not like we take the code for Instagram and make it open source. But we take a lot of the low-level infrastructure and we make that open source.

Probably the biggest one in our history was Open Compute Project, where we took the designs for all of our servers and network switches and data centers and made it open source. And it ended up being super helpful.

Because a lot of people can design servers, but now the industry standardized on our design, which meant that the supply chains basically all got built out around our design, the volumes went up, so it got cheaper for everyone and saved us billions of dollars. So awesome, right?

Okay, so there's multiple ways where open source I think could be helpful for us. One is if people figure out how to run the models more cheaply, well, we're going to be spending tens or 100 billion dollars or more over time on all this stuff. So if we can do that 10% more effectively, we're saving billions or tens of billions of dollars.

Okay, that's probably worth a lot by itself. Especially if there's other competitive models out there. It's not like our thing is giving away some kind of crazy advantage.

Dwarkesh: So is your view that the training will be commodified?

Mark: I think there's a bunch of ways that this could play out. That's one. The other is that - so commodity kind of implies that it's going to get very cheap because there's lots of options. The other direction that this could go in is qualitative improvements.

So you mentioned fine-tuning, right? It's like right now it's pretty limited what you can do with fine-tuning major other models out there. And there are some options, but generally not for the biggest models.

So I think being able to do that and be able to kind of do different app specific things or use case specific things or build them into specific tool chains, I think will not only enable kind of more efficient development, it could enable qualitatively different things.

Here's one analogy on this. So one thing that I think generally sucks about the mobile ecosystem is that you have these two gatekeeper companies, Apple and Google, that can tell you what you're allowed to build.

And there are lots of times in our history - so there's the economic version of that which is like, all right, we build something, they're just like I'm going to take a bunch of your money.

But then there's the qualitative version which is actually what kind of upsets me more, which is there's a bunch of times when we've launched or wanted to launch features. And then Apple's just like, nope, you're not launching that. It's like, that sucks.

Dwarkesh: Are we kind of set up for a world like that with AI where you're going to get a handful of companies that run these closed models that are going to be in control of the APIs and therefore going to be able to tell you what you can build?

Mark: Well, for one, I can say for us it is worth it to go build a model ourselves to make sure that we're not in that position. Like I don't want any of those other companies telling us what we can build.

But from an open source perspective, I think a lot of developers don't want those companies telling them what they can build either. So the question is, what is the ecosystem that gets built out around that? What are interesting new things? How much does that improve our products?

I know there's a lot of cases where if this ends up being like our databases or caching systems or architecture, we'll get valuable contributions from the community that will make our stuff better.

And then our app specific work that we do will still be so differentiated that it won't really matter. It's like, well, we'll be able to do what we do. We'll benefit in all the systems. Ours and the communities will be better because it's open source.

There is one world where maybe it's not that. I mean, maybe the model just ends up being more of the product itself. In that case, then I think it's a trickier economic calculation about whether you open source that because then you are kind of commoditizing yourself a lot.

But from what I can see so far, it doesn't seem like we're in that zone.

Dwarkesh: Do you expect to earn significant revenue from licensing your model to the cloud providers so they have to pay you a fee to actually serve the model?

Mark: We want to have an arrangement like that, but I don't know how significant it'll be. And we have this, this is basically our license for Llama.

You know, in a lot of ways, it's like a very permissive open source license, except that we have a limit for the largest companies using it. And this is why we put that limit in, is we're not trying to prevent them from using it. We just want them to come talk to us because if they're going to just basically take what we built and resell it and make money off of it -

Okay, well if you're like Microsoft Azure or Amazon, then yeah, if you're going to be reselling the model then we should have some revenue share on that. So just come talk to us before you go do that.

And that's how it's played out. So for Llama 2, we basically just have deals with all these major cloud companies and Llama 2 is available as a hosted service on all those clouds.

And I assume that as we release bigger and bigger models, that'll become a bigger thing. It's not the main thing that we're doing, but I just think if others are, if those companies are going to be selling our models, it makes sense that we should share the upside of that somehow.

Dwarkesh: With regards to the other open source dangers, I think I have genuine legitimate points about the balance of power stuff and potentially the harms you can get rid of because we have better alignment techniques or something.

I wish there was some sort of framework that Meta had. Other labs have this where they say, if we see this concrete thing, then that's a no-go on the open source or even potentially on deployment. The company is ready for it, people have expectations around it and so forth.

Mark: Yeah, no, I think that's a fair point. On the existential risk side, right now we focus more on the types of risks that we see today which are more of these content risks.

So you know, we have lines on - we don't want the model to be basically doing things that are helping people commit violence or fraud or just harming people in different ways.

So in practice for today's models, and I would guess the next generation and maybe even the generation after that, while it is somewhat more maybe intellectually interesting to talk about the existential risks, I actually think the real harms that need more energy being mitigated are things that are going to have someone take a model and do something to hurt a person with today's parameters and the types of more mundane harms that we see today, like people kind of committing fraud against each other, things like that.

So that I just don't want to shortchange. I think we have a responsibility to make sure we do a good job on that.

Dwarkesh: Meta's a big company. You can handle both.

Mark: Yeah.

Impact of Open Source

Dwarkesh: As far as the open source goes, I'm actually curious if you think the impact of the open source from PyTorch, React, Open Compute, these things has been bigger for the world than even the social media aspects of Meta. Because I've talked to people who use these services who think it's plausible. Because a big part of the internet runs on these things.

Mark: It's an interesting question. I mean, I think almost half the world uses our... Yeah, that's a trick. So I think it's hard to beat that.

But no, I think open source, it's really powerful as a new way of building things. And yeah, I mean it's possible. It may be one of these things where, I don't know, like Bell Labs, right?

Where they, you know, it's like they were working on the transistor because they wanted to enable long distance calling. And they did. And it ended up being really profitable for them that they were able to enable long distance calling.

And if you ask them five to ten years out from that, what was the most useful thing that they invented - it's like, okay, well we enabled long distance calling and now all these people are long distance calling.

But if you ask a hundred years later, maybe it's a different question.

So I think that's true of a lot of the things that we're building - Reality Labs, some of the AI stuff, some of the open source stuff. I think it's like the specific products evolve and to some degree come and go. But I think the advances for humanity persist. And that's like a cool part of what we all get to do.

Future Hardware for Models

Dwarkesh: By when will the Llama models be trained on your own custom silicon?

Mark: Soon. Not Llama 4. The approach that we took is first we basically built custom silicon that could handle inference for our ranking and recommendation type stuff. So Reels, news feed, ads, that was consuming a lot of GPUs.

But when we were able to move that to our own silicon, we now were able to use the more expensive NVIDIA GPUs only for training.

So at some point, we will hopefully have silicon ourselves that we can be using for probably first training some of the simpler things that eventually training these really large models.

But in the meantime, I'd say the program is going quite well and we're just rolling it out methodically and have a long-term roadmap for it.

Hypothetical - Google+

Dwarkesh: Final question. This is totally out of left field, but if you were made CEO of Google+, could you have made it work?

Mark: Google+, oof. Well, I don't know. I don't know. That's a very difficult counterfactual.

Okay, then the real final question will be, when Gemini was launched, was there any chance that somebody in the office uttered "Karthika Delinda Est"?

Mark: No, I think we're tamer now.

Dwarkesh: Cool. Cool. Awesome. Mark...yeah, I don't know. It's a...it's a good question. I don't...I don't know.

The problem is there was no CEO of Google+. It was just like a division within a company. I think it's like - and you asked before about what are the kind of scarcest commodities, but you asked about it in terms of dollars.

And I actually think for most companies, it's, of this scale at least, it's focus. It's like when you're a startup, maybe you're more constrained on capital. You know, you just are working on one idea and you might not have all the resources.

I think you cross some threshold at some point where the nature of what you're doing - you're building multiple things and you're creating more value across them. But you become more constrained on what you can direct and what can go well.

And like there's always the cases where something just random awesome happens in the organization. I don't even know about it. And those are great.

But I think in general, the organization's capacity is largely limited by what the CEO and the management team are able to kind of oversee and manage.

I think that's just been a big focus for us. As I guess Ben Horowitz says, keep the main thing the main thing, and try to kind of stay focused on your key priorities.

Dwarkesh: All right, awesome. That was excellent Mark, thanks so much. That was a lot of fun.

Mark: Yeah, really fun. Thanks for having me.

Dwarkesh: Hey everybody, I hope you enjoyed that episode with Mark. As you can see, I'm now doing ads. So if you're interested in advertising on the podcast, go to the link in the description.

Otherwise, as you know, the most helpful thing you can do is just share the podcast with people who you think might enjoy it - your friends, group chats, Twitter, I guess threads.

Yeah, hope you enjoyed and I'll see you on the next one.

### 中文转录

Mark Zuckerberg：Hey，非常感谢邀请我来到这里。我是你播客的忠实粉丝。

Dwarkesh Patel：谢谢你，很高兴听到这句话。好的，让我们从谈论 Meta AI 的最新发布开始吧。当这个采访发布的时候，将会有哪些新的模型和内容？

Mark Zuckerberg：我想大多数人最为关注的就是 Meta AI 的新版本。我们正在推出 Llama 3，对开发者社区开放源代码，并用它驱动 Meta AI。Llama 3 是一个很大的进步，我们认为它是目前人们可以免费使用的最智能的 AI 助手。

我们还整合了谷歌和必应以获取实时知识，并将其在我们的应用中更突出地展示。基本上在 WhatsApp、Instagram、Facebook 和 Messenger 的顶部，你都可以直接使用搜索框来提出任何问题。

我们还增加了一些很酷的创作功能，比如动画，你可以拍下任何图像并让它动起来。但我认为人们会觉得最神奇的是，它能如此快速地生成高质量图像。当你输入提示时，它会实时生成和更新图像。这非常神奇，我想人们会喜欢的。

我们最初在少数几个国家推出，未来几周和几个月内会覆盖更多。这对 Meta AI 来说是一大进步。如果深入技术细节，最有意思的当然是 Llama 3。

我们训练了三个版本 —— 80 亿、700 亿和 4050 亿参数的密集模型。今天我们发布 80 亿和 700 亿的版本，4050 亿的还在训练中。到目前为止，在训练中它已经达到了 85 MMLU，我们预计它将在很多基准测试中取得领先成绩。

700 亿版本也很棒，我们今天发布，它达到 82 MMLU，在数学和推理上得分领先。把这些模型交到人们手中会很疯狂。80 亿的版本几乎和我们发布的最大的 Llama 2 一样强大，所以最小的 Llama 3 基本上和最大的 Llama 2 一样强大。

Dwarkesh Patel：在进一步讨论这些模型之前，我想追溯一下时间。我想是在 2022 年你们开始采购这些 H100。当时你们的股价受到重创，人们质疑你们的资本支出。你们是否在为获得这些 H100 而支出资本？当时你们是如何知道要获得 H100，知道需要 GPU 的？

Mark Zuckerberg：我想是因为我们在开发 Reels。我们总是希望有足够的能力来构建一些我们还看不到的东西。我们在 Reels 中遇到了这种情况，需要更多 GPU 来训练模型。

这对我们的服务来说是一个巨大的进化。我们开始推荐人们不关注的内容，所以潜在的内容候选集从数千个扩大到数亿个。这需要完全不同的基础设施。

我们在开发时受到基础设施的限制，无法以我们想要的速度赶上 TikTok。所以我看了看，决定我们必须确保不再陷入这种情况。让我们订购足够的 GPU 来做 Reels 和 Feed 排序所需的工作。但我们还要再加一倍，因为总会有一些我们无法预见的东西。

Dwarkesh：你当时知道会是 AI 吗？

Mark：我们认为会是与训练大模型有关的事情。但当时我以为可能更多是与内容相关。但这几乎就是经营公司时的模式匹配 —— 总会有下一件事。当时我太沉浸于让 Reels 的推荐工作，因为这对 Instagram 和 Facebook 来说是一个巨大的突破，现在我们能向人们展示他们感兴趣的、来自他们甚至不关注的人的内容。

但回过头来看，获得这些 GPU 最终是一个很好的决定。这不是因为我有远见，而是因为我们之前搞砸了，不想重蹈覆辙。

Dwarkesh：我们稍微离题一下，但我很想问这个问题。你当时没有以 10 亿美元的价格出售 Facebook，但可能有一个你愿意出售的价格，对吗？你有没有在心里写下，你认为 Facebook 当时的实际估值是多少，而他们没有给出合适的估值？

如果价格达到 5 万亿美元，你当然会出售。那么你当时是如何考虑这个选择的？

Mark：我想有些事情是很个人化的。当时我可能还不够成熟，无法做出这样的分析。但我周围有很多人在争论，10 亿美元有多么多么多。他们列出我们需要的收入，需要做到多大规模，这显然还需要很多年的发展。而当时我们还差得很远。

我没有足够的金融知识来参与这种辩论。我只是在内心深处相信我们在做的事情。我做了一些分析，如果我不做这个，我会去做什么？我真的很喜欢创造东西，喜欢帮助人们沟通，喜欢了解人们之间发生的事情和动态。所以如果我卖掉这家公司，我可能会再创办一家类似的公司。而我还挺喜欢我现有的这家公司的。

所以为什么要卖呢？但我认为人们做出的很多重大赌注通常只是基于信念和价值观。事实上，很难做出面向未来的分析。

Dwarkesh：你们有 Facebook AI Research (FAIR) 已经有一段时间了。现在它似乎已经成为你们公司的核心。在什么时候，制造 AGI 或者你如何考虑这个任务，在什么时候成为 Meta 正在做的关键优先事项？

Mark：这件事情其实很重要已经有一段时间了。我们大约 10 年前就开始建立 FAIR。我们的想法是，在通往通用智能或全面 AI 的路上，无论你想叫它什么，都会有各种不同的创新。这将改善我们所做的一切。

我们没有把它当作一个产品，更多的是一个研究小组。在过去的 10 年里，它创造了很多不同的东西，基本上改进了我们所有的产品，推进了该领域的发展，也让该领域的其他人创造出改进我们产品的东西。我认为这很好。

但在过去几年里发生了巨大的变化，ChatGPT 问世，图像生成的扩散模型出现。这些东西相当疯狂，我认为它们显然将影响人们与各种应用程序的交互方式。

所以那时我们成立了第二个小组 Gen AI，目标是将这些东西带入我们的产品。我们要打造领先的基础模型，为所有这些不同的产品提供动力。最初我们开始这样做时，理论是我们做的很多事情都是社交性的。所以它帮助人们与创作者互动，帮助人们与企业互动，帮助企业销售产品或提供客户支持，以及为应用程序、智能眼镜或 VR 提供基本的助手功能。

最初，我们不完全清楚是否需要完全的 AGI 来支持这些用例。但通过实践，我认为我们发现你确实需要 AGI，因为有很多细微的方面。例如，在开发 Llama 2 时，我们没有优先考虑编程。因为我们认为人们不会在 WhatsApp 上问 Meta AI 很多编程问题。但事实并非如此。

我们发现，即使人们不是主要问编程问题，在编程方面训练模型也有助于它更严谨地回答问题，在许多不同领域进行推理。

推理是另一个例子。也许你想和一个创作者聊天，或者你是一家企业，想和客户互动。但这种互动不仅仅是对方给你发消息，你回复而已。这是一个多步骤的互动，你要思考如何实现对方的目标。

客户提出问题时，他们并不总是确切知道自己想要什么或如何提问。所以 AI 的工作不仅仅是回答问题本身。它需要更全面地思考。这实际上成为了一个推理问题。所以如果别人在推理方面取得进步，而我们只有一个基本的聊天机器人，那我们的产品相比之下就很糟糕。

所以归根结底，我们意识到我们必须解决通用智能的问题，我们加大了投资力度，以确保我们能够做到这一点。

Dwarkesh：那么，将要解决所有这些用户用例的 Llama 版本，是否足够强大，可以取代您这里的程序员？

Mark：我认为这一切都将随着时间的推移而逐步发展。但就目前的 Llama 版本而言，我认为这个问题包含了很多内容。我不确定我们是在取代人，还是在给人们提供工具来做更多的事情。

我不认为人类智力有一个单一的门槛，因为人们有不同的技能。在某个时候，我认为 AI 可能会在大多数事情上超过人类，这取决于模型的能力。但我认为这是渐进的。我不认为 AGI 是一个单一的东西。我认为它基本上是在增加不同的能力。

多模态是我们现在关注的一个关键能力，最初是照片、图像和文本，但最终会涉及视频。因为我们非常关注元宇宙，所以 3D 类型的东西很重要。

我关注的一个模态是情感理解，我还没有看到业内有太多其他人关注这一点。人类大脑有很大一部分是用来理解人的表情和情绪的。我认为这是它自己的一个完整的模态。你可以说，也许它只是视频或图像，但它显然是这两者的一个非常专门的版本。

所以有很多不同的能力，我认为你基本上是想训练模型关注这些能力，以及在推理、记忆等方面变得更好，我认为这本身就是一个完整的事情。

我不认为我们将主要把上下文或类似的东西塞进查询上下文窗口，以提出更复杂的问题。我认为会有不同的存储或不同的定制模型，可能更加个性化。

但我不知道。我认为这些都只是不同的能力。然后显然要让它们变大变小，我们两者都关心，因为如果你运行的是像 Meta AI 这样的东西，那么我们就有能力，它是基于服务器的，但我们也希望它能在智能眼镜上运行，而智能眼镜的空间并不大。所以你希望有一些东西是非常高效的。






14.19min

Dwarkesh：如果你要做数百亿美元的推理，或者最终甚至是万亿美元的推理，在工业规模上使用智能，那是什么用例？是模拟吗？是元宇宙中的 AI 吗？我们将把数据中心用于什么？

Mark：我的预测是，这基本上将改变所有的产品。我认为会有一种元 AI 通用助手产品。我认为它将从更像聊天机器人的东西转变为你越来越多地给它更复杂的任务，它就会离开并完成这些任务。所以这将需要大量的推理，在其他方面也需要大量的计算。

然后我认为我们要做的一大部分是与其他代理人互动。所以无论是企业还是创作者，我的一个重要理论是，不会只有一个你与之互动的奇点 AI，因为我认为每个企业都会想要一个代表他们利益的 AI。他们不会希望主要通过一个会销售竞争对手产品的 AI 与你互动。

所以我认为创作者将是一个重要领域。我们的平台上大约有 2 亿创作者。他们基本上都有这样的模式，他们想吸引社区，但受到时间的限制，而他们的社区通常想吸引他们，但他们没有时间。

所以如果你能创造出一种 AI，让创作者基本上拥有 AI，以他们想要的方式训练它，并能吸引社区，我认为这也将是非常强大的。所以我认为在所有这些事情上都会有大量的参与。

但这些只是消费者的用例。我认为当你想到像我和妻子一起运营的陈·扎克伯格倡议这样的基金会时，我们正在科学领域做很多事情，显然有很多 AI 工作，我认为这将推进科学、医疗保健和所有这些事情。

所以我知道这是一个很大的领域，我认为它最终会影响产品的几乎每个领域，以及经济。

Dwarkesh：你提到的一个 AI 可以为你做一些多步骤的事情，这是一个更大的模型吗？你会制作 Llama 4，会有一个仍然是 700 亿参数的版本，但你只需在正确的数据上训练它，它就会超级强大。发展的过程是什么样的？是扩展吗？

Mark：我不知道我们是否知道这个问题的答案。我认为一个看起来是一种模式的东西是，你有 Llama 模型，然后围绕它构建某种其他特定应用的代码。所以部分是针对用例的微调，但部分只是像元 AI 如何集成，应该如何使用 Google 或 Bing 等工具来引入实时知识的逻辑。我的意思是，这不是基础的 Llama 模型的一部分。

对于 Llama 2，我们有一些这样的东西，它更多的是手工设计的。然后我们的部分目标是将更多的这些东西引入 Llama 3 模型本身。但是对于 Llama 3，当我们开始进入更多这些类似代理的行为时，我认为其中一些将是更多的手工设计。然后我认为我们的目标是将更多这些引入 Llama 4 模型。

所以我认为在每一点上，就像在这个过程中的每一步，你都有一种对地平线上可能发生的事情的感觉。你开始摆弄它，围绕它进行 hacking。然后我认为这有助于你磨练你的直觉，知道你想尝试将什么训练到下一个版本的模型本身中去。

这使它更加通用，因为显然你手工编码的任何东西都是脆弱的和非通用的。当你说 "进入模型本身" 时，你训练它做你想让它在模型本身中做的事情。但 "模型本身" 是什么意思呢？

嗯，我想我在 Llama 2 中给出的例子是，工具的使用非常具体，而 Llama 3 有能力进行更好的工具使用。所以我们不必像手工编写所有这些东西来让它使用谷歌进行搜索。它只是可以做到。类似地，对于编码和运行代码以及类似的东西也是如此。

但我认为一旦你获得了这种能力，你就会看到接下来我们可以开始做什么。我不一定要等到 Llama 4 出来才开始构建这些功能，所以让我们开始围绕它进行 hacking 吧。

所以你做了大量的手工编码，这使得产品在过渡期间变得更好，但这也有助于展示我们想要尝试在下一个版本的模型中构建什么。

Dwarkesh：你最期待的 Llama 3 社区微调是什么？也许不是对你最有用的那个，而是你会最享受玩它的那个。比如把它微调到古代，你就会和维吉尔对话之类的，你对什么感到兴奋？

Mark：我不知道。我的意思是，我认为这类东西的本质是，你会感到惊喜。所以我认为任何我认为有价值的具体事情，我们可能都在构建。但我认为你会得到精炼的版本，你会得到更小的版本。

我认为 80 亿对于很多用例来说还不够小。我想随着时间的推移，我希望得到一个 10 亿参数的模型，或者一个 20 亿参数的模型，甚至可能是一个 5 亿参数的模型，看看你能用它做什么。因为，随着它们变得更小，如果 80 亿参数基本上和我们发布的最大的 Llama 2 模型一样强大，那么有了 10 亿参数，你应该能做一些有趣的事情，对吧？

更快，更适合分类，或者很多人在理解用户查询的意图之前所做的基本事情，然后将其输入最强大的模型，以改进提示应该是什么。所以我不知道，我认为这可能是社区可以帮助填补的一件事，但我的意思是，我们也在考虑自己去精炼一些这样的东西，但你知道，现在 GPU 正在训练 405。

Dwarkesh：所以你有所有这些 GPU，我想你说到今年年底有 35 万个？

Mark：那是整个机群。我的意思是，我们建造了两个，我想是 2.2 万到 2.4 万个集群，它们是我们用来训练大型模型的单个集群。显然，在我们所做的很多事情中，我们的很多东西都用于训练 Reels 模型，比如 Facebook 新闻源和 Instagram 信息流。

然后推理对我们来说是一件大事，因为我们为大量的人提供服务，对吧？所以我们所需的推理计算与训练的比率可能要高得多，高于大多数从事这类工作的其他公司，因为我们所服务的社区的数量巨大。

Dwarkesh：在你之前与我分享的资料中，有一点非常有趣，你训练它的数据量超过了最佳计算量，仅仅是为了训练，因为推理对你们来说是一个大问题，也是对社区来说，所以只是拥有这个东西并拥有数万亿的 tokens 是有意义的。

Mark：是的。虽然我们在 700 亿模型中看到的一个有趣的事情是，我们认为它会在我们训练它的大约 15 万亿 tokens 处变得更饱和。但即使在最后，它仍在学习。我们可能本可以给它更多的 tokens，它就会变得更好。

但我的意思是，在某种程度上，你知道，你在经营一家公司，你需要对这些元推理问题做出决定，比如我想把我们的 GPU 用在进一步训练这个 700 亿模型上，还是我们想继续下去，这样我们就可以开始为 Llama 4 测试假设。

所以我们需要做出这个决定，我认为我们达到了一个合理的平衡。未来还会有其他的 700 亿多模态模型在接下来的一段时间内出现。但是，我的意思是，这很吸引人，在这一点上，架构可以处理如此多的数据。

Dwarkesh：是的，这真的很有趣。那么这对未来的模型意味着什么呢？你提到 Llama-3 的 80 亿比 Llama-2 的 700 亿还要好，对吗？

Mark：不，不，不，它几乎一样好。

Dwarkesh：好的，我不夸大其词，但这是否意味着 Llama 4 的规模，Llama 4 的 700 亿会和 Llama 3 的 4000 亿或 5000 亿一样好？我的意思是，未来是什么？这是一个伟大的问题，我认为没有人知道答案。

基本上，当你有一条指数曲线时，它会持续多久是世界上最棘手的事情之一。我认为它很有可能会继续下去，值得投资数百亿甚至更多来建设基础设施，假设如果它继续下去，你将获得一些真正了不起的东西，它们将创造出令人惊叹的产品。但我认为业内没有人能真正告诉你它肯定会以这样的速度继续扩展。

一般来说，在历史上，你在某些时候会遇到瓶颈。现在这方面有如此多的能量，也许这些瓶颈会很快被打破，但我不知道，我认为这是一个有趣的问题，如果没有这些瓶颈，世界会是什么样子？

假设进展继续以这样的速度进行，这似乎是可能的，从长远来看，会有不同的瓶颈，对吧？如果不是训练，那就像，哦，是的，继续。

Mark：嗯，我想在某个时候，在过去几年里，我认为有一个问题是 GPU 的生产。即使是有钱购买 GPU 的公司，也不一定能得到他们想要的那么多，因为有所有这些供应限制。

现在我认为这种情况正在减少。所以现在，我认为你看到一群公司在想，哇，我们应该真的投入大量资金来建设这些东西。我认为这将持续一段时间。

我认为有一个资本问题，就是在什么时候把资本投入进去不再值得？但我实际上认为在我们达到这一点之前，你将遇到能源限制，对吧？因为我只是，我的意思是，我不知道，比如获得能源许可是一个受到严格管制的政府职能，对吧？

所以一方面，你从软件开始，软件受到一定程度的监管。我认为它受到的监管比我认为科技界的许多人感觉到的要多，虽然它显然是不同的。如果你正在创办一家小公司，也许你感觉不到，如果你是一家大公司，你知道我们只是与不同的政府和监管机构打交道，我们有很多规则需要遵循，并确保我们在世界各地做好工作。

但我认为毫无疑问，如果你谈论建造大型新电厂或大型建筑，然后建造跨越其他私人或公共土地的输电线，那就是一个受到严格管制的事情，所以你谈论的是多年的准备时间。

所以如果我们想建立一些像大型设施这样的东西来为此提供动力，我认为这是一个非常长期的项目。所以我不知道。我认为人们会这样做。但我不认为这是一件可以像变魔术一样的事情，就像，好的，你得到一定水平的人工智能，你得到一大笔资金，你把它投入进去，然后突然间模型就会...... 我认为你确实会在这个过程中遇到不同的瓶颈。

是的，即使是像 Meta 这样的公司也没有资源去做的项目，也许我有关系，也许没有，就像如果你的研发预算或资本支出预算是现在的 10 倍，那么你就可以去追求它，就像它在你的脑后，但今天的 Meta 可能会这样做，因为即使你不能发行股票或债券，它也比你的预算大 10 倍。

Mark：我认为能源是其中一部分。如果我们能获得能源，我认为我们可能会建造比我们目前能建造的更大的集群。所以我认为这在根本上是资金的瓶颈，就像如果你有一万亿美元的话。

Dwarkesh：我认为是时间。

Mark：嗯，如果你从指数曲线有多远来看，我认为有许多公司正在研究，现在我认为很多数据中心的规模是 50 兆瓦或 100 兆瓦，或者像一个大的可能是 150 兆瓦。好的。所以你拿一个整个数据中心，把它填满你需要做训练的所有东西，然后你建造你能建造的最大集群。我认为有一群公司正在做这样的事情。

但是当你开始建造一个 300 兆瓦、500 兆瓦或 1 吉瓦的数据中心时，我的意思是，还没有人建造过单个 1 吉瓦的数据中心。所以我认为它会发生，对吧？我的意思是，这只是时间问题，但它不会像明年，对吧？我认为这些事情中的一些将需要，我不知道，几年的时间来建设。

然后问题是，好吧，如果你，我的意思是，只是为了，我想，把这个放在角度来看，我认为一个千兆瓦，它的大小大约相当于一个有意义的核电站，只用于训练一个模型。

Dwarkesh：亚马逊没有这样做吗？就像，他们有 950 千兆瓦。

Mark：是的，我不确切知道你做了什么。你得问他们做了什么。你得问他们。但它不一定要在同一个地方，对吧？如果分布式训练有效，它可以是分布式的，我认为这是一个大问题，对吧？基本上是它将如何工作。

我确实认为，在未来，似乎很有可能，我们所说的对这些大模型的训练，实际上更多地沿着推理的方向，生成合成数据，然后再反馈给模型。所以我不知道这个比例会是多少，但我认为合成数据的生成今天更多的是推理而不是训练。但显然，如果你这样做是为了训练一个模型，它就是更广泛的训练过程的一部分。

所以我不知道，这是一个悬而未决的问题，就是在这方面的平衡以及它是如何发挥作用的。如果是这样的话，这是否也可能是 Llama 3 的情况？也许从 Llama 4 开始，你把这个放出来，如果有人有大量的计算能力，那么使用你放出的模型，你可以不断地让这些东西变得更聪明。

就像科威特或阿联酋或一些随机的国家有大量的计算能力，他们实际上可以只使用 Llama 来制造更智能的东西。我确实认为会有这样的动态，但我也认为在网络架构或模型架构方面有一个根本的限制。所以我认为我们用 Llama 3 架构训练的 700 亿模型可以变得更好，它可以继续下去。

就像我说的，我们觉得如果我们继续给它更多的数据或再次轮换高价值的 tokens，它就会继续变得更好。我们已经看到世界各地的许多其他人，不同的公司基本上采用 Llama 2 的 700 亿基础，采用该模型架构，然后构建一个新模型。

当你对 Llama 3 的 700 亿或 Llama 3 的 4050 亿进行代差改进时，仍然没有任何类似的开源模型。我认为这是一个巨大的阶跃函数，人们将能够在此基础上构建的东西，我不认为可以从那里无限地走下去。我认为在你进入下一个阶跃函数之前，可能会有一些优化。

Dwarkesh：好的，让我们从具体的模型甚至是你需要获得能源批准的多年准备时间等稍微放大一点。就大局而言，未来几十年，人工智能会发生什么？感觉像是元宇宙或社交这样的另一项技术，还是感觉在人类历史进程中是一个根本不同的东西？

Mark：我认为它将是非常根本性的。我认为它更像是计算机本身的创造。所以你会得到所有这些新的应用程序，就像当你得到网络或手机时，人们基本上重新思考了所有这些体验，很多以前不可能的事情现在变成了可能。

所以我认为这种情况会发生，但我认为这是一个低得多的创新水平。它将更像是从人们没有电脑到人们有电脑。但这也是，我不知道，很难推理出它到底是如何发生的。

我倾向于认为，在宇宙尺度上，它显然会在几十年内迅速发生。但我确实认为，有一些人担心它真的会旋转，并在一夜之间从某种智能变成极其智能。我只是认为有所有这些物理限制，使得这不太可能发生。我只是不认为这会发生。

所以我认为我们将有时间来适应一点，但它确实会真正改变我们的工作方式，并给人们所有这些创造性的工具来做不同的事情。我认为它将真正使人们能够做更多他们想做的事情。

所以也许不会在一夜之间，但你的观点是，在宇宙尺度上，如果你认为人类进化了，然后人工智能出现了，然后他们穿越银河系，或者可能需要几十年，可能需要一个世纪，但这就像是现在正在发生的历史大计划吗？

Mark：我认为这很棘手。我认为人们喜欢，你知道，人类的历史一直是人们基本上认为人性的某些方面在不同方面真的很独特。然后接受这样一个事实，即事实并非如此，但人性实际上仍然非常特别。

所以就像我们认为地球是宇宙的中心一样。事实并非如此，但人类仍然非常棒，非常独特。我认为人们倾向于有的另一个偏见是，认为智力在某种程度上与生命有根本的联系。但实际上并不清楚是否如此。

我的意思是，我不知道我们是否有足够清晰的意识或生命定义来充分审视这一点，但我知道所有的科幻小说都是关于创造智能，现在它开始采取所有这些类似人类的行为和事物。

但我实际上认为，所有这些东西的当前化身，至少感觉它正朝着一个方向发展，在这个方向上，智能可以与意识和能动性等事物完全分离，我认为这只是使它成为一个超级有价值的工具。

所以我不知道。我的意思是，显然，预测这些东西随时间的发展方向非常困难，这就是为什么我认为任何人都不应该对他们计划如何开发它或计划做什么教条。我认为你想看看每一个版本，你知道，我们显然非常支持开源，但我还没有承诺我们会像发布我们所做的每一件事一样，但基本上我非常倾向于认为开源它对社区和我们都有好处，因为我们会从创新中受益。

但是如果在某个时候，这个东西的能力发生了一些质的变化，我们觉得开源它是不负责任的，那么我们就不会这样做。所以我不知道，这一切都很难预测。

Dwarkesh：那么在部署这些系统时，你能看到什么吗？你在训练一个 Llama 4，它对你撒谎，因为它认为你没有注意到什么。你会想，哇，这是怎么回事？Llama 4 型系统可能不太可能出现这种情况，但你能想象出这样的事情吗？如果数十亿的副本在野外，你会非常担心欺骗性吗？

Mark：是的，我的意思是，我认为这不一定，我的意思是，现在它是，我们看到很多幻觉，对吧？所以我认为更多的是，我认为这是一个有趣的问题，你如何区分幻觉和欺骗，但是，我的意思是，我认为有很多风险和需要考虑的事情。

另一方面，在经营我们的公司时，我也试图至少平衡我认为的这些长期的理论风险与我实际认为现在存在的相当真实的风险。所以就像你谈到欺骗一样，我最担心的形式是人们利用这一点来制造错误信息，然后通过我们的网络或其他网络传播。

所以我们基本上通过建立比对抗性系统更智能的人工智能系统来打击这类有害内容。我想这是其中的一部分，这有点影响了我对此的部分理论，对吧？如果你看一下人们通过社交网络做的或试图做的不同类型的伤害，有一些不是很对抗性的。

例如，我会说仇恨言论在某种意义上并不是超级对抗性的，因为人们并没有在种族主义方面变得更好，对吧？他们只是，如果你有点，我认为人工智能通常只是变得比人们在这些问题上更复杂，更快。

所以我们有双向的问题。就像人们做坏事一样，无论他们是想煽动暴力还是什么。但我们也有很多误报，对吧？所以我们基本上审查了我们不应该审查的东西，我认为这可以理解地让很多人感到恼火。

所以我认为随着时间的推移，拥有一个在这方面越来越精确的人工智能将是好事。但让我给你另一个例子，那就是国家试图干预选举。这是一个例子，他们绝对拥有尖端技术，并且每年都在变得更好。所以我们阻止了一些技术，他们了解我们做了什么，他们用不同的技术来对付我们，对吧？这不像一个人试图，你知道，说刻薄的话，对吧？

基本上，他们有一个目标，他们很老练，他们有很多技术。在这些情况下，我仍然认为我们的人工智能系统以比他们更快的速度增长和复杂化的能力，这是一场军备竞赛，但我认为我们至少目前正在赢得这场军备竞赛。

所以我不知道。我认为这就是我花时间思考的很多事情，就像，好的，是的，Llama 4 或 Llama 5 或 Llama 6 是有可能的，是的，我们需要思考我们观察到的行为。这不仅仅是我们。我认为我们之所以开源，部分原因是有很多其他人也在研究这个。所以是的，我们想看看其他人在观察什么，我们在观察什么，我们可以缓解什么，然后我们将评估我们是否可以开源它。

但我认为在可预见的未来，我乐观地认为我们将能够做到。在短期内，我不想忽视人们今天试图用模型做的实际坏事，即使它们不是存在性的，但它们是我们在运行服务时熟悉的相当糟糕的日常危害。这实际上是我认为我们必须花很多时间去做的事情。

Dwarkesh：实际上我发现合成数据的事情真的很好奇。我很感兴趣，为什么你认为像当前的模型这样，一遍又一遍地做合成数据是有意义的，如果它们变得更聪明，你使用你在论文或博客文章中谈到的那种技术，在本期节目发布的那天，它会进入最正确的思路，为什么这不会导致一个循环，当然，它不会在一夜之间发生，但在几个月或几年的训练中，可能会有一个更聪明的模型，它变得更聪明，产生更好的输出，变得更聪明，等等。

Mark：嗯，我认为它可以在任何模型架构的参数范围内，只是在某种程度上，我不知道，我认为就像今天的 80 亿参数模型，我只是不认为你将能够达到与最先进的数百亿参数模型一样好，这些模型将新的研究融入架构本身，但这些也将是开源的，对吧？

是的，但我认为如果我的意思是，取决于我们刚才讨论的所有问题，是的，我的意思是，我们希望情况会是这样，但我认为在每个时刻，我不知道，就像当你在构建软件时，有很多你可以用软件做的事情，但在某种程度上，你受到它运行的芯片的限制，对吧？

所以总是会有不同的物理限制，就像模型有多大将受到你能获得多少能量以及用于推理的限制。所以我想我对这些东西能够继续快速改进非常乐观，同时也比我认为的一些人更加克制，因为我只是不认为失控的情况特别可能发生。

我认为保持开放的选择是有意义的，因为有太多我们不知道的事情。有一种情况是，保持权力平衡非常重要，这样就没有人会成为极权独裁者。有一种情况是，你不想开源架构，因为中国可以利用它来赶上美国的人工智能，就像存在智能爆炸一样，他们就像赢了一样。

是的，很多事情都是不可能的，就像保持你的选择开放，考虑所有的事情，似乎是合理的。让我们谈谈其他一些事情。好的。元宇宙，你最感兴趣去的人类历史时期是什么？公元前 10 万年到现在，你只想看看过去是什么样子的，对吧？

它必须是过去。哦，是的，它必须是过去。我不知道。我的意思是，我对某些时期感兴趣。我的意思是，我对美国历史和古典历史非常感兴趣。我对科学史也很感兴趣。所以我实际上认为看到并试图了解更多一些重大进展是如何发生的。我的意思是，我们所拥有的只是一些关于这些东西的相当有限的著作。

我不确定元宇宙是否会让你这样做，因为我的意思是，你知道，我们不能，对于我们没有记录的事情，很难回到过去，但我实际上不确定回到过去对他们来说是否如此重要。我的意思是，我认为它对历史课之类的东西会很酷，但这可能不是我对元宇宙整体最感兴趣的用例。

我的意思是，我认为主要的事情只是无论你在哪里都能感受到与人在一起的能力，我认为这将是令人兴奋的。我的意思是，在我们正在进行的人工智能对话中，有如此多的内容是关于所有这些潜在的物理限制，对吧？

我认为技术的一个教训是，你想尽可能地将事物从物理限制领域转移到软件中，因为软件要容易得多构建和发展。你可以使它更加民主化，因为不是每个人都会有一个数据中心，但很多人可以编写代码，获取开源代码并对其进行修改。

元宇宙版本是，我认为实现逼真的数字存在将是一个绝对巨大的差异，它将使人们感觉他们不必为许多事情而在物理上在一起。我的意思是，我认为有一些事情在物理上在一起会更好，所以这不是，我的意思是这些事情不是二元的，它不会像现在你不需要这样做了，但总的来说，我认为它将非常有力地用于社交、与人建立联系、工作，我不知道，工业的某些部分，医学，以及许多其他事情。

我想回到你在谈话开始时说的一些事情，你没有以 10 亿美元的价格出售公司。就像元宇宙一样，即使市场对此进行了抨击，你也知道我们会这样做。然后我很好奇，这种优势的来源是什么？你说过，哦，价值观。我有这种直觉。但每个人都这么说，对吧？比如如果你不得不说一些对你来说特别的事情，那是什么？你会如何表达这一点？就像，你为什么如此确信元宇宙？

Mark：嗯，我认为这些是不同的问题。那么，我的意思是，是什么驱动我的？我想我们已经谈过很多主题了。所以我的意思是，我只是真的很喜欢创造东西。我特别喜欢围绕人们如何交流以及理解人们如何表达自己和工作来创造事物。

我说过，当我上大学时，我学的是计算机科学和心理学。我认为业内的很多其他人学的是计算机科学。所以这对我来说一直是这两件事的交叉点。但我认为这也是一种非常深层次的驱动力。我不知道如何解释它。但我只是觉得在宪法上，如果我不在创造新的东西，我就是在做错事。

所以我认为即使在我们为人工智能投资 1000 亿美元或在元宇宙投资巨额资金时，我们也有计划，我认为很明显，如果我们的东西有效，那将是一项好的投资。但你不可能从一开始就确定。有所有这些论点，你知道，无论是与顾问还是不同的人，就像，你怎么能，这是你有足够的信心去做这件事？

而且就像，好吧，如果我停止尝试创造新事物的那一天，我就完了，我要去其他地方创造新事物，对吧？就像我根本无法运营一些东西或在我自己的生活中，而不是试图创造我认为有趣的新事物，就像这对我来说根本不是一个问题。就像我们是否要去尝试建造下一个东西。就像，我无法不这样做。

我在生活的各个方面都是这样的，对吧？就像，我们在夏威夷建造了这个牧场，我就像设计所有这些建筑一样，我有点想开始养牛，我就像，好吧，我想养世界上最好的牛，所以就像我们如何设计这个，以便我们能够搞清楚并建立我们需要尝试做的所有东西。所以我不知道那就是我。

Dwarkesh：我不确定，但我实际上对其他事情很好奇，那就是 19 岁的马克读了很多古代和经典著作，高中大学，你从中学到了什么重要的教训，不仅仅是你发现的有趣的事情，而是在你 19 岁之前，没有那么多令牌可以消费，其中很多是关于经典的，显然这在某种程度上很重要，你可以消费的令牌。

Mark：我不知道这是一个好问题。我的意思是，我认为非常有趣的一件事是，所以当奥古斯都第一次成为皇帝时，他试图建立和平，而当时没有真正的和平概念，人们对和平的理解是，这是你的敌人不可避免地再次攻击你之前的临时时间，所以你得到一个短暂的休息，而他有这样一个观点，那就是，看，我们想把经济从如此雇佣兵和军国主义转变为实际上是积极的东西，这在当时是一个非常新颖的想法。

我不知道，我认为这有一些非常根本性的东西。就像在当时人们能够构想的合理工作方式的界限方面。我回到了元宇宙和人工智能的东西，但就像很多投资者和不同的人一样，他们无法理解我们为什么要开源这个。就像你，就像我不明白，就像开源，那一定就像你让事情变得专有之前的临时时间，对吧？

但我实际上认为这是科技中一个非常深刻的事情，它实际上创造了很多赢家，对吧？所以我不知道，我不想过度解读这个类比，但我确实认为有很多时候，有一些方式，人们甚至无法理解这对人们来说会是一件有价值的事情，或者像一个合理的世界状态，我的意思是，我认为有比人们想象的更合理的事情。

Dwarkesh：这非常有趣。我可以告诉你我当时的想法吗？你可能从中得到了启发。这可能完全偏离了，但只是这些在帝国中担任非常重要角色的人有多年轻。就像凯撒奥古斯都一样，当他 19 岁时，他实际上是罗马政治中最突出的人物之一。他领导战斗，形成了第二次首要成员。我想知道你是否认为 19 岁的人真的能做到这一点，因为我认为这是一个有趣的例子，无论是从很多历史还是美国历史来看。

Mark：是的，我的意思是，我最喜欢的一句话是毕加索的一句话，所有的孩子都是艺术家，挑战是当你长大后如何保持艺术家的身份，基本上，我认为，因为当你年轻时，我认为更容易有疯狂的想法。你知道，你没有，在你的生活中有所有这些创新者的困境的类比，以及你建立的任何公司或任何东西，对吧？

所以你知道，你在轨道上更早，更容易转向并接受新的想法，而不会破坏你对不同事物做出的其他承诺。所以我不知道。我认为这是经营一家公司的一个有趣的部分，就像你如何保持动态？

Dwarkesh：如果 Meta 开源了 100 亿美元的模型，假设它完全安全，你已经做了这些评估，不像在这种情况下，评估者也可以微调模型，希望在未来的模型中会是这样，你会开源吗？100 亿美元的模型？

Mark：嗯，我的意思是，只要它对我们有帮助，那就可以。但它会吗？比如 100 亿美元的研发，然后现在它就像开源一样？这是一个我们将不得不随着时间的推移来评估的问题，但我们有开源软件的悠久历史，对吧？我们不倾向于开源我们的产品，所以我们不会把 Instagram 的代码开源，但我们会把很多底层基础设施开源。

我们历史上最大的一次可能是 Open Compute Project，我们把我们所有服务器、网络交换机和数据中心的设计开源了，最终非常有帮助。因为很多人都可以设计服务器，但现在整个行业都标准化了我们的设计，这意味着供应链基本上都是围绕我们的设计建立的，数量增加了，所以每个人都变得更便宜，为我们节省了数十亿美元。所以很棒，对吧？

好的，所以开源可能对我们有帮助的方式有很多。一个是如果人们找到了更便宜地运行模型的方法，那么随着时间的推移，我们将在所有这些东西上花费数百亿甚至更多。所以如果我们能更有效地做到这一点，我们就能节省数十亿甚至数百亿美元。好的，这本身可能就值得很多。特别是如果还有其他的竞争模型。这并不像我们的东西一样，放弃某种疯狂的优势。

Dwarkesh：那么你的观点是交易将被商品化吗？

Mark：我认为有很多方式可以实现这一点，这是其中之一。另一个方向是定性的改进。所以你提到了微调，对吧？就像现在你可以用其他主要模型做的微调非常有限。有一些选择，但通常不适用于最大的模型。

所以我认为能够做到这一点，能够做不同的特定应用程序的事情，或特定用例的事情，或者将它们构建到特定的工具链中，我认为不仅会实现更有效的开发，它还可以实现质的不同的事情。这里有一个类比。

所以我认为移动生态系统普遍糟糕的一件事是，你有这两家把关公司苹果和谷歌，他们可以告诉你允许构建什么，在我们的历史上有很多次，所以有一个经济版本，就是好的，我们构建了一些东西，他们就像我要拿走你很多钱，但是还有一个定性版本，这实际上是让我更沮丧的，那就是有很多次我们推出或想推出功能。

然后苹果就像，不，你不能推出那个。就像，那很糟糕。对于人工智能，我们是否也会设置这样一个世界，在那里你将获得少数几家运行这些封闭模型的公司，他们将控制 API，因此能够告诉你可以构建什么？

嗯，首先我可以说，对我们来说，值得去构建一个模型，以确保我们不会处于那个位置，就像我不想让任何其他公司告诉我们可以构建什么。但从开源的角度来看，我认为很多开发人员也不希望那些公司告诉他们可以构建什么。所以问题是，围绕这一点建立的生态系统是什么？有什么有趣的新事物？这在多大程度上改善了我们的产品？

我知道有很多情况下，如果这最终像我们的数据库或缓存系统或架构，我们将从社区获得有价值的贡献，这将使我们的东西变得更好。然后我们所做的特定应用程序的工作仍然会如此不同，以至于它不会真的重要。对吧？就像，我们将能够做我们做的事情。我们将在所有系统中受益。我们和社区的系统会因为它是开源的而变得更好。

还有一个世界，也许不是这样的。我的意思是，也许模型最终更像是产品本身。在那种情况下，我认为这是一个更棘手的经济计算，关于你是否开源，因为那样你就有点大规模地商品化自己了。但从我目前看到的情况来看，似乎我们还没有进入那个区域。

Dwarkesh：你希望从向云提供商许可模型中获得可观的收入，这样他们就必须向你支付费用才能实际提供模型吗？

Mark：我们希望有这样的安排，但我不知道它会有多大意义。我们有这个，这基本上是我们的 Lama 许可。你知道，在很多方面，它就像一个非常宽松的开源许可，除了我们对使用它的大公司有限制。这就是我们设置这个限制的原因，我们不是想阻止他们使用它。我们只是希望他们来和我们谈谈，因为如果他们打算基本上拿走我们构建的东西，转售它并从中赚钱，就像好吧，如果你像微软 Azure 或亚马逊，那么如果你打算转售模型，我们应该分享一些收入，所以在你这样做之前，请过来和我们谈谈，这就是它的运作方式。

所以对于 Llama 2，我的意思是，我们基本上只是与所有这些主要云公司达成协议，Llama 2 作为托管服务在所有这些云上都可用。我想，随着我们发布越来越大的模型，这将成为一件更大的事情。这不是我们正在做的主要事情，但我只是认为，如果其他人，如果这些公司要销售我们的模型，我们应该以某种方式分享上行空间。

Dwarkesh：关于其他开源的危险，我认为我有一些真正合理的观点，关于权力平衡的问题，以及我们可以通过更好的对齐技术或其他方式消除的潜在危害。我希望 Meta 有某种框架。其他实验室有这样的框架，他们说，如果我们看到这个具体的事情，那就是不能开源甚至可能不能部署的禁令。就像公司已经为此做好了准备，人们对此有所期待等等。

Mark：我认为你在存在性风险方面提出了一个很好的观点，现在我们更关注我们今天看到的风险类型，更多的是这些内容风险，所以你知道我们有一些底线，我们不希望模型基本上做一些帮助人们实施暴力或欺诈或者以不同方式伤害人们的事情。

所以在实践中，对于今天的模型，我猜测下一代模型，甚至下下一代模型，虽然从智力上讲，谈论存在性风险可能更有趣，但我实际上认为需要更多精力去缓解的真正危害是，有人会拿着一个模型，用今天的参数做一些伤害他人的事情，以及我们今天看到的更多平凡的危害，比如人们互相欺诈之类的事情。

所以我只是不想低估这一点。我认为我们有责任确保我们在这方面做得很好。Meta 是一家大公司。你可以同时处理这两个问题。

Dwarkesh：是的。好的。就开源而言，我实际上很好奇你是否认为 PyTorch、React、Open Compute 这些东西的开源影响甚至比 meta 的社交媒体方面更大。因为我与使用这些服务的人交谈，他们认为这是可能的。因为互联网的很大一部分都在这些东西上运行。这是一个有趣的问题。

我的意思是，我认为几乎有一半的世界在使用我们的东西...... 是的，这是一个诡计。所以我认为很难超越这一点，但不，我认为开源作为一种构建事物的新方式真的很强大，是的，我的意思是，这是可能的，我的意思是，你知道，它可能是这些事情之一，我不知道，就像贝尔实验室，对吧？

他们，你知道，就像他们正在研究晶体管，因为他们想实现长途通话。他们做到了。事实证明，他们能够实现长途通话对他们来说真的很有利可图。如果你在那之后的五到十年问他们，他们发明的最有用的东西是什么，就像，好吧，我们实现了长途通话，现在所有这些人都在进行长途通话，但如果你一百年后问，也许这是一个不同的问题。

所以我认为这对我们正在构建的很多东西都是如此，现实实验室，一些人工智能的东西，一些开源的东西，我认为就像具体的产品演变，在某种程度上来来去去，但我认为人类的进步仍在，这就像我不知道我们所有人都可以做的很酷的事情，到什么时候 Llama 模型将在你自己的定制芯片上训练？

Mark：很快，不是 Llama 4。我们采取的方法是，首先我们基本上构建了定制芯片，可以处理 Reels、新闻源广告等排名和推荐类型的东西的推理，这消耗了大量的 GPU。但当我们能够将其移至我们自己的硅芯片时，我们现在能够仅将更昂贵的 NVIDIA GPU 用于训练。

所以在某个时候，我们希望自己拥有硅芯片，我们可以用它来训练一些更简单的东西，最终训练这些非常大的模型，但与此同时，我想说该计划进展得很好，我们只是有条不紊地推出它，并有一个长期的路线图。

Dwarkesh：最后一个问题，这完全是跑题的，但如果你被任命为 Google + 的 CEO，你能让它成功吗？

Mark:Google+，哇。嗯，我不知道。我不知道。这是一个非常难以预测的反事实。

Dwarkesh：好的，那么真正的最后一个问题是，当 Gemini 发布时，办公室里有没有人说过 "Karthika Delinda Est"?

Mark：不，我想我们现在更温和了。

Dwarkesh：酷。酷。太棒了。Mark。嗯，是的，我不知道。这是一个很好的问题。我不，我不知道。问题是 Google + 没有 CEO。它只是一家公司内的一个部门。我想它就像，你之前问过什么是最稀缺的商品，但你是根据美元来问的。我实际上认为对大多数公司来说，至少在这个规模上，最稀缺的是专注，对吧？就像你是一家初创公司时，也许你在资本上更受限制。

你知道，你只是在做一个想法，你可能没有所有的资源。我认为在某个时候你会越过某个门槛，在那里你所做的事情的性质，你正在构建多个东西，你正在创造更多的价值，但你在什么可以指导和做好方面变得更加受限。就像总是有一些情况，组织中发生了一些随机的很棒的事情。

我甚至不知道。那太好了。但就像，但我认为一般来说，组织的能力在很大程度上受到 CEO 和管理团队能够监督和管理的限制。我认为这一直是我们的重点，就像本·霍洛维茨所说的，保持主要的事情是主要的事情，并尝试专注于你的关键优先事项。

Dwarkesh：太棒了。这太棒了，Mark。非常感谢。这很有趣。

Mark：是的，非常有趣。谢谢你邀请我。是的，绝对的。

Dwarkesh：嘿，大家好。我希望你们喜欢与 Mark 的这一集。正如你们所看到的，我现在正在做广告，所以如果你们有兴趣在播客上做广告，请点击描述中的链接，否则如你们所知，你们能做的最有帮助的事情就是与你们认为可能会喜欢它的人分享播客，比如你们的朋友、群聊、Twitter，我想是帖子。是的，希望你们喜欢，下次再见。

---

好的，我将按照对话的内容和话题，将这次采访总结为以下几个章节:

1. Meta AI 的最新发布

Mark 介绍了即将发布的 Meta AI 新版本，其中最重要的是升级到 Llama 3 模型。Llama 3 将以开源形式提供给开发者社区，并成为 Meta AI 的核心。它整合了谷歌和必应的实时知识，在 Meta 的各种应用中都占据突出位置。此外还有一些有趣的创作新功能，如动画和实时图像生成。

2. 应对竞争对手的策略

Mark 分享了他们 2022 年开始采购 H100 GPU 的决策过程。当时他们正在开发 Reels 功能，需要更多的 GPU 算力。Mark 意识到他们必须储备足够的算力，以应对未来的不可预见的需求。这个决定被证明是正确的。Mark 认为在 Meta 做出一些看似正确的决定时，通常是因为他们之前犯过类似的错误，并吸取了教训。

3. 拒绝天价收购和对元宇宙的坚定信念

Mark 回顾了他当年拒绝以 10 亿美元出售 Facebook 的决定。他认为这更多出于个人原因，而非商业分析。Mark 深信他们正在做有意义的事情，如果卖掉公司，他可能会去创办一家类似的新公司。

谈到对元宇宙的坚定投入，Mark 认为解决眼前的实际问题和满足用户的真实需求，比盲目追逐华而不实的设想更加重要。他们要打造的元宇宙产品需要经过反复的研发和试错，而不是一蹴而就的。

4. AGI 的发展进程和挑战

Mark 认为，类似 GPT-4 这样的大型语言模型，离真正的 AGI 还有很大距离。但在通往 AGI 的过程中，会涌现出许多实用的应用，给各行各业带来巨大的效率提升。目前的瓶颈主要在算力和能源，纯软件层面的进展相对更快。

5. 开源的机遇与风险

Mark 坦言，开源是把双刃剑。好处是可以发挥群体智慧，激发创新，打造一个开放、公平的 AI 生态。风险则是一些别有用心的坏人，可能会利用开源系统做一些违法或不道德的事情。权衡利弊，Meta 目前仍是坚定的开源拥趸。只有在系统表现出某些无法轻易消除的危险特征时，才会考虑闭源。

6. 应对 AI 伦理挑战的策略

Mark 认为，眼下应该把更多精力放在解决实际的伦理问题，如识别和遏制错误信息、仇恨言论等，而不是过度担忧某些还没有出现的威胁。这需要在 AI 系统研发的同时，加强内容审核和业务规则的制定。Meta 正在这两个方面同时发力。

7. 关于信仰与动力的话题

Mark 认为，要在激烈的行业竞争中保持领先，最稀缺的资源不是资金，而是公司的专注力。决策者需要对正在做的事情有坚定的信仰，并且要不断为用户创造新的价值。Mark 从小就有一种不懈的动力，要打造一流的产品。这种动力渗透到了他生活的方方面面。

8. 其他话题

Mark 还简单谈了他对人类历史上某些关键节点的兴趣，如古罗马时期和科技革命时期。他借鉴历史上的一些案例，佐证了自己对人工智能发展的一些看法。Mark 还透露，Meta 正在为自己的 AI 定制专用芯片，以从更底层优化算法性能。

总的来说，这次采访涵盖了人工智能技术发展的诸多方面，Meta 的战略侧重点，以及 Mark 作为科技领袖的管理理念和个人动机。Mark 的表述中透露出清晰的战略思路和内在的激情，这或许正是支撑 Meta 这艘大船穿越重重迷雾，继续前行的关键要素。

