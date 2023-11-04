## Reading and Writing JSON Files with Node.js

By  Scott Robinson

[Reading and Writing JSON Files with Node.js](https://stackabuse.com/reading-and-writing-json-files-with-node-js/)

[javascript - Write / add data in JSON file using Node.js - Stack Overflow](https://stackoverflow.com/questions/36856232/write-add-data-in-json-file-using-node-js)

### Conclusion

Throughout this article we showed how you can read and write JSON data from and to files, which is a very common and important task to know how to do as a web programmer.

There are a couple of methods in the fs module both for reading from and writing to JSON files. The readFile and readFileSync functions will read JSON data from the file in an asynchronous and synchronous manner, respectively. You can also use the global require method to handle reading/parsing JSON data from a file in a single line of code. However, require is synchronous and can only read JSON data from files with '.json' extension.

Similarly, the writeFile and writeFileSync functions from the fs module write JSON data to the file in an asynchronous and synchronous manner respectively.

### 0.0

One of the best ways to exchange information between applications written in different languages is to use the JSON (JavaScript Object Notation) format. Thanks to its uniformity and simplicity, JSON has almost completely replaced XML as the standard data exchange format in software, particularly in web services.

Given the extensive use of JSON in software applications, and especially JavaScript-based applications, it is important to know how to read and write JSON data to a file in Node.js. In this article we'll explain how to perform these functions.

### 0.1 Reading a JSON File

Let's first see how we can read a file that has already been created. But before we do that we need to actually create the file. Open a new window in your favorite text editor and add the following text to it:

```json
{ 
    "name": "Sara",
    "age": 23,
    "gender": "Female",
    "department": "History",
    "car": "Honda"
}
```

Now save this file as "student.json" to your project directory.

To read the JSON data from the file we can use the Node.js fs module. There are two functions available in this module that we can use to read files from the file system: readFile and readFileSync.

Although both of these functions perform similar tasks i.e. reading files from disk, the difference lies in the way these functions are actually executed, which we'll explain in more detail in the sections below.

#### 1.1 Using fs.readFileSync

The readFileSync function reads data from a file in a synchronous manner. This function blocks the rest of the code from executing until all the data is read from a file. The function is particularly useful when your application has to load configuration settings before it can perform any other tasks.

To continue with our example, let's use this function to read the "student.json" file that we created earlier, using the readFileSync function. Add the following code to a '.js' file:

```js
'use strict';

const fs = require('fs');

let rawdata = fs.readFileSync('student.json');
let student = JSON.parse(rawdata);
console.log(student);
```

In the above Node.js code we first load the fs module to our application. Next we use the readFileSync function and pass it the relative file path to the file that we want to read. If you print the object rawdata to the console, you will see raw data (in a Buffer) on the console screen:

```
<Buffer 7b 20 0a 20 20 20 20 22 6e 61 6d 65 22 3a 20 22 53 61 72 61 22 2c 0a 20 20 20 20 22 61 67 65 22 3a 20 32 33 2c 0a 20 20 20 20 22 67 65 6e 64 65 72 22 ... >
```

However, we want to read the file in its JSON format, not the raw hex data. This is where the JSON.parse function comes into play. This function handles parsing the raw data, converts it to ASCII text, and parses the actual JSON data in to a JavaScript object. Now, if you print the student object on the console, you will get the following output:

```json
{ name: 'Sara',
  age: 23,
  gender: 'Female',
  department: 'History',
  car: 'Honda' }
```

As you can see, the JSON from our file was successfully loaded in to the student object.

#### 1. 2 Using fs.readFile

Another way you can read a JSON file in Node.js is using the readFile function. Unlike readFileSync function, the readFile function reads file data in an asynchronous manner. When a readFile function is called, the file reading process starts and immediately the control shifts to next line executing the remaining lines of code. Once the file data has been loaded, this function will call the callback function provided to it. This way you aren't blocking code execution while waiting for the operating system to get back to you with data.

In our example, the readFile function takes two parameters: The path to the file that is to be read and the callback function that is to be called when the file is read completely. You can optionally also include a parameter with options, but we won't be covering those in this article.

Take a look at the following example to understand how to use the readFile function.

```js
'use strict';

const fs = require('fs');

fs.readFile('student.json', (err, data) => {
    if (err) throw err;
    let student = JSON.parse(data);
    console.log(student);
});

console.log('This is after the read call');
```

1『这个作者估计是「重构」老手，看上面的分支条件语句能感觉出来。（2021-04-18）』

The code above does exactly what our previous code snippet did (with an extra console.log call), but it does so asynchronously. Here are a few of the differences, which you may have noticed:

1 (err, data) => {}: This is our callback function that is executed once the file is completely read.

2 err: Since we can't easily use try/catch with asynchronous code, the function instead gives us an err object if something goes wrong. It is null if there were no errors.

You may have also noticed that we print a string to the console immediately after calling readFile. This is to show you the behavior of asynchronous code. When the above script is executed, you will see that this console.log executes before the readFile callback function executes. This is because readFile does not block code from executing while it reads data from the file system.

The output of the code will look like this:

```
This is after the read call
{ name: 'Sara',
  age: 23,
  gender: 'Female',
  department: 'History',
  car: 'Honda' }
```

As you can see, the last line of code in our file is actually the one that shows up first in the output.

#### 1.3 Using require

Another approach is to use the global require method to read and parse JSON files. This is the same method you use to load Node modules, but it can also be used to load JSON.

Take a look at the following example.

```js
'use strict';

let jsonData = require('./student.json');

console.log(jsonData);
```

It works exactly like the readFileSync code we showed above, but it is a globally available method that you can use anywhere, which has its advantages.

However there are a few drawbacks of require function:

1 Require is synchronous function and is called only once, which means the calls receive a cached result. If the file is updated you can't re-read it using this method.

2 Your file must have '.json' extension, so it can't be as flexible. Without the proper extension require doesn't treat the file as JSON file.

### 02. Writing JSON to a File

Similar to the readFile and readFileSync functions, there are two functions for writing data to files: writeFile and writeFileSync. As the names suggest, the writeFile method writes data to a file in an asynchronous way while writeFileSync function writes data to a file in a synchronous manner.

We'll take a closer look in the following sections.

#### 2.1 Using fs.writeFileSync

The writeFileSync function accepts 2-3 parameters: The path of the file to write data to, the data to write, and an optional parameter.

Note that if the file doesn't already exist, then a new file is created for you. Take a look at the following example:

```js
'use strict';

const fs = require('fs');

let student = { 
    name: 'Mike',
    age: 23, 
    gender: 'Male',
    department: 'English',
    car: 'Honda' 
};
 
let data = JSON.stringify(student);
fs.writeFileSync('student-2.json', data);
```

In the above example we are storing our JSON object student to a file named "student-2.json". Notice that here we have to use the JSON.stringify function before saving the data. Just like we needed to parse the data into JSON format when we read the JSON file, we need to "stringify" the data before we can store it in a string form in the file.

Execute the above code and open the "student-2.json" file. You should see following content in the file:

```json
{"name":"Mike","age":23,"gender":"Male","department":"English","car":"Honda"}
```

Although this is the data that we wanted to write, the data is in the form of one line of string, which is difficult for us to read. If you'd like the serialized JSON to be human readable, then change the JSON.Stringify function as follows:

```js
let data = JSON.stringify(student, null, 2);
```

Here we are telling the method to add newlines and a couple of indentations to the serialized JSON. Now if you open the "student-2.json" file, you should see the text in following format.

```json
{
  "name": "Mike",
  "age": 23,
  "gender": "Male",
  "department": "English",
  "car": "Honda"
}
```

#### 2.2 Using fs.writeFile

As I mentioned earlier, the writeFile function executes in asynchronous manner, which means our code is not blocked while data is written to the file. And just like the asynchronous methods from before, we need to pass a callback to this function.

Let's write another file, "student-3.json", using the writeFile function.

```js
'use strict';

const fs = require('fs');

let student = { 
    name: 'Mike',
    age: 23, 
    gender: 'Male',
    department: 'English',
    car: 'Honda' 
};
 
let data = JSON.stringify(student, null, 2);

fs.writeFile('student-3.json', data, (err) => {
    if (err) throw err;
    console.log('Data written to file');
});

console.log('This is after the write call');
```

The output of the above script will be:

```
This is after the write call
Data written to file
```

And again, you can see that the last line of our code actually shows up first in the console since our callback hasn't been called yet. This ends up saving quite a bit of execution time if you have large amounts of data to write to your file, or if you have quite a few files to write to.

### 03. Learn More

Want to learn more about the fundamentals of Node.js? Personally, I'd recommend taking an online course like Learn Node.js by Wes Bos. Not only will you learn the most up-to-date ES2017 syntax, but you'll get to build a full stack restaurant app. In my experience, building real-world apps like this is the fastest way to learn.

[Learn Node — The best way to learn Node.js, Express, MongoDB, and Friends](https://learnnode.com/)

#### Extend

[javascript - Write / add data in JSON file using Node.js - Stack Overflow](https://stackoverflow.com/questions/36856232/write-add-data-in-json-file-using-node-js)

If this JSON file won't become too big over time, you should try:

1 Create a JavaScript object with the table array in it

```js
var obj = {
   table: []
};
```

Add some data to it, for example:

```js
obj.table.push({id: 1, square:2});
```

Convert it from an object to a string with JSON.stringify

```js
var json = JSON.stringify(obj);
```

Use fs to write the file to disk

```js
var fs = require('fs');
fs.writeFile('myjsonfile.json', json, 'utf8', callback);
```

If you want to append it, read the JSON file and convert it back to an object

```js
fs.readFile('myjsonfile.json', 'utf8', function readFileCallback(err, data){
  if (err) console.log(err)
  obj = JSON.parse(data); //now it an object
  obj.table.push({id: 2, square:3}); //add some data
  json = JSON.stringify(obj); //convert it back to json
  fs.writeFile('myjsonfile.json', json, 'utf8', callback); // write it back
})
```

This will work for data that is up to 100 MB effectively. Over this limit, you should use a database engine.

UPDATE:

Create a function which returns the current date (year+month+day) as a string. Create the file named this string + .json. the fs module has a function which can check for file existence named fs.stat(path, callback). With this, you can check if the file exists. If it exists, use the read function if it's not, use the create function. Use the date string as the path cuz the file will be named as the today date + .json. the callback will contain a stats object which will be null if the file does not exist.

### Comments

SanthiRaju Yedla • 3 years ago

Nice Scott, very informative. I''m stuck on something, can you please help. I'm trying to modify a .json file on my desktop server from AWS Lambda function. Can you please let me know how to achive this.

Scott Mod • 3 years ago

Hi there. So the file your Lambda function is trying to modify is located on a different server? Does the Lambda function have access to the file via some standard protocol?

SanthiRaju Yedla • 3 years ago

Thanks for the response Scott...Yes Scott..Lambda function is on AWS cloud and the file is on my local desktop. Im trying to use HTTPS.Any other suggestions are also welcome. I just want to send some data from my AWS Lambda function to my local desktop and modify the .json file with the data from Lambda. Please help

Scott Mod • 3 years ago

To use HTTP to access your local machine you could set up ngrok (https://ngrok.com/) to tunnel to your local machine and set up a small web server there to handle the HTTP request and modifying the local file.

SanthiRaju Yedla • 3 years ago

Thanks Scott, I'm using ngrok already and am able to read a json on my local server. but I want to update a json file instead of just reading it. How to update a json file with my data from lambda.