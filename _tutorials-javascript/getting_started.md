---
title: 'JS: Getting Started'
position: 0
description: "Prepare your development environment to use Javascript with the Steem blockchain."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Getting Started](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/00_getting_started) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



For Javascript tutorials, we will use the opensource library [dsteem](https://github.com/steemit/dsteem).

### Node.js

To get the most out of these tutorials, you should be familiar with [Node.js](https://nodejs.org/en/), [ES6](https://babeljs.io/learn-es2015/) aka [es2015](http://www.ecma-international.org/ecma-262/6.0/), the DOM, and modern Javascript programming practices.
You can still learn a lot of these if they aren't in your base skill-set; it'll be much easier if they are.

### Your Dev Environment

These tutorials require [Node.js 8.7+](https://nodejs.org/en/download/). [Yarn](https://yarnpkg.com/en/) is nice, but not required. Runnable versions of the tutorials are located [in this github repo](https://github.com/steemit/devportal-tutorials-js).
If you haven't chosen an editor, you can use [Atom](https://atom.io/), [Sublime](https://www.sublimetext.com/), [Intellij](https://www.jetbrains.com/idea/), [Vi](https://en.wikipedia.org/wiki/Vi), etc.

If you want to keep multiple versions of Node on your system try [Node Version Manager](https://github.com/creationix/nvm).

### Running a typical Tutorial

Let's say you wanted to run the very [first tutorial](blog_feed), `01_blog_feed`. Here's how you'd do it:

1.  From Bash:

    ```bash
    git clone https://github.com/steemit/devportal-tutorials-js.git

    cd devportal-tutorials-js/tutorials/01_blog_feed
    npm i
    npm run dev-server
    ```

1.  open http://localhost:3000/ in your web browser

```
### Github

If you'd rather clone projects in a windowed environment rather than the terminal, consider [Github Desktop](https://desktop.github.com/).
```


---
