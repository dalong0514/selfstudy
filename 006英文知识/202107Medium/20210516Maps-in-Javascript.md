# Maps in Javascript

[Maps in Javascript. ES6 introduced new data structures to… | by Andrew Richards | The Startup | Medium](https://medium.com/swlh/maps-in-javascript-33508a5cb6e7)

Andrew Richards

Sep 3, 2020

## 00

ES6 introduced new data structures to take care of some problems that the language did not take care of.

Before it's introduction, people generally used Objects to do the work. However, Objects do not allow keys to be anything other than a string or integer. Keys in a Map, on the other hand, can be anything (object, array, string, or number). This allows for some interesting uses.

Features that objects do not have: 1) Can store Arrays and Objects as keys. 2) Easily iterable in order of entry.

## 01. How to Create a Map

```js
let m = new Map()
```

## 02. Built in Methods

```js
.set()
```

Use the set method to add entries to a Map.

```js
m.set('key', 'value')
m.set('hello', 'world)
```

```js
.get()
```

Use the get method to get the value of a Key, Value pair in a map

```js
m.get('hello')
// 'world'
```

```js
.has()
```

Use the has method to check if a key is in the Map. Returns a boolean.

```js
m.has('hi')
//false
m.has('hello')
//true
```

```js
.size()
```

Use the size method to check the size of a Map. Something that is not available with an object.

```js
m.size()
//2
```

```js
.delete()
```

Use the delete method to remove an entry from a Map.

```js
m.delete('hello')
// will remove hello from the Map
m.size()
// 1
```

## 03. Iterating Through a Map

One of the biggest improvements of a Map over an Object is the ability to iterate through the data structure in the order that the objects were added. In doing this we also have access to the value using destructuring. We can use a 'for, of' loop to get this done.

```js
for(const [k, v] of m){
    console.log(k, v)
}
// hello world
```