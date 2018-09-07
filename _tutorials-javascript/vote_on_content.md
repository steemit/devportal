---
title: 'JS: Vote On Content'
position: 17
description: '_Create a weighted up or down vote on a comment/post._'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Vote On Content](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/17_vote_on_content) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of preparing and submitting a `vote` using the `broadcast` operation.
Because this tutorial essentially produces spam, it will be pointed at a Steem testnet. The testnet is an open resource,
so the default account and posting key in this tutorial may have been changed by another developer learning the ropes.
If that happens, you'll want to create a new account on the testnet and use that account's credentials instead.

To learn more about the testnet, including an easy way to create a play account, visit https://testnet.steem.vc/

## Intro

We are using the `broadcast.vote` function provided by the `dsteem` library to send the transaction through to the
network. On the Steem platform, posts and comments are all internally stored as a `comment` object, differentiated by
whether or not a `parent_author` exists. When there is no `parent_author`, then it's a post, when there is, it's a
comment. Voting is done on either of the two based on the author and permlink of the comment. There are 5 parameters
required for the voting operation:

1.  _Username_ - The username of the account making the vote (the voter)
1.  _Privatekey_ - This is the private posting key of the voter
1.  _Author_ - The author of the comment/post that the voter is voting on
1.  _Permlink_ - The unique identifier of the comment/post of the author
1.  _Weight_ - This is the weight that the vote will carry. The value ranges from -10000 (100% flag) to 10000 (100% upvote)

Due to the low amount of posts on the testnet we added an additional step to create a post before we vote on it. The values are auto loaded in the respective input boxes. A full tutorial on how to create a new post can be found on the [Steem Devportal](https://developers.steem.io/tutorials-javascript/submit_post)

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with a Steem blockchain
1.  [**Create new post**](#createpost) Creating a new post on the testnet
1.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
1.  [**Broadcast**](#broadcast) Creating an object and broadcasting the vote to the blockchain

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
import { Client, PrivateKey } from 'dsteem';
import { Testnet as NetConfig } from '../../configuration'; //A Steem Testnet. Replace 'Testnet' with 'Mainnet' to connect to the main Steem blockchain.

let opts = { ...NetConfig.net };

//connect to a steem node, testnet in this case
const client = new Client(NetConfig.url, opts);
```

Above, we have `dsteem` pointing to the test network with the proper chainId, addressPrefix, and endpoint by importing from the `configuration.js` file. Because this tutorial is interactive, we will not publish test content to the main network. Instead, we're using the testnet and a predefined account which is imported once the application loads, to demonstrate voting on content.

```javascript
window.onload = () => {
    const account = NetConfig.accounts[0];
    document.getElementById('username').value = account.address;
    document.getElementById('postingKey').value = account.privPosting;
};
```

#### 2. Create new post<a name="createpost"></a>

A new blog post is created on the testnet with the necessary variables for the vote function being allocated as well. If a post is successfully created it will display a block number and a value will be assigned to the `permlink` variable.

```javascript
//refer to "10_submit_post" in the tutorials folder for creating a post on steemit
//create post function
window.createPost = async () => {
    //get private key
    const privateKey = createPrivateKey();
    //get account name
    const account = document.getElementById('username').value;
    //for content
    const time = new Date().getTime();
    //get title
    const title = `developers.steem.io - JS-T:17 ${time}`;
    //get body
    const body = `Go to [developers.steem.io](https://developers.steem.io) for the latest in Steem tutorials! This post was created by someone using the active version of those tutorials at  [https://github.com/steemit/devportal-tutorials-js](https://github.com/steemit/devportal-tutorials-js)
        
        ${time}`;
    //get tags and convert to array list
    const tags = 'blog';
    const taglist = tags.split(' ');
    //make simple json metadata including only tags
    const json_metadata = JSON.stringify({ tags: taglist });
    //generate random permanent link for post
    const permlink = Math.random()
        .toString(36)
        .substring(2);

    client.broadcast
        .comment(
            {
                author: account,
                body: body,
                json_metadata: json_metadata,
                parent_author: '',
                parent_permlink: tags,
                permlink: permlink,
                title: title,
            },
            privateKey
        )
        .then(
            function(result) {
                document.getElementById('permlink').innerHTML = permlink;
                document.getElementById(
                    'postLink'
                ).innerHTML = `Included in block: <a href="http://condenser.steem.vc/${
                    taglist[0]
                }/@${account}/${permlink}" target="_blank">${
                    result.block_num
                }</a>`;
                document.getElementById('postResult').style.display = 'flex';
                document.getElementById('permlink').value = permlink;
            },
            function(error) {
                console.error(error);
            }
        );
};
```

You may have noted the mystery function `createPrivateKey()`. It's a convenience function that allows us to give the
user some meaningful UI feedback if they put in a bad posting key. The important part of it is
`return dsteem.PrivateKey.fromString(<somestring>)` but its full glory can be seen in the snippet below

```javascript
const createPrivateKey = function() {
    try {
        return dsteem.PrivateKey.fromString(
            document.getElementById('postingKey').value
        );
    } catch (e) {
        const resultEl = document.getElementById('result');
        resultEl.className = 'form-control-plaintext alert alert-danger';
        resultEl.innerHTML = e.message + ' - See console for full error.';
        throw e;
    }
};
```

#### 3. Input variables<a name="input"></a>

The required parameters for the vote operation is recorded via an HTML UI that can be found in the `public/index.html` file. The values are pre-populated in this case with a testnet `demo` account. The vote weight is input via a slider as this value can range between -10000 and 10000 denoting either a 100% flag or 100% upvote.

The parameter values are allocated as seen below, once the user clicks on the "Submit" button.

```javascript
window.submitVote = async () => {
    //we'll make use of resultEl in multiple child scopes. This is generally good practice.
    const resultEl = document.getElementById('result');
    resultEl.innerHTML = 'pending...';

    //get all values from the UI//
    //get account name of voter
    const voter = document.getElementById('username').value;
    //get private posting key
    const privateKey = createPrivateKey();
    //get author of post/comment to vote
    const author = document.getElementById('author').value;
    //get post permalink to vote
    const permlink = document.getElementById('permlink').value;
    //get weight of vote
    const weight = parseInt(
        document.getElementById('currentWeight').innerHTML,
        10
    );
    ....
```

The `weight` parameter is required to be an interger for the vote operation so we parse it from the UI text field. The `permlink` value is retrieved from the `create post` function.

#### 4. Broadcast<a name="broadcast"></a>

We create a `vote object` with the input variables before we can broadcast to the blockchain.

```javascript
const vote = {
    voter,
    author,
    permlink,
    weight, //needs to be an integer for the vote function
};
```

After which we can complete the `broadcast.vote` operation with the created object and private posting key received from the input UI. The result of the vote is displayed on the UI to confirm whether it was a `success` or `failed` with details of that process being displayed on the console.

```javascript
client.broadcast.vote(vote, privateKey).then(
        function(result) {
            console.log('success:', result);
            resultEl.className = 'form-control-plaintext alert alert-success';
            resultEl.innerHTML = 'Success! See console for full response.';
        },
        function(error) {
            console.log('error:', error);
            resultEl.className = 'form-control-plaintext alert alert-danger';
            resultEl.innerHTML =
                error.jse_shortmsg + ' - See console for full response.';
        }
    );

window.onload = () => {
    var voteWeightSlider = document.getElementById('voteWeight');
    var currentWeightDiv = document.getElementById('currentWeight');
    currentWeightDiv.innerHTML = voteWeightSlider.value;
    voteWeightSlider.oninput = function() {
        currentWeightDiv.innerHTML = this.value;
    };
```

More information on how to use the `broadcast` operation and options surrounding the operation can be found on the [Steem Devportal](https://developers.steem.io/apidefinitions/#broadcast_ops_vote)

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/17_vote_on_content`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)

---
