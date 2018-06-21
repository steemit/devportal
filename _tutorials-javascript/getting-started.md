---
title: Getting Started
position: 1
exclude: true
layout: full
description: Common tasks for using javascript to access the blockchain
---
### Node.js
To get the most out of these tutorials, you should be familiar with [Node.js](https://nodejs.org/en/), [ES6](https://babeljs.io/learn-es2015/) aka [es2015](http://www.ecma-international.org/ecma-262/6.0/), the DOM, and modern Javascript programming practices. 
You can still learn a lot of these aren't in your base skillset; it'll be easier if they are.

### Your Dev Environment
These tutorials require [Node.js 8+](https://nodejs.org/en/download/). [Yarn](https://yarnpkg.com/en/) is nice, but not required.  Runnable versions of the tutorials are located [in this github repo](https://github.com/steemit/devportal-tutorials-js).
If you haven't chosen an editor, you can use [Atom](https://atom.io/), [Sublime](https://www.sublimetext.com/), [Intellij](https://www.jetbrains.com/idea/), [Vi](https://en.wikipedia.org/wiki/Vi), etc.

If you want to keep multiple versions of Node on your system try [Node Version Manager](https://github.com/creationix/nvm).

### Running a typical Tutorial

Let's say you wanted to run the very first tutorial, `01_blog_feed`. Here's how you'd do it:

```bash
From bash:
git clone https://github.com/steemit/devportal-tutorials-js.git
cd devportal-tutorials-js/tutorials/01_blog_feed
npm i
npm run start
open http://localhost:3000/
```


### Github

If you'd rather clone projects in a windowed environment rather than the terminal, consider [Github Desktop](https://desktop.github.com/).

Tip:
```
One advantage of using nvm to manage node.js is it does not require sudo or third party OS package managers.
```

Tip:
```
Instead of 'npm i' you may also use 'yarn install'.
```

Check out [yarn](https://yarnpkg.com/en/docs/install).
