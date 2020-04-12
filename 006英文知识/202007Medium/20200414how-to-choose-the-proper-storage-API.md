# How JavaScript works: Storage engines + how to choose the proper storage API


Alexander Zlatkov


Alexander Zlatkov


Following


Jun 13, 2018 · 15 min read


[How JavaScript works: Storage engines + how to choose the proper storage API](https://blog.sessionstack.com/how-javascript-works-storage-engines-how-to-choose-the-proper-storage-api-da50879ef576)


This is post # 16 of the series dedicated to exploring JavaScript and its building components. In the process of identifying and describing the core elements, we also share some rules of thumb we use when building SessionStack, a JavaScript application that needs to be robust and highly-performant to help users see and reproduce their web app defects real-time.


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


Tracking changes in the DOM using MutationObserver


The rendering engine and tips to optimize its performance


Inside the Networking Layer + How to Optimize Its Performance and Security


Under the hood of CSS and JS animations + how to optimize their performance


Parsing, Abstract Syntax Trees (ASTs) + 5 tips on how to minimize parse time


The internals of classes and inheritance + transpiling in Babel and TypeScript


Overview


Choosing the right storage mechanisms for local device storage is crucial when designing your web app. A good storage engine makes sure your information is saved reliably, reduces bandwidth, and improves responsiveness. The right storage caching strategy is a core building block for enabling offline mobile web experiences, which is something more and more users feel should be the case by default.


In this chapter, we’ll discuss the available storage APIs and services and will offer some guidelines on how to make the right choice when building your web app.


Data Model


The data storing model determines how data is organized internally. This impacts the entire design of your web app, defines the tradeoffs to making your web app efficient yet solve the problem it should solve. There is no「better」approach and no one-size-fits-all solution as with almost everything related to engineering. So, let’s take a look at the data models that you could choose from:


Structured: Data stored in tables with predefined fields, as is typical of SQL based database management systems, lends itself well to flexible and dynamic queries. A prominent example of a structured datastore in the browser is IndexedDB.


Key/Value: Key/Value datastores, and related NoSQL databases, offer the ability to store and retrieve unstructured data indexed by a unique key. Key/Value datastores are like hash tables in the sense that they allow constant-time access to indexed, opaque data. Good examples of key/value datastores are the Cache API in the browser and Apache Cassandra on the server.


Byte Streams: This simple model stores data as a variable in length, opaque string of bytes, leaving any form of internal organization to the application layer. This model is particularly good for file systems and other hierarchically organized blobs of data. Prominent examples of byte stream datastores include file systems and cloud storage services.


Persistence


Storage methods for web apps can be analyzed with respect to the timeframe over which data is made persistent:


Session Persistence: Data in this category is persisted only as long as a single web session or browser tab remains active. An example of a storage mechanism with session persistence is the Session Storage API.


Device Persistence: Data in this category is persisted across sessions and browser tabs/windows, on a particular device. An example of a storage mechanism with device persistence is the Cache API.


Global Persistence: Data in this category is persisted across sessions and devices. Therefore, it is the most robust form of data persistence. It cannot be stored on the device itself, however, which means that you need some sort of server-side storage. We won’t discuss it here in detail as this post is focused on storing data on the device itself.


Data persistence in the browser


Nowadays, there are quite a few browser APIs that allow you to store data. We’ll go through some of them and create a comparison to make it easier for you to choose the right option.


First, however, there are a few things that you should consider before choosing how to persist your data. Of course, the first thing you have to understand very well is the way your web app is going to be used and later maintained and enhanced. Even if you have the answers to these questions, you may end up with a few options to choose from. So, here is what you should look at :


Browser Support — you should take into account the fact that standardized and well established APIs are preferable, because they tend to be longer lived and more widely supported. Those APIs also enjoy a broader documentation and richer community of developers.


Transactions — sometimes, it is important for a collection of related storage operations to succeed or fail atomically. Databases have traditionally supported this feature using a transaction model, where related updates may be grouped into arbitrary units.


Sync/Async — Some storage APIs are synchronous in the sense that storage or retrieval requests block the currently active thread until the request is completed. Using a synchronous storage API can block the main thread and create a freezing experience for the UI of your web app. If possible, use async APIs.


Comparison


In this section, we take a look at the current APIs available for web developers and compare them across the dimensions described above.


File system API


With the FileSystem API, a web app can create, read, navigate, and write to a sandboxed section of the user’s local file system.


The API is broken up into various themes:


Reading and manipulating files: File/Blob, FileList, FileReader


Creating and writing: Blob(), FileWriter


Directories and file system access: DirectoryReader, FileEntry/DirectoryEntry, LocalFileSystem


The File system API is a non-standard API. You shouldn’t use it in production web apps since it will not work for every user. There may be large incompatibilities between implementations, and the behavior will probably change in the future.


The File and Directory Entries API interface FileSystem is used to represent a file system. These objects can be obtained from the filesystem property on any file system entry. Some browsers offer additional APIs to create and manage file systems.


This interface will not grant you access to the users’ filesystem. Instead, you will have a「virtual drive」within the browser sandbox. If you want to gain access to the users’ filesystem, you need to invoke the user by eg. installing a Chrome extension.


Requesting a file system


A web app can request access to a sandboxed file system by calling window.requestFileSystem():


if you’re calling requestFileSystem() for the first time, new storage is created for your app. It’s important to remember that this file system is sandboxed, meaning one web app cannot access another app’s files.


After you get access to the file system, you can do most of the standard operations on files and directories.


The FileSystem is quite a different storage option compared to the others as it aims to satisfy client-side storage use cases not well served by databases. Generally, these are applications that deal with large binary blobs and/or share data with applications outside of the context of the browser.


These are good use-cases for the FileSystem API:


Persistent uploader — when a file or directory is selected for upload, it copies the files into a local sandbox and uploads a chunk at a time.


Video game, music, or other apps with lots of media assets


Audio/Photo editor with offline access or local cache for speed -the data blobs are potentially quite large and are read-write.


Offline video viewer — it needs to download large files for later viewing or efficient seek + streaming


Offline Web Mail Client — downloads attachments and stores them locally.


This is the current browser support for the API:


Local storage


The `localStorage` API allows you to access a Storage object for the Document’s origin. The stored data is saved across browser sessions. localStorage is similar to sessionStorage, except that while data stored in localStorage has no expiration time, data stored in sessionStorage gets cleared when the page session ends — that is, when the page is closed.


Note that data stored in either localStorage or sessionStorage is specific to the origin of the page, which is a combination of the protocol, host and the port.


This is the current browser support for the API:


Session storage


The sessionStorage property allows you to access a session Storage object for the current origin. sessionStorage is similar to localStorage, briefly explained above. The only difference is that while data stored in localStorage has no expiration set, data stored in sessionStorage gets cleared when the page session ends. A page session lasts for as long as the browser is open and survives over page reloads and restores. Opening a page in a new tab or window will cause a new session to be initiated, which differs from how session cookies work.


Note that data stored in either sessionStorage or localStorage is specific to the origin of the page.


This is the current browser support for the API:


Cookies


A cookie (web cookie, browser cookie) is a small piece of data that the user’ server sends to the user’s web browser. The browser may store it and send it back with the next request to the same server. Typically, it’s used to tell if two requests came from the same browser — keeping a user logged-in, for example. It remembers stateful information for the stateless HTTP protocol.


Cookies have three main use-cases:


Session management — Logins, shopping carts, game scores, or anything else the server should remember


Personalization — User preferences, themes, and other settings


Tracking — Recording and analyzing user behavior


Cookies were once used for general client-side storage. While this was legitimate when they were the only way to store data on the client, nowadays it is recommended to choose modern storage APIs. Cookies gets sent with every request, so they can deteriorate performance (especially when on a mobile data connection).


There are two types of cookies:


Session cookies — They are deleted when the client shuts down. Web browsers may use session restoring, which makes most session cookies permanent, as if the browser was never closed.


Permanent cookies — Instead of expiring when the client closes, permanent cookies expire at a specific date (Expires) or after a specific time period (Max-Age).


Note that confidential or sensitive information should never be stored or transmitted with HTTP Cookies, as the entire mechanism is inherently insecure.


And, as you might have guessed, cookies are widely supported among all browsers.


Cache


The Cache interface provides a storage mechanism for Request / Response object pairs that are cached. Note that the Cache interface is exposed to windowed scopes as well as workers. You don’t have to use it in conjunction with service workers, even though it is defined in the service worker spec.


An origin can have multiple, named Cache objects. You are responsible for implementing how your script (e.g. in a ServiceWorker) handles Cache updates. Items in a Cache do not get updated unless explicitly requested; they don’t expire unless deleted. Use CacheStorage.open() to open a specific, named Cache object and then call any of the Cache methods to maintain the Cache.


You are also responsible for periodically purging cache entries. Each browser has a hard limit on the amount of cache storage that a given origin can use. Cache quota usage estimates are available via the StorageEstimate API. The browser does its best to manage disk space, but it may delete the Cache storage for an origin. The browser will generally either delete all the data for an origin or none of it. Make sure to version caches by name and use the caches only from the version of the script that they can safely operate on. See Deleting old caches for more information.


The CacheStorage interface represents the storage for Cache objects.


The interface:


Provides a master directory of all the named caches that can be accessed by a ServiceWorker or other type of worker or window scope (you’re not limited to only using it with service workers, even though the Service Workers spec defines it)


Maintains a mapping of string names to corresponding Cache objects


Use CacheStorage.open() to obtain a Cache instance.


Use CacheStorage.match() to check if a given Request is a key in any of the Cache objects that the CacheStorage object tracks.


You can access CacheStorage through the global caches property.


IndexedDB


IndexedDB is a way for you to persistently store data inside a user’s browser. Because it lets you create web applications with rich query abilities regardless of network availability, these applications can work both online and offline. IndexedDB is useful for applications that store a large amount of data (for example, a catalog of DVDs in a lending library) and applications that don’t need persistent internet connectivity to work (for example, mail clients, to-do lists, and notepads).


In this article, it’s the storage DB which we’re going to discuss in a bit more detail because the rest of the storage APIs are quite well-known. Plus, IndexedDB is getting more and more popular with the increased complexity of web apps nowadays.


The internals of IndexedDB


IndexedDB lets you store and retrieve objects that are stored with a「key.」All changes that you make to the database happen within transactions. Like most web storage solutions, IndexedDB follows a same-origin policy. So while you can access stored data within a domain, you cannot access data across different domains.


IndexedDB is an asynchronous API that can be used in most contexts, including WebWorkers. It used to include a synchronous version too, for use in web workers, but this was removed from the spec due to lack of interest by the web community.


IndexedDB used to have a competing spec called WebSQL Database, but it was deprecated by the W3C. While both IndexedDB and WebSQL are solutions for storage, they do not offer the same functionalities. WebSQL Database is a relational database access system, whereas IndexedDB is an indexed table system.


Don’t start working with IndexedDB, relying on your assumptions from other types of databases. Instead, you should read the docs carefully. Here are some of the essential concepts that you should have in mind:


IndexedDB databases store key-value pairs — the values can be complex structured objects, and keys can be properties of those objects. You can create indexes that use any property of the objects for quick searching, as well as for a sorted enumeration. Keys can also be binary objects.


IndexedDB is built on a transactional database model — everything you do in IndexedDB always happens in the context of a transaction. Thus, you cannot execute commands or open cursors outside of a transaction. Also, transactions auto-commit and cannot be committed manually.


The IndexedDB API is mostly asynchronous — the API doesn’t give you data by returning values. Instead, you have to pass a callback function. You don’t「store」a value into the database, or「retrieve」a value from the database through synchronous means. Instead, you「request」that a database operation happens. An event notifies you when the operation completes, and the type of event you get informs you if the operation succeeded or failed. It’s not that different from the way that XMLHttpRequest (or tons of other JavaScript stuff) works.


IndexedDB uses a lot of requests — requests are objects that receive the success or failure events that were mentioned previously. They have onsuccess and onerror properties, as well as readyState, result, and errorCode properties that tell you the status of the request.


IndexedDB is object-oriented — IndexedDB is not a relational database with tables representing collections of rows and columns. This fundamental difference affects the way you design and build your applications.


IndexedDB does not use Structured Query Language (SQL) — it uses queries on an index that produces a cursor, which you use to iterate across the result set. If you are not familiar with NoSQL systems, read the Wikipedia article on NoSQL.


The same-origin policy applies to IndexedDB — an origin is the domain, the application layer protocol, and the port of a URL of the document where the script is being executed. Each origin has its own associated set of databases. Every database has a name that identifies it within an origin.


IndexedDB limitations


IndexedDB is designed to cover most cases that need client-side storage. It has not been designed, however, for a few cases such as the following:


Internationalized sorting — not all languages sort strings the same way, therefore internationalized sorting is not supported. While the database can’t store data in a specific internationalized order, you can sort the data that you’ve read out of the database yourself.


Synchronization — the API is not designed to take care of synchronizing with a server-side database. You have to write code that synchronizes a client-side indexedDB database with a server-side database.


Full text searching — the API does not have an equivalent of the LIKE operator in SQL.


In addition, be aware that browsers can wipe out the database in the following conditions (ouch):


The user requests a wipeout — Many browsers have settings that let users wipe all data stored for a given website, including cookies, bookmarks, stored passwords, and IndexedDB data.


The browser is in private browsing mode — Some browsers have「private browsing」(Firefox) or「incognito」(Chrome) modes. At the end of the session, the browser wipes out the database.


The disk or quota limit has been reached.


The data is corrupt..


The exact circumstances and browser capabilities change over time, but the general philosophy of the browser vendors is to make the best effort to keep the data when possible.


Choosing the right storage API


As I mentioned already, it’s better to choose APIs that are widely supported across as many browsers as possible and which offer asynchronous call models, to maximize UI responsiveness. These criteria lead naturally to the following technology choices:


For offline storage, use the Cache API. This API is available in any browser that supports Service Worker technology necessary for creating offline apps. The Cache API is ideal for storing resources associated with a known URL.


For storing application state and user-generated content, use IndexedDB. This enables users to work offline in more browsers than just those that support the Cache API.


We at SessionStack use different storage APIs. For example, our library that is integrated into your web app is using both cookies and session storage. The reason is that our library is collecting data such as user events, DOM changes, network data, exceptions, debug messages and so on and sending them to our servers. We’re collecting such data from user sessions, but we need a proper way to determine when a user session starts and when it stops. We consider a session to be the entire period of web app usage from the start, containing all page views and navigations until the user closes his browser or the tab and doesn’t come back in a few minutes for which we use a combination of session storage and server-side logic. What’s more, , we allow you to identify individual end-users so that we can provide you with user data for each session. We rely on cookies to do this (just like other monitoring/analytics tools).


In our application, where you can watch (on-demand or real-time) the collected events as a video that recreates how users have stumbled upon issues, we use mainly cookies due to the RESTful nature of our service which basically requires just an authentication token to authenticate, authorize and validate requests.


There is a free plan if you’d like to give SessionStack a try.


References:


https://developers.google.com/web/fundamentals/instant-and-offline/web-storage/


https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies


https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API/Basic_Concepts_Behind_IndexedDB


