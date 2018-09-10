---
title: 'JS: Follow A User'
position: 18
description: '_Follow and unfollow a user / author._'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Follow A User](https://github.com/steemit/devportal-tutorials-js/tree/master/tutorials/18_follow_a_user) can be downloaded as part of the [JS tutorials repository](https://github.com/steemit/devportal-tutorials-js).</span>
<br>



This tutorial will take you through the process of checking the `follow status` of an author and either follow or unfollow that user depending on the current status. This is done with the `call` operation as well as the `broadcast.json` operation.

## Intro

We are using the `broadcast.json` operation provided by the `dsteem` library to follow or unfollow a selected author. There are 4 variables required to execute this operation:

1.  _follower_ - The specific user that will select the author to follow/unfollow (`username`).
1.  _privatekey_ - This is the private posting key of the user(`postingKey`).
1.  _following_ - The account/author that the user would like to follow (`author`).
1.  _what_ - The `type` of follow operation. This variable can have one of two values: `blog`, to follow an author, and a `null value`, unfollow the selected author.

A simple HTML UI is used to capture the required information, after which the broadcast operation can be compiled.

## Steps

1.  [**Configure connection**](#connection) Configuration of `dsteem` to communicate with the Steem blockchain
1.  [**Input variables**](#input) Collecting the required inputs via an HTML UI
1.  [**Get status**](#status) Get the follow status for the specified author
1.  [**Follow operation**](#follow) Execute the `follow` operation

#### 1. Configure connection<a name="connection"></a>

As usual, we have a `public/app.js` file which holds the Javascript segment of the tutorial. In the first few lines we define the configured library and packages:

```javascript
import { Client, PrivateKey } from 'dsteem';
import { Testnet as NetConfig } from '../../configuration'; //A Steem Testnet. Replace 'Testnet' with 'Mainnet' to connect to the main Steem blockchain.

let opts = { ...NetConfig.net };

//connect to a steem node, testnet in this case
const client = new Client(NetConfig.url, opts);
```

Above, we have `dsteem` pointing to the test network with the proper chainId, addressPrefix, and endpoint by importing from the `configuration.js` file. Because this tutorial is interactive, we will not publish test content to the main network. Instead, we're using the testnet and a predefined account which is imported once the application loads, to demonstrate following of an author.

```javascript
window.onload = async () => {
    const account = NetConfig.accounts[0];
    const accountI = NetConfig.accounts[1];
    document.getElementById('username').value = account.address;
    document.getElementById('postingKey').value = account.privPosting;
    document.getElementById('author').value = accountI.address;
};
```

#### 2. Input variables<a name="input"></a>

The required parameters for the follow operation is recorded via an HTML UI that can be found in the `public/index.html` file.

The parameter values are allocated as seen below once the user clicks on the "Follow / Unfollow" button.

```javascript
window.submitFollow = async () => {
    //get private key
    const privateKey = dsteem.PrivateKey.fromString(
        document.getElementById('postingKey').value
    );
    //get account name
    const follower = document.getElementById('username').value;
    //get author permalink
    const following = document.getElementById('author').value;
```

#### 3. Get status<a name="status"></a>

The current follow status for the author is called from the database and a variable is assigned in order to specify whether the follow operation should execute as `follow` or `unfollow`. For more information on this process you can refer to tutorial 19_get_follower_and_following_list.

```javascript
console.log({ follower: follower, following: following });

    let status = await client.call('follow_api', 'get_following', [
        follower,
        following,
        'blog',
        1,
    ]);

    console.log({ status: status });

    if (status.length > 0 && status[0].following == following) {
        type = '';
    } else {
        type = 'blog';
    }
```

#### 4. Follow operation<a name="follow"></a>

A JSON with the collected input variables is created in order for the `data object` within the `broadcast` operation to be completed.

```javascript
const json = JSON.stringify([
    'follow',
    {
        follower: follower,
        following: following,
        what: [type], //null value for unfollow, 'blog' for follow
    },
]);
```

The `broadcast.json` operation requires a `data object` and `private key` in order the execute. For the follow/unfollow operation the variables in the object have predefined values. These values can change depending on the type of operation.

```javascript
const data = {
    id: 'follow',
    json: json,
    required_auths: [],
    required_posting_auths: [follower],
};
```

The broadcast operation is then executed with the created object and the private posting key. We also display the follow status on the UI in order for the user to know the whether the process was a success.

```javascript
client.broadcast.json(data, privateKey).then(
    function(result) {
        console.log('user follow result: ', result);
        document.getElementById('followResultContainer').style.display = 'flex';
        document.getElementById('followResult').className =
            'form-control-plaintext alert alert-success';
        if (type == 'blog') {
            document.getElementById('followResult').innerHTML =
                'Author followed';
        } else {
            document.getElementById('followResult').innerHTML =
                'Author unfollowed';
        }
    },
    function(error) {
        console.error(error);
        document.getElementById('followResultContainer').style.display = 'flex';
        document.getElementById('followResult').className =
            'form-control-plaintext alert alert-danger';
        document.getElementById('followResult').innerHTML = error.jse_shortmsg;
    }
);
```

If either of the values for the user or author does not exist the proper error result will be displayed on the UI. The result is also displayed in the console in order for the user to confirm that a block transaction has taken place. The status of the operation can be verified on the [demo account](http://condenser.steem.vc/@cdemo/followed).

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/18_follow_user`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)

---
