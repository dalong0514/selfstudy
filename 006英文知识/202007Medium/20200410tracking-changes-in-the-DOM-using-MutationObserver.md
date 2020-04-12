# How JavaScript works: tracking changes in the DOM using MutationObserver


Alexander Zlatkov


Alexander Zlatkov


Following


Mar 8, 2018 · 6 min read


[How JavaScript works: tracking changes in the DOM using MutationObserver](https://blog.sessionstack.com/how-javascript-works-tracking-changes-in-the-dom-using-mutationobserver-86adc7446401)


This is post # 10 of the series dedicated to exploring JavaScript and its building components. In the process of identifying and describing the core elements, we also share some rules of thumb we use when building SessionStack, a JavaScript application that needs to be robust and highly-performant to help users see and reproduce their web app defects real-time.


If you missed the previous chapters, you can find them here:


An overview of the engine, the runtime, and the call stack


Inside Google’s V8 engine + 5 tips on how to write optimized code


Memory management + how to handle 4 common memory leaks


The event loop and the rise of Async programming + 5 ways to better coding with async/await


Deep dive into WebSockets and HTTP/2 with SSE + how to pick the right path


A comparison with WebAssembly + why in certain cases it’s better to use it over JavaScript


The building blocks of Web Workers + 5 cases when you should use them


Service Workers, their life-cycle, and use cases


The mechanics of Web Push Notifications


Web apps are getting increasingly heavy on the client-side, due to many reasons such as the need of a richer UI to accommodate what more complex apps have to offer, real-time calculations, and so on.


The increased complexity makes it harder to know the exact state of the UI at every given moment during the lifecycle of your web app.


This gets even harder if you’re building some kind of a framework or just a library, for example, that has to react and perform certain actions that are dependent on the DOM.


Overview


MutationObserver is a Web API provided by modern browsers for detecting changes in the DOM. With this API one can listen to newly added or removed nodes, attribute changes or changes in the text content of text nodes.


Why would you want to do that?


There are quite a few cases in which the MutationObserver API can come really handy. For instance:


You want to notify your web app visitor that some change has occurred on the page he’s currently on.


You’re working on a new fancy JavaScript framework that loads dynamically JavaScript modules based on how the DOM changes.


You might be working on a WYSIWYG editor, trying to implement undo/redo functionality. By leveraging the MutationObserver API, you know at any given point what changes have been made, so you can easily undo them.


These are just a few examples of how the MutationObserver can be of help.


How to use MutationObserver


Implementing MutationObserver into your app is rather easy. You need to create a MutationObserver instance by passing it a function that would be called every time a mutation has occurred. The first argument of the function is a collection of all mutations which have occurred in a single batch. Each mutation provides information about its type and the changes which have occurred.


The created object has three methods:


observe — starts listening for changes. Takes two arguments — the DOM node you want to observe and a settings object


disconnect — stops listening for changes


takeRecords — returns the last batch of changes before the callback has been fired.


The following snippet shows how to start observing:


Now, let’s say that you have some very simple div in the DOM:


Using jQuery, you canremove the class attribute from that div:


As we have started observing, after calling mutationObserver.observe(...) we’re going to see a log in the console of the respective MutationRecord:


This is the mutation caused by removing the class attribute.


And finally, in order to stop observing the DOM after the job is done, you can do the following:


Nowadays, the MutationObserver is widely supported:


Alternatives


The MutationObserver, however, has not always been around. So what did developers resort to before the MutationObserver came along?


There are a few other options available:


Polling


MutationEvents


CSS animations


Polling


The simplest and most unsophisticated way was by polling. Using the browser setInterval WebAPI you can set up a task that would periodically check if any changes have occurred. Naturally, this method significantly degrades web app/website performance.


MutationEvents


In the year 2000, the MutationEvents API was introduced. Albeit useful, mutation events are fired on every single change in the DOM which again causes performance issues. Nowadays the MutationEvents API has been deprecated, and soon modern browsers will stop supporting it altogether.


This is the browser support for MutationEvents:


CSS animations


A somewhat strange alternative is one that relies on CSS animations. It might sound a bit confusing. Basically, the idea is to create an animation which would be triggered once an element has been added to the DOM. The moment the animation starts, the animationstart event will be fired: if you have attached an event handler to that event, you’d know exactly when the element has been added to the DOM. The animation’s execution time period should be so small that it’s practically invisible to the user.


First, we need a parent element, inside which, we’d like to listen to node insertions:


In order to get a handle on node insertion, we need to set up a series of keyframe animations which will start when the node is inserted:


With the keyframes created, the animation needs to be applied on the elements you’d like to listen for. Note the small durations — they are relaxing the animation footprint in the browser:


This adds the animation to all child nodes of the container-element. When the animation ends, the insertion event will fire.


We need a JavaScript function which will act as the event listener. Within the function, the initial event.animationName check must be made to ensure it’s the animation we want.


Now it’s time to add the event listener to the parent:


This is the browser support for CSS animations:


MutationObserver offers a number of advantages over the above-mentioned solutions. In essence, it covers every single change that can possibly occur in the DOM and it’s way more optimized as it fires the changes in batches. On top of it, MutationObserver is supported by all major modern browsers, along with a couple of polyfills which use MutationEvents under the hood.


MutationObserver occupies a central position in SessionStack’s library.


Once you integrate the SessionStack’s library in your web app, it starts collecting data such as DOM changes, network requests, exceptions, debug messages, etc. and sends it to our servers., SessionStack uses this data to recreate everything that happened to your users and show your product issues the same way they happened to your users. Quite a few users think that SessionStack records an actual video — it doesn’t. Recording an actual video is very heavy, while the small amount of data we gather is very lightweight and doesn’t impact the UX and performance of your web app.


There is a free plan if you’d like to give SessionStack a try.


Resources


https://davidwalsh.name/detect-node-insertion


