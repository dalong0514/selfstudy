30 MAY 2017

# Between the Wires: An interview with Vue.js creator Evan You

[Between the Wires: An interview with Vue.js creator Evan You](https://www.freecodecamp.org/news/between-the-wires-an-interview-with-vue-js-creator-evan-you-e383cbf57cc4/)

I interviewed Evan You, the creator of vuejs.org which is a popular progressive JavaScript framework. Evan works on Vue full time with the funding from the Patreon campaign. Previously, he worked at Google and Meteor.

This article was originally posted on Between the Wires, an interview series featuring those who are building developer products.

Tell us a little bit about your childhood and where you grew up.
Okay, so I was born in China, my hometown is called Wuxi. It’s a medium-sized city, which is right next to Shanghai. Actually, I went to Shanghai for high school for three years and commuted back and forth. After high school I went to the US for college. I guess I got early access to computers, but I didn’t really get into programming too much. I was more interested in games, and I did play a lot with Flash when I was in high school, because I really enjoyed making those interactive storytelling experiences.


Evan with his first computer, 1996
What was your first programming experience?
“I was attracted to JavaScript because of the ability to just build something and share it instantly with the world. You put it on the web, and you get a URL, you can send it to anyone with a browser. That was the part that just attracted me to the web and to JavaScript.”
When I went to college in the US, honestly I didn’t know what I wanted to do and I was majoring in studio art and art history. When I was about to graduate, I realized it was pretty hard to find a job doing studio art and art history.

I figured maybe I could go to a master’s program that fit my interests better and developed more skills. I went to Parsons and studied the Master of Fine Arts for Design and Technology. It was a really cool program because everyone was half designer and half developer. They taught you things like openFrameworks, processing, algorithmic animations, and you also had to design apps and interfaces.

Parsons didn’t really teach a lot of JavaScript, but I was attracted to JavaScript because of the ability to just build something and share it instantly with the world. You put it on the web, and you get a URL, you can send it to anyone with a browser. That was the part that just attracted me to the web and to JavaScript.

At the time, Chrome experiments had just been released, and I was totally blown away. I immediately jumped into JavaScript and started learning it myself, and began building things similar to Chrome experiments. I put those things in my portfolio and then it somehow got picked up by the recruiter at Google Creative Lab. I joined as part of the Five program. Every year Creative Lab recruits five new graduates. It’s basically a small team with a copywriter, a creative technologist, a graphic designer, a strategist, and a wildcard.

Okay, when or how did you discover the current problem that you’re trying to solve with Vue.js?
My job at Google involved a lot of prototyping in the browser. We had this idea and we wanted to get something tangible as fast as possible. Some of the projects used Angular at that time. For me, Angular offered something cool which is data binding and a data driven way of dealing with a DOM, so you don’t have to touch the DOM yourself. It also brought in all these extra concepts that forced you to structure the code the way it wanted you to. It just felt too heavy for the use case that I had at that time.

I figured, what if I could just extract the part that I really liked about Angular and build something really lightweight without all the extra concepts involved? I was also curious as to how its internal implementation worked. I started this experiment just trying to replicate this minimal feature set, like declarative data binding. That was basically how Vue started.

I worked on it, and felt it had potential, because I enjoyed using it myself. I put a little bit more time into it and packed up properly, gave it a name, called it Vue.js. That was in 2013. Later on I thought, “Hey, I put so much time into this. Maybe I should share it with others so they could at least benefit from it, or maybe they will find it interesting.”

In February 2014, that was how I first released it as an actual project. I put it out on Github and sent a link to Hacker News, and it actually got voted to the front page. It stayed there for a few hours. Later, I wrote an article to share the first week usage data and what I learned.

That was my first experience seeing people going to Github and starring a project. I think I got several hundred stars in the first week. I was super excited back then.

If you had to list a few core things that defined Vue compared to other frameworks, what would you say?
I think, in terms of all the frameworks out there, Vue is probably the most similar to React, but on a broader sense, among all the frameworks, the term that I coined myself is a progressive framework. The idea is that Vue is made up of this core which is just data binding and components, similar to React. It solves a very focused, limited set of problems. Compared to React, Vue puts a bit more focus on approachability. Making sure people who know basics such as: HTML, JavaScript, and CSS can pick it up as fast as possible.

On a framework level, we tried to build it with a very lean and minimal core, but as you build more complex applications, you naturally need to solve additional problems. For example routing, or how you handle cross component communication, share states in a bigger application, and then you also need these build tools to modularize your code base. How do you organize styles, and the different assets of your app? Many of the more complete frameworks like Ember or Angular, they try to be opinionated on all the problems you are going to run into and try to make everything built into the framework.

It’s a bit of a trade off. The more assumptions you make about the user’s use case then the less flexibility the framework will eventually be able to afford. Or leave everything to the ecosystem such as React — the React ecosystem is very, very vibrant. There are a lot of great ideas coming out, but there is also a lot of churn. Vue tries to pick the middle ground where the core is still exposed as a very minimal feature set, but we also offer these incrementally adoptable pieces, like a routing solution, a state management solution, a build toolchain, and the CLI. They are all officially maintained, well documented, designed to work together, but you don’t have to use them all. I think that’s probably the biggest thing that makes Vue as a framework, different from others.

How did you manage to become financially sustainable with Vue.js?
“I’m creating value for these people, so theoretically if I can somehow collect these values in a financial form, then I should be able to sustain myself.”
I’m creating value for these people, so theoretically if I can somehow collect these values in a financial form, then I should be able to sustain myself. This gets complicated because JavaScript framework is relatively hard for people to pay upfront, given how the JavaScript ecosystem has been working.

Vue has a very vibrant user base. Many of Vue users are from the Laravelcommunity and they are also really enthusiastic and nice people. I thought, would crowdfunding work? I just wanted to try this idea on Patreon. Actually Dan Abramov, the creator of React-Hot-Loader and Redux, also did a small campaign on Patreon before. That’s actually what interests me. I have a rough idea of how many people are using Vue. Let’s say there are 10,000 users. If maybe 1% of them is willing to give me ten bucks a month, that is something.


Evan’s Patreon campaign
In February, I started a Patreon campaign, and it is a two-part thing. One part is targeted towards individuals who are using Vue. Typically they’re just willing to give up a small sum, kind of like buying me coffee. Then there’s the other camp with actual business entities, like start-ups or consultancy shops, who’ve built stuff with Vue. It’s important for them to see that Vue is maintained in the long run. It affords them peace of mind knowing that their financial support will make Vue more sustainable and they can feel safe using it for the long run.

Another aspect of it is Patreon rewards. If companies are willing to sponsor us, then I could put their logo up on a sponsor page on vuejs.org. It raises the awareness of the community. Half the Patreon funds are coming from individuals and one of them sponsored $2000 a month. I had no idea if it would work out when I tried it, but it turns out it’s kind of working. I think I made the full-time jump when I had $4000 a month on Patreon, and now it’s grown to over $9800 a month.

Did it take a long time to convince them to sponsor you? Were they skeptical at all, like, you’re just a young framework, you might not last six months?
When I started the Patreon campaign Vue was already showing really strong growth. In early 2015, Vue was largely still just a random open source project, but the Laravel community started going full on with Vue. I felt like if I couldn’t actually make any money out of it, it wouldn’t make sense.

I have to give a special thanks to Strikingly, which is a start-up based in Shanghai. They are really actively involved in JavaScript and Ruby communities in China. They don’t actually use Vue a lot, but they have this monthly fund that they use to sponsor open source projects. They were the first $2000 a month sponsor for six months.

That helped significantly in the early phase. Also, Taylor Otwell, creator of Laravel, is also sponsoring Vue. He started with 100, and bumped it up to 200, and 500 over time.

You mentioned that you were able to get sponsored because it grew so quickly. Did you have to do any marketing? Or did it grow organically?
I would say there isn’t any real money involved in marketing. I didn’t buy ads or anything. It’s mostly, just writing some blog posts. A lot of times I was just managing the Twitter account. I think that’s pretty much it. Occasionally I’d write a post on Medium.

You ended up getting great traction in international markets, which is probably pretty unique. We’d love to hear how it happened and some of the challenges and best practices for engaging developers outside of the US.

JSConf China, 2015
The Chinese market is unique. I’m Chinese and I’m pretty involved in the Chinese JavaScript community. A lot of people knew Vue because they knew me. We had this whole translation of Vue documentation into really well written Chinese, so that helped a lot with Vue’s adoption in China. A lot of users also know, “Hey, the author of this library is Chinese.” They just naturally feel inclined to at least check it out, but I think that helped quite a bit in the early phases. Vue just started being used by more and more companies in China, including teams at Alibaba, Tencent and Baidu. Those are all billion-dollar valued companies in China. React also has a really big mindshare in China.

There is a Quora clone in China named Zhihu, people ask all kinds of random questions on there and I answer a lot of JavaScript and Vue.js-related questions for them.

Do you have any suggestions for companies, startups, or open source projects that aren’t easily able to engage or communicate with international communities?
I guess the language barrier is probably the hardest part. The idea is if you don’t really put dedicated effort into pushing something in China, then no one’s going to notice it, unless you’re as big as React. You need someone who can speak Chinese, someone who can speak native Chinese to actually do it.

Another interesting thing is that there are actually many other users from other regions of the world such as Italy, Spain, Portugal and Japan. Some of the most active contributors are from Japan. They are really, really meticulous in translating the documentations.

Did you make any mistakes while building Vue that you hope to never make again?
“I have to completely rethink the problem in a certain way, but I think that’s just how software development goes because you would never get anything right just from the first try.”
Hm, I know, there are probably quite a few. To date, Vue has been rewritten from the ground up twice. Obviously, I rewrote it because the original implementation had problems that just could not be solved by gradually refractory. It’s like every six months I look at the code base from six months ago. I’ll be like, wow. How did this even work?

I have to completely rethink the problem in a certain way, but I think that’s just how software development goes because you would never get anything right just from the first try.

The journey of building Vue is also a journey of just growing as a developer, because over time I had to add new features, maintain it, fix bugs and ensure the whole ecosystem worked correctly together. It just naturally exposes you to all the problems you would run into as a software engineer. It’s just a learning process.

Have there been emotional, or non-technical hardships that you’ve faced with Vue?
“There is not going to be this one true framework that just makes everyone happy. The more important part is, make it better for the people who actually enjoy your framework. Focus on what you believe is the most valuable thing in your framework and just make sure you’re doing a great job, rather than worrying about how you compare to others.”
There definitely have been. There’s a lot of pressure in terms of competition. When Vue was still relatively unknown, that pressure isn’t there because any exposure is good. People aren’t going to hold you up to a certain standard. But as Vue has grown bigger and bigger, naturally people started comparing Vue to things like Angular or React, and they point out things like, “hey, React does this better. Angular does this better.”

That puts a lot of pressure on you and it can be stressful having to compete with all the big guys. Especially now that I’m doing this full-time. The viability of Vue in the ecosystem basically is directly related to how well I am doing.

But recently I just watched a talk by Evan Czaplicki, the author of Elm, where he talked about how he had a similar pressure when he was working on Elm. There was Om, the ClojureScript interface on top of React. There was PureScript, there’s other functional compiling to JavaScript languages out there, he was also worried how Elm could compete with those libraries.

Later on, he talked to Guido, author of Python, and Guido gave him advice, he said, “just do a good job.” The idea behind that is that Python also had this problem. It competes with a lot of dynamic languages, like Ruby, JavaScript, Perl, and it’s also in the same problem domain. It ends up all of these languages that are successful in their own right, and they have their own dedicated community using them, enjoying those languages.

People prefer different languages for a reason. Similar to JavaScript frameworks, people would prefer different frameworks for a reason. There is not going to be this one true framework that just makes everyone happy. The more important part is, make it better for the people who actually enjoy your framework. Focus on what you believe is the most valuable thing in your framework and just make sure you’re doing a great job, rather than worrying about how you compare to others.

What would you consider a successful outcome for Vue.js?
That’s a hard question because the scope of Vue.js has definitely increased over time. We now have this whole framework ecosystem, and we’re also expanding to explore things like Weex which is rendering Vue components to a native UI.

I also really care about the approachability part of Vue, which is rooted in the belief that technology should be enabling more people to build things.

The next few are just fun questions outside of programming. What are some other hobbies or interests that you have outside of programming?
Anime, I read a lot of manga. In case you haven’t noticed, Vue’s releases are code-named with anime names. It started in .09, every big release code-name is incrementing with a letter. 2.0 is G which is Ghost in the Shell. F is actually reserved for 1.1. 1.0 was Evangelion.


Illustration drawn by a Japanese Vue user to celebrate the 1.0 release (codenamed Evangelion)

Celebration illustration for Vue 2.0 (codenamed Ghost in the Shell)
I really enjoy karaoke.

What are some top technologies or trends that you’re most excited about?
General technology. It’s weird because I’m not super excited about AR or VR stuff. I really want to talk about something that’s closer to developers. Something like what Guillermo is doing with Now. Developers build tools for developers, and the developer experience of these tools, that is also user experience but for developer tools.

Who are some of your programming heroes? If you have any.
Obviously TJ Holowaychuck and Guillermo Rauch. I’m not a computer science major. I basically learned programming through just random online resources and books, but an important way that I learned was just by reading other people’s code. When I read TJ’s code, I always feel like it’s really elegant. That’s the word that comes to mind and that affected me a lot. TJ is definitely a hero to me.

This project is made possible with sponsorships from frontendmasters.com, egghead.io, Microsoft Edge and Google Developers.


Our sponsors.
Donate to support this project.

To suggest a maker you’d like to hear from, please fill out this form.

You can also send feedback to betweenthewires on Twitter.

If this article was helpful, tweet it.

Learn to code for free. freeCodeCamp's open source curriculum has helped more than 40,000 people get jobs as developers. Get started