---
title: 'JS: Submit Comment Reply'
position: 11
description: By the end of this tutorial you should know how to post a simple comment to Steem
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Submit Comment Reply](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/11_submit_comment_reply) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of preparing and posting comment using the `broadcast.comment` operation.
Being able to post a comment is critical to most social applications built on Steem.

## Intro

We are using the `broadcast.comment` function provided by the `dsteem` library which generates, signs, and broadcasts the transaction to the network. On the Steem platform, posts and comments are all internally stored as a `comment` object, differentiated by whether or not a `parent_author` exists. When there is no `parent_author`, the it's a post, when there is, it's a comment.

## Steps

1.  [**App setup**](#app-setup) Import `dsteem` into `app.js` and prepare it to communicate with a Steem blockchain
1.  [**Choose parent post**](#choose-post) Choose a parent post on which to comment. Parse the author and permlink from it.
1.  [**Add content**](#add-content) Add `body` content to your comment
1.  [**Get comment data**](#get-comment) Collect values from the UI
1.  [**Create comment permlink**](#get-permlink) Create a permlink for your comment
1.  [**Build comment object**](#build-comment) Assemble the information into a valid comment object
1.  [**Post comment**](#post-comment) Send the new comment to the blockchain & render the result.

#### 1. App setup<a name="app-setup"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
const dsteem = require('dsteem');
let opts = {};
//connect to community testnet
opts.addressPrefix = 'STX';
opts.chainId =
    '79276aea5d4877d9a25892eaa01b0adf019d3e5cb12a97478df3298ccdd01673';
//connect to server which is connected to the network/testnet
const client = new dsteem.Client('https://testnet.steem.vc', opts);
```

Above, we have `dsteem` pointing to the test network with the proper chainId, addressPrefix, and endpoint.  
Because this tutorial modifies the blockchain, we will use a testnet and a predefined account to demonstrate comment publishing.

#### 2. Choose parent post<a name="choose-post"></a>

We need to choose a parent post and parse out the parent author and parent permlink.
Below is a url that uses an instance of condenser pointed at our testnet.

```
http://condenser.steem.vc/qbvxoy72qfc/@demo/dsf0yxlox2d
```

In this case. `dsf0yxlox2d` will be our parent permlink and `@demo` will be the the parent author.

#### 3. Add content<a name="add-content"></a>

We've added the parent post info and `Some amazing content` in our UI via the keyboard.
![comment_reply_user_input.png](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/11_submit_comment_reply/images/comment_reply_user_input.png?raw=true)

#### 4. Get Comment Data<a name="get-comment"></a>

In the `submitComment` function, (runs when "Submit comment!" is clicked)
We gather information from the UI.

```javascript
//get private key
const privateKey = dsteem.PrivateKey.fromString(
    document.getElementById('postingKey').value
);
//get account name
const account = document.getElementById('username').value;
//get body
const body = document.getElementById('body').value;
//get parent author permalink
const parent_author = document.getElementById('parent_author').value;
//get parent author permalink
const parent_permlink = document.getElementById('parent_permlink').value;
```

#### 5. Create comment permlink<a name="get-permlink"></a>

Every post needs a unique permalink.
Because comments don't typically have a title, we recommend using a random number for ours.

_Note: **Take care of your users:** Because permlinks are unique within an author's scope, we recommend random numbers for comments; or at least making it a default in your settings._

```javascript
//generate random permanent link for post
const permlink = Math.random()
    .toString(36)
    .substring(2);
```

#### 6. Build comment object<a name="build-comment"></a>

We take the information we gathered from the UI and put it into a well structured comment object.

```javascript
const comment = {
    author: account,
    title: '',
    body: body,
    parent_author: parent_author,
    parent_permlink: parent_permlink,
    permlink: permlink,
    json_metadata: '',
};
```

#### 7. Post comment<a name="post-comment"></a>

We post the comment to the blockchain and render the resulting block number if successful,
or output an error to the console if there's a failure.

```javascript
console.log('comment broadcast object', comment);
client.broadcast.comment(comment, privateKey).then(
    function(result) {
        console.log('comment broadcast result', result);
        document.getElementById(
            'postLink'
        ).innerHTML = `<br/><p>Included in block: ${
            result.block_num
        }</p><br/><br/><a href="http://condenser.steem.vc/@${parent_author}/${parent_permlink}">Check post here</a>`;
    },
    function(error) {
        console.error(error);
    }
);
```

A successful comment will output something like the following to the console:
![successful console output](https://github.com/steemit/devportal-tutorials-js/blob/master/tutorials/11_submit_comment_reply/images/comment_reply_successful_console_output.png?raw=true)

That's all there is to it.

The `broadcast` operation has more to offer than just committing a post/comment to the blockchain. It provides a mulititude of options that can accompany this commit. The max payout and percent of steem dollars can be set. When authors don't want all of the benifits from a post, they can set the payout factors to zero or beneficiaries can be set to receive part of the rewards. You can also set whether votes are allowed or not. The broadcast to the blockchain can be modified to meet the exact requirements of the author. More information on how to use the `broadcast` operation can be found on the Steem [Devportal](https://developers.steem.io/apidefinitions/#apidefinitions-broadcast-ops-comment) with a list of the available broadcast options under the specific [Appbase API](https://developers.steem.io/apidefinitions/#broadcast_ops_comment_options)

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/11_submit_comment_reply`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at http://localhost:3000/

---
