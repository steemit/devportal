---
title: Edit Content Patching
position: 12
description: By the end of this tutorial you should know how to patch post edits to Steem
layout: full
right_code: |

---
# How to edit a Post

_By the end of this tutorial you should know how to patch post edits to Steem._

This tutorial will take you through the process of preparing and patching post using the `broadcast.comment` operation. Being able to patch a post is critical to save resources on Steem.

## Intro

Tutorial is demonstrating the typical process of editing content that has been previously posted on the blockchain. Instead of replacing the entire body of the post, the Steem blockchain offers an alternative strategy.
In this tutorial, we will focus on properly patching existing content and then broadcasting the patch with a `demo` account on a testnet.

We are using the `broadcast.comment` function provided by `dsteem` which generates, signs, and broadcast the transaction to the network. On the Steem platform, posts and comments are all internally stored as a `comment` object, differentiated by whether or not a `parent_author` exists. When there is no `parent_author`, it's a post, when there is, it's a comment. When editing a post, we need to make sure that we don't resubmit the same post over and over again, which will spam the network and adds additional cost to operate the platform. Instead we will use a package called `diff-match-patch`, which allows us to only apply changes and save resources on the Steem platform.

## Steps

1.  [**Configure testnet**](#configure-app) Testnet connection should be established with proper configurations
1.  [**Get latest post**](#get-post) Get @demo's latest post for editing
1.  [**Creating patch**](#create-patch) Creating patch with new edited text
1.  [**Submit a patch**](#submit-patch) Submit newly formatted post

#### 1. Configure testnet<a name="configure-app"></a>

As usual, we have a file called `public/app.js`, which holds the Javascript segment of the tutorial. In the first few lines, we have defined the configured library and packages:

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

Above, we have `dsteem` pointing to the test network with the proper chainId, addressPrefix, and endpoint. Because this tutorial is interactive, we will not publish test content to the main network. Instead, we're using testnet and a predefined account to demonstrate post patching.

#### 2. Get latest post<a name="get-post"></a>

Next, we have a `main` function which fires at on-load and fetches latest blog post of `@demo` account and fills in the form with relevant information.

```javascript
const query = { tag: 'demo', limit: '1' };
client.database
    .call('get_discussions_by_blog', [query])
    .then(result => {
        document.getElementById('title').value = result[0].title;
        document.getElementById('body').value = result[0].body;
        document.getElementById('tags').value = JSON.parse(
            result[0].json_metadata
        ).tags.join(' ');
        o_body = result[0].body;
        o_permlink = result[0].permlink;
    })
    .catch(err => {
        console.log(err);
        alert('Error occured, please reload the page');
    });
```

Notice, we are only fetching a single blog post by specifying a `limit` and we have filled all necessary fields/variables with the old content.

#### 3. Creating patch<a name="create-patch"></a>

We have created a small function called `createPatch` to patch edits to the old content.

```javascript
function createPatch(text, out) {
    if (!text && text === '') return undefined;
    //get list of patches to turn text to out
    const patch_make = dmp.patch_make(text, out);
    //turns patch to text
    const patch = dmp.patch_toText(patch_make);
    return patch;
}
```

The `createPatch` function computes a list of patches to turn old content to edited content.

#### 4. Submit a patch<a name="submit-patch"></a>

Next, we have the `submitPost` function, which executes when the Submit button is clicked.

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
const edited_body = document.getElementById('body').value;

let body = '';

//computes a list of patches to turn o_body to edited_body
const patch = createPatch(o_body, edited_body);

//check if patch size is smaller than original content
if (patch && patch.length < new Buffer(o_body, 'utf-8').length) {
    body = patch;
} else {
    body = o_body;
}

//get tags and convert to array list
const tags = document.getElementById('tags').value;
const taglist = tags.split(' ');
//make simple json metadata including only tags
const json_metadata = JSON.stringify({ tags: taglist });
//generate random permanent link for post
const permlink = o_permlink;

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

As you can see from the above function, we get the relevant values from the defined fields. Tags are separated by spaces in this example, but the structure of how to enter tags totally depends on your needs. We have separated tags with whitespaces and stored them in an array list called `taglist`, for later use. Posts on the blockchain can hold additional information in the `json_metadata` field, such as the `tags` list which we have assigned. Posts must also have a unique permanent link scoped to each account. In this case we are just creating a random character string.

In the follow code, we patch the old content with new (or edited) content and make sure that the patch size is smaller than original content, otherwise patching is unnecessary.

```javascript
//computes a list of patches to turn o_body to edited_body
const patch = createPatch(o_body, edited_body);

//check if patch size is smaller than original content
if (patch && patch.length < new Buffer(o_body, 'utf-8').length) {
    body = patch;
} else {
    body = o_body;
}
```

The next step is to pass all of these parameters to the `client.broadcast.comment` function. Note that in parameters you can see the `parent_author` and `parent_permlink` fields, which are used for replies (also known as comments). In our example, since we are publishing a post instead of a comment/reply, we will have to leave `parent_author` as an empty string and assign `parent_permlink` from the first tag.

After the post has been broadcasted to the network, we can simply set all the fields to empty strings and show the post link to check it from a condenser instance running on the selected testnet. That's it!

### To Run the tutorial

1.  clone this repo
1.  `cd tutorials/12_edit_content_patching`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)
