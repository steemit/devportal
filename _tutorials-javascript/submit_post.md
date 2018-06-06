---
title: Submit Post
position: 10
description: By the end of this tutorial you should know how to prepare comments for Steem and then submit using the broadcastcomment function
layout: full
right_code: |

---
# Submit Post

_By the end of this tutorial you should know how to prepare comments for Steem and then submit using the broadcast.comment function._

This tutorial will show the method of properly formatting content followed by broadcasting the information to the steem blockchain using a `demo` account on the `testnet`.

## Intro

We are using the `client.broadcast.comment` function provided by `dsteem` which generates, signs, and broadcasts the transaction to the network. On the Steem platform, posts and comments are all internally stored as a `comment` object, differentiated by whether or not a `parent_author` exists. When there is no `parent_author`, then it's a post, otherwise it's a comment.

## Steps

1.  [**App setup**](#app-setup) Configuration of `dsteem` to use the proper connection and network.
1.  [**Fetch Steem Post or Comment data**](#fetch-content) Defining information variables with the `submitpost` function.
1.  [**Format and Broadcast**](#format-broadcast) Formatting the comments and submitting to the blockchain.

#### 1. App setup<a name="app-setup"></a>

Below we have `dsteem` pointing to the test network with the proper chainId, addressPrefix, and endpoint. Because this tutorial is interactive, we will not publish test content to the main network. Instead, we're using the testnet and a predefined account to demonstrate post publishing.
There is a `public/app.js` file which holds the Javascript segment of this tutorial. In the first few lines we define the configured library and packages:

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

#### 2. Fetch Steem Post or Comment data<a name="fetch-content"></a>

Next, we have the `submitPost` function which executes when the Submit post button is clicked.

```javascript
//get private key
const privateKey = dsteem.PrivateKey.fromString(
    document.getElementById('postingKey').value
);
//get account name
const account = document.getElementById('username').value;
//get title
const title = document.getElementById('title').value;
//get body
const body = document.getElementById('body').value;
//get tags and convert to array list
const tags = document.getElementById('tags').value;
const taglist = tags.split(' ');
//make simple json metadata including only tags
const json_metadata = JSON.stringify({ tags: taglist });
//generate random permanent link for post
const permlink = Math.random()
    .toString(36)
    .substring(2);
```

The `getElementById` function is used to obtain data from the HTML elements and assign them to constants. Tags are separated by spaces in this example and stored in an array list called `taglist` for later use. However, the structure of how to enter tags depends on your needs. Posts on the blockchain can hold additional information in the `json_metadata` field, such as the `tags` list which we have assigned. Posts must also have a unique permanent link scoped to each account. In this case we are just creating a random character string.

#### 3. Format and Broadcast<a name="format-broadcast"></a>

The next step is to pass all of these elements in **2.** to the `client.broadcast.comment` function.

```javascript
//broadcast post to the testnet
client.broadcast
    .comment(
        {
            author: account,
            body: body,
            json_metadata: json_metadata,
            parent_author: '',
            parent_permlink: taglist[0],
            permlink: permlink,
            title: title,
        },
        privateKey
    )
    .then(
        function(result) {
            document.getElementById('title').value = '';
            document.getElementById('body').value = '';
            document.getElementById('tags').value = '';
            document.getElementById('postLink').style.display = 'block';
            document.getElementById(
                'postLink'
            ).innerHTML = `<br/><p>Included in block: ${
                result.block_num
            }</p><br/><br/><a href="http://condenser.steem.vc/${
                taglist[0]
            }/@${account}/${permlink}">Check post here</a>`;
        },
        function(error) {
            console.error(error);
        }
    );
```

Note that the `parent_author` and `parent_permlink` fields are used for replies (also known as comments). In this example, since we are publishing a post instead of a comment/reply, we will have to leave `parent_author` as an empty string and assign the first tag to `parent_permlink`.

After the post has been broadcast to the network, we can simply set all the fields to empty strings and show the post link to check it from a condenser instance running on the selected testnet.

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/10_submit_post`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)
