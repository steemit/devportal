---
title: Getting Started
position: 1
exclude: true
layout: full
description: Common tasks for using javascript to access the blockchain
right_code: |
    <img src="/images/npm-logo.svg" width="80%" />
    
    Tip:
    ```
    One advantage of using nvm to manager node.js is it does not require sudo or third party OS package managers.
    ```
    
    Tip:
    ```
    Instead of 'npm i' you may also use 'yarn install'.
    ```
    
    Check out [yarn](https://yarnpkg.com/en/docs/install).
---

These tutorials require `node.js 8+` and package management.  The complete JavaScript tutorials are located: [https://github.com/steemit/devportal-tutorials-js](https://github.com/steemit/devportal-tutorials-js)

<a name="setup_node_js"></a>
### Setup `node.js`

To get started, you should have `npm` ([Node Package Manager](https://docs.npmjs.com/getting-started/what-is-npm)) ready to go.  If not, you need to install it first.  If you don't already have `npm` or have an older version, you can switch using [Node Version Manager](https://github.com/creationix/nvm).

### Run a Tutorial

Now, we'll assume we're looking at `01_blog_feed` to start out with:

```bash
git clone https://github.com/steemit/devportal-tutorials-js.git
cd devportal-tutorials-js/tutorials/01_blog_feed
npm i
npm run start
open http://localhost:3000/
```

### Editor

If you need a code editor, consider [Atom](https://atom.io/).  It has plug-ins and code completion that you can enable as needed.

### Github

If you'd rather clone projects in a windowed environment rather than the terminal, consider [Github Desktop](https://desktop.github.com/).
