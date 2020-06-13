# How to use Font Awesome 5 on VueJS Project

Thang Minh Vu

Jul 18, 2019 · 4 min read

[How to use Font Awesome 5 on VueJS Project - Frontend Weekly - Medium](https://medium.com/front-end-weekly/how-to-use-fon-awesome-5-on-vuejs-project-ff0f28310821)


Font Awesome is a popular icon library which I used a lot in my Vue.js related project. Since it’s updated from Font Awesome 4 to Font Awesome 5, I have confronted with couples of problems when integrated with VueJS project. I would like to share the ways I’ve been used to add Font Awesome to my VueJS project.
In this article, I only deal with the free version of Font Awesome. For the Pro version, the process is pretty much similar.

The easiest way
The simplest way is using CDN. You can enter your email into Font Awesome website and then get CND link

Add the script to head section of index.html
<script src="https://kit.fontawesome.com/your-code-number.js"></script>
then you can use font awesome in your template with normal syntax:
<i class="fab fa-medium"></i>
<i class="far fa-envelope"></i>
The better way
I’m using vue-cli to create VueJS project and manage dependencies with npm (sometimes I use yarn). So I prefer using npm to install Font Awesome instead of adding a CDN link to head section. Fortunately, it can be done easily:
$ npm install --save-dev @fortawesome/fontawesome-free
then in main.js, import css and js file
import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'
...
new Vue({  router,  store,  render: h => h(App),}).$mount('#app')
and then use it as normal in Vue template
<i class="fab fa-medium"></i>
<i class="far fa-envelope"></i>
The best way (or the Vue way)
Above way is pretty easy, but it has a downside: it will bundle all available icons to your final bundle, which has a big size. We need another way to only import a small number of icons which are actually used in the project.
There is an officual vue-fontawesome package which you can use. You can install with npm
$ npm i --save @fortawesome/fontawesome-svg-core
$ npm i --save @fortawesome/free-solid-svg-icons 
$ npm i --save @fortawesome/free-brands-svg-icons
$ npm i --save @fortawesome/vue-fontawesome
Import in main.js
import { library } from '@fortawesome/fontawesome-svg-core'
import { faSpinner } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
library.add(faSpinner)
Vue.component('font-awesome-icon', FontAwesomeIcon)
...
new Vue({  router,  store,  render: h => h(App),}).$mount('#app')
Now you can use it in Vue template with font-awesome-icon component
<template>
  <div id="app">
    <font-awesome-icon icon="spinner" />
  </div>
</template>
It’s not very straightforward. There are some gotchas you need to notice:
Gotcha 1
There are multiple prefixes with Font Awesome 5, above syntax is a shorthand for
<font-awesome-icon icon="spinner" />
<font-awesome-icon :icon="['fas', 'spinner']" />
That means fas is default. If you want to use different prefix, you need to make it explicitly:
// main.js
import { faVuejs } from ‘@fortawesome/free-brands-svg-icons’
library.add(faVuejs)
// template
<font-awesome-icon :icon=”[ 'fab', 'vuejs' ]” />
There are 4 different styles, you can find more information here

Gotcha 2
Import each icon seems tedious. You need to remember which icons are used to import. If you need to import 10 icons, your code might become:
import { 
    faCoffee, faSpinner, faEdit, faCircle, faCheck,
    faPlus, faEquals, faArrowRight, faPencilAlt, faComment
} from '@fortawesome/free-solid-svg-icons';
library.add(
    faCoffee, faSpinner, faEdit, faCircle, faCheck,
    faPlus, faEquals, faArrowRight, faPencilAlt, faComment);
It’s not very nice. Luckily, you can import entire styles:
import { fas } from '@fortawesome/free-solid-svg-icons'

library.add(fas)
then done. You don’t need to import each icon individually anymore.
Gotcha 3
By default, when using @fortawesome/fontawesome-svg-core package, you can’t use the syntax <i class=”fas fa-coffee”></i>
<i class="fas fa-coffee"></i> // not work
<font-awesome-icon icon="coffee" /> // work
To make automatically transform from <i></i> to <svg></svg>, you need to enable manually
import { dom } from '@fortawesome/fontawesome-svg-core'

dom.watch()
then <i class=”fas fa-coffee”></i> will work. It’s very helpful when you need to use Font Awesome in the 3rd library like Bootstrap 4 Datepicker
Conclusion
Font Awesome is just an … awesome library. With this article, I hope you will find it easier to add icons to your Vue.js application. There are many more features which you can find on official page. Happy coding!
Frontend Weekly
It's really hard to keep up with all the front-end…
